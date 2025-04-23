Return-Path: <stable+bounces-135727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE765A99026
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156768E0789
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C206128BA82;
	Wed, 23 Apr 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IHN0t47z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A628B516;
	Wed, 23 Apr 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420686; cv=none; b=dvbtgXPoy3u4uS6nkEGhDxzb65Y/htkkChRh4NwTAICmA8OlwEmj4cE0rGc88msnKDUQJ60txTmviWAVKkyzgdJNxeH3s19t3iKx9xYlEyx91LGa4cY47WTzXdMBQfmr7+aZmMMNVGFAJ+xEreJf6Kg8IFxnwVthgO/j6nFoqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420686; c=relaxed/simple;
	bh=W4rtfKov8uLMlMRia0GTBb7yuA7p2T8sILfh7xfyj0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElbUuZssDJfxrJROSMZ6ZMdOmgmhhRi7Tms4TcX9qI+WSwn0BFUBufLYJSivgyooKe7bIN4JG4NzdfbrvXW2/QlCpd/4rh9a6FbHQkvHSnut/8cklwijPVGv+TU8SSn7U0IvvQ29gBGEYZedOknhhuzTMxug4NiV0ciXmWHXrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHN0t47z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA68C4CEE2;
	Wed, 23 Apr 2025 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420685;
	bh=W4rtfKov8uLMlMRia0GTBb7yuA7p2T8sILfh7xfyj0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHN0t47zN8FgECYDQNGRIqg+bS13mglQ+sW+IByQnr1st6bz3mYauIgBfsqVdtGTh
	 9TaN0x4/ix4DQiZfg7aFhWEBvyxgNxYq1bYg2uyHz5Q4kdxwEJK4lLoUc5tERrWhRG
	 WUldRSyC/fpBqDQYsvluck7Axs6x0aC3RPehDM8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 152/223] drm/amdgpu: Prefer shadow rom when available
Date: Wed, 23 Apr 2025 16:43:44 +0200
Message-ID: <20250423142623.369772719@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

commit 27145f78f56a3178c4f9ffe51c4406d8dd0ca90c upstream.

Fetch VBIOS from shadow ROM when available before trying other methods
like EFI method.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4066
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |   36 ++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -437,6 +437,13 @@ success:
 	return true;
 }
 
+static bool amdgpu_prefer_rom_resource(struct amdgpu_device *adev)
+{
+	struct resource *res = &adev->pdev->resource[PCI_ROM_RESOURCE];
+
+	return (res->flags & IORESOURCE_ROM_SHADOW);
+}
+
 static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 {
 	if (amdgpu_atrm_get_bios(adev)) {
@@ -455,14 +462,27 @@ static bool amdgpu_get_bios_dgpu(struct
 		goto success;
 	}
 
-	if (amdgpu_read_platform_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from platform\n");
-		goto success;
-	}
-
-	if (amdgpu_read_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
-		goto success;
+	if (amdgpu_prefer_rom_resource(adev)) {
+		if (amdgpu_read_bios(adev)) {
+			dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+			goto success;
+		}
+
+		if (amdgpu_read_platform_bios(adev)) {
+			dev_info(adev->dev, "Fetched VBIOS from platform\n");
+			goto success;
+		}
+
+	} else {
+		if (amdgpu_read_platform_bios(adev)) {
+			dev_info(adev->dev, "Fetched VBIOS from platform\n");
+			goto success;
+		}
+
+		if (amdgpu_read_bios(adev)) {
+			dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+			goto success;
+		}
 	}
 
 	if (amdgpu_read_bios_from_rom(adev)) {



