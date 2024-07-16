Return-Path: <stable+bounces-59490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56AB932947
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5653285215
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD121AE091;
	Tue, 16 Jul 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s95Mqlp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB121AE08A;
	Tue, 16 Jul 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140230; cv=none; b=VETC9tMUwRZ9QRg9401d9zCtfIrigfNGNj7IXDN23uMZdyN56rrYiuX4dT9CRBo9rhtHcUAc9BhTlwYAYT0w+yFs3V3jYD6hwWDSmHw3yEQBYu9iId42PvIfMcIJ15Ag5b7MpgSTnvl14joIOKEB6NkkKFRiONfe/vrb9fQt8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140230; c=relaxed/simple;
	bh=0bsUPsaGmfer7k05xolrUhbzePNdBqNTnnahyIoquWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smfzk2wZKqpd8AVrFKnfFPBCGugMCFLGiew13VKjsrLar4jldNHODky0WQt2IG40cwqwmnpdC70ew++7RZCf3p8EgPfUrQ+qWrgmjRMNX390GgBTKLCQcSIhwaLcdb7iMvWbzqCcXTlA1rZ88Y6YTnhDupeZnjS1wWeU4Wg2GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s95Mqlp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D3C4AF09;
	Tue, 16 Jul 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140229;
	bh=0bsUPsaGmfer7k05xolrUhbzePNdBqNTnnahyIoquWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s95Mqlp2c0OxVRwEt9eOyjNCnn4s5lhUneMzX3j5TJPO5L78p/PG4RaG5kTMk9Ujj
	 Itx1jL+I2gaGSL7JkfdHAG60UuQXkHfxONLtrMyA316YKlaWQ/aMmm0bZomOJls8dc
	 KFZvQtIIcCIbwULoT0724oHagWYEg6aY32EB3dgr4ncEYqT913P0+TopciWeYpy5g4
	 5mM6TQ9wNEmp5Cb0OlGbJZDNKlUBqOL7aTGqXFgHYNKRHUB1mVDT3jbJ34ZrHv9RGL
	 CXG+UkY5sUI4tFOvYYe8RI8HtoofNjuwxwZ5DYMLCsgacWRISzsLSQDAgk8iK2nO94
	 iWLza51PZRO+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 3/7] powerpc/eeh: avoid possible crash when edev->pdev changes
Date: Tue, 16 Jul 2024 10:30:11 -0400
Message-ID: <20240716143021.2714348-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716143021.2714348-1-sashal@kernel.org>
References: <20240716143021.2714348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.279
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
index 177852e39a253..4b6b1846e4d23 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -922,6 +922,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 {
 	struct eeh_dev *edev;
 	struct pci_dev *pdev;
+	struct pci_bus *bus = NULL;
 
 	if (pe->type & EEH_PE_PHB)
 		return pe->phb->bus;
@@ -932,9 +933,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
 
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


