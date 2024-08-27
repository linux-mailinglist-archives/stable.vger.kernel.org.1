Return-Path: <stable+bounces-70305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AF5960394
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85371C22B89
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D1A17BED8;
	Tue, 27 Aug 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caHe/bsA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20E17C9B5
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744767; cv=none; b=C1X4GzuQUxSIKZbYVTKECeTFLeWo8lG9RXfyypLpTjc6jpPJgnXZTdHwk5mfFmfyt2AO8IWD0Tkqc/wwuxlqObJCpICIwCFI37vpvNWilITSXEwpx6bGkJvq1WnOFadYQENUh8pnAg/UEOTYxutw6QXIKfR52JxjKA12MoWV5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744767; c=relaxed/simple;
	bh=Hs1dg5pWD3I295WazAy7VaA30zGQGLIk8UmdYXw78Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLV+OX5X9xkRueWCyFT2VaCa0G6/yYnMkp9Vv5zlI/UU4H0p0KofwMJeq5is94f7ksqD/KCCLdX2is6Dc/RYmUUFe8SL/+a3ASqofBunG4o2GK4x7M1yEXV+vCN2wXporxAnQsUcsElQVyfgh0Cd4xi3+qjFrze6docxs+IsWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caHe/bsA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724744764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lCIJZLOyjsTHc0FIhkASd9ONi97hrv0PKkErCwe7I28=;
	b=caHe/bsAPb0vnQjUDfmoAuqHXIVUBef+6kUxLT20l/Me2tqvwySpWZCYJMp4tKqpRClBOr
	eD1keDWsVZEDa7iWvELYlkA/TYPfbAxeXFgjXD2H1qWeE7bl0wtLTYWoSw5+FXAHmiplHY
	GOzcQPa3Z8zE3Hju1BOo6kTVBe6Pwnw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-IGePmX86NZmMWVq-4A8ttw-1; Tue, 27 Aug 2024 03:46:03 -0400
X-MC-Unique: IGePmX86NZmMWVq-4A8ttw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42820c29a76so49482385e9.2
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744762; x=1725349562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCIJZLOyjsTHc0FIhkASd9ONi97hrv0PKkErCwe7I28=;
        b=P02+qbsxDUF38oLIKkon1nEojpngdQr9PIDO9pvqmNdd9jCa2VeASCrYq48IEnXLxG
         4AqkM1PnuPbqDFrdtOakhlCWDkZ4G9VVaMD6B3ZeUNSiBpLCeehz4rLzC7Vf7MyJge3z
         mVZXncFcWuq/xZ7I2zmwikm2c25uKjWDcsld2AU0EVF5JSUgU7beiIk9LonGFook9M27
         0UDGnhXLTKI1UM30Fs+2TitnKLmDnjprIbqUIpFzBYcbWurkrdLlCzD8Nz2J8KAlJBpp
         rkNS09LavETcj/S7KOei6RN4sQUvZOsEgCd+F0YJ1QhqYAkfUr3108jzeXxmAruhQ4Zc
         jn/w==
X-Forwarded-Encrypted: i=1; AJvYcCXVAC/MXw6V672m9vqPHqvQJhSNfOBLP6aM6Iqz8XxtKBjbBkkOeqjB5HS7nQyTqFlb8ssD/d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmOW2hIIwvV+7UFXVRd8qpKXR+Uq9HvyGZx05CHl/5NZl3Ina
	pgNt4Cj4rhABub5mjvZr2yKV1wkcQhq50RRtU71dx64O774k0l/S9qP1BNgRPQ+8ACj6W3qYgmf
	K0W0FH1hN0T7KWw0bOxXnxD5CkryZEbOfXhz2gTDrQspuPKM9VQkATA==
X-Received: by 2002:a05:600c:35d0:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-42b9ade4cdfmr11440915e9.21.1724744761785;
        Tue, 27 Aug 2024 00:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGik2Opx3PDeJb8i8wW51P+RCvHvq1UmLg7w5MEaT370ExIUUEkmFSlpr26Nf6rxq8yfswqKg==
X-Received: by 2002:a05:600c:35d0:b0:428:1799:35e3 with SMTP id 5b1f17b1804b1-42b9ade4cdfmr11440615e9.21.1724744761183;
        Tue, 27 Aug 2024 00:46:01 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b95c1eef6sm51299435e9.8.2024.08.27.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:46:00 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/sched: Fix UB pointer dereference
Date: Tue, 27 Aug 2024 09:45:22 +0200
Message-ID: <20240827074521.12828-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drm_sched_job_init(), commit 56e449603f0a ("drm/sched: Convert the
GPU scheduler to variable number of run-queues") implemented a call to
drm_err(), which uses the job's scheduler pointer as a parameter.
job->sched, however, is not yet valid as it gets set by
drm_sched_job_arm(), which is always called after drm_sched_job_init().

Since the scheduler code has no control over how the API-User has
allocated or set 'job', the pointer's dereference is undefined behavior.

Fix the UB by replacing drm_err() with pr_err().

Cc: <stable@vger.kernel.org>	# 6.7+
Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Closes: https://lore.kernel.org/lkml/20231108022716.15250-1-dakr@redhat.com/
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..356c30fa24a8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -797,7 +797,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		 * or worse--a blank screen--leave a trail in the
 		 * logs, so this can be debugged easier.
 		 */
-		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
+		pr_err("*ERROR* %s: entity has no rq!\n", __func__);
 		return -ENOENT;
 	}
 
-- 
2.46.0


