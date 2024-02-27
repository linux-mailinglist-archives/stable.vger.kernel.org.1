Return-Path: <stable+bounces-23958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E9869202
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5921F23225
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCF145FF5;
	Tue, 27 Feb 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHHahEwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9F145FE1;
	Tue, 27 Feb 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040634; cv=none; b=uaKxrCA1LXHa+3GnIDo/3cuekIXKwFUzVkAhfGCh0cuCJled0AbPUKrNk04LAiDi6GWpylO2mxgcMycRmMMirsp+AEFGSKfubXNantJi4NmVho8M2vKxzIVJC/+0QKmuLTnOVbY/83wBpRIRrKG678iOsOTYvhzMH8Xlkf3szxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040634; c=relaxed/simple;
	bh=nH9Z9ytTBJb3GiswaQwXgGnEO3sa5ISSEmh3e8duSvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGDvUO8x6q+VMp7Y4CYkET0d290w+Ka1ORSV4YThHEiPL2jqOwGtqTNmviwOdj16Lz+jEjSNVd8F9JREkpzxITYDK6i6TKPh2Q02bNeKSPi6C0Gv74kSKl8jXmcMhwMdK+iliFNbI2ve3UHgoCisA7JMg7iXVuIz/hVIMankYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AHHahEwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F47C433B2;
	Tue, 27 Feb 2024 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040633;
	bh=nH9Z9ytTBJb3GiswaQwXgGnEO3sa5ISSEmh3e8duSvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHHahEwi4o1wzgGaa7VUpl1ie3AFVKQq4MIq2pr4wjSCeXkqnkW/KqYaNMKudZNzD
	 7yGw2nzPrctXJgJYY3ysekGRbwykuSqi+IeprLZd+tv/fqlWuRQzIZj8IS2UIDVf6r
	 2f24QeG6/up3+nFnTpCIqYuYnCTN+9aO1VNLiD18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 026/334] ahci: asm1166: correct count of reported ports
Date: Tue, 27 Feb 2024 14:18:04 +0100
Message-ID: <20240227131631.445326224@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conrad Kostecki <conikost@gentoo.org>

[ Upstream commit 0077a504e1a4468669fd2e011108db49133db56e ]

The ASM1166 SATA host controller always reports wrongly,
that it has 32 ports. But in reality, it only has six ports.

This seems to be a hardware issue, as all tested ASM1166
SATA host controllers reports such high count of ports.

Example output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0xffffff3f impl SATA mode.

By adjusting the port_map, the count is limited to six ports.

New output: ahci 0000:09:00.0: AHCI 0001.0301
32 slots 32 ports 6 Gbps 0x3f impl SATA mode.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=211873
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218346
Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3a5f3255f51b3..762c5d8b7c1a1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -663,6 +663,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
+		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+		hpriv->saved_port_map = 0x3f;
+	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
-- 
2.43.0




