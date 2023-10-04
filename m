Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34D7B875D
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbjJDSE2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjJDSE2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF983CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0976C433C9;
        Wed,  4 Oct 2023 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442664;
        bh=Ngzetgr+I0FOLurUn/JV84oMGctTy/HCgAp1C5Cjm6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDEpxg5ifk50OoGhhrLy5s159rxw4xhYCyaf92z4v++zWAybRXIApVrjbT8IP7zzP
         epat5nl3r2OP/D+88SAVIKAXKQIokeFIvhc5X5/lSMEE5IB4G/u1BhlD+DCwnu+wod
         nTVz7wXE99XlGooFTw+I3Y5h1wEdr4x5gq7D+bjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 037/183] selftests: tls: swap the TX and RX sockets in some tests
Date:   Wed,  4 Oct 2023 19:54:28 +0200
Message-ID: <20231004175205.495908788@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit c326ca98446e0ae4fee43a40acf79412b74cfedb ]

tls.sendmsg_large and tls.sendmsg_multiple are trying to send through
the self->cfd socket (only configured with TLS_RX) and to receive through
the self->fd socket (only configured with TLS_TX), so they're not using
kTLS at all. Swap the sockets.

Fixes: 7f657d5bf507 ("selftests: tls: add selftests for TLS sockets")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/tls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 97fceb9be9ed3..3bdb093731358 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -441,11 +441,11 @@ TEST_F(tls, sendmsg_large)
 
 		msg.msg_iov = &vec;
 		msg.msg_iovlen = 1;
-		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
+		EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
 	}
 
 	while (recvs++ < sends) {
-		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+		EXPECT_NE(recv(self->cfd, mem, send_len, 0), -1);
 	}
 
 	free(mem);
@@ -474,9 +474,9 @@ TEST_F(tls, sendmsg_multiple)
 	msg.msg_iov = vec;
 	msg.msg_iovlen = iov_len;
 
-	EXPECT_EQ(sendmsg(self->cfd, &msg, 0), total_len);
+	EXPECT_EQ(sendmsg(self->fd, &msg, 0), total_len);
 	buf = malloc(total_len);
-	EXPECT_NE(recv(self->fd, buf, total_len, 0), -1);
+	EXPECT_NE(recv(self->cfd, buf, total_len, 0), -1);
 	for (i = 0; i < iov_len; i++) {
 		EXPECT_EQ(memcmp(test_strs[i], buf + len_cmp,
 				 strlen(test_strs[i])),
-- 
2.40.1



