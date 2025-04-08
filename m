Return-Path: <stable+bounces-129488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC4A7FFC8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CED1889812
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06E266583;
	Tue,  8 Apr 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gXF7l+8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE8264A76;
	Tue,  8 Apr 2025 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111165; cv=none; b=aWZvOSuVvOkTL7mRATYedSQgMtsgJuGG1OWRzymfD75ZrXUSqBSYJzriQ5p14B10COgM+/m+QSrY0RdldUg7GoISWY2PGEIThRAcvIp4/aQdNDQSUj4QJ8JJk/o0v4B/Wi7p4kQHTqp/gy0wYcvlTMmsNYGhXqACPnr3P1Dp54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111165; c=relaxed/simple;
	bh=vpBDHXmvC4dbspaQwNiLzmpqCkD2E07UzzQExiYv5c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivmXdkZfJBdQxGgo4zG59dceWFjeyW87lGZvldiRDVYLZydNnknJGLEqylBHd2WJDdwJqyp0Lx6SpeKAaxat/GmiMly6BIHG/zDNGkujFolLis0iHWYFIlGnJJaTQLPj85EJoBDqwrrE/hxxONr2oa59GyFXujQjIHTfCoGnDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gXF7l+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9C6C4CEE7;
	Tue,  8 Apr 2025 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111165;
	bh=vpBDHXmvC4dbspaQwNiLzmpqCkD2E07UzzQExiYv5c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2gXF7l+85vE4bBiokN1Y3pKl2t5dijek3DJXPfqHZSYxJr/Lgt9csDeSHTy+XWYJ3
	 Z+V8zt6kc6XF8r7N3Atz8+0skXaF+V3Bd8S0CiegRojXurNrC4tAILQcZgz5TxahEU
	 m4eEH0OWszkI0jotlfLvBwj2Yl9+53fksjH9TJt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 331/731] PCI: xilinx-cpm: Fix IRQ domain leak in error path of probe
Date: Tue,  8 Apr 2025 12:43:48 +0200
Message-ID: <20250408104921.973675781@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

[ Upstream commit 57b0302240741e73fe51f88404b3866e0d2933ad ]

The IRQ domain allocated for the PCIe controller is not freed if
resource_list_first_type() returns NULL, leading to a resource leak.

This fix ensures properly cleaning up the allocated IRQ domain in
the error path.

Fixes: 49e427e6bdd1 ("Merge branch 'pci/host-probe-refactor'")
Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
[kwilczynski: added missing Fixes: tag, refactored to use one of the goto labels]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Link: https://lore.kernel.org/r/20250224155025.782179-2-thippeswamy.havalige@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-cpm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 81e8bfae53d00..dc8ecdbee56c8 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -583,15 +583,17 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 		return err;
 
 	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
-	if (!bus)
-		return -ENODEV;
+	if (!bus) {
+		err = -ENODEV;
+		goto err_free_irq_domains;
+	}
 
 	port->variant = of_device_get_match_data(dev);
 
 	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
-		goto err_parse_dt;
+		goto err_free_irq_domains;
 	}
 
 	xilinx_cpm_pcie_init_port(port);
@@ -615,7 +617,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	xilinx_cpm_free_interrupts(port);
 err_setup_irq:
 	pci_ecam_free(port->cfg);
-err_parse_dt:
+err_free_irq_domains:
 	xilinx_cpm_free_irq_domains(port);
 	return err;
 }
-- 
2.39.5




