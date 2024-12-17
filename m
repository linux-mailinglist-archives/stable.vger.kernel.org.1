Return-Path: <stable+bounces-104497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4119F4C40
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC49F1898C07
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0931F8902;
	Tue, 17 Dec 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJ9xYACH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmyzs601"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845051F868D;
	Tue, 17 Dec 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440914; cv=none; b=ro3X/IXi7zsiG7eYZPJUOY3Q6EeBcSaOSHEqSJIpgKe0WRjmUrTdjsiKgikaw5F8CxK0VqjZLI1Ey/5kwVUixvJ/JJHPOQYwzdv6qHvFJR5zJQpHjghRQkzNn/VMqtai4BoKyK7z7OebVXOrIvUhY8ngo80ZE5IbFLdFLQcP7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440914; c=relaxed/simple;
	bh=dGXIbMmmBZgtDVplErt/7CpxLPGtgb3MmIDDevW6Efk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bNFhlxgEkOZSK9ng3V0jzs07XTTOiFnAamoAHPHTm4H26Sq5sbVhjgtHsSf8gKi0j+vYYGjJhRLtjvzr1Enm9FquFtyWhPM38gDHW4H1k4/hLcmxynnZIA+hvRCsj+7nIR2DK5zXzMfxrtht4lEEUDjhEFy3Nb6nndZgV4x862I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJ9xYACH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmyzs601; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Dec 2024 13:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734440909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJkBce2wFh03Iy3adZzbcFqirjJB5sUIbEJpggojnPE=;
	b=jJ9xYACHaLBoWdDLSJlR3STGlJRcjLWZuHySQxlr26xu+L+N+Ui2wsLwh2hw8mDJtYBVyu
	kX/+Lji9ENTQZFVHVSbEXbac215B20HYs8hlPo+SbxvGkZLfwc7t5z2/ut0WL/Zy7q260P
	EofXdkgGsDENSFKwcvmw74x5IUcsUe9XRQUOLs8Wn07nqyKB58fwORvvzwfoqkbltQvZih
	t5Ri7K8jlEKGZlImDVZOddu2/kkhXu9A1GgFHRl+vr1BBNgj/G4136ShGZDdboKiKBRFlI
	0HocOPXvrC0RuGS+Kq4x3Z1mLn1i9qafCsI/R2xDIZcb6M5arsyhGye0tFelbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734440909;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJkBce2wFh03Iy3adZzbcFqirjJB5sUIbEJpggojnPE=;
	b=dmyzs6012yLl9BV1W1hiKvOR8QeP4S2SDYCHsf2pdgbHXoV+11B8Fl6E/RWMLB6WXrGkMv
	MCu/W/o/lTL+cRBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Handle lack of irqdomain gracefully
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ed2a8ow5.ffs@tglx>
References: <87ed2a8ow5.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173444090844.7135.5807329520776936894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a60b990798eb17433d0283788280422b1bd94b18
Gitweb:        https://git.kernel.org/tip/a60b990798eb17433d0283788280422b1bd94b18
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 14 Dec 2024 12:50:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Dec 2024 10:59:47 +01:00

PCI/MSI: Handle lack of irqdomain gracefully

Alexandre observed a warning emitted from pci_msi_setup_msi_irqs() on a
RISCV platform which does not provide PCI/MSI support:

 WARNING: CPU: 1 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x2c/0x32
 __pci_enable_msix_range+0x30c/0x596
 pci_msi_setup_msi_irqs+0x2c/0x32
 pci_alloc_irq_vectors_affinity+0xb8/0xe2

RISCV uses hierarchical interrupt domains and correctly does not implement
the legacy fallback. The warning triggers from the legacy fallback stub.

That warning is bogus as the PCI/MSI layer knows whether a PCI/MSI parent
domain is associated with the device or not. There is a check for MSI-X,
which has a legacy assumption. But that legacy fallback assumption is only
valid when legacy support is enabled, but otherwise the check should simply
return -ENOTSUPP.

Loongarch tripped over the same problem and blindly enabled legacy support
without implementing the legacy fallbacks. There are weak implementations
which return an error, so the problem was papered over.

Correct pci_msi_domain_supports() to evaluate the legacy mode and add
the missing supported check into the MSI enable path to complete it.

Fixes: d2a463b29741 ("PCI/MSI: Reject multi-MSI early")
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/87ed2a8ow5.ffs@tglx

---
 drivers/pci/msi/irqdomain.c | 7 +++++--
 drivers/pci/msi/msi.c       | 4 ++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 5691257..d7ba879 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -350,8 +350,11 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 
 	domain = dev_get_msi_domain(&pdev->dev);
 
-	if (!domain || !irq_domain_is_hierarchy(domain))
-		return mode == ALLOW_LEGACY;
+	if (!domain || !irq_domain_is_hierarchy(domain)) {
+		if (IS_ENABLED(CONFIG_PCI_MSI_ARCH_FALLBACKS))
+			return mode == ALLOW_LEGACY;
+		return false;
+	}
 
 	if (!irq_domain_is_msi_parent(domain)) {
 		/*
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879..2f647ca 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -433,6 +433,10 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
+	/* Test for the availability of MSI support */
+	if (!pci_msi_domain_supports(dev, 0, ALLOW_LEGACY))
+		return -ENOTSUPP;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;

