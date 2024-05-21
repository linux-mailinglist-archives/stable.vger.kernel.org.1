Return-Path: <stable+bounces-45502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3278CAE18
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAEF1F227AD
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8B524C9;
	Tue, 21 May 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DYM6x1R8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFC1CD20
	for <stable@vger.kernel.org>; Tue, 21 May 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294168; cv=none; b=ditSXOOatKrJG4Mj/DnAHmX0i1cKb0s9UwKFKUg1R6F/62g7xSfIxd9BeLBqQt9LBggXSCiavaBiy1WnDcGdB8wg8KXtRUXaBvKT7tHDHIb3DtNBPKY9qEBYtW5zGoo0n1EKVDGg9/dX7Tw8eNFw2dmaGvEoKi4De8i3zCkdMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294168; c=relaxed/simple;
	bh=UBLApKcf86OJs3xUsiy5MpXgoqtsRxwdmyqzdjZr4zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIKm790sxv+Jd7AFzusidIkgh9mA6lkOymYz26uD5ys+dy1KCL+WXqLyABZT5yWrlelfq9U7jVhVvmENBJvcqbqCgyETnekp0Jjh2aWzmxr60yrqhI4SEQz7GOgvlwLqlz4gMDbOGXthrwWBDImUkhplJ+j7Ph9PquoNwlfbPtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DYM6x1R8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed41eb3382so833565ad.0
        for <stable@vger.kernel.org>; Tue, 21 May 2024 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716294165; x=1716898965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG48Uxqe2EzhPhs8a2Xg8oGtJjKSEgVKXW6F2oT8BxQ=;
        b=DYM6x1R849MV0fXkhS4B7Lb0+u9inE0OKv/9wJ1Ducb6eINE/UcyLpIhVzw5RkWD9f
         i+YAiRX3xg1kaLd3X/8pKocjKGcaDk+WU11uC42B7f75oTK9HlLeEYHejIQKBf7G7Dj3
         2zDsfWBVF7afBwcz2QCXqSjzhMHpGidDrcPUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294165; x=1716898965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG48Uxqe2EzhPhs8a2Xg8oGtJjKSEgVKXW6F2oT8BxQ=;
        b=Uh437IkMsitqdOVG90Ahv8ilVFQ1tmbZ4IZEnTxAlksQ0VWdwMRPg3DLNMMiUinuVe
         D4HxM8aD+imm+U7+/64hxiNOV9cA0xOdIyYEeWW4trqQHUvx8rR9h7jCuqnx8SjOS/9A
         Iz05FYBI15rKGYx9R/22nk+XnKYrbFhXd+GQWkEH2CcK2gyF7jUdDNfBlvmTHN/EhAx0
         jtkP6zdAG5jRryzXijYrjd6MDquM9POEaM0LEEYp0iawNNn1oxvG2iz7Yi5QjY9PiUgz
         bYOungmd3w/iafSZJOKBSug4vkW70w7PNSrzs9EK8PiaOlfW/xo8Z+lCjcw7VldwWl5X
         BHtQ==
X-Gm-Message-State: AOJu0Yx3JnkRH4SWXyr+IqL8cs/ik7r+l3+1fNFemlRdvhrJgc6rHfzM
	HBqDA9Y5cfdhrhLd3Zy/n3emBv4i/hdgS7SoFaS9l30u5YWdpsPYeZHAlphWmiuKdyOz2NFC2zA
	JSR27ju6s/ysOlORk2ibCjOrD4vq86j8NAqmUOvsXtOYKEtWjZzQHmQpDzQ1l1V0DW6yPQgi85c
	3Hn67Qmn2MDRT0QewVUwBCGjgwlIyGnayCvviJIWLN
X-Google-Smtp-Source: AGHT+IH87L940uNbvtOKOhGB9+HNRB/YdZWBHcUEwLLR2DJkD1uALNG1m9dqnQR38m/YOcL4VnurdQ==
X-Received: by 2002:a17:902:e5c7:b0:1f2:fbbe:bed9 with SMTP id d9443c01a7336-1f2fbbec48dmr94534505ad.15.1716294165171;
        Tue, 21 May 2024 05:22:45 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31da2sm225873485ad.165.2024.05.21.05.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 05:22:44 -0700 (PDT)
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
Subject: [PATCH v5.15] drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper
Date: Tue, 21 May 2024 17:52:20 +0530
Message-Id: <1716294141-48647-2-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716294141-48647-1-git-send-email-ajay.kaher@broadcom.com>
References: <1716294141-48647-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit b8d55a90fd55b767c25687747e2b24abd1ef8680 upstream

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
[Ajay: applied AMDGPU_RAS_BLOCK_COUNT condition to amdgpu_ras_query_error_status()
       as amdgpu_ras_query_error_status_helper() not present in v5.15
       amdgpu_ras_query_error_status_helper() was introduced in 8cc0f5669eb6]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 439ea25..c963b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -820,6 +820,9 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!info || info->head.block == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.ras_funcs &&
-- 
2.7.4


