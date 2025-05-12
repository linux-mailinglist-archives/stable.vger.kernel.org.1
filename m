Return-Path: <stable+bounces-144057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E33FEAB46C8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004731B4095A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31229992B;
	Mon, 12 May 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPcu1n6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED17299A86
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086764; cv=none; b=NkXbT589T+h9rSK220KH1iTzvaCHifOuuvScJXMreKb2Ew0yorhayDG8cuekkmy+/otDMXkgz+OCZZhoSiMMiIPrDNX7WXZMKXDXvgDV6MQBtwDSHtgQpeHiCyGfybFz8NmF56SxuGR3iWRpPeZD1a2wPU45dfZJlTU5/M0cFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086764; c=relaxed/simple;
	bh=x0r7F45Fpu2/IKG0NJx/6wMKAGU6lwmLVsqy5iqe/zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzD870g6KN8q3oG4cJmO85lpUeviG0Fp66AeHGgkMcdsO1xlZWSKSFS8YA7uXIjcWO6ouejoE8jw/YmFgVC/c72USMBkQjmG71b6ZfDwHLy443l/4v7emoAPwQMvjfpZ5KuXsDnt2RrsBqX2/YF4qLbLhkBowHEzn6MnFkJAf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPcu1n6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BFBC4CEE7;
	Mon, 12 May 2025 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086763;
	bh=x0r7F45Fpu2/IKG0NJx/6wMKAGU6lwmLVsqy5iqe/zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPcu1n6+FSsclwGSDw7wgev5q0ETRJHIv1RNgcdLwbfT+UUmjA7xs3PfZ/c27WYP8
	 wg+5ZmhLG933Voy64NFuEfD45DaZndPJJD1GtkzVXHuCKZyoi8sTGxVeL/4dpyUsZ5
	 mhpxTrPwi0V4JPBEplcAulXWoJ2Wwo/0O3PixTGZMCyLFztqmEGI9qyQY9kVTrndq7
	 qY/cIhqeaZr9ldVVfdtdTk4sOEXxQLFSNHWl411VkoCO7H3GcPgIWxedbSYiup0kJt
	 TJN09WEL0uQ4J0rovinZDuHKoT2sNYtSnWQapngYCz/O8jLK+VXXaAVbWek6rDeG3o
	 0IwVy91Su9bAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
Date: Mon, 12 May 2025 17:52:40 -0400
Message-Id: <20250512163207-282f1e7f1aec7163@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512015227.3326695-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 9cf71eb0faef4bff01df4264841b8465382d7927

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Steve Wilkins<steve.wilkins@raymarine.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3feda3677e8b)

Note: The patch differs from the upstream commit:
---
1:  9cf71eb0faef4 ! 1:  e2b7a4dc57e1d spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
    @@ Metadata
      ## Commit message ##
         spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
     
    +    [ Upstream commit 9cf71eb0faef4bff01df4264841b8465382d7927 ]
    +
         While transmitting with rx_len == 0, the RX FIFO is not going to be
         emptied in the interrupt handler. A subsequent transfer could then
         read crap from the previous transfer out of the RX FIFO into the
    @@ Commit message
         Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
         Link: https://patch.msgid.link/20240715-flammable-provoke-459226d08e70@wendy
         Signed-off-by: Mark Brown <broonie@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/spi/spi-microchip-core.c ##
     @@
    @@ drivers/spi/spi-microchip-core.c: static int mchp_corespi_transfer_one(struct sp
      
     +	mchp_corespi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_TXFIFORST);
     +
    - 	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
    - 
      	while (spi->tx_len)
    + 		mchp_corespi_write_fifo(spi);
    + 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

