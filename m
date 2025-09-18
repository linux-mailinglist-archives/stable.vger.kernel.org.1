Return-Path: <stable+bounces-179952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B12B7E2A5
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2D71B20E61
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C918301465;
	Wed, 17 Sep 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXpbNGNo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39B2C3278;
	Wed, 17 Sep 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112911; cv=none; b=d+Srkdy3gmRtEti3JPnR30i/Sfm3yk1gxxx6qpAuN0/vdpLxT/vckmjr+WKnSbOFd1glqh2EJZQELL9FD+X6BvhT4p/v/toKDXhBBF717JAcu272p9sQ82/nPwTJfyWrtQ8QYAEjIM4Hf+jSvj9kkXSMvE4+ZWTSHtXTalAF5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112911; c=relaxed/simple;
	bh=IDYd2H3kn7VQuHWvMfT+zbJWEzMbPtqRPKsEi787NGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoxvc7YvHsulTVPF2D9rC6hKQVjHVbFUHr9ptszUBmcY94Icbhkkwbji9QQWUEVrBloGJYGKGcdQvW1MoS0dl2wPipIFmumA20y3qcMmUvHvq3OtAwr24feRRYPIJbpvFBihlev2YnbcnlcY2SY4v34KAgEVd57n7Eqmc/7vBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXpbNGNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C25C4CEF0;
	Wed, 17 Sep 2025 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112911;
	bh=IDYd2H3kn7VQuHWvMfT+zbJWEzMbPtqRPKsEi787NGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXpbNGNokk+lf/yH8eTHEGvqljfQ/x9P0VO82wIRCuMs6wmQNU030kmIrN4wGnZIw
	 lCUBYc+vyKlJSPkojB4aNi0GxNobQDJrzPxmRqVgFg6hJlxkC1KTL0UxEaef/og1WI
	 9eTNGwNNjmz4x97UP6CZSwxbvclvtpu3d3V6jIJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.16 114/189] fs/resctrl: Eliminate false positive lockdep warning when reading SNC counters
Date: Wed, 17 Sep 2025 14:33:44 +0200
Message-ID: <20250917123354.652448236@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reinette Chatre <reinette.chatre@intel.com>

commit d2e1b84c5141ff2ad465279acfc3cf943c960b78 upstream.

Running resctrl_tests on an SNC-2 system with lockdep debugging enabled
triggers several warnings with following trace:

  WARNING: CPU: 0 PID: 1914 at kernel/cpu.c:528 lockdep_assert_cpus_held
  ...
  Call Trace:
  __mon_event_count
  ? __lock_acquire
  ? __pfx___mon_event_count
  mon_event_count
  ? __pfx_smp_mon_event_count
  smp_mon_event_count
  smp_call_on_cpu_callback

get_cpu_cacheinfo_level() called from __mon_event_count() requires CPU hotplug
lock to be held. The hotplug lock is indeed held during this time, as
confirmed by the lockdep_assert_cpus_held() within mon_event_read() that calls
mon_event_count() via IPI, but the lockdep tracking is not able to follow the
IPI.

Fresh CPU cache information via get_cpu_cacheinfo_level() from
__mon_event_count() was added to support the fix for the issue where resctrl
inappropriately maintained links to L3 cache information that will be stale in
the case when the associated CPU goes offline.

Keep the cacheinfo ID in struct rdt_mon_domain to ensure that resctrl does not
maintain stale cache information while CPUs can go offline. Return to using
a pointer to the L3 cache information (struct cacheinfo) in struct rmid_read,
rmid_read::ci. Initialize rmid_read::ci before the IPI where it is used. CPU
hotplug lock is held across rmid_read::ci initialization and use to ensure
that it points to accurate cache information.

Fixes: 594902c986e2 ("x86,fs/resctrl: Remove inappropriate references to cacheinfo in the resctrl subsystem")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/resctrl/ctrlmondata.c | 2 +-
 fs/resctrl/internal.h    | 4 ++--
 fs/resctrl/monitor.c     | 6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2de09f..3c39cfacb251 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -625,11 +625,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
 			if (d->ci_id == domid) {
-				rr.ci_id = d->ci_id;
 				cpu = cpumask_any(&d->hdr.cpu_mask);
 				ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 				if (!ci)
 					continue;
+				rr.ci = ci;
 				mon_event_read(&rr, r, NULL, rdtgrp,
 					       &ci->shared_cpu_map, evtid, false);
 				goto checkresult;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedba2b03..9a8cf6f11151 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -98,7 +98,7 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
- * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
+ * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
  *	   @val includes the sum of event counts from its child resource groups.
@@ -112,7 +112,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
-	unsigned int		ci_id;
+	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f5637855c3ac..7326c28a7908 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -361,7 +361,6 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
 	struct rdt_mon_domain *d;
-	struct cacheinfo *ci;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
@@ -389,8 +388,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	}
 
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
-	if (!ci || ci->id != rr->ci_id)
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
 		return -EINVAL;
 
 	/*
@@ -402,7 +400,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 	 */
 	ret = -EINVAL;
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
-		if (d->ci_id != rr->ci_id)
+		if (d->ci_id != rr->ci->id)
 			continue;
 		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
 					     rr->evtid, &tval, rr->arch_mon_ctx);
-- 
2.51.0




