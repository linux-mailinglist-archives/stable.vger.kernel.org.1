Return-Path: <stable+bounces-9232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573F82279D
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 04:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9666F1C20F8C
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 03:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEB63B7;
	Wed,  3 Jan 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ryOVnnf1"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36C17984
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 03:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <fb44bcd8-6dfd-4a0d-98f5-cb39fedcd919@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704253509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yq2JKrMGGQJm0Ov1MXLoxp5SQKZARuzPA4iAJX2Vars=;
	b=ryOVnnf1UA+UGj5S/jM2agNpVOSDDPN1fZyPS7zE9q5yj4l1E8JJ/aL8nTDq9ST4EcSgxS
	3gt0bVIpSFn1Cn78MIzZkhwuOM53kDD6e3nVxXWP5ipmonqI3Raz8fXjAytP90Cf3DRJc2
	KzYYto46vqT3e2vGg/R/b6XokzobAXII8u0w571jRoZY+neY14RfwRl2RTLHpxol946Gjp
	gKW3qCDgE4lRf232v7MQoL2v7JWUgtzYyyW+uN9A7KRHLNDTLl4UNpj0eMntg/LyZmweBe
	Oi9u8CZPW4AcF6J/KHgdVvBxgY272jOkZyg1n474Dp6BnLNtkKZWtflhv/tDBA==
Date: Wed, 3 Jan 2024 10:45:05 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.1.66, 6.6.5 - wifi: cfg80211: fix CQM for
 non-range use
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?Q?L=C3=A9o_Lam?=
 <leo@leolam.fr>
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
 <a6d9940b-76e4-43cf-9a37-53def408a5b4@manjaro.org>
 <eff5692861533201b7a1e680bc36c551d0aa0a65.camel@leolam.fr>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <eff5692861533201b7a1e680bc36c551d0aa0a65.camel@leolam.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 17.12.23 00:58, Léo Lam wrote:
> On Sat, 2023-12-16 at 17:47 +0700, Philip Müller wrote:
>>
>> Leo provided the patch series here:
>> https://lore.kernel.org/stable/20231216054715.7729-4-leo@leolam.fr/
>>
>> However, without a cover letter to it. Since we reverted Johannes' patch
>> both in 6.1.67 and 6.6.6 both patches may added to both series to
>> restore the original intent.
>>
> 
> Ah sorry, I assumed the link I added in the patch description provided
> enough context!
> 
> Also I should note that my Tested-by only covers 6.6.7, while Phillip's
> Tested-by covers both 6.1 and 6.6 as there are forum users who tested
> both.
> 

This is now part of 6.1.70, however didn't land in 6.6.x series yet ...

-- 
Best, Philip


