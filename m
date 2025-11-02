Return-Path: <stable+bounces-192102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4EC29A45
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8695A4E295C
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3791207A20;
	Sun,  2 Nov 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVYGJOVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6B34D394
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127019; cv=none; b=jrlzpj3bg/eMCn7WQoau0CE31g3gnqNTB/6d/oo1Hhlepl99EMDCyfsWQcyOXWqdpdHeOO1V+1fJXYuvFQfAiBJ3yWjDh5C6no3l2Q4ZHhcotzpmydEGUHaPJznq33O0Oh8b9oDNlYUGe+viFJBEszA4/fKOKNVauRIMl9IsUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127019; c=relaxed/simple;
	bh=z/KczWo1UVKb4d/ZF3+O6gxUfT08SUiGBcUNhHJ8tCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUZMABTAb2ArqFFqjg3fAYpUjFHU7lFAyJo8e371SGAvzeNs/+ofUhS6G4jBmh6SM1RNaTNptcMGV9h6DbCh/weG05FLrko0GhCL4bcJZcry82Xc5S1vW7RR6pFS+1cYRC0erhUZ7X85JPG4B8EUp9Ya2hKWxdrVdV2Bj0S34uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVYGJOVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD8CC4CEF7;
	Sun,  2 Nov 2025 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762127019;
	bh=z/KczWo1UVKb4d/ZF3+O6gxUfT08SUiGBcUNhHJ8tCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVYGJOVMI0nIQPaMVxgkqbJU6D8X9wdmRp0+jbxJNuKzCSonGec01cVZ/4j64xL1p
	 Hqskd1laHFCVWxMkZPl70rCdYon1dgE4ue4TjxJKWNwcTwqgYNFvkIP34yFKTyHopv
	 RJs32RImWOmjho6nrbMH9uXPybcZTvjK+H5WggtT1kNhYuoJHEGZXUn3e5ZtW0CAfw
	 roDyVOhHnLH2wK1+d46/Z6xQVf4rYK9wukY3lcOe6U42vEaHctJmhIRNZU41laE2s1
	 yr6fuib4PZy0diClLFpVQBisL04nDNbuvcJXrqQw6z4pPTZNLzzyDL3VkrYzJdSjzt
	 Xs3Di7dT4nG0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	stable@vger.kernnel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] s390/pci: Restore IRQ unconditionally for the zPCI device
Date: Sun,  2 Nov 2025 18:43:36 -0500
Message-ID: <20251102234336.3659237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110237-sizable-stimulate-e9bf@gregkh>
References: <2025110237-sizable-stimulate-e9bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit b45873c3f09153d1ad9b3a7bf9e5c0b0387fd2ea ]

Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
resetting a zPCI device.

Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug
slot"), mentions zpci_clear_irq() being called in the path for
zpci_hot_reset_device().  But that is not the case anymore and these
functions are not called outside of this file. Instead
zpci_hot_reset_device() relies on zpci_disable_device() also clearing
the IRQs, but misses to reset the zdev->irqs_registered flag.

However after a CLP disable/enable reset, the device's IRQ are
unregistered, but the flag zdev->irq_registered does not get cleared. It
creates an inconsistent state and so arch_restore_msi_irqs() doesn't
correctly restore the device's IRQ. This becomes a problem when a PCI
driver tries to restore the state of the device through
pci_restore_state(). Restore IRQ unconditionally for the device and remove
the irq_registered flag as its redundant.

Fixes: c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()")
Cc: stable@vger.kernnel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[ adjusted bitfield context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pci.h | 1 -
 arch/s390/pci/pci_irq.c     | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 108e732d7b140..e9585a390c1f0 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -136,7 +136,6 @@ struct zpci_dev {
 	u8		has_resources	: 1;
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
-	u8		irqs_registered	: 1;
 	u8		reserved	: 2;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 393bcc2c3dc2b..69c5e4f9f10ea 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -107,9 +107,6 @@ static int zpci_set_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_set_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 1;
-
 	return rc;
 }
 
@@ -123,9 +120,6 @@ static int zpci_clear_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_clear_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 0;
-
 	return rc;
 }
 
@@ -427,8 +421,7 @@ bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
-	if (!zdev->irqs_registered)
-		zpci_set_irq(zdev);
+	zpci_set_irq(zdev);
 	return true;
 }
 
-- 
2.51.0


