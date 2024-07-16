Return-Path: <stable+bounces-59441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5AC9328BA
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6701C20C8B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E31A2FB0;
	Tue, 16 Jul 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhBKtF6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E501A2C34;
	Tue, 16 Jul 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140042; cv=none; b=PU2epXXb2Bh+HHDxGaccfss+w++BJ8FaDUWjc4aZi3L9RSVJBYMLNUZ06qBxOzNh5ZMfPKJVobJelZL9aSp2JW9vJVbdtK9JIuRoIhQbcgeR/dMH7rFQbZcbj0PRe+wtLKbSjcAvi5bgMp/fG7aUj2zGMRz8fYyOOP/2XAnktaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140042; c=relaxed/simple;
	bh=Q5oPOfaPPMtVbJo9sOz517kdeGlVdwhnoDlCg22S/Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXBYYc+qlFSAZQT0uLmcyaDRfqqlM2N0MSq7OvWeYt58l9ZE6iyOaflgckJy++QieBAxK/qrSNDnEJw2mK79AAJsvkCXBJcMLuJqL7o5I60UNdmlL3+sTty3H9AazuV9msBJFhm9CrssqcChDJZCbFRJ2YL2kMyy1l16Kw1NKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhBKtF6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F384EC4AF12;
	Tue, 16 Jul 2024 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140041;
	bh=Q5oPOfaPPMtVbJo9sOz517kdeGlVdwhnoDlCg22S/Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhBKtF6oBPEgrSuVdgqyzjhTDIqZauHYTjfmzfl/wBUvT9LsJ2AOq6CJ58xez1HT3
	 wNroLeS3fJp+hLWN2YQ3iPON2m7XidCuzxIW2j2z+unkepw+eKtWXVOLtN07Bka0mF
	 KtcMJzwMXTfQB5erKLf8RqKeO3tFVFmQFaDOUOeYiG+Z1NGEsOXSyEXTsK3nsQQkQg
	 cgKDJrp/sdaA7WTAhF5g6jHqJZ7Y3Iu+hJm8yUncRkhtKz6gbe5oXtzJAQ6XtjuxJN
	 uIf3g8fMgt2AURGHNNDb2kG6eSVDxV2Ws4c8BVMHvFdiBWvZ/rjgyTyQ3TlDKcJkyx
	 o4TZDVPrpwpFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 03/18] powerpc/eeh: avoid possible crash when edev->pdev changes
Date: Tue, 16 Jul 2024 10:26:38 -0400
Message-ID: <20240716142713.2712998-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index e0ce812796241..7d1b50599dd6c 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -849,6 +849,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 {
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
+	struct pci_bus *bus = NULL;
 
 	if (pe->type & EEH_PE_PHB)
 		return pe->phb->bus;
@@ -859,9 +860,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
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


