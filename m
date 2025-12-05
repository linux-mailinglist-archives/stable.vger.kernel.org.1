Return-Path: <stable+bounces-200161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D84CA7981
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 13:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D93431AB62F
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9EF398F90;
	Fri,  5 Dec 2025 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPrYhrnF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197B2FD7AC
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938318; cv=none; b=cMBKbKWhKp6NP8+lfbvTjmKuDfjE+fssGHuBt8Q5e9Gd4ub8k8WtYSlf95G+hTpfWeghSQAoY+cLAb2WCkV1OvVkUP+yUvsFjwFmxJWm/EjTrSlwgWn8rDF9cJX5P69okkoD7hi7drfDo96tUSFo9WXl39wqsqgv7v0sHweaY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938318; c=relaxed/simple;
	bh=YKjEkwwQxNsFPsAojFhrxWi0Ym+oFc6m47bQdQpgaWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWDP8VDqp8UNpbm7aBpEJviiLfHi1kQ/RMDuft4VipWoRG9rAoEuvzwLv/agsxBtlvN4fq0okdyXQ+YsdxRjVGoXwGrxQPiylYGA6MOzi3lq0qFaaZAROiTx6snHg5JOscwbSa+ccYie66GcdnUweO66vZNN/YDE6GXkzjtwwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPrYhrnF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59431f57bf6so2415815e87.3
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 04:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764938312; x=1765543112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klcElJtkzI0lLp3wntIo4gO11oCbbXWvHu4Lghm8pn8=;
        b=pPrYhrnFB8H7dGCWOE082ws4dxhKJGUdZMpIif8Yol5m9TdGhibFV9zY4+0wSXPN+i
         HNeP8hrLioGkXNlXsjdt+r9Cr6E935mmZoMngiVKcqsDkvbd49iK/kyXJCsHh61vyuwR
         yFMk1GbpXQXvgvN8bnF9PLsuhKwnk4zzDeDbY6VMiduByiMVIJtQNoKGWguSwbnR761H
         59ULbDGDmaV9errANyOGvHeBUIfCmedCTwHaoW123TIM5nbn8q11Yyr50+MqSSGpnCJm
         G5YlNuSWheMVCmUh/nLMCNu/jSlWt8QO0+qM2o5YrjoS0C84aQxt6XyM89Ww554Js/zm
         70WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938312; x=1765543112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=klcElJtkzI0lLp3wntIo4gO11oCbbXWvHu4Lghm8pn8=;
        b=aSxV+y35X7MJTeGjf1tVTH9RRtpjgqDu0ISIJoQVILB6xxw06Fvx0bSRiJ14/kPR2Z
         3jjDr4jMGJ4PTLYMPXpqLagmcfbODilx3HE/a34hVJ1Mk/lsHZYiMmuYCQbCcgqMSOzw
         6+BqmJp9AshybCqV2mnXQaY3Q/m2E7GqEKicysEvXd99JT0KnE26s3ZgUl1r4n0N27DJ
         yE0Y60cxk8pCe0WKvyIUxxZ6/xlXqAgmvo6S+kOHf/p4Bjxll2oXGOGrqiNCw4oMtNu7
         RwpfDVUVdvmfqNnqy3hTIClgMmTY9D4xRRasVpKcyfmuRxYi7FYCxi+f5E5tG65xKPWw
         qSUw==
X-Forwarded-Encrypted: i=1; AJvYcCWl8c6EcwvoJQowJSkCkjPTSf9wweYQg6WDxVOWvFdcQt2/xrwW3TmaKQuSXp3cndW6GIoooGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75XZfGgQJtiPjCI5lhm8PfvAOcrXLoYdPv5b3BPi4UT0Hb4wB
	suvvJbo/OSLPnzLEB6eyIVjfm86mAZQkQX6G8V5s3i+sTosUIg4Dm4p8JBsKDosAhKk=
X-Gm-Gg: ASbGnctrKkbp9oh8wkoRvHWy7YhtkYe6apeyhOU7igSVSXPbVLASo8k0pOKwNrOm16O
	8gzZjm71Gb+CaYAwrhUja9fpEFITN/K/oEIqdEtQUTEVqS7ND4yMELtCmDWJzm6hqKRNc6gtEwA
	reNzf/SQlTlg1OrYSShkOjXiJIu+FWLa2IRPUvujGIEREul18ReD9Pvt6AhYYG64lM0eGuVY71e
	rbcSmQV8rAkkwHm4ZjY5u/wDcOhKeZOqB1JwtBa3yiyfVA5izP30GE+N9cgFzjI7js883ZG/clO
	B60S9xCs7qD6mEl46vnOIK2cuByXJTyFRU9NaY9BxIdEYeqmbn+mQNoDIELF0RA69xjqZgKcW9b
	LskFCAtB++JEN8tLHa4oY+/kOktR+zzZbRag/G69QVLDD2timUtDLzqPmSJIpeberKjxL68B7ls
	AVNqFo7Ddk4b3b9SFqTemy1fXx+NvY0PnKkML/c/0TV3Ik
X-Google-Smtp-Source: AGHT+IFTlZw+oR2sw8F587+gt4VtLs/GMa9dNBWEO0QK962QEdEh8y33WxXMT99Jaj5hQoXnehj+Zw==
X-Received: by 2002:a05:6512:124b:b0:595:8200:9f7e with SMTP id 2adb3069b0e04-597d669ff19mr2333117e87.20.1764938311848;
        Fri, 05 Dec 2025 04:38:31 -0800 (PST)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b1a3d9sm1462351e87.4.2025.12.05.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:38:31 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Bill Mills <bill.mills@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm: xlnx: zynqmp_kms: set preferred_depth to 16 bpp
