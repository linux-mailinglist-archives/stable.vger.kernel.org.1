Return-Path: <stable+bounces-191944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91CC2641A
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1918034E9E1
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B6301465;
	Fri, 31 Oct 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dZj8Clx0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B03002C1
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929977; cv=none; b=rOISxWAVI+d4L0UYYIEMTlDOcdqSl5ysDBpoVgIIOoTPqakyIYnWFOeKaXAhWLDsSFJ3mS8n+X4HJGeLADJoRvTbaFkdlSe2RUmZzkyVO1HqqR06vKv7ezEBWxX0zaqrh0nhxbBSZxoWypRsZ3fJkbctKoZL2E3j4jGI5SDrB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929977; c=relaxed/simple;
	bh=XI5am4bqxEKpCCxr6YrL1WsbvZOn6blYwPCQvxM3vME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKYuJP4bo8np5N9sNAITlV7/DwrAwN3ltBra3Zhf9kF5DCoNCQIYul/g4MQuRGCNjkOeid3TAv4kWWhqF9Ay9NlgeKLx6qUZlW/wc3Bo6k7hkcwCGuB68dvA/pG/ZYXnv7/qWPp2zkat73LtGcBK52Wucn89iHEuuCeflogfS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dZj8Clx0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so537888466b.3
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761929974; x=1762534774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32M06fDmvpSLGWpWm1+m+xurNqSGXRw6Z8ERXRqrdTk=;
        b=dZj8Clx0PTctBVytYUWfRfWKgqGFv7CwLhZ2CdIu8dPV5P+uOhXkxdJ4HiWUfzw7D5
         qHlzAexzEhbypxUQj/+lB9XdxPe1W4kbG9OH30aFEJkwbWI1kJwa84rKxNiY9Z1kgbe9
         eTjDJrZzfTaP+c6KmxXXgH3mxxlu70gXwJ5g5RIKuzWKN2Chmrzjmm4EL73Blw7wLEKv
         myUPmRQtXqArC2RlvtXlhvq6ZtsU9Xakb6bBfUp8a6m+lbF0aS4e6j/3NlKuC+woJk9E
         CkjkdJmPnjy6yVk/mJ/rQgSyao+tPZVWQjYxBjkkvtw9ZSwYqHuMzAroHE6hMUZyPKQa
         iqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929974; x=1762534774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32M06fDmvpSLGWpWm1+m+xurNqSGXRw6Z8ERXRqrdTk=;
        b=hLYo/Ye9y7Demter9+78T1SShwc3l6I6VvTs6142nWq/IUEfvCCBJGr0RytOMsK7kK
         Y7v23Crf5WKWwfADRPDZZ8s31IWtVo6IG0IoWfZWvyPgQ9N3NZRoQuwAHhsKUgoUynLW
         AhKDIgq35A1DNADFQES3OovcRwkcVpPjLMJVWNuimeQoZu9PU0kL6+yHCnZo+VfPeMgB
         MwMzDuQ7y28MRp7sX1WaFb3vejGbOkDzSf1a2Cm+cGJLW3PYkZGExP95M14l+Mz88sPe
         HLN0UbNlFJZ8B5LQtpEFyFDp7HF0AJZwAccsKEei0aJJQeRbAjurJcjXe8emubbLitXS
         bKug==
X-Forwarded-Encrypted: i=1; AJvYcCVxjRSQD/DDQeDWJuEpRM6t4ryyqR8jGo/HIz8AKUpl/PUT8VGyg0UiKtjPORyQOndEQExp6T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/fxN0LfaEhPZBtIFFyZbg0yQrwaAU35x6Dxe4fPs8S4MzbqJ
	ILyaoTgfoDZDL0JhsNw+GlpTfNQJZku99LoqQ2hUY3Gc20yh0/sjqJo=
X-Gm-Gg: ASbGncvMEdNFbST+xX0BANB/GSSXbo/Glf0JtU8RRUTkjume1kqFEGjPZNVR3aIpbbP
	byxJJU7Sl/D10LOlAj1kfySjvkxM4LlgRWmaE7SNTnnu4uGoJfo7pkV4+bbjokZHkl/xp/fmFUt
	o3rxYSnKOOKFyDZUoXHcbjb8wlcd4RDJyRQ2VbrwDQy6FY+U7N30oT4T+amQhlG9ZMOm/aduSmQ
	ypaAL1+HrAWiVW0qBVZl+s5OnFYGk79JRGaaaL6pcAiW9a+RzwvASWO/m4suK/rOkUT1hrAxQec
	PeE1pJHz5oayomou5wwR2UEStXOe4RoudsvURwnmSj1qYLnEtMu6V+Md2u4Sy4woA6wOMHEIptv
	CygQPVLJdBPcpjulB5lNabB9PcravMuyhmRAFRNweO3sim7RXadm8N18LcOHLOB/9n7Mcx294n9
	xm78z2Vi6Ccl/lEyRc2z7C1cHDwsFRalXdgj+/AV8OghWNsG3nHx21OQ==
X-Google-Smtp-Source: AGHT+IH5ejgtCc6m1hWIm0s3g5GB4B2IveCV86RV0S8OrlIVBxKrpwlcb7RP0l7Qo7hx09ed6gvYOQ==
X-Received: by 2002:a17:907:96a7:b0:b3c:a161:6843 with SMTP id a640c23a62f3a-b70701067eemr413992466b.4.1761929973967;
        Fri, 31 Oct 2025 09:59:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3bb.dip0.t-ipconnect.de. [91.42.195.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779762bcsm226476666b.15.2025.10.31.09.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:59:33 -0700 (PDT)
Message-ID: <afb00dbe-7d8f-4fc6-a735-6ece2c12dcd1@googlemail.com>
Date: Fri, 31 Oct 2025 17:59:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.564670400@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.10.2025 um 15:01 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

