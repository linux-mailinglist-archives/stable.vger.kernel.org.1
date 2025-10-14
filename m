Return-Path: <stable+bounces-185701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39596BDA95D
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB58B4E17FE
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F82BE652;
	Tue, 14 Oct 2025 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5m1c65+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370C2C1786
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458450; cv=none; b=koTwwKln/HIBVnT6V3EjoEwoQcC6HVNmJ2SvhIBXGkMGofUbOxUDyD7g1O7JIfYwfHF8PQr/tuUOpPhFzFJzyWE+vxrNE6GPBN8V4j7GAd2+8ffNviqb/fcxJeet4hfjqzw4K/w6xE3IXu8h2PiBPRwFgWylegh0CWf7EnK4htY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458450; c=relaxed/simple;
	bh=cDh8bj6mUIBnACIEadYB8LhNilZbE6NGoxmD3qyDHa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDKVuwfcLla0Rw9Ym8JfZdgbCZTQqtpb3tIdUMeRUIneMthQLLNwa3FR0a8WhxOYEOxTaAdcbSrkIz8RWbREhRMwJDvfFr4Aqv5yaOd2yndah/R/uVwmvdwmnOxIeBRPz1S3S9Y5F2GXO1eJ/bUJVGRiWKf+2FYDJbq9c/vWq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5m1c65+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48EAC4CEF9;
	Tue, 14 Oct 2025 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458449;
	bh=cDh8bj6mUIBnACIEadYB8LhNilZbE6NGoxmD3qyDHa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5m1c65+Akh8LzQHfNcWnD9kSbK83pK8XLMYOPr8jwkMwEwdOzrk/gyu4HnIiADTB
	 1gCAIguHz0k5rSawXkR9plj25E/H2ez8L17dMpYQy/V4feN8HFZUGRuLX4pDJ3kpKH
	 lMLVb4KFYkfE5Ad48GZ+LZ7DLMtiaH5bok/61a2A57RBxifdMKJa77RIPnRyEgfv1q
	 pyfduxa1o8uI3FMxbA205kyJuZl7cp61I2KJA+K+r0gP3/pwqJc4eOMn1eKnKOWNDz
	 Bzu65txvzHFiEcT91qYxO9iARWrD9WpG1RVOtKKnqaPdMILEBuZopESoYqOJRGgscq
	 jynT9qVULoGoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release
Date: Tue, 14 Oct 2025 12:14:06 -0400
Message-ID: <20251014161406.164458-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014161406.164458-1-sashal@kernel.org>
References: <2025101341-gallon-ungloved-bc19@gregkh>
 <20251014161406.164458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 85afa9ea122dd9d4a2ead104a951d318975dcd25 ]

The fields dma_chan_tx and dma_chan_rx of the struct pci_epf_test can be
NULL even after EPF initialization. Then it is prudent to check that
they have non-NULL values before releasing the channels. Add the checks
in pci_epf_test_clean_dma_chan().

Without the checks, NULL pointer dereferences happen and they can lead
to a kernel panic in some cases:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
  Call trace:
   dma_release_channel+0x2c/0x120 (P)
   pci_epf_test_epc_deinit+0x94/0xc0 [pci_epf_test]
   pci_epc_deinit_notify+0x74/0xc0
   tegra_pcie_ep_pex_rst_irq+0x250/0x5d8
   irq_thread_fn+0x34/0xb8
   irq_thread+0x18c/0x2e8
   kthread+0x14c/0x210
   ret_from_fork+0x10/0x20

Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Fixes: 5ebf3fc59bd2 ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
[mani: trimmed the stack trace]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250916025756.34807-1-shinichiro.kawasaki@wdc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4ebc49f1a467c..3fe2187cdd0ba 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -282,15 +282,20 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 	if (!epf_test->dma_supported)
 		return;
 
-	dma_release_channel(epf_test->dma_chan_tx);
-	if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+	if (epf_test->dma_chan_tx) {
+		dma_release_channel(epf_test->dma_chan_tx);
+		if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
+			epf_test->dma_chan_tx = NULL;
+			epf_test->dma_chan_rx = NULL;
+			return;
+		}
 		epf_test->dma_chan_tx = NULL;
-		epf_test->dma_chan_rx = NULL;
-		return;
 	}
 
-	dma_release_channel(epf_test->dma_chan_rx);
-	epf_test->dma_chan_rx = NULL;
+	if (epf_test->dma_chan_rx) {
+		dma_release_channel(epf_test->dma_chan_rx);
+		epf_test->dma_chan_rx = NULL;
+	}
 }
 
 static void pci_epf_test_print_rate(const char *ops, u64 size,
-- 
2.51.0


