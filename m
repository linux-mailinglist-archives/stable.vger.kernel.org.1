Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40D775BC5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjHILUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHILUy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:20:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA555ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 509A1631DF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E58AC433C8;
        Wed,  9 Aug 2023 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580052;
        bh=TnAYbfVoSZrUMPy8eAlpWCJVB8r01TL2fjoRLO6Wc78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtumMOcV/YHdM6ANO7IgOsId9XqW1zGfb3Y7LEDpQ+U6qw+YHBpCdn76/BfA5Lynb
         x69XBSae3z6UvVLTQ217thnc8wRSsfEc7dfuKJx6lWLSDnySicd/AzpSwxgN46VIJf
         +BlVGcoMDliRXik+VQdFtFl6AuxmBDlhS+l7YW/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Cambda Zhu <cambda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 211/323] net: Replace the limit of TCP_LINGER2 with TCP_FIN_TIMEOUT_MAX
Date:   Wed,  9 Aug 2023 12:40:49 +0200
Message-ID: <20230809103707.791899223@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cambda Zhu <cambda@linux.alibaba.com>

[ Upstream commit f0628c524fd188c3f9418e12478dfdfadacba815 ]

This patch changes the behavior of TCP_LINGER2 about its limit. The
sysctl_tcp_fin_timeout used to be the limit of TCP_LINGER2 but now it's
only the default value. A new macro named TCP_FIN_TIMEOUT_MAX is added
as the limit of TCP_LINGER2, which is 2 minutes.

Since TCP_LINGER2 used sysctl_tcp_fin_timeout as the default value
and the limit in the past, the system administrator cannot set the
default value for most of sockets and let some sockets have a greater
timeout. It might be a mistake that let the sysctl to be the limit of
the TCP_LINGER2. Maybe we can add a new sysctl to set the max of
TCP_LINGER2, but FIN-WAIT-2 timeout is usually no need to be too long
and 2 minutes are legal considering TCP specs.

Changes in v3:
- Remove the new socket option and change the TCP_LINGER2 behavior so
  that the timeout can be set to value between sysctl_tcp_fin_timeout
  and 2 minutes.

Changes in v2:
- Add int overflow check for the new socket option.

Changes in v1:
- Add a new socket option to set timeout greater than
  sysctl_tcp_fin_timeout.

Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9df5335ca974 ("tcp: annotate data-races around tp->linger2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 1 +
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 81300a04b5808..22cca858f2678 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -128,6 +128,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 				  * to combine FIN-WAIT-2 timeout with
 				  * TIME-WAIT timer.
 				  */
+#define TCP_FIN_TIMEOUT_MAX (120 * HZ) /* max TCP_LINGER2 value (two minutes) */
 
 #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
 #if HZ >= 100
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cb96775fc86f6..9f3cdcbbb7590 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3001,8 +3001,8 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 	case TCP_LINGER2:
 		if (val < 0)
 			tp->linger2 = -1;
-		else if (val > net->ipv4.sysctl_tcp_fin_timeout / HZ)
-			tp->linger2 = 0;
+		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
+			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
 		else
 			tp->linger2 = val * HZ;
 		break;
-- 
2.39.2



