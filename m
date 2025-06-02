Return-Path: <stable+bounces-150623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F018ACBB35
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01F21757DA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956AE1990D8;
	Mon,  2 Jun 2025 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Sl9D9LRC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB481426C;
	Mon,  2 Jun 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889985; cv=none; b=ACdrcDTh0hwfMxF63JqXSnzh0TpM/9iQYkqRU60VLlrJOjQM4fpzKdshYRzoHOOBb5Xqg2NMCEthuoUCXYXk8I2iuwfjbt2mDGX0rfr0DrI2ikRn7/FPkZkIpzWeTW2mxV7hPgA8ZkC4ZnfMDMv+O5X+qrhTcxemxAjFP598uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889985; c=relaxed/simple;
	bh=t7PWQIROnj9O2Qd2473xwHXz1p4C86Pcz4bK/Kwvu5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9OUh3AvAMxum3XZjY3/VcqqOetI1f99epIlBlq7E2qVT0/bLocaZuBtQM/lwWX1/71ap46ebkInvplJsYCOchEPy7MkdZzdEeBDKHHreRLu3vTna6JIjoD140Zos4I05lumuXO0XchN82Un9oHrKalRW/KRNu656xRlWhjo69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Sl9D9LRC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso29094905e9.2;
        Mon, 02 Jun 2025 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748889982; x=1749494782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQgE/th7Y6NmSXgegzh7ifR88rjm7OtqqOUWoV4+ZsE=;
        b=Sl9D9LRClXNBLsyGWKwuZKW3ejEqD9QRD3nN2/31sQje2ytpOiC+7o9JUV8weptya9
         zs2npqKMLZf3FXn2HDB7db8jD+ysgdzCEvAt1p/3kcZn7kNj1X14dja4H7H9HBWO3MdH
         XNSj9+HGynSe3cFDRj65Xjx2oMcsVtbS8RbzVnhCPpzZawmSFLbMy9sVXREwRIHur84E
         7RvPGXaETnqEjrEAmZUQfRKgajp9nwU3NJrEb0jzizbxEAIM+OjCw9ujjqPDDEXv6DVM
         bDL/gGu4WY2hpaNR81fR3QWvbV1zo67emu2FEeEbmCGtBeiNp/rcUYob5IgmYuVwEGF7
         JyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889982; x=1749494782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQgE/th7Y6NmSXgegzh7ifR88rjm7OtqqOUWoV4+ZsE=;
        b=WCyA/CByp7btLDJwnSmMHEWjyudNUBEROxpYm7uYS/Oot/NYRBBTyvnhuMENVW/ji+
         GQdjUgouuZUGR7/ngXfB8Htyis2uxhzvW5LfPE7etjPfyuqc+TUT7wUtwIo6xlRyoX1M
         84r/kqWUM+0mAWuhc3CA64sRcThF3vsZtFBN3kmpn0u5s5YJ4gfUrtQ1wDU76i6k48AN
         etd85CO45pJcjjaicM5n917JFT/ayqXA7Y9IRrxqkf14S4IISz7xUbCXpPBbd+TaudxW
         T5ADlReo6ba2XM7X+3G14sUjluJgajGhcTOL6QsKUrba8aonxjyUnZ3JFUTBAd/V30gS
         pGBg==
X-Forwarded-Encrypted: i=1; AJvYcCWFwMkLG0hCu0yzu8EqE24gn/I9gWZjl6wgkhuLzcQNS1lvXs/mLUpd2IvP6oipgJFKJJ55yZGLHPWfST0=@vger.kernel.org, AJvYcCXGnOxjhXpk9izGgus4YKpR5d2pjC9frCuJpUJJjkxjRTlbvhiBccSee8MEv9G0QWSq359j6weA@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUU+5Cxg7nkW4ZUZm3NUnVfohHLTMocBKoKtiTHeYJCnFMXTX
	Qc9/H5R/ibCXcAHRiMw3z23UQoz50jCx96PMvPV+EmbLh5PLDHZ+LHU=
X-Gm-Gg: ASbGncsJED9tV8UaBDj3U5NS0q+Pob7u1JrRB9q+4fZuOHfCoYU/T4qhPicpyGJIIQQ
	AvUpdAB8pNBlot1NrLKWD7nkhPQ8wBojGM+BPRHo1ttaLWMzTxH6WAzLqbPmjBORNUnfmY1KhHy
	j90PYyNkZ/JmodfC0faOKIGrn0QDrGnFTbGyRht63BifTWrXA6Ahs2z9eXmA8NoKma6m5sMSRra
	yFFtD13cm35vpGVOMilWezz9VZKzOuSIQQI5RdaEizkQEvaDXfTLIMXokSn01evuCJ/kVnNhnk3
	kgrhCGs7wl5pB2Fqk8ICCXDIhZLCz/JTgEFEPd30dIDEtORjG8lRorTm+zo9bph5uHSPdF5TSHm
	leGkeSlqlrzk36PxtLyMStb7vnTM3K43AgN0DnzKQmwKfC5E0
X-Google-Smtp-Source: AGHT+IHJw1q7LezGoIk9SASABKd0sGNN76oputOfkAU4vVCaSWWo33UrhTOa7JcV5gOvreKvCke50g==
X-Received: by 2002:a05:600c:3542:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-450d64366a0mr153427605e9.0.1748889981690;
        Mon, 02 Jun 2025 11:46:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b057d53.dip0.t-ipconnect.de. [91.5.125.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c738sm15366037f8f.24.2025.06.02.11.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:46:21 -0700 (PDT)
Message-ID: <6117e660-bcba-4767-ae98-60c71e422169@googlemail.com>
Date: Mon, 2 Jun 2025 20:46:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 00/73] 6.14.10-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250602134241.673490006@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.06.2025 um 15:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.10 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

