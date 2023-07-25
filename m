Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B4761244
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjGYLAm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjGYLAY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720013C3C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636E861602
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D2CC433C8;
        Tue, 25 Jul 2023 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282655;
        bh=n1RCNObgOrF2nrFyzn6ThQ68JX1HC6n83D6Nb8EP1aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgShz3ToHhRUXuEUTP9d2JWFzPhHSETpmNL8tY9GOz7Tf2cGv59A9K9pj0G9cVEfo
         FKY/vYwxg3a1viH4raOyMYLViYNOacUl96dXFPnz+0XEqKCGAqX6VaSHcxcm3MWGug
         W+7GAuUqJ3z6tyH0X2Iw1vI7L/viq610CkvmtwHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 208/227] tcp: annotate data-races around tp->tsoffset
Date:   Tue, 25 Jul 2023 12:46:15 +0200
Message-ID: <20230725104523.374223312@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit dd23c9f1e8d5c1d2e3d29393412385ccb9c7a948 ]

do_tcp_getsockopt() reads tp->tsoffset while another cpu
might change its value.

Fixes: 93be6ce0e91b ("tcp: set and get per-socket timestamp")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230719212857.3943972-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c      | 4 ++--
 net/ipv4/tcp_ipv4.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c0e0add372f75..15b1191411ec3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3765,7 +3765,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (!tp->repair)
 			err = -EPERM;
 		else
-			tp->tsoffset = val - tcp_time_stamp_raw();
+			WRITE_ONCE(tp->tsoffset, val - tcp_time_stamp_raw());
 		break;
 	case TCP_REPAIR_WINDOW:
 		err = tcp_repair_set_window(tp, optval, optlen);
@@ -4267,7 +4267,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TIMESTAMP:
-		val = tcp_time_stamp_raw() + tp->tsoffset;
+		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
 		val = tp->notsent_lowat;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5d3e49ceb6917..f37d13ee7b4cc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -307,8 +307,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 						  inet->inet_daddr,
 						  inet->inet_sport,
 						  usin->sin_port));
-		tp->tsoffset = secure_tcp_ts_off(net, inet->inet_saddr,
-						 inet->inet_daddr);
+		WRITE_ONCE(tp->tsoffset,
+			   secure_tcp_ts_off(net, inet->inet_saddr,
+					     inet->inet_daddr));
 	}
 
 	inet->inet_id = get_random_u16();
-- 
2.39.2



