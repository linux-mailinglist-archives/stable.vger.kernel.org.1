Return-Path: <stable+bounces-95177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3909D73F1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F591667C0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71E12354D3;
	Sun, 24 Nov 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E26if7mj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8E2354D2;
	Sun, 24 Nov 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456242; cv=none; b=kogzMjuZRIeuQAZ77DnrO2ttY1v25z8psIlAWS0R5uq7Qm7mgK6UjAevM+nJcn4JrS3LnArN3B49wYd3XZPt3Ub2YN7P80WAFFHlaG3nMBz1kXUaSdpUAd5YaAZD9EERqjW5Vem4GmtSPxMwhhC7OhHccVHjfdOqnWrag7ANH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456242; c=relaxed/simple;
	bh=PflkmNnFfI51mszL8pskz9n4oU+nEZbo2KaAzSEZIUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahaqr9ZNyQSvRCZVOFC8ZCznoY1V6Rei6ZF4CRBSjyugODgEgqY3XYKFX3vI1JnUyD5O/76ww182Up6ZYNMDLSsPJLLq9QygCHVvU6eQiTzPY+jOLGby3UXxYNVz3S0uOzoGIZQU+2gZU1oSA1BcFDhRrsExCKQVuSWX004+z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E26if7mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0A3C4CECC;
	Sun, 24 Nov 2024 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456242;
	bh=PflkmNnFfI51mszL8pskz9n4oU+nEZbo2KaAzSEZIUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E26if7mjlBjGe2hHX8yLpKmCDEFmk1r44qhbdNEld0QcEc8FyhFQBaZpkZGF08Krx
	 h//so2HNwYvYg/0gG4KVYG9HT9UIt5tJ8EBR+Rc6vnL2h5Pqtt4ElXxFekYSTBnlkL
	 G0wC9zNqjCXgBtQtvnoLUYtGtlkqBIecELQDkWrRCsJjnb1N3z5YsWsUSsrQUBCkPv
	 EU6Hx1k/IomvhlFWQzHqPQ45X4/TLaq1C8Y9NTIZOlLxwxuAMS7KvcE4WQUbquoG+Z
	 850bB80j2SaMGDEYxKqg5WSglApjbhNMSHAjqfyt5sFDpJHvLUN/kgt1Uecq9riKEB
	 Gnt8TeMoOGeAA==
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
Subject: [PATCH AUTOSEL 6.1 26/48] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Sun, 24 Nov 2024 08:48:49 -0500
Message-ID: <20241124134950.3348099-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index f138b3be1646f..dbdd00c61315b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -595,6 +595,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
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


