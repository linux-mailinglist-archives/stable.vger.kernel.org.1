Return-Path: <stable+bounces-112115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4412DA26C26
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B519916803E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACB20010B;
	Tue,  4 Feb 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6zskoaO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D04913B29B;
	Tue,  4 Feb 2025 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650727; cv=none; b=FA7/g05wQ6HTm4r4Q/kpWw6uYRn2gbdZ9DlG9SNcZspwof/nwym0iV1a09p19EG5dzvs1lk1e/TSCp4JiZaIPVv7hrnerHoO+an/ZquIouXSZJ3QYRsRcnBemHVts+lMR+op40rJVpTKPt9pl72iQIg6cdu5kOq2f8U8NBlaas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650727; c=relaxed/simple;
	bh=0tIXBDruVfmh73EZENZUCflgMLVdRl0gwnOofOd2CuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGhGDYwFWT/6ITprKAiMbTCdKaKEMZjb3/scBabBAD6QqrKdmlEtUcLLWe+87eTaLVwH8j0P4YRml1+Wija5JKta3AblmlNZGT1zxxhKqLpaNScSCJxdy58Y4AZMwm7SpkuqF7bCDd+pMf3ErjorM4oGAniU+P1Gjp/z1WFlxio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6zskoaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8344C4CEDF;
	Tue,  4 Feb 2025 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738650726;
	bh=0tIXBDruVfmh73EZENZUCflgMLVdRl0gwnOofOd2CuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e6zskoaO9xYfDgISpyEpntGf1/iqH7gsOmqupnPzI8tKSO8JUJCTkjnpcgyLKgBJv
	 2lXx1cEAQ5jA3jsLOQBAXWFS7jfyk0DNJ2QtKvjlBYjfn3W88EqssRLkjBm3T5fvmb
	 cmtabgn0TegOuW2RPNZhSp3OinRuFl8R4N4ZFnjllVM+9oPbmDB45daktrVibKI0XH
	 m6/g2e7ZhuJLfNh+K1xgcoUieEOaCyavxyplSVw7j83dDoj4cDst79DlK/dtv+K3JH
	 Ig3WjBaMUZuPDuBbh+7Md1HpE/zeYs5SMlveUCrJjMFA4Yhuvw8PTgEb/VWt/XYvKS
	 Vg17KVxQXwikA==
Message-ID: <73a5e3f3-3a39-4ca5-87a0-5f67c25281f0@kernel.org>
Date: Tue, 4 Feb 2025 07:32:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
 christophe.jaillet@wanadoo.fr
Cc: gmpy.liaowx@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, stable@vger.kernel.org
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
 <20250204023323.14213-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250204023323.14213-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 02. 25, 3:33, Jiasheng Jiang wrote:
> Add a check for kcalloc() to ensure successful allocation.
> Moreover, add kfree() in the error-handling path to prevent memory leaks.
> 
> Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
> Cc: <stable@vger.kernel.org> # v5.10+
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Remove redundant logging.
> 2. Add kfree() in the error-handling path.
> ---
>   drivers/mtd/mtdpstore.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
> index 7ac8ac901306..2d8e330dd215 100644
> --- a/drivers/mtd/mtdpstore.c
> +++ b/drivers/mtd/mtdpstore.c
> @@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
>   
>   	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
>   	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->rmmap)
> +		goto end;
> +
>   	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->usedmap)
> +		goto free_rmmap;
>   
>   	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>   	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->badmap)
> +		goto free_usedmap;

Could you add a single 'if' for all of them here instead? And goto 
single free.

>   	/* just support dmesg right now */
>   	cxt->dev.flags = PSTORE_FLAGS_DMESG;
> @@ -435,10 +442,20 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
>   	if (ret) {
>   		dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
>   				mtd->index);
> -		return;
> +		goto free_badmap;
>   	}
>   	cxt->mtd = mtd;
>   	dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
> +	goto end;
> +

And:

free:
> +	kfree(cxt->badmap);
> +	kfree(cxt->usedmap);
> +	kfree(cxt->rmmap);

And NULL them as Christophe suggests.

>   }
>   
>   static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,

-- 
js
suse labs


