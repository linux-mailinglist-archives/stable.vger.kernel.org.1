Return-Path: <stable+bounces-87575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338F9A6BAF
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D416281C52
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B21FAC39;
	Mon, 21 Oct 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PxDSWj1W"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA81FA271;
	Mon, 21 Oct 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519711; cv=none; b=oxRPTj6kJfj11PhvhU4YlcaHBrKeT34t3JAzZvIt/tThz7RQHDUUqCNd2UCDe2z9E226T3VjhfjpRZmtebzT3sbsZJdsf9yAmWkQoamAhcXaJlmUzxcwJT72eN+U+ItPLt+0HDTo2gLN0EbePyqlVT4NwxDVLobyG/ZdG8c8wMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519711; c=relaxed/simple;
	bh=ENDFVzRG/cSHhohHXAlrlu8X8vbG5ayt/Jz55IYFLDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWDlGMoEI8z8+hpliCNtg+8KZO326ysuj8A9DbmHy9jdLz2p0sbQNB6+I2dJQ54dnH6liJhlA22eTfvFKFyw0quuOk3FhY5dqkT6Cqq4Bp3dpi8NfTJi2HXQO2RrqqlAoTc1DTlwL48IHHuxJx58MRHBFlKoPslXR+i/TnOPY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PxDSWj1W; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F4DB1A40;
	Mon, 21 Oct 2024 16:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729519595;
	bh=ENDFVzRG/cSHhohHXAlrlu8X8vbG5ayt/Jz55IYFLDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PxDSWj1W2hRRX6/76+mP/nye+oe6R1f6chkMM+fq6dLMYNQTSaK72ISZ7DJLhY9R4
	 8EgDc1vJVC2+bmbGtD4anOJmLazMkU517fAV+/SHtXKlO+XgaGOmMYiQYJgMjXg+bl
	 WDZFelNbWIhIE5dvbT+6AxXMcGVRY5ONpBdchrmU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 21 Oct 2024 17:07:50 +0300
Subject: [PATCH 6/7] drm/tidss: Fix race condition while handling interrupt
 registers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bGZXTG+tLmXBnXVPFsIwwNa8R3k06EXefciByMbofqM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnFmBOTwVF0bOBCbZHVN0m7QT4O92wtEguXJm7B
 m7b+yARrGWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxZgTgAKCRD6PaqMvJYe
 9egHD/9Lo9BOhehfjhPUQCcW290RdFSEMHDIAgFsTTmDduhcRjjHCntIlVzwBsX/VQjcx1DPuam
 DuNxqbhoKoo+xrbPfbdV38+mEZglw3IxIjha0U8DrrUCazbxdO96fnbCMHUcf/B8kgt9TGDDo9s
 G6RybrCb9SW5kQ8FJoXVyaIC5e8hrV4PF6cn6DEHrzyxYrENcwJRzgvUKiO6acID0VAFmeYP71h
 TpeRScI8C1CFC8UIkR5lqTBIzsj7sDP2Lv0B0x24iLSamA2AK6MHe4Y8VXPlIfYCH+vJYHTl0IM
 EPNW2Bo6T6Ih0m99g/K/SUPNr/uRLjWSwz4Xq8j65w92ZUPq0UZZRas5GxVRU2wSphp2BULgUQ/
 tPud9VxLEVSENWY1nY9t5Z+EJ4KGNo39DS49CLpOs0+uu5mvMjbTbfp0ocyeZ1tK7c2MKNxsztR
 k1EUPY7tDRWPjqhjia9xh4FfIhWnawdMcRWiw/vSaKC563vvJf+IsOaqG0vH24kZQSDQveNJ6Hq
 MC/tYWEwBH+mDihu7eCYnZdmbZMGkuMiY2M+D+thYUGAYLMH4Xxe1p4aYPq7wsMuv9Sq82BpZIN
 vtbPDkpf4tvBZae/V/uoNqBSer5joVTZ0XhMZZ2NLRnXwf63IdkyEf+yYgM2dghgCebLwaiB+PO
 oxTpogasEpFpLEQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

From: Devarsh Thakkar <devarsht@ti.com>

The driver has a spinlock for protecting the irq_masks field and irq
enable registers. However, the driver misses protecting the irq status
registers which can lead to races.

Take the spinlock when accessing irqstatus too.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Cc: stable@vger.kernel.org
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
[Tomi: updated the desc]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++++
 drivers/gpu/drm/tidss/tidss_irq.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 515f82e8a0a5..07f5c26cfa26 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2767,8 +2767,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
  */
 static void dispc_softreset_k2g(struct dispc_device *dispc)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
 	dispc_set_irqenable(dispc, 0);
 	dispc_read_and_clear_irqstatus(dispc);
+	spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
 
 	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
 		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 3cc4024ec7ff..8af4682ba56b 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
 	unsigned int id;
 	dispc_irq_t irqstatus;
 
+	spin_lock(&tidss->wait_lock);
 	irqstatus = dispc_read_and_clear_irqstatus(tidss->dispc);
+	spin_unlock(&tidss->wait_lock);
 
 	for (id = 0; id < tidss->num_crtcs; id++) {
 		struct drm_crtc *crtc = tidss->crtcs[id];

-- 
2.43.0


