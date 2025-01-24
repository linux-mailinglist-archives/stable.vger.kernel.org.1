Return-Path: <stable+bounces-110352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CAA1AF4E
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 05:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FF9163266
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 04:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83761D7E4C;
	Fri, 24 Jan 2025 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaypUXGA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFD1D79B4;
	Fri, 24 Jan 2025 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691730; cv=none; b=Um5/mmp9HMleFbVko5+giKfQ6JXOQj9DwMX0NW3RLPa+/MztgaW3CscXk6318lyA92g/vM2zjQ25L23hlwibGoX+7/ijpAH1C8byCqrgvDzZcIEs91iSZcMdLXftb3J2/J3CxO9rO85/Y33qEe+40Vc9jA/D9faNy3PgWCpPF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691730; c=relaxed/simple;
	bh=CEX9iTnWVwmw7wHb8BwrgfBevsuzLYRxQx14siwDqvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5hfZTWVPTC0jZhEetfe1ZPyVBpcerxt2PpjeXu2UYmAK8uXtraVylXyqVqMmBAP20RmgR3X4dmhHx6zLlLaIbxT9cZbmc62k/Col3gSVUgu9p0c9nwk4OpmqZ7BiewkDw3va32OrX4+8TXmQ5ZzCy9KAbWFk6qlQuF6dp7Sdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaypUXGA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso3100164a91.0;
        Thu, 23 Jan 2025 20:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691727; x=1738296527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D6e6R/iD1t4ReAa9KfZ1qSPqX0t3TQNshzKeYKkD9yY=;
        b=QaypUXGAWMNXBOK54kPLbfjPWO8jgkfA7gwB8m2DA2I5sUL8vcMNmKIENpbpqntbtY
         wUFSfhBFR0SUe+7pKsZhgqpfV+VdRjg/so32NNeG8lzg3q7rVBok8BGhOAOlB8OqBkBM
         vs2F5pcPXHp5XxMvop9kGMx9WzSW8JUwTOFozjB94QEcFFHOa6he+UEs90utXDMIxfoU
         XejSjY91/XTr09kRYzztiXTqXmmQzbgn8PUnm40waVB2SlTuPIj7DGQQvOJNmwbNl+Dx
         nBvXTuADVuGGVurZERIh5/elkSjlwWqcz9qy+GxEJOVeBTgDhjJLDDvvC6rWBQeusTrF
         xQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691727; x=1738296527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6e6R/iD1t4ReAa9KfZ1qSPqX0t3TQNshzKeYKkD9yY=;
        b=XwH1uAhPU+sV1YKy5oNNADG+5+ZHrybHO2yfW3qk1xoXONmcxAhZ5Te4RbhVzMXx/2
         0/Xd2Bz3fA8txc9jOzAjS76HPa3g0j+nR5MCcD64lh6TWRZoylz5dfg4pbofZue304rz
         nSo3KIV789llixfIkheh+5QoBcMOKFA0LXvaB0IE12HpJMmCq+S78JC1WLqbsxo7wzF5
         hKJxLHVctnBu3KphzWnAmFSor0s9MuZqahuqVoR/+Xe/6LniVfHYgyu9zt+FiXv+w1tP
         P0KyaUviYwuD8EBWs92fZ7ccQHj2j4cHJwX9Y7dcM3SwK89MLcsZboOnTDG9TfwOnwUh
         wxkg==
X-Forwarded-Encrypted: i=1; AJvYcCUdr606mFLPoBcUDpCl+y9F9N01QlQ70+3pMwFvL4keW8nEqRmFV4gMWN4YLRRJ3Xcd5wBkehEdDA44xQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwH/8hiNyJRuooaLpqAkLq9gjMScjL/ryaaAhem06ah2OigsDp
	ryXOqXNTWHLsfcMJ+NewDzYllnC8tIMx6MEO1L4VgKAxvc/s99a3ajLRnT3OHUSq/g==
