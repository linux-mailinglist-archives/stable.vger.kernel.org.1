Return-Path: <stable+bounces-98645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 910139E4A1C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47382285A3B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9A218595;
	Wed,  4 Dec 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUUI0Ktx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89A20E30F;
	Wed,  4 Dec 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354998; cv=none; b=FvmmHZBejSOSBibNdReiu33+ZWq3lFZ06UGayYsmd3l+bFIl7voLPrfOvW58fYnxoryc/gKnAXqJQHTl079mm3CZYmdogR8NU6GC4f+JIP1ZmMrO4Ca5QmFoHPJJM7lO/NRKFnbz7I+dMltuJd/fKkyJf5juKt05MQhftCXTIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354998; c=relaxed/simple;
	bh=+J+kz/M+Y8prMAq3RC1OxtSLP4O3Db7wbLLW3XlzyMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrbHdCb//3iNoJOeoBpEoyhBTqBw47XZkTLeoXqnfBsfKvpO4Sm2fFT/V5MThUFWPEz7uE/uyvbwkUGDpu/JzBgGeiKo2vl0q60HOsBNzH0rittZ91EnBupGT/9KQeeMQ4FF9v/b1XW9gt8UyEmyDbCYTGrgXkAbn8mhYMYyR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUUI0Ktx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EC0C2BCC4;
	Wed,  4 Dec 2024 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354998;
	bh=+J+kz/M+Y8prMAq3RC1OxtSLP4O3Db7wbLLW3XlzyMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUUI0Ktx6giwokja8FInhutIaiBLV81gp9sLgwi+7wkT4mSuVC08D46/7lUuiaG0o
	 /KeU0aUfXz+H7Y7L1yhdgnLCwVpuF1OwM8EVcELqJAhk3JYpdWzpA7fh7TBYB2T1Vl
	 KvJSsw9ALIXJylUWKbZS0REfkrvepJRo7iWtF+YwZKvMVGSxiJp3QAxjQgsvCSBnn8
	 pPRh+Tnj/Efq9WnwhUAGw3YIKw7gZdq0euWafp1yjll7oCA/kcAkbHcLmGTGU6ONUo
	 mC/ZQsib8KvS3zm4ZTCig0BJGvoMlr2Mp1aDLNj87TCgBqhDn+kVoery6ZWxpS3kQO
	 q5Hz2xjrGOMzg==
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
	Jane.Jian@amd.com,
	David.Wu3@amd.com,
	sathishkumar.sundararaju@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 07/10] drm/amdgpu/vcn: reset fw_shared when VCPU buffers corrupted on vcn v4.0.3
Date: Wed,  4 Dec 2024 17:18:05 -0500
Message-ID: <20241204221820.2248367-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index f85d18cd74eca..e80c4f5b4f402 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -77,6 +77,20 @@ static int vcn_v4_0_3_early_init(void *handle)
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
@@ -107,8 +121,6 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
 		vcn_inst = GET_INST(VCN, i);
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
@@ -131,12 +143,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
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
@@ -221,6 +228,8 @@ static int vcn_v4_0_3_hw_init(void *handle)
 		}
 	} else {
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			struct amdgpu_vcn4_fw_shared *fw_shared;
+
 			vcn_inst = GET_INST(VCN, i);
 			ring = &adev->vcn.inst[i].ring_enc[0];
 
@@ -244,6 +253,11 @@ static int vcn_v4_0_3_hw_init(void *handle)
 					regVCN_RB1_DB_CTRL);
 			}
 
+			/* Re-init fw_shared when RAS fatal error occurred */
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			if (!fw_shared->sq.is_enabled)
+				vcn_v4_0_3_fw_shared_init(adev, i);
+
 			r = amdgpu_ring_test_helper(ring);
 			if (r)
 				goto done;
-- 
2.43.0


