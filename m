Return-Path: <stable+bounces-64832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0779943A85
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C53F2828D3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D714AD3D;
	Thu,  1 Aug 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDPj1bsJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBA136663;
	Thu,  1 Aug 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470949; cv=none; b=Yh6NgkiT0E0bMEOMlekE+UP1G4O7n1dUd3pNZqqgPLvgTG0oSDLCmOU3j/68w0QusrKIBaOwwONIAfT5IlvhEPeuo/sgLG2HX46g4ikqcAuJFAHHT8xWKX051BZj0VtcrT+V0KeFYLhUz/1ZigVFMRVtJ1fqfZUuZ23zt4x9a40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470949; c=relaxed/simple;
	bh=slZEUwGqc5HulqPdnfKpD6NavuYjpRC2DjrtoG/qlaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrMEyWyVuRiYhw6jnUw8o2QuVOYkQviRa7/TGKGpyq8CWrfB0HFL1+tcXWYl3rha7i9Ycjz0JpTCbb6VuNH7J2odQtKhBMKVg+03kXFdmMX/j+35lJxfT1r/NJM1q18aHKcXWYqYTIlfjcvPdsSIWp6Rh2orWyKxbqH1GqVYwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDPj1bsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C6CC4AF10;
	Thu,  1 Aug 2024 00:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470948;
	bh=slZEUwGqc5HulqPdnfKpD6NavuYjpRC2DjrtoG/qlaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDPj1bsJp15s661nlKce8CV8S+G+VdcrA3xdhO3gU9Vbzu9atk8/6Z8y8vhZBk+os
	 sqgeDzHqPDkOcwxTJeibdfihxHAmZsUe7SZFfn+qJPHl4bOBfNQDPkfQajSO5hedM7
	 Y2SDLdtTh7RumcZyBhSR7YkX2GQqjwyW/hNbCjqE4vK2oVJZIJ6tJTOTLp0+rVdy+v
	 UhijUFLsjb3dxV1kHWj5quhTBp/HnpJkYgXNvZu24kqJUMBnLCoGUt73N4ZszLmWyh
	 vFfMDpbzSMxU8IMLoM6W/dtUvK1gjV3Ywm6ipthOfMWXdc4nEiEqrWgxGffycVmJwe
	 7kXdTktsZNS+A==
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
	electrodeyt@gmail.com,
	samasth.norway.ananda@oracle.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 007/121] drm/amd/pm: fix the Out-of-bounds read warning
Date: Wed, 31 Jul 2024 19:59:05 -0400
Message-ID: <20240801000834.3930818-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index b1b4c09c34671..b56298d9da98f 100644
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


