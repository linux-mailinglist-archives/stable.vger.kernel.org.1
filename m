Return-Path: <stable+bounces-143732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7124CAB413C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB33A7D4F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2C255235;
	Mon, 12 May 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2TIK14N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F381EE03B;
	Mon, 12 May 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072901; cv=none; b=KdhNZwvLCM5fUXYKtcAfQeodzQdcrT03vt1ovGEXx0hlRCUCyyVLIzOp0jzFG1tXG5lJsRXYN7Qo/1rkbD1bwCQImQC2tMtyRIjZp0ZEnnMMUrqvN1ViPWs7aq9XuVQDxjuFpRR4nF6YDYHpkZ/e4zYPaA9ieH36wAUbxHatSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072901; c=relaxed/simple;
	bh=/86slEzPlnv/J5InxIn0cd+qpxDuARPknkWd31uR46s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3+Up1IbSeoInMNn9VrP/8TWRL81KKT4GgFtLRh8wHcmEwAIkIH3/jdD0yovikbtNL/sdd+sUvdxlTtOqUUfterCzbg8kOzEvrjAHt4oYKtwPOb+cE6E4mpYJdLLjSt06wZzPlB5XMcjxOlNgtalYt6dQRa/yr9NTnZPtSsKugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2TIK14N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0DCC4CEE7;
	Mon, 12 May 2025 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072900;
	bh=/86slEzPlnv/J5InxIn0cd+qpxDuARPknkWd31uR46s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2TIK14NckJq3O6AqXfDFLWsG4zxB9Eui7DsZ8UkZn+TQY5u8pQ1V2S4ldPg6LixR
	 ahIDlqmNe1cnTDMnKWKQ9KYVEWgFsCPaOjyihitSKtNkXSDttlRoBGRn34y3pfBH7R
	 dZv6XczXTIOKbkDqG7vjF8w59TquYTKhACUtYpKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 090/184] drm/amdgpu/vcn: using separate VCN1_AON_SOC offset
Date: Mon, 12 May 2025 19:44:51 +0200
Message-ID: <20250512172045.493498870@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruijing Dong <ruijing.dong@amd.com>

commit b7e84fb708392b37e5dbb2a95db9b94a0e3f0aa2 upstream.

VCN1_AON_SOC_ADDRESS_3_0 offset varies on different
VCN generations, the issue in vcn4.0.5 is caused by
a different VCN1_AON_SOC_ADDRESS_3_0 offset.

This patch does the following:

    1. use the same offset for other VCN generations.
    2. use the vcn4.0.5 special offset
    3. update vcn_4_0 and vcn_5_0

Acked-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5c89ceda9984498b28716944633a9a01cbb2c90d)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |    1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |    4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |    1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |    3 ++-
 8 files changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -66,7 +66,6 @@
 #define VCN_ENC_CMD_REG_WAIT		0x0000000c
 
 #define VCN_AON_SOC_ADDRESS_2_0 	0x1f800
-#define VCN1_AON_SOC_ADDRESS_3_0 	0x48000
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x1fd
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x503
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -40,6 +40,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0						0x48000
 
 #define VCN_HARVEST_MMSCH								0
 
@@ -575,7 +576,8 @@ static void vcn_v4_0_mc_resume_dpg_mode(
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+			VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+			adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -44,6 +44,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0	0x48000
 
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0						0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
+#define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
 
 #define VCN_HARVEST_MMSCH							0
 
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -488,7 +488,8 @@ static void vcn_v5_0_0_mc_resume_dpg_mod
 
 	/* VCN global tiling registers */
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+		adev->gfx.config.gb_addr_config, 0, indirect);
 
 	return;
 }



