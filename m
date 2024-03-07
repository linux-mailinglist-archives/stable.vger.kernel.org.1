Return-Path: <stable+bounces-27109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888987568D
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 20:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9EB2103B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E2135A61;
	Thu,  7 Mar 2024 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b="dU/pITdt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18B84A2B
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838294; cv=none; b=h6reMRRnkuQRIRaF9nJoy24rfU8xDdgf2F0lQ7kz33lb0FcCQ7lXTGeZQF7/cnuX6igozqgAJSk7eExUfGasU0UGritJbJ0dPbGvxzB18n4Kz4W2APjo1g40O9p680MVNHYpoAwwXyvSYAQpgt3tO38oISOmi4vH1GXGG0EAems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838294; c=relaxed/simple;
	bh=T2uhlE8JbeMiLMTuIygpyzn9VM4bV10WmCweCtQSNkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KuBjKCfMvJn/m7DJSw035VmM3f/6rEp/9N/RX46zCJc270jyGKG6a4XrsEEXY0UermiBcvKTiOQH13D3DJ7Re2f0tUXXXS8WcIKVK91WiFFBko/1RFsyI8/5N2NEuzByttiGxFBM7Mg3A0OR8FQa1PKVue9RDpLqtoeq+KePjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (2048-bit key) header.d=froggi.es header.i=@froggi.es header.b=dU/pITdt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so900430f8f.0
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google; t=1709838291; x=1710443091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IujEeWp48Yow5VwuItpdeDL7053jowuL8P5RXX4WPpA=;
        b=dU/pITdtW5MNRqf/kZskpY16dj6Q0NQ10QiUNgy7TEFzdAQBg7QWPPDiQ3wfUVbfig
         KmLpTssZB1/YQTrIKV1ZjIvLeIOeQjuwWNgBTBF0jCFrmZcYNIDSfM0rPLLl2vG+EoVI
         YXD14Mev5vQnsLPyAWIz1ZkncPxwWIbcnKweKW/iDaehSvbZ1s31jGO8uiwWkhjdM4m/
         CyYHirRF6dzgaQ88RyJEDNgrc1RuWJRXk+kgyQu+NzAxnUH53pOdhE3vj7YEEOoi6UuD
         8HLzq9XtCobdpx1f4LHibGEdcjp8XvoAE8kWswLvpP/aO3nMOUnn3B+FZoAlUX4wzLxX
         M+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838291; x=1710443091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IujEeWp48Yow5VwuItpdeDL7053jowuL8P5RXX4WPpA=;
        b=W1jbh4ttbFMO6AKpoXo7qhkZwHPGi0hAK9vxtXUF0kDDwglIJiXHYjisImEYU76pV2
         V9s0cAUw626aImXfTyRkmrUN+UV28VFVEMLLu4euN+MJnViLQTWbk4f0MJfU0NE10GdC
         QvtlrQn4K3MElExUCzAEwBjvPar0erdA3h+46pVkuByKum0WMUP0yVj7cxR+k6G14r+7
         tMEjJgVAYHP9EwRSK3akVDbsXEOYNCcE5r5SGSoF3dDSgnyS10H1SFg/plUvtsT9S6kD
         pAUhaSKNpo8sjQHOTLZCP3RSqZrqyMvsWZPVrVfGVZgT083H/VcxQuinrmedkgmuKcA8
         U4wg==
X-Forwarded-Encrypted: i=1; AJvYcCVK3stG8aZiqN4Bu4xHbOQnEC3mPv6P+B7NQY0XwuRtU+graLeSj/BMRjg/DR9JIUDIBDzC/65MqZkhLBxEDloX+aydcQuC
X-Gm-Message-State: AOJu0YzSQOWvdhrwUed2BGQTQR/lRPJwIusNMIq6PMqxtiJenkOdrZgZ
	4dCHOlLsjn8kmXeJSj5iDD+f7zG5o02TGPsi0WTIFM+3O5joOvsrqgMWwOvD4Go=
X-Google-Smtp-Source: AGHT+IEpLv4zX3uKGqCEeNnpYhUk7MLG/Vb/rhFeLja69jyu4o/rXvMNskBKHfq9LxPkbKlG7u8iaw==
X-Received: by 2002:a5d:67c6:0:b0:33e:5fb9:af1c with SMTP id n6-20020a5d67c6000000b0033e5fb9af1cmr2434433wrw.59.1709838290926;
        Thu, 07 Mar 2024 11:04:50 -0800 (PST)
Received: from localhost.localdomain (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:04:50 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
Date: Thu,  7 Mar 2024 19:04:31 +0000
Message-ID: <20240307190447.33423-1-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As we discussed before[1], soft recovery should be
forwarded to userspace, or we can get into a really
bad state where apps will keep submitting hanging
command buffers cascading us to a hard reset.

1: https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es/
Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4b3000c21ef2..aebf59855e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	struct dma_fence *fence = NULL;
 	int r;
 
-	/* Ignore soft recovered fences here */
 	r = drm_sched_entity_error(s_entity);
-	if (r && r != -ENODATA)
+	if (r)
 		goto error;
 
 	if (!fence && job->gang_submit)
-- 
2.44.0


