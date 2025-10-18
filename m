Return-Path: <stable+bounces-187838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AABED0B2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1FC1887D05
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B752D8DD6;
	Sat, 18 Oct 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNIh9Nn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B21B4F1F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795467; cv=none; b=DQqyK8EVx6l62zAAeXNSy1G6KPPxMsiL7Xk31rW4RMpfKSdR2zzdPl/L8zXwKlYEQOt/sYZwP4vYRq5VwF6tY8TMqRFFVf3WoGIHR8OKAgOTMgb6YCQAumRktPe/mv1QiPlkCFI7k4Kfi1qrh9USQAWvSgTSUdGxFNe4UITddX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795467; c=relaxed/simple;
	bh=tiLiFh5+RjBM0YQ8cyw0CmAXwp5UA1QsMsDXv4GCVBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIOvDbZ3BM5W38AEQvdxOrAhXF+k5Oy0lLb/VuxOQmS4/S4TETvPsSHH9/+CcKt3jH0V+Ne/AXVCoVGeUlY9899EHjn0jvDg240QOWBG+px5aFYbwK/j7sqUFPcJo91zQKZjTd6MnkAJ3V0AmgtzM+MfABp5gjUe8y5ctUVxYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNIh9Nn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E2AC116B1;
	Sat, 18 Oct 2025 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760795466;
	bh=tiLiFh5+RjBM0YQ8cyw0CmAXwp5UA1QsMsDXv4GCVBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNIh9Nn+aZmiGxDPGUqNj2zpGSXfzqIWL1sYLojh2hZldTXeLYMqjm/Wmvn3Bqiif
	 7FsNVw3Zp88RK/JSCcTw9D4LiQpT9aXjLDgZYxXhWL6+bnACbJ6OKykk9lnrMCKU7u
	 uLL4tqpqD0x8Q6YtClqtiPZXkLxjnP+PPNXF4HJUXJKtl9UDt1it7/qdwHGzbbwXCI
	 FnJySEKMM2GMgH71OQQSCirzA+bO0QFWxlDGXDokLflX6yhrLQfnsJ3xwFvuEMqj+n
	 0tmq3/Y4zxd/LVa968sxY2AXn87YpGgMLeudoskoO1tNTtK23K6rvaUmccgxO+tqUu
	 Qd924rSdMoBWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Crudup <kenny@panix.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 2/2] drm/amd: Fix hybrid sleep
Date: Sat, 18 Oct 2025 09:51:02 -0400
Message-ID: <20251018135102.711457-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018135102.711457-1-sashal@kernel.org>
References: <2025101656-trailside-reabsorb-e368@gregkh>
 <20251018135102.711457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 0a6e9e098fcc318fec0f45a05a5c4743a81a60d9 ]

[Why]
commit 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for
normal hibernation") optimized the flow for systems that are going
into S4 where the power would be turned off.  Basically the thaw()
callback wouldn't resume the device if the hibernation image was
successfully created since the system would be powered off.

This however isn't the correct flow for a system entering into
s0i3 after the hibernation image is created.  Some of the amdgpu
callbacks have different behavior depending upon the intended
state of the suspend.

[How]
Use pm_hibernation_mode_is_suspend() as an input to decide whether
to run resume during thaw() callback.

Reported-by: Ionut Nechita <ionut_n2001@yahoo.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Fixes: 530694f54dd5e ("drm/amdgpu: do not resume device in thaw for normal hibernation")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: 6.17+ <stable@vger.kernel.org> # 6.17+: 495c8d35035e: PM: hibernate: Add pm_hibernation_mode_is_suspend()
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index dbbb3407fa13b..65f4a76490eac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2665,7 +2665,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* do not resume device if it's normal hibernation */
-	if (!pm_hibernate_is_recovering())
+	if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
 		return 0;
 
 	return amdgpu_device_resume(drm_dev, true);
-- 
2.51.0


