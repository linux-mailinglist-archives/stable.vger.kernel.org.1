Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0863E775A96
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjHILJn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjHILJm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DD1FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC0863118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38518C433C8;
        Wed,  9 Aug 2023 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579380;
        bh=Cn3kESZGYOk/T94iCGLxH/uEkKoHjTeOWvty7oRO/mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6BzMF3yuTXI8c99XDjjTsbfi1q67A8Lee7Y1ChpUif772VZmfLmOUrrg19FL//Mj
         EBZ0DRrqtbuyPnz/lbMe/pMk7nrxbBRHakicA6jjehAozpvNThy+CiFCFoJIBSqzru
         9GUqjJCHIiN/jdFuCD4D5m1xmPJUv0FoVoQKf94M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 144/204] tcp: annotate data-races around rskq_defer_accept
Date:   Wed,  9 Aug 2023 12:41:22 +0200
Message-ID: <20230809103647.405649906@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ae488c74422fb1dcd807c0201804b3b5e8a322a3 ]

do_tcp_getsockopt() reads rskq_defer_accept while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c93aa6542d43b..98811b5f2451a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2729,9 +2729,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -3067,8 +3067,9 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 			val = (val ? : net->ipv4.sysctl_tcp_fin_timeout) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
-- 
2.39.2



