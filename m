Return-Path: <stable+bounces-6879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9E8158BB
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 11:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBB51C24A5B
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E0154BA;
	Sat, 16 Dec 2023 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="M9FNw9po"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A31E4AA
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <a6d9940b-76e4-43cf-9a37-53def408a5b4@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702723644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Urgm+WxmD2C4sIvkvCAGFZWK3r/QGopzONmUzrmcgUM=;
	b=M9FNw9poIVNNfP69wG139OLAxqhUUdocQkXTndp/W04mRYIzN9g79+mfCju1b7UuN9v9SU
	TwDUMdPuuj9rrkLzZuwrKIawgdFCgbz9a9E8XfyfyiiW3M2CWIdHPVBcZQWS7yUDX77b6e
	+et8gvko3WGyyeoL4dEoZ1fKtOxnNaWxsrz/3Fkqrs2FfC/JtSwVAGmnp60Li5IBrd7fP+
	SW3MBiiosCi6ellkINI+xsB4A8RJuadZm58SeKkNAZ5wJEkEUalKMjZB3qlIym45Vdb6/f
	og83PSUKTLz+ACcfqmGhApSt3rpWhgzzZ7YdoxcGeb4Kk5Cq5sOs9LqdTCwZvw==
Date: Sat, 16 Dec 2023 17:47:19 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, =?UTF-8?Q?L=C3=A9o_Lam?=
 <leo@leolam.fr>, "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <43a1aa34-5109-41ad-88e7-19ba6101dad3@manjaro.org>
 <e7a6e6a6-2e5c-4c60-b8e0-0f8eca460586@manjaro.org>
 <DM4PR11MB5359B0524B31A258DD3B20F4E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <2023121423-factual-credibly-2d46@gregkh>
 <DM4PR11MB535948386880F5A2DB3C5582E98CA@DM4PR11MB5359.namprd11.prod.outlook.com>
 <779818b0-5175-449f-93fb-6e76166a325f@manjaro.org>
 <2023121450-habitual-transpose-68a1@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2023121450-habitual-transpose-68a1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 14.12.23 18:59, Greg Kroah-Hartman wrote:
> On Thu, Dec 14, 2023 at 03:32:47PM +0700, Philip Müller wrote:
>> On 14.12.23 15:24, Berg, Johannes wrote:
>>>>>> So Greg, how we move forward with this one? Keep the revert or
>>>>>> integrate Leo's work on top of Johannes'?
>>>>>
>>>>> It would be "resend with the fixes rolled in as a new backport".
>>>>
>>>> No, the new change needs to be a seprate commit.
>>>
>>> Oh, I stand corrected. I thought you said earlier you'd prefer a new, fixed, backport of the change that was meant to fix CQM but broke the locking, rather than two new commits.
>>>
>>>>>> Johannes, how important is your fix for the stable 6.x kernels when
>>>>>> done properly?
>>>>>
>>>>> Well CQM was broken completely for anything but (effectively) brcmfmac ...
>>>> That means roaming decisions will be less optimal, mostly.
>>>>>
>>>>> Is that annoying? Probably. Super critical? I guess not.
>>>>
>>>> Is it a regression or was it always like this?
>>>
>>> It was a regression.
>>>
>>> johannes
>>
>> So basically the reversed patch by Johannes gets re-applied as it was and
>> Leo's patch added to the series of patches to fix it. That is the way I
>> currently ship it in my kernels so far.
> 
> Great, can someone please send the series like this with your:
> 
>> We can add a Tested-by from my end if wanted.
> 
> that would be wonderful.
> 
> greg k-h
> 

Hi Greg,

Leo provided the patch series here:
https://lore.kernel.org/stable/20231216054715.7729-4-leo@leolam.fr/

However, without a cover letter to it. Since we reverted Johannes' patch 
both in 6.1.67 and 6.6.6 both patches may added to both series to 
restore the original intent.

thx.

Philip
-- 
Best, Philip


