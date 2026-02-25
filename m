Return-Path: <stable+bounces-218997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNeqFg1anmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE63B190A2B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C5F032D947B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FE2877E5;
	Wed, 25 Feb 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9gk13qP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185042522A7;
	Wed, 25 Feb 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983906; cv=none; b=aFT6rJBBKA9nqJTxaoqp1DIvda1QYxfjFts1I/wRaoa0rNlJbTxvRT1Y9LetWLn6SBMwqB//GiNTvnbsbgLiri0PIg4Izbh/dJXaJu18n+Xw2u7XyT43tqoRHQFrec4KYKlGGcFEUgrgiffaEo7V3yd03JjlmZk8wJNOt5VdipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983906; c=relaxed/simple;
	bh=XoIAfc5C9YwdDvf0+fAspcg1S1zA4oXxlPsAhJn8nhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgdfAFQKCjuU48Ch1nwL9DtmEnrqnaHoao1xHPLrc9vH2y1tMFTGD/NqnZRaGR3wOH2sL5s67/bRbs8YxV0z7AAlHtobeTsLDLzeIyR0/JGhEQIiIYiWglT7+kJInsCnCSYDYiQIF62uEv7uMs5Xsgjt8Gn8cr0rfBiV2N/OHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9gk13qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA91C116D0;
	Wed, 25 Feb 2026 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983906;
	bh=XoIAfc5C9YwdDvf0+fAspcg1S1zA4oXxlPsAhJn8nhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9gk13qPJnYlp2YUXHQGabyf9nNkedXwx9doaQATfH2ehWzK+PLu+57gDLRgobkVt
	 37/kfDSibNUxrDrMTUaZdU0lB/drTKYAsyT/F9zNwnLMrjqaNFYyLXm9fLVEUx6EVy
	 w0plGrMZfJr0B2Hh4UVAAxWQ2yJjTToZjItqh9+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 173/641] drm/panthor: Make sure we resume the tick when new jobs are submitted
Date: Tue, 24 Feb 2026 17:18:19 -0800
Message-ID: <20260225012353.231936993@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arm.com,gmail.com,collabora.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218997-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: EE63B190A2B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit 99820b4b7e50d9651f01d2d55b6b9ba92dcc5b99 ]

If the group is already assigned a slot but was idle before this job
submission, we need to make sure the priority rotation happens in the
future. Extract the existing logic living in group_schedule_locked()
and call this new sched_resume_tick() helper from the "group is
assigned a slot" path.

v2:
- Add R-b

v3:
- Re-use queue_mask to clear the bit
- Collect R-b

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Link: https://patch.msgid.link/20251128094839.3856402-8-boris.brezillon@collabora.com
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 43 +++++++++++++++++++------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 368e7f3449105..8f11fe73bee23 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2563,14 +2563,33 @@ static void sync_upd_work(struct work_struct *work)
 		sched_queue_delayed_work(sched, tick, 0);
 }
 
+static void sched_resume_tick(struct panthor_device *ptdev)
+{
+	struct panthor_scheduler *sched = ptdev->scheduler;
+	u64 delay_jiffies, now;
+
+	drm_WARN_ON(&ptdev->base, sched->resched_target != U64_MAX);
+
+	/* Scheduler tick was off, recalculate the resched_target based on the
+	 * last tick event, and queue the scheduler work.
+	 */
+	now = get_jiffies_64();
+	sched->resched_target = sched->last_tick + sched->tick_period;
+	if (sched->used_csg_slot_count == sched->csg_slot_count &&
+	    time_before64(now, sched->resched_target))
+		delay_jiffies = min_t(unsigned long, sched->resched_target - now, ULONG_MAX);
+	else
+		delay_jiffies = 0;
+
+	sched_queue_delayed_work(sched, tick, delay_jiffies);
+}
+
 static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)
 {
 	struct panthor_device *ptdev = group->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
 	struct list_head *queue = &sched->groups.runnable[group->priority];
-	u64 delay_jiffies = 0;
 	bool was_idle;
-	u64 now;
 
 	if (!group_can_run(group))
 		return;
@@ -2615,13 +2634,7 @@ static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)
 	/* Scheduler tick was off, recalculate the resched_target based on the
 	 * last tick event, and queue the scheduler work.
 	 */
-	now = get_jiffies_64();
-	sched->resched_target = sched->last_tick + sched->tick_period;
-	if (sched->used_csg_slot_count == sched->csg_slot_count &&
-	    time_before64(now, sched->resched_target))
-		delay_jiffies = min_t(unsigned long, sched->resched_target - now, ULONG_MAX);
-
-	sched_queue_delayed_work(sched, tick, delay_jiffies);
+	sched_resume_tick(ptdev);
 }
 
 static void queue_stop(struct panthor_queue *queue,
@@ -3222,6 +3235,18 @@ queue_run_job(struct drm_sched_job *sched_job)
 
 		group_schedule_locked(group, BIT(job->queue_idx));
 	} else {
+		u32 queue_mask = BIT(job->queue_idx);
+		bool resume_tick = group_is_idle(group) &&
+				   (group->idle_queues & queue_mask) &&
+				   !(group->blocked_queues & queue_mask) &&
+				   sched->resched_target == U64_MAX;
+
+		/* We just added something to the queue, so it's no longer idle. */
+		group->idle_queues &= ~queue_mask;
+
+		if (resume_tick)
+			sched_resume_tick(ptdev);
+
 		gpu_write(ptdev, CSF_DOORBELL(queue->doorbell_id), 1);
 		if (!sched->pm.has_ref &&
 		    !(group->blocked_queues & BIT(job->queue_idx))) {
-- 
2.51.0




