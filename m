Return-Path: <stable+bounces-202539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD79CC2CE6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02FCF300D8E8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD49393DC5;
	Tue, 16 Dec 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OnH1CasT"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C9365A1A
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888224; cv=none; b=h2r/oe7edIeG7PxckyFtk7qQFPFw/J4XYTEFUHcEG7lk4t/4vjD022ilYgqMo9RuUs3W9ylwW3OqbsoALKXLGC1Tf1ASAFxSX/gjZNrnheqQbMmH7KGFBvqzLzou+a2aN/ls4fT69Fo+doEWEWJr9Yqb8O7U8ZMgLUZj085LL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888224; c=relaxed/simple;
	bh=7yolT636jRC/mcRZn8I84hXqpMW0x0YQIEGWsjGb/HI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RdjyEobxfS9F/GgmbZQqcGUdn5YkYQ0Lr3n+NL+S3W3MKNtUFDwsd59I2zaqImToAaN8qLdnAN3fWNV6n3xYqY0+OtSGLst2snSzH0cW4Tz1pBD6AAxlkAwan4QdBVkB8Oc+G/gm9ToN9bzJgQb2VY1Req9Im2vSBsGjGKuBljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OnH1CasT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765888204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBitbS+AynqjT0TC+eWlmRVTfBavzMnQ+1VJqNBkJPg=;
	b=OnH1CasTfPSRcU5klJLi5CIaLBzImZNknFeKresWTMlR1mzx0f8Mkwowsd0MOWyvVHtykW
	gTq4CRpGnLE6YhxNfGwtx1S5IEqMomBa/KPXsRF4sk4ZxZifIovbGheoicl0NatoTslXUR
	Ji0gvwdWrzlsooBFqaGojnT9Hci9RXc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <243ec26f-1fe1-4b3c-ab24-a6ebab163cde@kernel.org>
Date: Tue, 16 Dec 2025 13:30:01 +0100
Cc: David Laight <david.laight.linux@gmail.com>,
 Huisong Li <lihuisong@huawei.com>,
 Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2434C572-231F-416D-AE42-BAE8AA86B52E@linux.dev>
References: <20251111204422.41993-2-thorsten.blum@linux.dev>
 <243ec26f-1fe1-4b3c-ab24-a6ebab163cde@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 16. Dec 2025, at 08:11, Krzysztof Kozlowski wrote:
> On 11/11/2025 21:44, Thorsten Blum wrote:
>> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
>> bytes and a NUL terminator is appended. However, the 'size' argument
>> does not account for this extra byte. The original code then allocated
>> 'size' bytes and used strcpy() to copy 'buf', which always writes one
>> byte past the allocated buffer since strcpy() copies until the NUL
>> terminator at index 'size'.
>> 
>> Fix this by parsing the 'buf' parameter directly using simple_strtoll()
>> without allocating any intermediate memory or string copying. This
>> removes the overflow while simplifying the code.
>> 
>> Cc: stable@vger.kernel.org
>> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> [...]
>> 
>> +	if (p == endp || *endp != ' ')
>> +		ret = -EINVAL;
>> +	else if (temp < INT_MIN || temp > INT_MAX)
>> +		ret = -ERANGE;
>> 	if (ret) {
>> 		dev_info(device,
>> 			"%s: error parsing args %d\n", __func__, ret);
>> -		goto free_m;
>> +		goto err;
> 
> So this is just return size.

Yes, all 'goto err' could be replaced with 'return size'. I only renamed
the label to keep the changes minimal.


