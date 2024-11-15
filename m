Return-Path: <stable+bounces-93541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718F9CDE8B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81011F23609
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231A1BE854;
	Fri, 15 Nov 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kSt/YHR/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FE1BBBFD;
	Fri, 15 Nov 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674618; cv=none; b=oPfm4nTPpXHr5LFJuv10G44x7PfVKL1dNefD+fvnMTEoLw4nPUTixwUheQz6ksu7Yld6PdY0ZlpO3xXJmxc9OCavtSpoWijJAeTjEvxL0daXMKkWg+KnylEgUpSf8MVnc5chnzdwtQ9NhDxF/77XE9q0eO2dezrHg85d7ccdoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674618; c=relaxed/simple;
	bh=0PETfD8Gl8AoTwKr0t+EAaEZMLvWbcQI3PxMj1nls9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQZh1b/o2OBzkpdRahxVwVbTeEMbwUWdb5Ik/RsSH/xGsCmFfvFRv/skSIROVMjyqqjN6ZtzPioOP3CZSApNm8xZ159ngsxDV55RDTmaahPr4fW8IWLfdILBOyBGfMiEXiMQHlC0I7H4pv+ZWMCLFJyRnJKmEtvieuWx2ESn9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kSt/YHR/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso19033135e9.0;
        Fri, 15 Nov 2024 04:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731674615; x=1732279415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqMsKbA3dO+XdOuLGY0q9rDIGWmP/bu1+ik2oz85mMg=;
        b=kSt/YHR/SX54jmyfeZib8bnsUkdftSbZwZ+bwKU47L5MW6YeG1lcPkhiYowYpFPR7O
         d9XuQ4k8YEs77kjqFHxYfXzwKiHyqC057E2XYt7+sRzUdxfMGYk2+uXHiGfQ3kCdWcdg
         VuJMurg9pC+ecLr3dVbBtpL69RscjGc8p+6NK1MCw8SryAEnG6EvtmjtqfjbRNO9HAtl
         rWl/H0/l8aLPr3NNLSqcEpld5bRSub2fgQE0h4NP2HVo3dbUTXBIlQtEOfmFsOh3Eg4O
         CBmDjCVpGRdRKqh06ReklpCRGcNNOiQ7E/XXcENT3kIU0LiNWCzIX1rxtTFQvliygjyn
         zUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731674615; x=1732279415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqMsKbA3dO+XdOuLGY0q9rDIGWmP/bu1+ik2oz85mMg=;
        b=OB8jvBpgFsvbch0tlb5XAyiGYLrNR6wmSKGhzkmeA8xGEok2t6kMV5rnYKBWuf+IO9
         rCpvIDItAryFpO+ybe1kjyCCwR8gIQrkrV2LhAMzmTGoyuKbXnoo6JqaPU1EOc62iRYa
         Pqa9ebQE3ZTsGjiVqld0pXtlVLNLU+isV3umFArV2tY68OAxhYksLFxE4ttgYsBkU47S
         0coy/UrgqtoV3l1BgZ1T9aUHBMW036ZOtWEwF9Urk6w+/duxAKCalOCwzr90NyyKzJsE
         0Qgvbrks4lKJrAvJYJn9zSxHfJiiATDW677eqps9zfwdGkGN4NlScwX3djFP918hJTfD
         Xz+w==
X-Forwarded-Encrypted: i=1; AJvYcCW6Jrskq7giS77fKHFoj6+f6+Gc8RLzloPpwFUKj4qpVy4bA1OytPifiOZ9Uw8UaAlC4k29qwT0@vger.kernel.org, AJvYcCWwEN5sk81xSlsIJsHxC/OwTNWUar7gBacgIS66TkBMWXgupwacw/b3onPpdzPsJR2s1waQHDi3Vmd5R84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAIAkgyCGSsr+jAo24bo/GsqtVWW1HFaQtNFMs+G1ERdiHnC0G
	JULIyFNlbHyEHbXpDUXc1ZyFP3wHUROe95gaQGsF1+wGLX8rN1I=
X-Google-Smtp-Source: AGHT+IGjlp03I3khXnqVs9FPoaf2f8iNImWPpfJ7NhaswXhDzLo+Yga//Gzs/rvT23hsD3zoJemriA==
X-Received: by 2002:a05:600c:1387:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-432df742662mr23592635e9.11.1731674615048;
        Fri, 15 Nov 2024 04:43:35 -0800 (PST)
Received: from [192.168.1.3] (p5b05792c.dip0.t-ipconnect.de. [91.5.121.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe73sm56168855e9.20.2024.11.15.04.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 04:43:33 -0800 (PST)
Message-ID: <45105775-41e5-4600-8197-642a31ae8e17@googlemail.com>
Date: Fri, 15 Nov 2024 13:43:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/39] 6.1.118-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063722.599985562@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.11.2024 um 07:38 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.118 release.
> There are 39 patches in this series, all will be posted as a response
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

