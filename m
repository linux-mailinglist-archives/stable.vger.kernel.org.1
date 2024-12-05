Return-Path: <stable+bounces-98635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B29E495A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D19A283C22
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE0216600;
	Wed,  4 Dec 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTfGIcS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B420DD63;
	Wed,  4 Dec 2024 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354956; cv=none; b=rK/ooValpj14xPK/IxZ96u2T2Ud2U08vdtNfhFRiv5kHRz4k9Y2Su1ezc7Bj1E1wrV91Z8V2s4wlk/74o0+YnRjqFBVdarGwdA8e+ZxrTYt9rYFUnnBrNjkdpY/Le3yGFA+GS2NiNf4wAZCazV60xInC8qa81bq9f6XRkAeUWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354956; c=relaxed/simple;
	bh=pFQjjEdkgiRe6I61WhUqrKY6q25ZpHWn+fnlSX5OMTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaAXc60190xsJchcE5+OEOmQkhE3oiZYTnT7r+iBOj2ewf5HLgwjZDinZOADZm8XJztxMPTS0xuEAvKL/HLDXwRc82knLxddgV4UFNDcOIIHEP7Zz0ZHJippZiXw2tXKXAPLbGa3qEZvOrFOoA7nDYCCsO6O4rfg5VaLWIlTaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTfGIcS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40851C4CECD;
	Wed,  4 Dec 2024 23:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354956;
	bh=pFQjjEdkgiRe6I61WhUqrKY6q25ZpHWn+fnlSX5OMTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTfGIcS2ZfwDYS2tpsbw9iq6MywlJc33TwCg6+J6mcK2jnry8h24WtsIjWmbDed0D
	 Q2xQHwxcOL/4UxQaJdssqrs39drqV56ahd6TtLHc06pXijMUtyOlRow6i+Ijpm7NHk
	 Sm7iZBAfaIcrkH0mni/wJb37HFKrZpAiEVsH0Um2Z9sp3gy45ympFJnLXGoNXbLns5
	 2THmr1NmztR0qVDT3CnpiKCfgbQi6ciNjxNDGQpn7uX8I+ROqOadUZkZ64A1HEHsJZ
	 JrBn8Td2AZRMKhLd7ySm9voLAFr8zK7hodUFpVbdKefg0gmc4SNI6UwIzgxbgT1PtI
	 3rQmjIgmaEYyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiang Liu <xiang.liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Stanley . Yang" <Stanley.Yang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	lijo.lazar@amd.com,
	leo.liu@amd.com,
	Jane.Jian@amd.com,
	David.Wu3@amd.com,
	sathishkumar.sundararaju@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 12/15] drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted on vcn v4.0.3
Date: Wed,  4 Dec 2024 17:17:06 -0500
Message-ID: <20241204221726.2247988-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Xiang Liu <xiang.liu@amd.com>

[ Upstream commit 928cd772e18ffbd7723cb2361db4a8ccf2222235 ]

It is not necessarily corrupted. When there is RAS fatal error, device
memory access is blocked. Hence vcpu bo cannot be saved to system memory
as in a regular suspend sequence before going for reset. In other full
device reset cases, that gets saved and restored during resume.

v2: Remove redundant code like vcn_v4_0 did
v2: Refine commit message
v3: Drop the volatile
v3: Refine commit message

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 9bae95538b628..77071967f965a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -80,6 +80,20 @@ static int vcn_v4_0_3_early_init(void *handle)
 	return amdgpu_vcn_early_init(adev);
 }
 
+static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	struct amdgpu_vcn4_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+
+	return 0;
+}
+
 /**
  * vcn_v4_0_3_sw_init - sw init for VCN block
  *
@@ -110,8 +124,6 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		vcn_inst = GET_INST(VCN, i);
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
@@ -134,12 +146,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = true;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+		vcn_v4_0_3_fw_shared_init(adev, i);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -224,6 +231,8 @@ static int vcn_v4_0_3_hw_init(void *handle)
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			struct amdgpu_vcn4_fw_shared *fw_shared;
+
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 
@@ -247,6 +256,11 @@ static int vcn_v4_0_3_hw_init(void *handle)
 					regVCN_RB1_DB_CTRL);
 			}
 
+			/* Re-init fw_shared when RAS fatal error occurred */
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			if (!fw_shared->sq.is_enabled)
+				vcn_v4_0_3_fw_shared_init(adev, i);
+
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				return r;
-- 
2.43.0


