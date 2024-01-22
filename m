Return-Path: <stable+bounces-12941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85108379C6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061AF1C27542
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F1A1272BB;
	Tue, 23 Jan 2024 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IxhxcgTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538521272B8;
	Tue, 23 Jan 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968496; cv=none; b=MV8w+sWWnsA5tSFLFR+lQ9TG5wjkEMiWjDiFNYRtjpR0geJ8MBN/ixzNq81EyBEI58mFRAEODbCWfDuS1hC9nrnLAFZzY6bcPnBAiqSnkliguWbxFuta/7evWYqRcsyyRim7Lb4m+dZ8nBifzjz1V2MtMXoYbCRWY0xgpCdnxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968496; c=relaxed/simple;
	bh=IIrHV/MUtlkO3Q1rcxzb9CpZoX9ZkBavGpbYcDa8Dzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9TMN2H+fEHAthgGb4g4cdgOn0b6qJkbRZCrsT1IpAIHBty/gs+GEAbQYzbIVN7VIfexrXaL5hcnWNKdtwqpfDEAAKel/Br1l+r7i3pPk5Wh9fjRJUWOK1ZBIpGmikhHIc6cYqfVKJtADzyFM7I2pspDa8HZjrHl6ULDGXcn1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IxhxcgTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E72C433C7;
	Tue, 23 Jan 2024 00:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968495;
	bh=IIrHV/MUtlkO3Q1rcxzb9CpZoX9ZkBavGpbYcDa8Dzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxhxcgTAnXckgBTfqcVtuh4AkMP7mkhKFH0xIfx4OAxPwNPS7F0GzmNFCv4ouYBZv
	 8jd3reZ8+Rj6Y7v3Msv6nvLnbhGwf4cJDmyxNx74AFes4DhNqLBTFBm3kqVuzTDzhH
	 8wGQNHr70qz15JFE9f0pd9UZkMnBktFeFazbCrcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/148] drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()
Date: Mon, 22 Jan 2024 15:57:33 -0800
Message-ID: <20240122235716.314624809@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 5985efc5a1f3..b7308ed7e266 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -676,11 +676,16 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
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




