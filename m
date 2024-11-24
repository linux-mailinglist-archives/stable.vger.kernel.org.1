Return-Path: <stable+bounces-95124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E49D7383
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF7016664D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A221E009B;
	Sun, 24 Nov 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQxjAE19"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6991E009D;
	Sun, 24 Nov 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456080; cv=none; b=Yr+Zu9zCLfwt4gZRrJujLsjuCJyZ/TUi9XAffV6835Lupyfi6MV2Z6Wpzwvf7M6kNAagv9c5s+Zm5gi6QMAq7ZmtZ/vKx3XvZ3Ytlwuoh4ZZSZBJiHBDlS8dyrQoSdMDSEcn5xttdO7MJYgrS2IVF3Px9+Kq10pJncLFCQD+9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456080; c=relaxed/simple;
	bh=iYr0doZHlv3la6k3A7nFvvkFC/k6o8kxlRWPd2yitJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ncs5Ok0mw85GO+TfgWCeRQj/Zxe2YpTxMzRFxVT5vkOkTSo/82j8csKPb/bxgfw4LEZhsUmW9ISj+XknGmJ8uFjqklN8o4Ca/FKRc2EfEbggcTmQnNeqyL9kCrvlUZFsUGeA8+dI/BLuV9bLsFBsURFiijpxnUi/lZ0NfwE2m2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQxjAE19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80153C4CED1;
	Sun, 24 Nov 2024 13:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456080;
	bh=iYr0doZHlv3la6k3A7nFvvkFC/k6o8kxlRWPd2yitJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQxjAE19YOZt6xOSrPmLYtcreELnsgqRay2b1kiGET8cuggayicEBaJizZk9arIZg
	 bqeR5ozxEHlvxV/I5wfhDu9bKhm5Q4XPcfubHwdCxxTiU99lvghiLVAcPo7q9oV4PQ
	 N1sFA3XHC7IZ2PH284GHoI8nbxCrsVFD9Ozvmzq1eiEGgOZt+9aHC992ephSPWu8kR
	 nw5ye+yaXd9z6q+3D2Xa/2fCbpE4RCe8CFiwzNbhZGCCCvFO7dTK2GhQ7lCmiSHC3k
	 C9kcfD+8eM8FW6SDEc9dUxBWbwhs+1y9tjTzu5zFxz6x6uvTZJWKX53+bRj8mZcmiw
	 xe/Nr7N3CKlgA==
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
Subject: [PATCH AUTOSEL 6.6 34/61] drm/amdgpu: Dereference the ATCS ACPI buffer
Date: Sun, 24 Nov 2024 08:45:09 -0500
Message-ID: <20241124134637.3346391-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 12a0ac42fcfea..8b2f2b921d9de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -798,6 +798,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 		return -EIO;
 	}
 
+	kfree(info);
 	return 0;
 }
 
-- 
2.43.0


