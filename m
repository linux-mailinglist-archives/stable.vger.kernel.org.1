Return-Path: <stable+bounces-188893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE47BBFA182
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C6A4845B9
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F501684B0;
	Wed, 22 Oct 2025 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QZUxdIDR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64ED2ECEBB
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111738; cv=none; b=kBjo3/roqecvkOsVE6R9A76WTuw9dNTHNjLE1JRfKneME0seN9XrOUsPnHc1KR5/+GyChKRtt4vfbsPyrUdADxI6dHfeLkDxFrNAYCSdWdbB3iQMhTtLKOMjC/rLMU3ahMUzpFKZQBgBUr34vAGOv8RxgENbaZ55gNthBG/RLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111738; c=relaxed/simple;
	bh=vTHlocwSFWTfO8hSt0cIUru6ReNW+tNVoaM5Ls9YdeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6CbET3yPn9L+NggtWhrqGgrzygI7sOIVGVZ3M0R+PkN9cnKQ13z+fRqSA/xx1WQFgqumpLMQIlZyndpguWsPF+saOKkq+RE1z9EBzo68G4A/20Kjf4JhEFhWZ0UN04EEH+0/BLCqUkbte8PfFEARULwsFp4L1zB0sy3DHsZZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QZUxdIDR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471b80b994bso46539765e9.3
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761111735; x=1761716535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoA1WWVRov6H7a5xUEiwI5O5mAdzyiICIeuaq5U1Y4A=;
        b=QZUxdIDRKyBWdL8qADFPJagSpXphCxoCMUjM09z6bHEfBblkZ35Fs+HZgyZ2laCZ4f
         L0p/X3EYZcaEpmwIhMb3lVrt0sQhj0mH4dB6u4lruWakLWDe7CtJ91nJ71KrOvFr2RlE
         7q4URvrvpiYVpVDPgys7xA6TNRKGKmXd1qJzZrpPocPAfQ0bDXe+swi1imU82ClrFUO2
         SyFJ84mE9TfarUhbCeqeySzkAvimRZ4K9BpEsBD7nH0HaxyAtYltZ7+0oNR9rcUH9AIl
         9S4ss3gSXWWmrDtjcaVq7sG8SwpPK2lWbHHBM8mvdszdTW7uGAWAP6qq2SJpkmHrDDQ6
         KZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111735; x=1761716535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoA1WWVRov6H7a5xUEiwI5O5mAdzyiICIeuaq5U1Y4A=;
        b=QBYTNeAYdnv+64W64QZoGxmQgGjnA/YYDeWmqwSGBF3SlcLWko80jAdNq1K/yNjzeo
         wLUsxoH9lU4uOehdrQcq66rfu2EZyz225mv0GUZl8hRFLZ+82F7001NtE8G9Hz4AVWL3
         qTHdTYYp2pBRlXJjuewNObddgQoJM5lnimskwM5WLp/yA7W63XXsoJiZLNkUJdqDWQhz
         zWDSytBBkuvN5danhrIoN9ATg2/VAJCVfv1mF++ojhqIiX217bfP8NdhNDXQMjXG7XsA
         5yt/VQWqtO8jikp6ht4Cele6696sns0RzM+reU35/E4oi48+q73+PcaV1gzwmnEm+RSV
         WVEw==
X-Forwarded-Encrypted: i=1; AJvYcCVaeeCOxKaK8UER8MHsmExtoFcQ+3Mf616SHiicNRG4R3jxdT1+ezJ3XAhz9i2oQBSLuRLAWDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIV/dj9gI1F+quKpjkYnjzHbjMDynV6mJozdqh1z96+TCZ21A
	FvXj2WHhdfo0a7zyeh2n3bl6j5nPbtWk+jCdFMb7jU0ES56/vkvS3/E=
X-Gm-Gg: ASbGncv4bjX5GkqFutkYn1r+UGHk31oQTPFzJxDD5YCaEFRJYJEWKjlFlSDKl3ZNfl4
	Niwr8Re3Dgw+pasN5FHL5pQfLX3JCh4DGVfcXl23joaNXvdedNT6hX9TMBhZwF6DBjHGnJ88HYI
	8gmUTxn++ZJYZwyETESdLEEXrTofVQSrNVSpQQ8TumKuDVRAFi080lD3zeuYQPKIYHetunX02xi
	SJGj+Q0RlJP/ZEttWykFkn3JNdrJjYfZ5JhCKwSWdVlH8OQF5QpyFGpojcQmXVFtxalFfqCKhee
	HZ4fIpM9K/uPq79POgEqSXUgJWQNEUa59xS5j07f4IGgkgTuk3ESTgaG6GPlVeyMuOCeAht/h84
	vUBdamW4Tj/uPviYEy6Dru57lTQAOROZe1d6P0pAVUiwcZdNbkpRxMMd5ZtKJtsHjxVP6cPSbli
	MmOnhWR9+ZVr0gVfban4akvsvBGEfmu/p1LT6PlGYVXP23t17XDHbE8oO2Dm+MLg==
X-Google-Smtp-Source: AGHT+IGWLldgO9eeUo0uqFHesf5QkUIf3hAgpxI4olpESlwkKLLpF1ZgmVauywZSpSoCic9nLf2kJg==
X-Received: by 2002:a05:600c:470d:b0:471:7c8:ddf7 with SMTP id 5b1f17b1804b1-471178a7447mr126370715e9.14.1761111734829;
        Tue, 21 Oct 2025 22:42:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496bf7137sm30354195e9.3.2025.10.21.22.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:42:14 -0700 (PDT)
Message-ID: <7015844a-7eca-469c-9115-b84183a94154@googlemail.com>
Date: Wed, 22 Oct 2025 07:42:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 020/136] drm/ast: Blank with VGACR17 sync enable,
 always clear VGACRB6 sync off
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Nick Bowler <nbowler@draconx.ca>, Douglas Anderson <dianders@chromium.org>,
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 dri-devel@lists.freedesktop.org
References: <20251021195035.953989698@linuxfoundation.org>
 <20251021195036.457336682@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251021195036.457336682@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

Am 21.10.2025 um 21:50 schrieb Greg Kroah-Hartman:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Thomas Zimmermann <tzimmermann@suse.de>
> 
> commit 6f719373b943a955fee6fc2012aed207b65e2854 upstream.
> 
> Blank the display by disabling sync pulses with VGACR17<7>. Unblank
> by reenabling them. This VGA setting should be supported by all Aspeed
> hardware.

This patch breaks VGA output on my machine. I have already reported this regression against mainline 6.18-rc2, see here:

https://lore.kernel.org/all/a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com/

When I revert this patch from 6.12.55-rc1, the issue goes away, just as in mainline. I'm still going to test 6.17.5-rc1 
too and report back, but I guess it will be just the same.


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

