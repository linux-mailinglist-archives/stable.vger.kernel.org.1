Return-Path: <stable+bounces-95053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 621699D729F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283CA284EED
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A801D517E;
	Sun, 24 Nov 2024 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSrf99Ew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C511991CD;
	Sun, 24 Nov 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455821; cv=none; b=UxrS7l+bSNG8k5ObIIdDy1BapIdsJTD9cToMw96Vrw+yH/P21eviGsZtPI3dTxvFKq41AmmgH8ZyXqFtV49CV6696oF1bJJPINdN7RSnf6LA6xppUls6K1Qsys2HF1BzDwHA2R9UO2UazxGhFwAKm3QoWCbwivdpPqtI8F6tqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455821; c=relaxed/simple;
	bh=z3R85XMXdBMEexlHujvlKrzPqhHlDK76LHTEer4GGh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odhaHbo99+pW51Z/AtCswDy5S0Ld3355k58Jktt4REuoEn+W60XCgJEhFcQx3U/DeEurprZoMkPH7M/5//nhIxd8p39U4SCK0kn0FDEnMUSG+Wh9/PrdkW+3pOaV65uyn16Sf5bmBLhmoAIU3EX3ijmWS9HnwIUmE91VcekiR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSrf99Ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C019C4CECC;
	Sun, 24 Nov 2024 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455820;
	bh=z3R85XMXdBMEexlHujvlKrzPqhHlDK76LHTEer4GGh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSrf99Ewn0+2+FN/z3eLSMDENLxsI3t7i7wpkv4MRxij0tAv/MgletHOuJBjxo2ut
	 CUrOXOlHPius1CGeTfpUnsayg3UdQKj8GLCEKag+9RUYj7hXKwlrMytC3IOQOHdCjC
	 D34yIhgqL4OdSA5+iDJl9K34zvvbqEmtpy8d84HuYsNXxJLYPsIB4vlQpYmwx7plxy
	 sLKTGvvbB7D9u3Ja3vkwBHHdZff8BezHKoDSgprTtAQDUNfXZ/mufr0dZakrWvJ1Nz
	 48kZaCRJjsz3U1JCYEpJTVNIuxyKE7UdDkEUfIcSqOUVsBae5wdHgEGKkhTYsL0aOU
	 c21W5QJ2GrsQQ==
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
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 50/87] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Sun, 24 Nov 2024 08:38:28 -0500
Message-ID: <20241124134102.3344326-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


