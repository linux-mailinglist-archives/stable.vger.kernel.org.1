Return-Path: <stable+bounces-65095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC48943E59
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC411C22574
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C514A602;
	Thu,  1 Aug 2024 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W68kasZU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482A1A256A;
	Thu,  1 Aug 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472397; cv=none; b=LfAfo16mYnGxMcZmNB+FDDINtpTv2p30WLvDBXKw6N5JMao4XlSOXd3yCL5NdPxtqNB6GAvcK2JJnPNGptT4prnJ5QZMnj0aPKHb0KjEPMVlYKuQzfVP7x9jKU6o/LFRVvns8nLMSj6t7NUZ6hTpRkyjg4otFeaVrAtMS/2UeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472397; c=relaxed/simple;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do/VIowkaOEFCLwRduTS6PdRoqRuQugY3ZCeDfVwPjVrRE6GvjbOhFnx/nI+8sVon3MMwumAbjpBnIpupevfAHwi+KYTBq+BAK4L2DN303aApP8uDKDjr90BJkPvbTHBhk+XIpSnLK44wnfpP/UqgvYkRtkaQlBqEjxCkHpeZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W68kasZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF36BC4AF0C;
	Thu,  1 Aug 2024 00:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472397;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W68kasZU1SQCezkOuysJGTVDQ9dExKo4+VCgt+0TZ6jUpElPNQMEwDKzFEqGWXMu9
	 ZzeT8Owk23GSSjj2x0I1eYWbRb2BRLZNC1pLCCkZ3mbMadXEYpiQAXFvRNrzIFgk6D
	 0IwxZ+06vzobbs+/72Jp70p+e0uiMbQ/R6gkMzN51kR8alPLuturpVrSbZ129brPU5
	 WV9oxyjPIY7Kb9d6Zu+vmyNiBgkT1s6P9K0rUPGebSsyZjP2QM56jUVs3GbhXeI6wV
	 qSxtkvl/iVrFXRZpnSXijx2cLEFXLoudH2R3ZwIMScqp+qQGmdjTsoqo7ALwGzol8a
	 nbGTBgEHuJ5DA==
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
Subject: [PATCH AUTOSEL 5.15 05/47] drm/amd/pm: fix the Out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:30:55 -0400
Message-ID: <20240801003256.3937416-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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


