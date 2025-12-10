Return-Path: <stable+bounces-200725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3624CB2F70
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E32323007CB7
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD901322C88;
	Wed, 10 Dec 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P+xaTPXI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE243233EA
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765371666; cv=none; b=ivLbgEhMVb807knQMAj2fcpzEzsTTsXZ53A5Ex8OkYQJGdx07V/TWEjmnHezeHBhowCnRp/wYSOmFld3CXmW5ic7y6HEQjUT6GQ+mUXmDb+vFbyuMqgBR7y/kvrtm1MWJ/6IrzTjKFpBmyNr+8PsmsjjgfWft9OKhMX9uqu8mes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765371666; c=relaxed/simple;
	bh=tM0crvOF6uQketKzGcUzJt/x2RnQeslVhRYwL8mMcbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcceBq2ldXJvmBEoWslw38MwINjSPN9GlSz4SnOFVNJJgi6pT73QS/yFdyZPDHqgpeIWXOGMSEMkEANiWiUyOKLAaniYAP8NFYY+l1Cy7lJ7vrp2GFvdP+wu+55sFEr4Ya20Zem25rY8IlKXc/ItIrKe4UZENo3wEoecLPViD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P+xaTPXI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso4663704f8f.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1765371662; x=1765976462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCS7GfOmrSOsGr4lczglaWgYwldA9XAo/9uCFN01sH0=;
        b=P+xaTPXIvYrHkII/AQeN61xDXddGgdJdXKJpmsGUdEJuQ2Ir716lrNshI5Nt0HLvPN
         yfVDyjWtCIAhqEtzOCz4a49+xVLVReblMiX7YMAwNwTZbxgGoXvMLEDZ2s534sENdpOg
         0wRujClsEftHe9G7GgY2vSPNev8FrFKRWyDlv5yVNB/ZDjcE9XlLMiKRdEil/Ax6lvjx
         ovPe706w4fjhuFN5V4BHB41sXQc54KmaYOFzQ+gC5lmdGZZulJ0i/KHEixn2vgIWQLqq
         S68OG2x46YObXQXvDpA9x3+MZzgeP1ClWs5c8LxVyp/C4T6gSixT/greCamlz7GE4mzg
         TKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765371662; x=1765976462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCS7GfOmrSOsGr4lczglaWgYwldA9XAo/9uCFN01sH0=;
        b=m6KwkXNc5xWTPfkWHR2NZVG4rSbdx3akNxOImmvvB2/lKYuy26yrm+e7EvzH3/Ro0o
         RtUWbJYC4TLSVu121dlUgOJBOMyMVcAwh/O87MAFMS0khcFHtAZOEezcOlmwqmskcozv
         NEZQY5UabBrPVdMNgnoKOrMeijUYugc6s3hcS1MO+NR8vEjXiF36bRTz0YO78HxwgNfe
         ecnYVp5BHVazK4MTz0+AO5QWBHBTGr5e2TfXRE1mQXQ1s6FSqNlicZ6sNCdaNWmyoFPr
         6A9erMKP8o/Hl4wAsjfK2bNE/0Qu/1xDlD7NXdcDpWr4Uc88gZoRdQKxjd3T6f5mE1N1
         Y86Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+cN8KNGfnl56IYuBJuhdRKiw5O187bQyydiRoKWrZndt4q+csgfXrl6dVWBKlLN72kAjZ63w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGP6nz6SPK+q2wiBMTVBZToKAHRfz3Ta7fSoyz6r6/mMVw4eFU
	iRrAAI3R+1PmydoSShO8z2+cJvtmKscOKvByAnypDE6FiqEu1sSGEhw=
X-Gm-Gg: AY/fxX7kFABAoAQ8VhpRz2uYwzQK0a9HNepZcFeZ4oIgcCIlWxjhrXYNjUPuqeeRLAs
	ifOIUdQgyrI432QlAOnYKQUlN26D7m32wNBuSbw3V096bXzEW7+r1o51MRuAOFMYboKtSpKAUbR
	x7OFjbek6x6J4BByB+Xy7vQ8MnjQVV/0GGEU7BTKHluZVXGyCXqGOAw1g9NffEvbE4qZYHvjnsE
	4JmBUczRzGXWup97hVYqGDE673A/9wnAhM0btcUZEU0dNX9D9NAWWg225w1m5qzTK0utYoZ9kcu
	uYtSBqduSXg1rUVJtRb/d5DCDTn3nORqatXupY1nlE4SzgS12GchH0sdzIuH7cyYSIU803mW/db
	AExFSDJeqi8Z4g17O8kIyCDc8zPMMnslqWhG+M0+ZnQMNgjzp5kJqgohnjtgge4N3tZVIkz8YF0
	rCW09zsuUoQhfMPW8V3s0hCAWmjlWJN/5nI0x4q8O+iiQToe1VJudEWI3SKBeWq3fIKOKPWlQN
X-Google-Smtp-Source: AGHT+IFrrlOJCf/V+kYb4fnZRVhRfhFsQIZpmeJrt4yqinm/F5tOB/5end4jHdvM3o6gcosjwWJVcA==
X-Received: by 2002:a05:6000:1845:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42fa3b0512bmr2424961f8f.48.1765371662193;
        Wed, 10 Dec 2025 05:01:02 -0800 (PST)
Received: from [192.168.1.3] (p5b2b444c.dip0.t-ipconnect.de. [91.43.68.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90fdsm36302032f8f.3.2025.12.10.05.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 05:01:00 -0800 (PST)
Message-ID: <0e096eed-ae29-462d-9bb2-60c14b7e40c2@googlemail.com>
Date: Wed, 10 Dec 2025 14:00:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/60] 6.17.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251210072947.850479903@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.12.2025 um 08:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.12 release.
> There are 60 patches in this series, all will be posted as a response
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

