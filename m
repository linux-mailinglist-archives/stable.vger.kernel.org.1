Return-Path: <stable+bounces-14072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B633837FF9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BFCB29DD0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C562A05;
	Tue, 23 Jan 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtCe6coY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9122062;
	Tue, 23 Jan 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971105; cv=none; b=smj1K6d6nue/IzV/2CgXyF5HOlJM95e9ofT4Jo2adwh0A0QgZ9dxeBCl1MNxsw4Y88P/gOgU9YgoBBTpQuNYsQrgwaYVbDn3tBi0LBRJAfTgkFycvdBe5o65IS9aBtNkYE0E06w6QdiQMPAjPVeFAZKi12sPWPdTel9MbMOJ5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971105; c=relaxed/simple;
	bh=h2hajZE9GaV0JVlkUKg3BInbgO/7MNEPyVnWePTj4+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfm3cQflImSWeM2HcJFXNVK0GWLlWPevmMBxh8G2pbbhdoozKzK0TqZ9cRGUv+FmGFP03vp14m6YJu/aFmXcjiQ6gnP/Ov1MF6u+c8p1YFNcdM+mM/cvYJz+xr2dukv+Xs4TiKa1TDSswnKgl7waD8BETEbYkbcKFHX/sPsJmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtCe6coY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D81C43390;
	Tue, 23 Jan 2024 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971105;
	bh=h2hajZE9GaV0JVlkUKg3BInbgO/7MNEPyVnWePTj4+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtCe6coYpqmb950h5BkTVtxt2HEixkmINWh5cFafNWLcRkhxCZ93sGMlNq+S3dCxC
	 2/ETKtkx9fz6gFpio/1VxHQGDEURaIPObImyO0xsFL15aKa5jx7fMVmijlMdCWk8Sn
	 /DiPgwhO0TxSWqUwZ8ih3LNTpycjo6VYzPC0Kd+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/417] drm/msm/mdp4: flush vblank event on disable
Date: Mon, 22 Jan 2024 15:55:49 -0800
Message-ID: <20240122235758.138462680@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit c6721b3c6423d8a348ae885a0f4c85e14f9bf85c ]

Flush queued events when disabling the crtc. This avoids timeouts when
we come back and wait for dependencies (like the previous frame's
flip_done).

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/569127/
Link: https://lore.kernel.org/r/20231127215401.4064128-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 169f9de4a12a..3100957225a7 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -269,6 +269,7 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
 	struct mdp4_kms *mdp4_kms = get_kms(crtc);
+	unsigned long flags;
 
 	DBG("%s", mdp4_crtc->name);
 
@@ -281,6 +282,14 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
 	mdp_irq_unregister(&mdp4_kms->base, &mdp4_crtc->err);
 	mdp4_disable(mdp4_kms);
 
+	if (crtc->state->event && !crtc->state->active) {
+		WARN_ON(mdp4_crtc->event);
+		spin_lock_irqsave(&mdp4_kms->dev->event_lock, flags);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irqrestore(&mdp4_kms->dev->event_lock, flags);
+	}
+
 	mdp4_crtc->enabled = false;
 }
 
-- 
2.43.0




