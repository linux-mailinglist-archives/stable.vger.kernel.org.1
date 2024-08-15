Return-Path: <stable+bounces-67979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A5953010
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797DE1F23AE6
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797491A00D3;
	Thu, 15 Aug 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fe4e06c3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271041A00CB;
	Thu, 15 Aug 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729118; cv=none; b=YT39D1kUmkzcDuQZOey1LqBzdF2i+bgK5pRJFUklXhdk4iYRZLOFbjAg6Yh+iETifpOmoazymGTAaEQikPFP/MoQWyBkG6Agq4n2TY/2tYij9Kd4ZVN3QrPI8x3yf2qpHrng63TKYtLWw1tWN6LgrSUGehA5gVgI0kYiMUPPg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729118; c=relaxed/simple;
	bh=V+lyD9PUka1dFCus5eGc/d5LL+/hKkANUX8ataPVOro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDMFqIC5WvUxIIB3Hh3bp+TDWSOraSaJSW0hH11vpI9TgnaIt5UoMB0VJiDkL7M90afPmF4QEF0LY/ViyrH6jEjtNXKCxb0ipPJ5Xn/sj/Oepc2XMLA/BDKkRHBFb58eAC3nDRMxo2ZwB3aHYUsv1+datRz0HPeZsJzoHuHezqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fe4e06c3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89097C32786;
	Thu, 15 Aug 2024 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729118;
	bh=V+lyD9PUka1dFCus5eGc/d5LL+/hKkANUX8ataPVOro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe4e06c3/yRm6dlf08RCv19Lm7Z3456oppFAVtgEVVP9FmTCUpuMJ8t9wE8m5V9yZ
	 6rX3IKO9257Oj7w1amCbY/GoSuNl79PbpU/dD0Eu2qC55+Mu6j5YU3uSZV7kjkKWCD
	 5O/rCiU5Qn76ARaYthnNG0A1MPfUZPf9A5kUv3fA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.10 02/22] drm/amd/display: Defer handling mst up request in resume
Date: Thu, 15 Aug 2024 15:25:10 +0200
Message-ID: <20240815131831.361620837@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
References: <20240815131831.265729493@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <wayne.lin@amd.com>

commit 202dc359addab29451d3d18243c3d957da5392c8 upstream.

[Why]
Like commit ec5fa9fcdeca ("drm/amd/display: Adjust the MST resume flow"), we
want to avoid handling mst topology changes before restoring the old state.
If we enable DP_UP_REQ_EN before calling drm_atomic_helper_resume(), have
changce to handle CSN event first and fire hotplug event before restoring the
cached state.

[How]
Disable mst branch sending up request event before we restoring the cached state.
DP_UP_REQ_EN will be set later when we call drm_dp_mst_topology_mgr_resume().

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2418,7 +2418,6 @@ static void resume_mst_branch_status(str
 
 	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
 				 DP_MST_EN |
-				 DP_UP_REQ_EN |
 				 DP_UPSTREAM_IS_SRC);
 	if (ret < 0) {
 		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");



