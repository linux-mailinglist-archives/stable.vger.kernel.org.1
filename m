Return-Path: <stable+bounces-112116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E65A26C2E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608C11888972
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4EA200BB4;
	Tue,  4 Feb 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmesWUIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558013212A;
	Tue,  4 Feb 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738650978; cv=none; b=F1ozsssUsrhd0AlWuJwwAzhrIJJo687PV1E0TReEC/mSqL2LU14glzR0SN/yovCc3zFlwpOJZ+ZAjGbyhzoT3Pf4xefcW7MMcJxpqsVVMvWwbmGesCj3d3pgTqCo9MPO9OVkHQu3bAK7QCZkaPA5ZCaf552hHCMzXDyxRVkrLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738650978; c=relaxed/simple;
	bh=AoPZffDxKXgAYnlcQCovRARbXMgktVy5zIEqbFmvgqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6ZGpVWEplh1mx/1y/LH8yidkh3W0YcOU3c3o76OHlb3bIT3DTm6Pa4hm/mpqeBrR7QzIZXPjKa+pB37IdvoPuBYjPC/kiKT0skHSCDApfQjgbLzn6ihSzR0L3zcrtaQmjAekw01j38WXF4VruOu/Cug5UbOTDlJNdsAOU4qs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmesWUIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC5C4CEDF;
	Tue,  4 Feb 2025 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738650978;
	bh=AoPZffDxKXgAYnlcQCovRARbXMgktVy5zIEqbFmvgqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FmesWUIztCVgHs01aJq5nV1qSuwJawTsW6KqDSdGxfhEfhrSDS+f32SAjxB4SA3pz
	 EynFBJLOf6fT+9BHnEKjMmi/DNPNokAjM0EXvTDgDicLkZrSjyBF1YAwyS5ttJAsBP
	 AKs59S9TuYQ8COtxg6DSTYrpKrtcrdaGKDiPDHO9LSuCRFn6nelAswD6mGzF3/mNSd
	 a9CV/naIamDgeaVtS9AKe9a9F6sd1TnQSWVD2LMbKtSMfLfSFjEIdGtEwuk3GywutA
	 HXD13HJ46aHitKCeEW/O4oQlKHYIjvP2f08qDmi5KNJGveTTF+JBenRHTHkQZqmEdZ
	 eaCADCY1zKDlQ==
Message-ID: <48ad8f05-a90b-499d-9e73-8e5ff032824a@kernel.org>
Date: Tue, 4 Feb 2025 07:36:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: gmpy.liaowx@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, stable@vger.kernel.org
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
 <20250204023323.14213-1-jiashengjiangcool@gmail.com>
 <e41d9378-e5e5-478d-bead-aa50a9f79d4d@wanadoo.fr>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <e41d9378-e5e5-478d-bead-aa50a9f79d4d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04. 02. 25, 7:17, Christophe JAILLET wrote:
> Le 04/02/2025 à 03:33, Jiasheng Jiang a écrit :
>> Add a check for kcalloc() to ensure successful allocation.
>> Moreover, add kfree() in the error-handling path to prevent memory leaks.
>>
>> Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
>> Cc: <stable@vger.kernel.org> # v5.10+
>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>> ---
>> Changelog:
>>
>> v1 -> v2:
>>
>> 1. Remove redundant logging.
>> 2. Add kfree() in the error-handling path.
>> ---
>>   drivers/mtd/mtdpstore.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
>> index 7ac8ac901306..2d8e330dd215 100644
>> --- a/drivers/mtd/mtdpstore.c
>> +++ b/drivers/mtd/mtdpstore.c
>> @@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct mtd_info 
>> *mtd)
>>       longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
>>       cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +    if (!cxt->rmmap)
>> +        goto end;
> 
> Nitpick: Could be a direct return.
> 
>> +
>>       cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +    if (!cxt->usedmap)
>> +        goto free_rmmap;
>>       longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>>       cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>> +    if (!cxt->badmap)
>> +        goto free_usedmap;
>>       /* just support dmesg right now */
>>       cxt->dev.flags = PSTORE_FLAGS_DMESG;
>> @@ -435,10 +442,20 @@ static void mtdpstore_notify_add(struct mtd_info 
>> *mtd)
>>       if (ret) {
>>           dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
>>                   mtd->index);
>> -        return;
>> +        goto free_badmap;
>>       }
>>       cxt->mtd = mtd;
>>       dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
>> +    goto end;
> 
> Mater of taste, but I think that having an explicit return here would be 
> clearer that a goto end;

Yes, drop the whole end.

>> +free_badmap:
>> +    kfree(cxt->badmap);
>> +free_usedmap:
>> +    kfree(cxt->usedmap);
>> +free_rmmap:
>> +    kfree(cxt->rmmap);
> 
> I think that in all these paths, you should also have
>      cxt->XXXmap = NULL;
> after the kfree().
> 
> otherwise when mtdpstore_notify_remove() is called, you could have a 
> double free.

Right, and this is already a problem for failing 
register_pstore_device() in _add() -- there is unconditional 
unregister_pstore_device() in _remove(). Should _remove() check cxt->mtd 
first?

thanks,
-- 
js
suse labs


