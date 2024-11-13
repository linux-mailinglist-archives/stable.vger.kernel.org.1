Return-Path: <stable+bounces-92959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7339C7D49
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB71F23808
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB15206E78;
	Wed, 13 Nov 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOnRZAiP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302D204021
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531833; cv=none; b=qDeVoZrlTWbd3ExZ3Y1YMwiVtJRHoMy7XLenXmEqPN98Fm0wdqfv8injevJukkTfjcdt5dds3hZDeyhSZe8FVQlNxrzWE5vCJfFfTnHTXqKqrZCUfTqTsYnPDINWeTUwabf9wBwhcXcG7Sw5hkcGn3AeoZEG21cBkcWICJzevXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531833; c=relaxed/simple;
	bh=Heiust2lk2TQ7+75yP27aiVUP7Gcr7UNHszJsH/pVxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dj735hSECGhhT98VyNMF1ydN9Gm97pVR5z9Lz2FTk1VHw9KrZFSmvzClIxAQpSrrQDxWHCB3P5aU15ogtuM2QbKLLSo0tZ9q86S/noFz9oEX1hEI7GQo4ned0xbn9JuKiJm4qhA7HfEglmfnhfrPquEs8Yxk7wFZp2upyKbi2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOnRZAiP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so3570a12.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 13:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731531830; x=1732136630; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOCUc/yJUoL2hpg7TdUrHhUe2R4Jfk9THcrUWgwfKEw=;
        b=IOnRZAiP+ZmlIW/StkVi40qmGdfeEla6GcYRxPsKbXYqDhKAifWrlFrm6+imMF5TDq
         zPWte9bykvoipdA0EYVjSNfZFN2FkIOhrgmZfClLf07WikPlXwS821tLv8U9sjFcFXKw
         C+TdUTlG49bX/Mv184zM+JAZbjihSD1n97n++l4ZBIvOf6yDWxxcuyXwI8/I9RnlwEEM
         gP3a6tDN6rT3t2LioU+w3Iehloy1+41ulasSoDF9r9UHQvROsU9N0tC3hZEcdMJe7Pgv
         1KPRrIEZR0/5Pzniv4nK5Q67KkP2XpXAqe592BSVFL0rmeV2ID9PJb2qeXQWJr4GXKBe
         eYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531830; x=1732136630;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOCUc/yJUoL2hpg7TdUrHhUe2R4Jfk9THcrUWgwfKEw=;
        b=SNxIX+R6KDeDNZLDT0mMo8JaC02txT8+8czWzPkiH/rxoQ5U03/ays5cLQC6bsl0wm
         qnw/oakPQ17wo6iMQ2WKtgHzoUmcf2JkUHyXWZMvgWDaUOR9TMq9W92tlAXcyJy01Eng
         7XEQJ4M42QesAR2c2JvP283M6tirE5iFC006nu8eHeDNWiQlwECdxPGXCbX6RngnYRMS
         ZOPezNYWpmtEaD1YRV8I6ZEoKinl3NmbuzUYLJBJiKHERUkm+bju9maLslwIvlJHSBKn
         F5dsu203h5OmM8h9lNGFvrxceb8GRMncB/nbH4RBZoVpcSHWdXJ2nW2Aaj2aPCcRBzOl
         jMOw==
X-Forwarded-Encrypted: i=1; AJvYcCWNyVtOrjXif6F10i0FUzYJspHElHPBastEwdGfp6wuRNAGWtLgNhamjLrPymlwRF1g5e95Y3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEZ06jZfuPxMktTj6B+4X/gmx2CSiLfiRLtNKfalukf1uPwUT
	puB6zA0vOOfUvCYJ9ylisZu7tMkJtAbx6y3jd1WABSu2Vf1PajlDa5haGSUyog==
X-Gm-Gg: ASbGnctOZV+vruML6fDqiFwluaX8P0bgbYUPeVFB7yh24vcNRRRLfznMH9BV710t6/J
	Lqtx5FSoFgSt/P/foXkZctbJJXUh3P9MCJ4+IWc4rlVS618YsScOPlvz1+1hJSJ/w3xzCfK6er/
	ziUq5pDZWrb/HWboaLm/rsZ7gVUOapvEv/LDxTPOf/iY5Tn5Ix8j3Q3Xpb7tJgOPOA7YHvJu1qI
	g+pis39uYm9SFF3FcGqJUPeaUk3lQx0HabJPQ==
