Return-Path: <stable+bounces-65035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC5943E08
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15E5B2B026
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01721183CBF;
	Thu,  1 Aug 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPeKRTEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116E131BAF;
	Thu,  1 Aug 2024 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472111; cv=none; b=ZH2k1bftlBEy7jDHx5+Z7o17Js8gLfvQiABwtCrpX2CDI91Zu805GzahmMjnNSm7AA06lelC64+RynJcxBACaaCRtzgwdVcmndhaWYu7M+/l0t58gyo4WIOznohGc2xdfhUgIWcpbijAk9ALfM4CAz4KDJcix076VJk0ZT8s9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472111; c=relaxed/simple;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF6PfjznNkIdxgbhU75GbXJw0FO/Ovg/OOp+d9gUuhzmRl9YXlfoUnWYf4fxxPUH3H8c2DIc+s9pdchD0jzoPW9hVtgCxuv2kdWkLCszj9QHK5MYOpIgqVZBhJAKznH+ITj3RYbpk9ucJUPrbNZDFj9otopnRCj/UTFjIapW9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPeKRTEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB74C4AF0C;
	Thu,  1 Aug 2024 00:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472110;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPeKRTEwi0+VxlY+mz3Wpu3IiNFb4a/HpSzd8ck1hktz527CIo51FU/fInZO59DGc
	 4KzvxdTfBBziYIs2nmdl2nEyVfZyX6PRDfwBy3KlR5wgg1SBVxMivTUQsp4cAraKTi
	 Ua4ujWDgBgJna2oN+c7jnFvLpEG67vBDwnh0zArd5OGeYlsaflonjmyQHoZbmOyq7d
	 t613D0/qduNeoSAREIVjNsoWmFAvJaVOtfa8t/RCF54eY5PtFpwYws8r8tYws+gkzt
	 PTrimS8GOEHOanJ7fnPbgjs/JrBkBkUVYQyyokCbaEAEu7DmYBlFMfGtjli7TFSqeg
	 m36mESTyekJUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	samasth.norway.ananda@oracle.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 06/61] drm/amd/pm: fix the Out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:25:24 -0400
Message-ID: <20240801002803.3935985-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 12c6967428a099bbba9dfd247bb4322a984fcc0b ]

using index i - 1U may beyond element index
for mc_data[] when i = 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61faa600..cc3b62f733941 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
-- 
2.43.0


