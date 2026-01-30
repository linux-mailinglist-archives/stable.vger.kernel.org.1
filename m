Return-Path: <stable+bounces-212885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM/uD8i+fGlVOgIAu9opvQ
	(envelope-from <stable+bounces-212885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:23:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8952BB8BD
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 15:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F20A300D72B
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093527AC31;
	Fri, 30 Jan 2026 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te3j7la4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="soIQf2bQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2A1F09AD
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782981; cv=none; b=a0Ktn0t9VVjkbZnN0rjvdbUI2HmvRJuVTW/fQAgj+pKx6KsY22EHiQbIYjZIy4/4jJwqmzR+c85w66jhSN7JKUj60NIkiGLQEw4o5zdge+NCsV6DyIx+9SrcjPb8qRVnlaIDxcL+mIZK6wR4ItXIXoa9QA/htSWrntOq1LlJ160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782981; c=relaxed/simple;
	bh=RSNCX2GpKcXAieaD94LQrInlDlBOtYks76IuyEEMjNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqAJrpDGGOqXudV3z03QY6vYu8O/kE39kc/GwMNqjiFSqWnCljv5MfE5NK61rBttTr/tdxEIGsop9QmxL8m6T+0h28ds9r3HomVlBuUGLNqaRPRNVxQaiORjpb+ZBpO/RHLo9n092NycfmykFFKH5bCwy14x8XE4/EUQyaU97bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te3j7la4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=soIQf2bQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769782978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NysZYs1wcrqLDG0t5h0GSF4MeXnnFrjLy628r+9XtI=;
	b=Te3j7la4sbAhgDcwOta08JFmzWlQnqdO3CBFBrC/FQCoRiL1ciw7YZTUDmHtF55ZsSX0/y
	aVGaT4DxitZ0wsDMcXsKsyOuAvec2KiAJFCjas5VQVgLo/9qL4NlOQcsoJ04Cq55HoFDs0
	Tz0udLrExv6fP//VSOKHTs3rQDXyX+c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-yKQUQdiXOMSZpMaC4C8Eeg-1; Fri, 30 Jan 2026 09:22:57 -0500
X-MC-Unique: yKQUQdiXOMSZpMaC4C8Eeg-1
X-Mimecast-MFC-AGG-ID: yKQUQdiXOMSZpMaC4C8Eeg_1769782976
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso9444575e9.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769782976; x=1770387776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NysZYs1wcrqLDG0t5h0GSF4MeXnnFrjLy628r+9XtI=;
        b=soIQf2bQMmY2wAA3gQ+a5IDpvmi5tcKn6Ktk4nK4a1fQSEALMbxW1XF3EJZIliZNrN
         PHkLkoUG33bpQ6bMnen6jNbIQ4IgRaFIjApM9o4FmH6ceaW8OQd/XljyBIpNf9LVmct9
         iBDyFRlBa01RLv+Ww+mkqOgqv2O95F0nm7RM4qFvxQR2xu75GwR2YgUCNO4JiyzdXynZ
         R3bYAx91+E31OY5UnaL1ZweavLRmYHcL0r43zeTQtvKz1tHjxwDLn66KdlsLulmJIGcv
         wJxq87UWvB+qroZDTO3ptTguWWkEIWSlanLTXB0OUsAAZiDnxPVwNkvzct7R8CV5LEB0
         Gptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769782976; x=1770387776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NysZYs1wcrqLDG0t5h0GSF4MeXnnFrjLy628r+9XtI=;
        b=tr72I1gpZ8P3SyLIwtV7Gsg02OioB5IJGpzQlENbtXRbqZBUDty/N9P24zfvbpCLXl
         IHS4K7EwjddfgTrbI86fIgCgIP7ird34VyBUY1VelQkMBVfOHBqWpmkzdVNJvcPvol5/
         /3I8oZ+3bQ9L+yn6zvzDA0szdhpN0o3XXHv9VYY+ybgzfiwP1jRlSKBay6ocYa2/kuM0
         52/bTVns4Af10gjIGtnL9iRUrcVwzqbMjvynO0o0UOM+lstJuA0L24ruc+ZqFRGjWWOM
         tSe5HXXeHWT0h1C5cFasZtSyPhPmM4+XY7FQhiIkcxiL7MVxX5Sj+kTN3PToKTTeVBtg
         teng==
X-Forwarded-Encrypted: i=1; AJvYcCU4X+revF/2K6e6coK2pyPId4ahgGFW03oi7HlnuuJjbzSb37S2j+EIfNnjxA6N+BeKiqOn6dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkD1uyLPNiYck34ASF6vVBoU+jxTXtbmIqY6KppHzOONBD+2yz
	qHc52ZRItyxDYktNm9ioNkoEgYkEiy6yDjCQXTNEPaAC7gSc1MIZziNXOQzHFJDWFwfQz04o1F6
	7cSeZ6oG5ACAgKIy6/jNPOzuL/oq3QPAtai9eemQecMh3pMpgDCoEZSx92/1JlgHMlQ==
X-Gm-Gg: AZuq6aJLdaAhhcRUnkEWN0PjgZAuvGeV0HPpM4FXAmTxwtyitgc26vd7QtA8iMzg7K0
	k9tJGCy7iwFHFHyEXim32fRMUJNPTeyNMN1U27p5DuNSv+4aAAetH8KkIwf2bxIXIUUQ5a+IjEf
	OR/WiTziDXHIketvViXJB27g9bfOCfHll6uR9NREVMNsWd7JB4cIFC91tQztJ6EhFk+rnLibG1S
	tD3H2bOrzMZOp5ZRuC4Y5txboUfHJVJCri9hwcbZ7kKmGldO2Ua0P8gbipnhOogRPcuTc8rXbRp
	HbWCAqG/+wUXkhIVhLteJzfe+9pORrfWxTOsiFgLLbbX1KqWZXdHh+WkCKnB99nCDvtYLi27l1x
	3t2nRne9WXRp5TJcMXBd8aiZc+xBiVoAoibe6Nr1eJ+bkkiBZ4w==
X-Received: by 2002:a05:600c:3e15:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-482db48c76dmr38136345e9.18.1769782976052;
        Fri, 30 Jan 2026 06:22:56 -0800 (PST)
X-Received: by 2002:a05:600c:3e15:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-482db48c76dmr38135955e9.18.1769782975646;
        Fri, 30 Jan 2026 06:22:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf4asm23441310f8f.28.2026.01.30.06.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:22:54 -0800 (PST)
Message-ID: <85edc1c4-1985-48d0-9ece-50a5c70e1752@redhat.com>
Date: Fri, 30 Jan 2026 15:22:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: sleep instead of busy wait for BMC
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Jacob Keller <jacob.e.keller@intel.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: Pasi Vaananen <pvaanane@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260128-jk-mgag200-fix-bad-udelay-v1-1-db02e04c343d@intel.com>
 <338ff7cf-1c7d-48da-b1b8-37aac440fed0@suse.de>
 <88f33e4e-5d0e-4520-a399-5be2901a3281@intel.com>
 <27af79a8-ee84-4845-a737-82d3883536e7@redhat.com>
 <8d238204-b0f6-48a7-9afc-480097c32a23@suse.de>
 <770785c9-266b-4ebb-a0a1-f5e615e45855@redhat.com>
 <4272ae94-902e-40dc-86ce-62b642fa9656@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <4272ae94-902e-40dc-86ce-62b642fa9656@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212885-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[60hz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8952BB8BD
X-Rspamd-Action: no action

On 30/01/2026 15:03, Thomas Zimmermann wrote:
> Hi,
> 
> I don't understand this.
> 
> Am 30.01.26 um 14:27 schrieb Jocelyn Falempe:
>> Hi,
>>
>> To take some measurement, I've put this instead of step 3a of 
>> mgag200_bmc_stop_scanout()
>>
>> for (i = 0; i < 100000; i++) {
>>     WREG8(DAC_INDEX, MGA1064_SPAREREG);
>>     tmp = RREG8(DAC_DATA);
>>     pr_info("MGA Sparereg %02x\n", tmp);
>>     udelay(10);
>> }
>> return;
> 
> What do you actually measure? The loop in 3a is supposed to end as soon 
> as bit 0x1 signals that the hsync is active.
> 
> Are you sure that the pr_info() doesn't interfere with the loop? This is 
> a tight loop to catch the bit when it flips. Putting that pr_info() 
> there in the loop can take plenty of time.

I just read continuously the SPAREREG register, just after step 2.

So I take 100000 measurement, every 10us, which should take 1s, but take 
1,2s in practice, probably due to pr_info(), and reading MGA register, 
but that's not relevant.

> 
> 
> 
>>
>> It's called at boot at
>> [   45.110616] MGA STOP SCANOUT
>> [   45.110631] MGA Sparereg 84
>> it oscillates between 80, 81, 82, 83, 84 for ~4310us
>> [   45.114941] MGA Sparereg 81
>> then stays at 81 for ~227ms
>> [   45.342492] MGA Sparereg 81
>> [   45.342504] MGA Sparereg 80
>> and stays at 80 for 1136ms, until the end of the loop.
>> [   46.356152] MGA Sparereg 80
>>
>> Then it's called a few time when my display go blank and each time a 
>> different behavior is seen
>>
>> [  729.448040] MGA STOP SCANOUT
>> [  729.448055] MGA Sparereg 80
>> it oscillates between 80, 81, 82, 83, 84 for ~39258us
>> [  729.487313] MGA Sparereg 81
>> then stays at 81 for ~230ms
>> [  729.717349] MGA Sparereg 81
>> [  729.717363] MGA Sparereg 80
>> then back to 80
>>
>> This one is strange, it stays at 0x81 for 1191ms
>> [  838.307042] MGA STOP SCANOUT
>> [  838.307055] MGA Sparereg 81
>> [  839.498450] MGA Sparereg 81
>>
>> And the last one, this time it stays at 0x80 for 1235ms
>>
>> [ 4318.439032] MGA STOP SCANOUT
>> [ 4318.439047] MGA Sparereg 80
>> [ 4319.674140] MGA Sparereg 80
>>
>> So my conclusion, is that the bit 2 is almost never seen when polling 
>> at 10us, so there is no chance to see it if polling at 1000us like 
>> it's done by the driver. So the step 3b won't work at all on my setup.
> 
> 
> 
>>
>> But even the bit 1 can stay set or unset for more than 1s, so it looks 
>> very unreliable to rely on it, at least on this hardware.
> 
> Did you connect to the BMC virtual display while performing the test?

I didn't configure the remote interface on this machine. But this code 
is still run and should work in this case.

> 
> 
>>
>> I feel like doing a msleep(300) is probably the best bet.
>> If you still trust the hardware, maybe it should wait for ~100us, then 
>> check the bit 1 and wait until it goes back to 0.
> 
> Here's an example calculation: with 1920x1080@60Hz, there are 1125 lines 
> overall. So
> 
>    (1,000,000 usec/sec / 60 Hz) / 1125 lines ~= 14.8 usec / line.
> 
> There are 2200 pixels on each scanline. So
> 
>    (1 - (1920 pixels / 2200 pixels) ) * 14.8 usec / line ~= 1.88 usec
> 
> This is roughly the time that the CRTC spends in each scanline's blank 
> area and likely the upper bound for the duration of a single polling 
> with that display mode. Otherwise, we might miss the blank.
> 
> Honestly, I'd just take the proposed patch as it is and not bother any 
> further. I think this is the correct fix unless we can figure out the 
> exact meaning of these bits and the BMC.

I'm fine with that too. At least on my machine, this waits for a random 
amount of time, and that looks to work.
> 
> If anything, we could try to reduce the polling time to 1 usec and 
> reduce the number of iterations to 50. This would give us 3 scanlines to 
> catch the bit.
> 
> 
> Best regards
> Thomas
> 
> 
>>
>> You can find below the raw dmesg (I just removed the lines where the 
>> value is equal to the previous and next line, to make it smaller).
>>
> 


