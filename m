Return-Path: <stable+bounces-59385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88C931F50
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 05:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9A7B219CF
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C315ACA;
	Tue, 16 Jul 2024 03:36:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359E6FBE;
	Tue, 16 Jul 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101012; cv=none; b=lgIzdIxqWMyJ4+ZkKBzee7gsBns3LTPA5vEgfdAgCBuzr6cTvM1ufKPzu95/ym8OGtdttWXHvBoBqReOcCE7iIXf78cIPmjxUwdhenDB/6KQZbf2secMbZw8Tv/v82wYW926C6d291vskUAIXgvMPREMXaGMpn9Qs1yfC7a8eI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101012; c=relaxed/simple;
	bh=5e7kOSRl8XBPrCbjMasuiGU3+ao2+bDdz+BDslhwhVQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HYAEesyG5ztTtIdXyMyAo2S8AUTl7t/tdGy3w00T1NfxdTOeHKK+P7wng5vPuSmjl4qO+nGb+HxJpMPZ5LKzEviMSE68JckvJXdblRaqqGboMmjvCAhd0ydddiOYCaELLmIA2OBpt85z5lUqwYXVwTUVu4QitgqKeNldracHcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83CCA2009BA;
	Tue, 16 Jul 2024 05:36:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A7712009AE;
	Tue, 16 Jul 2024 05:36:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 55CDA183487B;
	Tue, 16 Jul 2024 11:36:40 +0800 (+08)
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
Subject: [PATCH v3 0/4] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Tue, 16 Jul 2024 11:18:11 +0800
Message-Id: <1721099895-26098-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

V3 main changes:
- Use GENMASK() macro to define the _MASK.
- Refine the macro names.

V2 main changes:
- Add Rob's reviewed-by in the binding patch.
- Re-name the error out lables and new RXWM macro more descriptive.
- In #3 patch, add one fix tag, and CC stable kernel.

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v3 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v3 2/4] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v3 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v3 4/4] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 406 ++++++++++++++++++++++++-----------------------------------------------------------------
2 files changed, 155 insertions(+), 298 deletions(-)