Date: Fri,  5 Dec 2025 14:37:51 +0200
Message-ID: <20251205123751.2257694-3-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205123751.2257694-1-mikko.rapeli@linaro.org>
References: <20251205123751.2257694-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xorg fails to start with defaults on AMD KV260, /var/log/Xorg.0.log:

[    23.491] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    23.491] (II) Module fbdev: vendor="X.Org Foundation"
[    23.491]    compiled for 1.21.1.18, module version = 0.5.1
[    23.491]    Module class: X.Org Video Driver
[    23.491]    ABI class: X.Org Video Driver, version 25.2
[    23.491] (II) modesetting: Driver for Modesetting Kernel Drivers:
kms
[    23.491] (II) FBDEV: driver for framebuffer: fbdev
[    23.510] (II) modeset(0): using drv /dev/dri/card1
[    23.511] (WW) Falling back to old probe method for fbdev
[    23.511] (II) Loading sub module "fbdevhw"
[    23.511] (II) LoadModule: "fbdevhw"
[    23.511] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    23.511] (II) Module fbdevhw: vendor="X.Org Foundation"
[    23.511]    compiled for 1.21.1.18, module version = 0.0.2
[    23.511]    ABI class: X.Org Video Driver, version 25.2
[    23.512] (II) modeset(0): Creating default Display subsection in
Screen section
        "Default Screen Section" for depth/fbbpp 24/32
[    23.512] (==) modeset(0): Depth 24, (==) framebuffer bpp 32
[    23.512] (==) modeset(0): RGB weight 888
[    23.512] (==) modeset(0): Default visual is TrueColor
...
[    23.911] (II) Loading sub module "fb"
[    23.911] (II) LoadModule: "fb"
[    23.911] (II) Module "fb" already built-in
[    23.911] (II) UnloadModule: "fbdev"
[    23.911] (II) Unloading fbdev
[    23.912] (II) UnloadSubModule: "fbdevhw"
[    23.912] (II) Unloading fbdevhw
[    24.238] (==) modeset(0): Backing store enabled
[    24.238] (==) modeset(0): Silken mouse enabled
[    24.249] (II) modeset(0): Initializing kms color map for depth 24, 8
bpc.
[    24.250] (==) modeset(0): DPMS enabled
[    24.250] (II) modeset(0): [DRI2] Setup complete
[    24.250] (II) modeset(0): [DRI2]   DRI driver: kms_swrast
[    24.250] (II) modeset(0): [DRI2]   VDPAU driver: kms_swrast
...
[    24.770] (II) modeset(0): Disabling kernel dirty updates, not
required.
[    24.770] (EE) modeset(0): failed to set mode: Invalid argument

xorg tries to use 24 and 32 bpp which pass on the fb API but which
don't actually work on AMD KV260 when Xorg starts. As a workaround
Xorg config can set color depth to 16 using /etc/X11/xorg.conf snippet:

Section "Screen"
        Identifier     "Default Screen"
        Monitor        "Configured Monitor"
        Device         "Configured Video Device"
        DefaultDepth   16
EndSection

But this is cumbersome on images meant for multiple different arm64
devices and boards. So instead set 16 bpp as preferred depth
in zynqmp_kms fb driver which is used by Xorg in the logic to find
out a working depth.

Now Xorg startup and bpp query using fb API works and HDMI display
shows graphics. /var/log/Xorg.0.log shows:

[    23.219] (II) LoadModule: "fbdev"
[    23.219] (II) Loading /usr/lib/xorg/modules/drivers/fbdev_drv.so
[    23.219] (II) Module fbdev: vendor="X.Org Foundation"
[    23.219]    compiled for 1.21.1.18, module version = 0.5.1
[    23.219]    Module class: X.Org Video Driver
[    23.219]    ABI class: X.Org Video Driver, version 25.2
[    23.219] (II) modesetting: Driver for Modesetting Kernel Drivers:
kms
[    23.219] (II) FBDEV: driver for framebuffer: fbdev
[    23.238] (II) modeset(0): using drv /dev/dri/card1
[    23.238] (WW) Falling back to old probe method for fbdev
[    23.238] (II) Loading sub module "fbdevhw"
[    23.238] (II) LoadModule: "fbdevhw"
[    23.239] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
[    23.239] (II) Module fbdevhw: vendor="X.Org Foundation"
[    23.239]    compiled for 1.21.1.18, module version = 0.0.2
[    23.239]    ABI class: X.Org Video Driver, version 25.2
[    23.240] (II) modeset(0): Creating default Display subsection in Screen section
        "Default Screen Section" for depth/fbbpp 16/16
[    23.240] (==) modeset(0): Depth 16, (==) framebuffer bpp 16
[    23.240] (==) modeset(0): RGB weight 565
[    23.240] (==) modeset(0): Default visual is TrueColor
...
[    24.015] (==) modeset(0): Backing store enabled
[    24.015] (==) modeset(0): Silken mouse enabled
[    24.027] (II) modeset(0): Initializing kms color map for depth 16, 6 bpc.
[    24.028] (==) modeset(0): DPMS enabled
[    24.028] (II) modeset(0): [DRI2] Setup complete
[    24.028] (II) modeset(0): [DRI2]   DRI driver: kms_swrast
[    24.028] (II) modeset(0): [DRI2]   VDPAU driver: kms_swrast

Cc: Bill Mills <bill.mills@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index ccc35cacd10cb..a42192c827af0 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -506,6 +506,7 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 	drm->mode_config.min_height = 0;
 	drm->mode_config.max_width = ZYNQMP_DISP_MAX_WIDTH;
 	drm->mode_config.max_height = ZYNQMP_DISP_MAX_HEIGHT;
+	drm->mode_config.preferred_depth = 16;
 
 	ret = drm_vblank_init(drm, 1);
 	if (ret)
-- 
2.34.1


