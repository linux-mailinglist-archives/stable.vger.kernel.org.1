Return-Path: <stable+bounces-60591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D559373C8
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 08:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320F72857BB
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD091474A8;
	Fri, 19 Jul 2024 06:01:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F17D095;
	Fri, 19 Jul 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368883; cv=none; b=rR+mgxD3Bn7eAaRYM9Ww2upS/jTQQUN/OY+ew/zVRzx4dQXYVmu0B6r2QvCawiUTQCLQZUUo0dy5CqAu/3bZcQ+FpX6IaDWqFbRocc8mr1YFv2gDrLx+jxjNzT1nGl0KsDvfxGS0uvfXAKZKqdC2e2BHcImIoZevSZIkuKDPooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368883; c=relaxed/simple;
	bh=cxVQQ+R4yiV9XxeUz8KiRaH23efpSM16Hs0a1I75sRI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=POpDrOWonY8bXdblMGAAIBfvc4Gj49kZxFFdDBE2SL+mIfBbhasj+ddKyxpF9VpHd0pWMh0zfXGnWgztjpT+yuF8DVpgT5uFBkBQlH7COVDsb53qfBbusA93APUB0pkPQL8BzhLtnvZTAvyvh+EkeHCkbNnHqR/UXTTIpRxkgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F5E42015EA;
	Fri, 19 Jul 2024 08:01:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45C8C2015E6;
	Fri, 19 Jul 2024 08:01:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 549D91820F57;
	Fri, 19 Jul 2024 14:01:12 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: tj@kernel.org,
	dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-ide@vger.kernel.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 0/6] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Fri, 19 Jul 2024 13:42:10 +0800
Message-Id: <1721367736-30156-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

V4 main changes:
Thanks for Niklas' comments.
- Update the commit message in #2 patch of v4.
- Split the clean up unrelated codes to #3 and #4 of v4.
- Remove the Cc: stable@vger.kernel.org and Fixes tag in #5 of v4.

V3 main changes:
- Use GENMASK() macro to define the _MASK.
- Refine the macro names.

V2 main changes:
- Add Rob's reviewed-by in the binding patch.
- Re-name the error out lables and new RXWM macro more descriptive.
- In #3 patch, add one fix tag, and CC stable kernel.

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v4 1/6] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v4 2/6] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v4 3/6] ata: ahci_imx: AHB clock rate setting is not required
[PATCH v4 4/6] ata: ahci_imx: Add 32bits DMA limit for i.MX8QM AHCI
[PATCH v4 5/6] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v4 6/6] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 406 ++++++++++++++++++++++++-----------------------------------------------------------------
2 files changed, 155 insertions(+), 298 deletions(-)


