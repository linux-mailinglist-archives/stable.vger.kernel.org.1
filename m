Return-Path: <stable+bounces-140788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75243AAAB2B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8A217C813
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069A2E62C2;
	Mon,  5 May 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/1uejF0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3135C922;
	Mon,  5 May 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486262; cv=none; b=oWHOGDKfLVutIdT61t6RpPvgeMkEXSp2+gA6Uc5RhqwXvWWK7pv2HyGavR2LLC6dJG0CIxwn8Ot2zk4bZdRACcpBTvc/vRFnYQtqhKssEIVXXuGPMR4REqqsAhjhfiw0I74wbEubnmw4nZdOUwKvTNWpYHnb6ru2QE7x8wYcO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486262; c=relaxed/simple;
	bh=vaEVeBrYr3rHS3vtdbcr8RIrO4o6QAz5RJrmEdmJi18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADfVDgPELX4PBCicAK6EwGgEIZEabOWbRyHC894iveyeb4Ey1NGP9yaWtP8qxxWj+jyf6ytRuXCrMRoIWDX2JrCJt+by7eGKtzOkZ34TrD9FLNdUwy2+Oo10iLVxB3A0gVFlLcHqFGhq0Sfw1pMXGeLO6VSPbppfYTHwBgWqJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/1uejF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C84CC4CEED;
	Mon,  5 May 2025 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486260;
	bh=vaEVeBrYr3rHS3vtdbcr8RIrO4o6QAz5RJrmEdmJi18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/1uejF0gYCenr7lB8bMHJULnjY598qDev8E6Wtcj+6BGLIgWIcy+k8MzIKX1NPCa
	 Q6dqs1jAyKipVfybZAozrMUhNMlAsOT/w4+gIptLtHzWJPE+LNLQyAuGimAHZWBTEX
	 m9nWUPciWYFH0uI0jHkBsvIhhy8u9zp+qodW5IGs+OH2TorV7EMfRA2azpk7je/pme
	 Kb9WBbKDuAvlyn9jXQ95YFxLIdbsI7rfeOnhOBTHkDn5SnFO5+3wpqWCNcDcxfB5i6
	 RA03skIxORXb70idFUrLw0jnHNz3ylDO9KUYDFQhdX8xP5gXLfJw/cvNmrSqb1jtPP
	 +4s8sD/J5q1nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shiwu Zhang <shiwu.zhang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	sunil.khatri@amd.com,
	YiPeng.Chai@amd.com,
	candice.li@amd.com,
	le.ma@amd.com,
	Feifei.Xu@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 228/294] drm/amdgpu: enlarge the VBIOS binary size limit
Date: Mon,  5 May 2025 18:55:28 -0400
Message-Id: <20250505225634.2688578-228-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Shiwu Zhang <shiwu.zhang@amd.com>

[ Upstream commit 667b96134c9e206aebe40985650bf478935cbe04 ]

Some chips have a larger VBIOS file so raise the size limit to support
the flashing tool.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a4ab02c85f65b..ffa5e72a84ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -43,7 +43,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
-- 
2.39.5


