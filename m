Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E307615DE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGYLd6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjGYLd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A6F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C4B616A2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2F9C433C8;
        Tue, 25 Jul 2023 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284835;
        bh=S5PJq/3opapiyInYdpZsDqrkTu+g+hiGYs6Myultx0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAvFEV65qs4kPLt9CWxh6y5/uwLu1ur3/c3X6QQKBjBTjJzsEnRntD/9xPMi7z21t
         QZq4eCi+cFofs5JYgle0Yw1WaGFfPwfW68BevDjSNRx4sOyuXtI0KBBo8szU/UbZbC
         HSj0e9MA02G6gg5bBnURUgBPE8EdFsyPnded0Gks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 497/509] net: Introduce net.ipv4.tcp_migrate_req.
Date:   Tue, 25 Jul 2023 12:47:16 +0200
Message-ID: <20230725104616.511492572@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.co.jp>

[ Upstream commit f9ac779f881c2ec3d1cdcd7fa9d4f9442bf60e80 ]

This commit adds a new sysctl option: net.ipv4.tcp_migrate_req. If this
option is enabled or eBPF program is attached, we will be able to migrate
child sockets from a listener to another in the same reuseport group after
close() or shutdown() syscalls.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Benjamin Herrenschmidt <benh@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20210612123224.12525-2-kuniyu@amazon.co.jp
Stable-dep-of: 3a037f0f3c4b ("tcp: annotate data-races around icsk->icsk_syn_retries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 25 +++++++++++++++++++++++++
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index df26cf4110ef5..252212998378e 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -713,6 +713,31 @@ tcp_syncookies - INTEGER
 	network connections you can set this knob to 2 to enable
 	unconditionally generation of syncookies.
 
+tcp_migrate_req - BOOLEAN
+	The incoming connection is tied to a specific listening socket when
+	the initial SYN packet is received during the three-way handshake.
+	When a listener is closed, in-flight request sockets during the
+	handshake and established sockets in the accept queue are aborted.
+
+	If the listener has SO_REUSEPORT enabled, other listeners on the
+	same port should have been able to accept such connections. This
+	option makes it possible to migrate such child sockets to another
+	listener after close() or shutdown().
+
+	The BPF_SK_REUSEPORT_SELECT_OR_MIGRATE type of eBPF program should
+	usually be used to define the policy to pick an alive listener.
+	Otherwise, the kernel will randomly pick an alive listener only if
+	this option is enabled.
+
+	Note that migration between listeners with different settings may
+	crash applications. Let's say migration happens from listener A to
+	B, and only B has TCP_SAVE_SYN enabled. B cannot read SYN data from
+	the requests migrated from A. To avoid such a situation, cancel
+	migration by returning SK_DROP in the type of eBPF program, or
+	disable this option.
+
+	Default: 0
+
 tcp_fastopen - INTEGER
 	Enable TCP Fast Open (RFC7413) to send and accept data in the opening
 	SYN packet.
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4a4a5270ff6f2..9b0d8649ae5b8 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -131,6 +131,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_syn_retries;
 	u8 sysctl_tcp_synack_retries;
 	u8 sysctl_tcp_syncookies;
+	u8 sysctl_tcp_migrate_req;
 	int sysctl_tcp_reordering;
 	u8 sysctl_tcp_retries1;
 	u8 sysctl_tcp_retries2;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5aa8bde3e9c8e..59ba518a85b9c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -878,6 +878,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 	},
 #endif
+	{
+		.procname	= "tcp_migrate_req",
+		.data		= &init_net.ipv4.sysctl_tcp_migrate_req,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
 	{
 		.procname	= "tcp_reordering",
 		.data		= &init_net.ipv4.sysctl_tcp_reordering,
-- 
2.39.2



