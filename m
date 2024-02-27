Return-Path: <stable+bounces-24100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB33869313
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E5EB2E927
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371D13B7AB;
	Tue, 27 Feb 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qu4tP5Oh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374278B61;
	Tue, 27 Feb 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041033; cv=none; b=j0WZrE9UlgCcLc24jbwivYAjAhZwa6pNlSHf4OqLtapWdkwk5TQu/NtGgjAxWYxlNiULAyLPzx9iYG0dsvik3txWYWTG2X1uOC9Z7Ujm4yLEJy7YZZQR46b9BrEsNSTiDLA33q0uWms7U9VJfw8jtCU/pfe1N11eB22ltqe9ogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041033; c=relaxed/simple;
	bh=RFgynA0/T1TuG6Je6tUpX1W/42SpCzYvsQD6b9LrX4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFz0/jtSbTdPRl/V5Gd7VpUVtp3bv1jC2idqXrE7YLTriAjY6gZwcP8mMwBf5pg9ujLmMCa+Hj/5GU29SzkpDyvjssR+BBE5H1cUuX/1Cn5I73idt6wOavNRqXCObF30Na2sgXbpZ6f241WL7rY6a0OStGQ+IswvY99+3mY1Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qu4tP5Oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C7C433C7;
	Tue, 27 Feb 2024 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041033;
	bh=RFgynA0/T1TuG6Je6tUpX1W/42SpCzYvsQD6b9LrX4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu4tP5Oh0hmCgclacim3A2uJDR24xj4nekYqoVWGADr+tGOrqfJKEq2aoFo3Pi2mo
	 /RrG+CeWhsXWbKuLIuBSsgL9Yh63dSaBTU0QjxKnTzb8C+WQdeWrlZ5b3WE452GcO5
	 sL9enQMb65/TQsMgh5mQMxr5yu+8SsqA35LzA82w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH 6.7 196/334] PCI/MSI: Prevent MSI hardware interrupt number truncation
Date: Tue, 27 Feb 2024 14:20:54 +0100
Message-ID: <20240227131637.030477682@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vidya Sagar <vidyas@nvidia.com>

commit db744ddd59be798c2627efbfc71f707f5a935a40 upstream.

While calculating the hardware interrupt number for a MSI interrupt, the
higher bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI
domain number gets truncated because of the shifted value casting to return
type of pci_domain_nr() which is 'int'. This for example is resulting in
same hardware interrupt number for devices 0019:00:00.0 and 0039:00:00.0.

To address this cast the PCI domain number to 'irq_hw_number_t' before left
shifting it to calculate the hardware interrupt number.

Please note that this fixes the issue only on 64-bit systems and doesn't
change the behavior for 32-bit systems i.e. the 32-bit systems continue to
have the issue. Since the issue surfaces only if there are too many PCIe
controllers in the system which usually is the case in modern server
systems and they don't tend to run 32-bit kernels.

Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115135649.708536-1-vidyas@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/msi/irqdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_ca
 
 	return (irq_hw_number_t)desc->msi_index |
 		pci_dev_id(dev) << 11 |
-		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
+		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
 }
 
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,



