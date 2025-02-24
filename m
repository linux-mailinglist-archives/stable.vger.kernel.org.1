Return-Path: <stable+bounces-119420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC38A42EEE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 22:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C44189DFD2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C61DC988;
	Mon, 24 Feb 2025 21:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rd55fAqS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA31D7E42;
	Mon, 24 Feb 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431966; cv=none; b=KkCX/wHsFfoTHsif0P3wFYyAMk1Jb/EXFGrx67vOUvbqx/jKDvrM2H2lQeF6zRs8eiPOdiVJz30wLH3yjxZd4InNkuba4GvN+UTMaBnhizoKPecbaJeKCPdcEbk58rpja/ukBZmQDKH56/jaehRnY+rdV9viy7XQQWC62spoo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431966; c=relaxed/simple;
	bh=YoEVxQm7GUNB/Pace/xv1ua8aa3MZ5wuQD3jL7sthmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuOUiO60S6iUWAr2eqH3iri3B72SUPz+e3le3mgwevjkcc5pF1WSFQ0JG1AbTZvDQpI6M4VOIPr5erbNE36Q57AQgNimVW4k6uNuaro/KuXCAzz2UKJIbUv5/B87XWQPDzS1exzmiHj/pBUm0aH/E2BwHoFhCMyJXrDY86QkjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Rd55fAqS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so2419631f8f.0;
        Mon, 24 Feb 2025 13:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740431963; x=1741036763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpeO2CI36Azm6aM6kCOPxfPUs3dzzjFPJf88qBzpQcg=;
        b=Rd55fAqSNJ4lxCeUg8wOhHhdTaLqBpdfQ71vyjLVW92O8X0WBnboP3XJKDwOmvYNI1
         WbJ0BKCPA2JUALL54LECPRDK7pk/g+9yFQk9wsht1TD0oJz+gi+e7EdLDn1jIAmJOMFq
         E8GTe/xWR2fopiB34sCEpMTXkxPg4EssaZQYJsa4mieWxcbkEUaNIedeiDmfwwAhUCHf
         EqyCrhNQ5kB15YenQHGwVMPVNhC3Wn338cKio01uaJep9ySlg/LOEc4Qa/Tythxt5h+t
         hf+dvE8p5c8WGFffTJeRdek8qnWGmuH35thGeHqtA/RlU10+b2oSY9Xzl6CxPQlR6xge
         wsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431963; x=1741036763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpeO2CI36Azm6aM6kCOPxfPUs3dzzjFPJf88qBzpQcg=;
        b=ddN+NgXKwvP3L9d08XdB40OOl12ysM/2D2egvHFmlJS5FuHnwLHeS1njPTbWmTIgnA
         1dXBcCPYAPsnwuBkk/rxyRp8DloJEH/5P9dFzK/4uaerbiL8kWRNBwJFXdY/w1dqNT/f
         mq7hCEuAJEKSTareEs+B9MnOksYWznC31sIgtrd+/3MXP315vUL1MGKUkdsHvBfDkcQC
         9skOTA5pRUp0voEd9HVwt8EX1diya/zbLCT5vQa2mQDhlHeFbz2G3Dcvozwz2bjZVogS
         qRmTkzokmFps5XSc1R25szjJFUc0loOn7jPf2vpUGCFiqtEAXmDUiluAGFpZYa0iHH13
         dqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnMTZvC5On/4FRGdoJf+I5IyQKr4QdSE5Ghf6GAsDSgsX/D5Wgw2DWhEKUQlGYQJf4VzlMTyeU@vger.kernel.org, AJvYcCWz8YKvWA1KOnR8Ow4RwPTbd9i9LW7D47rUPqYJvDBLNPLgwupm5uliQ5ycmlUJ/MhECut3cQRohuUO/NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoBUbPsbsdIzCCiGb92+MpOSwRSGBwDRMy3clgCTQv2bL4WqhY
	1D5R6HOzNdvQzBvB5qzneM+vuVUK8Gu/gwc0ZP10nzy0XB9K2q0=
X-Gm-Gg: ASbGncvH3eKvcpI7UU9lnL5NKg8WCCaX2msDYTkbImNpOauu1MIB3hZU6pOvwZs48VX
	G71iCPVK59iiCtGwITPtr11+YvYFpQkMBQD7BdPmk8xjXm6FZOZz+o/kJXRwN8LFe83RvytUQdS
	xZ2nFDdexPuviRzvZJJfKvuU5oLIZbv1wDz/2pFcpJ7sTXEZTCcNYU1IthiSE7priq/tMvZX/iD
	vsY1aDe9Gjc4wm4q7teN3oyyUxYJEOsmfcaHYzhJ5/W+g8S1pWY2EKcxniaQf7kJvnZm+QvA6Uz
	R1XZYQqrgxj43OGL559zTU0/ELg9h18ZZgKYWaqJnjmP6FmisDRG4rglnszJqnOMMhMnNcJZIlH
	ktpI=
X-Google-Smtp-Source: AGHT+IEYsevmMEoA+JE6owr4Lom17EkYScyptZxEaM2HX68zip8SRSjflN6YB00vNtpaXesHEnqkKg==
X-Received: by 2002:a5d:6d08:0:b0:38f:4531:3989 with SMTP id ffacd0b85a97d-38f7085e028mr12832430f8f.51.1740431963449;
        Mon, 24 Feb 2025 13:19:23 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4180.dip0.t-ipconnect.de. [91.43.65.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866af3sm154293f8f.2.2025.02.24.13.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 13:19:22 -0800 (PST)
Message-ID: <304185a2-5cd5-44b1-a098-3e193b433657@googlemail.com>
Date: Mon, 24 Feb 2025 22:19:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250224142604.442289573@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.02.2025 um 15:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 138 patches in this series, all will be posted as a response
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

