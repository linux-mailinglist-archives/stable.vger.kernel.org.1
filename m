Return-Path: <stable+bounces-133822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D6A927CC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E036B4A2A23
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE57257453;
	Thu, 17 Apr 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWJiAXn7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35B2571D2;
	Thu, 17 Apr 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914246; cv=none; b=THDudeYp28wroNqM0g66uyQ1YUk7Q/5sTeCTuYihY34ZQg+S+W0ltVF2K7BAG5FhirTVI8Q616HkyNDCuAWYXFofJ5foeMe+1d3RxMlKvND7AGbV47IvmW2zBjlMVZFXFdVz6dBfoq7S0QmSKOEOgvlvsO742ltDFRJHlFltrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914246; c=relaxed/simple;
	bh=9Fr3JSiZzQdjHuO2BSxsNWTtE7xk7Zjh4+BWiI4GLyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZbrcUa0AxbJmP2KznUXkw2K1mQr/kVwStim89qk9pfAva5HbjLK4PiOoc6eZnyx00mDLy52GNwOElZ1R2pixafN+CynCCvmgAXflqOBKypuxVT7pioO3bi68NAucpT7WZLCJN+yfjBhbuvSiwadrQpjsK8OalQKtc8RixH5M+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWJiAXn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B878CC4CEE4;
	Thu, 17 Apr 2025 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914246;
	bh=9Fr3JSiZzQdjHuO2BSxsNWTtE7xk7Zjh4+BWiI4GLyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWJiAXn7zxy8efKjk3QwYltI6ZMizbHoQT4tFpC7FM5zi4D1OEOJOEJOnVP2NFc5k
	 CeHZcIY2tWRgR2LGYRdi/+yKgEBmlW5Oq30qH0jEpQYP8PWiDRqlSWprDUmynhxhv1
	 DKwg5vT+hSHFo68aDK5KaiTq5s4E1Mn1osLfTFJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 154/414] drm/amdgpu: handle amdgpu_cgs_create_device() errors in amd_powerplay_create()
Date: Thu, 17 Apr 2025 19:48:32 +0200
Message-ID: <20250417175117.630875512@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 1435e895d4fc967d64e9f5bf81e992ac32f5ac76 ]

Add error handling to propagate amdgpu_cgs_create_device() failures
to the caller. When amdgpu_cgs_create_device() fails, release hwmgr
and return -ENOMEM to prevent null pointer dereference.

[v1]->[v2]: Change error code from -EINVAL to -ENOMEM. Free hwmgr.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 26624a716fc60..f8434158a4022 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -51,6 +51,11 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->adev = adev;
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
+	if (!hwmgr->device) {
+		kfree(hwmgr);
+		return -ENOMEM;
+	}
+
 	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
-- 
2.39.5




