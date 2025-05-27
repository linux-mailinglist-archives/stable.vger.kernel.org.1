Return-Path: <stable+bounces-147892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C487BAC5DA2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 01:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AF59E2F72
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE1216E24;
	Tue, 27 May 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M2F79ixQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA332165EA;
	Tue, 27 May 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748387626; cv=none; b=VMwUJ9oKrBo+iPg8COlbQWiufnprIs5E0a6iUsZR3EI+lna3MrcCeJ1gtK48eBf6Hj3S6ftx45VtINj+jUwWyu8bAREznzGpl/Wy54k64W6OWo6iAvzB4RdcbR+SfkvuaQpErW4pRgrwBo2Ag4qQXWHzAssM2xuCPe+rlfIHiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748387626; c=relaxed/simple;
	bh=mgJlmbUc2ro6RV6Em3XK74+pc/RXFJAn8arY4O8Gn/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Veb96MUP+eW65T9SL0c46yoobH9vB2d/2Ex/MM7HHquEneBcmsQadXllwZdDbMLIcL19Nt93NSa96XeMA0UpWaeNcvEpUlHMS6RVIm+mTtKmcV60KRyFhShfCjCOhWTlBg/FqwhcoBhafwAN3WDim+a9ltFE6x0Pk5J6gZomxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M2F79ixQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31938015e9.2;
        Tue, 27 May 2025 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748387622; x=1748992422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3Lc6Jwle7E9Z1hz2kstblSBGOT4ne3Fyuf9Vey2s4o=;
        b=M2F79ixQSkpnWVMvqTCvCzzjRTbasjgqVVl9A7rbJolfHHA8sre7ZOkpFvwU/gACOh
         rCRyH7kNgVT6JV3n6GVnuqc+quUI0JDoQiWZ+XzdpLflHk68xngbXoSYqAxF6ytQDxja
         h5jCPt0ic8SFWUsqB1BpHBJGS7nGkR5BdDHxrIjdHJj3EavUzXRC+jZfp1y0F489S7Oj
         0JxyTEj+y1DoatqI8j+SP3YJ2nKg1NR9mG1ZuVGnX+NSsgKGBOQRc62Sle/rUukP9HAP
         VCXdyx1K5CTmY04TQrVqQ7OMpI9QPC46Ma/xztoTsoPkJKUitAa5GkXpcOU0mE0zVCyI
         R9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748387622; x=1748992422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3Lc6Jwle7E9Z1hz2kstblSBGOT4ne3Fyuf9Vey2s4o=;
        b=cTBfAxRZPP82dYLQygsZNhySqu0CjvA6R2vZPvII7+4MdvRswye1n2tSUY9bnlaINw
         IhfHogRPLIGp4f2jSDGAziKRwACTC13tQS4drbr/FERKArOLuazdHQ3MYsOIv1xSQ3ch
         nW0M7YKfNN3w2prbkCrC+qhXdvW0FEvKQ1i9YzA+uK+1/9Gd53rnc+8pu04R5eS+sHE6
         8uuIkd6kv3AvP9KvjXWrRy2xaQgwK7cO/jHY6V6srR89jScudEKnwdet+7yQNT86HIuk
         Av4H3vB0Wb36U44h0T3kJn0PTp0lvidQwpW9bu+q1qJacz6DKYTqoggdo/e8ISwy3afn
         S1qg==
X-Forwarded-Encrypted: i=1; AJvYcCVErQxf6rG4ssH/tt7zvlPRKFk9DztK6Ee07GZUzHEjS8mKihkI5gZZd6r+/WoRonj93o83e/0W88ZZ1fA=@vger.kernel.org, AJvYcCXybkjPqDfzNpCu9Pk+NUMl8wB9WhMBIs7MuND5uCIe6G9jFJUWBJhK3U7dJtZMOc0f+4CrkMjB@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHcTtVhStLBQT/KTz/HbM1sHbttSgXdD4pNp8UblfPJYIH9+b
	LhXrprpWqHRBSptZno5vUSe77XMeiZ5YK48fkGtXpOnoKBxbVFlt9B4=
X-Gm-Gg: ASbGncuQ/7ieKxjirQfAvRoKj4BGjsBdqsvPQdAaBo6XnJ5l4rjhHKECP+hcq71FmFi
	B1oLLpwQ5D6RgnTgqrfY631MEY33BaK2vLMwyQFTfvJpVCiY3MYZJulBReEa8HZh/wpv/URFwpW
	VR52KJCkVbT+oWFDsHGPLDbdXnql00HSXqpkIXGbcaJyawCC9Kx741EqZsxhAp0vQRdSSTIbsmb
	pFPLQyJnQwBNJixXrJIyLvj1BZvEeszQMSoQHwow9l2ZBlnOcWxocOVXOUHe24+cKP9EBh34gEV
	DN0U1P1YximPY+aXSMY1y80xU8dTQgMH2mzeUw2ivuW3AcgB/YRwWzrWWTFIhkimxSz/BXJsS1Q
	Z52l0SVty8kL6FkuSunE6UsfC2PA=
X-Google-Smtp-Source: AGHT+IFBeUh+qlVxssEXGivv7mIe4rzopkh+j/jyz9zm7czpZpVxm2UnFluFidGi63ZZjrI8VVRijQ==
X-Received: by 2002:a05:600c:5294:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-44c9493e67fmr111553085e9.20.1748387622283;
        Tue, 27 May 2025 16:13:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b402f.dip0.t-ipconnect.de. [91.43.64.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064b53b1sm2779155e9.29.2025.05.27.16.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 16:13:40 -0700 (PDT)
Message-ID: <18f3959c-e7d8-4d57-a5a0-cbafbba91281@googlemail.com>
Date: Wed, 28 May 2025 01:13:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250527162513.035720581@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.05.2025 um 18:16 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
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

