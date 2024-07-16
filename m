Return-Path: <stable+bounces-59459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76D9328F5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458D31F22573
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBF1A9074;
	Tue, 16 Jul 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLpqc8xu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C519DF86;
	Tue, 16 Jul 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140114; cv=none; b=YWk23DEfBuBU73p3ZX7LzuEB+1+vqE2r9keYLXnPPevt8kjRr02qEoBHgLPKI2bZkGJc7XBqng28bmxiB2ArwJxL8GoPUUijoLDVT6vIm7XZKmCnH0A87M7Sj6e9zwBIEnrqYfEkhVDAZNuvEnNl3VYxw7r/ArrTsVnOvEXK5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140114; c=relaxed/simple;
	bh=60SeZ4m4xDv43jZaIxH9z3C6iKXcxRIqNZpQS0Brq18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMf/865dmqWEVn+8Z0YlwVLCmV0PX+bIWPKfdzwRE5sKJI6PsuB5HdFEuCDTsc34O+uD82IvQWSd5/bvhQLJsSBKfp3GBZdXvRUCCSyPDyjpRTEuXLI9wLk3s63iI/AkLdE+sqUOZBNPQ8CRXJEvdaK88G91DnZ0QydfxC3YIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLpqc8xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A65C4AF0E;
	Tue, 16 Jul 2024 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140114;
	bh=60SeZ4m4xDv43jZaIxH9z3C6iKXcxRIqNZpQS0Brq18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLpqc8xui4ehk3l9SLulwJA2YKof5lc5574Fl/n/70imxmD3nhHXgV+W5XoLGIZIy
	 GQ841UpOUds0R+buLTigzRXfdSbeoHg/eX1Djg7dnTe1V4xlJV0yoNvnurEhw/DhQK
	 tfePM+iYUEJo2kYPN2oPaG/dbyyw1WwLw7hixxnrAdx/WMb5kfzQYU54gSHbKO+KoO
	 bv+6XSD4G2pN4Hi567W3qyNM6BfyQnuzqHdWP+NtDM94zTQFB1NnsXEEoqI6gF0/6J
	 ryCTAwsOB9dc2i7dlPIiyMmYNHCjptAdJdeUKR0aafu+OImOrfqqcbhLnbCAFAOszY
	 UWxiqsD6kUvHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 03/15] powerpc/eeh: avoid possible crash when edev->pdev changes
Date: Tue, 16 Jul 2024 10:28:00 -0400
Message-ID: <20240716142825.2713416-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
Content-Transfer-Encoding: 8bit

From: Ganesh Goudar <ganeshgr@linux.ibm.com>

[ Upstream commit a1216e62d039bf63a539bbe718536ec789a853dd ]

If a PCI device is removed during eeh_pe_report_edev(), edev->pdev
will change and can cause a crash, hold the PCI rescan/remove lock
while taking a copy of edev->pdev->bus.

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240617140240.580453-1-ganeshgr@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh_pe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index d2873d17d2b15..e4624d7896294 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -850,6 +850,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 {
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
+	struct pci_bus *bus = NULL;
 
 	if (pe->type & EEH_PE_PHB)
 		return pe->phb->bus;
@@ -860,9 +861,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
 	/* Retrieve the parent PCI bus of first (top) PCI device */
 	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, entry);
+	pci_lock_rescan_remove();
 	pdev = eeh_dev_to_pci_dev(edev);
 	if (pdev)
-		return pdev->bus;
+		bus = pdev->bus;
+	pci_unlock_rescan_remove();
 
-	return NULL;
+	return bus;
 }
-- 
2.43.0


