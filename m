Return-Path: <stable+bounces-205512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A14CF9C8A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94D9B300DB03
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB4306B1B;
	Tue,  6 Jan 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l3pt3dvq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD7303C88;
	Tue,  6 Jan 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720940; cv=none; b=OqNG6hr7wMOEFZ0rCiTs1mj9MdzR5VB1NiPX9z36FxPZKMw0pVSPVMAzIK9RaF7Ddnp6TSdfeDUwZPEM65gZsdGtMsIoeyHYkiPrCN2AKYv/DV6KOP7uLaXqwXtelxjvD8kv7PSaPwLWUFyAyw91LF+8PygI5G04jUxlioohjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720940; c=relaxed/simple;
	bh=+wL4LRoY5MdAh4wBwBRf/Ud1E5oru4de98FOpMSjaFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aub4/meZrgIVgAZEBl+IU9IE9j8VgT3IbsI02APIi29st+SLkh/aT9yx9v5uSuKy2oBruceDU9pOvB2rG3E/e2uTFGgz9mR1q8yi9Y2r0FrVrK6HFxaPEkmKiSCZRGQOHCXFoCxNqHvUz11EJwvS0H/aLCIzhJHe5Y5yOFkcdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l3pt3dvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A74C116C6;
	Tue,  6 Jan 2026 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720939;
	bh=+wL4LRoY5MdAh4wBwBRf/Ud1E5oru4de98FOpMSjaFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3pt3dvqWC7Z9RZFAghdt0PezfJEwlJ+qKt6KxUhNeNG/07qO+URxy7qmCq4wcuRg
	 IiHYlc1gs5EntqhgyMgMv2eZCaGrSXo1YifvLttCtiizAbF/Cnj5RccUKrpdm5Ax73
	 fypWl7U++aUANZ0tezPD83M1yz8+PLVL6WUnhBTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.12 354/567] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Tue,  6 Jan 2026 18:02:16 +0100
Message-ID: <20260106170504.429735842@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinhui Guo <guojinhui.liam@bytedance.com>

commit 75ba146c2674ba49ed8a222c67f9abfb4a4f2a4f upstream.

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd/init.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1602,13 +1602,22 @@ static struct amd_iommu_pci_seg *__init
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,



