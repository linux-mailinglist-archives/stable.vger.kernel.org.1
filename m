Return-Path: <stable+bounces-33919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A269F893A1C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E13C281566
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C913FFB;
	Mon,  1 Apr 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Az2glAEa"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344312E76;
	Mon,  1 Apr 2024 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966728; cv=none; b=RNUSSMi/KV5l02HenRaA/vo/EKVVylreGJkehDpxpUmQfp4gDNMPOAeblWz3PeyvDRbmHKcukQDxEVdp8Qx2r7K0V7KQFVDsrKR21cBeM/qMf2pvIqt4+ezmxk/v1tD/eAxD3DhJOtmrljtgMpjHuG1/44E03ovF6sB5pLOC310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966728; c=relaxed/simple;
	bh=ehfnvRIeHgnQ4xt2QMZ0t370QTxU8nKi+N95bSxHXIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDiHenbbJtZM8uJRjswmBoWswsOI6SUlGgY4EsA8MkNtSeZ+v5R2O/VZzftRqEpS0rU0SjUsSR62BGBGxfO9eRjtxAvkziQ5MQegjn69zR9sTgf3Rvn0i3RdFHDU1ahat6BLqG+q5BSQv4aiKbK2z53GJ3tXyjR+7yerAV+mdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Az2glAEa; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=LmPPOUxF89lqOHUIkRqnzvDXAwSIm/wUrFmtQE4uP9M=;
	t=1711966726; x=1712398726; b=Az2glAEaBzq9x8ZdkmZ4bYq6eu51Qcz+cGYrGmkDs4Rryzy
	RD5NTUzoQDLwZMja2x+MOAFTwweqjpFs5TCSeCuP5Y8VWm64SiECF4SuFm/eA+sT3X9mOEmNsLiep
	+hBkm0ZPrtJFXdg7x1n74mu7Ib4C5gQV+5/zBZ6FM7Ndr4g9h9SrysGCE6afnqRqbaR8cyiX8NYoF
	nGX48bEdDF5OyF07rMTKerg36DTNYR9TGuOmWTWs4SIme9Pmwa2fz+Q4wiPuCeBmvrvol2L5DbhKV
	fT4zYQxcGhzxzZS2nlKhzxvCKDml8gPsYSe8U2Qt2xhlcoT2QwVjogpKDgm90r7Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrEkU-0006tM-6Y; Mon, 01 Apr 2024 12:18:42 +0200
Message-ID: <e4dab631-0e22-4781-8229-1309840b1fa6@leemhuis.info>
Date: Mon, 1 Apr 2024 12:18:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Kenny Levinsen <kl@kl.wtf>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
 <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
 <297c2412-5680-4a4f-bd43-b3431a0bb4bd@leemhuis.info>
 <349de395-0797-478d-9e04-860ebf423f4d@manjaro.org>
 <53b09f02-1422-405f-852f-02776fde19d1@manjaro.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <53b09f02-1422-405f-852f-02776fde19d1@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711966726;c136b494;
X-HE-SMSGID: 1rrEkU-0006tM-6Y

On 01.04.24 12:09, Philip Müller wrote:
> On 01/04/2024 13:43, Philip Müller wrote:
>> On 01/04/2024 13:20, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> TWIMC: Kenny Levinsen (now CCed) posted a patch to fix problems
>>> introduced by af93a167eda9:
>>> https://lore.kernel.org/all/20240331182440.14477-1-kl@kl.wtf/
>>>
>>> Looks a bit (but I might be wrong there!) like he ran into similar
>>> problems as Philip, but was not aware of this thread.
>>
>> thx for the pointer. I'm applying it right now and let you know if
>> that changes the situation on my device. Might be the right direction.
> 
> Seems I can confirm that the patch fixes the regression for me.

Thx for testing!

> I did
> batch test with reloading the module and no -110 errors anymore. We
> should add this patch also to 6.8+ kernels and backport if patches from
> that series should go to lower LTS kernels.

Well, ideally Kenny would add a stable tag to ensure backporting to
affected series, but that's up to Kenny.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot fix: HID: i2c-hid: Revert to await reset ACK before reading
report descriptor
#regzbot monitor:
https://lore.kernel.org/all/20240331182440.14477-1-kl@kl.wtf/


