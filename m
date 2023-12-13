Return-Path: <stable+bounces-6683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67B7812349
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 00:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7801C2141B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785AB77B5A;
	Wed, 13 Dec 2023 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="eKN1dHeN"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B21BF2
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 15:39:28 -0800 (PST)
Message-ID: <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702510737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/EgbldCL2dN2jX1UzTy+FFTsRD7YW+SIA0bPqARDJM=;
	b=eKN1dHeNGQvzW5sjyogafUye/vb5HiIljf5Nrga9D/7v/a0Ts1BwMksf9B1DDEH9t3tiir
	Si+nRMqtRK1BuCqUQJ9T8eNq6ibAoaUGMtqvqagW723gc/q1Q+4SQdLmC4bSQ+tViOEJ2y
	1ZzOboEZu+F/PC2aK2DfaXNYqlmDX1m7XeA/4ZWBUOKF03mLx907K9fvsYRseWWCk/XVnO
	z77DXdWf5vudYCjRP8Nok9BgcqaUxhl4c+j7mSzQdiCDyKTztRd+z1V+83HghkEkyHrDNp
	S7mIVMRisXHpoLflJO0xlcNdYXMb88xWPohleMQUT1mgGySIGhCpdkf5iHlT5A==
Date: Thu, 14 Dec 2023 06:38:51 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
To: "Berg, Johannes" <johannes.berg@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?L=C3=A9o_Lam?=
 <leo@leolam.fr>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 12.12.23 05:26, Philip Müller wrote:
> On 12.12.23 03:58, Berg, Johannes wrote:
>>>> https://www.spinics.net/lists/stable/msg703040.html
>>
>> FWIW, that looks fine to me. I don't know how I managed to miss that. 
>> Sorry about that ☹
>>
>>> That "fix" was not cc:ed to any of the wifi developers and would need 
>>> a lot of
>>> review before I feel comfortable accepting it, as I said in the 
>>> response to that
>>> message.
>>
>> Indeed, I hadn't seen it before.
>>
>> But I just checked the error paths there, and the fix adjust all three 
>> of them correctly.
>>
>> johannes
> 
> I have at least 7 users who have tested that fix on my end:
> 
> https://lore.kernel.org/stable/20231210213930.61378-1-leo@leolam.fr/
> 
> So it can also be called tested now:
> 
> https://forum.manjaro.org/t/153045/77
> https://forum.manjaro.org/t/153045/88
> https://forum.manjaro.org/t/153045/90
> https://forum.manjaro.org/t/153045/92
> https://forum.manjaro.org/t/153045/93
> https://forum.manjaro.org/t/153045/94
> 

Since I re-applied the broken patch by Johannes plus the fix of Leo to 
6.x kernels on my end and didn't hear any regressions so far, it can be 
called tested by Manjaro community.

So Greg, how we move forward with this one? Keep the revert or integrate 
Leo's work on top of Johannes'?

Johannes, how important is your fix for the stable 6.x kernels when done 
properly?

-- 
Best, Philip


