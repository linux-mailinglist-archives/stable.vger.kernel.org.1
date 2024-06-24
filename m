Return-Path: <stable+bounces-55104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A491582C
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 22:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB2B1C2361D
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1B1A0AE3;
	Mon, 24 Jun 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="WbQZOXCf"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9E1A08C9
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261708; cv=none; b=hlqGJmX7ONKjOT0Kch8516kMltDBOiILTjLxkq40XYuH7nxMIit6RBwE9reJy41zjJtcLak3NHCcGXXd0Cb9/PwXhKH5H7KrEN+iqwZk2Xk2fORDysPvXJKtMCowqqoqSlLawIM1tZFVB9uMAp3UJn9mUAC0uZcQxITy67okeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261708; c=relaxed/simple;
	bh=TJYXUnEmRvQ3P5Iy0fK8m2XiYoFkyeN9sQ7dGAci6kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5aSQ9BImwpQyeSUBfEILm22vNySYMI6sL2ncVaYJ0jwlTIb7/kZDLT0UjlfGtMe2cWgLacD/HyuIZvra6kjCuRXnXDYIsKrigg48t+H0MoLY1XCraz0Z3/LeJkpCS7keiqNXwBrsREEK2PMeSgAm0q9WQBCZ0XFhnJ0IEYmEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=WbQZOXCf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1719261704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hjt3C9pL92UZVTHccpVfXiMxQ9kX8axxehFDYvZWg4M=;
	b=WbQZOXCfxxNpDlQsKDmAnAnvprp35IDeWA1DfhJpU35jWsGnotyp4UU6PXcdibnptQ/O8M
	sYXc2DjwqQUj+KiFjXUaRkQQFmPsznFNa4Y1U9p9nKqcAP6Z+QUmlX+kJ73XhFG3CLGso7
	qjlDUa+pFaZ5Fs6ekeu3c8eT0hpJJxhwIYPjSf6SSTauB8Wj77J9tU+pwCT7bH4mgGj4Oy
	3TL7HXfg64HWuCbgeRwtibn+YMhjG7S6rS4VoS1/qwfDYomP+mMjlhBB4AS7wK+3gPpW8h
	5Cy0D6T9iVHQ+0UPYZdv05URWthuH6tDLxe7HgqfN6jdXNIe8f8n5QyyDRSCtQ==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	stable@vger.kernel.org,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066
Date: Mon, 24 Jun 2024 17:40:49 -0300
Message-ID: <20240624204054.5524-3-val@packett.cool>
In-Reply-To: <20240624204054.5524-1-val@packett.cool>
References: <20240624204054.5524-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The RK3066 does have RGB display output, so it should be marked as such.

Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 9bcb40a64..e2c6ba26f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -515,6 +515,7 @@ static const struct vop_data rk3066_vop = {
 	.output = &rk3066_output,
 	.win = rk3066_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.max_output = { 1920, 1080 },
 };
 
-- 
2.45.2


