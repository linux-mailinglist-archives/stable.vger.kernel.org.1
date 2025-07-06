Return-Path: <stable+bounces-160320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A0AFA6D3
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C761896695
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D229E0FA;
	Sun,  6 Jul 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hNFbB9uc"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD29E0E1;
	Sun,  6 Jul 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823006; cv=none; b=iLcQXwPxQZ729WKc7l55nVV4SoQsLi7OBOJ10G715hhNoVDLDOueiopY3LbYzkIyyzP/8AnMoKtLU06SDtaq9c5qU7QSZkjQmhgsZan9wcDZMi761fI+ttwbdHw8SEKshvSZtR8qrmlsOXalwZoPGnJY5REQCc9VgHPsw3+5ESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823006; c=relaxed/simple;
	bh=4QixqbGy0XLMGNdgyiJE46+isoTboBCUR/vHxQlDSuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tsL4Unw/vvgQ4SFPQ62gLgt4NJ23GEbGF07vd6hz86Y5UgmHSkN0dj7Xw0y7e3jGNsFUj4T4nnD8MnpmrKMI1wNKpfmRnsrZARDsU+sJhNHe9ezMcZ9gqgi1P5yP1bFkE5mtMwerD2hLqLvp+r6urdsr/u2SuPlgvY2Im/3r8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hNFbB9uc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A90C225CC7;
	Sun,  6 Jul 2025 19:30:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G03BX57gX3CC; Sun,  6 Jul 2025 19:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1751823000; bh=4QixqbGy0XLMGNdgyiJE46+isoTboBCUR/vHxQlDSuw=;
	h=From:Subject:Date:To:Cc;
	b=hNFbB9ucboIruz1f9JcTIwVizc0IImZWxPrJPY5e7p3VRNiQ6KwEoFlGVlW3CZAMo
	 pHQM/Ql2kuU+nBqkl/Y0ODugYT6fY+gu474Ybl2Aa/8Mf2ONOFrE/Y5sRUC9ZbXaxR
	 DG4rdyn6q6XpxC0TSQoaH2T63zfgeVIPcV2QLZKWmCbZCmA+/KU47Exv8qFnkaPQeE
	 2PMVdK6oaFja4fgjKeprdWoHPPoNIBaVrnuzo0gAOHxvECyzc/1iUvHxgknSVWqu/t
	 8S+4X4QwwZdKWh6rhK12VCZC8hLitokiiCCjnXLl1EFUnZcSq+XY0TAUZJ8Tasi7ec
	 LCLYbgP5TnZug==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v4 0/2] Samsung Exynos 7870 DECON driver support
Date: Sun, 06 Jul 2025 22:59:44 +0530
Message-Id: <20250706-exynosdrm-decon-v4-0-735fd215f4b3@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIiyamgC/2XPQQ6DIBAF0Ks0rEsDIyB21Xs0XeiAyqLSgCEa4
 92LJiZtXP5J5v2ZhUQbnI3kfllIsMlF54ccxPVCsK+HzlJncibAQLCKl9RO8+CjCW9qLPqBCgT
 QxnADTUvy1ifY1k27+Hzl3Ls4+jDvBYlv08OqTlbilFGFUiuOHBsmHsbF4P1486Ejm5bgECRTH
 M4CZMEozOdw1EyWZ6H4EeD8TyqyIBshVas1trb+F9Z1/QLJohzdNAEAAA==
X-Change-ID: 20240917-exynosdrm-decon-4c228dd1d2bf
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751822991; l=1775;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=4QixqbGy0XLMGNdgyiJE46+isoTboBCUR/vHxQlDSuw=;
 b=AHwu7q2UAAhZXbmj/8AYRvdQoa71glMdtoigvUtfOTaJ5nuJl/G+qwdu7tXKHV6miyJeLd8cX
 1gsE+Zl8ld+AChxIZ4FzfrY556CKa5EjtE4jwIg/V+nZOPDbKjiwQ6Q
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

This patch series aims at adding support for Exynos7870's DECON in the
Exynos7 DECON driver. It introduces a driver data struct so that support
for DECON on other SoCs can be added to it in the future.

It also fixes a few bugs in the driver, such as functions receiving bad
pointers.

Tested on Samsung Galaxy J7 Prime (samsung-on7xelte), Samsung Galaxy A2
Core (samsung-a2corelte), and Samsung Galaxy J6 (samsung-j6lte).

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v4:
- Drop applied patch [v2 3/3].
- Correct documentation of port dt property.
- Add documentation of memory-region.
- Remove redundant ctx->suspended completely.
- Link to v3: https://lore.kernel.org/r/20250627-exynosdrm-decon-v3-0-5b456f88cfea@disroot.org

Changes in v3:
- Add a new commit documenting iommus and ports dt properties.
- Link to v2: https://lore.kernel.org/r/20250612-exynosdrm-decon-v2-0-d6c1d21c8057@disroot.org

Changes in v2:
- Add a new commit to prevent an occasional panic under circumstances.
- Rewrite and redo [v1 2/6] to be a more sensible commit.
- Link to v1: https://lore.kernel.org/r/20240919-exynosdrm-decon-v1-0-6c5861c1cb04@disroot.org

---
Kaustabh Chakraborty (2):
      dt-bindings: display: samsung,exynos7-decon: document iommus, memory-region, and ports
      drm/exynos: exynos7_drm_decon: remove ctx->suspended

 .../display/samsung/samsung,exynos7-decon.yaml     | 21 +++++++++++++
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         | 36 ----------------------
 2 files changed, 21 insertions(+), 36 deletions(-)
---
base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
change-id: 20240917-exynosdrm-decon-4c228dd1d2bf

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


