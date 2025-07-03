Return-Path: <stable+bounces-159575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616BDAF7956
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A433B20C7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83D2ED157;
	Thu,  3 Jul 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkThwGxC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A7F126C02;
	Thu,  3 Jul 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554658; cv=none; b=CxRL0qd/VpQT8KiMLSkARWUTUMxUg7D+Tezlt6DTxkf920H1XLWmGV+jzntFLKNdoxXXIOA2Rn2ygRj0/Fe8dwUi0MHwl8UFKMkpKasutogLXL171n81RmwymMlJuNRH7yKnLco32cCryxsGBTcxsfFE3O83qBrTy1kiHFZbxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554658; c=relaxed/simple;
	bh=dGkZO9Zut3gVwIkATXj8E700BvNvPi3ZVq+QZ53nipg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwUq5Y0i8qxyDcpXj5bnubmx+2/Anj+AOA7nN+laHBR4B5aToeSXpo2E2DHspFmEZbhZ1zToQBOY7yd+5zd+PJuP+C5a4OzP1hnVMoAggiE8VoCcLDspFkmF0bplkjgsbgTaMOgOiWBQcKrjnNTPL6iRbwshiTLXVx7V2wmpeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkThwGxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C898C4CEE3;
	Thu,  3 Jul 2025 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554658;
	bh=dGkZO9Zut3gVwIkATXj8E700BvNvPi3ZVq+QZ53nipg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkThwGxColy+ak1DB4GYsN1iqRfkSBylXCArBfrEhnulzL4rmW0XW+EGphPdbTgro
	 3I1glEejcFDhVG9Wxw9Drv9CUewtw4iiR+EO1C18xAeqsLbr+6d2aDF6fCzJoqxSab
	 QEzRPXboHaSyWFI5WYWcxPPVtCRljAhCF20TRFcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ruijing Dong <ruijing.dong@amd.com>,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 040/263] drm/amdgpu/vcn2.5: read back register after written
Date: Thu,  3 Jul 2025 16:39:20 +0200
Message-ID: <20250703144005.910922951@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David (Ming Qiang) Wu <David.Wu3@amd.com>

[ Upstream commit d9e688b9148bb23629d32017344888dd67ec2ab1 ]

The addition of register read-back in VCN v2.5 is intended to prevent
potential race conditions.

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3eec1b8feaeea..58b527a6b795f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1158,6 +1158,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1343,6 +1348,11 @@ static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1569,6 +1579,11 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1635,6 +1650,10 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.39.5




