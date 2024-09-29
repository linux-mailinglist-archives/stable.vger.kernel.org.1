Return-Path: <stable+bounces-78222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935498965C
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D959B1F22768
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE1D17C22E;
	Sun, 29 Sep 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCMW9hqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B017BB25
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629350; cv=none; b=mEd+ZqbBoFkPMZUjqnammmb3mpR5o84GziiOqj/4uZKJ+iEs4Wz5/YNvH3acVnPWl5cgKAgVXz9vSEm75QhVQYC7ApSbwRXa2Dj5t+I/k9gF7ZwDrsWlrTiyaKHFyosK4Ihc23BEiza4JTlKv6q7TbUZJmQwfGGjiMObvjJKY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629350; c=relaxed/simple;
	bh=WDCBKsTHjp/NHJDHJqjkOEXRzEWg6l9ME3B2bbxpytA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NAmHTHbDVA6BAtpvEmGh7e5WlY6ZIC8fDzoEprJ0PaQBRL8JuyMBNZRSia0CfLbPFFaiQUyguLnpLnDhk15V09FG0vdfPb04+KIjFLE8RyA97pUnol+ok8biLbukJ1y8gXXMYZsczzzJY6HASv0/7Xzy2YAK8He8Up4S4XwjWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCMW9hqF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so5491519276.0
        for <stable@vger.kernel.org>; Sun, 29 Sep 2024 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727629347; x=1728234147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RkT0NKS4Ufiuoo5uZ02wVyiBMA1288PpHUseO+PJhjU=;
        b=rCMW9hqF7BhO5tiYx814s/Z5qgJtomjMTR6l5jShD39Vb3YVBYdBugY1kn+f/8H0pZ
         CN/c/RMr7IBO7J0lcbT2cx3y5hzQiIfbVdqokKIDmz/l2teJq/IOKfQdDdpIzaHXBNRY
         DqiQGOkYULSBeIB6/8v8xp+rmcl0kMO2w324A0AC+NCn9ovTTREUJsdhw+DBRGdxEPiZ
         Cor8zOVH49tSF206mxx0ErKd1I/BkkrOJEzCrRjfSC7UqRcbPzMWBDSPRNb/5V2BH0BU
         iOH/8iNaHDnE4GaGj3cHnJrgUXCm5hTPQEkuqCegJTTU+MPYP/96XLaXGSGQP8a7cQg6
         0raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629347; x=1728234147;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RkT0NKS4Ufiuoo5uZ02wVyiBMA1288PpHUseO+PJhjU=;
        b=kms5EE+2gwDWrBWckHaoCFyfoJoU045+ldBH6IJ6KBtY4ioUgovCQlVJu0kn9JfY8x
         megSdQzDDUNx2l4zAKsNRBlv00nLMCmdwRnSbGVauWfNC37k3z6CVzdR6f3tmTsw5fCk
         ug6A2s011uTuBuptfD/Ba9unu4S/zr0opXzO/sBA/ZexLaCuWfkwzHsowGPvlRvCT7mg
         SQKEl42EOcW0RrfedEpZsm6rbWYxjIslCaPrqvpb5Sw9gYpj2k1lGB63OASgLqGzJuOu
         ocmGO6z5Mp5NoL25BpQ9plemqKK/eA0jyXppyx5xrnKrKRkHK/NT2tCIJkYkXxDGztGZ
         Lwkg==
X-Forwarded-Encrypted: i=1; AJvYcCXF97BwSH1wbKpeQTpXwdzG7oBNDuRx0K75XeLBYIcfEul+j1zHQbkBOwjZmzl5yztctHo6QH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2DKNo2QUaEWMc+boBuSNstZctofuS29mY0FmGLONE7Kw4KIp
	9nuFS00wFgNRhqA9infH22Skaarjj0ou4NMPjWZ5NXJ/JCOarghMQU4idOUX7B/lgokwWkxrJQ=
	=
X-Google-Smtp-Source: AGHT+IEvP3/T6gZjub63r0EOa02Spj51ZwcQya0k90XDKjGRzN6mR0VBe3+AMfLmQiv05cITdeBe1vcYbg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a25:ace6:0:b0:e16:6e0a:bb0b with SMTP id
 3f1490d57ef6-e26049562f0mr8295276.0.1727629347546; Sun, 29 Sep 2024 10:02:27
 -0700 (PDT)
Date: Sun, 29 Sep 2024 17:02:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240929170219.1881536-1-jrife@google.com>
Subject: [PATCH v1] bpf: Prevent infinite loops with bpf_redirect_peer
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is possible to create cycles using bpf_redirect_peer which lead to an
an infinite loop inside __netif_receive_skb_core. The simplest way to
illustrate this is by attaching a TC program to the ingress hook on both
sides of a veth or netkit device pair which redirects to its own peer,
although other cycles are possible. This patch places an upper limit on
the number of iterations allowed inside __netif_receive_skb_core to
prevent this.

Signed-off-by: Jordan Rife <jrife@google.com>
Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
Cc: stable@vger.kernel.org
---
 net/core/dev.c                                | 11 +++-
 net/core/dev.h                                |  1 +
 .../selftests/bpf/prog_tests/tc_redirect.c    | 51 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_peer.c        | 13 +++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..753f8d27f47c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5455,6 +5455,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	struct net_device *orig_dev;
 	bool deliver_exact = false;
 	int ret = NET_RX_DROP;
