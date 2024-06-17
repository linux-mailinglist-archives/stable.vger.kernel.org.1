Return-Path: <stable+bounces-52603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668E90BBF3
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 22:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DBE283A03
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CD19B3DD;
	Mon, 17 Jun 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ij22bNSh"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278019AD99;
	Mon, 17 Jun 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655480; cv=none; b=K/4kL1oZKVNrj5YBx3dLTQ3TEDJjMk04mJLaRJbln348cQPDwM8f5Zd5xon1H/iV6xZ8hJ+qfvcZZwwkJ0hP7ivvXA6+DzD9j4Ao1Ko0xH5w4ObvdzUEBP20Brk8J/2Rv4UxHS+zG3F7F8+/huramUbWcPa9LkPjt4M9jRmakjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655480; c=relaxed/simple;
	bh=We1ydyHnrk8Sp4RgNlISv2jNIeyh8hASpbRXppWAGec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTHHYpkmn9S2/o8M9C1PA/zXavi4aMzI4S7+OZ6gbeK9aUpYxC+xKAmLO5RMV9tfcYaiApH7y1XivqBbyaVHhNwwQFaikhUJiuPjQnJTG+TX1/idhWj781OlMG9OyBquAIIejCbH55q0GIEFE+m7k3W9hiXgGQxEN1IUxgcvh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ij22bNSh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718655474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6nJ2AJoxxGOzx8FlzxjSHQ63pZJ01vIWAcBtW0WpNeE=;
	b=Ij22bNShaPPe/gdzZ0oHStjzEKfSKZ1tehWFhhbe9x/419UocSw+CG6QsGDr4qrLjKu8O8
	FnFSHoDI9D18TseRQM/gTKU53h06vpEUQh5rAiaAHPL+FYaXP/geIPr4rEONABCM2qpuBe
	k9uVHwUn2iiQ25Qd5Qo5ihOdtPnm/pOIpgauGkBma5vMG84/dFND/frm8mzUp6hdlAufFj
	AGdDnzF2yQ64ZfCoyOPk0fSAZ8kBr+ODbVcrOd0g9gd32y0Gz6/Y/IcDrzs4xz6m65iYCW
	wF/Z+iYgm9SmhTJ/X0AnhN98lgPFCnTTxruOp8OPqIqJqD6J2BTeU/jbsRKA3Q==
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Furkan Kardame <f.kardame@manjaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: Mark simple_ondemand governor as softdep
Date: Mon, 17 Jun 2024 22:17:48 +0200
Message-Id: <4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Panfrost DRM driver uses devfreq to perform DVFS, while using simple_ondemand
devfreq governor by default.  This causes driver initialization to fail on
boot when simple_ondemand governor isn't built into the kernel statically,
as a result of the missing module dependency and, consequently, the required
governor module not being included in the initial ramdisk.  Thus, let's mark
simple_ondemand governor as a softdep for Panfrost, to have its kernel module
included in the initial ramdisk.

This is a rather longstanding issue that has forced distributions to build
devfreq governors statically into their kernels, [1][2] or has forced users
to introduce some unnecessary workarounds. [3]

For future reference, not having support for the simple_ondemand governor in
the initial ramdisk produces errors in the kernel log similar to these below,
which were taken from a Pine64 RockPro64:

  panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init [panfrost]] *ERROR* Couldn't initialize GPU devfreq
  panfrost ff9a0000.gpu: Fatal error during GPU init
  panfrost: probe of ff9a0000.gpu failed with error -22

Having simple_ondemand marked as a softdep for Panfrost may not resolve this
issue for all Linux distributions.  In particular, it will remain unresolved
for the distributions whose utilities for the initial ramdisk generation do
not handle the available softdep information [4] properly yet.  However, some
Linux distributions already handle softdeps properly while generating their
initial ramdisks, [5] and this is a prerequisite step in the right direction
for the distributions that don't handle them properly yet.

[1] https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/blob/linux61/config?ref_type=heads#L8180
[2] https://salsa.debian.org/kernel-team/linux/-/merge_requests/1066
[3] https://forum.pine64.org/showthread.php?tid=15458
[4] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d
[5] https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be512f6d8f4489054668ad

Cc: Diederik de Haas <didi.debian@cknow.org>
Cc: Furkan Kardame <f.kardame@manjaro.org>
Cc: stable@vger.kernel.org
Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index ef9f6c0716d5..149737d7a07e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -828,3 +828,4 @@ module_platform_driver(panfrost_driver);
 MODULE_AUTHOR("Panfrost Project Developers");
 MODULE_DESCRIPTION("Panfrost DRM Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: governor_simpleondemand");

