Return-Path: <stable+bounces-188151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C7BF232A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00673A4E24
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1726E6F4;
	Mon, 20 Oct 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmkcZSBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65F26E161
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975058; cv=none; b=craoEnbL2d+foS2ZYa8hUEDqUdWb+OJbqBhxQ31Lnfum+ujHelSGLjet2fllcUAKT3phHXn23k8XAmN//VTMWFXXoh6IgKvZxAe8P9p6+o4dg8NtW4mLiIxlVl+bXms/kljnu6x7hE5mw57+eA3O3YoCA9oQO/YYeS3CxglujNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975058; c=relaxed/simple;
	bh=Gq0pZxpetXYGpwx+sFy563WwE6Tjqac+DwECuIDRJrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7nC4uEX3rQRhqD1mTN1ntYRnA0FKmVOTf+zw1MrCXmHr8XTZTxjDlIZE89byjCog6Zvt/dPgeRGBu380BnNor/s6iQ72kr/AVcCKIZjWoRcY2TI2Sn/DyeI7xt6KfFOqWXTAame3OzeceCbCvZbp+tgmd/jmftwWXXFiLwRloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmkcZSBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E255C113D0;
	Mon, 20 Oct 2025 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975057;
	bh=Gq0pZxpetXYGpwx+sFy563WwE6Tjqac+DwECuIDRJrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmkcZSBLBG02VhKkbCWM+16xldy5KxYZxiCyQQbjlRFl54LmO3IwU8vIbsyw99oxz
	 sW7H+27vxvrKNpha4g8rqvDwUajgARehdVvOKYdwTa/H/0b2lj1FT18FGLUAZZAmRG
	 Sy7xuS7ULVyzIZb/kQx8jkMpf6lGB0tfH/APB3EBtR2UwThEd9V0kyzfAqo3k/HibL
	 i4up65p6UwEJ1b5z7hGaWKlBCuhXToG2ZoFrbur15kKCS3zarheKhHTtEqu13PlYrq
	 O2PkYBQquZHjSih0gn+ZCQPvEMRXd8uNr2L7m0uiYW512DNN0zawVEBXBtQSXoQsH7
	 OnGjs+WJ/V3ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/8] net: Add locking to protect skb->dev access in ip_output
Date: Mon, 20 Oct 2025 11:44:06 -0400
Message-ID: <20251020154409.1823664-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020154409.1823664-1-sashal@kernel.org>
References: <2025101604-chamber-playhouse-5278@gregkh>
 <20251020154409.1823664-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>

[ Upstream commit 1dbf1d590d10a6d1978e8184f8dfe20af22d680a ]

In ip_output() skb->dev is updated from the skb_dst(skb)->dev
this can become invalid when the interface is unregistered and freed,

Introduced new skb_dst_dev_rcu() function to be used instead of
skb_dst_dev() within rcu_locks in ip_output.This will ensure that
all the skb's associated with the dev being deregistered will
be transnmitted out first, before freeing the dev.

Given that ip_output() is called within an rcu_read_lock()
critical section or from a bottom-half context, it is safe to introduce
an RCU read-side critical section within it.

Multiple panic call stacks were observed when UL traffic was run
in concurrency with device deregistration from different functions,
pasting one sample for reference.

[496733.627565][T13385] Call trace:
[496733.627570][T13385] bpf_prog_ce7c9180c3b128ea_cgroupskb_egres+0x24c/0x7f0
[496733.627581][T13385] __cgroup_bpf_run_filter_skb+0x128/0x498
[496733.627595][T13385] ip_finish_output+0xa4/0xf4
[496733.627605][T13385] ip_output+0x100/0x1a0
[496733.627613][T13385] ip_send_skb+0x68/0x100
[496733.627618][T13385] udp_send_skb+0x1c4/0x384
[496733.627625][T13385] udp_sendmsg+0x7b0/0x898
[496733.627631][T13385] inet_sendmsg+0x5c/0x7c
[496733.627639][T13385] __sys_sendto+0x174/0x1e4
[496733.627647][T13385] __arm64_sys_sendto+0x28/0x3c
[496733.627653][T13385] invoke_syscall+0x58/0x11c
[496733.627662][T13385] el0_svc_common+0x88/0xf4
[496733.627669][T13385] do_el0_svc+0x2c/0xb0
[496733.627676][T13385] el0_svc+0x2c/0xa4
[496733.627683][T13385] el0t_64_sync_handler+0x68/0xb4
[496733.627689][T13385] el0t_64_sync+0x1a4/0x1a8

Changes in v3:
- Replaced WARN_ON() with  WARN_ON_ONCE(), as suggested by Willem de Bruijn.
- Dropped legacy lines mistakenly pulled in from an outdated branch.

Changes in v2:
- Addressed review comments from Eric Dumazet
- Used READ_ONCE() to prevent potential load/store tearing
- Added skb_dst_dev_rcu() and used along with rcu_read_lock() in ip_output

Signed-off-by: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 23ee8139a7563..e5c9ea1883838 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -566,11 +566,23 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
 	return READ_ONCE(dst->dev);
 }
 
+static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
+{
+	/* In the future, use rcu_dereference(dst->dev) */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return READ_ONCE(dst->dev);
+}
+
 static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
 {
 	return dst_dev(skb_dst(skb));
 }
 
+static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
+{
+	return dst_dev_rcu(skb_dst(skb));
+}
+
 static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 {
 	return dev_net(skb_dst_dev(skb));
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4d432e314bcb2..0bda561aa8a89 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -426,15 +426,20 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
+	struct net_device *dev, *indev = skb->dev;
+	int ret_val;
 
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, indev, dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+				net, sk, skb, indev, dev,
+				ip_finish_output,
+				!(IPCB(skb)->flags & IPSKB_REROUTED));
+	rcu_read_unlock();
+	return ret_val;
 }
 EXPORT_SYMBOL(ip_output);
 
-- 
2.51.0


