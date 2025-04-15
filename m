Return-Path: <stable+bounces-132695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DC1A893FC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 08:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4431896D5C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 06:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637012741D5;
	Tue, 15 Apr 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYpdtCQz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75WBXRH5"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BD19E7F9;
	Tue, 15 Apr 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698998; cv=none; b=kd+6PoF651tU9BP6BBF05DGs/QSbE3Clc27Sj8Y+PkT8BgIoX+SzHYgfhQZW6WOd0HEISeoOq3niHrRrqdb5KYRF1lsOkvmfdlmpH9eplgFiPOx130VlZsewAIcgyydrp3qmpDdzBKakUhMpcknSTMzHfcximREt5CEJlR9y0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698998; c=relaxed/simple;
	bh=DHUV3MAYnLx14usRygDI5XOlCbsTZ4F018P9Ye7MW1c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a6gEc6W1vHpgN1CmxNxJkjUxB7j1hOylNPKN5gSVC/SZmXHu6xaX4nhB0TSjmdh3Q8vnp7MkWccv8te/RKp3Cl2Eyp6RcDVcaYAWH/Nfh+ML1IRuAeigh1Q/3O1ufJw/1G4dPoTwMHn6SQHQ/9hQmqiXTGfJs7Xo88kfsLxsP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYpdtCQz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75WBXRH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 06:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744698995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfUDejjWqOqJXYAaBs/4aO76M02EaPR8YrF/co/oIII=;
	b=NYpdtCQz/IvahgJwfZL5R5u1j9i4cE4DtPMa94HYERYoMjJwgC876p3iFEH71sqdJCjIp8
	lrj/3dgTVKbfhgKGKPc3f6iHMeRw6b98i7uN172P1ejWGes2dR3XUHr652XlZ3lElBeJw1
	YtzcOyPthyn1ey2aq379MsqaffEg2ijPLjfgrIPfv9eHNyG8tQB4oyEQLyKJgNWArk6QwT
	c9m904o0QDe8QdsDX4je1nYqTNk73chKt00SLSAGmnD77mmkEJ296Cp8FU2mTij54QudEJ
	BCe2BeAL/2R/mSU/6lyMNwK3xn9qr6kl9DsoSlKxW8zXgttIfXA5ANB1JMcDTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744698995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfUDejjWqOqJXYAaBs/4aO76M02EaPR8YrF/co/oIII=;
	b=75WBXRH55nanlf0kuF2uY/2vnV0bv+l/dsrjc4M4h3MDa12NRT7DxYHc8B6GIgHc3BUWWf
	/5X6ZBEawtuVUuAw==
From: "tip-bot2 for Jonathan Currier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Add an option to write MSIX ENTRY_DATA
 before any reads
Cc: Jonathan Currier <dullfire@yahoo.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241117234843.19236-2-dullfire@yahoo.com>
References: <20241117234843.19236-2-dullfire@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174469899423.31282.16890035810253105875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     cf761e3dacc6ad5f65a4886d00da1f9681e6805a
Gitweb:        https://git.kernel.org/tip/cf761e3dacc6ad5f65a4886d00da1f9681e6805a
Author:        Jonathan Currier <dullfire@yahoo.com>
AuthorDate:    Sun, 17 Nov 2024 17:48:42 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Apr 2025 08:32:18 +02:00

PCI/MSI: Add an option to write MSIX ENTRY_DATA before any reads

Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries") introduced a
readl() from ENTRY_VECTOR_CTRL before the writel() to ENTRY_DATA.

This is correct, however some hardware, like the Sun Neptune chips, the NIU
module, will cause an error and/or fatal trap if any MSIX table entry is
read before the corresponding ENTRY_DATA field is written to.

Add an optional early writel() in msix_prepare_msi_desc().

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241117234843.19236-2-dullfire@yahoo.com
---
 drivers/pci/msi/msi.c | 3 +++
 include/linux/pci.h   | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6569ba3..8b88487 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -615,6 +615,9 @@ void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
 		desc->pci.msi_attrib.can_mask = 1;
+		/* Workaround for SUN NIU insanity, which requires write before read */
+		if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+			writel(0, addr + PCI_MSIX_ENTRY_DATA);
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd..51e2bd6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {

