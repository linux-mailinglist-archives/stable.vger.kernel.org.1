Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1773D7D3379
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJWLak (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjJWLak (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:30:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB7A4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:30:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80DEC433C9;
        Mon, 23 Oct 2023 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060638;
        bh=tp9LJLKXtfM3nX0RtCwckc7eBuLj4Z8V3jxQpRV4swU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09WkrHcRzHu5DLtGahg/RfzmrKO2tCQhtg9eY0GBUZN2mNnDLn01VygWX96eQI5kX
         1E3j9RF5nhv8hLt4WZ2QGT3w/dvkIvWzkb6z1c1RtcdDoNERmmS7//NkmTEhCTihym
         SvhoWkutGNprYAPtOs/+hxyX7q2eBSdLBhdx5cbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sili Luo <rootlab@huawei.com>,
        Eric Dumazet <edumazet@google.com>, Willy Tarreau <w@1wt.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/123] net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()
Date:   Mon, 23 Oct 2023 12:56:14 +0200
Message-ID: <20231023104818.290045550@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 31c07dffafce914c1d1543c135382a11ff058d93 ]

Sili Luo reported a race in nfc_llcp_sock_get(), leading to UAF.

Getting a reference on the socket found in a lookup while
holding a lock should happen before releasing the lock.

nfc_llcp_sock_get_sn() has a similar problem.

Finally nfc_llcp_recv_snl() needs to make sure the socket
found by nfc_llcp_sock_from_sn() does not disappear.

Fixes: 8f50020ed9b8 ("NFC: LLCP late binding")
Reported-by: Sili Luo <rootlab@huawei.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willy Tarreau <w@1wt.eu>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231009123110.3735515-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_core.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index b1107570eaee8..92f70686bee0a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -205,17 +205,13 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
 
 		if (tmp_sock->ssap == ssap && tmp_sock->dsap == dsap) {
 			llcp_sock = tmp_sock;
+			sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
 
 	read_unlock(&local->sockets.lock);
 
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
 	return llcp_sock;
 }
 
@@ -348,7 +344,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    const u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len,
+					    bool needref)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -384,6 +381,8 @@ struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
 
 		if (memcmp(sn, tmp_sock->service_name, sn_len) == 0) {
 			llcp_sock = tmp_sock;
+			if (needref)
+				sock_hold(&llcp_sock->sk);
 			break;
 		}
 	}
@@ -425,7 +424,8 @@ u8 nfc_llcp_get_sdp_ssap(struct nfc_llcp_local *local,
 		 * to this service name.
 		 */
 		if (nfc_llcp_sock_from_sn(local, sock->service_name,
-					  sock->service_name_len) != NULL) {
+					  sock->service_name_len,
+					  false) != NULL) {
 			mutex_unlock(&local->sdp_lock);
 
 			return LLCP_SAP_MAX;
@@ -833,16 +833,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 						  const u8 *sn, size_t sn_len)
 {
-	struct nfc_llcp_sock *llcp_sock;
-
-	llcp_sock = nfc_llcp_sock_from_sn(local, sn, sn_len);
-
-	if (llcp_sock == NULL)
-		return NULL;
-
-	sock_hold(&llcp_sock->sk);
-
-	return llcp_sock;
+	return nfc_llcp_sock_from_sn(local, sn, sn_len, true);
 }
 
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
@@ -1307,7 +1298,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			}
 
 			llcp_sock = nfc_llcp_sock_from_sn(local, service_name,
-							  service_name_len);
+							  service_name_len,
+							  true);
 			if (!llcp_sock) {
 				sap = 0;
 				goto add_snl;
@@ -1327,6 +1319,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 				if (sap == LLCP_SAP_MAX) {
 					sap = 0;
+					nfc_llcp_sock_put(llcp_sock);
 					goto add_snl;
 				}
 
@@ -1344,6 +1337,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 			pr_debug("%p %d\n", llcp_sock, sap);
 
+			nfc_llcp_sock_put(llcp_sock);
 add_snl:
 			sdp = nfc_llcp_build_sdres_tlv(tid, sap);
 			if (sdp == NULL)
-- 
2.40.1



