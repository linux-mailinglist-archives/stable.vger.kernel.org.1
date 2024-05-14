Return-Path: <stable+bounces-43993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9498C50AD
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D93E1F210EE
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57E13E41F;
	Tue, 14 May 2024 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RtK6zxAL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159413E41A;
	Tue, 14 May 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683572; cv=none; b=GUSvKRIQ1rEamzqdjc8XOcDnIdwd38mxKUCnY0d0BH1Dinob5IrQ6Aw9soOHUM0J4tnLKuqBWYcndGecYhm6/sVI6QfBBbrvC55yNUcWXRXyX/9BWZarukscwW/2LJuIG7nzOiNHxGcIXvFOUc3JsCmQ/+00BCqO+wpIq1lGIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683572; c=relaxed/simple;
	bh=uCaoZdtiXbOz0b13rA4416eFyHNXyNSFgWur1N0FnLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4AmjjVR82bo6iGITccsWzfgs4ujNRO7Lt/I/di7IjUuQdVgtg4SIws9Y/j70J2BYhjhQzfDtV6ypHdXmRoE2O7bjBqnAkyYXpKc0kKRxtB+7IubWI0GQH0em44jSbMY2WTskQldQN7S4u3n1TH7yqJ7fTsRMoL6tTDDMgoGOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RtK6zxAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE8C2BD10;
	Tue, 14 May 2024 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683572;
	bh=uCaoZdtiXbOz0b13rA4416eFyHNXyNSFgWur1N0FnLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtK6zxALkVtuqhxMIoR6tbrjU6e34pTfFMnZKFC9vDM4awmfT6Ip13TzxaRIZRAxz
	 wbkMeY6I+OuFxmjWfrFecyo7oDlYJNLth024ROcBKEfTBOHMDti2Ef0rMlrvAk13cC
	 vRL/xCOqwja1l19rm9F3KkhImIldR6vsiGVz+Xck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Huang <Tim.Huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 237/336] dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users
Date: Tue, 14 May 2024 12:17:21 +0200
Message-ID: <20240514101047.562213361@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit cd94d1b182d2986378550c9087571991bfee01d4 ]

Limit the workaround introduced by commit 31729e8c21ec ("drm/amd/pm: fixes
a random hang in S4 for SMU v13.0.4/11") to only run in the s4 path.

Cc: Tim Huang <Tim.Huang@amd.com>
Fixes: 31729e8c21ec ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3351
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 949131bd1ecb2..4abfcd32747d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,7 +226,7 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix) {
+	if (!en && adev->in_s4) {
 		/* Adds a GFX reset as workaround just before sending the
 		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
 		 * an invalid state.
-- 
2.43.0




