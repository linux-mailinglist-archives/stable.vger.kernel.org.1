Return-Path: <stable+bounces-194454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C592C4CBB9
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E11B3A7D72
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3102EBBAF;
	Tue, 11 Nov 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWEP18O2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE4252917;
	Tue, 11 Nov 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853840; cv=none; b=jXbEYPPuMFBb/KbDvN5gAuPHOn+cR7hOKrQB8yO2bRnL4ySXLZ4yBsmwLF6Y/xbfP3dB1s3mZewb+INwvZzTH4tQLS6nH+hRZLbCwj62LqXtWr25BFp6AMKMmlpaLxVKIS+awuWYsVbJlOgTktIvoefagiXFtwH5n+W9D6mlD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853840; c=relaxed/simple;
	bh=hBswxWwybuZIgK/oU6jdvi5SVM4HjiW7Dn5p6TuCD2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGwHY6bLGUbkX0wwJz3Eg2IP5/EmnpAs1h5m8pYuhqP+9CALzC9XYhdZuC087A/mA9PU0X/VLHUgCLW3TmQusboyb6HlM2N1KOj+2sgbaklDZYc3eaOkDA1F7gaDTOjfg+k8n6D4PYgSORedUM82grg7gek9+Nh0oVtNoBkQBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWEP18O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0AC116B1;
	Tue, 11 Nov 2025 09:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762853840;
	bh=hBswxWwybuZIgK/oU6jdvi5SVM4HjiW7Dn5p6TuCD2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TWEP18O2jujguz/unAMLA8YV9mO9nkPp/+bnpi3XZ16mItZD4Sd0Zm8TKO64f7YRO
	 2h91P+GoRDZ55WZIdzHElmpYftKdF3DdGNuYGgAFp43xC2wfI6kDiIKY8HRKAa9rBq
	 rTvvRpmm2HEP5EnDpfcQO+ZGn1ImPSlRzrpgBZLsEMQPcft0vl8y5cpBQqg7ih2I/m
	 TYsFjwKf+neGSzLCW/QtF63TIDd2CykFlXqTWaoh6/qUKhMwoVyhwc4TLq46HNIWHO
	 Vun6ED4hmLYYccF3z0rbgvzciIR4d/iqin3tLRYN3F4n7UWjp0BRXXFyeswBf99kLw
	 3meBulZABDq4A==
Message-ID: <10440fd8-aa78-4d73-a927-1f808fbc42c7@kernel.org>
Date: Tue, 11 Nov 2025 10:37:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Laight <david.laight.linux@gmail.com>,
 Huisong Li <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030155614.447905-1-thorsten.blum@linux.dev>
 <cac46c65-4510-4988-8ba2-507540363ad4@kernel.org>
 <9DA6251C-C725-46F2-899A-5CF2BE39982E@linux.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <9DA6251C-C725-46F2-899A-5CF2BE39982E@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2025 23:11, Thorsten Blum wrote:
> On 9. Nov 2025, at 19:29, Krzysztof Kozlowski wrote:
>> On 30/10/2025 16:56, Thorsten Blum wrote:
>>> -	/* Convert 2nd entry to int */
>>> -	ret = kstrtoint (token, 10, &temp);
>>> -	if (ret) {
>>> -		dev_info(device,
>>> -			"%s: error parsing args %d\n", __func__, ret);
>>> -		goto free_m;
>>> +	p = endp + 1;
>>> +	temp = simple_strtol(p, &endp, 10);
>>> +	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
>>> +		dev_info(device, "%s: error parsing args %d\n",
>>> +			 __func__, -EINVAL);
>>> +		goto err;
>>> 	}
>>> +	/* Cast to short to eliminate out of range values */
>>> +	th = int_to_short((int)temp);
>>>
>>> -	/* Prepare to cast to short by eliminating out of range values */
>>> -	th = int_to_short(temp);
>>> -
>>> -	/* Reorder if required th and tl */
>>> +	/* Reorder if required */
>>> 	if (tl > th)
>>> 		swap(tl, th);
>>>
>>> @@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
>>> 	 * (th : byte 2 - tl: byte 3)
>>> 	 */
>>> 	ret = read_scratchpad(sl, &info);
>>> -	if (!ret) {
>>> -		new_config_register[0] = th;	/* Byte 2 */
>>> -		new_config_register[1] = tl;	/* Byte 3 */
>>> -		new_config_register[2] = info.rom[4];/* Byte 4 */
>>> -	} else {
>>> -		dev_info(device,
>>> -			"%s: error reading from the slave device %d\n",
>>> -			__func__, ret);
>>> -		goto free_m;
>>> +	if (ret) {
>>> +		dev_info(device, "%s: error reading from the slave device %d\n",
>>> +			 __func__, ret);
>>> +		goto err;
>>> 	}
>>> +	new_config_register[0] = th;		/* Byte 2 */
>>> +	new_config_register[1] = tl;		/* Byte 3 */
>>> +	new_config_register[2] = info.rom[4];	/* Byte 4 *
>>
>> How is this change related?
> 
> Not related, but I thought when I'm already rewriting 80% of the
> function, I might as well just improve the indentation/formatting.

Fix of buffer overflow should not contain any style changes. And
definitely changing if/else logic is just style.

Best regards,
Krzysztof

