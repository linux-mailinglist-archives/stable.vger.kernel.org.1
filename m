Return-Path: <stable+bounces-167102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF96B21E77
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B11A23920
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988926A0C5;
	Tue, 12 Aug 2025 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GPamlzTc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE720C001
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980638; cv=none; b=L0NeFUhu12ayDQaZtKDQItcSc3IjWqTvWm19KTXZva/YsMimnQkdZ9q92/1NO9DcR+s+jlkobTsrLxuu1hKLrP2EK9eEAJ4VrhMNy3bxjC5LAELKmUyBS0ZCPWPrOE2CYBx0QgWGHEHb6Ip6j/f18hK38uBp1FC1akUnOsJt7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980638; c=relaxed/simple;
	bh=mYiBVXAo93QnGQS5BptwWusIUvuqnLn8pdDv8oIL01c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9glHO/9rkP/THpXm/di8X5Cx7mwpTSuBtRDUoRdWPT79IxNb0+NVrdYyCMFDhIfwBGfHfuzk6fGRWKIyCID3stQPYHChF8MsAhAIaiAPPKpRO9eh4SCo/4NxPkXHOMEFXoIv7zRHVM0cL4Wrnzwt6CDBaXUljMFc9QiYRK4JHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GPamlzTc; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-242d3ba2b44so18679545ad.3
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980637; x=1755585437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
        b=oB6o5tNdfvuwJkX0TvTN7zqGUwS1bGMZGPlfVAUXHQRh2itTrT6WxwOclSUO2ODVmL
         d7Gj1WQsqC+Sfkh8h8hEgOANZukNFgO6z/SLIC+Pm/SgsgHCq71Ruwpme9CPbIymkh28
         fjFE7PO8J6WpLJmSbRou62KoiuwiJRIWysgpuE9jxlUWpeFMnepsqP1A2fTQqneg0Njj
         m/oR7Bt0kVLC7X4Iv4M5ACdnpsVuMJFuh8cdg+dItE+H1ZspHT6KoIAYBk6ERBs/JVWS
         oUxHc3jNI8LUXBGEs0zrgPXX04lh518ELWddjDqLwVGma7lBKqvvWLJcL7X2Qm0cU6Xy
         aCsA==
X-Gm-Message-State: AOJu0YygNBoUPEeEOSWv+nPLphw4K3hoRvw70PjzU17cvrz/qhFz3LMS
	lzK05wbBlKqrRVoBJdH2MypET4lMCvnJRsGGXpdWNAqrwujzZ+ZJ46TmuWTsQGrx45MO8ugWGNM
	hbnwq/i/rEj5/LZ2e8MlPTfJWQk0p/ccx+qnRpCc0hu2izQ+8p7plazrsJpO2V1SoQ1c6W9tnYC
	V7c3kW8EfHXuDqPy2YyNKF9+I+vrlo+LpZDzOmvnvs155Hg1Ckkz85kdvpS8ADjScUevvVWykGR
	lidROlA3/+yWw0BCw==
X-Gm-Gg: ASbGnctdGJn5edSbnm/t+pZlfl2gH+v2QB9PXdsFXEzQo+X1TS3UPXgdrZxnCUVWUqa
	z4oPzejvz45ee6Ilr9ATOCyXcqCzVX8d5Rcwgg+JJqBQ/sKh8uZ99FHTN2oudQJ5d8QuHkw+Sxp
	lQedryMwT4ksC8sZCnmw2RmwzUXXBQMmOMaM4EW4J72Qqi93/wNCxkihWe/V/A6o/0i589ON1Jb
	3NA/OQ5d7FAAW1rf3uU65NFIiXM9kReib72Yz3EgJCrg1ZocynLdMIEtJSA4/hKAPcbOaeUF67W
	+sRruVfIjLQe54++1W49YerotSXKWDH+v5Cb3zRmOnCvoh+QpigVm6ER9bizUUau9orinOIqusk
	nDEIZ9OdWrhQe98FkUT4S/FpoJz34jEwlUmmYGbE8KGimlJr4XYSHv6BfrEcgPB0YVk5a0XV6H4
	/d9Gk9QA==
X-Google-Smtp-Source: AGHT+IFjF4yoFw5h0YE7aQm+4vAztNJz5E1mDjxHBH95DFEMmwQU6L/1raskeC1OKFkIy3Lt8geWUldpTDrN
X-Received: by 2002:a17:902:fc4c:b0:240:72e9:87bb with SMTP id d9443c01a7336-242c22228fcmr247358055ad.42.1754980636637;
        Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241d1ef5fdasm17207295ad.18.2025.08.11.23.37.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:37:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4af22e50c00so125997271cf.1
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754980635; x=1755585435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vnf9J8D/lbhMrAAVySeXBqauE+p5C7GABrpw1C+CN+M=;
        b=GPamlzTcichAUm85LGJQbNiAuJ9qGOl/6KPcke5zGApE4TlmcaYtLNF6bz0cvsPB00
         JiOGxreDqCa/98DhRREJ2kBe71XvpITpgBZ/P/cYcmbGSkqYLIOgeH9L4VuQoSMaW8BS
         sAk8akiRNWE94yl/Fd9YBj1nSVRHaBArrjOSk=
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b0aed86506mr214214141cf.59.1754980635158;
        Mon, 11 Aug 2025 23:37:15 -0700 (PDT)
X-Received: by 2002:a05:622a:3c7:b0:4b0:641a:ddde with SMTP id d75a77b69052e-4b0aed86506mr214213721cf.59.1754980634597;
        Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b095e6c7d4sm85319621cf.54.2025.08.11.23.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:37:14 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	sunil.khatri@amd.com,
	srinivasan.shanmugam@amd.com,
	siqueira@igalia.com,
	cesun102@amd.com,
	linux@treblig.org,
	zhangzekun11@huawei.com,
	andrey.grodzovsky@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Guchun Chen <guchun.chen@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] drm/amdgpu: handle the case of pci_channel_io_frozen only in amdgpu_pci_resume
Date: Mon, 11 Aug 2025 23:23:49 -0700
Message-Id: <20250812062349.149549-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit 248b061689a40f4fed05252ee2c89f87cf26d7d8 ]

In current code, when a PCI error state pci_channel_io_normal is detectd,
it will report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI
driver will continue the execution of PCI resume callback report_resume by
pci_walk_bridge, and the callback will go into amdgpu_pci_resume
finally, where write lock is releasd unconditionally without acquiring
such lock first. In this case, a deadlock will happen when other threads
start to acquire the read lock.

To fix this, add a member in amdgpu_device strucutre to cache
pci_channel_state, and only continue the execution in amdgpu_pci_resume
when it's pci_channel_io_frozen.

Fixes: c9a6b82f45e2 ("drm/amdgpu: Implement DPC recovery")
Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ff5555353eb4..683bbefc39c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -997,6 +997,7 @@ struct amdgpu_device {
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
+	pci_channel_state_t		pci_channel_state;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40d2f0ed1c75..8efd3ee2621f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4944,6 +4944,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	adev->pci_channel_state = state;
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
@@ -5079,6 +5081,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 
 	DRM_INFO("PCI error: resume callback!!\n");
 
+	/* Only continue execution for the case of pci_channel_io_frozen */
+	if (adev->pci_channel_state != pci_channel_io_frozen)
+		return;
+
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
 
-- 
2.40.4


