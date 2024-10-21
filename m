Return-Path: <stable+bounces-87587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E929A6E4D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C45B1C22590
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FB1C4603;
	Mon, 21 Oct 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b="RG14wvzx";
	dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b="a2Y4a2U+"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw3.jing.rocks (mail-gw3.jing.rocks [219.117.250.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90B1C32EC;
	Mon, 21 Oct 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.117.250.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524937; cv=none; b=t5FfLr4lQR6K39vb9z2giCmjMWGxYetPMpbeg3B+knbhtSfES2z0fxeesKff9xBIvIbpDcbS4xnCLB4/J/BxGNwBqfemKPy7RuOPbk4WhFnawsXneYKaL63ZUoFz61oHSH4KnZU3FB6Dy/lSNv86qhuhlLIJ4uAiPUvABQvezrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524937; c=relaxed/simple;
	bh=pJuI/9yq3jhzCnW1lWIwI9WPmcku8REQsfB23Vm5LV8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nJhLsWYNpmDp1D4mIC+VSS7OpUYh10UYBVBnBlAno4+Qw3GOBTPj6Hw9W56/5/3anqyKfCl++xPDzOWsvRAOWdUbqAtFJ7ybOVnQ05zYCg48dHEhOWSjI3wQkMkn2gRyaY42AwKfp5ON1TfoFpZg7ey/Dra/sIDPwJ0Rwj5XBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jing.rocks; spf=pass smtp.mailfrom=jing.rocks; dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b=RG14wvzx; dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b=a2Y4a2U+; arc=none smtp.client-ip=219.117.250.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jing.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jing.rocks
Received: from mail-gw3.jing.rocks (localhost [127.0.0.1])
	by mail-gw3.jing.rocks (Proxmox) with ESMTP id 9BC18347B8;
	Tue, 22 Oct 2024 00:26:18 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jing.rocks; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail-gw; bh=wiskvmF9VvUZk+8tp
	b5dq40Y3ixtn7Em19zbs6VX0J4=; b=RG14wvzxxl8/UKibxzjMT/EE3rjypWJ1R
	Yb3a7/eMsky6e2AG8roWxoTfMl8w+3Q3GBDbBl1yCDdfn5io0YZSTSa36bsY2QNF
	xyy1qOZw7R7aWkPt3Tq0ZMqZY+Mw2jkcKN3AKCAlSusjZECiUfREyFFC/l2etPgN
	ZtGsmaIGsgZClO2g/U4nWSmWtEeMVdAPcmPCJavu6RH5KcN+/zaZl1e1zq/HjxJ5
	8Ut+YFKynUS2BUS15ouUQPpn9U5gt0PqrUzSS/eyBaTvotMGw1RWVuAEK6fkvE9E
	OwtrKmnYLZcdGdDM/byHU+bK1nr2N5Vf+1HSkmHRlMJh9Ar4eaIUw==
Received: from mail.jing.rocks (mail.jing.rocks [192.168.0.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw3.jing.rocks (Proxmox) with ESMTPS id 480033470E;
	Tue, 22 Oct 2024 00:26:16 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jing.rocks;
	s=default; t=1729524376;
	bh=pJuI/9yq3jhzCnW1lWIwI9WPmcku8REQsfB23Vm5LV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2Y4a2U+CPKhrj1/x9hQy7O6k0w5CPzuBQy6ObsJGEvSKzWuHS3ZfrBUHg2tBHMVt
	 TL35WOBoCaFFjW552MulWlmZHGNR9gghhatn0c3CsPX3qtPIXkRKO7MkUmr7D32zcJ
	 WGCCArq6oDjEQsrCB7cSJd8EHdLq9tm0g1/wzRzUCpd7bBe9Cp0hRrmvCAWksiJP2r
	 lSQD5Jqb5lmDblZoeOYh75nHjM/rA3X1hHGB3gMbllnm9WFnCaynkMs04I3b3Yf5ID
	 2EVL/zJ3022NfbAR7rMd2sNQ79/I7egw9qofz0kCqBcQl8X0z9M+mCehiHq99CRoSu
	 x2zmwJAjWSzLw==
Received: from mail.jing.rocks (localhost [127.0.0.1])
	(Authenticated sender: jing@jing.rocks)
	by mail.jing.rocks (Postfix) with ESMTPSA id 1670B39AF0;
	Tue, 22 Oct 2024 00:26:16 +0900 (JST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 00:26:15 +0900
From: Jing Luo <jing@jing.rocks>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ron Economos <re@w6rz.net>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into
 account
In-Reply-To: <20241020142931.138277-1-aurelien@aurel32.net>
References: <20241020142931.138277-1-aurelien@aurel32.net>
Message-ID: <63780c938a9d2b640b3ef8c2c577383b@jing.rocks>
X-Sender: jing@jing.rocks
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-20 23:29, Aurelien Jarno wrote:
> The Synopsys DesignWare mmc controller on the JH7110 SoC
> (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> and thus requires the use of SWIOTLB.
> 
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> "swiotlb buffer is full" to happen because swiotlb can only handle a
> memory size up to 256kB only.
> 
> Fix the issue, by making sure the dw_mmc driver doesn't use segments
> bigger than what SWIOTLB can handle.
> 
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Jing Luo <jing@jing.rocks>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages 
> bigger than 4K")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Feel free to add:

Tested-by: Jing Luo <jing@jing.rocks>

This patch not only fixes the kernel log spam by dwmmc_starfive 
reporting "swiotlb buffer is full", but also seems to have fixed a 
serious bug that causes data corruption on emmc (as I reported to Debian 
[1]), which at least can be observed on both Visionfive 2 and Star64 
boards. To add a cherry on the top, with this patch applied, I see 
massive performance improvement (sequential rw speed) on emmc: with a 
quick-and-dirty test using `dd bs=1M`, on Visionfive 2, it goes from 
28MB/s to 42MB/s (+50%); on Star64, it goes from 13MB/s to 46MB/s 
(+253%).

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1085425

Thanks & cheers,

Jing Luo

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..dc0d6201f7b73 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2958,7 +2958,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>  		mmc->max_segs = host->ring_size;
>  		mmc->max_blk_size = 65535;
>  		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -		mmc->max_seg_size = mmc->max_req_size;
> +		mmc->max_seg_size =
> +		    min_t(size_t, mmc->max_req_size, 
> dma_max_mapping_size(host->dev));
>  		mmc->max_blk_count = mmc->max_req_size / 512;
>  	} else if (host->use_dma == TRANS_MODE_EDMAC) {
>  		mmc->max_segs = 64;


