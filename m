Return-Path: <stable+bounces-77672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4B985FC2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180951C256A4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88BA1D4DF6;
	Wed, 25 Sep 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYigfOuy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBA1D4DF2;
	Wed, 25 Sep 2024 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266655; cv=none; b=cjP14Rcq8+x+Jgv1z6FEifuo6oYBF7CWSko+akczPWCmGzgg2rwNl4uRtMxHHsQVl09VD/6woRaZseIS/T3GLYx4TENuEitn5zSVo77GgRNmOtnhVnvRpse6EmcGk3nEzHBq5B/2HT3B+h0iIAqw2p9Ta2gKKmJ96fAu1sl1X1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266655; c=relaxed/simple;
	bh=OB6NENlvZSwTU8nlAMQ/WpdGI0kcmwA0lqhEFOvXgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9oSYyLFBGOeN7THSFUND887zIS/Yj24HIfchTOZlTaHKpYpqq1VJxqg7fuHOme2oNIbfiXTEgfVCUHJyXIdZ2J6mUDABAfbUb2n0LbrpQsxJiSpOu81STBMADG4q9qhykOhr3NscvhhFF4f681XSb45lxyr5EjcEVtvLhBRhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYigfOuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A47CC4CEC3;
	Wed, 25 Sep 2024 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266654;
	bh=OB6NENlvZSwTU8nlAMQ/WpdGI0kcmwA0lqhEFOvXgMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYigfOuyZBSYsDP65x7gUkcxXUFsAcZNc9r6W4QGVxIIX8aS2UE9ZX8RVZGwic8XM
	 GeD3UDp4nzGFOyTrcl+yongu9aAhwcnq+PkE0ixrteO0Pw88C4ujRJtBlQjkhcY5zf
	 yDcTUh7Qf3NVmTZrvvKPgmyr0bPgi04s8ARRvrvYQ4/0aEgVJBg8qccjqltAQGeqzl
	 bDwEXF/R0ggzTY7KDWcrS6gjVSEfUQX4Es+/r388FmO24c5+Z4LXRqBcTQ1sf9+rtp
	 Ybo8ChSehtOTQDXgPLWjVgvRG2xrKIycRvzteS0SRuvsHfuWTp5wh4Pn4c5fZ6mB2n
	 Q2q2+oXxBQ4+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	kevinyang.wang@amd.com,
	Jun.Ma2@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 124/139] drm/amd/pm: ensure the fw_info is not null before using it
Date: Wed, 25 Sep 2024 08:09:04 -0400
Message-ID: <20240925121137.1307574-124-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit 186fb12e7a7b038c2710ceb2fb74068f1b5d55a4 ]

This resolves the dereference null return value warning
reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 5794b64507bf9..56a2257525806 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1185,6 +1185,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
-- 
2.43.0


