Return-Path: <stable+bounces-133848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2758A927DC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B4189C440
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDDB25FA02;
	Thu, 17 Apr 2025 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZrqWZ19U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770225F992;
	Thu, 17 Apr 2025 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914329; cv=none; b=KOoKvZQjaLlJhesYvOUClX6IjGEgXCqD8Vny+6jUrDAuSyZlsGV0oClArrJQkiNKzN/R86N8HAL/TLwEiU5ye7X32qPKY9jBnHBmA3lGygxdhWQCIA+2T1qdIQP3mcXI7uiOGZ4zmpiQ+Om6reF66FHpzNiEIeppfR1FvPIJz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914329; c=relaxed/simple;
	bh=Cab52mvFIAtPWqvecnEkr+3+9N8ScHnqrA7pKKQV6sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiJpITu+r7ZyOmvhYtIc1z38iIcoH9i3/wrfsgyIcTd1ESQRepAefgbf5zaGCHUYOoCUOPlpdehc07poQiDpJ5SiSORfFRAZBvOfYl7yoXkmJ/sWVpw+gpQtgfW5kY/fIyU3FgH3Uv3nebVxbS/1RdGuKk01nSE9n7CmNsoVM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZrqWZ19U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A06FC4CEE4;
	Thu, 17 Apr 2025 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914329;
	bh=Cab52mvFIAtPWqvecnEkr+3+9N8ScHnqrA7pKKQV6sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrqWZ19UGxLOApJMfWBhucdxcAoXO6X2wZWYNHhwqHLtzTC/vnkUW0E1j0/Cl+b7p
	 Gd3Q2IttitgtKG7tN6yzU+wHT3uUPDTNGVEXcfyOfhK4xMnGvMoUOdrbMozoc4BQrp
	 ettUf1Lt69TpooOguAUN8F4yO3eEjPi6NfnPwCoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 149/414] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu, 17 Apr 2025 19:48:27 +0200
Message-ID: <20250417175117.415007130@linuxfoundation.org>
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit fe9d0061c413f8fb8c529b18b592b04170850ded ]

debugfs hang_hws is used by GPU reset test with HWS, for MES this crash
the kernel with NULL pointer access because dqm->packet_mgr is not setup
for MES path.

Skip GPU with MES for now, MES hang_hws debugfs interface will be
supported later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 35caa71f317dc..463771b7dd4a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1519,6 +1519,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
 		return -EINVAL;
 	}
 
+	if (dev->kfd->shared_resources.enable_mes) {
+		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		return -EINVAL;
+	}
+
 	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
-- 
2.39.5




