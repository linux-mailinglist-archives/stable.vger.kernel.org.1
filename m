Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4827B74C29E
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjGILWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjGILWl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29E13D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D00160BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FACCC433C7;
        Sun,  9 Jul 2023 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901759;
        bh=LsmTnX2IO0UlYazZ9MIROmT1UhQkF5rdKlPv7+d6LmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtNgWWnqcYJM0a7mBd7zMng+TJkJF39x+hvQSHcNPOhD5Jcsa44Ry02h7bvDkBJNa
         rHzodYqq2nCOcBrPkb40YKS4vYEp1qWuAZrYee3dql4hYgMUgL+A09CmggdR4yO3kO
         8jVhtVG/Ajci/DhQQ3gjQ6r3UMdfPetpCtprpHfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gilad Sever <gilad9366@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 135/431] bpf: Factor out socket lookup functions for the TC hookpoint.
Date:   Sun,  9 Jul 2023 13:11:23 +0200
Message-ID: <20230709111454.327797456@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gilad Sever <gilad9366@gmail.com>

[ Upstream commit 6e98730bc0b44acaf86eccc75f823128aa9c9e79 ]

Change BPF helper socket lookup functions to use TC specific variants:
bpf_tc_sk_lookup_tcp() / bpf_tc_sk_lookup_udp() / bpf_tc_skc_lookup_tcp()
instead of sharing implementation with the cg / sk_skb hooking points.
This allows introducing a separate logic for the TC flow.

The tc functions are identical to the original code.

Signed-off-by: Gilad Sever <gilad9366@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230621104211.301902-2-gilad9366@gmail.com
Stable-dep-of: 9a5cb79762e0 ("bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1d6f165923bff..5910956f4e0db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6701,6 +6701,63 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_skc_lookup(skb, tuple, len, IPPROTO_TCP,
+					     netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
+	.func		= bpf_tc_skc_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP,
+					    netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
+	.func		= bpf_tc_sk_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP,
+					    netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
+	.func		= bpf_tc_sk_lookup_udp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
 	if (sk && sk_is_refcounted(sk))
@@ -7954,9 +8011,9 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
-		return &bpf_sk_lookup_tcp_proto;
+		return &bpf_tc_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_lookup_udp:
-		return &bpf_sk_lookup_udp_proto;
+		return &bpf_tc_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_tcp_sock:
@@ -7964,7 +8021,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skc_lookup_tcp:
-		return &bpf_skc_lookup_tcp_proto;
+		return &bpf_tc_skc_lookup_tcp_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
-- 
2.39.2



