Return-Path: <stable+bounces-110526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E6A1C99D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD47A30BF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8B81F55FA;
	Sun, 26 Jan 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azskYTrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2E154C08;
	Sun, 26 Jan 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903266; cv=none; b=uF8TiibzXVfO6R1lf5oLF1Fu4pqMZaP/r4Tya/eknsxLWlAhU+S3p5bdlmdfPIM1jLolmWugcSJZftgRdfjoD9HTTAhacZ7pMijBZ7r2C61BBEMZva+bav7wYy3yLVf2ZWgv7K44ENu5EEt0WKcj1esvyeSxcIsRoU2jYWMg5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903266; c=relaxed/simple;
	bh=GN1NMxt/gjWTVbQAZE7hiZyVilNRTegYbGnMQt5SG6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zzd/hvFJBVR1BzUcikBNYPgzxP61+WuPpXi0vF4OYpj8WKn8pSwLzT5URLKNK4K/3OWWEWrTQDockmslWblRzyLK0/CK0pvNiFvAY+kga8PAKqeZMUeFi58lHoxny08a5WxvtU46/82hQImgZSqfcfQ07PBWrIF10hEFS3ubG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azskYTrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A3C4CED3;
	Sun, 26 Jan 2025 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903266;
	bh=GN1NMxt/gjWTVbQAZE7hiZyVilNRTegYbGnMQt5SG6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azskYTrfdM4xC+PEMGc/ILiIJRvtETTtUdA7qtAEs109sEbNZYDLBEj0Rs8ae0IAW
	 gM+M+l6c6wm2fBB3UZpOsxCJv4UyKEQdnXt8k20g1m8PQylufDzBW+Mq0t+sLGURu1
	 4MLqzjiyHAFpBVbjdRL3s5x08JBENqRH2M2m35hOE5T9CBNnImwoV+jecfpxL+VoAb
	 iKGXYuA2a9VzaKVQBgTOJmgEA+8Amfn2mltwhEl0xT3MfgXTbLVf7PrybASw1hku6v
	 7gCKC4mf3mzUagX+6eym61sr26QPEb5B43K9JjH9epFCOFayHN7mkNWtKu+ArmuT0U
	 VMLjIJC2TwcHA==
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
	tao.zhou1@amd.com,
	jesse.zhang@amd.com,
	Jiadong.Zhu@amd.com,
	le.ma@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 24/34] drm/amdgpu: Don't enable sdma 4.4.5 CTXEMPTY interrupt
Date: Sun, 26 Jan 2025 09:53:00 -0500
Message-Id: <20250126145310.926311-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index a38553f38fdc8..ed68d7971a93a 100644
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


