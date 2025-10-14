Return-Path: <stable+bounces-185696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359FBDA887
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38997356640
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32F93002C2;
	Tue, 14 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrrsVsRK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17592C0286
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457537; cv=none; b=pq6kKB7wkhJ3ECf2zskDGDN7kZw8L0EEsIhM6J8+liGBV5V5hDcoTrBLl5KAhGTfsBWKmY2ZsKL5uiAi2L7Tz6GhRbNuHSPBNCP9a30MCfNDqpPV1OLoUVKqjf3wGvXsooEopbp7+9Bpw0w4LwDkIFvf9HErM/bMl/W8AuV9JaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457537; c=relaxed/simple;
	bh=C3V1Kh+/+J/sH/6M79C8cOSah21U4xWJSkucv23Sr74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INEXrTxO0I3f5Y2bE2cy37V67x4tbq2L4Q0PphskO0oIGzkhKTSD2F/u4wJ9iS3dJN2TAD9F9T51nHvuaFbMeozyPteHf/gHE3G2zywoqn0iz6KSkTHlJ7jVP4Z5bgoWu+6Rz+uu6LixieQdE4mKecqnuvWaOzEWCrsL7jUTA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrrsVsRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86C6C4CEE7;
	Tue, 14 Oct 2025 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760457537;
	bh=C3V1Kh+/+J/sH/6M79C8cOSah21U4xWJSkucv23Sr74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrrsVsRKewZcM8mFkVV2Tuuru39wF2CkfinrPSV/kxgiZZVyuETT1vMSx5sLTwNMN
	 ZgCWiiH/Myo1oW+AtYhMdEbC7JHYB3fC7zjUUXUZvAqgamYF/FqGkV3zT18rhp+iy0
	 gwQom2nWTagAD1uuvEe6sNSs0oX6Cb5nXEo50r/kjEjjyE3Kc3ungWwdzjzhSUNGUM
	 xSUtVDMCFdG/gEo5FYMmW78ZxkyyXLBzTlgaf8HFUDvdWI26Vz3Ia2IGUCSI7CFxfS
	 17PVM66xUUqLh6dMCuL3cR4DAUIpbjwfFARYbGzm6GiIBHCLQFD98f8HYa+SIdVrcX
	 LmfDR9Vs/a2Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Jiang <jiangwang@kylinos.cn>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()
Date: Tue, 14 Oct 2025 11:58:53 -0400
Message-ID: <20251014155854.154310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101340-marbled-uneven-a896@gregkh>
References: <2025101340-marbled-uneven-a896@gregkh>
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
index 21aa3709e2577..0a7646a8b104f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -291,8 +291,6 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
 
 	dma_release_channel(epf_test->dma_chan_rx);
 	epf_test->dma_chan_rx = NULL;
-
-	return;
 }
 
 static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
-- 
2.51.0


