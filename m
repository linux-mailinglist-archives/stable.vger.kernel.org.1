Return-Path: <stable+bounces-112114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85AA26C16
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EED167CAB
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737121FF7B9;
	Tue,  4 Feb 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KNyaa5VZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D925A655;
	Tue,  4 Feb 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649956; cv=none; b=N5A3vMnoJvQNLGmDl3WumpkR+8TlTfmTMqk7JNWp+ywmFwfcABZ66i7yTqTi7FdlrnLLcRNSLhRV4onDmz7FzxULUTCjQoPI7i79Wh3U/285Nzs+nhl94hT6EMhDTErGoylyQ7cQkLE/7oWwe+waZukU1FkGbJT0pz1fVqHMqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649956; c=relaxed/simple;
	bh=qVxz4qhhEqrScUAsJhIjKbHH5wmCbfE7VN3wRR73N34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eup/wZwi/SeYbLnmsq9m0hLGvg/7l3vZKP8wHkbPpNq5c7ndkR7x33Cl3sIWmg88b+qKkfE4fdWROiZ3qYbm6llbj9+E6INM/yObHpWKFLZfwIxLX/NuwfeilDhTcLMLZ8HQKD0quDQ8em8IOkl8Iup7G4VcLGoHzHoAFST9gF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KNyaa5VZ; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id fCFwtHY03MBalfCFztJres; Tue, 04 Feb 2025 07:18:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738649881;
	bh=2rigdcBP5Blbnm80a1gcLyNHTyPctzTAtz4Al0/l+0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KNyaa5VZKs96XELNAwL6YcnuQVGssubBs5PudTymcgJmoHVH6zkCHtJe4PexTDKKH
	 S0mRkXiSHI5Nmtpcnyq88a0dul6gZUTZ6AGuqm624HCxGd0HGCnrAKt7cK25GTPuGT
	 Cf/DW4V2nRwe71lDMW64vPy4BLe4Vd/ZOsXkB4LRe3ffwveFlXT1q8REyb4wa3RIr/
	 fhno6I0wmKBoWv6dJKHI5Z8MI356w2u/ZGHM6hP9phxxeEpfJDuU9R6U4cj4Ilr3X+
	 oWz6aJtA+i6KL4XE1nrPJydfrGx00oGAlpqXKuAwVgVoGsB72IWK5mTc7eWSObccCC
	 hayXja0UbhPUA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 04 Feb 2025 07:18:01 +0100
X-ME-IP: 90.11.132.44
Message-ID: <e41d9378-e5e5-478d-bead-aa50a9f79d4d@wanadoo.fr>
Date: Tue, 4 Feb 2025 07:17:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: gmpy.liaowx@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, stable@vger.kernel.org
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
 <20250204023323.14213-1-jiashengjiangcool@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250204023323.14213-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/02/2025 à 03:33, Jiasheng Jiang a écrit :
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

Nitpick: Could be a direct return.

> +
>   	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->usedmap)
> +		goto free_rmmap;
>   
>   	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>   	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
> +	if (!cxt->badmap)
> +		goto free_usedmap;
>   
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

Mater of taste, but I think that having an explicit return here would be 
clearer that a goto end;

> +
> +free_badmap:
> +	kfree(cxt->badmap);
> +free_usedmap:
> +	kfree(cxt->usedmap);
> +free_rmmap:
> +	kfree(cxt->rmmap);

I think that in all these paths, you should also have
	cxt->XXXmap = NULL;
after the kfree().

otherwise when mtdpstore_notify_remove() is called, you could have a 
double free.

CJ

> +end:
> +	return;
>   }
>   
>   static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,


