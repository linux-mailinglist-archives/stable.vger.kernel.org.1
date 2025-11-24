Return-Path: <stable+bounces-196660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C00C7F637
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908834E2DF0
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874024677B;
	Mon, 24 Nov 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYErwbzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93922AD2C;
	Mon, 24 Nov 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763973017; cv=none; b=hbYLjHQeQUPIwDfe3Qz3kXclzkoTwJvpbQ1QLWEpaGH5N5hAhYcgz+6jJDGqw4qLbvm+gQhbV8pLpxlnjUucKKMtaCYK9S3zFNy1zbZAtq7OzQY9VZoPsvNtnKN+kazkkiShRwDmIMyLTgQeFVVLAHcEVnmc3nlxM9YicGsCKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763973017; c=relaxed/simple;
	bh=bg4OCJoS/Sw+A/y7cBvEecuwcG7LWVdliImHvZLiGWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sC8dVZTfUORNd+VMg+DwIztcsn7eypGe5wBe114C74CJeX5jaQ8PYuIj7izs6t/Je5FTwCXugxmFMI5klztF/pcPr7jTYU+dTWdQAZQo5Mzwk1LpzGwZtA0AvivX0Hcp+OFAWrS3TEu5yfRJo8luCLf8CtYD6wjS1mJeZsOG+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYErwbzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E4C4CEF1;
	Mon, 24 Nov 2025 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763973017;
	bh=bg4OCJoS/Sw+A/y7cBvEecuwcG7LWVdliImHvZLiGWA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DYErwbzrqjocx5yXtax18c8UJzRSOEdAocUwOC+UjQ1/ksJmCwpN7xk2j0kypJ8qf
	 JXqZMIvwLBSHUdOHtkplxApkAby65/e3nBPC9ztrCqBtEA75nbihtCJ54ChfPemNd/
	 fmxR4TLd0ijNyJIgLO3sIYFJrM+/pHgFsbJ1x/T+R2QGcuHdETl1cjO5/TsEnk7OR9
	 afy3g/X7SUjPGdTuLErVLIaJHcOjHuY0JxLTc7SfiHcbqNq3LTuPEf3oE+n9j83FTy
	 D/nOiEa0M49Vib73CKDzPysrHGoLH04wiYs+TkCuHBqHAJloydqvVuKnmOwIklgX8y
	 3Fo7QRhAAsCuw==
Message-ID: <7557d32c-c5e1-4e73-aefe-23ebf4bea708@kernel.org>
Date: Mon, 24 Nov 2025 09:30:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linville@tuxdriver.com, aloisio.almeida@openbossa.org,
 johannes@sipsolutions.net, lauro.venancio@openbossa.org,
 sameo@linux.intel.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251121022728.3661-1-make24@iscas.ac.cn>
 <3c0b6a08-cbaa-4e7e-8689-1fa716dd1525@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <3c0b6a08-cbaa-4e7e-8689-1fa716dd1525@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2025 09:24, Krzysztof Kozlowski wrote:
> On 21/11/2025 03:27, Ma Ke wrote:
>> nfc_genl_dump_targets() increments the device reference count via
> 
> Only in some cases, but you drop it unconditionally.
> 
>> nfc_get_device() but fails to decrement it properly. nfc_get_device()
>> calls class_find_device() which internally calls get_device() to
>> increment the reference count. No corresponding put_device() is made
>> to decrement the reference count.
>>
>> Add proper reference count decrementing using nfc_put_device() when
>> the dump operation completes or encounters an error, ensuring balanced
>> reference counting.
>>
>> Found by code review.
> 
> Drop, there is no point nor need to say that humans did the work. This
> actually rather suggests you used LLM and disguise your finding as "code
> review".
> 
> No, LLM is not code review.

Looks like LLM.

> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 4d12b8b129f1 ("NFC: add nfc generic netlink interface")
>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> ---
>>  net/nfc/netlink.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
>> index a18e2c503da6..9ae138ee91dd 100644
>> --- a/net/nfc/netlink.c
>> +++ b/net/nfc/netlink.c
>> @@ -159,6 +159,11 @@ static int nfc_genl_dump_targets(struct sk_buff *skb,
>>  
>>  	cb->args[0] = i;
>>  
>> +	if (rc < 0 || i >= dev->n_targets) {
>> +		nfc_put_device(dev);
>> +		cb->args[1] = 0;
> 
> Did you test it?

I am pretty sure this is double put and thus bug. There is put in done().

Best regards,
Krzysztof

