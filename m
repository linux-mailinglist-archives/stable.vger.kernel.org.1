Return-Path: <stable+bounces-152561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94229AD752F
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F43918854B2
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D069279334;
	Thu, 12 Jun 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="UBs+WhFP"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E5278E5D;
	Thu, 12 Jun 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740441; cv=none; b=oOkBoTxhhUhD9qPjr5MsEofd28iIUjpRQPoXYuS2OfnJxebnozpyOfQEOsqgKoefP2bUpiPGM7Sws+M7znsmWxp3C6v1GUxjdcKPunckqHlfn6kLXGvJ7smLNbjwBCQvXHucXaE5Y/pOQlJLO9Lvay7ISdhw32tGvpQRvapz81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740441; c=relaxed/simple;
	bh=hyszOhcRbzyjfVvsWkNpk+hVLWy3Vif4GHa8XCtb/z0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mj+BQ23YtNjjYQbUYip9w5+oUZHFQ307Fkgc2TmD7prl0jId8+uryIjDal6Y2HFxxntLfTnPvU6VmsPDJ+D9710Xw9e2Im5Fb21pBEn3hQVnGxp0HyMBwUtMdnG4j0AeUQgeXX1HYhHHYFhBhdAMkVFwMH5EGKmgFY2y7xojvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=UBs+WhFP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 14A5A260A0;
	Thu, 12 Jun 2025 17:00:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ma3iOkFIL4ux; Thu, 12 Jun 2025 17:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1749740435; bh=hyszOhcRbzyjfVvsWkNpk+hVLWy3Vif4GHa8XCtb/z0=;
	h=From:Subject:Date:To:Cc;
	b=UBs+WhFPGmXf10maD/KCA03fqTS+jQmw0BJes/UnNzmC3xIEuLH2la6i7Qp2XZk4N
	 3H8QosxjTDSMl6IvaERdEF5o/9lFwU01jdjA0Po7JFJvMiyp3ZABsTzTt4d6yCBiXb
	 yOwlZi+8sc4hHDFjd14rxmfDdpm5jWajdicBwrQoVgHycyO9FJjoAbxM4ebi1EV7sG
	 HxXyQu0I9+eoI17KoDJCUIKGAF1MMtvRXXAbDbQHyrlSqLTeNMMTI9CDxedjW9U9zf
	 iAmientABoTM6Z65Y4RkCs/kkdFAX3sdeN/HQXDj3qX4m2FhuoDL8gcj5zWB0Mkfsy
	 2JIEUcWipbuaA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Samsung Exynos 7870 DECON driver support
Date: Thu, 12 Jun 2025 20:29:18 +0530
Message-Id: <20250612-exynosdrm-decon-v2-0-d6c1d21c8057@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbrSmgC/2WNQQ6CMBBFr0JmbU3bIIIr72FYSGeAWdgxU0Igh
 LtbSVy5fC/572+QSJkS3IoNlGZOLDGDPxUQxmccyDBmBm99aRt3NbSsURLqyyAFiaYM3teIDn3
 XQ169lXpejuKjzTxymkTX42B2X/trNX+t2RlrqnCpKxdc6Gx5R04qMp1FB2j3ff8Ax0hFv7AAA
 AA=
X-Change-ID: 20240917-exynosdrm-decon-4c228dd1d2bf
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740428; l=1203;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=hyszOhcRbzyjfVvsWkNpk+hVLWy3Vif4GHa8XCtb/z0=;
 b=RBepMzepmmvN9MEFlWtkAYr8CSmXHsbMD5QHpkFVOAJxzE4dbCgTT+mxjmvjvSYo2dr+5RnEc
 0Fi3M5ecoAzBnDtWAjPc8ngbIx8joImgFgyZP9PLH1uivMD+tNAjOEP
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
Changes in v2:
- Add a new commit to prevent an occasional panic under circumstances.
- Rewrite and redo [v1 2/6] to be a more sensible commit.
- Link to v1: https://lore.kernel.org/r/20240919-exynosdrm-decon-v1-0-6c5861c1cb04@disroot.org

---
Kaustabh Chakraborty (2):
      drm/exynos: exynos7_drm_decon: fix call of decon_commit()
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

 drivers/gpu/drm/exynos/exynos7_drm_decon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
change-id: 20240917-exynosdrm-decon-4c228dd1d2bf

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


