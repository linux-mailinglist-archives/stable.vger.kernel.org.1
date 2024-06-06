Return-Path: <stable+bounces-48365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFFA8FE8B2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843D2B2421C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BD196DA0;
	Thu,  6 Jun 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dlr/M8H6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B6196D9C;
	Thu,  6 Jun 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682924; cv=none; b=Z5KV0fm+H04Tl5u5FAmBG46+QiOOFFtOVRlodx+ieMqYq6x/FwVsqhV1SvXiFXLV5R6PpyMGA9BX3wH33QOisf39vnXF9hQn7x/hVk/AmVp7DFgTatkS0ARcTPgVp3iY8WQvzEtTv3WrkrWUC27A5mzO9FALRQlvSM0p0mUP0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682924; c=relaxed/simple;
	bh=gKHrmOY6iwxjMkXV9vSgOb+FD0C/HX4jud+me9CdNNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoniyqJDi7YfMJwSudczN6TOe4dljoHMSka9zRk55uIgq8zbWUfTMd8hup1d9/E3TR9qijWwpbO+4rpq9IXFsdmYU1ljTmoELUgApUZmuLDsm/sy/3CVQQfdK89bYS2/vQKOR2iN1DnP7k+wjoLQISLgFp8s6kXC8Zcqx/svsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dlr/M8H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E3C4AF08;
	Thu,  6 Jun 2024 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682924;
	bh=gKHrmOY6iwxjMkXV9vSgOb+FD0C/HX4jud+me9CdNNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlr/M8H6rKzzuIgPcIK815qA5SNQ9HUypdxedhfUy6PKZkxoqJBXY3psm0IwPBGfZ
	 xOUSNd3i6Nia3gp87zIFZn2a7mhj5skOO9DJqhxbpw/W+TTT1gxSvRlOSU55IhSAPW
	 yOzksj7c3yI8wRkMs4pNgATcQOD4Ru/xTI+ut7Wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 066/374] PCI: Wait for Link Training==0 before starting Link retrain
Date: Thu,  6 Jun 2024 16:00:45 +0200
Message-ID: <20240606131654.048664683@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 73cb3a35f94db723c0211ad099bce55b2155e3f0 ]

Two changes were made in link retraining logic independent of each other.

The commit e7e39756363a ("PCI/ASPM: Avoid link retraining race") added a
check to pcie_retrain_link() to ensure no Link Training is currently active
to address the Implementation Note in PCIe r6.1 sec 7.5.3.7. At that time
pcie_wait_for_retrain() only checked for the Link Training (LT) bit being
cleared.

The commit 680e9c47a229 ("PCI: Add support for polling DLLLA to
pcie_retrain_link()") generalized pcie_wait_for_retrain() into
pcie_wait_for_link_status() which can wait either for LT or the Data Link
Layer Link Active (DLLLA) bit with 'use_lt' argument and supporting waiting
for either cleared or set using 'active' argument.

In the merge commit 1abb47390350 ("Merge branch 'pci/enumeration'"), those
two divergent branches converged. The merge changed LT bit checking added
in the commit e7e39756363a ("PCI/ASPM: Avoid link retraining race") to now
wait for completion of any ongoing Link Training using DLLLA bit being set
if 'use_lt' is false.

When 'use_lt' is false, the pseudo-code steps of what occurs in
pcie_retrain_link():

	1. Wait for DLLLA==1
	2. Trigger link to retrain
	3. Wait for DLLLA==1

Step 3 waits for the link to come up from the retraining triggered by Step
2. As Step 1 is supposed to wait for any ongoing retraining to end, using
DLLLA also for it does not make sense because link training being active is
still indicated using LT bit, not with DLLLA.

Correct the pcie_wait_for_link_status() parameters in Step 1 to only wait
for LT==0 to ensure there is no ongoing Link Training.

This only impacts the Target Speed quirk, which is the only case where
waiting for DLLLA bit is used. It currently works in the problematic case
by means of link training getting initiated by hardware repeatedly and
respecting the new link parameters set by the caller, which then make
training succeed and bring the link up, setting DLLLA and causing
pcie_wait_for_link_status() to return success. We are not supposed to rely
on luck and need to make sure that LT transitioned through the inactive
state though before we initiate link training by hand via RL (Retrain Link)
bit.

Fixes: 1abb47390350 ("Merge branch 'pci/enumeration'")
Link: https://lore.kernel.org/r/20240423130820.43824-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd42884..70b8c87055cb6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4629,7 +4629,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * avoid LTSSM race as recommended in Implementation Note at the
 	 * end of PCIe r6.0.1 sec 7.5.3.7.
 	 */
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, true, false);
 	if (rc)
 		return rc;
 
-- 
2.43.0