+	int loops = 0;
 	__be16 type;
 
 	net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
@@ -5521,8 +5522,16 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		nf_skip_egress(skb, true);
 		skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
 					 &another);
-		if (another)
+		if (another) {
+			loops++;
+			if (unlikely(loops == RX_LOOP_LIMIT)) {
+				ret = NET_RX_DROP;
+				net_crit_ratelimited("bpf: loop limit reached on datapath, buggy bpf program?\n");
+				goto out;
+			}
+
 			goto another_round;
+		}
 		if (!skb)
 			goto out;
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..28d1cf2f9069 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,7 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
+#define RX_LOOP_LIMIT	        8
 
 #ifndef CONFIG_PREEMPT_RT
 static inline bool dev_xmit_recursion(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index c85798966aec..db1b36090d6c 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -1081,6 +1081,55 @@ static void test_tc_redirect_peer(struct netns_setup_result *setup_result)
 	close_netns(nstoken);
 }
 
+static void test_tc_redirect_peer_loop(struct netns_setup_result *setup_result)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_src_fwd);
+	LIBBPF_OPTS(bpf_tc_hook, qdisc_src);
+	struct test_tc_peer *skel;
+	struct nstoken *nstoken;
+	int err;
+
+	/* Set up an infinite redirect loop using bpf_redirect_peer with ingress
+	 * hooks on either side of a veth/netkit pair redirecting to its own
+	 * peer. This should not lock up the kernel.
+	 */
+	nstoken = open_netns(NS_SRC);
+	if (!ASSERT_OK_PTR(nstoken, "setns src"))
+		return;
+
+	skel = test_tc_peer__open();
+	if (!ASSERT_OK_PTR(skel, "test_tc_peer__open"))
+		goto done;
+
+	skel->rodata->IFINDEX_SRC = setup_result->ifindex_src;
+	skel->rodata->IFINDEX_SRC_FWD = setup_result->ifindex_src_fwd;
+
+	err = test_tc_peer__load(skel);
+	if (!ASSERT_OK(err, "test_tc_peer__load"))
+		goto done;
+
+	QDISC_CLSACT_CREATE(&qdisc_src, setup_result->ifindex_src);
+	XGRESS_FILTER_ADD(&qdisc_src, BPF_TC_INGRESS, skel->progs.tc_src_self, 0);
+	close_netns(nstoken);
+
+	nstoken = open_netns(NS_FWD);
+	if (!ASSERT_OK_PTR(nstoken, "setns fwd"))
+		return;
+	QDISC_CLSACT_CREATE(&qdisc_src_fwd, setup_result->ifindex_src_fwd);
+	XGRESS_FILTER_ADD(&qdisc_src_fwd, BPF_TC_INGRESS, skel->progs.tc_src_fwd_self, 0);
+
+	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
+		goto done;
+
+	SYS_NOFAIL("ip netns exec " NS_SRC " %s -c 1 -W 1 -q %s > /dev/null",
+		   ping_command(AF_INET), IP4_DST);
+fail:
+done:
+	if (skel)
+		test_tc_peer__destroy(skel);
+	close_netns(nstoken);
+}
+
 static int tun_open(char *name)
 {
 	struct ifreq ifr;
@@ -1280,6 +1329,8 @@ static void *test_tc_redirect_run_tests(void *arg)
 	RUN_TEST(tc_redirect_peer, MODE_VETH);
 	RUN_TEST(tc_redirect_peer, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_VETH);
+	RUN_TEST(tc_redirect_peer_loop, MODE_VETH);
+	RUN_TEST(tc_redirect_peer_loop, MODE_NETKIT);
 	RUN_TEST(tc_redirect_peer_l3, MODE_NETKIT);
 	RUN_TEST(tc_redirect_neigh, MODE_VETH);
 	RUN_TEST(tc_redirect_neigh_fib, MODE_VETH);
diff --git a/tools/testing/selftests/bpf/progs/test_tc_peer.c b/tools/testing/selftests/bpf/progs/test_tc_peer.c
index 365eacb5dc34..9b8a00ccad42 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_peer.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_peer.c
@@ -10,6 +10,7 @@
 
 #include <bpf/bpf_helpers.h>
 
+volatile const __u32 IFINDEX_SRC_FWD;
 volatile const __u32 IFINDEX_SRC;
 volatile const __u32 IFINDEX_DST;
 
@@ -34,6 +35,18 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_peer(IFINDEX_DST, 0);
 }
 
+SEC("tc")
+int tc_src_self(struct __sk_buff *skb)
+{
+	return bpf_redirect_peer(IFINDEX_SRC, 0);
+}
+
+SEC("tc")
+int tc_src_fwd_self(struct __sk_buff *skb)
+{
+	return bpf_redirect_peer(IFINDEX_SRC_FWD, 0);
+}
+
 SEC("tc")
 int tc_dst_l3(struct __sk_buff *skb)
 {
-- 
2.46.1.824.gd892dcdcdd-goog


