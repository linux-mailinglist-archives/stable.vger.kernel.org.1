Return-Path: <stable+bounces-191387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBEC12D7E
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429F21A288B8
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A587299929;
	Tue, 28 Oct 2025 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lbo5U6tc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECE2980C2
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624802; cv=none; b=Pc7GpBCy0zOJzRB7Bsvaajsmxe1TJVyF9WUe+rH5bxiZ971lVrLEb29n9e58Qnps8YhM7Z/8PpKKKNql6YkuyOXkTGn053M+/ahB6kno/UoKIhJ3BJaSHQblEZ2jPugzPk53+iQE4NrIF+TsV2FjglZoRIxSOZ486JCYZ5HBLO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624802; c=relaxed/simple;
	bh=UyyiNhIYnsemwIB2QhJMUyT/KVr2/tew62qORZRK0Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbatUXw80Qb7DVV8eMPYT2u8Q/8xIAG0L017qWgBrYnwXm/l5aCsLaJF0cjCRA54CcLHlLokZZzB9dmBZdHJMR4KdPzXOCwHi7/fQd0vjbbjqopzL66nm8kCx6yzsicqmLxso/C1mWRIRFBL619BKPDjf//yxAxRjUf3l/GIJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lbo5U6tc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so840938366b.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761624799; x=1762229599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEgqINWjOapsM0h4fb7Lm6F0VAqSNd9RUscnZLgSB1U=;
        b=lbo5U6tceNABkoI5dzvEAg5UbJWJEOEmk+5XBRW85Ot8eP+2lV2C2vRjXFgyAJjCT4
         rLeDfVzjgCiGjlC730D8eHGsHBivSMPWdDf8RuT2a4BZdr7DQUfoYXRkr66eBiR2nujk
         M2pOpi1By0M9HTVxSHMFamFThEvWPIjJ1TZe18A9QVqP0yPTv9c81FM8cLeK4pCpq9Rg
         5Dts7qyNVXxXC0TsIaUSap+44VOds4bP57VQ228q86TboED+Os/I40IzIg96dq99ThnM
         8pWgwouUJvS9Oi5rRG9dX8Sg8hwvjh3BAFWWTX5MY61xh4j8tP7Bl1pLlA+GGlHFeBlm
         mCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761624799; x=1762229599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEgqINWjOapsM0h4fb7Lm6F0VAqSNd9RUscnZLgSB1U=;
        b=My89oG8LDEHccHR5oi9DwR22wfAM4gu8XgzYByjQadwvVpkvWJnkO8syydF7hgi+7R
         5m2Q38GRsVSaIHt4SApmzUzAxlURijFkG6HlcLpbKNH7bynW0FCgUREM0o8FZfh4sHwJ
         EkiT0kUzqHbgaMbpzkxh21sfvQW9s955MsrxsMW2epbuqnN9A1HJbTdoMCohh75VIxW/
         FCMSgaxIJxJdE/fS16Br7QZwJHXkNSXsxgm8efGCcTPqiYfV+itLeGwfRROhi9BfWg9b
         3S9mZb/6Z+emskm58HeEZDhZORuJKTRyxgjnlvCnaIi053ioFzHxxGMhkMPMTO9tnzqb
         YQfw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Vsg4ZpBKqGmG1OIwZsMkuq8xXpvMqoPIdmQmc82XtcLSyB9V5k2KckWBqWZu1ez7bKHsV64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBzeUH7Cwd+LYSlfKMPmBghfsFPhwSPImXUfDnZGmkjc5lW7J
	3I0SqLTjG4aAgKZQWtAwSl1i30/NOJiFLysJqQVs6txKgk4RBCQ5yH4=
X-Gm-Gg: ASbGnct/q8yUJyWThkuLBUh62pX65SVqLodJRcU0cajs8Qi2Tc7TL1BwdYkB1l4we3+
	+YZgAxmDj4vnOFdt8pV/CrONFUNEl6lE3xENQDcssWxuH7F2Tg7UY44B6PckF6bk59vIC+0w4Vp
	J9GvzRaqnaLUFJ5wJckCd6hp0iZH1HnpBZnpGtm3WSZNzd/2E6peBJyLFbgVVRZFfhKKVLHsY0C
	pb2ThxMmLyfDyGbQ1Ru8GYb4KtTDRi/38M5+8UZWdYa5zGyWDXTBylvsauTRt9Ewl5RltpmPKIS
	zSedMdmR8ie8C7SGAYJbEe8WSzbseAvKJXAXJaE08XE46Klev5tEYSK+2AGGo/8LT5YvadTnxtO
	vS5Ag9/2mnlP8OyTomOocPaGyU+yDhmRfIfP2r8+RLRKvU/qCBMFdcTKZlG85Vcb+xeIgIWjE6S
	FddP9HQ7ceZLpW0lLysxc/gh7TCTF5oSnsPUeMQkMDKo0Vqhy9gtM=
X-Google-Smtp-Source: AGHT+IEUPA4wpYmXK0HNWghv1sI6PC6wX8Ur9fjRdU/JKa9FwcicSW3bLBVlrN3ChpFgFmnLfEDCTg==
X-Received: by 2002:a17:907:7e96:b0:b6d:6832:a9d3 with SMTP id a640c23a62f3a-b6dba584353mr220514066b.39.1761624798933;
        Mon, 27 Oct 2025 21:13:18 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85445d48sm954769066b.65.2025.10.27.21.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 21:13:18 -0700 (PDT)
Message-ID: <377623ca-864e-427d-b6d9-3ba0788d2261@googlemail.com>
Date: Tue, 28 Oct 2025 05:13:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183453.919157109@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
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

