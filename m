Return-Path: <stable+bounces-168291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B985B233FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438BF7B8A7F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F02FD1AD;
	Tue, 12 Aug 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GANIsmQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E2EF652;
	Tue, 12 Aug 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023683; cv=none; b=VaZim1ihJp++9tRVDFgrCCJulsqLyf3LsLgNFS5BSJHQykkoEyzAb0wkucoWNqqKVmzUg5lCZIzaO+EtjrifOkBBtSCFmClQKqY9shvCxWW3tHxSKhGbvdhqh70uvjn1khiLidXxxY7Qh1HFm1saYcciPYM7+idrtP/s2B562CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023683; c=relaxed/simple;
	bh=5yJkOZDmgMQeUhDDXtbOoxKBZJxMdWT6d8ZYzHrZXcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJWTKLIVOGeVrlWzWmaUxmIetRBlyTyBCZzfBFokGhf+IBe+gHM+e/JD0I8qlmlVmUzF03CfN5NvN9FskRmajo+FvccymHe2KFJk2YTf+11lVvG0aT1SK6CbZzS7SbBJPXxJjDI4FFfU8Ioz7VLFSOkMHlXcexSc1cnt/or/Qso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GANIsmQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840A0C4CEF0;
	Tue, 12 Aug 2025 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023683;
	bh=5yJkOZDmgMQeUhDDXtbOoxKBZJxMdWT6d8ZYzHrZXcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GANIsmQbrWEopRAm/RskjHjNbVaBy363hKfcXIFN1o+QTaFP+wSVVUgbxLVl1HeID
	 J9fYXQnvwKswAX5vUtxm3etpV54k/ji2/H9wf1sm53dXzbAltB+sCP0g69MdYeq3r2
	 tIUoE0RA8PBE1RHgTSSuqL3SSPl7v15ERw/MvtRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Mangesh Gadre <Mangesh.Gadre@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 151/627] drm/amdgpu: Remove nbiov7.9 replay count reporting
Date: Tue, 12 Aug 2025 19:27:26 +0200
Message-ID: <20250812173425.035689119@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 0f566f0e9c614aa3d95082246f5b8c9e8a09c8b3 ]

Direct pcie replay count reporting is not available on nbio v7.9.
Reporting is done through firmware.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Fixes: 50709d18f4a6 ("drm/amdgpu: Add pci replay count to nbio v7.9")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index a376f072700d..1c22bc11c1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -31,9 +31,6 @@
 
 #define NPS_MODE_MASK 0x000000FFL
 
-/* Core 0 Port 0 counter */
-#define smnPCIEP_NAK_COUNTER 0x1A340218
-
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -467,22 +464,6 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	}
 }
 
-static u64 nbio_v7_9_get_pcie_replay_count(struct amdgpu_device *adev)
-{
-	u32 val, nak_r, nak_g;
-
-	if (adev->flags & AMD_IS_APU)
-		return 0;
-
-	/* Get the number of NAKs received and generated */
-	val = RREG32_PCIE(smnPCIEP_NAK_COUNTER);
-	nak_r = val & 0xFFFF;
-	nak_g = val >> 16;
-
-	/* Add the total number of NAKs, i.e the number of replays */
-	return (nak_r + nak_g);
-}
-
 #define MMIO_REG_HOLE_OFFSET 0x1A000
 
 static void nbio_v7_9_set_reg_remap(struct amdgpu_device *adev)
@@ -524,7 +505,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.is_nps_switch_requested = nbio_v7_9_is_nps_switch_requested,
 	.init_registers = nbio_v7_9_init_registers,
-	.get_pcie_replay_count = nbio_v7_9_get_pcie_replay_count,
 	.set_reg_remap = nbio_v7_9_set_reg_remap,
 };
 
-- 
2.39.5




