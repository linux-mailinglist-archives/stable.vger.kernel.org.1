Return-Path: <stable+bounces-94958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7C9D7171
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D3163CAE
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF31E0DA1;
	Sun, 24 Nov 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmTP4TzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF031AF0B7;
	Sun, 24 Nov 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455402; cv=none; b=mWvMjh9N2vuXJEdDwzOQhC/+wSe3Q+d2NmSKJ9z/g5R6wuQ7qgqbh/cxYC0an/tTUt3IGiOqNcljV3KTjnJVWlKuQwmDRJbGgcJI4a3vUWRGGW7xUJasWeAxTjygpSMCzH/mJh6X50hkNL8BexNIuw7oYdDvV/viB9XhMWFTSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455402; c=relaxed/simple;
	bh=z3R85XMXdBMEexlHujvlKrzPqhHlDK76LHTEer4GGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tisUkP5vDIV+TtdpXrq/D68I29+Nu5y5ejq0orXl1uc1Vk9PFS/EnSRGdW/5ovyseHOmivB3/ZefbtGEA4G+UNt0CK7HsRL3lppb8CEKYp9lMg6/FJQ9qq+7BIMbAX/z/PqjI5D7sJoKWTiC6aRafRmHt9GbEQFSHJ//ugAEgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmTP4TzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BDAC4CECC;
	Sun, 24 Nov 2024 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455402;
	bh=z3R85XMXdBMEexlHujvlKrzPqhHlDK76LHTEer4GGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmTP4TzNa8doY4TBk7xIRtpS/x3Qgcx/xTvU6g3MiCm1vIX6+QBtsf18d2vPm/kdO
	 1oi3FgHuPVGT32dAI3av/ComgWJnOP69oTvgM3aC6IEAEdrqkLsu1lnmBbKSUhF+zg
	 KbYKjs5CWm9mCxn1TCFmHYIvaVasZ5QIFzpu1B3bhQixR3g3nffY7lwyYTBaN3FBNs
	 ai9nZ59czxWw9hOOQA+iVJmyR4gu8+D443+7YbN13RDt+wQlCS73+uxhZQVjajSBKw
	 pCSJZiEnwXGfcfT2hR5+Sdo+DjJKagB8EHvGP8T5FrIXGL+BnHxtrq9AzXBJsn7PlR
	 0mQ30zxU6ClxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	antonio@mandelbit.com,
	Jun.Ma2@amd.com,
	sunpeng.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 062/107] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Sun, 24 Nov 2024 08:29:22 -0500
Message-ID: <20241124133301.3341829-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit 32e7ee293ff476c67b51be006e986021967bc525 ]

Need to dereference the atcs acpi buffer after
the method is executed, otherwise it will result in
a memory leak.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7dd55ed57c1d9..b8d4e07d2043e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -800,6 +800,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0


