Return-Path: <stable+bounces-13086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C8837A71
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DD71C2275D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2D12CD9D;
	Tue, 23 Jan 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u19jzpui"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68D12CD99;
	Tue, 23 Jan 2024 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968956; cv=none; b=cKFY5Q3BFa5E5mQMWqXSuw6R5uQJ3iGCbDe+uGbK4GcJlPFql3PNVnPdMv1IlGSK2aEEY9eY57Ht9t/QmY6LbPD/qHbb/ZE82O9REnq8eMipml/MqAuQ4jZ7qxvxxdcDF6JaB0neO6+Af4u/2GboO0w1GAKndpbOYrhvi7RIcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968956; c=relaxed/simple;
	bh=MtOxzWvxV9LMSxSDSWD6rB7lieft94X8dVOSPDWgqOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oosyR9U3o+Vf/VZ9T6c1+deX4BcJUNRSN3SKezQgmOUdqybLM4rqZF6CiMvpazRSKe67hQ86hSB8YvfwcVjfsREGQgWu3c6fiw6X3qj/huxIPQEFJVonHyE4IcP2KpUzBRy2TwnFKjsPga1Adfi+0IW01QyEXv8HonoU677eRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u19jzpui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4240BC433C7;
	Tue, 23 Jan 2024 00:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968956;
	bh=MtOxzWvxV9LMSxSDSWD6rB7lieft94X8dVOSPDWgqOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u19jzpuissWhf3SHm37w7fEcvvrYr3yETqrbwBLRicsqyXrMcsT2WTyFZ2tyBXj/K
	 vX1kCFjv2PH00Oi5boTmc30lPIfCUE3yKx/oiBiO2xI4Wiu5cgRquK5BTm1ludmREk
	 DEd/DP0gNv9TN5LzQ74FjBzFdNn7sesLoCVr0GnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/194] drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()
Date: Mon, 22 Jan 2024 15:57:31 -0800
Message-ID: <20240122235724.413187160@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 7a2464fac80d42f6f8819fed97a553e9c2f43310 ]

check the alloc_workqueue return value in radeon_crtc_init()
to avoid null-ptr-deref.

Fixes: fa7f517cb26e ("drm/radeon: rework page flip handling v4")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 27b168936b2a..c7f50d9f7e37 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -682,11 +682,16 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		kfree(radeon_crtc);
+		return;
+	}
+
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
2.43.0




