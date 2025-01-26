Return-Path: <stable+bounces-110557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADBDA1CA14
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B203A7DA1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D391FA84F;
	Sun, 26 Jan 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgLjkV6k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7401B412B;
	Sun, 26 Jan 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903351; cv=none; b=HFANNfQv89zkcLBjDlUqPsvnlkJO29h6T0drg4dbFRvnGkvHe+HkV8LFOuNeBZDuSuv7DaTaziQvt801ajRGDTz+a7ZaxRi0UHbl8wZF27Boczw/fg0HwZjnQ7zSozTSgrKHAdP+yo8yQl/4gUgf2oIv9M+TH0IqbNcY5Zu9AeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903351; c=relaxed/simple;
	bh=DbRbu2Eok980IsJKoXz0VGAWjwu7B8uSxCNJX8/iE60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATyR7bV3CeD6m6x0XQJUHrAxB9OAifW4wNm5izwWURvJ2lBCMbc0se/Atr/Y2DcH5QN3MmLuJUJJFVz3O0tR7UbAn6+pEGv1CUwzsxH4iqSRFBRlw7VfGLFPLz9LqzGkoXPKr8X3nHeZcmsJ0RzK3DOUnma5gDrNTnsXPwfcLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgLjkV6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CE6C4CEE7;
	Sun, 26 Jan 2025 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903351;
	bh=DbRbu2Eok980IsJKoXz0VGAWjwu7B8uSxCNJX8/iE60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgLjkV6kvxbXoxuNGdpGj/suLdU1FdFTdTwjWBGAOdTe5pXIpealt0Nu7K7qBJ8oL
	 l6tT5VIwaUSezwRBuDVuIzd5QYr8SDbnenyGdnN/TUebi+a1SPBVQiNjynSyf6KUFQ
	 x08KyUdR8zZB1HKdXLGgaL56OkqJSFnZpWNB6+6IpyinhxDcand/ATEFiq/byY16FE
	 pfGYUEVA3O/v87jgjXUUTmyyXm2gg9QKX2qAPhVeDHehKKDTWHKqY5BsuhO345t+Bv
	 YKdQ7Eui3MosR6fRaiGiSOOaiKfX4AL4SPjZjn+8PDjh3GPM1A/msWmEgy6FGcV1a/
	 qOAhcTMMa0kzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	kevinyang.wang@amd.com,
	lijo.lazar@amd.com,
	boyuan.zhang@amd.com,
	jesse.zhang@amd.com,
	Jiadong.Zhu@amd.com,
	tao.zhou1@amd.com,
	le.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 21/31] drm/amdgpu: Don't enable sdma 4.4.5 CTXEMPTY interrupt
Date: Sun, 26 Jan 2025 09:54:37 -0500
Message-Id: <20250126145448.930220-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit b4b7271e5ca95b581f2fcc4ae852c4079215e92d ]

The sdma context empty interrupt is dropped in amdgpu_irq_dispatch
as unregistered interrupt src_id 243, this interrupt accounts to 1/3 of
total interrupts and causes IH primary ring overflow when running
stressful benchmark application. Disable this interrupt has no side
effect found.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760a..4dd86c682ee6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -953,10 +953,12 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
-		/* enable context empty interrupt during initialization */
-		temp = REG_SET_FIELD(temp, SDMA_CNTL, CTXEMPTY_INT_ENABLE, 1);
-		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
+		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
+			/* enable context empty interrupt during initialization */
+			temp = REG_SET_FIELD(temp, SDMA_CNTL, CTXEMPTY_INT_ENABLE, 1);
+			WREG32_SDMA(i, regSDMA_CNTL, temp);
+		}
 		if (!amdgpu_sriov_vf(adev)) {
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				/* unhalt engine */
-- 
2.39.5


