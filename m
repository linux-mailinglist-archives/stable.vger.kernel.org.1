Return-Path: <stable+bounces-49947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB38FFBDF
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 08:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2C286AE6
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B611527BC;
	Fri,  7 Jun 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JmvfL000"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E8152168;
	Fri,  7 Jun 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740614; cv=none; b=gyiIqbleI1xCxKpfvrFHqJRROGMFGbKWMPRZEJ5xL2s7JmPOXzb2XOhh0EqTpGO7tVo7dhUdaC+x45cAKsgeIqisZb3p1fK7Ya2GEHiV9kmPU/u9HQqsiStqhln8/NzZygyT1Tg2bjHNm5Q/yTyOO8k73OOlGzsvo3LtkB3XfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740614; c=relaxed/simple;
	bh=ckioJl9vajbY1NY8xPgM0DgSe4tTZ088rXm8lefAKNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUi7K5SMmwqyeYAZnsJvR3EkBRiHcl116JX3T/JEJEIRRUPNWb8knjhtp8+2HetGEG/RxYO0XrjYWRmYPDM1DI6z/bG+UPqoYSfCXaBSG0DXz6jNH4p3wUanXKwJobokmXhApPgY5v36SbC2cJynYX9L6oxexxhMumu4sWGJcVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JmvfL000; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=UKY9mfcsSIWUumL/x92ZX9UOfQJ5ndiPQuj7lVX4LJA=;
	t=1717740612; x=1718172612; b=JmvfL000RzKOWtFyD9IcNLFCOOjp5luVRjMa7DIcyPsLDF9
	WdCgDmQYiEl1AnQxruZvSlcXFyL4YLb8M5v/cTGanqey4kFpWTdApXVmwtQjypoc37DPDOcRfMqFX
	E86moI2SP/DraN2xC/xaBuQW2JiWIK+VrJm03nprwo0r9u6lZvN4A/V+sUcK+lvcB5u7aXioCXdFc
	x3HWYm3Ib51UyUi3Tw17kti4iMAzQtOllpx0tC+fWZV4RTTlfO2xG2eEWTHgAtfySTq8iRwsibHFA
	RWMmuYdD1ktTrgyCht7+jCRHp180M/7407TwRMuA7nZRm8nyj60ctfK6L1d0Kr3Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFSnh-0006r7-Rs; Fri, 07 Jun 2024 08:10:09 +0200
Message-ID: <212fca4c-fc1f-4da4-b48e-c6a4b64a2b35@leemhuis.info>
Date: Fri, 7 Jun 2024 08:10:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is
 not available (Regression in 6.9.3, 6.8.12)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <CABBYNZLE9uYiRM-baoBt=RQktq__TguMETgmVWGzfeorARfm4w@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABBYNZLE9uYiRM-baoBt=RQktq__TguMETgmVWGzfeorARfm4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717740612;e4727336;
X-HE-SMSGID: 1sFSnh-0006r7-Rs

On 06.06.24 23:23, Luiz Augusto von Dentz wrote:
> On Thu, Jun 6, 2024 at 4:46 PM Timo Schröder <der.timosch@gmail.com> wrote:
>> on my two notebooks, one with Ubuntu (Mainline Kernel 6.9.3, bluez
>> 5.7.2) and the other one with Manjaro (6.9.3, bluez 5.7.6) I'm having
>> problems with my Sony WH-1000XM3 and Shure BT1. Either A2DP or HFP/HSP
>> is not available after the connection has been established after a
>> reboot or a reconnection. It's reproducible that with the WH-1000XM3
>> the A2DP profiles are missing and with the Shure BT1 HFP/HSP profiles
>> are missing. It also takes longer than usual to connect and I have a
>> log message in the journal:
>>
>> Jun 06 16:28:10 liebig bluetoothd[854]:
>> profiles/audio/avdtp.c:cancel_request() Discover: Connection timed out
>> (110)
>>
>> When I disable and re-enable bluetooth (while the Headsets are still
>> on) and trigger a reconnect from the notebooks, A2DP and HFP/HSP
>> Profiles are available again.
>>
>> I also tested it with 6.8.12 and it's the same problem. 6.8.11 and
>> 6.9.2 don't have the problem.
>> So I did a bisection. After reverting commit
>> af1d425b6dc67cd67809f835dd7afb6be4d43e03 "Bluetooth: HCI: Remove
>> HCI_AMP support" for 6.9.3 it's working again without problems.
>>
>> Let me know if you need anything from me.
> 
> Wait what, that patch has nothing to do with any of these profiles not
> really sure how that would cause a regression really, are you sure you
> don't have actual connection timeout happening at the link layer and
> that by some chance didn't happen when running with HCI_AMP reverted?
> 
> I'd be surprised that HCI_AMP has any effect in most controllers
> anyway, only virtual controllers was using that afaik.

Stupid question from a bystander without knowledge in the field (so feel
free to ignore this): is that patch maybe causing trouble because it has
some hidden dependency on a earlier change that was not backported to
6.9.y?

Timo, to rule that out (and it's good to know in general, too) it would
be good to known if current mainline (e.g. 6.10-rc) is affected as well.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

