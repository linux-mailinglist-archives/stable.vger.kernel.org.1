Return-Path: <stable+bounces-192862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7124BC448B4
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 23:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BC304E2010
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888420DD42;
	Sun,  9 Nov 2025 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="smjvEHbZ"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772AE2E63C
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726274; cv=none; b=qnNCPox3lQDdn/eFl4VcdcR1wRSzzA/sYP35mdebI/pcgQyNrkZjfMOVctfwX0nMtxGC39a/PBds7+aq31KRbJEz5DlmdXHV6QfA3mYidqdnXfv4hcSk70iJch32VT70tf7q8hQj1jkAn5HAF1CjakKb4NG59HvuSTIpRwqieY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726274; c=relaxed/simple;
	bh=DCviYoqzljPkjaLFg9opUlqzkMvLMcY7wYMpbLrXsPI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uEVjH2NrJOLK/YNkCG4DAsLH6eGh8ffO0afXcGRiW/x2LNSmA5aR90QEYvADvOVLmp6UIeIqVkcHqmYC5LOyY9PCcYLDozJ5RPM9vr9MbSviMTkmwYYJaUwE+vU5sJQSisWt8puI2MiwUMM5fvaBkefnvV2BK0eZ0uDX7m+Q8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=smjvEHbZ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762726269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+eKEhLyPOzSVOi4eq+sEhgJ4Ueema8tYGNPf1rbujg=;
	b=smjvEHbZjbNsnSakFfIAGORZLo7X14TJFkLx4spx1Y06jrHkNwB2PFVphl/qqPDkObWGm1
	9g7whvJ/88+SUAl6yLkCzpVPmvcny2kS5FiJa81xX1e00NkjCz1A9jRmz2wJAAlp9zNTrQ
	HWo4QVIYsXSKQIyv/WldVoXNt/GYgB4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <cac46c65-4510-4988-8ba2-507540363ad4@kernel.org>
Date: Sun, 9 Nov 2025 23:11:02 +0100
Cc: David Laight <david.laight.linux@gmail.com>,
 Huisong Li <lihuisong@huawei.com>,
 Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9DA6251C-C725-46F2-899A-5CF2BE39982E@linux.dev>
References: <20251030155614.447905-1-thorsten.blum@linux.dev>
 <cac46c65-4510-4988-8ba2-507540363ad4@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 9. Nov 2025, at 19:29, Krzysztof Kozlowski wrote:
> On 30/10/2025 16:56, Thorsten Blum wrote:
>> -	/* Convert 2nd entry to int */
>> -	ret = kstrtoint (token, 10, &temp);
>> -	if (ret) {
>> -		dev_info(device,
>> -			"%s: error parsing args %d\n", __func__, ret);
>> -		goto free_m;
>> +	p = endp + 1;
>> +	temp = simple_strtol(p, &endp, 10);
>> +	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
>> +		dev_info(device, "%s: error parsing args %d\n",
>> +			 __func__, -EINVAL);
>> +		goto err;
>> 	}
>> +	/* Cast to short to eliminate out of range values */
>> +	th = int_to_short((int)temp);
>> 
>> -	/* Prepare to cast to short by eliminating out of range values */
>> -	th = int_to_short(temp);
>> -
>> -	/* Reorder if required th and tl */
>> +	/* Reorder if required */
>> 	if (tl > th)
>> 		swap(tl, th);
>> 
>> @@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
>> 	 * (th : byte 2 - tl: byte 3)
>> 	 */
>> 	ret = read_scratchpad(sl, &info);
>> -	if (!ret) {
>> -		new_config_register[0] = th;	/* Byte 2 */
>> -		new_config_register[1] = tl;	/* Byte 3 */
>> -		new_config_register[2] = info.rom[4];/* Byte 4 */
>> -	} else {
>> -		dev_info(device,
>> -			"%s: error reading from the slave device %d\n",
>> -			__func__, ret);
>> -		goto free_m;
>> +	if (ret) {
>> +		dev_info(device, "%s: error reading from the slave device %d\n",
>> +			 __func__, ret);
>> +		goto err;
>> 	}
>> +	new_config_register[0] = th;		/* Byte 2 */
>> +	new_config_register[1] = tl;		/* Byte 3 */
>> +	new_config_register[2] = info.rom[4];	/* Byte 4 *
> 
> How is this change related?

Not related, but I thought when I'm already rewriting 80% of the
function, I might as well just improve the indentation/formatting.

Thanks,
Thorsten


