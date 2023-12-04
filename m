Return-Path: <stable+bounces-3935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F07C803FA5
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F77A1C20C09
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05535EFB;
	Mon,  4 Dec 2023 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6Y8HITa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80035EFA
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0CEC433CA;
	Mon,  4 Dec 2023 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722091;
	bh=d0x7v3HGnyDSRgQ6KgQ0tQ0Qs6El+7eD0tb299DREL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6Y8HITaExi+Mh96QCZHtesPIaQe4VywVqYD1cYrPxhSDiXwv79U5EY3vCsmDTnj0
	 /PIy9KyJvGLTwQoiicY3t5g61bJiRvhtMqYPs0GvIDLCAvxS3WFNdmS+q2KdLSfsnM
	 v8MmKnRZih4tksjC52XogmmdEWDlEzXnCfAd7ZSKJsCxYZgM2ZTDAHkfmtnYi3+ESc
	 5/8XWNHykN3iLDDVjCJbEKCRo+OAvqalto0/96M+cohH4D0z6uvaqegCsNibBwT/qr
	 91TIvOb8j/OxTreY1HgSts2Ae591UsdeFoefm2VGSBkKkRRs8o5Fgb7z3Yh+0ywFb9
	 oAaWUm7XGA8JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	le.ma@amd.com,
	James.Zhu@amd.com,
	shane.xiao@amd.com,
	sonny.jiang@amd.com,
	Likun.Gao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 28/32] drm/amdgpu: Use another offset for GC 9.4.3 remap
Date: Mon,  4 Dec 2023 15:32:48 -0500
Message-ID: <20231204203317.2092321-28-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit ed6e4f0a27ebafffbd12bf3878ab004787685d8a ]

The legacy region at 0x7F000 maps to valid registers in GC 9.4.3 SOCs.
Use 0x1A000 offset instead as MMIO register remap region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f5be40d7ba367..b85011106347c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1159,6 +1159,11 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x46;
+		/* GC 9.4.3 uses MMIO register region hole at a different offset */
+		if (!amdgpu_sriov_vf(adev)) {
+			adev->rmmio_remap.reg_offset = 0x1A000;
+			adev->rmmio_remap.bus_addr = adev->rmmio_base + 0x1A000;
+		}
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.42.0


