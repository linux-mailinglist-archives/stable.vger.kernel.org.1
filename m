Return-Path: <stable+bounces-192100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB1C29A1C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE59B4E20F2
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A113D2B2;
	Sun,  2 Nov 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdbovCJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52B34D380
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762126162; cv=none; b=sRbh2W0dL81gAwCntat/QEc1YDbxF7uwSGdoSWSy+6xJGkDDEm583ZvmC8WU9BEJrvbT1SN4No0d97TJuPTAvHGZjZ2nQDNhMR0/7/bKiba62ddIz2lV3+GKNUE4tJ5bcEZ+pfN9JD+Kv5e3XLBdiroGz3q2smrH9H9wBTYFlzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762126162; c=relaxed/simple;
	bh=YhkV0ozlGRleIcHQcJInBhZ5xkrfDAQ5NIzLjbeh/G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHM264LpVyP933u5JOUYWDRlYWFLKdG+h4d7a6FNy55nSA6Ye/+XQcVrcTZx6TX5p7+GJkjcWfdHjB477YkHm7O4j0azKq/h3LvJbI+lOHip47uz6FgoLnVFo/o7ZZcGCjh7UmYSAYTpFi98+TXBWHAQJhqAZ3ckXEsLUUkivtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdbovCJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D58C4CEF7;
	Sun,  2 Nov 2025 23:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762126162;
	bh=YhkV0ozlGRleIcHQcJInBhZ5xkrfDAQ5NIzLjbeh/G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdbovCJ351sGLE3/IrulzdVPhFl4bhHRSdANVWO9GVl+pZpTzHGl9atF5yiH/VNm6
	 CXGxq4D7v86LaufUc8wX2jBtx8sUSsHYtwkBRz3FhN0SiEC8t7RxuwyIpTERgA+M32
	 MdFoABADeqz51SKEDv1l8AyKxwyOXSelrIvxXoRgpftbkyPgvJYDbze8hZT+PjdK0Z
	 1zOJcrDPt1ZCUpAhYUrUXQunaV6t35Em0sgHd9p3qt7sHAvD0VdLfkikrvkbmjI+PW
	 rbXtHnmgEtD8BxlFNXWkhcJR0bGt+hfEToFb2NPnboorP6XPGEQgr+mEhNGoHnGEqK
	 QaEt1OrWJ+akQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>,
	stable@vger.kernnel.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] s390/pci: Restore IRQ unconditionally for the zPCI device
Date: Sun,  2 Nov 2025 18:29:20 -0500
Message-ID: <20251102232920.3654814-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110234-parameter-underdog-10cd@gregkh>
References: <2025110234-parameter-underdog-10cd@gregkh>
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
index b248694e00247..30e8e6baa5f85 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -138,7 +138,6 @@ struct zpci_dev {
 	u8		has_resources	: 1;
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
-	u8		irqs_registered	: 1;
 	u8		reserved	: 2;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 84482a9213322..e73be96ce5fe6 100644
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


