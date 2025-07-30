Return-Path: <stable+bounces-165484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E0B15DAF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809A718C4FE6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A79280033;
	Wed, 30 Jul 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmLF2lvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406952641F9;
	Wed, 30 Jul 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869325; cv=none; b=gHh0Bh5XR4Tgth8/O5I8OPEq6GkHFFiFzhVyJH6Akx5cV4LONxtNKhy4+doTerMmkZxtP/L9yGeC8o+9ioMtktOJxigOjuFuwrpGP+DnfrDey+FZUlSDYCk3I6hSzDntmtcQ/nhjT5G8QmtBF8zpA47gtoGGYTHbpnJgcaM7uK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869325; c=relaxed/simple;
	bh=NYjpiEnzvzh2g6Pc11Xr1y8Gfq6C5x0npjNdyWMLUlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC1vcKWQLAMmfyLm4Q0CzID2PKQd6lsO7MrkQJNylLrTxfJc+XZjPrZFIa4iHrqaMSwkrqsIR0gRa4B/kxlV1ZZJRwA65NGWk09CHaZPe33oQShZ/mMb6FZ599fp+dKJt4zL+0Z+C+3NtwirZrWWbVwpTCsJ+CLBSuCB7KAn54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmLF2lvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABBAC4CEF5;
	Wed, 30 Jul 2025 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753869325;
	bh=NYjpiEnzvzh2g6Pc11Xr1y8Gfq6C5x0npjNdyWMLUlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmLF2lvA2IvtedOX93cYvsUrmqPFG40pMtVnL8J6ySokQ6B34Z5sUTmewiaW5Ap58
	 CHSC9ySNXnkA16LUypGNhjy+sJ+jMt/useBw7/TGwrILIRlHeH5oz8sTDmCU+7vHf4
	 FN7piQAjQ5ONz9Y2M+S2SfWC0mLqNApXfWzV0q04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.15 90/92] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
Date: Wed, 30 Jul 2025 11:36:38 +0200
Message-ID: <20250730093234.216392179@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
References: <20250730093230.629234025@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

commit 04a8ff1bc3514808481ddebd454342ad902a3f60 upstream.

Remove incorrect checks on cqspi->rx_chan that cause driver breakage
during failure cleanup. Ensure proper resource freeing on the success
path when operating in cqspi->use_direct_mode, preventing leaks and
improving stability.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence-quadspi.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1960,11 +1960,6 @@ static int cqspi_probe(struct platform_d
 
 	pm_runtime_enable(dev);
 
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_get_noresume(dev);



