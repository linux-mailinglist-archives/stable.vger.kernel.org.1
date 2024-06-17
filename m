Return-Path: <stable+bounces-52564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6F90B601
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 18:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831AE1C22EBD
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28593D68;
	Mon, 17 Jun 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JMXHsfBj"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11A179BD;
	Mon, 17 Jun 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640852; cv=none; b=RyRqT8oa66z9mVNkTxdvAMTwhtjnYV1C4EoNvHzVgqz2rVxWepCZeo3xzZK44BEXcbp1V7fN3Z2aFKf1EDvSi7BQr/WWyAi2BVM/fEF8dMZFO+Poh6yhnmSLCgEiOIfqA19dbzGwudvG9SEdh5g1Gbu/nvHo3xE8pXjCm5FMVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640852; c=relaxed/simple;
	bh=/mymfvncDmk5Blm0pWeKHkMjdqFJN8aXQAKCaPiQ1TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJMQw6t2LYk9fuwWX1muu5hOgJ93g0Xl5OWq/bU5kIC4xezaqcL2JbB3SEryxpmOiaNXAwkVmBCmqt+lTUT7Wovc+keZLERbDCE4rp5DgTf7pN4ygeIA8sGVYP0HpADsHUcn6e1DKsMkRFNqrHdQNfXdAPe1fH4JhnU59tHndNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JMXHsfBj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=HO0XThImftWEZTH21r6ldikbaH/ZfnqxG0vFPhEyEP8=;
	t=1718640850; x=1719072850; b=JMXHsfBj+XvaMhTn+FRdTzLTBhrlWihBA3iTN+K4zSTEfhM
	PpA55VEkyBkr1jjZuDQ5yS9lwizd5UfGK8upWCacSzjbtSSYRV1nlDElecvOS2pwjfGgGEU6M0j63
	M7MvmADIqqclr2kvpGTs4PHxIbCNpBO0/BHLseo9gcNNJZEwoUSP78YO8Hvz8jF3Qc5TN+SblZonE
	1d8BEEkylFRZFKQp/GZgwyU7cosVPHuhNPNgGv06OTaD/d2Ajnz6KrPRuP5s+XM2t+CyMg9Enbf1k
	JCDt2kkaV5yts1ADl9f5zUEtwatcXPnrTAKxJaVRaw9Cn5D/VIeEr5usX4I/HQBQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJEzZ-0006Ar-9O; Mon, 17 Jun 2024 18:14:01 +0200
Message-ID: <bb96d22d-250f-4d5d-9c21-c2568d37b27b@leemhuis.info>
Date: Mon, 17 Jun 2024 18:14:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Xinput Controllers No Longer Working
To: Edward Wawrzynski <ewawrzynski16@gmail.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
References: <CABRw72orHLEqpAS=cW1ThGkVUW0juqc7Y_-N2=o-k0rSqgpLxA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABRw72orHLEqpAS=cW1ThGkVUW0juqc7Y_-N2=o-k0rSqgpLxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718640850;4bae447a;
X-HE-SMSGID: 1sJEzZ-0006Ar-9O

[to anyone that replies to this: please drop the stable mailing list
from CC, as this sounds like a mainline regressin]

Hi Edward! Thx for your report

On 17.06.24 17:37, Edward Wawrzynski wrote:
> 
> I was reaching out to report that there's been a regression in the
> latest stable 6.9.4 kernel. I'm using Fedora 40 and 6.9.4 just got
> pushed to the repos recently. Upon updating, my wired USB Xinput
> controllers no longer get detected.
> 
> I've tried two 8BitDo controllers, the one being the 8BitDo Pro 2
> Bluetooth (with a USB cable) and the other being the 8BitDo Pro 2
> Wired Controller for Xbox. Neither of them are being detected on
> Kernel 6.9.4, despite previously working throughout the lifetime of
> Fedora 40's 6.8.x kernel versions, the latest being 6.8.11. I've also
> tried the vanilla kernel, as well as the latest vanilla mainline
> kernel from Fedora's COPR: 6.10.0-0.rc4.337.vanilla.fc40.x86_64.
>
> To reproduce, simply load Kernel 6.9.4+

That sounds a lot like it is a mainline regression that was introduced
between 6.8.y and 6.9;

> and plug a USB controller in
> with XInput (either an Xbox controller or something else that emulates
> one). It won't be detected. I plugged in a PS5 controller and it
> worked, but when I plugged in an Xbox Series S controller, it didn't
> work. The 8BitDo Pro 2 Bluetooth controller has four different
> settings (Switch, Android, DirectInput, Xinput), and it was detected
> and worked on every setting except for the Xinput setting. Reverting
> to version 6.8.11 fixes the issues immediately.

Could you please share the output of "journalctl --dmesg --output=short"
for both a working and a broken kernel?

Ciao, Thorsten

