Return-Path: <stable+bounces-10146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B68272A9
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F881F23621
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D173B4C3BB;
	Mon,  8 Jan 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="of1nWgj1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B16D6E4;
	Mon,  8 Jan 2024 15:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2B4C433C8;
	Mon,  8 Jan 2024 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726904;
	bh=6vZ6SV3nz8V7DsF9KM0rAG1775doO2PUi+wcfF24otk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=of1nWgj1Xs4psC2aecGxS0abEVIxkkW1MOqzRYWfMaQlibYLNlcc7mYB5dkGHUuJK
	 eBbZGtC/FUaBb5oQwoGGeImmcfauuykJRZQYVZwbCvbTXirarPJhGUjZEBRRrGZWtX
	 FB1CgvUEc9Enr5YvaffQXcX12HOMQjaQ4yrZrIqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 114/124] drm/amdgpu: skip gpu_info fw loading on navi12
Date: Mon,  8 Jan 2024 16:09:00 +0100
Message-ID: <20240108150608.216396686@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 21f6137c64c65d6808c4a81006956197ca203383 upstream.

It's no longer required.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2318
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1896,15 +1896,8 @@ static int amdgpu_device_parse_gpu_info_
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->mman.discovery_bin) {
-		/*
-		 * FIXME: The bounding box is still needed by Navi12, so
-		 * temporarily read it from gpu_info firmware. Should be dropped
-		 * when DAL no longer needs it.
-		 */
-		if (adev->asic_type != CHIP_NAVI12)
-			return 0;
-	}
+	if (adev->mman.discovery_bin)
+		return 0;
 
 	switch (adev->asic_type) {
 	default:



