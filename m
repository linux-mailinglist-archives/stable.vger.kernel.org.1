Return-Path: <stable+bounces-69985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EE95CED3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFAC41F27461
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3211B191F64;
	Fri, 23 Aug 2024 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlYCZhCR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE1188A11;
	Fri, 23 Aug 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421740; cv=none; b=ttRC7cOW8hSD9hN+1bb6+hytLGLYrh1GFPBJxSWnTtrbCHpQ20RBBNzhH6gMpabcGiBD2TAetnpYHW7XKsWyo2INCaBNr6Z2xQevM1sUYqve4QhtSu2iAUvt6dHGyZBjqKwFgyubsd33cKKQXDj+NT+sVPEN7e3F6n3ycV4omYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421740; c=relaxed/simple;
	bh=dgiQ3/mt/vSgmJTLRuwP+QlvvZhMW/aC7s6AlBg/FVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Ubh7nmgo2VEsCIAfKhGotKc/vaARfTU0hxZSgYCre7hg1sTSGrJ+9ta8bLRbmi6F/BSMRGbTzPx1qMBGuTrDM7hnfBYJC1sFwIifK4PTjiby9fT9tPjTlAj2rmR506TeW+OCXPbQ7qZdj9gRwwwR2Pbv/SQspjhg4Zj5OUptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlYCZhCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD72C4AF09;
	Fri, 23 Aug 2024 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421739;
	bh=dgiQ3/mt/vSgmJTLRuwP+QlvvZhMW/aC7s6AlBg/FVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlYCZhCRU7nnq27Ho0uf0X+Ef2SfRvgleHTR3u1xKT4dEw3OOYAijqId7ghUQkIJZ
	 it1nCR0iv/8Oeuj0b4vdCsr7P8BfeMll1Yr1AxECRimn7dzLFzT2PN44IuWq7NURU3
	 QIzdpfuh4O+Ws/MQClW8BJ25tVv7Cbn87muSYFyNQUgOW9nKhXs6p9e6p2K5F6uUKm
	 BY4wE7S5/SV7rZQDr74/+lX1PZYJFKhuShDNzxnERzhQKg+O3UbQDtUjd3Wmt7qNwV
	 NwmsCAf5jLiMv/hHsxDNwsjz2r78CNYOhn2v7J6+0GYD6mWKXHKMH3aNTuj7Lvkkzt
	 RkRPwcshrj9QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yinjie Yao <yinjie.yao@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	leo.liu@amd.com,
	sonny.jiang@amd.com,
	boyuan.zhang@amd.com,
	srinivasan.shanmugam@amd.com,
	bokun.zhang@amd.com,
	saleemkhan.jamadar@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 18/24] drm/amdgpu: Update kmd_fw_shared for VCN5
Date: Fri, 23 Aug 2024 10:00:40 -0400
Message-ID: <20240823140121.1974012-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Yinjie Yao <yinjie.yao@amd.com>

[ Upstream commit 507a2286c052919fe416b3daa0f0061d0fc702b9 ]

kmd_fw_shared changed in VCN5

Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit aa02486fb18cecbaca0c4fd393d1a03f1d4c3f9a)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 9f06def236fdc..49cf0c73b2364 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -460,8 +460,11 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
-	uint8_t pad2[4];
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.43.0


