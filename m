Return-Path: <stable+bounces-80292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1698DCCC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5611F22EF0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B01D1F58;
	Wed,  2 Oct 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fs3OR1VI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA211D551;
	Wed,  2 Oct 2024 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879945; cv=none; b=QU5Dek2DEIiEIUMxn6p9EB+j9fiStiMmBlvE7KoMb2D1C40GpCRl+hMK9yRMiERq4NpukFJ7geGAwlcqMIF9/+mea7XVFpElENzUpcUqWMC5Sdhzhwk6NFguydyivvIM4Udmv6le9gtG9VCYbZzaGRhrAL9oYnHlYZ4aD/mXrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879945; c=relaxed/simple;
	bh=2+2LTS8McXzjqfqQuw/A5YZn2+aKiNJD1y2z3SewIqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN3e9RzMcWV/Av7vMfTGeWNqfmcqX+zg6GOmzOvy8HCiAnft0+8hDmq3r6J0oS+5GfOIZaq3H30dQr1qioMAnpK0h56gZvR8B8Sq17TqFHFb/iopWcSHUb59GHGlMaw5vOMxQ6fKuCZTqWR5ETw2M4rf62ma+b3r9HmqFS0jv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fs3OR1VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A30C4CEC2;
	Wed,  2 Oct 2024 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879944;
	bh=2+2LTS8McXzjqfqQuw/A5YZn2+aKiNJD1y2z3SewIqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fs3OR1VI5HmeoT1Q6dEuUl5e/2Rl0mXBxSscqYXMyjiIqvYnutWLchNayUKehzZQN
	 lcIPg9AfmF/3u41C+Rxv+4lipyjECIc0hTdv1CLZFkFat4fWnfXxFqYwhpk2CNxnBU
	 8yAib2v132nxQHI4LmTvac/DRc7ot5xdgQngvN7A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 291/538] x86/PCI: Check pcie_find_root_port() return for NULL
Date: Wed,  2 Oct 2024 14:58:50 +0200
Message-ID: <20241002125803.743737084@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit dbc3171194403d0d40e4bdeae666f6e76e428b53 ]

If pcie_find_root_port() is unable to locate a Root Port, it will return
NULL. Check the pointer for NULL before dereferencing it.

This particular case is in a quirk for devices that are always below a Root
Port, so this won't avoid a problem and doesn't need to be backported, but
check as a matter of style and to prevent copy/paste mistakes.

Link: https://lore.kernel.org/r/20240812202659.1649121-1-samasth.norway.ananda@oracle.com
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
[bhelgaas: drop Fixes: and explain why there's no problem in this case]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/fixup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b33afb240601b..98a9bb92d75c8 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
 		return;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
@@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
 	u16 pmc;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
-- 
2.43.0




