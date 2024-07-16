Return-Path: <stable+bounces-59483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5B932933
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E91F21602
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09A1ACE6D;
	Tue, 16 Jul 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1bPU6u6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7CB1ACE73;
	Tue, 16 Jul 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140202; cv=none; b=ApVTBnBXzLJecCSOBSVf5lSC923EN+rS1ofF8EsPzh5koMI5X6b8h4/hND5NJSv+us22877lpnf/itL6DXzH2t1zkT9q81O22rcykvqhxos11xrs780VpSWxk7tclo48ucT1QJh7n9wq7SmSHNa6rp/kfvmuZW4mAjp5m+Ij8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140202; c=relaxed/simple;
	bh=bpfITA42XWvZVHxWy7B4/5zK5MXRBy8D9dEJb9S7Ioc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm5VTNo7b2BZkFBhjlcA0s1oV11yE6GbD7midULdoblGlCIQNFlOlsO4eyejESLT0bKAnUEe+hG7DgMYDL1izxqlH/P7yZ87YZS/OF7L8RFmOGGpZhtjTBYgJD42XEnVC7BujUTLqUB5j+wGNIe4J0/PeSRpUfNnFgXlj9qKXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1bPU6u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B30C4AF09;
	Tue, 16 Jul 2024 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140201;
	bh=bpfITA42XWvZVHxWy7B4/5zK5MXRBy8D9dEJb9S7Ioc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1bPU6u6bbt3GrU5I1EaStl75fxdnRTqkM6quds9zVYclr55AE5gwf63fgsvyHuMn
	 0+54ZGA3w0aqWapx0E0lvYR84H3pYa9cTF2GFsscqZRN2sEmngb25rk84+/FfdvD6P
	 GI7v/IgLvRKWETIAV0TohAutMDVwQGV8pNSO3rTZrLniqV6lQGOsQP6YqvNb0cOZdk
	 U+9+FSkX6x/+CdRGCqp1hVPKNW0L0iMh5c60ktcDA08C0FxscbsTYUtZ1RDAa6Qq9J
	 SuqQR/8rjOGOy18DPh1E5zzmBX3FC7vGLyPzMtWYTw54g+uVxCq2gUovSXf3ObBBtA
	 VSp4hHA8VtN3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 3/7] powerpc/eeh: avoid possible crash when edev->pdev changes
Date: Tue, 16 Jul 2024 10:29:43 -0400
Message-ID: <20240716142953.2714154-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142953.2714154-1-sashal@kernel.org>
References: <20240716142953.2714154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 845e024321d47..a856d9ba42d20 100644
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


