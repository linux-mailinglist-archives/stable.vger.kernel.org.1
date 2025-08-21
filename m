Return-Path: <stable+bounces-172094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD3B2FA81
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3839162911
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44333439F;
	Thu, 21 Aug 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ebqym96R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6A3218D6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782941; cv=none; b=E4PdAZPntk/lo64ot8uR08tJjpP9nIVrfSMfNWzgHEAhObUzY56drpTA0ERHCX8efy4O3YaZboqYQllJa3wlmJJWx4t4bsSPm5eltjkhdceRZK914VFcgiQ0USQb3vyjJiHOk8HomXnWmrmuADrMouN7QYm5UbGqfe8+RicgC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782941; c=relaxed/simple;
	bh=MxWGlUf03Ur9C+bS/N2zKf7+Axkas9QwNlETQUo2oLs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sPdcwWNEi8qbNdntd70GTyRpXJFiz1x/Cl7d2yiV3D6nueImdWf1eHlFnApp5wP8B4Pyxios+CAT6kxb+wppHN6EsO5/oFqKS4NBDEjmgo1EIpe+rPmH0D+PEUttq8Ad4muz5BsM8JXLsboI9IYzZ5Udy6NIlkcI56OoELFtgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ebqym96R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5563C4CEEB;
	Thu, 21 Aug 2025 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782941;
	bh=MxWGlUf03Ur9C+bS/N2zKf7+Axkas9QwNlETQUo2oLs=;
	h=Subject:To:Cc:From:Date:From;
	b=ebqym96RjcJbOe9/0O+qqEwZuvkAvyJ3DB6yTeAheEKPJSmlOOGYHHf3z9MW3ZU6G
	 SwokdtuPVydHovUBgg+h50q86WbNgWoHQL/RYMl+digjRbmatUVpoibl4hXsUvANYs
	 J0okj7hO639FaL22hSN8pDX3luqFnsZ6Px5w4NYM=
Subject: FAILED: patch "[PATCH] PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4" failed to apply to 6.6-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:28:52 +0200
Message-ID: <2025082152-acetone-swept-9f05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 399444a87acdea5d21c218bc8e9b621fea1cd218
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082152-acetone-swept-9f05@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 399444a87acdea5d21c218bc8e9b621fea1cd218 Mon Sep 17 00:00:00 2001
From: Richard Zhu <hongxing.zhu@nxp.com>
Date: Tue, 8 Jul 2025 17:10:03 +0800
Subject: [PATCH] PCI: imx6: Add IMX8MM_EP and IMX8MP_EP fixed 256-byte BAR 4
 in epc_features

For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 and reserved BAR 5
in imx8m_pcie_epc_features.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[bhelgaas: add details in subject]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250708091003.2582846-3-hongxing.zhu@nxp.com

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7d15bcb7c107..9754cc6e09b9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_64K,
 };
 


