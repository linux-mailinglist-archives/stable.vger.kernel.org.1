Return-Path: <stable+bounces-67450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BD950262
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D741C20DC9
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E41187349;
	Tue, 13 Aug 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h+QPiFjL"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E2208AD
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544722; cv=none; b=cEsFSblP6w5wS/1DadoM+pBW/5jK/6G9A1N7XEf2JT1bZQ5A8MRPr6y5M2iOrsW+LvpYP6t46JNBmyaU0BGNA4KRvA/WIuxXSefeZ59FEErnqUqBV0BGYqlICF/vNW3NrhV4EnAPkpQ6gQl9tbDX9xKklIsJrNVAsq204mcZjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544722; c=relaxed/simple;
	bh=r2auOJE6LbbQTFf6icQU9xYgTqhe5enJ6MapPaIc1wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OlwoP53vyijVdM7kKy1dES0wNs5OtC7D1Un9IFNxv+02HuT3fGILWxvP6mmG2ZPXLnwi32q+3YdepamURzBuyWlPo7HfvCD1fkFTKZuytiVSAmQwOMkn36Kt87UI06o/e+7WksfizehKWBg6Sn3Jc2xb/5T2QkyZ8xfAo9bbfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h+QPiFjL; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RmMAaQVLm22R4ky3+deRS6uCjPL1oBLCXQkikvomZHM=; b=h+QPiFjL6JDkVQwAbqCYzt3YWu
	ncU81jOWWiEHXqei1BAPF5X+LaNEEjHss1H8/83MTCWdnebF8puhmOASRy+UwOZpT1Dgc4Ivpbq3Y
	KCYDkHVfAtmJt3rLj9k3LNtmhMOGLqXiBp9yy78H+3W+KhqGegFEStH+mTz2hoOcVJmrsNLlB62RA
	YXM57586KJvvJDT3Aj1PRs/ojukLLZX7FxJ4eXfXueAQlRavaURfsQnmnMvhbvkOsKhIo0nlinVCJ
	dXUWUfVYIifO+s8ZUmFk+lzNb5XW1TwW8oTQCZhMsNmhhsmASzvMr7SrKUw+vtIa7uarbRPnOuIB6
	iAyy6T8Q==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sdoiC-00Bsut-0b; Tue, 13 Aug 2024 12:25:08 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/v3d: Disable preemption while updating GPU stats
Date: Tue, 13 Aug 2024 11:25:04 +0100
Message-ID: <20240813102505.80512-1-tursulin@igalia.com>
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
Acked-by: Maíra Canal <mcanal@igalia.com>
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


