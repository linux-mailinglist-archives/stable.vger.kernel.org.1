Return-Path: <stable+bounces-181460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A01B955CB
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096202A3814
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD0281376;
	Tue, 23 Sep 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dE0XSIOS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F626E6E3
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621747; cv=none; b=t27wVIjEeDtLVavS8ZLcCojqgycuhDegwqKb1Nigx+EmduriwBPxv5foXrbpIl1dvd+k1knwRxqHVwMkqu4q932EnNXaFF2/dYu1eH0gzqQTD8bK75H9JdBmQwJvPlwSTyEWzxRfLFAFwGm04wYEYXwf4Y0tr4YpbP/BdTAnVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621747; c=relaxed/simple;
	bh=5FF8tPIDmyxIpM9wVSXDOOY0MC8zPSnYmryOXTAKfc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+SDLig9VjZ+oG+nG7eWXwN490jA+4GXHyCxcv37OwP9TnqTycFGN94J7S1PSi6mtAb5Na19QXZWqgTSP/OeoaXY/ds8IPTHz0mZqrX2aadSC/j/d8EoghyElh06Rc28BDr/tXgJggVrbp24a43srJW0+qcQ5AlbtLBVstTyirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dE0XSIOS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso37839585e9.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758621744; x=1759226544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuxeQkFvuyAhGjszfWEO1n8yY4RqHJEB2By+oL3ZH3o=;
        b=dE0XSIOS46fPLhBUSsts70xEpIqWo+QBD2rA+zb/P2KciiyLSmj2YH1M7orOKeKGKS
         MQvxNFVv8iVjnZiFCFhAOUcT/zsADIzOzWOX6SHRP+oLYoekgBfDtVvt1vAgPSBeO1MB
         I2IzVpHnDeL2LMpBGrpuroFgHxFzpGS0ZFpt1xUhzKRddV4YW5TGQqhzA7cRXYuzj1sq
         5CHj2dC+Qd5QMbTWgBKIQ8tb+LKU1ILr628GbgGaJnnG5t+aaOxF3vJFfDyXqQ4b32+i
         udofikTaDTCCFlQ0tOioYlIRyO/XcMmoLvV+y82YvTqSC6DjASaq+6zjGQA4W+xS5btR
         vheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621744; x=1759226544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuxeQkFvuyAhGjszfWEO1n8yY4RqHJEB2By+oL3ZH3o=;
        b=eVortrImz07rF1Mz2r2r00KzqfM3jVcG5j6lTw+0TGe8AR8SDKIRcWliKcZsZRCKpg
         8cyG9q3vNwjAU1uYPbmsxZxbLexUTvQFXK76ozK9dg3B+VW8OXcVJAKUIrPTNlPVmKpQ
         VZC2+a94UZUjymV7hu7h/CeKJwzxnY3ts+pvZI/fhZ4ZQW8jpG+QhZIY7EnC1c3Vge+u
         FUWcDpZkyN/zD81OJupb6oq9fGf3pnFE1ECIjnQudzy+kfMt7ZlnbQTOKMh8xqVW50IY
         fnF5r6jZ4a1cgpPN3g/uw8g9dEOo3phq/DLmS6+CH7OlKLdKxAHq4t9R4jGfmBNK1cBw
         UO+A==
X-Forwarded-Encrypted: i=1; AJvYcCWGBSDbWWBv3K6I1Ye7CR9HjScUo4Euxd1N8iNEo2P2p54vzrt0sCpUxFTjQuIamES6M4xp+yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4zxdNUy48WE9c1T4IzGzesQpPN0XVzA1DUsF/QPYU7fzQVtj
	66D4h+5caALb5WNrB5fiHdWB8yLUSsghvOweX+AXu1CJnws9KgNnBxrXkQJB
X-Gm-Gg: ASbGnct/0/Zo5TlCMpN17rRnD6r1SdWLXtsWFbomg2/dca9c3xUtn9UxOeKzDhju4fz
	Xwhz4AQklfZeFvKtD19jShtOCkmA2PCxk+mK8te0b81MtFhGZvkLCNZtAR0TYGCtSA6Oc3v+349
	FRoPnwJ4uMoC/9dDZFY6K0FHD4l+ChgQMvM2ALgHi0sf9Jm9Gv5gG+Io5Lreru0QvBAcLDQxfJz
	WIK7WlJwMRKWyhiBTCpEtVPqe3Bz18bhXSl331LZvfcqWFjhOY3uQaSC53pMN0ICw6ByChEqtt7
	yaSi101ceE4YEVd76L1+agAdcKuiizhEOYa8wFKbDJD6TG3wy83xKAHCtHkVL3KB4ZmcNtGezd3
	ruFXfalvzrBmPBtVQLe9JqBPY2Qoc/8NWm0L628zZXi3wOnnKmuMuPYeRrHzAbY/iMt565FFjqN
	xxdw4RFv2w6/o=
X-Google-Smtp-Source: AGHT+IHbIWkBOYmlyevzc/DOc2+b02FFIYKW4dQtg7oDiCppTekVOg8WoA5ZV55KSLWulnHDNB4qDw==
X-Received: by 2002:a05:600c:45d4:b0:45d:f897:fbe1 with SMTP id 5b1f17b1804b1-46e1dac6779mr17626225e9.32.1758621743929;
        Tue, 23 Sep 2025 03:02:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac1a7.dip0.t-ipconnect.de. [91.42.193.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm273067595e9.22.2025.09.23.03.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:02:23 -0700 (PDT)
Message-ID: <5820ed19-d753-402a-adb7-9d2026491edd@googlemail.com>
Date: Tue, 23 Sep 2025 12:02:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192403.524848428@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.09.2025 um 21:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
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

