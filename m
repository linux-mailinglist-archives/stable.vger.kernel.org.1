Return-Path: <stable+bounces-65168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9485943F5A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CC92836D7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1133A1C2301;
	Thu,  1 Aug 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBnHy4ZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9213775B;
	Thu,  1 Aug 2024 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472716; cv=none; b=t2X85M83idemW5zmTMXMjxvWdxL/hUGCosLcrS+hNo/cVoZe0B1b8NgjvNo2jftU2lUV7iz1i5LHHbjeBm8d0wvZmGzwjAQXb9iHd/CSit88ln2/cnY4e1IY2axrLi9XsTLXBlIBEpU+NfzDMxfcW9d7anfuhO01yldER1/eGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472716; c=relaxed/simple;
	bh=G18znVv8Awy0nqLe3UcKJM8x74ytyQbdXqD68nCkYLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+UyYe035eet90jwcR408XYtEFwECi3XeYETXbiMLbd+QrZi3q0h68eCAuhRFHzoOdcRIVi4Aquk4cqGV8AZz2e1AavDANnzlVJjbW23juojvxDMDf03fHjulfuDRA88B8unR7cPi7W67ZyJ+WvHvUXog/w++FQ4AliEfn+zkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBnHy4ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377C5C116B1;
	Thu,  1 Aug 2024 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472716;
	bh=G18znVv8Awy0nqLe3UcKJM8x74ytyQbdXqD68nCkYLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBnHy4ZTtCyRVz6umH4CCb+7ytLp8vqh2D5MTyAtTHCc206otFxXvHyoWTVbYkyZ5
	 x4WvV2b4tgb/sOPseoaEBc7pjnJpdMhG/TqmmjIecBPeY8scQZTnTOZA9z/pQ2bEMg
	 aGa0Blk80VOfJpID+JSLQVjoaXyT58VCCGz5JMQG6WaOD05vUYG897BiQT6zQw5Y7M
	 wlE+XlpPqNIYQ/RfyR+ysmQCNgFoTzBtQzc7O4ojHUzG4Uhb4IiDe2Zwc/+87+eB1j
	 9zyIzcND1LyioToOVFSszoZkrzYC5MROQelrxrmHZgJujDfVFXS/6PcJBFsJjUKCXR
	 ssz/VFJDcqpvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 31/38] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:35:37 -0400
Message-ID: <20240801003643.3938534-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 57b56d16800e8961278ecff0dc755d46c4575092 ]

The writing of css->cgroup associated with the cgroup root in
rebind_subsystems() is currently protected only by cgroup_mutex.
However, the reading of css->cgroup in both proc_cpuset_show() and
proc_cgroup_show() is protected just by css_set_lock. That makes the
readers susceptible to racing problems like data tearing or caching.
It is also a problem that can be reported by KCSAN.

This can be fixed by using READ_ONCE() and WRITE_ONCE() to access
css->cgroup. Alternatively, the writing of css->cgroup can be moved
under css_set_lock as well which is done by this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 11400eba61242..e7b84b754748c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1773,9 +1773,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
-- 
2.43.0


