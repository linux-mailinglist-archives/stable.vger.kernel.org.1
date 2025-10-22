Return-Path: <stable+bounces-188865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B4BF99BD
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 03:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A55518C6750
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB221EB193;
	Wed, 22 Oct 2025 01:30:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEA1993B9
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096616; cv=none; b=I4yl9ynIcTXynBrL2V2mIsgEVHQIpHeSlYDJxboP+Yxd8tlFBwx/Gtmcr27w3XsO7rX0tcx7RDWucvoh2uRhx+8YRuHef8YkLhPLQZgA7KqZDTjH7t7EvG0okssueYVhfRGaW0z/xmkxpxEIOAbOKG1srGUS5EfBrnQwiKlCsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096616; c=relaxed/simple;
	bh=fpGPbczkoFCSGyhstSPhoxIVa7ggj01QLGUbKKsXNpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qKq41Q6EWGc1UZHfbpNgnRND1QuLKyMxlTpJtvuIanHFFRis3e+1CiqmMHcu9AOuTYpBr0C4cEU0IZl1Xmospcpk/gkNOL1H0WAlzoxA4jD0Kz3HII/fQAWRJTP8achn/DqLDly/FJtrDaTji1T7CpLpUTPtkD+4OG2UuFgJr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 60803233A7;
	Wed, 22 Oct 2025 04:30:09 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y ] drm/amdgpu: Fix potential out-of-bounds access in 'amdgpu_discovery_reg_base_init()'
Date: Wed, 22 Oct 2025 04:30:08 +0300
Message-Id: <20251022013008.186448-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit cdb637d339572398821204a1142d8d615668f1e9 upstream.

The issue arises when the array 'adev->vcn.vcn_config' is accessed
before checking if the index 'adev->vcn.num_vcn_inst' is within the
bounds of the array.

The fix involves moving the bounds check before the array access. This
ensures that 'adev->vcn.num_vcn_inst' is within the bounds of the array
before it is used as an index.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1289 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Fixes: a0ccc717c4ab ("drm/amdgpu/discovery: validate VCN and SDMA instances")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ kovalev: bp to fix CVE-2024-27042 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d8441e273..8bc3a4bf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1128,15 +1128,16 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
-				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
+				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
+				}
 				else
 					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.50.1


