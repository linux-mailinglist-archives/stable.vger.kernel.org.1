Return-Path: <stable+bounces-94954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7C9D752D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3263B44F03
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0871E048D;
	Sun, 24 Nov 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTf+1NVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFB1E04B8;
	Sun, 24 Nov 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455369; cv=none; b=IZuHZRqZgl/S6/SwjkDCSjPskneegLyNTaLgG7xrdqr1A2uhDZpQazeHdyxqaH8Gmsh3VE+50HbBF5hDTA6r0XMc+zyZiZpOACWPOJ9MZnkfQ5092vR9NxzQCxz2hX3FaxB2u7Hj0QAjEe1lWiCwzO8vYTeE1l9J6A8CVoYf//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455369; c=relaxed/simple;
	bh=w23f07CrIy+GznCKbCOqwJH7ze1gmeI/5uXAH1UokYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXjE3vYYwNce9YIi66LBtuqjqTNOJztnU3vIjptOmm4qBfg+1u45QaEbjROsHarm03vAaW3mLJvo/qfCoIvx+QuaGCVh8j3k9AT3BQctReeU5wycEa3MsQNijGntkfuLTgrVar9IcxqQitwtLkT2a9prxfQkjyDs2yVNOfA+QeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTf+1NVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABB7C4CECC;
	Sun, 24 Nov 2024 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455369;
	bh=w23f07CrIy+GznCKbCOqwJH7ze1gmeI/5uXAH1UokYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTf+1NVbG/aAjD4ZvhgX92Dpos3Vgc18DptZHyA1LEZY8VQVZQFXT190ugvzVfkQD
	 +GUpzrXzdJ3nfQ6AMZrA0GmGZO7eKGFi3ShKbXjN4MjVz6dTOOsM9tLLgZf6p5BI5O
	 qp9D8Gtgd+ZL439Ay3unx4SbJDoM+s9AxEGO6aT0udX+g6qBrn3tFGTqIgEWJsKAvx
	 wUo7K3+ZECPQsAFCvx5jdWJRPEUMgMyAt1sopeqT27BcWYRDXUplSZPIzJH5TurhST
	 RxtgnENJWTvXU6eEN14eMlwv/3+8Tdnvd3EkIRXak4P0XeuvjJ/sirap4Fg7RKm97t
	 uaDK+BpbRhTnw==
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
Subject: [PATCH AUTOSEL 6.12 058/107] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Sun, 24 Nov 2024 08:29:18 -0500
Message-ID: <20241124133301.3341829-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index e97c6c60bc96e..416590ea0dc3d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -803,6 +803,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		return -EINVAL;
 	}
 
+	/*
+	 * We don't know for sure how the user has allocated. Thus, zero the
+	 * struct so that unallowed (i.e., too early) usage of pointers that
+	 * this function does not set is guaranteed to lead to a NULL pointer
+	 * exception instead of UB.
+	 */
+	memset(job, 0, sizeof(*job));
+
 	job->entity = entity;
 	job->credits = credits;
 	job->s_fence = drm_sched_fence_alloc(entity, owner);
-- 
2.43.0


