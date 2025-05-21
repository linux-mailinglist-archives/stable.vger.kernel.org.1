Return-Path: <stable+bounces-145918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C57ABFBBB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AF41BC55AC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555325EF98;
	Wed, 21 May 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="iUF3XRJt"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F5263F2C
	for <stable@vger.kernel.org>; Wed, 21 May 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846513; cv=none; b=ouz1/A9pwSo4Rce3jJMk/mqrRMDwvxYa2xlzI8Qy5vgvWT89eSwOX1BmxGVHuVloXG8X77ErjcclkOtitm184uo2s7FumfBH2ltYv7tKKh01gstlfthKConufmj83IFHcnVScoS70OfmMrMQ/O1HxgvGAH4nk+5JR71x6viODBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846513; c=relaxed/simple;
	bh=GSBrBhoujKr+OI6jHgQp7ToyqzlfSvY8000dVY3I5ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/F+Y7wdX7/RgZc6GXQWJol8G895NdSIyGUNYqVfHFXEpY6s+djF8CqrPIP6V6P5/5McOL8r0T2sFgc7kxUcZKmB8o+fldo2VtCMGfj/X9Vh9m5hDvjBK93MBetIkFDp2cBWG0ylHZYOSXxkWxeeWsOFpAZv18q5H1PznTNL6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=iUF3XRJt; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB7E3283A04;
	Wed, 21 May 2025 18:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1747846509; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ereQYCWgKf4EKj9Vf86LYB0/Wo3F7TRQeBbx1tIlGvc=;
	b=iUF3XRJt6GBT5PiXh2oOH95ks7ZkwjBv3CgJWQDpr4w0dwUTtN8tipwEq+Dv+JbH3V4eiV
	MZb8fR02s2G0rji5/on/btDGf/G4GfqC8PZHn90HqUcGEHCvlMvfL2iIwQeLLtf/hFbE2g
	OzzwNA2Hw4UH5CchIj/eDUFIhGQhsKfyvGvdq8YQeiEKwx7QomFTdHa35k0HB8x8/oIhkR
	wuqT1YtmV0LJfxlVo+IPpCexozz9jlwntTaNc1LaMdyTQffOyuLZsHDNK0PkeLrrE4yOf4
	2uOuz4uiVsOKgQZw4EeiBxcQzSxsISSSBTkaxXmb9G9z+qnz/jSl+X7uU56ydg==
From: Eric Naim <dnaim@cachyos.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: mario.limonciello@amd.com,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Eric Naim <dnaim@cachyos.org>
Subject: [PATCH 2/2] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Thu, 22 May 2025 00:54:21 +0800
Message-ID: <20250521165421.293820-2-dnaim@cachyos.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521165421.293820-1-dnaim@cachyos.org>
References: <20250521165421.293820-1-dnaim@cachyos.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

commit ee7360fc27d6045510f8fe459b5649b2af27811a upstream

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. Adding
register read-back after written at function end is to ensure
all register writes are done before they can be used.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 07c9db090b86e5211188e1b351303fbc673378cf)
Cc: stable@vger.kernel.org
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Eric Naim <dnaim@cachyos.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9f9a9bf8dab9..c9761d27fd61 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -983,6 +983,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
@@ -1164,6 +1168,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+
 	return 0;
 }
 
-- 
2.49.0


