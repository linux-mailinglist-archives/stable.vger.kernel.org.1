Return-Path: <stable+bounces-187810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B847BBEC673
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F74E9BBE
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E8D284669;
	Sat, 18 Oct 2025 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kWjym4rI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423527702D
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760758005; cv=none; b=QTItAHhidDLamtGU+IXUkVDlsRlyE8rePefJxIBwZhtz8vXt7hmPDFdASmec4MTjASC80i5Hc5QxZJOtW0NZbltsTPAOZv0Sgo/K3UgYzfie9VS4wdSYnziwTrPYJd1mfcvVuG22/4VtXaxDp/z1HBx2h0CEfAZnKfC6BSfxfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760758005; c=relaxed/simple;
	bh=9Vz6go/WSSET7hZHq91e2bf2IiJVDYooRd3SM+ixwzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYouln6OPEWAto0WD+0L3OYdsx6C8on6urLIoKm6dag1MUakdlvDMUbH5qH1qmnbjRgdYy3fb7tMF1Aj3B9t1YiRpZM440ADrxn56yqvDY6LLBrqqaXfxzcWEwOfURLxtgdyU6pFkNnFse1rEbYu3IVfCKVv0A86x6NraoM/bLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kWjym4rI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46b303f7469so19088695e9.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760758002; x=1761362802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7UD66nWwcPiFcs3XPMrdOoCuNNabzs8Aqa0dczoYOI=;
        b=kWjym4rIS5Rc6vm5sOQXVUDKavEgv8sLpFjlerwu8eHiKxbCKJb+jcuvAm5pQ9pFl5
         YF14cKoQFGTHX8F738aJQeuwNSQHrfgUfPDTsLM2y9U0judU1e7Tg33QpGykmqlaAm8y
         xOrVh8Hl5aIE+VOLlfs6HlVc4ejMxSn9XcvS2xnECkIkFors7TqlikgvQDsmTZxCYdH6
         So/KE7D3g4F4Vg7alGf6H6eu1D0hN7YX7TFv9EeMsefe5QadVBu14Phi/bs8744ka3x7
         I/qHvWQ8eac/9H3l2yDY4P5pExGEI9ZPDuB5u4Sw9uv2VJOC9eewhBRL3RL45mTzdFsX
         3sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760758002; x=1761362802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7UD66nWwcPiFcs3XPMrdOoCuNNabzs8Aqa0dczoYOI=;
        b=QN1Ad3EvWuwLnAPGl/Ikej6p3BJWf4CLFtJmJgMczORWWgGhSBlHCqxkld4A4/3k2Y
         RBHjNendkwRJCTD7oZ63ANCa95gomdEh1kvexYsSEL38ZZ3YkGjJbMXHytQtKvxhyepW
         7IhrzDqJUG1UijJn1m096xVhHKpd+ubAqakQde6BEqJLPjqdCU0aljgG3uPRHRDbyAVY
         zDb3SZ0wFKbRVQX8NgtKtDQBXeamyjm4NVK6hxjlrN77MFhWzz7v5DADdVyeb18iT81T
         qQZUAYnZezCDTz1YsjLL1HVmKmVxpmScZJSFrkh8K0q6KPbEhWtgHHb40Ph2C0LlAw6+
         xImA==
X-Forwarded-Encrypted: i=1; AJvYcCVbAcl/lUYEpRM4Se/lM+5Ua2KeDsF3cAjxAGsC/U7UdrNCnoH7ea6UqsHB5t05G8/q/T8n8ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrYSdzqHpUuw1WitqdBX3L7H2Q7QtMkm0fsKxp7nckn0Yutvy
	wteJ5ytgoRqr6F+sfGzyhHY3m7rpADXLv/b41EJ53j516V1h56w2Dzk=
X-Gm-Gg: ASbGncupsA8sKuPZLbgFw2HDuvdEfcE3EoHQZKUbwaG8/lf042n0HC9G6rSa0OEg9va
	qgoKG8wahZgffDzZckPRLlJYd0ZDM5QM5yfehccL68UoWfIep6QtTm96PNsS3naYLwzTV2/z01M
	BsLsmSTsvFfwyv8zneeOZhReARb2gSFXVj6b+rY8+L/pYETkxnsSqnMwhISS3yxAV9u5dmB2PUZ
	Fo78f50Gwq4Xapow5iEdWlt7BjK0Vsrntz+oZkAKHbDdwUPAcU2I6YS2EIVaSy6zJZ/G0kOqZyp
	o+FSKK9VYuSh2+C9zWVTosOTgKx27fxIMNyU/dxl+WSlArcOqLbMZdboKJOsvo1fLozKKv7LNbu
	DlGKAm4YQJkLzorypnGqMk8tgBHy2bvjORXvdlk+fnKYOWl+SoaevpyFrkfwID6G84izH6WRiSA
	rCgSH54BukmFSFZsun3q6scaGjzSeKlIF8vpbVREGySnRvK/1/gHcF
X-Google-Smtp-Source: AGHT+IG0WT8qGhi7qbukasMowA0m3pGEljJVHr4MRqavxDx0uIQv4Oco55RPQjnCpJK+yEKzAlJVDA==
X-Received: by 2002:a05:600c:674a:b0:46f:b327:31c5 with SMTP id 5b1f17b1804b1-471177ba398mr43631455e9.0.1760758002040;
        Fri, 17 Oct 2025 20:26:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm108137345e9.13.2025.10.17.20.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:26:41 -0700 (PDT)
Message-ID: <0bccfb0a-dbcc-4103-8453-adcade20a0c7@googlemail.com>
Date: Sat, 18 Oct 2025 05:26:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145147.138822285@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
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

