Return-Path: <stable+bounces-17274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C13841086
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C211F24B01
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCF15F330;
	Mon, 29 Jan 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1+Te2Gs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98415B973;
	Mon, 29 Jan 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548638; cv=none; b=gI1wyMxDXYjDvLhh94dtLcjAUDra9nc8oMKsKWU3/YRy5JOwQ0UCZu4L5oqO3dxRsRdeC2vsD8RIQbIkTVgVJ4qeR1qvfa05A7NgQv5qI9H9u5AiTQEyYnpYmxpZ62brlOU5zmbcYidNRf+yDHrJOI3a3qWflDXOx2OsTTYbusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548638; c=relaxed/simple;
	bh=I2zFRQ5mnYDEqzHtiXYsSWzHnHtQZbrzl2V+wR/dx8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=staEwo55jAtj36VlGm4WXoCQYdR440MganoodLbsrnXow3sTcX3h1qaqe58hlcWvld+uJyTHD0dNBp3bGGhrzdklUilfrELFVc2ct5mpeeHuyAnATK352BNtAAI+yhH4OyqxoEanMRQC0MlVBn4eyTnizaD+5f145Tazo95aXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1+Te2Gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E9FC433C7;
	Mon, 29 Jan 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548638;
	bh=I2zFRQ5mnYDEqzHtiXYsSWzHnHtQZbrzl2V+wR/dx8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1+Te2GswcrMk+vVIVIvsYXGLV8IGCG2mjbsqov15j5pwa+gaFIKsKwWl1nFymopI
	 MERCkH7dQFdtv2FnEnozE3F+qoei9uKe5Z+BZ00WKC5+suivgZRNons+xfRw/tE/D4
	 DJRY5PChSh0CjMYCwd0g5AdISCgx3TQ7KytmOPbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 314/331] spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
Date: Mon, 29 Jan 2024 09:06:18 -0800
Message-ID: <20240129170024.072015099@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 6c314425b9ef6b247cefd0903e287eb072580c3b ]

Turns out this "SoC" side controller does not support certain commands,
such as reading chip JEDEC ID, so the controller is pretty much unusable
in Linux. We should be using the "PCH" side controller instead. For this
reason remove this PCI ID from the list.

Fixes: c2912d42e86e ("spi: intel-pci: Add support for Meteor Lake-S SPI serial flash")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://msgid.link/r/20240122120034.2664812-2-mika.westerberg@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 57d767a68e7b..b9918dcc3802 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -84,7 +84,6 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xae23), (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
-- 
2.43.0




