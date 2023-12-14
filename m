Return-Path: <stable+bounces-6721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0899812A72
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9071F21100
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96801D52D;
	Thu, 14 Dec 2023 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ml15PFax"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BCBD
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 00:32:54 -0800 (PST)
Message-ID: <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702542771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ptqGvqWbAwZAM3LyFZt3iSUNwPmuF8U2U/tE/Tigak=;
	b=ml15PFax6x2+EQ2/xT4vYaEVuwUEXrdZM7igtBn7tYm282XePvFZfQWUcvik1AMSZKLzfy
	06H8M8+bXSao7ZGp8M1N1J9dIKlWSTu3/uMRI2x/wKP8kHwbHhLyhjeUxnXfGMUP1SlxpW
	3UmDEf5ECLu101Trh+sxdrtZLvpGUPb7TJsfEFGXFST0KZzqtajl4TsJrO3SLNYZL3XyHC
	l6HuQfr9GTJLVyQc4nnN2GJb14pS5vVpYfaPX2b59CVKTIAzJsUWqzrmkNx505igXj0lCf
	90CoD+NXafHBod4b9JYEcwny5DRRRY9PxLTklSXcdlAjq3uBjBjI8sVX+uMqFA==
Date: Thu, 14 Dec 2023 15:32:47 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
To: "Berg, Johannes" <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?L=C3=A9o_Lam?= <leo@leolam.fr>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <2023121423-factual-credibly-2d46@gregkh>
 <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 14.12.23 15:24, Berg, Johannes wrote:
>>>> So Greg, how we move forward with this one? Keep the revert or
>>>> integrate Leo's work on top of Johannes'?
>>>
>>> It would be "resend with the fixes rolled in as a new backport".
>>
>> No, the new change needs to be a seprate commit.
> 
> Oh, I stand corrected. I thought you said earlier you'd prefer a new, fixed, backport of the change that was meant to fix CQM but broke the locking, rather than two new commits.
> 
>>>> Johannes, how important is your fix for the stable 6.x kernels when
>>>> done properly?
>>>
>>> Well CQM was broken completely for anything but (effectively) brcmfmac ...
>> That means roaming decisions will be less optimal, mostly.
>>>
>>> Is that annoying? Probably. Super critical? I guess not.
>>
>> Is it a regression or was it always like this?
> 
> It was a regression.
> 
> johannes

So basically the reversed patch by Johannes gets re-applied as it was 
and Leo's patch added to the series of patches to fix it. That is the 
way I currently ship it in my kernels so far.

We can add a Tested-by from my end if wanted.

-- 
Best, Philip


