Return-Path: <stable+bounces-52604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FE90BC18
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 22:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2841C23C88
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DEA19883C;
	Mon, 17 Jun 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ijh+uWnh"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C1196DA4;
	Mon, 17 Jun 2024 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655740; cv=none; b=Eq3BXExS9HgzG5Lq3JNMb3Eta0E4P3CIt1NEWwic3EMeqSgW3dGfa6NNZ4SMlSxSaGP1XQRN7LFvE3P6bP4Bt7jxc0lQtC/aRQth6gMgMoRRFcl7l5bgUKFNgfI5o+aTq12PeGiAvL3pD3Jowxy2toaUAQbfIzu1vJijdDgB4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655740; c=relaxed/simple;
	bh=lDmE6Oc99oUhAcr5WIwumgLA+GcsneQdxF8Anei0cF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FuEASu9ybcKBe8Q+wYaWqG8y72wD9uoRUevhEYJrZJQrMbOPppiSn8mcanMDhmxZ+q/0VXM0BXDijhmz/xGV7VhJMgx6rqTyb2RWylHwu+N7SxcBGnVNmc+c53cr7QCNmilUlo8vd6osplvzBH7KsSSxKzRyln1fRG93ivPnoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ijh+uWnh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718655735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KE0itf7SPq2y4IgF/9FfRchQi+X27+0vxz0kqB+YZMM=;
	b=ijh+uWnh8LENHexsTozHC6SCsZIJn8G4mw7xG0hs93oJN1KIgpWNCrQ67kUjpTIq8E+K2G
	lbJPkDV0kis73ZrBp0t/RC2PvLK5IyiPq2a4ZDeBxcbTUeD71na3sUM+X3Wu/xeSbVf6J3
	2o4eZVyURX04DEc4qpGkAdxAmhasS6WyyYbbcZq+GDt6sTAnwMXXfZfUUnrs/cwiaEUXiZ
	mG4rSG7QBXwqWLoFsvJ5JusfPzew6UIw6yXaKRHTk9FRB/0e7Zydl8BujE2WPcmFy2hS5L
	G7GHchrWa0t8/mPid2Vj2P8Ebxul08P+4FTC8gwPdIUQRblg+GHU0mjSe+H5eQ==
To: dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: yuq825@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-kernel@vger.kernel.org,
	Philip Muller <philm@manjaro.org>,
	Oliver Smith <ollieparanoid@postmarketos.org>,
	Daniel Smith <danct12@disroot.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/lima: Mark simple_ondemand governor as softdep
Date: Mon, 17 Jun 2024 22:22:02 +0200
Message-Id: <fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Lima DRM driver uses devfreq to perform DVFS, while using simple_ondemand
devfreq governor by default.  This causes driver initialization to fail on
boot when simple_ondemand governor isn't built into the kernel statically,
as a result of the missing module dependency and, consequently, the required
governor module not being included in the initial ramdisk.  Thus, let's mark
simple_ondemand governor as a softdep for Lima, to have its kernel module
included in the initial ramdisk.

This is a rather longstanding issue that has forced distributions to build
devfreq governors statically into their kernels, [1][2] or may have forced
some users to introduce unnecessary workarounds.

Having simple_ondemand marked as a softdep for Lima may not resolve this
issue for all Linux distributions.  In particular, it will remain unresolved
for the distributions whose utilities for the initial ramdisk generation do
not handle the available softdep information [3] properly yet.  However, some
Linux distributions already handle softdeps properly while generating their
initial ramdisks, [4] and this is a prerequisite step in the right direction
for the distributions that don't handle them properly yet.

[1] https://gitlab.manjaro.org/manjaro-arm/packages/core/linux-pinephone/-/blob/6.7-megi/config?ref_type=heads#L5749
[2] https://gitlab.com/postmarketOS/pmaports/-/blob/7f64e287e7732c9eaa029653e73ca3d4ba1c8598/main/linux-postmarketos-allwinner/config-postmarketos-allwinner.aarch64#L4654
[3] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/commit/?id=49d8e0b59052999de577ab732b719cfbeb89504d
[4] https://github.com/archlinux/mkinitcpio/commit/97ac4d37aae084a050be512f6d8f4489054668ad

Cc: Philip Muller <philm@manjaro.org>
Cc: Oliver Smith <ollieparanoid@postmarketos.org>
Cc: Daniel Smith <danct12@disroot.org>
Cc: stable@vger.kernel.org
Fixes: 1996970773a3 ("drm/lima: Add optional devfreq and cooling device support")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/lima/lima_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 739c865b556f..10bce18b7c31 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -501,3 +501,4 @@ module_platform_driver(lima_platform_driver);
 MODULE_AUTHOR("Lima Project Developers");
 MODULE_DESCRIPTION("Lima DRM Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: governor_simpleondemand");

