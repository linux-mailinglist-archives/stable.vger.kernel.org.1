Return-Path: <stable+bounces-13127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE2837B49
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B200B265B5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB312FF67;
	Tue, 23 Jan 2024 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8hi3Vl8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698612F5A7;
	Tue, 23 Jan 2024 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969018; cv=none; b=IyoTe76FNLZlvxIPcfX2m8PPSE5l7laSY710l4I7YMnFhTsZqBWBSlFbWQxYcs0caxtbzWf1LKmzp5DMWVdUUOR0qbSqsc9VlNYGLfmo77yzWVPSXDQ3ppPVP5H8dZ7VWKp4cF8cNbHkfs3F/vvi9GZTwl188UgZyBaRau4VGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969018; c=relaxed/simple;
	bh=BVn12pJa/tLgogceAFesw0LRy4+elAnkqJ6ix4XFeJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOwzPlg8CToonTHt32kiLUtfds7R73vVETcmsc66t8vJIz19jWXem5dsWSmCnJwJx2pLwEf/HI4kO8eL51y/0/MgFxVJQTMOUGQM27FssAcIU0Oq1qgGUQWUSHQVVLp3crxyxN5bKY8NcfsEU+Fv1f5mXMwBJL7uXBOgR8AaoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8hi3Vl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB15C433F1;
	Tue, 23 Jan 2024 00:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969017;
	bh=BVn12pJa/tLgogceAFesw0LRy4+elAnkqJ6ix4XFeJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8hi3Vl8MlbERRwc/UB2l0poPlz4L/6nu93ykC5UYwDO/ZVa8MvYG9aWhMfQI1C7t
	 cPDX3iNBzjxhPKtZP3vykm+qW9omdzsiVuLnxrTTrWTySn74tND2J5ARMPFRvJpwNm
	 J/aMVgJa7hmvCapF5GEzNMgLqp2+2u0b5FUZJAos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Lu <alexious@zju.edu.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 128/194] drm/amd/pm: fix a double-free in si_dpm_init
Date: Mon, 22 Jan 2024 15:57:38 -0800
Message-ID: <20240122235724.725717509@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit ac16667237a82e2597e329eb9bc520d1cf9dff30 ]

When the allocation of
adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries fails,
amdgpu_free_extended_power_table is called to free some fields of adev.
However, when the control flow returns to si_dpm_sw_init, it goes to
label dpm_failed and calls si_dpm_fini, which calls
amdgpu_free_extended_power_table again and free those fields again. Thus
a double-free is triggered.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 9931d5c17cfb..6d7fd45b3129 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7349,10 +7349,9 @@ static int si_dpm_init(struct amdgpu_device *adev)
 		kcalloc(4,
 			sizeof(struct amdgpu_clock_voltage_dependency_entry),
 			GFP_KERNEL);
-	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
-		amdgpu_free_extended_power_table(adev);
+	if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
 		return -ENOMEM;
-	}
+
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count = 4;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk = 0;
 	adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v = 0;
-- 
2.43.0




