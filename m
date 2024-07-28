Return-Path: <stable+bounces-62145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C993E5F7
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2EC1F215B0
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D153373;
	Sun, 28 Jul 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF1Cyo7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150441C64;
	Sun, 28 Jul 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181354; cv=none; b=o7/l+GWugB6+4+W/HjXkiGDwNLrVuuoOuBJF6VIU5MX3fXcGe5cKQ5F7Blp089Nhy+NcnmYhbI9KqsHz3iseRKyTg36w9DmTAJwxWersvMrZWwNEEtBGtS3K0G+tKq61W/z9OWatdY38wkznIpPCwk/RjjNmIaY6wS/fY52r2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181354; c=relaxed/simple;
	bh=8q5D2B9OW6lTxci4LEAhIIy1s+NJNtC4AYx42sA6Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PF1fCajwbKkcn4bMJJMcwffM4uJlOOQkmqpMUp2pI8PGLnr0ozTj4MQNjKVd98u2MycvD99MfQigcJQ5jngSvG3d7Je2hfM0grFpxhWgMtn/B8UpJKl9JdCJjUkZVWP2ulMxUTsfSXV6LexC0CAxTGCY+nzfV6tpLjF2LPJzdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF1Cyo7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B4C116B1;
	Sun, 28 Jul 2024 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181353;
	bh=8q5D2B9OW6lTxci4LEAhIIy1s+NJNtC4AYx42sA6Xts=;
	h=From:To:Cc:Subject:Date:From;
	b=fF1Cyo7eX1QOiKplbmpbh0dNRqh+QJP9ls93EcvUmxzYaqgtgFl7ORfhcS4oSvgoy
	 ck0Gucc1TiHWsyzuhxG5CW45D38fwFaLoBFJGNj/0bvAVJ/lqL6vfv6lTiDWhPDAZJ
	 fZMCLyGTpxouT9907MqOiwJJRNAVBTCSX0V/qq1KUs1RpoHVnxj3cC9yZE+yEtux7J
	 6yg9ofcDGdxL4KRROkSXNdcaFlPdB55R65eVXdHW/Nsp72K3XfIyUfoGpyvVuN8NZK
	 4jeDaSTiBY2mTif6LyMCSPySgQSoAuRzKbXVuEbV7YAbsLKvWnGTGTd9gA0zY8S1Yx
	 PJFDjM7ezug/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 01/34] drm/xe/preempt_fence: enlarge the fence critical section
Date: Sun, 28 Jul 2024 11:40:25 -0400
Message-ID: <20240728154230.2046786-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit 3cd1585e57908b6efcd967465ef7685f40b2a294 ]

It is really easy to introduce subtle deadlocks in
preempt_fence_work_func() since we operate on single global ordered-wq
for signalling our preempt fences behind the scenes, so even though we
signal a particular fence, everything in the callback should be in the
fence critical section, since blocking in the callback will prevent
other published fences from signalling. If we enlarge the fence critical
section to cover the entire callback, then lockdep should be able to
understand this better, and complain if we grab a sensitive lock like
vm->lock, which is also held when waiting on preempt fences.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240418144630.299531-2-matthew.auld@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_preempt_fence.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
index 7d50c6e89d8e7..5b243b7feb59d 100644
--- a/drivers/gpu/drm/xe/xe_preempt_fence.c
+++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
@@ -23,11 +23,19 @@ static void preempt_fence_work_func(struct work_struct *w)
 		q->ops->suspend_wait(q);
 
 	dma_fence_signal(&pfence->base);
-	dma_fence_end_signalling(cookie);
-
+	/*
+	 * Opt for keep everything in the fence critical section. This looks really strange since we
+	 * have just signalled the fence, however the preempt fences are all signalled via single
+	 * global ordered-wq, therefore anything that happens in this callback can easily block
+	 * progress on the entire wq, which itself may prevent other published preempt fences from
+	 * ever signalling.  Therefore try to keep everything here in the callback in the fence
+	 * critical section. For example if something below grabs a scary lock like vm->lock,
+	 * lockdep should complain since we also hold that lock whilst waiting on preempt fences to
+	 * complete.
+	 */
 	xe_vm_queue_rebind_worker(q->vm);
-
 	xe_exec_queue_put(q);
+	dma_fence_end_signalling(cookie);
 }
 
 static const char *
-- 
2.43.0


