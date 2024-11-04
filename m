Return-Path: <stable+bounces-89707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA879BB7AD
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC88285250
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9118595F;
	Mon,  4 Nov 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wue59/qY"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFC178CDE
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730337; cv=none; b=BYRZIpgs1B/JFrCJ0YZVammouVwTrELxGLYbGSIWRRCR1GtlPkScTfN+de0n1fI4y8XbELrP+ZFlLs8k2AK2hxzLJG0ihF0inbLbWkVrWoFUuMOtzzMgF4ylPDyZt8LE7ssA1kWkGCPC7fIyIIkMksQEC47r2as1M+NtQZTa9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730337; c=relaxed/simple;
	bh=3d4DcxhoRFU1jfPBuOL51gzs7SAFahe/Gt5ZXJAylPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyktoWe6227WhKvE2TGyVVKnVRfZqZBQZlV8zOBY6C/V7qQzz91iB5oorJqkxlxTL+gQt72nbXxNgLo3MhbYQ6dIAofySjonF+9fWASZCMIZWEK/WJc0HVwpF9Bs5BCTN0gqnXdkTXmzdFukarby0zypk3dUyYxuQM5TKbMIWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wue59/qY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OrVCh3d8J09VhprTj1HmsplkajLcHY5tTARFV+ARm7c=; b=Wue59/qYJZl9oeLnljX9IvaFkS
	TFgem5Dyhi0tPeU3PZdMDUqHdHB6ltNgpwmz22Nc1dHW55mAe6+nPCz6ubDRKvE8wuWEHGh22ORCq
	ZEBc8nnubVHspmaTSLErXv0/v5YnL9vBA4YXdw/J4yowhS1x2aPoC/qhcoNpUy7Dv6kUQez/DXygZ
	nPPqenh6ArXj8jAiRqeu9umCpqiDtpOkqSO/LQ554tB+t6Ez+6pFDUPZtZ7NtHT6ORISbjQ4/IiJD
	mJ3fEACO4ELnz7YfBT0XXAwilXbtTfdGg60Gu+U1P1aKo1Q2OItPuVjQTZS6B0Pboy99GZHIUnmjN
	Fd7gfz3Q==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t7y1C-001afi-9f; Mon, 04 Nov 2024 15:25:22 +0100
Message-ID: <fd36621e-b6a4-78d1-34b4-832c16eb2a05@igalia.com>
Date: Mon, 4 Nov 2024 11:25:14 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1.y / 6.6.y 0/4] Backport fix(es) for dummy_hcd transfer
 rate
Content-Language: en-US
To: Andrey Konovalov <andreyknvl@gmail.com>, sashal@kernel.org,
 stern@rowland.harvard.edu
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sylv@sylv.io,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
 <CA+fCnZdM2rjzJf7COAjDLvW6S0dDaSpPKgZfMvXXQ4i2_HL+Nw@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CA+fCnZdM2rjzJf7COAjDLvW6S0dDaSpPKgZfMvXXQ4i2_HL+Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/11/2024 22:29, Andrey Konovalov wrote:
> On Sun, Nov 3, 2024 at 3:28 AM Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>>
>> Hi folks, here is a series with some fixes for dummy_hcd. First of all,
>> the reasoning behind it.
>>
>> Syzkaller report [0] shows a hung task on uevent_show, and despite it was
>> fixed with a patch on drivers/base (a race between drivers shutdown and
>> uevent_show), another issue remains: a problem with Realtek emulated wifi
>> device [1]. While working the fix ([1]), we noticed that if it is
>> applied to recent kernels, all fine. But in v6.1.y and v6.6.y for example,
>> it didn't solve entirely the issue, and after some debugging, it was
>> narrowed to dummy_hcd transfer rates being waaay slower in such stable
>> versions.
>>
>> The reason of such slowness is well-described in the first 2 patches of
>> this backport, but the thing is that these patches introduced subtle issues
>> as well, fixed in the other 2 patches. Hence, I decided to backport all of
>> them for the 2 latest LTS kernels.
>>
>> Maybe this is not a good idea - I don't see a strong con, but who's
>> better to judge the benefits vs the risks than the patch authors,
>> reviewers, and the USB maintainer?! So, I've CCed Alan, Andrey, Greg and
>> Marcello here, and I thank you all in advance for reviews on this. And
>> my apologies for bothering you with the emails, I hope this is a simple
>> "OK, makes sense" or "Nah, doesn't worth it" situation =)
> 
> Sounds good to me, thank you!
> 

Thanks a bunch to all of you folks! For the reviews and the suggestion
about the commit-ids. I've always sent patches to stable this way, be it
a backport or even a cherry-pick, but it's interesting and definitely
easier to just mention the IDs and ask for merge - thanks for the
suggestion, I'll do that in case of future clean cherry-picks =)

Cheers,


Guilherme

