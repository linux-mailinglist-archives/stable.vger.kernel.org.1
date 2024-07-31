Return-Path: <stable+bounces-64871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C7943B4E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE291C21303
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E705FEED;
	Thu,  1 Aug 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6Pkvlny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142E143C51;
	Thu,  1 Aug 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471231; cv=none; b=Gu3/W208jlHvYLMGT409m1w4jsI56OzAmha5fkcc9Mky6/7RPep/Tw8LOO3V67oSCAf73ptef8B9iEbSFBt4ONGYisYAkuVCpUZg/MsN1mGCGny0d6zT9zTAcPPek/fHim7JGdwfayOhYBPELpNIkzuXb8aCGlF128H1Bo6B2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471231; c=relaxed/simple;
	bh=5dcuLI2tFaXB4csI38a2w0530+09filL6oAzHdSXEIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBrAzwk6gpAfdrRkyhb/pzgsT0bLuWMhmOJSWo9bHwI/XmS85HlBE3JLRZKOm39S94j109r4s5bJu4Q9n8Nqj6kdcHoiQTwWSfq7tSpZNCYLuXg/sOrW215MbYrhEZkjug3zfNAoSiBR0rPrCiblyOskROwwEY0k5PE8pua36xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6Pkvlny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B02C32786;
	Thu,  1 Aug 2024 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471231;
	bh=5dcuLI2tFaXB4csI38a2w0530+09filL6oAzHdSXEIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6PkvlnyqOmiAjoLojYCUT4AUo6sfK0dTjdeMl4ov6D/d9kx6IKnbi1jtBxrae22P
	 6M+7txgpo17htmiHfeWTunSETNLijJs9qxvd4v9UzsIZFDmSLfASiNLVcPbc41weQN
	 H/P4Ko4ArJWI2n2RWoMGHMKEK9zoDSCEQETnC3BFRzkKJ5HhwoydkXwQP+6lYC+GRx
	 Kgrh7ChKpwwdWSaofejTrxVAIogzbM2yVDF0mpnYRXm+7CwqXj/bDLcr9dJ8bPKux7
	 uXhIsGJE+gX19l8zgBgvqMNTYy2bflXsyXKT8gCVkc4EmOgLzcdC+JU+GEO+hbfFWx
	 raZXezE6p3TFg==
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
	YiPeng.Chai@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 046/121] drm/amdgpu: fix the waring dereferencing hive
Date: Wed, 31 Jul 2024 19:59:44 -0400
Message-ID: <20240801000834.3930818-46-sashal@kernel.org>
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
index cef9dd0a012b5..b3df27ce76634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1375,6 +1375,9 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
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


