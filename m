Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22DD703319
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbjEOQdN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242732AbjEOQdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D8D30E7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7221B62526
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC0C4339C;
        Mon, 15 May 2023 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168384;
        bh=Gfho95/6K/uX3oq47MASCSU2N5nvK8dGz+S4g0TJR08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8os+phwYP80/CI57p7vXu5thgrPyyPPXaU2dHzR9XGmUuG4vb9ed9VEAgfHA/n46
         XygCp00jTJpAgN8sFUDtQSzXT3fTLVmOZ3hFuiuudOO54hz/KZe78sXdWLdJevzyCG
         5xLANR/g91QVHYz/76gEIj1KCDqlM89wODaPWwHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 033/116] net/packet: convert po->auxdata to an atomic flag
Date:   Mon, 15 May 2023 18:25:30 +0200
Message-Id: <20230515161659.365914465@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fd53c297aa7b077ae98a3d3d2d3aa278a1686ba6 ]

po->auxdata can be read while another thread
is changing its value, potentially raising KCSAN splat.

Convert it to PACKET_SOCK_AUXDATA flag.

Fixes: 8dc419447415 ("[PACKET]: Add optional checksum computation for recvmsg")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 8 +++-----
 net/packet/diag.c      | 2 +-
 net/packet/internal.h  | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ce6afdb50933b..8b44ad304a656 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3480,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
-	if (pkt_sk(sk)->auxdata) {
+	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
 
 		aux.tp_status = TP_STATUS_USER;
@@ -3865,9 +3865,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->auxdata = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -4009,7 +4007,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 	case PACKET_AUXDATA:
-		val = po->auxdata;
+		val = packet_sock_flag(po, PACKET_SOCK_AUXDATA);
 		break;
 	case PACKET_ORIGDEV:
 		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
diff --git a/net/packet/diag.c b/net/packet/diag.c
index bf5928e5df035..d9f912ad23dfa 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -22,7 +22,7 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 	pinfo.pdi_flags = 0;
 	if (po->running)
 		pinfo.pdi_flags |= PDI_RUNNING;
-	if (po->auxdata)
+	if (packet_sock_flag(po, PACKET_SOCK_AUXDATA))
 		pinfo.pdi_flags |= PDI_AUXDATA;
 	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f39dcc7608bc6..3d871cae85b8c 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -117,8 +117,7 @@ struct packet_sock {
 	struct mutex		pg_vec_lock;
 	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
-	unsigned int		auxdata:1,	/* writer must hold sock lock */
-				has_vnet_hdr:1,
+	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
 				tp_loss:1,
 				tp_tx_has_off:1;
 	int			pressure;
@@ -144,6 +143,7 @@ static struct packet_sock *pkt_sk(struct sock *sk)
 
 enum packet_sock_flags {
 	PACKET_SOCK_ORIGDEV,
+	PACKET_SOCK_AUXDATA,
 };
 
 static inline void packet_sock_flag_set(struct packet_sock *po,
-- 
2.39.2



