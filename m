Return-Path: <stable+bounces-95122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FA9D737B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E50E284A46
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A8229C67;
	Sun, 24 Nov 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVGf6u5h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4805229C61;
	Sun, 24 Nov 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456072; cv=none; b=qHV7s4seGzFpDsQ0Rk2dJUJFO+2nnxWOzWO7oL8NK4Z/zBQI5YsZXuqxf/R+X0YAO5Ijrb7gaKHMJH+EOMYDif0+qyTeI5ZUdN7frPbrzpSARQHwNHFPjhQNp3XeGSJBf/x1hO21lAXA8fGWnVeHoLb5hh+O2915ezDQPScmO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456072; c=relaxed/simple;
	bh=rJkcQimjp1uU4jhz0XfPNPy2BjS79UgvD7VZN3ivLsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkqRtYrsQYEg2ySSvWNVQioZ3l7B7Xxf3ycq9bkflz0iyrPY4RM2M8qbNqOD+aHNLbuf80xCrZkTQi3KFa20BC6DJzVRB19EqecgAXdiDVPHfa43Pm1jsxUemItQGCx+bN5DaGgUn7yLbq1Di+H8vGWdC9TXA8oytbZ91nZu0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVGf6u5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440C0C4CED1;
	Sun, 24 Nov 2024 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456072;
	bh=rJkcQimjp1uU4jhz0XfPNPy2BjS79UgvD7VZN3ivLsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mVGf6u5hf+ENdGh04KL32ennhTkXZQfwnUvTNaXuR01Ahe80q/uZyTBDLdzl48tBB
	 HXOjwE1BnuNUpM8KF5m0UJC7k+Bb1Sw17VyBuxQn2dWrISqw2+TQITt0Sw+aUKyn82
	 oEX9xveDUXv9XBPD6hDsgHN4vulglemIZzDKxRXkXjcoDI1U8fIHdOKwD5T2XWCzeT
	 /gfCb5rv0qS6fPM0t+vHE03WAvnLcoORaUzU1MiSHHpDjdA44kEm9SVSAhxk7cUHLe
	 Tg0JE/PAf3Hv7WeF3OpP8vXImFi+/Pi+sO074cD8xsEu4t+FjqwacpMq0jHK3djVkR
	 uts9kqnJZ1AGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	ltuikov89@gmail.com,
	matthew.brost@intel.com,
	dakr@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 32/61] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Sun, 24 Nov 2024 08:45:07 -0500
Message-ID: <20241124134637.3346391-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 2320c9e6a768d135c7b0039995182bb1a4e4fd22 ]

drm_sched_job_init() has no control over how users allocate struct
drm_sched_job. Unfortunately, the function can also not set some struct
members such as job->sched.

This could theoretically lead to UB by users dereferencing the struct's
pointer members too early.

It is easier to debug such issues if these pointers are initialized to
NULL, so dereferencing them causes a NULL pointer exception.
Accordingly, drm_sched_entity_init() does precisely that and initializes
its struct with memset().

Initialize parameter "job" to 0 in drm_sched_job_init().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241021105028.19794-2-pstanner@redhat.com
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5a3a622fc672f..fa4652f234718 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -635,6 +635,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
 	if (!entity->rq)
 		return -ENOENT;
 
+	/*
+	 * We don't know for sure how the user has allocated. Thus, zero the
+	 * struct so that unallowed (i.e., too early) usage of pointers that
+	 * this function does not set is guaranteed to lead to a NULL pointer
+	 * exception instead of UB.
+	 */
+	memset(job, 0, sizeof(*job));
+
 	job->entity = entity;
 	job->s_fence = drm_sched_fence_alloc(entity, owner);
 	if (!job->s_fence)
-- 
2.43.0


