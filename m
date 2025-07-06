Return-Path: <stable+bounces-160326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A4AFA79D
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 22:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5689C3B8C0E
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500F2C15A5;
	Sun,  6 Jul 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vtdzM+0U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670832BCF75;
	Sun,  6 Jul 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832045; cv=none; b=u5oXyYOwSXFsFUQciDEVlJLyszXjEtAUDvVEsMA8y6cg7STRgBoOYL8Y9Y9q02GNOvlIRhAAkMfsmLFVFnIFv3P5vUvkpKEOUPlF1CSPtS0smAMttfSmlDVi72MMaNdJ9khaiBLS1QFF0x94Bvuw6gIIpvGAytXiWRG308PUunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832045; c=relaxed/simple;
	bh=hY/0MJQsza+izedSJJ03XLPYSzkvnobjs1JkQo0KpaY=;
	h=Date:To:From:Subject:Message-Id; b=PuY1ap/ceQr3xxdyqlmnYqXmL50ZWZXje6Wk5W1iX27CUENSfvdiZrHv1HvRz+q4nfaif9DG1Awh6Bl/GgSSW9XGZTu2gO6a6ev1q7ER1f+Af1FiN0XT0UvltoL01k9Wr2gtcdb8qHfI0ukJXa/2MeK8MG8ictQL3wSIj49B1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vtdzM+0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11ECC4CEF1;
	Sun,  6 Jul 2025 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751832044;
	bh=hY/0MJQsza+izedSJJ03XLPYSzkvnobjs1JkQo0KpaY=;
	h=Date:To:From:Subject:From;
	b=vtdzM+0UNgApJ6wgor4TeUE39JIKt+u9RRqGjkYa7SwG0WipPXQ7MhEwDc8H5p/qB
	 6vt8CamktxSz7qW3CG8n1XbsWTiJzRZnnjUi4KF8VSvxlarzxBVplhndP5z8gKN464
	 EShk6E0+tqzi9fcH3Sc3K/PyQxzJkesClQOhh6ik=
Date: Sun, 06 Jul 2025 13:00:44 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + samples-damon-mtier-support-boot-time-enable-setup.patch added to mm-new branch
Message-Id: <20250706200044.D11ECC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: samples/damon/mtier: support boot time enable setup
has been added to the -mm mm-new branch.  Its filename is
     samples-damon-mtier-support-boot-time-enable-setup.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/samples-damon-mtier-support-boot-time-enable-setup.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: samples/damon/mtier: support boot time enable setup
Date: Sun, 6 Jul 2025 12:32:04 -0700

If 'enable' parameter of the 'mtier' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG can
happen.  Fix it by checking the initialization status.

Link: https://lkml.kernel.org/r/20250706193207.39810-4-sj@kernel.org
Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 samples/damon/mtier.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/samples/damon/mtier.c~samples-damon-mtier-support-boot-time-enable-setup
+++ a/samples/damon/mtier.c
@@ -157,6 +157,8 @@ static void damon_sample_mtier_stop(void
 	damon_destroy_ctx(ctxs[1]);
 }
 
+static bool init_called;
+
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -170,6 +172,9 @@ static int damon_sample_mtier_enable_sto
 	if (enable == enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enable) {
 		err = damon_sample_mtier_start();
 		if (err)
@@ -182,6 +187,14 @@ static int damon_sample_mtier_enable_sto
 
 static int __init damon_sample_mtier_init(void)
 {
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enable = false;
+	}
 	return 0;
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-core-handle-damon_call_control-as-normal-under-kdmond-deactivation.patch
mm-damon-introduce-damon_stat-module.patch
mm-damon-introduce-damon_stat-module-fix.patch
mm-damon-stat-calculate-and-expose-estimated-memory-bandwidth.patch
mm-damon-stat-calculate-and-expose-idle-time-percentiles.patch
docs-admin-guide-mm-damon-add-damon_stat-usage-document.patch
mm-damon-paddr-use-alloc_migartion_target-with-no-migration-fallback-nodemask.patch
revert-mm-rename-alloc_demote_folio-to-alloc_migrate_folio.patch
revert-mm-make-alloc_demote_folio-externally-invokable-for-migration.patch
selftets-damon-add-a-test-for-memcg_path-leak.patch
mm-damon-sysfs-schemes-decouple-from-damos_quota_goal_metric.patch
mm-damon-sysfs-schemes-decouple-from-damos_action.patch
mm-damon-sysfs-schemes-decouple-from-damos_wmark_metric.patch
mm-damon-sysfs-schemes-decouple-from-damos_filter_type.patch
mm-damon-sysfs-decouple-from-damon_ops_id.patch
selftests-damon-add-drgn-script-for-extracting-damon-status.patch
selftests-damon-_damon_sysfs-set-kdamondpid-in-start.patch
selftests-damon-add-python-and-drgn-based-damon-sysfs-test.patch
selftests-damon-sysfspy-test-monitoring-attribute-parameters.patch
selftests-damon-sysfspy-test-adaptive-targets-parameter.patch
selftests-damon-sysfspy-test-damos-schemes-parameters-setup.patch
mm-damon-add-trace-event-for-auto-tuned-monitoring-intervals.patch
mm-damon-add-trace-event-for-effective-size-quota.patch
samples-damon-wsse-fix-boot-time-enable-handling.patch
samples-damon-prcl-fix-boot-time-enable-crash.patch
samples-damon-mtier-support-boot-time-enable-setup.patch
mm-damon-reclaim-reset-enabled-when-damon-start-failed.patch
mm-damon-lru_sort-reset-enabled-when-damon-start-failed.patch
mm-damon-reclaim-use-parameter-context-correctly.patch


