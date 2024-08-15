Return-Path: <stable+bounces-68741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86339533BD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC371C254BD
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017451A76CC;
	Thu, 15 Aug 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGOaRoHn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFC17C987;
	Thu, 15 Aug 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731517; cv=none; b=nN8sTVBf0GmAQmAoyQ4TWFUmJ+VeY0BQyXnrn7cQoi46JBGT8XP7OxgxpTOY4PPbKu5KXoAALCZe28ik4E4nkXX/no3iOX2S71C7IHdgg22nKwr7O4rDBtTcwTn406AeTM1oftE4gzdgfYqyLE5Ajl5g0yxqcmPfMHkPvZmVDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731517; c=relaxed/simple;
	bh=1Pq3Hm6ravv1EfWVdGck0oSBYHdexn2LYoMwmxa3DXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHkZX8vocSo/NNH5Vbn++C/br93NlXTLjZY3Ta3eCS2pUvMM/EFpg73S2M2VL1+HP8vah+I6/k4K1I5zlKsX1hz43QLI8qbgnpKTAZt2Q0b9N2x+x/C5wqJV8QgolLbXKO1lZzr7E3LvzBrYY9O5YjhZ1POPH7p8kRBfhkGu1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGOaRoHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89AAC32786;
	Thu, 15 Aug 2024 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731517;
	bh=1Pq3Hm6ravv1EfWVdGck0oSBYHdexn2LYoMwmxa3DXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGOaRoHnHpkWSomkmjbbdOoJtoxJO0IOH0wXV0VjEGhmWp/4mD0Ure8v1TKvykOhs
	 BwwtvAGXVfKM3Ihc/9F9eEB6iR0Lx52bEnlCD1ABB23DzHMt7aXGo9x/+B860TOrzf
	 u512oqvVjtZaiG9aWK/ZTKT/nuFe/Gr36npPZ0fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 154/259] s390/pci: Rework MSI descriptor walk
Date: Thu, 15 Aug 2024 15:24:47 +0200
Message-ID: <20240815131908.734471037@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2ca5e908d0f4cde61d9d3595e8314adca5d914a1 ]

Replace the about to vanish iterators and make use of the filtering.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Link: https://lore.kernel.org/r/20211206210748.305656158@linutronix.de
Stable-dep-of: ab42fcb511fd ("s390/pci: Allow allocation of more than 1 MSI interrupt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 5036e00b7ec1b..9ed76fa9391cb 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -273,7 +273,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 	/* Request MSI interrupts */
 	hwirq = bit;
-	for_each_pci_msi_entry(msi, pdev) {
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
 		rc = -EIO;
 		if (hwirq - bit >= msi_vecs)
 			break;
@@ -338,9 +338,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		return;
 
 	/* Release MSI interrupts */
-	for_each_pci_msi_entry(msi, pdev) {
-		if (!msi->irq)
-			continue;
+	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
-- 
2.43.0




