Return-Path: <stable+bounces-183434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C44BBE3F5
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F445348769
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA42D3A94;
	Mon,  6 Oct 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjO4kg9O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046C27F19F
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758984; cv=none; b=RXYGYk9F0lWeTqB8cuMzI5EiV4QuweE0eBjxt+CZOtVvGOQkw5hscrpDCyLrpm9521eKGxMWKSJYPNq7Mo2YXp77hqWyVuhO3h8sw28ZsP7/I6XV9utFoE2PBfQEe/AEkxSFsinDD/c3DJ0W7PNUG43mCbn6qC4Qe0yeL7eNl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758984; c=relaxed/simple;
	bh=Z2xAK+1Wj91vV8QniPmwQhcfKfqA2muGrYwV25zeEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3NrKmldis6fjs0hHT61QtMJjqrnB0dbguOOp5TjH1nN5m4zJBwOoyun2EW47/98lE3uNCvMesl7QQYy6oVm0jdsmFgxHE4Mne5EWeULHzonT9pRvTjdMuyV54fN8Fu2/2UeXceLrgqXDl4VKn15z3Y8FnZ8fnmj1v/j1I+CtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjO4kg9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F59C4CEF5;
	Mon,  6 Oct 2025 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759758983;
	bh=Z2xAK+1Wj91vV8QniPmwQhcfKfqA2muGrYwV25zeEG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KjO4kg9Os/L5zSQmdJhy89RZczumzcmKDfCfY40Gic0bOR5DerHNh9kFWItj5oBUh
	 PosivmrOJnLGKGWpjmIL7CllQqHy1BcXLnt/r0ChAJHL2Vik2eVsAHNUUnWbUzlAbr
	 uxKdHnl4hVqD3V5KXA4+wkZwhChAjRinePJgMrO9lIg5C28F/+k0ZJn8QtJUrJRpUZ
	 BZaIzSg0L9k5le7p51YiWOUHo7jLlSN1BBxUvAx50fy1V0ljBhEHm+rjWnGyy+LhVl
	 vxnpe/wZGwfNEl9Ki28gAI3Hwa+Ojs4A31c+C/bpR2i4raHWcWfdCtNyzUXCzkbPCz
	 gpmFlNjuuqCaw==
Message-ID: <f2d82fa5-7eb3-4717-89ba-6568658e1bf4@kernel.org>
Date: Mon, 6 Oct 2025 08:56:23 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LR compute WA
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>
 <2025100627-landfill-helium-d99a@gregkh>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <2025100627-landfill-helium-d99a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/2025 5:04 AM, Greg KH wrote:
> On Sat, Oct 04, 2025 at 01:41:29PM -0500, Mario Limonciello (AMD) (kernel.org) wrote:
>> Hi,
>>
>> We have some reports of long compute jobs on APUs hanging the system. This
>> has been root caused and a workaround has been introduced in the mainline
>> kernel.  I didn't CC stable on the original W/A because I wanted to make
>> sure we've had enough time to test it didn't have unintended side effects.
>>
>> I feel comfortable with the testing at this point and I think it's worth
>> bringing back to any stable kernels it will apply to 6.12.y and newer. The
>> commit is:
>>
>> 1fb710793ce2619223adffaf981b1ff13cd48f17
>   
> 
> It did not apply to 6.12.y, so if you want it there, can you provide a
> working backport?
> 
> thanks,
> 
> greg k-h

Thanks, I see 6.16 and 6.17 had no problem.  I'll find the contextually 
missing patches and send out 6.12.y separately.

