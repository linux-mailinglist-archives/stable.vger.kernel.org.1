Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA13775BC6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjHILU5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjHILU4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:20:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6A1BFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12930631E1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E481C433C8;
        Wed,  9 Aug 2023 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580055;
        bh=q4Z7s2QYT6XHIW8+sih7dykltDnnCwI5m4UK0TfmINQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUG0K3+wlvhOeYFUPrIJA/lsVROku1MCCYUA+3Km7977APfW0fpG/HSm9u2hwbuTN
         2IwW8M8cH3RkgWKihPMtVxhSB+GOmPix0sMaNytcH1LA4WZEJw0yLlaD46C80bslqy
         OoevAlA8LKs32oDd+Zc5MivUzWqlN0Taq4wwhxvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 212/323] tcp: annotate data-races around tp->linger2
Date:   Wed,  9 Aug 2023 12:40:50 +0200
Message-ID: <20230809103707.832332000@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9df5335ca974e688389c875546e5819778a80d59 ]

do_tcp_getsockopt() reads tp->linger2 while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9f3cdcbbb7590..4711963413a49 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3000,11 +3000,11 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
@@ -3401,7 +3401,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_syn_retries;
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
-- 
2.39.2



