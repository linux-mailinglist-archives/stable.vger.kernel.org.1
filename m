Return-Path: <stable+bounces-172087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07957B2FA73
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2360318992D8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFCC334398;
	Thu, 21 Aug 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSQ4tpmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D433D8
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782912; cv=none; b=W/uMAIpJ0kHY0p2cpqh9sOipexXIn5KFsB98QNjJ2M4degxjKgVjBSchDi9dt3TVUXg27iTbk39rDFNRLeuSXVdVHCCbsfiAhGvbJqR8EhO/a4oKOOHdrHoiwZ4epMHYthrvyGL3FhwHIqIX99LUnq3a57ZlvF3jE52NBjO0Xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782912; c=relaxed/simple;
	bh=NqHpzmkRLmJva7Rs5iKtzCxAsZPm3r1SNUxq9ydrhE0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PUWwQ3yi2YrNGX+VU0erJbx8HbDGYJMXzk6vyBCuLxmfCyczW1FQKGCvaYbVZpAkznxUDAAYQT3XCqijhsSyVl4p91+Qtu8XSyVSw/pYI5iLEWOBaSfpHlVVVBTBZ3DMukx32vKhIiJMrycF3YbNFpNs8XejmZxClA0g9XAj9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSQ4tpmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846A6C4CEEB;
	Thu, 21 Aug 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782911;
	bh=NqHpzmkRLmJva7Rs5iKtzCxAsZPm3r1SNUxq9ydrhE0=;
	h=Subject:To:Cc:From:Date:From;
	b=TSQ4tpmf+xYGtIOLCyq6M+ohX+N1OVvw0xZwxZv4FnWd1qFsAQFP+u6t+B5JqKWQT
	 zjlVtEW9PWKdAIvZMC2nx94rMhZZJeAjBN7iXPd9MoA3xqQoaHjodu8UbXnPaCerIc
	 poxri+arT2KbgbhIUwuZfVKRTNrLsp3xtLTOyqWg=
Subject: FAILED: patch "[PATCH] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before" failed to apply to 6.12-stable tree
To: geraldogabriel@gmail.com,bhelgaas@google.com,mani@kernel.org,robin.murphy@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:28:26 +0200
Message-ID: <2025082126-geometric-stark-b2bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 114b06ee108cabc82b995fbac6672230a9776936
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082126-geometric-stark-b2bc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 114b06ee108cabc82b995fbac6672230a9776936 Mon Sep 17 00:00:00 2001
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Mon, 30 Jun 2025 19:24:57 -0300
Subject: [PATCH] PCI: rockchip: Set Target Link Speed to 5.0 GT/s before
 retraining

Rockchip controllers can support up to 5.0 GT/s link speed. But the driver
doesn't set the Target Link Speed currently. This may cause failure in
retraining the link to 5.0 GT/s if supported by the endpoint. So set the
Target Link Speed to 5.0 GT/s in the Link Control and Status Register 2.

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
[mani: fixed whitespace warning, commit message rewording, added fixes tag]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/0afa6bc47b7f50e2e81b0b47d51c66feb0fb565f.1751322015.git.geraldogabriel@gmail.com

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 383d20f98cc3..fb9ae3f158a8 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -342,6 +342,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
 		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);


