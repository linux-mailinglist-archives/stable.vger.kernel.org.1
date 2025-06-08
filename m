Return-Path: <stable+bounces-151925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E4AD1255
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A3C188C3DC
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5E21772D;
	Sun,  8 Jun 2025 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaKKyUwQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B6205E3E;
	Sun,  8 Jun 2025 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387359; cv=none; b=ToBb/9b8l7y8xaNHR39RYaSWlSNgOdVzxmEPUlj9Ts4EV52tSY76/xUtb+oS5KMe3OGGLmpKJT7XSrwAKK56usl6fqxl0upLiC9jY/LBy0LjlL9nBH8XlnhjdV2Zu5Wk8wZJpP4qBFhb9RbIvZVq4P7LYHOWpkO+9Lgnv+Ii6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387359; c=relaxed/simple;
	bh=AZm/gjwqLwwSOgS+a+0d30mNruiU3F0TyHCO/ph0PVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHZ2U8sou9Lj3ZB7tauRuLCes7W217BgURGbgwWQ9ExngIcMMtwDm4TobDFTnjZqUQVF6xxE+eW+b+De7S1hR1NSuHf/YIT2G7wcBj8ryl/SC5Hinf7yNz5RiJxEvSMhd3iIzwEjXne7HRWkMvXF8wqmMmd+nrrWVnRS50k7IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaKKyUwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B101DC4CEEF;
	Sun,  8 Jun 2025 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387359;
	bh=AZm/gjwqLwwSOgS+a+0d30mNruiU3F0TyHCO/ph0PVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaKKyUwQc4onRTMCSM6gW7LqO60qf5pWSe7E5Y+MbcMFUNQ6bCGMA0YddCBXoYGfE
	 44v6NeiruOdT5nR1TvPYKf2F8zWwjS0wGy8FAZCcuqcP7AYp6uXvezlVv6ogJ/l8/w
	 MmFL4lnfxkBfz4AFzAjdni1queTYOGsGJgfumB9bllpMC5WNk5TbmjQQdqJG/ZQL9H
	 qxLPYnhLfmd22fwyWM7IwYxWCbXZvHpfOm3mBuAKvxwHJQLvCu4OWm2BdVYvoJIp4L
	 BJz6zTmnbbT7q9Iw/+zx3BEwLX/hyjsSpw7oD7pjZcwzYyUxEzjdpmnyHVCMm8y+gw
	 c7mFTDmEfDKSQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/3] Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices"
Date: Sun,  8 Jun 2025 08:55:54 -0400
Message-Id: <20250608125556.934550-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125556.934550-1-sashal@kernel.org>
References: <20250608125556.934550-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 3be5fa236649da6404f1bca1491bf02d4b0d5cce ]

Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") changed IRQ handling on PCI driver probing.
It inadvertently broke resume from system sleep on AMD platforms:

  https://lore.kernel.org/r/20150926164651.GA3640@pd.tnic/

This was fixed by two independent commits:

* 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
* cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices")

The breaking change and one of these two fixes were subsequently reverted:

* fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"")
* 6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")

This rendered the second fix unnecessary, so revert it as well.  It used
the match_driver flag in struct pci_dev, which is internal to the PCI core
and not supposed to be touched by arbitrary drivers.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://patch.msgid.link/9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees.

**Extensive Analysis:**

**1. Context and Purpose:**
This commit is part of a coordinated series of reverts addressing
regressions introduced by commit 991de2e59090 ("PCI, x86: Implement
pcibios_alloc_irq() and pcibios_free_irq()") which broke system
suspend/resume on AMD platforms in v4.3. The original issue was fixed by
two independent commits, one of which (cbbc00be2ce3) added the line
`iommu->dev->match_driver = false;` to prevent other PCI drivers from
binding to IOMMU devices.

**2. Code Change Analysis:**
The commit removes exactly one line from
`drivers/iommu/amd/init.c:2034`:
```c
/* Prevent binding other PCI device drivers to IOMMU devices */
iommu->dev->match_driver = false;
```

This line was setting the `match_driver` field of `struct pci_dev`,
which the commit message correctly identifies as "internal to the PCI
core and not supposed to be touched by arbitrary drivers."

**3. Why This Should Be Backported:**

**a) Part of Coordinated Fix Series:** This revert is the logical
completion of a series of reverts that fixed major regressions. Looking
at the similar commits provided as examples:
- Similar Commit #1 (YES): Revert of x86/PCI pcibios-irq allocation
- Similar Commit #2 (YES): Revert of PCI IRQ management helpers
- Similar Commit #5 (YES): Revert of the original problematic
  pcibios_alloc_irq implementation

All these related reverts were marked for backporting, making this
commit part of the same logical fix series.

**b) Removes Inappropriate Code:** The commit eliminates code that
violates kernel design principles by accessing internal PCI core
structures from a driver. The `match_driver` field is not meant to be
manipulated by individual drivers.

**c) Cleanup After Main Fix:** Once the root cause (commit 991de2e59090)
was reverted by commit 6c777e8799a9, the workaround became unnecessary.
Keeping unnecessary workaround code, especially code that
inappropriately accesses internal structures, is problematic.

**d) Minimal Risk:** The change is extremely small and low-risk - it
simply removes one line that was setting an internal field
inappropriately.

**e) Consistency and Completeness:** Since the other reverts in this
series addressing the 991de2e59090 regressions were backported, this
should be included for consistency and to ensure the cleanup is
complete.

**4. Stable Tree Criteria Met:**
- ✅ Fixes inappropriate driver behavior (accessing internal PCI
  structures)
- ✅ Small and contained change
- ✅ Part of a series addressing known regressions
- ✅ Minimal risk of introducing new issues
- ✅ Consistent with backporting decisions for related commits

The commit represents necessary cleanup after a coordinated regression
fix and should be backported to maintain consistency with the related
reverts and to remove code that inappropriately accesses internal kernel
structures.

 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b6ee83b81d32c..625ff2486982d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1870,9 +1870,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (!iommu->dev)
 		return -ENODEV;
 
-	/* Prevent binding other PCI device drivers to IOMMU devices */
-	iommu->dev->match_driver = false;
-
 	/* ACPI _PRT won't have an IRQ for IOMMU */
 	iommu->dev->irq_managed = 1;
 
-- 
2.39.5


