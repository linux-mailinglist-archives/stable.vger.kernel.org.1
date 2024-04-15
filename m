Return-Path: <stable+bounces-39512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD468A51F2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A282B247DF
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8479945;
	Mon, 15 Apr 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tx5JLS8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369378C6A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188352; cv=none; b=Q2TEbIqK51MCgTDQeMk3qpwNUFj5nC4Sg4A6undv4qdNb8moufSH6u6vRn3lBsnH6CwmgfTIts8hQAg3XjHx2DkiqLDOwECWSvoZoAoPeDYg6jlW91cDg6IK3btEsGHfnMIRtNkQHPgJMOyXJtX20AutRMVbfcNGbMC1R8ADx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188352; c=relaxed/simple;
	bh=MOazXK39iYd867QKvWtV8bfY+9WEe3X01pEIruCVddA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDCfXlQ0wQPwjMual5QzWG4Rg0mNsmCeD8aB5ecUm96PO2PzVJo78bH1CampCc4A7HWef94wDDMKJxr7i7HXtpA1WPHg74KYp28cvSijy2vpHrS9Y9ea6wBw0EUPLna4GYRsbhlr9cYAp2rh7j+tO07vlDQxBYR9d+pb+KDJXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tx5JLS8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C71C113CC;
	Mon, 15 Apr 2024 13:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188351;
	bh=MOazXK39iYd867QKvWtV8bfY+9WEe3X01pEIruCVddA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tx5JLS8R7sCjysnU5TTxVgXCH7+6oOZCK3AJ/rrFCcBdGUE3DDgcHGVDC8nUGv8zd
	 dSuIDx3KtYa8RJgrPwfXemDKhUU85LAAKcjw5PZo+k72CjDOxAuLnoO1dNSEEHjPVM
	 8NtgJB9Hg2Z/XwgvibIUm7DYx31lCVOTDgUvyaGSI37Cgvz/ePNztyeEzdDfg0rfU0
	 UPTzoxzSwnLL5t9TQoe1j5fT+paj8Fm8gBPH0QwLdE+mo+IiPpMjgGVbuv0HGhPe5r
	 JOVDo47//TlruMn5KyXBPCtvUJnzJSI58k0mpriDB/IrpS9Oitpopi2F+OV9qojhwi
	 hDeKzZlugVeHw==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 044/190] PCI: keystone: Don't discard .remove() callback
Date: Mon, 15 Apr 2024 06:49:34 -0400
Message-ID: <20240415105208.3137874-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 200bddbb3f5202bbce96444fdc416305de14f547 ]

With CONFIG_PCIE_KEYSTONE=y and ks_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
resource leaks or worse.

The right thing to do is do always have the remove callback available.
Note that this driver cannot be compiled as a module, so ks_pcie_remove()
was always discarded before this change and modpost couldn't warn about
this issue. Furthermore the __ref annotation also prevents a warning.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 3ea8288c16053..54fe75fd46b9d 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -379,7 +379,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = ks_dw_pcie_link_up,
 };
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 
@@ -457,7 +457,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = of_match_ptr(ks_pcie_of_match),
-- 
2.43.0


