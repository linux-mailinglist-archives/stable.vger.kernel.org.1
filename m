Return-Path: <stable+bounces-112247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9746A27CEE
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DA0166202
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D08219E99;
	Tue,  4 Feb 2025 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Qe4uvLXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3E19E83E;
	Tue,  4 Feb 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702261; cv=none; b=aQ4S78/9D8KZlWQNPLHYdfy9WMx97JSbj4rnBaRgogMiB/CTY9mriWgE1+Q4n6zsQjMTmkLcrzyoHiPtQWbf4GQyAReFcvokz0h7Gl7BMtEi/06Js7iUeHAA3wXiM22SzCzuUo/JPtqewJp2MWJccVXD1gKVAsqLRWaOt6WAj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702261; c=relaxed/simple;
	bh=U5vN9NaJf/Hh/3ZK/M/vl+ih1hJO4g9FzWxhvyjuyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIhdPdbdsv83l82MAWkuelAqzig/b7pHKqGP/65kmc5RyDoZf23CEmxGvBJD9jeMWB/qT1/2YP/YlSacJS9JGoGDVuUydpOax86avf+VB9k/A5r4AxdQj9ykYtMSv+vT2FXIzsNamgiFFgTjZXEucQWXVlyHpOY8RJtBQfeMR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Qe4uvLXe; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id fPsbtpZU4inFifPsfthBqw; Tue, 04 Feb 2025 21:50:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738702250;
	bh=cEJrjrt2iVAFpYW/0YZX/gP7F3sDEkngN20jzc4pxzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Qe4uvLXe/cappcqsmC5mjcdHulH1WxgPsw5mlTZSD/zfbLsys0bzGC++t2M1c7mDx
	 LuDFpqT1XZnALmaGfAeYLbc2W54DayF/x9SCy/yzHI/Tlos79eHLIUmM/JmVehzjrF
	 JTex7vKvjBN9TvgRfp82uRVoZdb55iBZwJM80cxZFpVJsQ5+99oBYcN/yEqmvROpit
	 bE0CrkRZ8EQtwAq8rirHrkrwnM0VvUMkItuSoJXCBx95vb2xFAfqO/+Mi/F80lLpcu
	 SNTY7s5s3E5MG9booYpPPLSKEPy8Jcli/GoVhIDmoygRhbTw4Zweg+6LLeHp4f1u4D
	 XplwbKpPx2H4w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 04 Feb 2025 21:50:50 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
Date: Tue, 4 Feb 2025 21:50:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: Add check and kfree() for kcalloc()
To: Jiri Slaby <jirislaby@kernel.org>,
 Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: gmpy.liaowx@gmail.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, stable@vger.kernel.org
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
 <20250204023323.14213-1-jiashengjiangcool@gmail.com>
 <e41d9378-e5e5-478d-bead-aa50a9f79d4d@wanadoo.fr>
 <48ad8f05-a90b-499d-9e73-8e5ff032824a@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <48ad8f05-a90b-499d-9e73-8e5ff032824a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/02/2025 à 07:36, Jiri Slaby a écrit :
> On 04. 02. 25, 7:17, Christophe JAILLET wrote:
>> Le 04/02/2025 à 03:33, Jiasheng Jiang a écrit :
>>> Add a check for kcalloc() to ensure successful allocation.
>>> Moreover, add kfree() in the error-handling path to prevent memory 
>>> leaks.
>>>
>>> Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
>>> Cc: <stable@vger.kernel.org> # v5.10+
>>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>> ---
>>> Changelog:
>>>
>>> v1 -> v2:
>>>
>>> 1. Remove redundant logging.
>>> 2. Add kfree() in the error-handling path.
>>> ---
>>>   drivers/mtd/mtdpstore.c | 19 ++++++++++++++++++-
>>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
>>> index 7ac8ac901306..2d8e330dd215 100644
>>> --- a/drivers/mtd/mtdpstore.c
>>> +++ b/drivers/mtd/mtdpstore.c
>>> @@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct 
>>> mtd_info *mtd)
>>>       longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
>>>       cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>> +    if (!cxt->rmmap)
>>> +        goto end;
>>
>> Nitpick: Could be a direct return.
>>
>>> +
>>>       cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>> +    if (!cxt->usedmap)
>>> +        goto free_rmmap;
>>>       longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>>>       cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>>> +    if (!cxt->badmap)
>>> +        goto free_usedmap;
>>>       /* just support dmesg right now */
>>>       cxt->dev.flags = PSTORE_FLAGS_DMESG;
>>> @@ -435,10 +442,20 @@ static void mtdpstore_notify_add(struct 
>>> mtd_info *mtd)
>>>       if (ret) {
>>>           dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
>>>                   mtd->index);
>>> -        return;
>>> +        goto free_badmap;
>>>       }
>>>       cxt->mtd = mtd;
>>>       dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
>>> +    goto end;
>>
>> Mater of taste, but I think that having an explicit return here would 
>> be clearer that a goto end;
> 
> Yes, drop the whole end.
> 
>>> +free_badmap:
>>> +    kfree(cxt->badmap);
>>> +free_usedmap:
>>> +    kfree(cxt->usedmap);
>>> +free_rmmap:
>>> +    kfree(cxt->rmmap);
>>
>> I think that in all these paths, you should also have
>>      cxt->XXXmap = NULL;
>> after the kfree().
>>
>> otherwise when mtdpstore_notify_remove() is called, you could have a 
>> double free.
> 
> Right, and this is already a problem for failing 
> register_pstore_device() in _add() -- there is unconditional 
> unregister_pstore_device() in _remove(). Should _remove() check cxt->mtd 
> first?

Not sure it is needed.
IIUC, [1] would not match in this case, because [2] would not have been 
executed. Agreed?

CJ


[1]: https://elixir.bootlin.com/linux/v6.13/source/fs/pstore/blk.c#L169
[2]: https://elixir.bootlin.com/linux/v6.13/source/fs/pstore/blk.c#L141

> 
> thanks,


