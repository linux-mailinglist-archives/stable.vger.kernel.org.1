Return-Path: <stable+bounces-174313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F0B3627C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E071896A88
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FF298CA7;
	Tue, 26 Aug 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VYz6Rpbb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861226158C;
	Tue, 26 Aug 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214058; cv=none; b=lp2JlLgKmAdPihQ40T/Q/JD0IVIlxq8MT9Md8tOFTH5CAQFEHsrVf5JxzucK1mrZyvAN4g20q60n4Q0eD34T6uXK4ssMGgFvmrPQAt4FAC6Xzy6qHdxHlgIjZadP07UdnEXAbhQzxW7cueqsP7hwVAj1aU/fV9q6sey/peGoe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214058; c=relaxed/simple;
	bh=+MbRgZ/cdqe5KeOOhXjNdF28Bd5UP7m0eTNuDJ1QIDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unMA23BAXHA7ZFG8Zbrwf5IflJUkYrgtQktlh109ZiYg2k8OIr5EOc7JD+Grd9X87mCkzAd07h0BosKsmfCe5ggwD7E6aYduVGWQQYpNQ0ZlyAy7jFd1Te8nUoVE2HPT+R6XBUTo5tHVGVM+IYq+JYhjoJdUUdWBetvzM4ZGLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VYz6Rpbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DBC4CEF1;
	Tue, 26 Aug 2025 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214058;
	bh=+MbRgZ/cdqe5KeOOhXjNdF28Bd5UP7m0eTNuDJ1QIDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VYz6Rpbbv8AyCu4UXTPnzFBiVgfdzYakorMKn6lhpAD1FNCsCmxe16Z0obqm32lkx
	 Lk9fIdYVOoHiq7qC2sqTGIG1vj2qiwDwtBE0FPGt7tBYmeGFBFQdW3Al8wphu9Ti3g
	 dFDPOo6KGS84ZIORRzG64NE1XNX2UIvqDFs2eLkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 550/587] cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key
Date: Tue, 26 Aug 2025 13:11:39 +0200
Message-ID: <20250826111007.010954585@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 65f97cc81b0adc5f49cf6cff5d874be0058e3f41 ]

The following lockdep splat was observed.

[  812.359086] ============================================
[  812.359089] WARNING: possible recursive locking detected
[  812.359097] --------------------------------------------
[  812.359100] runtest.sh/30042 is trying to acquire lock:
[  812.359105] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xe/0x20
[  812.359131]
[  812.359131] but task is already holding lock:
[  812.359134] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_write_resmask+0x98/0xa70
     :
[  812.359267] Call Trace:
[  812.359272]  <TASK>
[  812.359367]  cpus_read_lock+0x3c/0xe0
[  812.359382]  static_key_enable+0xe/0x20
[  812.359389]  check_insane_mems_config.part.0+0x11/0x30
[  812.359398]  cpuset_write_resmask+0x9f2/0xa70
[  812.359411]  cgroup_file_write+0x1c7/0x660
[  812.359467]  kernfs_fop_write_iter+0x358/0x530
[  812.359479]  vfs_write+0xabe/0x1250
[  812.359529]  ksys_write+0xf9/0x1d0
[  812.359558]  do_syscall_64+0x5f/0xe0

Since commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem
and hotplug lock order"), the ordering of cpu hotplug lock
and cpuset_mutex had been reversed. That patch correctly
used the cpuslocked version of the static branch API to enable
cpusets_pre_enable_key and cpusets_enabled_key, but it didn't do the
same for cpusets_insane_config_key.

The cpusets_insane_config_key can be enabled in the
check_insane_mems_config() which is called from update_nodemask()
or cpuset_hotplug_update_tasks() with both cpu hotplug lock and
cpuset_mutex held. Deadlock can happen with a pending hotplug event that
tries to acquire the cpu hotplug write lock which will block further
cpus_read_lock() attempt from check_insane_mems_config(). Fix that by
switching to use static_branch_enable_cpuslocked().

Fixes: d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ad8b62202bdc..eadb028916c8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -432,7 +432,7 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 {
 	if (!cpusets_insane_config() &&
 		movable_only_nodes(nodes)) {
-		static_branch_enable(&cpusets_insane_config_key);
+		static_branch_enable_cpuslocked(&cpusets_insane_config_key);
 		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)!\n"
 			"Cpuset allocations might fail even with a lot of memory available.\n",
 			nodemask_pr_args(nodes));
-- 
2.50.1




