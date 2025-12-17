Return-Path: <stable+bounces-202841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24ECC819D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D3D3062E20
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7437A3F8;
	Wed, 17 Dec 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l+sXsQ2O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86982350D49
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979556; cv=none; b=G8gvAKHYPMcGzJOB6aMKaDT0y0iOH7ak1YyLga85lXEfzrU7DiJL1SW9bsLrFH+xrGA4Stzv4RGiq1U8pN3Yp+j55ss6hjTcCmMf16aBbazZ3OSiiz18fqgoDlb58qLsBM1uSI94EP+VxeLY87ZSHmRFnn451sr4cyiRnBVcnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979556; c=relaxed/simple;
	bh=D2T7TmmZbGv18Uh8J4cdBHWJXJAc+GOKLv2WgixHQ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRxZ1G09tLfg43M06I/BSqfghCNGkEufqcuq+bvk/T9R3M8XGa6nMQONuo45ry5cyvIqA4Xqa608Fw8CNBuWj65LDH/z1eMLmF9+vnO0wI/6kQxo6aM4+Xkojugf0fmhYxb3mLLEI/WMY3mulFaCs7g8S1QkWGMSDtfEuGSsXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l+sXsQ2O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305552so3449093f8f.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979548; x=1766584348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiurWDqD087A+2PBJW62gWLArV1oM1DnASwOeXGS6o4=;
        b=l+sXsQ2OOTrJj+cmkO6cJcjLJM67rKvXtJU8F/MzaxcxCHNrRs3ufrk4lEDk3bGnBH
         146y1mKHl5xJ5viXsnLkQl4aBkeFd/qgLhuElDFeKU0Tuw3E1hJayYzFpIaI9AaxJDjR
         CoTpNSuAYUq56xkndS5K12Txg467ztZT+sprHmQochdVHSwVqJ5tEKIdYWb52uRp5kgB
         Utium2ZbAiSTWzSJO41JMTZ8TNJL0AQhmnpWpBTO4mFNC0d+E5r2EyMWG/jqZxU9Q8NI
         RTsEwvR31II+AF7k+aAHiqER4YUxakNdHc7SHB98sRhr6SqHAfit+1UkyBUJ1u4HcVbj
         pb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979548; x=1766584348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiurWDqD087A+2PBJW62gWLArV1oM1DnASwOeXGS6o4=;
        b=sl4aR5YB51Zt3a3hpKZDvpJDpAYve+/f29EsJff4/GOYKkUukpBBc7vHNRXBVuCebf
         46AFOcm5UJFl9/Y/pDihltI2o+GhIQEA9ZyABHvSXbjeEquMEvDuZMg/Lz00zbe2ehFq
         e/SLU5QWGYuEqQhL0iBko4KCRcID1A6K+GecUvNS62F1KRoT2BXcM0rDGhim6bip/35T
         OW7Ft5FYxjlnGjU3vwW/We2YTIP9nZCtwzS68Zsw+PTYAsFlVJ/hUhoCCFCEg0Pip6sy
         iV6xW7K/GMHqhbyeoV3Cx2Cyw35UqELj/t2QTPtmWcKQ8KHyap0F8GIoqs41rWD+ust0
         kudw==
X-Forwarded-Encrypted: i=1; AJvYcCWUE+FE4rNgwjifdF6FzVxc5TiQ/qsOYoy0O92tg3OwC4dXfM5khip0gkH1vsZMPmO06GjoD7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkOIQVy7y8EHdB6uKxNqZfwf2SfWCkM/Rjck53urKGdCJbEY6
	wMDoxVYipUwiiBiDwKLaF2VSEdcorjm/oWf2UX2hyAwGA+Lxs1W1wv4fTUh83+5hCAI=
X-Gm-Gg: AY/fxX5d0OPA6eatPSW7ViWuCayZZJwwri/X3q4UHo30pjPBWXIV6lA/aNc8++IoGYd
	EP6SlAowloVfnh71Lb406Dv//SvEpZorohfbmk5iJrip4WLOBkiGT5e9eXRqQ4+PucWI2bHQe5m
	DqYzYtMC/G/SvI4+gtSmuqGlR+U1tRROEP4iiwazbsQNu8vZppL45LIynnEsoyiSlJpVHOypjec
	w73Oqwazze3jwQnA52YQKSah5HckWooz2o2LbBCxYwCx2iXVLOG7SxNa7MPdUX2007s9IoKqXL8
	gY7yTD0J3LjyQB2GS57NDHoUEevlhPZlsqfgiYeqot5v0Thtl88djQOoCJc96a3yXgWmetS6kD1
	uXEW7fBBt7xk9+SEkSX9TKXA3yILhNkPic4BgJ4fKHg/mF8Yx+2HihqZvrtMRA4etYxJU6221Sw
	a7krhsJTFEy2HrKNSE5Co0kovmj6OpqE7DTy/Ia723
X-Google-Smtp-Source: AGHT+IFBGJjaVHWPYOnuom4x2tvqUJvMTQ6WQNn312V9kRaikBmwm+H4UADRXnDowE0AWwmip+iF/w==
X-Received: by 2002:a05:6000:420a:b0:430:fced:90a with SMTP id ffacd0b85a97d-430fced09ebmr9829622f8f.16.1765979548201;
        Wed, 17 Dec 2025 05:52:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
Date: Wed, 17 Dec 2025 15:52:09 +0200
Message-ID: <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL registers. To avoid concurrency issues when updating these
registers, take the virtual channel lock. All other CHCTRL updates were
already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c8e3d9f77b8a..c013bf30fa5e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -569,8 +566,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -721,6 +718,8 @@ static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
 {
 	struct rz_dmac_chan *channel = dev_id;
 
+	guard(spinlock)(&channel->vc.lock);
+
 	if (channel) {
 		rz_dmac_irq_handle_channel(channel);
 		return IRQ_WAKE_THREAD;
-- 
2.43.0


