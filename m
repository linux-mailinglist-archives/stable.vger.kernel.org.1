Return-Path: <stable+bounces-158034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99798AE56A3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0497C7B3076
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C2222599;
	Mon, 23 Jun 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyVACwLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6915ADB4;
	Mon, 23 Jun 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717321; cv=none; b=lsCH61YI+UKoY9kmU1og3LQzndGucYPUWS6LhnrYJVnqqRKqpwF4/e6K+8xkjI91k15opgjo7GtZ/wcPh07NbROrYhNPgjXoSD1zPs2BThO/Gi480tAT6UgsyzAKJsadBZzzUB6Vbwm1unGT5qgRjvJJFFMhPGKWX8GMxe3BKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717321; c=relaxed/simple;
	bh=HeItyzJhSukG4FuwIbyofLOOjRtwRtTyNlfVktW2fgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm4IpIBef9uJprLr+HdfQ8kA002Sf79dt4PxnwNsnYufsctaQ4XyfQPkZ1y20DKoU2dnZs9Psprf5UdijLVeHwad+VwgUsl1xhuZ7YH2Aclqw5AHgEzWSbzxEa4cyAVhT6IOSOqpRfMCeym5pH7TzxkGcYMS3WHD7mvAoSHFCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JyVACwLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1772C4CEEA;
	Mon, 23 Jun 2025 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717321;
	bh=HeItyzJhSukG4FuwIbyofLOOjRtwRtTyNlfVktW2fgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyVACwLZofPb/eeZhosqii4IQVjH6qS5cEwdqOxcm43XbU1GDNZ5t/sPZNtseHhV3
	 taii6mNwJhBdwE3k2IVoR/Mr3ICOfbySzU44zdXK4/RfsMsowFdo0dpYE+BPxwdkbH
	 QV8eCpfqDQGm6roV9nPM6XXv+31xKkDPnqe1nQbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 404/508] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Mon, 23 Jun 2025 15:07:29 +0200
Message-ID: <20250623130655.179822277@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 1c0829788a6e6e165846b9bedd0b908ef16260b6 ]

The statistics are incremented with raw_cpu_inc() assuming it always
happens with bottom half disabled. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this is no longer true.

Use this_cpu_inc() on PREEMPT_RT for the increment to not worry about
preemption.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20250512092736.229935-4-bigeasy@linutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4574dcba9f193..8701081010173 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -192,7 +192,11 @@ const __u8 ip_tos2prio[16] = {
 EXPORT_SYMBOL(ip_tos2prio);
 
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.39.5




