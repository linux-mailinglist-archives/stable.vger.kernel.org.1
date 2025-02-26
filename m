Return-Path: <stable+bounces-119642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53FA45965
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1D47A7B0E
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6921018A;
	Wed, 26 Feb 2025 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8totDbP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46E1A2C0E;
	Wed, 26 Feb 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560730; cv=none; b=TgFX8yJ5GgZC2lU6WlLozi91tjp+uFbb1tRE634cfWxpsZawfRyhHk+feYNUwQhK23d32fysgjWBsU82sa5H7TSKA/mgyegbv55Qgqb+NcFg0i6w4PiniPK6iSuAIwYi6rAgGOKKUNJgDMUYAkxCGMqLBBlDarCVTBshDJOU0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560730; c=relaxed/simple;
	bh=JYVd1OTFimZlMmj/OMKoN3U32JvtW/pbUaD9FKJgfhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIeOZVTzdQqQf9dWlcONCJuLofkO391LfOoElqBrTPOi8DYouodFJamQUKJCW0nIK7s97/wy3WqFjdcGHrygNuKpXb9KI5DC/Ewu+xBvTQaDt72xx2dLNxQ8HR3M6Jb2O8Y59pP1lC48gfP7elit584Slv4OPYrOGlKkFzDK2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8totDbP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c3e25658so15442155ad.1;
        Wed, 26 Feb 2025 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740560728; x=1741165528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYXJdYifFv8UK938F1cugEpkcZ70y4SI16ovjUtT/x0=;
        b=d8totDbPGu7ba/8SRqaGs5z/oPqtzYoRc0kvm7Xk6V2clNG28w965l3O3ZW7vW1Asg
         ikgHLo1kiPbmfzgysMJohVVxJr56T6njc60Cuj0yTU4lahePdCPE0bshklbuXQIbIM8w
         40XSoCVmUYIQiJj1J/K4cBuIyafKqvsUTri0Dns8chnBKI0StI7vKjcE805hwr0Zv8X6
         UVnw1ojz1gA0WxLHx/lipoQlTRscIUlpXifKwW8B7mIsgWPW6Ttbr5/ov6ukjC+IDaAk
         /Z6SXSy3e7VYMTanDEReNvgesdJDd2JsVrFhXxLAlfyf9/a1zZKUL8J3iFm0I+mBXirs
         TTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560728; x=1741165528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYXJdYifFv8UK938F1cugEpkcZ70y4SI16ovjUtT/x0=;
        b=QadWhvqkMkky0/lxanwbc18U8TPtktJKYNJnSA0iTl7siIb77Ytnfh1zvom5lm6wTv
         ABoJr84HkwZF5HFK+eFh+aGqGGj9xeIJ1TrvXXVZDlMTt8L357d9e+56oLI9UNkgogsk
         4W3hUXD1UlQLGkKRhhb6VnHt4Q7LKXUe1WtJ6f/69fGHwqtW4yquWsdTszC8AsQ978R1
         u+j6xA0e//b7jgCIH/MgBWG3ygAjn84quKYld4TwSjnFEGeDs1Zo9VOmKGSsu8D13ELG
         Jir6ZaAtHWxzWU9kU3Y9e/WWZTdLkxDC/8Xt2i6Px0aJ0WZ+8TX63UN9OWNvleSfRvbp
         ACfg==
X-Forwarded-Encrypted: i=1; AJvYcCUarSyiN16cTJzqIvRBgwqtec9E4RV2Y5zz2Zl8qtwKC/q09G+rJfIuyLZ6MxpHQ5CRBIy65/Be@vger.kernel.org, AJvYcCWFMQtBKpRcd8KQj3avvUKGr+d9PSvS459f8ID9g/5fZluZHRKB9Sx/+ijjn2udeOs69QmCB8mV/gUqSUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MuoO69yDSrMIy9miFNKsmBT313R5Oc389a9m/rPL/vh17rR4
	pHfm+hD/9khHODSwJT3blyNEu8DVuczOpLAnpT1jOUTUA2mfLoAi
X-Gm-Gg: ASbGncv238DxNvhglZzbPSEXJwaGk3NSbHPKyN0I17g6p6y5sZAa7ZJJnkKnhq/uHlr
	+G+oL/c8bCFwdDSPIXTq2RPABczTiaYPv1aNyTqbqLm2JmHhh59641rr/K6fz+qDXaFEIZ77xNp
	q+G6hpLTD1/EgfrHRd7DBB1YOXLYUNV8PwEBhdaq93MGlrbuBgJnpc/z8271lgTzDbukKX6G3mK
	QMvwIk4/8ljbC0NpdCw97lq+gqqV0SnnIbi5esmAZHCgcnOjyiHTZnJZ87UXRdC0MHGkjPd6buc
	+W+sZxqWOcs3pdOavkoCfcx0g9fhHGpdzXE30qbawA==
X-Google-Smtp-Source: AGHT+IElRARJT6IGSF3WnJ8KTS/H4EEWiKqM5dhHa8FhymY79x6pVL3/9XVsHpGNfAz4c3x/59PSeQ==
X-Received: by 2002:a17:902:dace:b0:221:7854:7618 with SMTP id d9443c01a7336-2219ff78bafmr120632325ad.8.1740560728362;
        Wed, 26 Feb 2025 01:05:28 -0800 (PST)
Received: from localhost.localdomain ([182.148.13.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a9c86sm1072998a91.9.2025.02.26.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:05:28 -0800 (PST)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH V3] drm/sched: Fix fence reference count leak
Date: Wed, 26 Feb 2025 17:05:21 +0800
Message-Id: <20250226090521.473360-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: qianyi liu <liuqianyi125@gmail.com>

The last_scheduled fence leaked when an entity was being killed and
adding its callback failed.

Decrement the reference count of prev when dma_fence_add_callback()
fails, ensuring proper balance.

Cc: stable@vger.kernel.org
Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
---
v2 -> v3: Rework commit message (Markus)
v1 -> v2: Added 'Fixes:' tag and clarified commit message (Philipp and Matthew)
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 69bcf0e99d57..1c0c14bcf726 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,12 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
-- 
2.25.1


