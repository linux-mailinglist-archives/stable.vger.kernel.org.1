Return-Path: <stable+bounces-176405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38586B37172
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41B18E3FE6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEBD314B91;
	Tue, 26 Aug 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Avg2UxUS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F42E2DFC;
	Tue, 26 Aug 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229924; cv=none; b=orQMMyVGQ8EdOUdKBd5ensArt9kJqMB0ZPB/NbElaYfd5fvPdmRWAvgFsjCpYiJRNHbnbY+nf74ouOPDvFym3XTmULFpbCMFAD9+axLmA0m6bNo+Ph24hHq194j/3N8M+GUFJ5Pic176SNUkm/I/IzYv3lGf0AoWw5CNjkYhVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229924; c=relaxed/simple;
	bh=ZY0Nqgb9CgNDa2G+URK3Z5pq819+PKjL8HdDDaJHs1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQJMbybIF8ZZ5Jma2nsHqqB7PQ5RGiXBpBlbDoD/7q7JG/fQd86dOvqjpuZm5ucnxEFslg3ZlJP1XPd8+JSQ/hSEQFQAjb/fkN/OEXN5lhBY8yKVFNjXbAqr6SliZKfVSUnBBJF6EhigewR99NMZKTBXni2X01XoEW56OTDlhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Avg2UxUS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d892175so29785875e9.2;
        Tue, 26 Aug 2025 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1756229921; x=1756834721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/DeFB5e3JjBkmKYycUrxoBdm7wpBiHToE6tdlPi1jI=;
        b=Avg2UxUSaTZ0ejHycgauwRSxVR6j2Sq4/dcmjK9CDx+CEARJRI2uA+B4UC0abI1iU6
         HzPoyfZ8PuDnF93DaDqG2Oizm9xP0viW6Dws848FIu3cALhId6qc1U3YduutddGlGbau
         8KgrRaU8+JjPHyFYOSMd2hC7NsAENrt3GxqOCl3XT0XLxLEbKM5V6FRHnC4OVN91c7CY
         w0kF73oe2qNUAhB2FZDGxraM+zpbrUTe+BCynsrRZ9Pi2h0zxjZHrydRAnsErGYQ2GP3
         dd6wHQcUBYpDvXFOYAqy+imO48/o5ebxtPljJkuiXfLA17loFWf/7u7c14fSHoqHxWrW
         vvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229921; x=1756834721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DeFB5e3JjBkmKYycUrxoBdm7wpBiHToE6tdlPi1jI=;
        b=tcXIIA/uHGgo/kaaPUf+pSKjMhljcuTIPjHSTmpfbknGg6KHsOYJCiqTD3nDG7lz8r
         Pl65e/Qb+p6jcIcBEs+l4/ow9cxJd1UmKtrhkxsIUZb1rXXzkMmiYjPgDhZ3JVePRkrB
         QqdczGSo/dXPs7fDZRomsB1NALlO7aDTNQAWiwbNjHkY28RIXf9w+EH2/yunGpGI92Kt
         z9C9sGjXmxMnJEnA9h74ygi1OxJcTqQGp/qkStjedLUJOXSIIWwEccclMGp2783a845Q
         7Am9ej+Kcj2hvxISdFhF3fWTRq+XEBHvcJunbao5SBqmbX3bbL868uRFrqr6Hyt4YTYl
         e+LA==
X-Forwarded-Encrypted: i=1; AJvYcCVKAJbQwvrsxvQB5S9CPtuQVJIVzi99kZ2cmrTXl1Zmmo5L5slhXhKgSShQl2uhl5ahMaZt1PyjKRIMp2o=@vger.kernel.org, AJvYcCXFSDvYbCMww/4XlHkADuM84XG9sYug2NAtlQEWEjBCBKuCJ/q3+uxI+xUzxS6RqQhVJOu3RhX8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37El0MoXIAOS9dy4KxJGocSIwuJTuTj8wH3RyhZrvCPMxe0Nv
	zcG7eB8vpFz+K0GX9bt0zjzpPgameJi1ywCLahiivO6Mo0TlZKDobrQ=
X-Gm-Gg: ASbGncuJ+1STKVwTpiu2TGxuH4ZYK1oRg9wM19FJnn2qqil2XSmqOr4kEEEzW/IOKvY
	IQZtu+zLvyudSdyZVcbrOmfNIYNBcJYtyt4spfYTlza7Ji79p3nu8Sot6qH5H08cfbDvNCeifxJ
	VyM1TFQNVJVVgtrVwOmon37RdXsURBitmMWtnu1fxwZbH16MBr96ofbXTwF3QmZ2CJbZP4IdpfL
	/kbvMA/GthYBEropdjMlw8E41FxqbYwPpfz2tJ9NHWzk+uT85m4+tbj7YHuXLdihL5u9XE+w5af
	DFyVexqyaLmc5Pp5x8T+PUoqMiDlvixQLHPySyyFVIFSbywKuOViItttR1V0jH6+6QfDiycUY+H
	Tut7VzoBWzu/bnGdTYsQ7PZplIkhjZZ9KqmCJBA9mAQMjIgPwwyDtW9bJaTMPaZw8yMe71HY1Bi
	BG1A6XnBAw
X-Google-Smtp-Source: AGHT+IFfc4DiAti/XlzwdzNIKfX0igYZ5i8ahHaJD5NZfy57ZdwW0mO8SjsPI+6IxgJWq6LB+rnunA==
X-Received: by 2002:a05:600c:1c1a:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-45b517d9008mr131562355e9.28.1756229921192;
        Tue, 26 Aug 2025 10:38:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b057219.dip0.t-ipconnect.de. [91.5.114.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6c5b2eb8sm1402545e9.4.2025.08.26.10.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:38:40 -0700 (PDT)
Message-ID: <0afb7c90-856a-408b-b3ed-deb85a58effb@googlemail.com>
Date: Tue, 26 Aug 2025 19:38:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110930.769259449@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.08.2025 um 13:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
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

