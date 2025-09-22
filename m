Return-Path: <stable+bounces-181110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D6B92DB8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1AD1900128
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3E27B320;
	Mon, 22 Sep 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hx/ylMWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC41FDA89;
	Mon, 22 Sep 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569715; cv=none; b=kensqDbSOlcvQw65StOQ+uAzMClW1CXPUlnvjEDPKKqupN4jbjAJFiVbNAJYtFIk/PoWPVcSmuewyXkR+V81z2a3E4vTZabRf+TURwEjMBePDotraZm+jAdMtbAx941js0QHliR0vm/SPgl7gq/jjhigNl5WgEkLWjPAY36Eu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569715; c=relaxed/simple;
	bh=WS/RDRZ98UhB5LmP8pVAhAihfzIgYiGhpJYKZKZn2m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxxfHGm1crQ5mM+Rv7lIOLvkKikyjkorLAgvY31zBXtq4Vnl0LGjBATD+fCk+CVLVt8BH7Lrom06d9HFBD85FajnkLWsN2HgR6vGf9rGrpPUcdBOrBn/UjD1MpdKdW6xS7ZRb445JPcu6W0S6YDP+3qg9Z0kgYIRUcCPc/vFPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hx/ylMWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B09C4CEF0;
	Mon, 22 Sep 2025 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569715;
	bh=WS/RDRZ98UhB5LmP8pVAhAihfzIgYiGhpJYKZKZn2m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hx/ylMWP7ZZT50eSOrro18Fo93JblilU63/WwkaWSJcvADwNaxeaSzc9qOo26FGbR
	 3DrYMujORaM6Ad9kjyrA9OD/aWC8XFzxlcqhy+1TO+zw6p/lEuG0Zr/oFozSPiuciG
	 h3hUNbwJMDHZ5ejX5tpEe2LF8PqgIX95PkbGnJyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 40/70] mmc: mvsdio: Fix dma_unmap_sg() nents value
Date: Mon, 22 Sep 2025 21:29:40 +0200
Message-ID: <20250922192405.692985442@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit 8ab2f1c35669bff7d7ed1bb16bf5cc989b3e2e17 upstream.

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mvsdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -292,7 +292,7 @@ static u32 mvsd_finish_data(struct mvsd_
 		host->pio_ptr = NULL;
 		host->pio_size = 0;
 	} else {
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 	}
 



