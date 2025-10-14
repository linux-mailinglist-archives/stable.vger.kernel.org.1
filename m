Return-Path: <stable+bounces-185699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604EBDA8EB
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CAB3B1939
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BEE3009FA;
	Tue, 14 Oct 2025 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8icaYPx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8C3002C8
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457989; cv=none; b=hAZ34o5QjeZGVHszuOZz5ebBGLSTutHWDUMvQU144JJ/uEeGXuuJzRdQSCTbGGyycBaXvTqasIv10kb2X80mVm0akQHl1v/Oo+qLrRZ0UrEyDKswHBksJblZdJ0YBTfzWW3PjAmD35aQFF6vkVAkypQ6RvZyoDLZGQTy+osRLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457989; c=relaxed/simple;
	bh=9tc4qlNTzRhbMSM8TPIEF2fZZ2R73vXPhd7B1Dg7PkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRQytNoB5lWY1Q0alR6PfSS3TaEc38hAAzt/mK48TfJkP3bu9ljApekMZ9foceQbDlCkUR2bnQuLgdJQ3TgejvUVXDWQI2Kx0ytYH/I9h3Tni2FEJ7Gzmakcs7539x0SgI4orzO/rQHz2yEoJVcS5DrfSS4Qs1zDdYLorVsIBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8icaYPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12A3C113D0;
	Tue, 14 Oct 2025 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760457987;
	bh=9tc4qlNTzRhbMSM8TPIEF2fZZ2R73vXPhd7B1Dg7PkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8icaYPxYz++t5v1lbUp51ApTh7tflz8AbkTbFCv3YVhNuR9hViZfJJHPxGCQ85OT
	 U4Ni1OgkCM8fuwYYIYoBdpE7cuagh+XOqLUSrld6J7DplkP9fuVpNQQIcVkW2PhCME
	 4aWJPtnq6ouJK396Du+0OATzniow6rWA7ht9LXwk+oVRrATff9BjDFcBFCvLrt9llw
	 9/utjsLDo4SEqhwcBKcPkMCOA8ifGiLYNct3r3Asg3OAOZ0R0fsscJEmi3G6MeFLbF
	 l0jUjg9THdGNUql0kgSrpMIWAJo1DMMqYgHZK89BL8gND4hBzlPSTUOscGp5ctisk0
	 b6Tj2l1ncZrSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release
Date: Tue, 14 Oct 2025 12:06:18 -0400
Message-ID: <20251014160618.158328-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014160618.158328-1-sashal@kernel.org>
References: <2025101340-passably-rounding-59df@gregkh>
 <20251014160618.158328-1-sashal@kernel.org>
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
index ff4ca6ea5cb8e..4cf20ca25ea74 100644
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
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.51.0


