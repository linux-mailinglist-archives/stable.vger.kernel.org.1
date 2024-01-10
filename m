Return-Path: <stable+bounces-10424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B820C829495
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 09:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B1C1F27551
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762C3A27E;
	Wed, 10 Jan 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGAyWX1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0E3E460
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 08:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70AFC433C7;
	Wed, 10 Jan 2024 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704873615;
	bh=dNxjZ7SgBHuhIFhL2vwCPfnm5n975bEbk4Db+Bp049I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGAyWX1UJzqRugISwMAv2zfTo9g9OxczCS5ejrRksO5ibSRI+DWRGZg7AFaka0n01
	 lSFSvJhpgfJMDGfQ6FCi6x0tjgNSNkVfyRAFan9V29vbYfCOLjwsGU5mQ6wzd/BNTe
	 7OiIQYf6AGTH2RfLwoubeODsIbJ4IWrn1l95mm6c=
Date: Wed, 10 Jan 2024 09:00:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: stable@vger.kernel.org, miquel.raynal@bootlin.com,
	jaimeliao@mxic.com.tw
Subject: Re: [PATCH] mtd: spinand: macronix: Correct faulty page size of
 MX35LF4GE4AD
Message-ID: <2024011001-luridness-snowcap-b5c5@gregkh>
References: <20240110025428.158812-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110025428.158812-1-jaimeliao.tw@gmail.com>

On Wed, Jan 10, 2024 at 10:54:28AM +0800, Jaime Liao wrote:
> From: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> Correct page size of MX35LF4GE4AD to 4096.
> 
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index bbb1d68bce4a..f18c6cfe8ff5 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -125,7 +125,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
>  	SPINAND_INFO("MX35LF4GE4AD", 0x37,
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

