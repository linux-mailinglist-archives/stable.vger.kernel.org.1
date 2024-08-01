Return-Path: <stable+bounces-65140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1FB943F17
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B13282B9D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7C1AC422;
	Thu,  1 Aug 2024 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD3UMDY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7F1AB502;
	Thu,  1 Aug 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472616; cv=none; b=B2RzmygpfOuE6Sdcyp5+nQ1cdQL2bzFMA+IHTemJThQ9OLs8wecdWNABtKIYAHNEziO1zAjrqwY0g10FRsuhsLHbJ9WHDdepJj23n9XWurWX5/+O7kUYkRFVQPzT87Yzd7idt/qchjH/6Vq1rO/QhC7VutPuehtBWjZKIBa2MJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472616; c=relaxed/simple;
	bh=1u9S4XLsdPKv0aGLBiRvVW04h4+GQwsJMoBYkDP1Erg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR2hVf5Edh2o8//g0/sm59A4XOzeSanqPxmOvFZsJCYzTsjjdmM0jvAaxUERzwsDpxSaw59S8ev3vOme39gHE3xUwvZvXI5Laf/7bTsFPq7UAgNXqRqsg2FfAJjnE3y02rjvTJeNw+LCaGWU7BL+Aup2JeK80DrXW6PTjGU1JXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD3UMDY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7A1C32786;
	Thu,  1 Aug 2024 00:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472615;
	bh=1u9S4XLsdPKv0aGLBiRvVW04h4+GQwsJMoBYkDP1Erg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pD3UMDY7F4zj0+dnm5aWqPEFGQNXEI2xCmw4mfuyFPsmhsSh6qPgS31V48aZFQBuD
	 m5w8KAKkPFU/POLRCFryEMGbH9yx93sIn5wVSmnI90Y64r1ufP7CmPOo+kWTOtyJfN
	 Uw9kMoFXpfL9Cj0jKldEFN6sP4unvvXKRh++dtnz+syQWugifyTREF2asQCdHzruxB
	 P14+n0/NRlbxPdCBvyRjZ01tzpoyAKu31AtqMWAcupn6Cg7u0eoJO5qFw7jL26GZel
	 ryuTQzRxvnXC8griTZRGkM7wpGcDnnmKlJIBSSmAkOC1WuPCCoXojiKdNCoykNAeSR
	 j5jtlWBKLUfXw==
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
Subject: [PATCH AUTOSEL 5.10 03/38] drm/amd/pm: fix the Out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:35:09 -0400
Message-ID: <20240801003643.3938534-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 01dc46dc9c8a0..165af862d0542 100644
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


