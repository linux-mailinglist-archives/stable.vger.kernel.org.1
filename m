Return-Path: <stable+bounces-58945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB76092C55B
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 23:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD48B2195E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF8182A5B;
	Tue,  9 Jul 2024 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IpEKGhbS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B6F1B86D4;
	Tue,  9 Jul 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560920; cv=none; b=c9WAZ3GCXEp3xhwNBZOmKKmzy5Qk5+qHFjfwQRQof8j2Th4+AwG9qwuR1UcWbX0nrAQAuMy95DuI3oQ0Fv1TzQ62TXHsG/NGqgjIuZV6F8Xdy7yDs5zdKqHMCWt7q6+UzdsCtuWbAqRccgYum+EHRZ51WJK7R8cMjhdF667KtTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560920; c=relaxed/simple;
	bh=ZetbC7TE4JO9QBtAGo9CeTU1BeEzOd/4ss6yzko0CUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxpA8rtHs839LL6VCr8CjXJsE7CszkEIumUqywagG2qQacm34Uy/HV1DLeqzMw1d3B6HLjpJq7pshB8iYJx1fGQ3BOmqBI6pgxBANofgWCRhDPO1HrTGPYLnvkn16ZtAVRu4eWOr+Dsg5O/Ish9qnNhm1bQTFIUvNTcl6ne5vQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IpEKGhbS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42579b60af1so39075915e9.2;
        Tue, 09 Jul 2024 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720560917; x=1721165717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3M5Fvu/U+spfWTBwhlOd4QQV8BmMooOznPRXHtmfW+s=;
        b=IpEKGhbS+3kiU/tnoHydH9iK/n3H5CZUnKkGnLe7s10RD8i1gbUKqcJs3Cg6q8Sqx0
         a6N8kVY8H/dAwcUkxXOeWy7puyUYvNkpYNjlM05xFtCH8quc2eKdV4TH6crEyxQaxxRs
         vOuB3THOJiRK6FWuNaLs5e4wD4jx7OxAoz6m0ptT2QQEN+6YynRQUwAesi3wkBgaQIZC
         jQyvIP24oaK8F2/G66J0Gm7HhTAxF4hDdDaxBW5LmZk68HMroI1W5459ep391K1EVCF9
         JqpB4Ru4mlarPzXRFXFE/ztPH/NJGTQ9vvkwdrrPgKQsJu9rltZQt8HaMMw4rSy1jGme
         tqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560917; x=1721165717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M5Fvu/U+spfWTBwhlOd4QQV8BmMooOznPRXHtmfW+s=;
        b=QHZvegiqoFDyn2Olf97E3MgZXbja4uLv0yoU8w5x8DuMcntHXaDw9qCRmlDW8sifWI
         xnH1TeUiLuSs076KHWuoI+idftFmhkUXlBRt2zJPQHpFnX0Muh5nYi02W7fgqN1BoC4S
         v9+KRd/IQabCUd/u4JIJTb2x0MaXLfoGcHp83YrZpSM9VMmuX6e7EjHZa74AeeiZC9cQ
         kFZ9nARf1/G8wjzEaP/aJhmBA+45+THuqxRf3ui6byjlKJDW7yfamIqv9MyeKGX9+yR3
         2e+5TrtM8tFzL2E0WWfl2uRQywoTqYEhn9MdSsSyc9PZ0Cl0fayyi4AJm5217M8+Mawu
         1rwA==
X-Forwarded-Encrypted: i=1; AJvYcCW8/v+BcFLAcRiFvowoMeqznMFOC1/mB++vqbXR11RYpltVo03xjP3OPmnPcSq1doxvQB4LvaMrgMR2D6sTLQVxz/5pkNJkHgnvazYRT+7SwNOGJC5AD0EyyPFJYhchb73vWifv
X-Gm-Message-State: AOJu0Yw+F3hMs47Mk9UGf0+aWYAg+0lgbei3oJVnKNWcI/Tbw2YSR+7r
	xac5cps+AUSR79HtLehod3h9ElGpL5YiPQ0/hUaoPx7Xy9/+VDU=
X-Google-Smtp-Source: AGHT+IG1hi5P+S1pSgVCL9mWAifazaPt5ItydrKvszdcF+cs4/YQ4T1bNJv67r/1jRKKNpKhwuhk/w==
X-Received: by 2002:a7b:ca4b:0:b0:426:6c7a:3a61 with SMTP id 5b1f17b1804b1-426707cf194mr22888825e9.3.1720560916890;
        Tue, 09 Jul 2024 14:35:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b0577f1.dip0.t-ipconnect.de. [91.5.119.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d165bsm223537125e9.4.2024.07.09.14.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 14:35:16 -0700 (PDT)
Message-ID: <07de625c-c504-4e12-830e-1f68e923aacc@googlemail.com>
Date: Tue, 9 Jul 2024 23:35:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110658.146853929@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.07.2024 um 13:08 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found. It ran for an hour now, and I built 6.9.9-rc1 
with it, which I will boot-test next.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

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

