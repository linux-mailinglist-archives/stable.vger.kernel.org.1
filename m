Return-Path: <stable+bounces-45501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2068CAE17
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E291F2335B
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC1524C9;
	Tue, 21 May 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UciPErUs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D01CD20
	for <stable@vger.kernel.org>; Tue, 21 May 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294160; cv=none; b=p9u2mAYBzjmAnA1MtX/dNr8rLEPGj3bzyk+rD4yWgdOSdZGsR9ulQ0tHLSdWXSnBjTecpR9dOktgpDByP5/HPMiQAfWjbMXaJ74x562YVJmSmvVEfUPqtyoUhzePQEHsW1pqH0KVEpwHlvZk3RlUBhSZLqvY1ZhWvKW9ro+35VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294160; c=relaxed/simple;
	bh=JLbgghzY1mJq9Hc1l1auGJYzpsIggp7sNFb84VZ7adU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j2+hcUF577nDLm9dCI/FnkATIP6YZJJsMddVn/iK4OecpJxxIkOgd4pMYojYcW7PaWbBAsFiQ3h/ryjbe/CPCfym4k8/1N2lG9hIA2G5ZtJazEMtqT2WAwk26pAQBSIPKz3TVkpZZGAfY/0YCkh4QYd/kdN+jSq+n0++Y5J2gdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UciPErUs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1edc696df2bso779915ad.0
        for <stable@vger.kernel.org>; Tue, 21 May 2024 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716294157; x=1716898957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xarA3hqV44kgRif+8XSWqnvW9KILIkSaq+8s2S9i7+g=;
        b=UciPErUstCYpneqM8jlrheYGmYA80KXx9MqRyMGmTMm2LVR2e0bQ2lqTkqjb5F+nQu
         5cCbiUnWjrUzjUihZ7A91JzO7u1UaV/1keVHJmyGj+NIVTGy+/oqAzW5eHvfWqA9gqQB
         45FS77BgcMIMYl5gd2kmu2/n1Ga7ulpcymxYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294157; x=1716898957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xarA3hqV44kgRif+8XSWqnvW9KILIkSaq+8s2S9i7+g=;
        b=Vjru9TS15ENCGCnYTEf3ybZc+UNeDVa8lGeRM+fMCfb4gBFrbjvR+5nmtE8CXaJJkl
         A/x6L9gWZVaz6KZ3kjHkIJfDcPOBxuobpvtIFRjmS/3+++K6saHRXvv1wgpAlJd8JTSi
         fZ3obh338PS1jq8SGuSn5Kbp2gpx+hg740dRDLqTsy1zZ94puR6URcuJBuJMknan3Xvf
         oie98pQ53v49r0pcC1gr3ZdUeus3DLsSJrrvZov+EZBL1b8VCeG6YhQGkCEy3byIke4O
         bIG4UdYaoqXnCQNKhqwpboERtPQUGEFuT+UW1uiRf2FvK6qDDLyGrOQNEPqbw/fkuC/G
         UtPw==
X-Gm-Message-State: AOJu0Yz7ZoiLYmytP7hOZPUzf+pwZHMov0JX+L+9xabHuHTWzEdqRDxh
	FpaBp1qT89QXBvi1M58c/X8yICtMUWXxDom3cuKJ28r9RIzpEG4XbJVodCRGIjsr9miUeBSbyJW
	xCk6Uc91jae9sldArpuPjWLSzikIhTiI39CNVt0OuP5wXT5MFpMQqRjMloUZvG6xfVK1AAL3gwJ
	fLDMjtDoEVMkaUUqhnddbb8/BZ+rn3AXJn6D13Eg==
X-Google-Smtp-Source: AGHT+IGqW/5EFnO7khPQ2gJCAHo/U6uNX/1X0P4ct/6/MzPqYJvm0sxiBgDn1Ff5gf1PeiW9mRzI7Q==
X-Received: by 2002:a17:902:9a4b:b0:1eb:5b59:fab9 with SMTP id d9443c01a7336-1ef4404a1admr316358305ad.53.1716294156921;
        Tue, 21 May 2024 05:22:36 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31da2sm225873485ad.165.2024.05.21.05.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 05:22:36 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5.10, v5.4] drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()
Date: Tue, 21 May 2024 17:52:19 +0530
Message-Id: <1716294141-48647-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit b8d55a90fd55b767c25687747e2b24abd1ef8680 ]

Return invalid error code -EINVAL for invalid block id.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1183 amdgpu_ras_query_error_status_helper() error: we previously assumed 'info' could be null (see line 1176)

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[Ajay: applied AMDGPU_RAS_BLOCK_COUNT condition to amdgpu_ras_error_query()
       as amdgpu_ras_query_error_status_helper() not present in v5.10, v5.4
       amdgpu_ras_query_error_status_helper() was introduced in 8cc0f5669eb6]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a8f1c49..e971d2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -765,6 +765,9 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!info || info->head.block == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.funcs->query_ras_error_count)
-- 
2.7.4


