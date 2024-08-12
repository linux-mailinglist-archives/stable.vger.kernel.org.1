Return-Path: <stable+bounces-66411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B002194E978
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676291F245E0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20616CD1D;
	Mon, 12 Aug 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UyF08sfW"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182B116CD16
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453971; cv=none; b=ot4zWKgxKTOcDq6Bv7evDwLpAwZLNVWRKZVLCuwbLwysdYfhrSNxf6kUMsPzXD0sHZRMj3R1uWupfHHXOXE/zugfSHOEBOxDZNapxyWohipDCNaFyMYtZbSc9tpxIOiff1fw3X1KcCFahPlsvBxz2CEh+uhHY1LrGt3u5PMs9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453971; c=relaxed/simple;
	bh=pxGn8TVe9E+n8XsIG00DYfvIdNAfIdI8Kw3fATAzsEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4Z3w42UE2KRVzYc0l1nDUEDwNsuJ8cFGFjwY7BS5Of+zPQteLyz1bSlgmvzKVMU8T8lyDGpPeWhtu9asLsEbIAIkDkGPRhaitj81AxULQF36mGDyidJbmLjMFY5NBzkOteD5eM1okXEQ0sQUvTZ72IVQS0oPcrmDPMHkz3iZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UyF08sfW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nzakQAeO2wVmbzs7cMJEkVxni0mJK8NaG4e9tA5Swdw=; b=UyF08sfWt6vvsk1wD92VMzHwza
	6dBKCZQjgnUbDZz84oKmAIGMiF4Fis27tM8cKnrpKpBCKBo5i5CQtENdNMBogzQjYxeOi0XUHDkBb
	qZj48Gv793KLcoMu6mHl5hGAeGgYTbBw+yuD3HK/Uj5z4qFahlKssGGUhLeVkXQkGQOioCeq0xEdJ
	hXq+ckjfuY7D3C50xnf61H/yOb27neKm7l4P0WPSEAilhn6xuEIisYVghCQ68uIJ4XbQuUa+cADjQ
	sS/L7Ng0HYCqww/V7FFHOvJ2zvUc4cVFbofSzb7tHU0NoPufhOSbz+Lmt+m9dYC9moKaDlWHHTUKg
	KukKhWNw==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sdR6T-00BSDl-05; Mon, 12 Aug 2024 11:12:37 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/v3d: Disable preemption while updating GPU stats
Date: Mon, 12 Aug 2024 10:12:17 +0100
Message-ID: <20240812091218.70317-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

We forgot to disable preemption around the write_seqcount_begin/end() pair
while updating GPU stats:

  [ ] WARNING: CPU: 2 PID: 12 at include/linux/seqlock.h:221 __seqprop_assert.isra.0+0x128/0x150 [v3d]
  [ ] Workqueue: v3d_bin drm_sched_run_job_work [gpu_sched]
 <...snip...>
  [ ] Call trace:
  [ ]  __seqprop_assert.isra.0+0x128/0x150 [v3d]
  [ ]  v3d_job_start_stats.isra.0+0x90/0x218 [v3d]
  [ ]  v3d_bin_job_run+0x23c/0x388 [v3d]
  [ ]  drm_sched_run_job_work+0x520/0x6d0 [gpu_sched]
  [ ]  process_one_work+0x62c/0xb48
  [ ]  worker_thread+0x468/0x5b0
  [ ]  kthread+0x1c4/0x1e0
  [ ]  ret_from_fork+0x10/0x20

Fix it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 6abe93b621ab ("drm/v3d: Fix race-condition between sysfs/fdinfo and interrupt handler")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/v3d/v3d_sched.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 42d4f4a2dba2..cc2e5a89467b 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -136,6 +136,8 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
 	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
 
+	preempt_disable();
+
 	write_seqcount_begin(&local_stats->lock);
 	local_stats->start_ns = now;
 	write_seqcount_end(&local_stats->lock);
@@ -143,6 +145,8 @@ v3d_job_start_stats(struct v3d_job *job, enum v3d_queue queue)
 	write_seqcount_begin(&global_stats->lock);
 	global_stats->start_ns = now;
 	write_seqcount_end(&global_stats->lock);
+
+	preempt_enable();
 }
 
 static void
@@ -164,8 +168,10 @@ v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue)
 	struct v3d_stats *local_stats = &file->stats[queue];
 	u64 now = local_clock();
 
+	preempt_disable();
 	v3d_stats_update(local_stats, now);
 	v3d_stats_update(global_stats, now);
+	preempt_enable();
 }
 
 static struct dma_fence *v3d_bin_job_run(struct drm_sched_job *sched_job)
-- 
2.44.0


