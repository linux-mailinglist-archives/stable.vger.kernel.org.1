Return-Path: <stable+bounces-193162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D40BC4A0EB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D760E4F397A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0924EA90;
	Tue, 11 Nov 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aAsaDixf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93C1DF258;
	Tue, 11 Nov 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822444; cv=none; b=BvnEj58J97j/HBeyUkttIBDFTp8wh/riYkG1ZFRiN/Un6DjbHV+1jSb4G4HlV+dz8JIXd4LjHKdZaIFr6yhzyby4fvk+mHXKHKlVTyDnA0Ud37K6ZLU5rXfYfe3Vv5pQcxDjAudM0aBEnJDSwcPnzRDefJld2WXp+IyOOQhR3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822444; c=relaxed/simple;
	bh=PE2XE7kTrN/518qo/4Y5V4L5qgMoQzpSTcg+Ytap1iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOoyzKN/raVrwVGUGs3GIl7XuCAp1m9z2bBeIV2nRXrKkcTwhENaIVaiYZHv/pLAZV8iF2h9zJR4kf5+VUBlKXgFLtzyYuxzhyzsM0LD/zueUv5vurzPLC493fDva5mxmsw+TAorruXwASe8W+Z7fM6MGPp0tFCS/XgBNZ3/p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aAsaDixf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9DC4CEF5;
	Tue, 11 Nov 2025 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822444;
	bh=PE2XE7kTrN/518qo/4Y5V4L5qgMoQzpSTcg+Ytap1iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAsaDixf3yK+qYbedwD+86Y3257rYuFdtqW+GL9EBEefNoIlpO6Nm4pcxtLdxPpTc
	 +Pf897NdFZpJaOIsPzaikcBVMvopbX7JHV2WRml0wIXS4Hvm7FQZ8TEmLL+nAYWS7n
	 xHerOfvOQhx9CG1fZHP2+/xK8w1IoevOFZp/ASb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Smith <itistotalbotnet@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 082/849] drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
Date: Tue, 11 Nov 2025 09:34:12 +0900
Message-ID: <20251111004538.403589600@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Smith <itistotalbotnet@gmail.com>

[ Upstream commit 07a13f913c291d6ec72ee4fc848d13ecfdc0e705 ]

Previously this was initialized with zero which represented PCIe Gen
1.0 instead of using the
maximum value from the speed table which is the behaviour of all other
smumgr implementations.

Fixes: 18edef19ea44 ("drm/amd/powerplay: implement fw image related smu interface for Fiji.")
Signed-off-by: John Smith <itistotalbotnet@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c52238c9fb414555c68340cd80e487d982c1921c)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
index 5e43ad2b29564..e7e497b166b3e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
@@ -2024,7 +2024,7 @@ static int fiji_init_smc_table(struct pp_hwmgr *hwmgr)
 	table->VoltageResponseTime = 0;
 	table->PhaseResponseTime = 0;
 	table->MemoryThermThrottleEnable = 1;
-	table->PCIeBootLinkLevel = 0;      /* 0:Gen1 1:Gen2 2:Gen3*/
+	table->PCIeBootLinkLevel = (uint8_t) (data->dpm_table.pcie_speed_table.count);
 	table->PCIeGenInterval = 1;
 	table->VRConfig = 0;
 
-- 
2.51.0




