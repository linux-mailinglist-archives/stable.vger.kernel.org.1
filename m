Return-Path: <stable+bounces-218240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ga8IA5RnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A018EE7A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B78A308192E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC12550D7;
	Wed, 25 Feb 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7Iotk4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95C1FE45D;
	Wed, 25 Feb 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983037; cv=none; b=JVaHoZRRxHBu8UHvcPL/+dCQQHzmfAUF9Gb85QmXyOaDSzaGEdFLNRFF1J8nWPw6LqlHijpfo1RwIs/5+arrD/XFSM+VqVux4/8oC6t++2D4DM/RcaMgp3/T7KjRG5t33dZAG9deeuAu2Urk5YlhCzec8bY7I25UrR/h1G+FuAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983037; c=relaxed/simple;
	bh=f9FEO9eJkqckAclrccVktqL/SQrN5RdT/izDDB9/A8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3HabyVT+KJhCn357FWFAH9xeLWROZ2lyzFw4BN6JTyHHe8m6KLQ5etzMOMmZZ6z+yAajy+sgPQ5R4++zua7ZpPtQqNfIfe4+WdXLCsMvI6lVzZtdBGjyrXR2R9UxZ/HMiUoioVDlC1vVHhNDVH9k1HofWm6Sxe/8Pwz7rWUCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7Iotk4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06207C116D0;
	Wed, 25 Feb 2026 01:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983037;
	bh=f9FEO9eJkqckAclrccVktqL/SQrN5RdT/izDDB9/A8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7Iotk4ht5bUi57C98KsuJZFVgdABpm3H2ZTnIQafew8yquiw38NGRJ2sTm8QrDal
	 WskPNmrvamzb7yCZX98cBA5VEmby4w7l2lXuf8fK/Yv71OCZ+SviPdBkq1WRxrKuZW
	 e2To6Dthe04+NKeYjGFOMDAKPSNU27HO+HHTXxzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chia-I Wu <olvaffe@gmail.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 200/781] drm/panthor: fix queue_reset_timeout_locked
Date: Tue, 24 Feb 2026 17:15:09 -0800
Message-ID: <20260225012404.568119569@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218240-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,arm.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 635A018EE7A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-I Wu <olvaffe@gmail.com>

[ Upstream commit ac5b392a8c355001c4c3f230a0e4b1f904e359ca ]

queue_check_job_completion calls queue_reset_timeout_locked to reset the
timeout when progress is made. We want the reset to happen when the
timeout is running, not when it is suspended.

Fixes: 345c5b7cc0f85 ("drm/panthor: Make the timeout per-queue instead of per-job")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://patch.msgid.link/20251202174028.1600218-1-olvaffe@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index f53fa51d51694..6ac4cec52f9e4 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1072,18 +1072,6 @@ group_is_idle(struct panthor_group *group)
 	return hweight32(inactive_queues) == group->queue_count;
 }
 
-static void
-queue_reset_timeout_locked(struct panthor_queue *queue)
-{
-	lockdep_assert_held(&queue->fence_ctx.lock);
-
-	if (queue->timeout.remaining != MAX_SCHEDULE_TIMEOUT) {
-		mod_delayed_work(queue->scheduler.timeout_wq,
-				 &queue->timeout.work,
-				 msecs_to_jiffies(JOB_TIMEOUT_MS));
-	}
-}
-
 static bool
 group_can_run(struct panthor_group *group)
 {
@@ -1100,6 +1088,18 @@ queue_timeout_is_suspended(struct panthor_queue *queue)
 	return queue->timeout.remaining != MAX_SCHEDULE_TIMEOUT;
 }
 
+static void
+queue_reset_timeout_locked(struct panthor_queue *queue)
+{
+	lockdep_assert_held(&queue->fence_ctx.lock);
+
+	if (!queue_timeout_is_suspended(queue)) {
+		mod_delayed_work(queue->scheduler.timeout_wq,
+				 &queue->timeout.work,
+				 msecs_to_jiffies(JOB_TIMEOUT_MS));
+	}
+}
+
 static void
 queue_suspend_timeout_locked(struct panthor_queue *queue)
 {
-- 
2.51.0




