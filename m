Return-Path: <stable+bounces-15491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF39A838A1D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9DEB22000
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24958124;
	Tue, 23 Jan 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvVb5kLp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B556B78
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001548; cv=none; b=X/3bYNTkWfwqoZ8cJf37FH1GqIlfX7GtnWHOExCr29GYgiR8bG+Zq8dIPF/srgInl7RyuS59R1n2+ZPxpmuwZ1bK5WjUhjpkUnHt4l204tx2x4fz/cLZbX06GDdkSbMIQLL8+pItpfmVTWF+RIms7L58wxbS+QRDG8AfRhsKxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001548; c=relaxed/simple;
	bh=7VuZmFxUpB1lVSDCAJTO+tJjNkrL3UwBXwDgvhvIjBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8I8HSVfQkK3s23mN5TaMLTB+GJZrqHcSOSCco5S2yfzaf00fBIZCQiVAGq+Lc2qwNI8E5Fn1R1gCk5+9dTYvDwuYHNFLNM9jUBbLjIMgxrNd3z0dKm9CnAuOcmV+l4YIT0+dcbW4LtwrL429tzmOlJMvzzgrhLqkOTVaSpO97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvVb5kLp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2e0be86878so938918066b.1
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706001545; x=1706606345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBk1RWkyZJiPgH1O/EL2UlH0Vp2cg0BsBTQsF+HbtdY=;
        b=AvVb5kLpa7bQpUu8u3+EZWYenD5vl0HJmedi2gfxDt5hYLL1mMFtJHO+4IDVAlrNfx
         Wcf4BKal5v9Dm1YT3YN4kso37uLomn/ojBJuR2gm2EeMdo1sn3I2uZ7lQ9XHEWJwXkex
         8MiLyFH0Y8z/dlwUxnnlB+PWfkj8BvaZgWsLmTRknvUbGu4fISElxIZceZJa8d4NpGL0
         AWrVKIJSTof/kbSFi8XnPr2wAYSTc5wQIqI5khhwOLgLCVUIKjH5IrNZytwjDNhpNrUO
         8ZW+SytOgbE6lyUYw0XYUnSqKUsdWpVfm7Ef9TP6H/bLfvDbsDk6IPPhmcuvO3qnaB59
         xAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001545; x=1706606345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBk1RWkyZJiPgH1O/EL2UlH0Vp2cg0BsBTQsF+HbtdY=;
        b=Wcz7/pKAO3NyCpeXxWbqQUjYx5fc/RsmHZTZo3r1wpz+kNOJqfswgKqW7fLEu7iI5Z
         pZXIAt/vXAU+5L7xlPOBV85NL2+PVnDh39rKmM0AStgNVAaZ4J4gGMX+SHI2EvaPRo6g
         8fIQnRRodmLtMpXNtlEqcPbdU/3lKRUv8DfMuGE1aFZIUGRX4+LAGFo+1x252FlOU1tL
         hzrsXo9Ev9/U/gcGlg41dpfExlGPCkW+9kMaag1nQXDcPmkANvRn48e9Wpvb0+iVI21E
         XdUh8PR82xMmvJ1qGdv6GB73RmVEmOSySWuo1J0NGjEuISmko2fMHYfN9Pglb5YZTaaH
         yzRA==
X-Gm-Message-State: AOJu0YxRWC99aXmXYlRnzX6vsLkt87gz9FmFEmJthF6QFL3e6mx7pm0p
	GTDUJ3sNyoBSwys/1VqVxwStPx92TXqYjsn7iX7b5CfXHAdbue76
X-Google-Smtp-Source: AGHT+IHRUTpVvFWRf1iwvev0Rm6Uh+KZ4ise7148syZG/xVFOrpQRNim4YJA769VELvuqY15kf+c3w==
X-Received: by 2002:a17:906:8925:b0:a2a:c113:2677 with SMTP id fr37-20020a170906892500b00a2ac1132677mr4955188ejc.61.1706001545141;
        Tue, 23 Jan 2024 01:19:05 -0800 (PST)
Received: from ?IPV6:2a02:908:1980:b9c0::6a53? ([2a02:908:1980:b9c0::6a53])
        by smtp.gmail.com with ESMTPSA id tl9-20020a170907c30900b00a30461c31efsm2068398ejc.177.2024.01.23.01.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:19:04 -0800 (PST)
Message-ID: <98e5bf78-a85f-44c1-8277-20d90d6093b7@gmail.com>
Date: Tue, 23 Jan 2024 10:19:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add a quirk for Yamaha YIT-W12TX transmitter
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, stable@vger.kernel.org,
 Julian Sikorski <belegdol+github@gmail.com>
References: <20240123084935.2745-1-belegdol+github@gmail.com>
 <87msswmn3g.wl-tiwai@suse.de>
From: Julian Sikorski <belegdol@gmail.com>
In-Reply-To: <87msswmn3g.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 23.01.24 um 10:10 schrieb Takashi Iwai:
> On Tue, 23 Jan 2024 09:49:35 +0100,
> Julian Sikorski wrote:
>>
>> The device fails to initialize otherwise, giving the following error:
>> [ 3676.671641] usb 2-1.1: 1:1: cannot get freq at ep 0x1
>>
>> Signed-off-by: Julian Sikorski <belegdol+github@gmail.com>
> 
> Thanks, I applied now.
> 
> But at the next time, try to check the following:
> 
> - Use a proper subject prefix; each subsystem has an own one, and this
>    case would be "ALSA: usb-audio: Add a quirk..."
> 
> - Use the same mail address for both author and sign-off
>    
> - Put Cc-to-stable in the patch description instead of actually
>    sending to it now
> 
> 
> Takashi
Thank you and apologies for the mistakes. I will try to do better next time.

Best regards,
Julian

