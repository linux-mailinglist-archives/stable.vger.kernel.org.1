Return-Path: <stable+bounces-179070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249CB4AB9E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7047BAB7E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8592F0661;
	Tue,  9 Sep 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7hUoAlx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F12472A8
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416921; cv=none; b=DQpWy4Kyj0QNC+Vi+GhgefhsB0bhzyEKjHXE8EOolRS9rAP3EFhhNAIWYl8W9Ok+fVLwxg9Mmp/pT8Fg5NUPROr1Q/J6qQ0ZbFsFVsElc1kf9hJ7QeZmtT6vuwSDrXPxuu9JPpZ8WKCr02cLWVr7UQqqHMlZa1L4/le16Z2zfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416921; c=relaxed/simple;
	bh=uLKgh/YTOEG7lRDETZIjV9MdddGsqfjptEVnUVoo7HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4Gk5MU3RdxuUJ+JB8IL2A8ML6ZZLfeI/EEbbumVouVtsW0Sf9k3zco0VKxD02PJPgAET+aZgxpypykz6maP4HbvONaPDGIiwMJGKCTao/VeWaFivgEVJxoo8LQERfxc5Z5LyM6PPnRY4PrfLXnKbvew4mZMcYtPdkSdgWxcPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7hUoAlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED62C4CEF4;
	Tue,  9 Sep 2025 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757416920;
	bh=uLKgh/YTOEG7lRDETZIjV9MdddGsqfjptEVnUVoo7HA=;
	h=From:To:Cc:Subject:Date:From;
	b=T7hUoAlxbo7MUfZQYudnsB+f6wi6/pWj8K9MLJXg4Kb9+F7DnOVtTQg3dOBhqAVVh
	 zzgaMsvWBfxcLkY0/uixL+4jpX1hTR/OeaK4xAkcYSF/a0g2ANVzLEozqTt4Y4yJ0/
	 1Rx5hVIdD40Eaf3uk6CimQ+KQuDRPkRmSi1Xt2u4102VBbxGu9gyjsgAbQSmRRCRg2
	 hQjoKsaLcwmnSEDZlpsHI9VYj6NPueE4ac5jpWPKkEbNiVhxk5WN4UMzGsM7y2e1uI
	 hYwthxe5jHXq9UjvYlrfsg8bCXYtTffM2FH6EChAd0UXM6C2JfyL6TMIWYttOXxjhK
	 uLcnECUE8A2Lw==
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init callback
Date: Tue,  9 Sep 2025 13:21:22 +0200
Message-ID: <20250909112121.682086-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=cassel@kernel.org; h=from:subject; bh=pX/MpTonHapCoD9Ys3C3UTZE9fwAxfHE3GCmLlJrJrU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIO8G5cyxlyMGeK0IJdny9WnuiaL1LzJXUdp+k9G2HPO fVr5y0L6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEykMYGc63ynDnz1/60Ceo VIVn0qsLLQYFFQdUq3zv/t/yS7Haxovhf/ap+2d80kT4Tc5PfpqomtxsynPlkOCjzL3MGaXTZq9 mZQEA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

For DMA initialization to work across all EPC drivers, the DMA
initialization has to be done in the .init() callback.

This is because not all EPC drivers will have a refclock (which is often
needed to access registers of a DMA controller embedded in a PCIe
controller) at the time the .bind() callback is called.

However, all EPC drivers are guaranteed to have a refclock by the time
the .init() callback is called.

Thus, move the DMA initialization to the .init() callback.

This change was already done for other EPF drivers in
commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
initialization to EPC init callback").

Cc: stable@vger.kernel.org
Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2e78397a7373a..9c5b0f78ce8df 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2325,6 +2325,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 		return ret;
 	}
 
+	nvmet_pci_epf_init_dma(nvme_epf);
+
 	/* Set device ID, class, etc. */
 	epf->header->vendorid = ctrl->tctrl->subsys->vendor_id;
 	epf->header->subsys_vendor_id = ctrl->tctrl->subsys->subsys_vendor_id;
@@ -2422,8 +2424,6 @@ static int nvmet_pci_epf_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	nvmet_pci_epf_init_dma(nvme_epf);
-
 	return 0;
 }
 
-- 
2.51.0


