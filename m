Return-Path: <stable+bounces-76112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10F9789E1
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7454E286456
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3761A146D40;
	Fri, 13 Sep 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrSJ5H2y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F147A73;
	Fri, 13 Sep 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258993; cv=none; b=hUA4NYVpovmCjeBBg/vTfoEdjV9RMAoz3Un+7zRzHuC73Ig9yqCiOwfcTnP4oK868HuZPMYEmG2mj7qhKrQYiMCJEXHxbDMuQ+fosKcg9lIwu6RCvF6ZWQ/kYaxhebkWjRFjXRSWmZHHbsgbc0f9svpwzWeefshREtgBLMTkHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258993; c=relaxed/simple;
	bh=6ttCygXWaiy9o5ImONLw+WDzQK4E7NW68xfA6SeWar4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1nMXHZk8lUJxMOb2WyTrZ+gFKaQRo7gz9cqYSZUAFWneyCUbXAyBUzQeVpPPIHry1chsQvnNfTCSVkeC+Edov2Qc2hKSSHH/2ELzwUU1aofFd+xJYRHnEkXzEpBq0AC8OI/EeluTEF11pmLHMOuN8TAaEsr9iRxyl4u2GEjVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrSJ5H2y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055136b612so32785025ad.0;
        Fri, 13 Sep 2024 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726258990; x=1726863790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGrbRu4UVUOtjQ0FjFvwXtnrS7aqfcokFl3QpnQ2GXE=;
        b=BrSJ5H2yaavFWglSmBVI9ZoDf9JuFYVOikfi/sXn24qjdy6xhFoMRhr1fTPaj6Tgqh
         bidaDIImE3U0kNM+dY/4cm6CiIQhofM/+t/Se9l8gKJJ0teEWbWs5BRc3M3ITuCKd0jy
         a3t6yBFWbdkK8ul09ccMBF028g+9q/9spKI628ZLYOMh0iJ054JS6zg4cMlGSM0tfmrT
         sXqzSO8nWbyDfkYl+kjYEhSHrTavWryRvdmCoSu5ZVv+qZZ0arG57TGmj7UBHmP+kWQg
         AJ/ZZ/mN7zs+Gq/zw79i9PVQB2KTyKNPP5Lesj3csGYqOv1vtO8qOKpRauCxjqu4ezMV
         Bw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726258990; x=1726863790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGrbRu4UVUOtjQ0FjFvwXtnrS7aqfcokFl3QpnQ2GXE=;
        b=RV3ed+bbP/RiKvF5Q/LTtGaD7unUrwVbqtuEsmypeJG0P+ruJMmE1O6CpRTjk++2vn
         49VZHKPU4RRPaW6Y/t5I6hmrcokWiCtgCd/lqUwUO264KNsOHn8SWJpGj2f9iQyYSU88
         Qw0VvJet6YhkCwEpLrByjLw0UvWnX8p5K4BeDbBBPAH+AQpJQmWKFLNOJOsEsGiOdtzE
         923K8/1Ztda3XUtay1++yslMkEk5mqsK4Gp2eFengyY1wvFoqxuJsLdcmnizOqfzdEf1
         6QgP+rYIPBN/JILZmZJxDK+hb6ZR0Xc5QlDI7/zyQpk71eRBVIFnEljBgDQh/MKebLtn
         ziNg==
X-Forwarded-Encrypted: i=1; AJvYcCWFS3dj9+pbummNgsUEnys1M5eYSShvIOtm7Ww598tuzeMfe5VE0BdXmQn6pyfh7OWw+V7OxsHD5GRaNNc=@vger.kernel.org, AJvYcCWYYmW6jQos4SEv9G0ki/gqXNVcDFIbqKRzPPL/gjJBhVV12Rh2wxzU1GwHLWuN32pdHSs6lKMO@vger.kernel.org
X-Gm-Message-State: AOJu0YzEE+2MdiHDi6dNuZ0mUUdW2VgDtq4qtQTw2V96mvkRDUYuaYHQ
	tnF4PuBPSqnYjoKOxqegWU3fveQzBF3mQ/Fzs5cwO3eCAeF2w4Sh
X-Google-Smtp-Source: AGHT+IFHJ41lFsckyz82yO3h+VuYR/uhhZQb1LPgxwsKBosoaojM8n5ejFt72vGXXggfzMb2Hq8hRQ==
X-Received: by 2002:a17:902:ccc8:b0:207:1709:dbe with SMTP id d9443c01a7336-2076e421fddmr131470595ad.50.1726258990386;
        Fri, 13 Sep 2024 13:23:10 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794730be0sm305315ad.264.2024.09.13.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 13:23:09 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Asahi Lina <lina@asahilina.net>,
	stable@vger.kernel.org,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/sched: Fix dynamic job-flow control race
Date: Fri, 13 Sep 2024 13:23:01 -0700
Message-ID: <20240913202301.16772-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609

The whole premise of lockless access to a single-producer-single-
consumer queue is that there is just a single producer and single
consumer.  That means we can't call drm_sched_can_queue() (which is
about queueing more work to the hw, not to the spsc queue) from
anywhere other than the consumer (wq).

This call in the producer is just an optimization to avoid scheduling
the consuming worker if it cannot yet queue more work to the hw.  It
is safe to drop this optimization to avoid the race condition.

Suggested-by: Asahi Lina <lina@asahilina.net>
Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
Closes: https://github.com/AsahiLinux/linux/issues/309
Cc: stable@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
 drivers/gpu/drm/scheduler/sched_main.c   | 7 ++-----
 include/drm/gpu_scheduler.h              | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 58c8161289fe..567e5ace6d0c 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -380,7 +380,7 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 		container_of(cb, struct drm_sched_entity, cb);
 
 	drm_sched_entity_clear_dep(f, cb);
-	drm_sched_wakeup(entity->rq->sched, entity);
+	drm_sched_wakeup(entity->rq->sched);
 }
 
 /**
@@ -612,7 +612,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo(entity, submit_ts);
 
-		drm_sched_wakeup(entity->rq->sched, entity);
+		drm_sched_wakeup(entity->rq->sched);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index ab53ab486fe6..6f27cab0b76d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1013,15 +1013,12 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
 /**
  * drm_sched_wakeup - Wake up the scheduler if it is ready to queue
  * @sched: scheduler instance
- * @entity: the scheduler entity
  *
  * Wake up the scheduler if we can queue jobs.
  */
-void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
-		      struct drm_sched_entity *entity)
+void drm_sched_wakeup(struct drm_gpu_scheduler *sched)
 {
-	if (drm_sched_can_queue(sched, entity))
-		drm_sched_run_job_queue(sched);
+	drm_sched_run_job_queue(sched);
 }
 
 /**
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index fe8edb917360..9c437a057e5d 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -574,7 +574,7 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 
 void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched);
 void drm_sched_job_cleanup(struct drm_sched_job *job);
-void drm_sched_wakeup(struct drm_gpu_scheduler *sched, struct drm_sched_entity *entity);
+void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched);
 void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
-- 
2.46.0


