Return-Path: <stable+bounces-5278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2B80C516
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62601F21062
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4C219E2;
	Mon, 11 Dec 2023 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dsQdO2PS"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B281184
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:46:18 -0800 (PST)
Message-ID: <fbd66e83-4aa4-4d48-972a-e41d4ec905f9@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1702287977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1TrzbYPmec8JqrZLeyZnZz49EXwc6BfMWv7EoVGelY=;
	b=dsQdO2PS86HqTO9ehhNuV+bDsisX27E6XXT6hm2oASsokgQ2dtcbFnS97Fns8AETD+oEMq
	PzJzE9Y8qKPZMdeRm2cVH93pF51ynoQn+pt9jUUdSK21umCgRNyxng+lX71fKHepOzkMg6
	ZLHNetSCU9F//6DjlaevioU6a63ludDf/O985eN8jN7v/EYE+7gwXvoWWniYXuQ48MhLxW
	jHqsZdOQKx5rfr8PWYPRF0R832+BL/z0nCmPOuSSvcW0p3cYIAdT5zkaCFHJT5gznt2T7E
	JGIZ/wgSt+V7hEShwsSWl7CaPC583VpgpR1PCTqRASykrkoJu3ZCpr03misaIw==
Date: Mon, 11 Dec 2023 16:46:13 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, leo@leolam.fr
Cc: Johannes Berg <johannes.berg@intel.com>, stable@vger.kernel.org
References: <e374bb16-5b13-44cc-b11a-2f4eefb1ecf5@manjaro.org>
 <2023121139-scrunch-smilingly-54f4@gregkh>
 <aee3e5a0-94b5-4c19-88e4-bb6a8d1fafe3@manjaro.org>
 <2023121127-obstinate-constable-e04f@gregkh>
 <2023121128-unlighted-bagful-f6f1@gregkh>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2023121128-unlighted-bagful-f6f1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 11.12.23 16:40, Greg Kroah-Hartman wrote:
> On Mon, Dec 11, 2023 at 10:39:26AM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Dec 11, 2023 at 04:26:26PM +0700, Philip Müller wrote:
>>> On 11.12.23 16:25, Greg Kroah-Hartman wrote:
>>>> On Mon, Dec 11, 2023 at 04:02:11PM +0700, Philip Müller wrote:
>>>>> Hi Johannes, hi Greg,
>>>>>
>>>>> Any tree that back-ported 7e7efdda6adb wifi: cfg80211: fix CQM for non-range
>>>>> use that does not contain 076fc8775daf wifi: cfg80211: remove wdev mutex
>>>>> (which does not apply cleanly to 6.6.y or 6.6.1) will be affected.
>>>>>
>>>>> You can find a downstream bug report at Arch Linux:
>>>>>
>>>>> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/17
>>>>>
>>>>> So we should either revert 7e7efdda6adb or backport the needed to those
>>>>> kernel series. 6.7.y is reported to work with 6.7.0-rc4.
>>>>
>>>> Yeah, this looks bad, I'll go just revert this for now and push out a
>>>> new release with the fix as lots of people are hitting it.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>>
>>> Hi Greg,
>>>
>>> there is actually a fix for it:
>>>
>>> https://www.spinics.net/lists/stable/msg703040.html
>>
>> That "fix" was not cc:ed to any of the wifi developers and would need a
>> lot of review before I feel comfortable accepting it, as I said in the
>> response to that message.
>>
>> Also, please point to lore.kernel.org lists, it's much easier to handle
>> as we don't have any control over any other archive web site.
> 
> Also, have you tested that proposed fix?
> 
> thanks,
> 
> greg k-h

Not yet. Currently build kernels on my end to see if it fixes the 
regression. A revert of the patch is confirmed to work also by users who 
have the issue. I can check with mine, when I've released a kernel with 
Léo Lam's fix.

-- 
Best, Philip


