Return-Path: <stable+bounces-95050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7219D729B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE393162BEA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FAB20102D;
	Sun, 24 Nov 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfJ7ehyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AD201028;
	Sun, 24 Nov 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455808; cv=none; b=V46Ef6FGkxD01WPixCCOCFaxhDs/QXzmifpw8zcbUFdp9lu544SCdzStzRL8a0XvTmsmYgVzn6XfeNCRcBLwUg8pNmsEAb25200Y515ONfsWGzWAOioVqSD49TW52SaTsWONr6xJbeEV0lzflmEKMmXqFKUqURKz9mpRuy3ElS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455808; c=relaxed/simple;
	bh=fyqo6oZTDiIismfuDx03b5xSttcnX1gRtpOqOmcXHUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsK5p+D3pGk1+/DCUF2ole7SqS48lb/GASbxZUZLCrXpDzXfEtElK9eGtOb1Iz9YDZqgVJ1oFYYGk0n+SImcz1M2wRGhhPEL6bUTI1ZY0p6GpQUYH+I0vq7NU3UGECyAq57FNaBh1rf6uyWaTCLjFc+jBVzglsaaR1PN0S+Vs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfJ7ehyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6CBC4CECC;
	Sun, 24 Nov 2024 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455808;
	bh=fyqo6oZTDiIismfuDx03b5xSttcnX1gRtpOqOmcXHUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfJ7ehyIFH56eG0dJcFZXTyl9Jtf2xdnXY2UPs67V75GMbTw3vh4klAcF77lhLH2t
	 YJpsDNdQERhyGRR41lEAvERdUCaqmrEPIYbXSN/Ub0/2c8EU4J8YDqpbZVkTFEPm01
	 DteqG3Wn4MM6Ci8WdQkdkgvtQqR5wlP1tjOG2hOjwaj/+8QYld6K9RvREpGWLLbYWi
	 Qu5HmOSlextJ9P6AlxBuW/Ug374Cv/39jS79oxz3gJg0EgbW1mq8i6r+hJvAX5T/y8
	 Tuifm8+5P9nt70l78fi9k0qnsiMPu0lHVHVp1hefGCpXvi225FJ3pSiyzXEMWE1w0b
	 lKlxW7ZPgMYMg==
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
Subject: [PATCH AUTOSEL 6.11 47/87] drm/sched: memset() 'job' in drm_sched_job_init()
Date: Sun, 24 Nov 2024 08:38:25 -0500
Message-ID: <20241124134102.3344326-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index a124d5e77b5e8..9ed7efa655c6b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -806,6 +806,14 @@ int drm_sched_job_init(struct drm_sched_job *job,
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


