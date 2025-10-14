Return-Path: <stable+bounces-185700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFFBDA95A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357603AC7E6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D8F2FF650;
	Tue, 14 Oct 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeKrA7Ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F82C1786
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458449; cv=none; b=e4SnFjzRWt5Eg4I6/YlhRUl1GjKRLzKyb2sYMU/ZD1FGY65hEqTjMuTLOe4v00Vbs9QXH4RIx9K0/cPitakiNwQHP7Lg2WnHeD9cFSomr7FW1WJaYnrmdKOtKa/Xy8ktgX4vsxoOulnZT4Ph8tBSlEKRzs2cRFTv2hvJ28b9ECE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458449; c=relaxed/simple;
	bh=CkhDHhNaiENPitM0Db0e0S9ZviAGmSP4EwmO+HgvXB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjHZNtmHL1PK3ognBCQi0pU4j0CSnr9RQDwzC668JujiLzh5IZXB82mOGc9fxMJ8Y1hKtWROrbgeYPgdY94orKlkbqqTk5LeLVezTP3Hf0UXmKuUh6fSllV/WRx9tEiYkZ0lOP8+GRMeyaHwe/aBFFLKb0IXnBaibp3Wtj9hjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeKrA7Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0740C4CEE7;
	Tue, 14 Oct 2025 16:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760458448;
	bh=CkhDHhNaiENPitM0Db0e0S9ZviAGmSP4EwmO+HgvXB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeKrA7Obo6DeX2d9gc7okcU6X81n7E2r8VPHD+EK4krlW90SVGBPpTRB5szQUs9Td
	 UndPn+Xh8FiazFACLedz8bYnMnoseq15eEJWUCBBfywSNnXOQ7cVpLO+zplmv0iQBf
	 hGy4wyqjOQ73wBZphay5zS3dEFUEM2pQce4g5YbCsoCAetWDXoAaN9ijhPtSQGvbwl
	 gJkIxAM79+qmYwraQLS/WwEEpafHSUaNGR0Ke0m0ri99/QMwW+CDvjcCitvjyXNnyZ
	 D6Gtf/oFiaRAuZzcUINFR0+CP9OyFut/nPP8BnzMtty/4Ur8ag2XttTCjCh2kPyE2O
	 tu+2bcbzizluw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jiang <jiangwang@kylinos.cn>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
Date: Tue, 14 Oct 2025 12:14:05 -0400
Message-ID: <20251014161406.164458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101341-gallon-ungloved-bc19@gregkh>
References: <2025101341-gallon-ungloved-bc19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wang Jiang <jiangwang@kylinos.cn>

[ Upstream commit 9b80bdb10aee04ce7289896e6bdad13e33972636 ]

Remove a surplus return statement from the void function that has been
added in the commit commit 8353813c88ef ("PCI: endpoint: Enable DMA
tests for endpoints with DMA capabilities").

Especially, as an empty return statements at the end of a void functions
serve little purpose.

This fixes the following checkpatch.pl script warning:

  WARNING: void function return statements are not generally useful
  #296: FILE: drivers/pci/endpoint/functions/pci-epf-test.c:296:
  +     return;
  +}

Link: https://lore.kernel.org/r/tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com
Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Stable-dep-of: 85afa9ea122d ("PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index bcf4f2ca82b3f..4ebc49f1a467c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -291,8 +291,6 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 
 	dma_release_channel(epf_test->dma_chan_rx);
 	epf_test->dma_chan_rx = NULL;
-
-	return;
 }
 
 static void pci_epf_test_print_rate(const char *ops, u64 size,
-- 
2.51.0


