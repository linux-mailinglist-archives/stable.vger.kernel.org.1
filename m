Return-Path: <stable+bounces-77268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD1985B48
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8231C24150
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59F1BBBF1;
	Wed, 25 Sep 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrplLewe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0E192B7C;
	Wed, 25 Sep 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264882; cv=none; b=tcPP//yFhlYG1ozHiGSzkZl7BUvnMRItP88DrDf4fmPCrAKRwCJO8zoQacgktvdN1wnF8WcmW1Qk2wTEIrbZ42lbyoQlTZA2lRYoOb5TDFUBXcbV0PqApNGJ8DXRzCxoSITUaE/bgY5O6z7kbr3ay6k9YVfTMDkMazBbQEtSnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264882; c=relaxed/simple;
	bh=Jy1jlDlsLJD787IEma8LXNWbNDr+evipQtToshm4ews=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tl/BvNEnDVqwHbZkYIamol8/28EtnwdAxvM36kUzoEsehZ2dgSPg4zR45mMj0CuaJf0d5+CJ/F8trWzJeUy1CZmyjJnTqlJj/dz8vJyRFDFuqcCjf6pCPyhoNEYV7vXltlcbXc0De34AtKD/nigIUkql+rE4jsoZRhQIEOCTJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrplLewe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F3EC4CEC3;
	Wed, 25 Sep 2024 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264881;
	bh=Jy1jlDlsLJD787IEma8LXNWbNDr+evipQtToshm4ews=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrplLewe4C9j2fjTDmkbSLnPkTWJOmVQwWy4E6ycK58Hbazb8qnAfTBSRzud8VXK5
	 JO2cMBI3UsUGXv7GjlN4IHTbDMq+4Uz1QpoDT94BOvr7Nib7tXdOQcvDQQK/Dz5ImY
	 sE8LiEWjbMxhMj7J5DbifkVD7aPNvxOlQUPLKtlbilaV/wF0kGPWJJmSxoXmcv+NIO
	 6iKtmRWV3fiXcdiNCHXX0d/MyDNuLqjtu0UE4ppv6+986ag92u8cQE+6DPtU5zLnzk
	 dlC9eBquJ5lzZvms0S9NcpvC223+VD4Xc2F/9OsxlnLvxUq56KdkLWYN6Pe2Tnjtk9
	 zAqrfZATvilAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 170/244] drm/amdgpu: add raven1 gfxoff quirk
Date: Wed, 25 Sep 2024 07:26:31 -0400
Message-ID: <20240925113641.1297102-170-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 0126c0ae11e8b52ecfde9d1b174ee2f32d6c3a5d ]

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea73..9360a4425c4ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1301,6 +1301,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