X-Gm-Gg: ASbGncscxatae4sAmqraXPllTG+23/vyQDZMlkXCnFptgQ3Zc2tAe87TDxV0VlwmFxM
	Zce81tJkiUo+jVWNrH5ZnI28TeDLw+1aH2EsAOZ9Sx0jcYfaR5M19Ibw21sScoyVEIh/3fZt97N
	te28aJMnIOTN7Nsny9hHoKx0FPfDbh3enz7Rclp4y1OzuM668Oh08fL95U226mGmfzt3CvpLvmE
	P1kiwnsq+mOBtgC0JjS7edkLpHW064KcU9arySxoufyru/F9bgoHaWeGxbWexTZWuCN8sdbrv8z
	fKn2dEqXBjEXKoLsKQxKgs9Fiwc3/JC5pt5FB53r
X-Google-Smtp-Source: AGHT+IGKwqK3FeAP7M3pDG/EPu8XOfZtrxx0RtjPTD4kt8b1n6567njef2h1tCvlNFusMRPQtdbLkw==
X-Received: by 2002:a17:90b:2808:b0:2ee:d433:7c54 with SMTP id 98e67ed59e1d1-2f782cb61bemr40425091a91.19.1737691727590;
        Thu, 23 Jan 2025 20:08:47 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.59.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa455c0sm562670a91.3.2025.01.23.20.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 20:08:47 -0800 (PST)
From: Imkanmod Khan <imkanmodkhan@gmail.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	alexander.deucher@amd.com,
	daniel.wheeler@amd.com,
	mario.limonciello@amd.com,
	josip.pavic@amd.com,
	aurabindo.pillai@amd.com,
	sohaib.nadeem@amd.com,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wayne.lin@amd.com,
	sashal@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	charlene.liu@amd.com,
	gabe.teeger@amd.com,
	amd-gfx@lists.freedesktop.org,
	Nicholas.Kazlauskas@amd.com,
	Imkanmod Khan <imkanmodkhan@gmail.com>
Subject: [PATCH 6.1.y] drm/amd/display: fixed integer types and null check locations
Date: Fri, 24 Jan 2025 12:08:36 +0800
Message-ID: <20250124040836.7603-1-imkanmodkhan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohaib Nadeem <sohaib.nadeem@amd.com>

[ Upstream commit 0484e05d048b66d01d1f3c1d2306010bb57d8738 ]

[why]:
issues fixed:
- comparison with wider integer type in loop condition which can cause
infinite loops
- pointer dereference before null check

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser2.c   | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 4d2590964a20..75e44d8a7b40 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1862,19 +1862,21 @@ static enum bp_result get_firmware_info_v3_2(
 		/* Vega12 */
 		smu_info_v3_2 = GET_IMAGE(struct atom_smu_info_v3_2,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
 		if (!smu_info_v3_2)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_2->bootup_dcefclk_10khz * 10;
 	} else if (revision.minor == 3) {
 		/* Vega20 */
 		smu_info_v3_3 = GET_IMAGE(struct atom_smu_info_v3_3,
 							DATA_TABLES(smu_info));
-		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
 		if (!smu_info_v3_3)
 			return BP_RESULT_BADBIOSTABLE;
 
+		DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_3->gpuclk_ss_percentage);
+
 		info->default_engine_clk = smu_info_v3_3->bootup_dcefclk_10khz * 10;
 	}
 
@@ -2439,10 +2441,11 @@ static enum bp_result get_integrated_info_v11(
 	info_v11 = GET_IMAGE(struct atom_integrated_system_info_v1_11,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
 	if (info_v11 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v11->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v11->gpucapinfo);
 	/*
@@ -2654,11 +2657,12 @@ static enum bp_result get_integrated_info_v2_1(
 
 	info_v2_1 = GET_IMAGE(struct atom_integrated_system_info_v2_1,
 					DATA_TABLES(integratedsysteminfo));
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
 
 	if (info_v2_1 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_1->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_1->gpucapinfo);
 	/*
@@ -2816,11 +2820,11 @@ static enum bp_result get_integrated_info_v2_2(
 	info_v2_2 = GET_IMAGE(struct atom_integrated_system_info_v2_2,
 					DATA_TABLES(integratedsysteminfo));
 
-	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
-
 	if (info_v2_2 == NULL)
 		return BP_RESULT_BADBIOSTABLE;
 
+	DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", info_v2_2->gpuclk_ss_percentage);
+
 	info->gpu_cap_info =
 	le32_to_cpu(info_v2_2->gpucapinfo);
 	/*
-- 
2.25.1


