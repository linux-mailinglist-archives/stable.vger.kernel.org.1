Return-Path: <stable+bounces-118214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A50A3BAA1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA76802943
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6396E1DF755;
	Wed, 19 Feb 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAP6Zu98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AF1C3BF1;
	Wed, 19 Feb 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957564; cv=none; b=JOPvsHqq9HrCOWGrQ8itxmxHl+bKMItnJclHA+hwmYOQmEf/p6zvmERT1IMbzuRp2kfQveqUr7pCrkdcXLJX87DUoQAwYGN4HaIqYY4DMNoDIdouzUkPG/7mTAohIRUPxIpTw5pUPIEOkC3niyurHbVE9cshplsfctAgF3GJu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957564; c=relaxed/simple;
	bh=/4HomBlx3ASgFNbKbQNoNLoz+4cEgAUgfcGmNen+oJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPTf+Bl446gzKgmKjz543dtyxby3gys/gK49I4F9ZneDqxJE1q0fDKdWt9Z8JRpiqTDAShQrQ2e2ckjf1QLOcE31sPClknf3n1jRjYLl6enyiZl2VwqgIviRnheLqc31EUDCWB/eohxqcV5s1kxwtERP3D6NCU4jgJA88/P8v6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAP6Zu98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93955C4CED1;
	Wed, 19 Feb 2025 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957564;
	bh=/4HomBlx3ASgFNbKbQNoNLoz+4cEgAUgfcGmNen+oJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yAP6Zu98sxaSPnMocMgMC6mcAnCpgmUnAL/MirEzxRXtT479VNZ8SnUSmaP0u0NrZ
	 bE+Y7yLqc1dRjCJDquu01UvN75dEbAa5zva/LGZvOgr+kPEi2mEA3nzFZrcB5gTZE5
	 BNpCw8tcnoU7mZMmKUv47iO0/NosuO5xc4+A1nUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 6.1 570/578] serial: 8250_pci: add support for ASIX AX99100
Date: Wed, 19 Feb 2025 09:29:34 +0100
Message-ID: <20250219082715.378244411@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

commit 0b32216557ce3b2a468d1282d99b428bf72ff532 upstream.

Each of the 4 PCI functions on ASIX AX99100 PCIe to Multi I/O
Controller can be configured as a single-port serial port controller.
The subvendor id is 0x1000 when configured as serial port and MSI
interrupts are supported.

Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230724083933.3173513-4-jiaqing.zhao@linux.intel.com
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -66,6 +66,8 @@ static const struct pci_device_id pci_us
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9922,
 			 0xA000, 0x1000) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
 	{ }
@@ -5890,6 +5892,14 @@ static const struct pci_device_id serial
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
+
+	/*
+	 * ASIX AX99100 PCIe to Multi I/O Controller
+	 */
+	{	PCI_VENDOR_ID_ASIX, PCI_DEVICE_ID_ASIX_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/* Intel CE4100 */
 	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
 		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,



