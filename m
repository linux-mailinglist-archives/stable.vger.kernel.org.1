Return-Path: <stable+bounces-182503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA736BAD9AA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D3B188B5AA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AD2F9D88;
	Tue, 30 Sep 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYnnRGls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FD2236EB;
	Tue, 30 Sep 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245161; cv=none; b=a1Jtc5I/6mzxr5mR5+EcrJydoLK20JhdAPWln1+yrr4ihZdVROUXdpNUr4bskxDuWGek2DjhJbBVmNGeBqLwCRhgMuBvcIHMyxCuKqTQwdQExEaqicla2EGua6bC6t3knMU09DYTQqNCgd+rY9UIQVmzWYjhCANxh4kqE4TXn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245161; c=relaxed/simple;
	bh=WeY0apsem8TIVe/gmmWpl4q0RXBOiyoKirPagEioanc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzePq/iwnRx94ARSemG0zdHZ2U1dxnDCw/TSB3N0N45STFL45tu8ZQ4b81MfvLdIeA/ZP1vWPphyVdG08dGMVFDZKA+rRLIY4yT2yPxbvchizpWwyVGQtAm1FvMnIe+ovwbBjJcmBnHlW8zhriJ3B/rxkbt+UAvAGo9R+cBWJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYnnRGls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439ACC4CEF0;
	Tue, 30 Sep 2025 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245161;
	bh=WeY0apsem8TIVe/gmmWpl4q0RXBOiyoKirPagEioanc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYnnRGls7HpsgWv5FHvlCJ4MhP4Tg+lpN+d3qxVSsaq10U0lsCwlUJbq7Oqpdnsux
	 5+qt4K4A8ae0OADJ+yeFN3P/k7JTgxsoQ6OsdmLKMWi3TOFhN6hAhUyW6b1uetFltv
	 ZY+FKQGpSsEht6ZhgUmB4h39yexDyjrp1k277zYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 082/151] mmc: mvsdio: Fix dma_unmap_sg() nents value
Date: Tue, 30 Sep 2025 16:46:52 +0200
Message-ID: <20250930143830.862443835@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 



