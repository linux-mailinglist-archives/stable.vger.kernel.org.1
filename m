Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8272C0C6
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjFLKyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjFLKyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21E1FCA
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B532A60F87
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA660C433D2;
        Mon, 12 Jun 2023 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566385;
        bh=Jez9EAf0n1mazDMejW9MjaAsIhlRmXis+UCGgjKUE+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/ydrWTaXyh+7kSx9wfwK9rpoPE1JUuWUnz4a4bdCEUiTgNAU1rr7xZO42CDl2lLr
         qJaQIFF1UYjt22UVdJB6htY28UYjXh0yJZ+xXQH3vnARNRimAKA1fUGjC3/fqDg4ol
         bB1KeU7pWAxBlgu2imh6spd8+zzDjXdxCszsp/oA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/132] net/ipv4: ping_group_range: allow GID from 2147483648 to 4294967294
Date:   Mon, 12 Jun 2023 12:25:46 +0200
Message-ID: <20230612101710.846425281@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Akihiro Suda <suda.gitsendemail@gmail.com>

[ Upstream commit e209fee4118fe9a449d4d805361eb2de6796be39 ]

With this commit, all the GIDs ("0 4294967294") can be written to the
"net.ipv4.ping_group_range" sysctl.

Note that 4294967295 (0xffffffff) is an invalid GID (see gid_valid() in
include/linux/uidgid.h), and an attempt to register this number will cause
-EINVAL.

Prior to this commit, only up to GID 2147483647 could be covered.
Documentation/networking/ip-sysctl.rst had "0 4294967295" as an example
value, but this example was wrong and causing -EINVAL.

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Co-developed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 4 ++--
 include/net/ping.h                     | 6 +-----
 net/ipv4/sysctl_net_ipv4.c             | 8 ++++----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4ecb549fd052e..3301288a7c692 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1247,8 +1247,8 @@ ping_group_range - 2 INTEGERS
 	Restrict ICMP_PROTO datagram sockets to users in the group range.
 	The default is "1 0", meaning, that nobody (not even root) may
 	create ping sockets.  Setting it to "100 100" would grant permissions
-	to the single group. "0 4294967295" would enable it for the world, "100
-	4294967295" would enable it for the users, but not daemons.
+	to the single group. "0 4294967294" would enable it for the world, "100
+	4294967294" would enable it for the users, but not daemons.
 
 tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
diff --git a/include/net/ping.h b/include/net/ping.h
index 9233ad3de0ade..bc7779262e603 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -16,11 +16,7 @@
 #define PING_HTABLE_SIZE 	64
 #define PING_HTABLE_MASK 	(PING_HTABLE_SIZE-1)
 
-/*
- * gid_t is either uint or ushort.  We want to pass it to
- * proc_dointvec_minmax(), so it must not be larger than MAX_INT
- */
-#define GID_T_MAX (((gid_t)~0U) >> 1)
+#define GID_T_MAX (((gid_t)~0U) - 1)
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 struct pingv6_ops {
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 39dbeb6071965..f68762ce4d8a3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -34,8 +34,8 @@ static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int ip_ping_group_range_min[] = { 0, 0 };
-static int ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
+static unsigned long ip_ping_group_range_min[] = { 0, 0 };
+static unsigned long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
 static int one_day_secs = 24 * 3600;
 static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
@@ -162,7 +162,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int ret;
-	gid_t urange[2];
+	unsigned long urange[2];
 	kgid_t low, high;
 	struct ctl_table tmp = {
 		.data = &urange,
@@ -175,7 +175,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	inet_get_ping_group_range_table(table, &low, &high);
 	urange[0] = from_kgid_munged(user_ns, low);
 	urange[1] = from_kgid_munged(user_ns, high);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	ret = proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
 
 	if (write && ret == 0) {
 		low = make_kgid(user_ns, urange[0]);
-- 
2.39.2



