Return-Path: <stable+bounces-208055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26ED115A0
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACAD301F00F
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713E346797;
	Mon, 12 Jan 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="Rj5LJwT+"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC4346771;
	Mon, 12 Jan 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208182; cv=none; b=lBTWCqQiw8O30axXyGNcYtWMuYK4w/IGN3ik2kEjw3CL/tARI2zKj0Zv2tqaqCb4nNSTMRfFD9tHemLRvwFnSRyMBfmYNH309zlYV6AVeuYtesL2sgHw0/K99K+da9BTR7RQCuxyvUl8D4JGb54Jv74ImBxO87a3blnOG2c2s2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208182; c=relaxed/simple;
	bh=xIRZ/FaSvuHrmYkGikUIcZjd9YhQw52qIW7JYwpyfIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVIqKoPGhrYjsiInmOSPlAdD0hfHcUBEu2mFyX6SOBxu2ZC5645Zq4kYnLZetB6woAjWzTzNZTBMgcip/9Gzbc79V5yr5ht1CKQn8ctqFkBUbWQvDeexyA41zr5gRIzaGvnDkJ0KoIRPKFPgmBWBPkj7Z4iHpjqe/5fjIazDHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=Rj5LJwT+; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1768208179; x=1799744179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIRZ/FaSvuHrmYkGikUIcZjd9YhQw52qIW7JYwpyfIM=;
  b=Rj5LJwT+exXWqiNeGJzijpgDYhQmeuKSMVAxWWtC3WTKDzkZX2JsqPzh
   92Dt7i9JGbUdr0kvZTr+HnomJdcIOKnB3+cIytyozf5f1oL3mHfkyCim8
   q9kSfZ6QsyMgPWo9ErnnRxlwOTItcBap0W1CIQXPCwverwY2Du/m4Fvxf
   r23QHYzq9kLN4ZzBmnJt/ky4EN92/NtWa42osLSFeP3bW9jBmlLBKlIjU
   CODroHatGz1BUo7PTBwy6v1gCjCmXsXOafB6g9D6IVhAR9zMVMzHq43BU
   r6TgkDg57KiIWKaMQ+pDaJvq1VdKOSn2GL7KZ0GYTapocMPbZmrO8DfrG
   A==;
X-CSE-ConnectionGUID: 651BMYvfTVGlE7RB3UICaA==
X-CSE-MsgGUID: 1OKWucKESpq7sHUxRfp4PA==
IronPort-SDR: 6964b714_tSxTxtCp/DhJlGVKvJgQK83f0dJn/sc2Eb7KU4/2ZLVibuW
 y8CuVpNiLDhhkyOKJ+BSNgYPgHSN9mc+dLVQEog==
X-IronPort-AV: E=Sophos;i="6.21,219,1763420400"; 
   d="scan'208";a="1584331"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 12 Jan 2026 09:55:48 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id 4165913005A6;
	Mon, 12 Jan 2026 09:55:28 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 2955813006A1;
	Mon, 12 Jan 2026 09:55:28 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id KBcMbSomLXQ0; Mon, 12 Jan 2026 09:55:28 +0100 (CET)
Received: from [192.168.100.117] (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id EAD5F13005A6;
	Mon, 12 Jan 2026 09:55:27 +0100 (CET)
Message-ID: <095dd1c7-58fe-4fa7-9ed5-dbfa22911e90@hale.at>
Date: Mon, 12 Jan 2026 09:55:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: nfc: nci: Fix parameter validation for packet
 data
To: Jakub Kicinski <kuba@kernel.org>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20251223072552.297922-1-michael.thalmeier@hale.at>
 <20260104101323.1ac8b478@kernel.org>
 <4d6a1f0b-946e-4acb-bfe4-1e9317fd144e@hale.at>
 <20260107181519.1e6dbfc6@kernel.org>
From: Michael Thalmeier <michael.thalmeier@hale.at>
Content-Language: en-US
In-Reply-To: <20260107181519.1e6dbfc6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 08.01.26 um 03:15 schrieb Jakub Kicinski:
> On Wed, 7 Jan 2026 11:06:27 +0100 Michael Thalmeier wrote:
>>>> @@ -380,6 +384,10 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>>>>    	pr_debug("rf_tech_specific_params_len %d\n",
>>>>    		 ntf.rf_tech_specific_params_len);
>>>>    
>>>> +	if (skb->len < (data - skb->data) +
>>>> +			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
>>>> +		return -EINVAL;
>>>
>>> Are we validating ntf.rf_tech_specific_params_len against the
>>> extraction logic in nci_extract_rf_params_nfca_passive_poll()
>>> and friends?
>>
>> You are right. The current patch is only validating that the received
>> packet is consistent in the way that the rf_tech_specific_params_len
>> number of bytes is also contained in the buffer.
>>
>> There is currently no code that validates that
>> nci_extract_rf_params_nfca_passive_poll and friends only access the
>> given number of bytes in their logic.
>> And to be frank, I do not know how to implement this without either
>> cluttering the code with validation logic or re-implementing half the
>> parsing logic for length validation.
> 
> Don't think there's a magic bullet, we'd either have to pass the skb
> or "remaining length" to all the parsing helpers and have them ensure
> they are not going out of bounds.
> 
> There doesn't seem to be a huge number of those helpers but if you
> don't wanna tackle trying to validate the accesses maybe just add a
> couple of comments that the validation is missing in the helpers called
> in the switch statement?

Will be sending an updated patch with validation in the helpers.

> 
> BTW are you actually using the Linux NFC implementation or just playing
> with it? I'm not sure I'd trust this code for anything but accumulating
> C-V-Es, TBH.

Yes, we are using the Linux NFC implementation with the NCI driver (with 
a NXP PN7150 NFC chip) in production devices. It was actually working 
quite well and stable until the referenced commit completely broke it.



