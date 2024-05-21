Return-Path: <stable+bounces-45503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5E8CAE19
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 14:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF40A1C22082
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D67524C9;
	Tue, 21 May 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SG6J3op7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBA1CD20
	for <stable@vger.kernel.org>; Tue, 21 May 2024 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294176; cv=none; b=IwaQhLApURnOXY7PmWe0YYvao8qyHPqOlpP95m6vTGaRC4KflCXegt0MpsNHkQ/VnL8YsrTWSqCC5ijL1D4n0REbKX8n0lIx6d75YwUzB2+PC1QZBXUp134dqO7Z4GOxggqFpXovX211N2EAwrvEQymgodvfXNGG2AzurgLrNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294176; c=relaxed/simple;
	bh=1v7YJ5kteFc0Fy6/mxujwV17RuJsj1QH8x0kJwqjF3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVDrXsuulv4L9wAS8wZQlZFH3dvD88iKN4BgErJoNtYouIx+6EQmPoeFwICs2JLQbrJM2nq+bu3Zrno08Iu5kwGWnMIWfGcPsJInlzUPbjzD3F+dxCjnuV9+cN5VskWySZzA8fasE+sha4aJ0QzX7f9pf8wzdTJOd9TqThDtNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SG6J3op7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edfc57ac0cso762765ad.3
        for <stable@vger.kernel.org>; Tue, 21 May 2024 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1716294173; x=1716898973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NABc579krtp5xFJpNBbYQDKZU3ByCAtkrEpvI0Y6Eas=;
        b=SG6J3op7EsAMYtGUPWvd/TZ8DcYmoaDjW2Y41k1w40iz1fC+MB7Bu4RQThdER/ELCh
         Qh3ULYe35DLKEuYOW3ZTs+cmKbVzydpV1LYVq6PW7jCXVvKjAu0ak2jDTcojCCQmUZ28
         SCc4N5jRZaFtwuWMZ+98VBnH6hz1/zAzdhz4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294173; x=1716898973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NABc579krtp5xFJpNBbYQDKZU3ByCAtkrEpvI0Y6Eas=;
        b=fXO1k15Nb3eYACC1H9JeCNWYcwNy4v5VF+HP/CXfJp4jc40nK8T9ImwRj1gv8HFjHH
         OxiCPpncHM/J5ma+ZU95zt2INE4RUeJ+iNpyLENrbrsipaDYHxwLdOv4X6b2Bl816QCN
         aR8ZgGEJlAkpUdteisj3kyG97/691dIVO9/1H+oj/Fa5BqX52ADccPcFD/i+e+KP4YVd
         Ur/6C5fN3oCquMU80V09GC029VxhygjPp2SaBE7K91HKqYoNQ/neXSL9QHsc8MSp/L2d
         mVOqGfeN9GHE7+xsP9Vt5gjYnzZUDOHp+SwHQTJr4/fa4YXnz7fGRWFCUD2Pw01gS09k
         jkuA==
X-Gm-Message-State: AOJu0YzHUwVPtl6tnmrC7Q/Vv8QZ47NIy3VV3i8CzP/J9lb0qUGCPbzB
	ApW4KwWqUbuTQ/sNt3XahFfVudZpiIIyWr2pw79HGzZXFTwfFkPRVFTitwhsiMf86uYneVfVds1
	43H0tpWkTuw3saJHw4tbcq/wVw/aqwzTX5k67AZuna6O8NhlYXwdfWqC69y24t4LCXsSmUunwln
	Uw4QilFI72x4eq7e35WrKPWqPluoED2LH+VGiDRTho
X-Google-Smtp-Source: AGHT+IGRLqXUsglUspBavaa0TrZsdNvl9QVsL8vu5lRT9HNu+KWcTmoAcwjCNHYzdTgUTtReNwFb7A==
X-Received: by 2002:a17:902:784e:b0:1eb:3daf:ebaf with SMTP id d9443c01a7336-1ef4404a932mr273407495ad.57.1716294173345;
        Tue, 21 May 2024 05:22:53 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31da2sm225873485ad.165.2024.05.21.05.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 05:22:52 -0700 (PDT)
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
Subject: [PATCH v6.6, v6.1] drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()
Date: Tue, 21 May 2024 17:52:21 +0530
Message-Id: <1716294141-48647-3-git-send-email-ajay.kaher@broadcom.com>
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
       as amdgpu_ras_query_error_status_helper() not present in v6.6, v6.1
       amdgpu_ras_query_error_status_helper() was introduced in 8cc0f5669eb6]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9fe2eae..a1a65d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -974,6 +974,9 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!info || info->head.block == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	if (info->head.block == AMDGPU_RAS_BLOCK__UMC) {
 		amdgpu_ras_get_ecc_info(adev, &err_data);
 	} else {
-- 
2.7.4


