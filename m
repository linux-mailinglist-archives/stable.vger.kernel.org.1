Return-Path: <stable+bounces-194951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B816AC63A3F
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 11:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF363B5568
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9228630B52A;
	Mon, 17 Nov 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wavMCK8O"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D127F727;
	Mon, 17 Nov 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376910; cv=none; b=mMnv9Inn7MR4TRKZmY7dl3jRvvKoX/XY94Drs5TMEHo7uRhIaA7fFUfyTaOVyUXxlPQ4/A3w7Aj2coVn1uINgkzUuwDjHnkNfDJqDaIDzR8QwM5/FwtG0n/+vnDsrL6V/4iFn3eM/J1JToSa816TgfqOkOC/myAMOAFe8b4kCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376910; c=relaxed/simple;
	bh=2M0VkDnbNmQIejDbk40Ml2CazfkhW08KtcbopHNqyRw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ru7tpAUuJ9wh09ue9QTO841x/rp3z/ocqH/6pSiFmVNr9+3hqIMNYUNgZu9IRlpmj88rt1YhKHaaQlT+/YJGRQIXXxgnXET4MRZAGGJn5+lM7DEkq+6B3rP3j+gwb2uCjoaV7fjCHcSlxX82zfjSZOwV7Gg7bccqT+xa0xemrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wavMCK8O; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Gl5RJ+7Dhd6fFyeukfLeCRYTOZJp99ZMSn6T+FzFquQ=; t=1763376908;
	x=1763808908; b=wavMCK8OExNT1H0ZcGVJ286EFT8BVBCqOH4cziCUSjcmS1/iJF5Qc0iWJxV0k
	cM8wfGO0P4ILb8wcrTil1VcMhUwoQK+Zpl09BpGjP1Q6urAE5xW8WXwhZVbDz3B57IGiu4/+rgA8R
	DattGFjYf3ruO1QUfPrcmLQc9JI1mxzAiuUUD68vmUWi+YM90VUUKU28Ka4ahb1ztQukDBDj36jHJ
	jk2bSHsABpDm5mbbR/si/wm8Ot1oxo6e2VizdOuG+tCdeTG/wLWuwkAF908yl9NqLvL3ebdvya2GU
	tikXkrOssVNuasZNaxe9cMzQjuSIn/8Lu83wa3TJPkkn+DxMOQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vKwsw-005RES-2v;
	Mon, 17 Nov 2025 11:55:02 +0100
Message-ID: <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
Date: Mon, 17 Nov 2025 11:55:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: incogcyberpunk@proton.me, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 "sean.wang@mediatek.com" <sean.wang@mediatek.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1763376908;58f027ff;
X-HE-SMSGID: 1vKwsw-005RES-2v

On 11/17/25 10:42, Thorsten Leemhuis wrote:
> On 11/17/25 02:30, incogcyberpunk@proton.me wrote:
>>
>> #regzbot introduced: v6.13.1..v6.13.2
>>
>> Distro: Arch Linux 
>> Kernel: since v6.13.2
> 
> Lo! Thx for the report. It's unlikely that any developer will look into
> this report[1] as 6.13.y is ancient by kernel development standards and
> EOL for quite a while.
> 
> Please check if the latest stable version is still affected; if it is,
> ideally try latest mainline (6.18-rc6), too. If that is as well, it
> would be great if you could bisect between 6.13.1 and 6.13.2.

TWIMC, IncogCyberpunk replied in private to me and wrote:

"""
Sorry, if I was not clear but, the problem persists in both the stable
(v6.17.8) and the latest mainline (v6.18-rc6) linux kernels as of Nov 2025
"""

Please reply in public next time. And no problem, but quite a few people
write "since v6.13.2" and only mean later 6.13 versions, that's why I asked.

You might want to provide the logs from 6.18-rc6. Then feel free to wait
two or three days to see if a developer replies. If not, please bisect
the problem between 6.13.1 and 6.13.2 – and then try if reverting the
culprit in mainline fixes the problem (if it's possible to revert it
there easily). For details, see:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

HTH, ciao, Thorsten

>> The bluetooth adapter would be recognized and the bluetooth worked
>> flawlessly till v6.13.1 , but since the v6.13.2 , the bluetooth adapter
>> doesn't get recognized by the bluetooth service and therefore the
>> bluetooth functionality doesn't work . 
>>
>> I suspect the bluetooth's driver failing to load at the kernel-level. 
>>
>>   * The output of |bluetoothctl|​ :
>>
>> $: bluetoothctl
>> Agent registered
>> [bluetoothctl]> list
>> [bluetoothctl]> devices
>> No default controller available
>> [bluetoothctl]>
>>
>>   * The output of |systemctl status bluetooth.service|​ :
>>
>> ● bluetooth.service - Bluetooth service
>>      Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled;
>> preset: disabled)
>>      Active: active (running) since Sat 2025-11-15 22:57:00 +0545; 1 day
>> 8h ago
>>  Invocation: bddf190655fd4a4290d41cde594f2efa
>>        Docs: man:bluetoothd(8)
>>    Main PID: 617 (bluetoothd)
>>      Status: "Running"
>>       Tasks: 1 (limit: 18701)
>>      Memory: 2.8M (peak: 3.8M)
>>         CPU: 38ms
>>      CGroup: /system.slice/bluetooth.service
>>              └─617 /usr/lib/bluetooth/bluetoothd
>>
>> Nov 15 22:57:00 Incog systemd[1]: Starting Bluetooth service...
>> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth daemon 5.84
>> Nov 15 22:57:00 Incog systemd[1]: Started Bluetooth service.
>> Nov 15 22:57:00 Incog bluetoothd[617]: Starting SDP server
>> Nov 15 22:57:00 Incog bluetoothd[617]: Bluetooth management interface
>> 1.23 initialized
>>
>>   * The output of |lspci|​ is attached below . 
>>
>>   * The logs for |journalctl -b|​ for both v6.13.1 and v6.13.2 are
>>     attached below. 
>>
>>
>> Regards,
>> IncogCyberpunk
>>
> 
> 
> 


