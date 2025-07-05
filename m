Return-Path: <stable+bounces-160239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34845AF9DAB
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 04:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747A117340B
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 02:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD941BF58;
	Sat,  5 Jul 2025 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f5+eK0kz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589F187332;
	Sat,  5 Jul 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751681312; cv=none; b=hEzm3QQGL4cc2mvTN6Hlorg1V5w0+aLCHFTUjopVFTg3xoWCCQJQxOo58rLGV7nogBm6NURHidVrvIFfKkhnHS0x/Iq7DkgRzEvKulz0f4hIm/5mPFTs4/MKWGv2F4Og0sjFWeuS64xcxIfgInfl6UxrPASap/dJ+mBJlVlDA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751681312; c=relaxed/simple;
	bh=be28xlpM98yPXvlNlJIYFuxj2Hb+eIwDL7/S1B/jd9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AInVyhacZYzEnwDqHQPDFECVRQkRGZ7JiUD5iWAKdNU9ehPcMs9GCqvsQ5XXZyxpMJ2LRLjOEgoDEf/8Xzlr02VCL0HPX+15ZOHUk+YAubKe9zUb3v1tvs8eVWzRDiVx3O6qeNZf1sDT/RqVDg8l3LL/fK1jNREAiBSAn1EAEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=f5+eK0kz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45310223677so9550115e9.0;
        Fri, 04 Jul 2025 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1751681309; x=1752286109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGhOYIGfUjYOXxzUn04JCpCy8svnXrhg1yJxR9dK8Ko=;
        b=f5+eK0kzAa45dirPDwXv/nkMocTXfYzHSAfzMWM8Yq1VvyMHbTOh2cGRc2IoO6nJqf
         amhZMQyIvnASGHfBaDc6Bw6tB69zFiSC5u6IfbRBxMQaPV4ifjJQLRdIJa9eX7XpQ9f2
         Uw33KpQv0cHm2FhQZhp7XWptHHBiEJZ73EsNyCSNrmGqcb15z9pV2Dzv9IY196cjS5Dc
         4BJB7SmreAj47/PWA4QXefGwoXn4MiRV+QfUZNJM2uOP0Xv5cuAfH3dC1Qyammcb45eR
         C9GLApvT89uomtq8RdI9byW2Sg04n5J+zT4O21vRT0i3nfe4TGlTQFmI1y16LyoJGPSD
         5ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751681309; x=1752286109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGhOYIGfUjYOXxzUn04JCpCy8svnXrhg1yJxR9dK8Ko=;
        b=iJHkH+BeWs4kHJs7Xmh8rCupAXnni4qaHxRXvBX8oh2N5te2cgTD31XKqqvfrfsRsK
         cWfLJU1AJLYurKuf8GcQ3Rfk6G2Rsj6aK/F0egdHLyBZq45K3WVgsO+nxSaukLrUYnv5
         O/IDM3akmJx3EA4Gh5IMDWElfBMxTlMXIqupFuJ4oyocc6phor5optyGq0ibGzBeoSZ3
         5tgLnFdR1M8evmo9U9Ku3qQM4pdrH8WO+hoTkw5uJEPEM0Oo8Gyn+0xF6xQNO9hAvpXq
         xz2l81F63cE0WM6JrDfnMgxl8SRoTNzpOVDZSkB3HnsRElkHE5qLU1KWP96XUssIX7L4
         I34g==
X-Forwarded-Encrypted: i=1; AJvYcCVXzyjarzSWsG7/XuvSG/rSsdcRgFaCTQG526FwQUU1htc/e79s656PjW57j2TWdjuHF68+/paw@vger.kernel.org, AJvYcCVg5sd6wkoR/cYNTIAIePFnvr8yNmGOXqqrFcVyCiugoBDaUoVbTlJW9I/rAdu+gQ8xuMQr3g4mGMWK2ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkENh1oZDUZlj9zLnSXSLsIE1FQPlwIHL4Del6uKKEvG27QHTY
	3PFCBogzrqxDdN0v2dggJM9lBliy1zBuwSTGoPpiJo3sZGEqTWuBjVI=
X-Gm-Gg: ASbGnctajHAequCeMbk+CdHQO6kJfooTPKkn91CODmhhiKHpHKY5PYrXLaj6eYXPJyV
	WZTPknl15sX+HCB2azjhXglU18GAnkejA3mB8wpD5sPnV5OiSvj1Paw+ZEo0MkLyPgTlqyw5oSK
	CzsciZziIB81MthU9JN+AkT0unQlbOlgZC40ZUHx3IKYew7nU+anMZV0HIzdKHRHpufPVoDwvm0
	Rcf/uQVcC151m7kCAtOBojj/Y5ep75rTj/LF4/rIX45tMAdw7EmkoyRuxQy/lOeG11MiqeU1GF8
	CJsSCLJkl1zJMy5H0eWoDjtTgy7X/8LNbMG5CFlWD4GDgAwWhSngiz9CFgHADh3WpcYDhrjckDp
	wcJgma749bJiQFS4RtxFEu7t0+9DuZxamZN2Z2Gw=
X-Google-Smtp-Source: AGHT+IEbwwUIxygLV+74Mmp1gwA1h8iRo/H3pyAhARXfAbRofPKW0H3SBzS/dGS+OguVGTTf2uf8sg==
X-Received: by 2002:a05:600c:8b0d:b0:441:b19c:96fe with SMTP id 5b1f17b1804b1-454b4e79652mr48274335e9.10.1751681308843;
        Fri, 04 Jul 2025 19:08:28 -0700 (PDT)
Received: from [192.168.1.3] (p5b0570c7.dip0.t-ipconnect.de. [91.5.112.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bcef22sm71166965e9.19.2025.07.04.19.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 19:08:28 -0700 (PDT)
Message-ID: <2d467b17-ef4e-4473-8d95-80217fcb6ab7@googlemail.com>
Date: Sat, 5 Jul 2025 04:08:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/132] 6.1.143-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250703143939.370927276@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.07.2025 um 16:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.143 release.
> There are 132 patches in this series, all will be posted as a response
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

