Return-Path: <stable+bounces-154564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BACADDB41
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388103AFD7C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD64277C86;
	Tue, 17 Jun 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAbd4Gsi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247F2EBBB8;
	Tue, 17 Jun 2025 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184554; cv=none; b=CkLwMcFgyY71AzOXcFg1j73u0G2pjvvh6mrPKXhG4CTJFuc6LpdQzzJ+CrnPH0lum7tKJpw7IL14CPfP9obIu63/kwVLf/ppYCWNsaXSbgzTWvVoBO60GU4eepeIl0pETtn4ZmqbCE+LV3eWsSTCKjr5A9mDVaGK1VTel6IhX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184554; c=relaxed/simple;
	bh=rRATALdhRcn5DZSQIwnUYb/BCKnqu3gR4V6mBlBkB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSnMXdvi/QctW6cvmTgwj0h0txJP4fYFP5RDNLt6g8BQ6JqHdk1a5CZCxP9C0MLRhhHIVXV/JU4HzF6ETaSvFzfI965dtwm0uTPHzzUS5APV17hBCxviaF7C5gtAsUtNo1RCSh8o9jlOdW+uU8DpKu9KP9IsxnZwjmAsY3KK6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAbd4Gsi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso4843651a12.2;
        Tue, 17 Jun 2025 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750184551; x=1750789351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6+6yUoMuq5S3gjE0GRLY4LeWHot5xsTS/R1ypehyGnM=;
        b=JAbd4GsiSBQ9JWgO17KJsjYqwEccruT0sr3YZt3De4JJXayv587TF6ebwzloy+mpd/
         Fl2ZHzxtNc3Q2HKJ0ARKl8tNcR40PrkmC9PuA7FoP+CaIHELoR+hbeTdK/BLzes5vZhX
         lgtzKfatwykOH8lszdPtlU7lM6gllgukCvMm6TJWds4eDB+AYFfSeQ4bR8Z/CrfeEmHh
         lbQiJP2RiT8sKN1DhsiO7h1h8SqUXb+YP2pYJDnheyolTOOfGRqLUkL15FS1Rfzxv4rH
         NyuF30gAekJ4F9XT4ppQYGnIX9ug0WBSxKCclKM83ClXLI7NXgkZKUOCd4Tg7+qROUOS
         ohiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184551; x=1750789351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6yUoMuq5S3gjE0GRLY4LeWHot5xsTS/R1ypehyGnM=;
        b=ZZeKhIw3crjxGKQ+qmmc1tMwZcVDIpwPZyDs6iWSuOonCBptDvv505w57rSXA817XW
         uvr3zoB99k/HPfZhKXblP9BLr0RVpMngdYY2zya1QwZdhVLTsH0m9Utb31+tXksx6NiH
         Sb3bRbKhHmGMnco/j4F5ruCZrm7U0c3HTgWx3BERZhPUMKevMKX0YSoSxleFaFadSwt/
         UFTPljeaja3GloZtC66A8gywNrx1gF1jsKoua88oznbxHyL3Sk9LYhonsc/d/4U35VGi
         N7QcqE3VcOJCVFH1ZFm6mMZpBEYWO7o9g/84PSXGU1GwP3k0KpJtkwHxtlJXTvHTU8sR
         2ykA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2BSfxcWUZ1ef6z1jit9K2H9by5cBUu3n5rSum2Pmlif25qEgIp9nc45U214ta3mp7sOj9Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAp1bi/jJTIppOQqbeLB+8iD8AhX+novrkgx8djo3B111JPZY
	a8BPgia98KON4IQ7ltgRH6Na2fqiwBqiYPhuIox7L0/M77ToyzAeEHc6peWxNN7y
X-Gm-Gg: ASbGncvqhIvJqzcQCjMBSL67ufj4M6ae4UtRyjX7LhWJoDJTYNuT21G5RqWiVlLMqMb
	L8Og9mTaf987T1rhZPnPolnRxfO+jbSTXFiiZLDMjsgeM3Ee7X/VWtxesoaWJcAo92WZfRtwMmq
	hm3OEtwB78RzM1YnkiJGmseETQOFVIv50Fd22BjPaCiYwQ4pCwe3nFaqHv5aXx2zh1wjPrRhHHO
	k6KYbgdxHLJkBctsAyUCZXdTnEmO7D9IHGOFp7fEzUPMZmW0H7Gn2Mfkcow8K1ByEceiUGSuiQl
	YVzw4TR/H6JSi8HU/3dLYxYAhqChPZyupFV/GFai+UoKjJCaz6MrgpKL4WG+pUXjkWMpBNr1U0N
	cMm5U5F1geXMLeA==
X-Google-Smtp-Source: AGHT+IFgrqJZVVHc6CZw1rbCUX7xXW7mFmdlAjjsynjIlFhhsOoP42hQdJ3kJ8yMNpcaIKSWoIt3mA==
X-Received: by 2002:a05:6a21:9010:b0:215:d9fc:382e with SMTP id adf61e73a8af0-21fbd4dd9fdmr21722887637.13.1750184551147;
        Tue, 17 Jun 2025 11:22:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe168d7ecsm9247635a12.64.2025.06.17.11.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 11:22:30 -0700 (PDT)
Message-ID: <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
Date: Tue, 17 Jun 2025 11:22:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tulip 21142 panic on physical link disconnect
To: Greg Chandler <chandleg@wizardsworks.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(please no top posting)

On 6/17/25 11:19, Greg Chandler wrote:
> 
> Hmm...  I'm wondering if that means it's an alpha-only issue then, which 
> would make this a much larger headache than it already is.
> Also thank you for checking, I appreciate you taking the time.
> 
> I assume the those interfaces actually work right? (simple ping over 
> that interface would be enough)  I posted in a subsequent message that 
> mine do not appear to at all.

Oh yeah, they work just fine:

udhcpc: broadcasting discover
[   19.197697] net eth0: Setting full-duplex based on MII#1 link partner 
capability of cde1

# ping -c 1 192.168.254.123
PING 192.168.254.123 (192.168.254.123): 56 data bytes
64 bytes from 192.168.254.123: seq=0 ttl=64 time=2.902 ms

--- 192.168.254.123 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 2.902/2.902/2.902 ms

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.03  sec  39.6 MBytes  33.1 Mbits/sec    0            sender
[  5]   0.00-10.07  sec  39.8 MBytes  33.1 Mbits/sec 
receiver


> 
> My next step is to build that driver as a module, and see if it changes 
> anything (I'm doubting it will).
> Then after that go dig up a different adapter, and see if it's the 
> network stack or the driver.
> 
> I've been hard pressed over the last week to get a lot of diagnosing time.

Let me know if I can run experiments, I can load any kernel version on 
this Cobalt Qube2 meaning that bisections are possible.

Good luck!
-- 
Florian

