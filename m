Return-Path: <stable+bounces-95179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632879D73F4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDBB1669BF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35443235C01;
	Sun, 24 Nov 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFYqH7XN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC4235BE6;
	Sun, 24 Nov 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456250; cv=none; b=taaBS+/89FQpcGcR/JWoCfz0sHaGHDj19mFHxbOPsV+m210b/PfyRyEtzEIIIalP9rn3k2yMX8LcM4FJkTfKob7/guMLa2mcaMkAG2L0+HFeUM5+55O+no4h2PxvDKMXxvJTMxpoLeBydierE65DOWDgSNnrOsudF7Or0mokoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456250; c=relaxed/simple;
	bh=ZY44IHedXHybYQd5QP0PoNOjOVOximKt8dPydbgGOAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqCsAk4hDfr7jUiM+F1NVmM7BKpIztU1CWDaiqzkBv4RDrCckIkhP37OtwH1g5HHdpE9x3bZERuEBdGTpVAf5B2ghVhd3/7i9Favi5J9zjHhI9Hszpt/jsf8GTfojoyCmJq4M9Esf27UXAi2YDT7i0TpDBXdyhoKI923bEbkc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFYqH7XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0566CC4CECC;
	Sun, 24 Nov 2024 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456249;
	bh=ZY44IHedXHybYQd5QP0PoNOjOVOximKt8dPydbgGOAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFYqH7XNbYwySLEfgcjj+XGfMi9fl2x9pnV+cIz1IXwByx7jurPhLTu1HNLskDqcT
	 DsfYjVVk3n8nPJFRBTUEhBFj9jt2JouW9RxsEADbqVbpM8o93DUkWqgAGNe6+5cs/Z
	 8SCcpjbk7kg8OKT8n8vrQpPsEoXLmGbqwDBUeY/773dTXot39tTQoMDprzLJogXS6R
	 iRbZTTXQY/KzTGlZYcnWI/mpopELVmO4BRVbAWtSUOo+CLF5rsrczoUaUTcVXfLg9R
	 ZmpDf7cjhC5ejpDSEzbUhb4iQ9ENQjahfhEgkGuDtt5J4xt+uIUhhEUDAcMrkIBHAN
	 KvUubylGJfN4A==
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
	Jun.Ma2@amd.com,
	antonio@mandelbit.com,
	sunpeng.li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 28/48] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Sun, 24 Nov 2024 08:48:51 -0500
Message-ID: <20241124134950.3348099-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 7ad7ebaaa93cd..5fa7f6d8aa309 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -758,6 +758,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0