X-Google-Smtp-Source: AGHT+IG1zVNACjIiwuT159tiQbcacfdUCCAM6NVeqCGU2Yzh1607/zU+bDBumeceKweprv/UyAwMdA==
X-Received: by 2002:a05:6402:1a52:b0:5ca:18ba:4a79 with SMTP id 4fb4d7f45d1cf-5cf762fa6b0mr66520a12.7.1731531829738;
        Wed, 13 Nov 2024 13:03:49 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:69d0:c862:d7b:9232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea3cbsm19603805f8f.74.2024.11.13.13.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:03:49 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Wed, 13 Nov 2024 22:03:39 +0100
Subject: [PATCH] drm/panthor: Fix memory leak in
 panthor_ioctl_group_create()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-panthor-fix-gcq-bailout-v1-1-654307254d68@google.com>
X-B4-Tracking: v=1; b=H4sIACoUNWcC/x2MWwqAIBAArxL73ULaA+oq0YfppguhpRVBdPekz
 4GZeSBRZEowFA9Eujhx8BlEWYB2yltCNplBVrIRQtS4KX+4EHHhG63ecVa8hvNAaXql667tKzK
 Q6y1SVv7zOL3vByy90QVpAAAA
X-Change-ID: 20241113-panthor-fix-gcq-bailout-2d9ac36590ed
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mary Guillemard <mary.guillemard@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731531825; l=2836;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Heiust2lk2TQ7+75yP27aiVUP7Gcr7UNHszJsH/pVxA=;
 b=lzcwlYsBE4dnEtS4J1h0Wf/4iptqrd0IEJ14sGcSTgw5cyU8TenlSxFixHMkQZuQfYbk44Svk
 UYn5uJdkAWYB0zXWRUPHrMruK1IPz0rykyF1bF7/DSCL/HkIw9Syr6Y
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When bailing out due to group_priority_permit() failure, the queue_args
need to be freed. Fix it by rearranging the function to use the
goto-on-error pattern, such that the success case flows straight without
indentation while error cases jump forward to cleanup.

Cc: stable@vger.kernel.org
Fixes: 5f7762042f8a ("drm/panthor: Restrict high priorities on group_create")
Signed-off-by: Jann Horn <jannh@google.com>
---
testcase:
```
#include <err.h>
#include <fcntl.h>
#include <stddef.h>
#include <sys/ioctl.h>
#include <drm/panthor_drm.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

#define GPU_PATH "/dev/dri/by-path/platform-fb000000.gpu-card"

int main(void) {
  int fd = SYSCHK(open(GPU_PATH, O_RDWR));

  while (1) {
    struct drm_panthor_queue_create qc[16] = {};
    struct drm_panthor_group_create gc = {
      .queues = {
        .stride = sizeof(struct drm_panthor_queue_create),
        .count = 16,
        .array = (unsigned long)qc
      },
      .priority = PANTHOR_GROUP_PRIORITY_HIGH+1/*invalid*/
    };
    ioctl(fd, DRM_IOCTL_PANTHOR_GROUP_CREATE, &gc);
  }
}
```

I have tested that without this patch, after running the testcase for a
few seconds and then manually killing it, 2G of RAM in kmalloc-128 have
been leaked. With the patch applied, the memory leak is gone.

(By the way, get_maintainer.pl suggests that I also send this patch to
the general DRM maintainers and the DRM-misc maintainers; looking at
MAINTAINERS, it looks like it is normal that the general DRM maintainers
are listed for everything under drivers/gpu/, but DRM-misc has exclusion
rules for a bunch of drivers but not panthor. I don't know if that is
intentional.)
---
 drivers/gpu/drm/panthor/panthor_drv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index c520f156e2d73f7e735f8bf2d6d8e8efacec9362..815c23cff25f305d884e8e3e263fa22888f7d5ce 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1032,14 +1032,15 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 
 	ret = group_priority_permit(file, args->priority);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = panthor_group_create(pfile, args, queue_args);
-	if (ret >= 0) {
-		args->group_handle = ret;
-		ret = 0;
-	}
+	if (ret < 0)
+		goto out;
+	args->group_handle = ret;
+	ret = 0;
 
+out:
 	kvfree(queue_args);
 	return ret;
 }

---
base-commit: 9f8e716d46c68112484a23d1742d9ec725e082fc
change-id: 20241113-panthor-fix-gcq-bailout-2d9ac36590ed

-- 
Jann Horn <jannh@google.com>


