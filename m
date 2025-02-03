Return-Path: <stable+bounces-112037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0FA25EDF
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AA63A9EC7
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0C2080E6;
	Mon,  3 Feb 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AopHi5Ak"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF920433A4
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596798; cv=none; b=A/IzMV8NunfFMYudWWCoynkwqSVKX9GAoF2gpUtNbG/D79WLa3P80q69lFBlhtnqk93c6+6QVnelBmBsgCXIau3TBfiG1hB6mS63r/saURqJPvH6TWZP04t7/udJGzKCRHjvkvuBYJ+3QjNWmosAGiWx2fyVibBl+UIe7+wt/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596798; c=relaxed/simple;
	bh=1wk7VQ/UfvndU+hVk2NOLBV3egwP6bVh8LnWFhTLgEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVfBjn6IrIUnLl7hgzo1O49ocwBInDdX8BlbVe7dhwLazNRo9QZPawrL9bDcu2/97VvwGnLo08N0zxVgGT/JjkQ2MuukyStdcMX1GfdVSGceuv2vlzF5LFKe0Kw01a5SrLcEl7TUH0Z4yTmEn+jjoaYfAhjtUDBdd2G2Q/uZ+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AopHi5Ak; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b0dba75c-e26d-40eb-8d1e-b6bbd00884f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738596780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9Soud69r86LZMQrHNANoqb5glSogcgwSct8l59C6GQ=;
	b=AopHi5Akm/j+5jPwsaRhyv/poqwM6tYwzS3yV9XGQ5Gg+JW4NGfxteHyG098MiUhRuoP92
	WGbd3lSKvj+x/xASb84i163GB1GX0mOjjVDk5dm6zJz0mogBQ61h41nLDdkkw2culgQJDz
	mALX8U3NHMKAd0czWtfEQgV0fO/elKc=
Date: Mon, 3 Feb 2025 23:32:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "drm/etnaviv: Drop the offset in page manipulation" has
 been added to the 6.12-stable tree
To: Lucas Stach <l.stach@pengutronix.de>, stable@vger.kernel.org,
 stable-commits@vger.kernel.org
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250202043355.1913248-1-sashal@kernel.org>
 <d8b6c3b4eda513277f19640c8f792c6d70b03f06.camel@pengutronix.de>
 <2dfb1991-3030-4143-890b-83508d1b77e0@linux.dev>
 <ece27be6f18b700140eb338c018e291efd19f271.camel@pengutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ece27be6f18b700140eb338c018e291efd19f271.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2025/2/3 19:14, Lucas Stach wrote:
> Hi Sui,
>
> Am Montag, dem 03.02.2025 um 18:53 +0800 schrieb Sui Jingfeng:
>> Hi,
>>
>> On 2025/2/3 16:59, Lucas Stach wrote:
>>> Hi Sasha,
>>>
>>> Am Samstag, dem 01.02.2025 um 23:33 -0500 schrieb Sasha Levin:
>>>> This is a note to let you know that I've just added the patch titled
>>>>
>>>>       drm/etnaviv: Drop the offset in page manipulation
>>>>
>>>> to the 6.12-stable tree which can be found at:
>>>>       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>>
>>>> The filename of the patch is:
>>>>        drm-etnaviv-drop-the-offset-in-page-manipulation.patch
>>>> and it can be found in the queue-6.12 subdirectory.
>>>>
>>>> If you, or anyone else, feels it should not be added to the stable tree,
>>>> please let <stable@vger.kernel.org> know about it.
>>>>
>>> please drop this patch and all its dependencies from all stable queues.
>>>
>>> While the code makes certain assumptions that are corrected in this
>>> patch, those assumptions are always true in all use-cases today.
>> Those patches are harmless even we apply them, and after apply my pitch,
>> it requires less CPU computation, right?
>>
>>
>>> I don't see a reason
>> I think, if 'sg->offset != 0' could happen  or not is really matters here.
>> My argument was that the real data is stored at 'sg_dma_address(sg)', NOT
>> the 'sg_dma_address(sg) - sg->offset'.
>>
>>
>> As we can create a test that we store some kind of data at the middle of
>> a BO by the CPU, then map this BO with the MMU and ask the GPU fetch the
>> data.  Do we really have a way tell the GPU to skip the leading garbage
>> data?
>>
>>
>>> to introduce this kind of churn to the stable trees
>>
>> If I'm wrong or miss something, we can get them back, possibly with new
>> features, additional description, and comments for use-cases. My argument
>> just that we don't have good reasons to take the'sg->offset' into account
>> for now.
>>    
>>
>>> to fix a theoretical issue.
>>
>> The start PA of a buffer segment has been altered, but the corresponding
>> VA is not.
>>
>> Maybe a approach has to guarantee correct in the theory first.
> I'm aware that one could construct cases where things fall over with
> the previous code. However, there is no such case in practice. I fully
> agree that this issue should be fixed, which is obviously why I merged
> the patch.
>
> I do not agree to introduce churn into the stable trees and burden
> myself and others to check the correctness of the backports (just
> because patches do apply to the stable tree does not mean all their
> prerequisites and underlying assumptions are met),


The core problem still is, whether 'sg->offset != 0' will happen or not.
Without answering this fundamental question I don't think the rest murmurs
make technical sense.


The patch is about to stop touching unreasonable part, if stable branches
has raised any problem because of this single patch, I think I could help
to resolve.


> to fix a theoretical issue.


This is concept, not theoretical.

> Regards,
> Lucas

-- 
Best regards,
Sui


