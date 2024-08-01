Return-Path: <stable+bounces-64979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C30943D31
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FD7B250B2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD5115886C;
	Thu,  1 Aug 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrMuEkuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E721C2D89;
	Thu,  1 Aug 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471835; cv=none; b=JkU8ePE0KkazPfwQOcwjE0TwVlEH5RUrlO6mG9EHgjIYkiIugN/cqJapeHz+GNUdnhqVV++JxS9txsNN7KYRx1pezhvnA8Je2YoaN9bdJuYjZy1PWiHS4W1IeLio3LvAvYmC+MLYkXxkWxLUca6bJgP2ufb/ybRcqrQAwLnqS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471835; c=relaxed/simple;
	bh=rs265Eabs7+n1qPRTK7rDrTVs/3rT++TtXpzWenxFoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg140syNDEh3NgQ7oiAvIbBR/7/06qo9jsLjuQt5iidlN4Hj06R0PkNmEfRmVv25H6oS01Dxcwyg0+AdMsJ6EA2m2FNyTBHgozBLgFxmnHB9YquaSTMapS34mhEDcPWeKnY9C3i+tUeisi1/y61GZsdWw535LHSJeDxmdD7bod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrMuEkuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC6C4AF0E;
	Thu,  1 Aug 2024 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471835;
	bh=rs265Eabs7+n1qPRTK7rDrTVs/3rT++TtXpzWenxFoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrMuEkuRlE6C2d7eJsdTqbRz0p+K894YjcAhCi1TLOHn96Po8VLK3v2MaIVKSdiTP
	 H0NX47S4MDqLMa3S6AKYxdc2alI4Cgub4LW+V5MCy4rqAErb0biMU5/2P4aelS4+/m
	 z1eHVQLHSWzmDiKDdD7kFRkZjMVxoF/mpTBBRLbm8KcsgcnDeua5zKBbDtZXln9V/6
	 gf2CUM0Cyaf7ixlX6ukX1zVhD/aSJcVDI7Bczk4sk0RarRRP1euyUV8uq97pg+wmYI
	 PjUqXjm+8n41qkPEfng7oAYxNPosaimjd0id9G29JlE2XITcev+xrD8OnawSdnWuo2
	 LWMZvoLHWY/qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	Likun.Gao@amd.com,
	shiwu.zhang@amd.com,
	Lang.Yu@amd.com,
	YiPeng.Chai@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 33/83] drm/amdgpu: fix the waring dereferencing hive
Date: Wed, 31 Jul 2024 20:17:48 -0400
Message-ID: <20240801002107.3934037-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 1940708ccf5aff76de4e0b399f99267c93a89193 ]

Check the amdgpu_hive_info *hive that maybe is NULL.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 429ef212c1f25..a4f9015345ccb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1336,6 +1336,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 	uint8_t dst_num_links = node_info.num_links;
 
 	hive = amdgpu_get_xgmi_hive(psp->adev);
+	if (WARN_ON(!hive))
+		return;
+
 	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
 		struct psp_xgmi_topology_info *mirror_top_info;
 		int j;
-- 
2.43.0


