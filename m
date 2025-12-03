Return-Path: <stable+bounces-198324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0BC9F90B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00A433036045
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451F313E09;
	Wed,  3 Dec 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KW40sgPc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D631280C;
	Wed,  3 Dec 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776170; cv=none; b=hLBDxZbzS9vdP4v1+0CfxVaEB0npjosQJQx5DqL/84HSgpE6kjcKo9jyqFyLrPX6pbLmIO8V+4YQl0Cg4WnSgqEf1OlE+fNxMcH4uAIBq30+Gw3MFXsM4PBoGcG9hKQa/Z5IiyXfv7budLSrHzjV9vH/5yoHYXBednA+z0kzE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776170; c=relaxed/simple;
	bh=NuwkODElZcdLF0d6ejy8moQchjn0ZOW3OkhP9bsdbNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dkkh7qWZOX5RG+c4LhUPArQr8P7TI4IavdkLf955V9DceKGJJIGNil/sqOtk6CNurEHbIxr7pxsnDGQfRuPVc0CsJYcmrN+YoVbJ1DX3ktP96olKbasY5ocXy2pWu8Ne0DmTP6KMut6E3h4oC9eUOMBn3CIyWBh0AQJKao40vBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KW40sgPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99870C4CEF5;
	Wed,  3 Dec 2025 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776170;
	bh=NuwkODElZcdLF0d6ejy8moQchjn0ZOW3OkhP9bsdbNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KW40sgPc0Y5qtxbbA91x6krNc18Iwx3LKpubNIur0kFlgeWxK8kTYrkGAg+yqMtdj
	 7Lsj3hlaNqZih1wElwUwDq2ekh/a0180dr0x2yI5mg23ceU414JLEq3NrwW+Q/nNRw
	 6EXu4Uud2wAqufKA1kWes9brCiTUWIpyrfgoTBgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sathishkumar S <sathishkumar.sundararaju@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 069/300] drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff
Date: Wed,  3 Dec 2025 16:24:33 +0100
Message-ID: <20251203152403.177803628@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

[ Upstream commit 0e7581eda8c76d1ca4cf519631a4d4eb9f82b94c ]

Acquire jpeg_pg_lock before changes to jpeg power state
and release it after power off from idle work handler.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8996cb4ed57a8..1341a7f866cd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -87,10 +87,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec);
 	}
 
-	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
+	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
+		mutex_lock(&adev->jpeg.jpeg_pg_lock);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
 						       AMD_PG_STATE_GATE);
-	else
+		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
+	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
 
-- 
2.51.0




