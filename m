Return-Path: <stable+bounces-59263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D0930C93
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 04:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1804BB20ECB
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 02:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F68F48;
	Mon, 15 Jul 2024 02:17:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506A79F3;
	Mon, 15 Jul 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009873; cv=none; b=lyC4lBignFRT67pI81ACu+X3Y5HU5asfK6UyzcJODY0hj0gZi61uGMxw4QNEAT9I/lhR3ZqBeiXWv4NvnZh4A+nciHcvzQ3NTfZtEZmJwkzeDH0Bec76bg8PFsNHHPIPCAqJSf+d1/DkV6z2jydF8ZAwZKyFhO1iGLMdUJn1VsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009873; c=relaxed/simple;
	bh=hYPspV38qTvoGjGj4HeITgm/lNpi9Xl7kdSX6Qx9HYA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B0qbuU8V8o5vnmm+BIF4GG0u2gWcXNQHMF32GBR71lenF0JmxwSrz1ya58CqkcFtK/qSIN639Pj7BR6DcQsZyV+hXYS2AR3McgSLjh0rJDCdc1uSy8kE3e72lRR3DfnclFfTiNi2GRErf9HERk2qqGIya6ZazPZifrFzgHQR5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFBEB1A0391;
	Mon, 15 Jul 2024 04:12:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 873EB1A0118;
	Mon, 15 Jul 2024 04:12:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9BAA11802183;
	Mon, 15 Jul 2024 10:12:17 +0800 (+08)
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
Subject: [PATCH v2 0/4] Refine i.MX8QM SATA based on generic PHY callbacks
Date: Mon, 15 Jul 2024 09:53:52 +0800
Message-Id: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

V2 main changes:
- Add Rob's reviewed-by in the binding patch.
- Re-name the error out labels and new RXWM macro.
- In #3 patch, add one fix tag, and CC stable kernel.

Based on i.MX8QM HSIO PHY driver, refine i.MX8QM SATA driver by using PHY
interface.

[PATCH v2 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
[PATCH v2 2/4] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY
[PATCH v2 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM SATA
[PATCH v2 4/4] ata: ahci_imx: Correct the email address

Documentation/devicetree/bindings/ata/imx-sata.yaml |  47 +++++++++++
drivers/ata/ahci_imx.c                              | 406 ++++++++++++++++++++++++-----------------------------------------------------------------
2 files changed, 155 insertions(+), 298 deletions(-)

