Return-Path: <stable+bounces-191391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE2C12E7B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1093350C72
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2426E6E1;
	Tue, 28 Oct 2025 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VdcZOc0D"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD013AA2F
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627908; cv=none; b=SVBgqalD+WmRQH2A7OE+d+VWiZ4+rXMtYKkQgIGXtj/RQb6bO0/Y5DTK9nvanz7fWv+Yb2y0eiCJZNJdINgqqIpkirp5iE2K9FFdIVd7YcwT8Wi+2FcUXqqxoVi1TKKQYGPFDZW2w1fUyNIANfHcCU+RJg9ZvH/g/blkr1sEcFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627908; c=relaxed/simple;
	bh=tPEtRdgT5AFqfrjmOByK1BhhX0vqZEFiVdNegX8W91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pidVsS7Wo3al2vzENri6Hsg8ybhirGkYrfAoa0XVg/vfdadZVsg0Po4c/7Q+R4SKrwxvLrA3R1t/k4TUYQV7yGZrzpMkhXgzdSt4NvRXlvC0aOLIwEerlfBKGMAXLtzpHEl4GLZSChdHpB7v1ejN7ipD80sQe2BliNOd1Z7bOs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VdcZOc0D; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d6c11f39aso5770466b.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761627903; x=1762232703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AerQ8anahxAVq796epN6eN0GZqxQd097rK/3M9J0Tyc=;
        b=VdcZOc0D2149n4kWe4LZz5x+rE2pGHpMKec5O54ERiilRcaOlC6OxIYmdmIPmTjjcT
         3dWssd3lF62vMeo0k/NYx+JmDgvlIiuopOEGUD7WMY7Wi5bRq5f2/pdcpenR8pngwwGC
         CjraMeFqR6gqtwQO/XUbqRQ9m12rYvANQGM5sDwFyL2xlhka2kMoOvvH0bSs99c1Q1y+
         nFXMpkseoCaAuo5ZyiQx5bfZ8oU1DrzD6OtJ8KsWolDw53pZUPRQUDGRCGtTik1Ij/ov
         kdaVy94UOKQvC4++jAJ0dJ2f51m+TWGpZc9x9KscChRmGegooyro2oVc5LKqXUf3BJyj
         Ctrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761627903; x=1762232703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AerQ8anahxAVq796epN6eN0GZqxQd097rK/3M9J0Tyc=;
        b=qjobvKTxB+TH7CIYXYtbfyUyvfWP6s5h7Rr64Ac1FljqACGdqOIdeiR5OUOBlOGfgU
         N1vuas+IFxZ4Re64eulGgnc4KNtWE/MkmQszhYgd8b0GFa5ry4cFeHSJpENgvxsk5CVM
         j5ewR4rWsJyAfaAMLkvK2nVE716xe/Dr4uaJkpLAOEWbXlln+f1RLMtHNd1A0UU/GTgO
         LYIcOZvvuK5kDdBwRIv3vag/MAL7R/RTKx11QC2udQzm6s8T26v0P6fKf669seQW7qDt
         VJRMqa4iG0aQFra6yA0HE7jigvALJyzGr9lhAA4fV9FpXXV+ntQzaKsxSPXpwMk7lP+v
         NzQw==
X-Forwarded-Encrypted: i=1; AJvYcCUpEKxgCJ6HkP/krAj/qcLYpvXrm4xVdhMCRbEJ/QiLDlkTWWy7Wn8qXli7kAMnnOcxQ6+wRiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBylCBLrnzrzMNmzTSzLAQnLhju7pSNNvI1xjpD0ZZ9+THpSu
	1BOgAM2LZ+iD6fVbl2o/+GU5TY7zwZ1o5INluw+NsrG7Y+xndsSB/4Y=
X-Gm-Gg: ASbGncumG3/T3Ikq4wdLh4fObnxS+fWQZfWdzQgKItaFMNK+HYG4pa7UtWgoLZDeeP1
	MSTzX+ax15VVEN5ftwEATEgfB0u+VwD6dAQGoFw49jT8+SdjQAvMJQRKuGr7XtmfXu2EptOvX1y
	TPhxJoPRuNJMOShnXEcyaSK+98VC2ZubmsI3PiM/ku86siuxn/qTi6hiwyDUsgQXU+FWwSLNii1
	2pjWjpyY0SvB8cCrRK3/Q+t6WQzpU+Thk/a+C+XhcSY0HCkc+YftXM8NXB9JsGUYSaGEyRbnLGh
	koG68MA8Gvl9S+5Iurx82djyuNkPIk+OY6e+rwOoMBlY9MenSUNmTPTgJxlsusoDbhGnUleUT/Z
	DEAEgTCk7VJHi2vcMAzwpDC4er0JzNd7tbsSALFJ3U/lSPwb0vusthfvLVnQBGTmR0StYzc4E5w
	eECvtjpXnIOmvJEdKKFILrSg4LBn0fyXMRIhfhTl44SCT8L6msxXU=
X-Google-Smtp-Source: AGHT+IG98gaKXDDq10+P2yRvMTbMWPbW2KU883vT9OMUrK2f2QHIOlAdmmMdyx3BlHiKzEtfl9tNlA==
X-Received: by 2002:a17:907:1c94:b0:b6d:505e:3d99 with SMTP id a640c23a62f3a-b6dba462958mr271070766b.12.1761627902710;
        Mon, 27 Oct 2025 22:05:02 -0700 (PDT)
Received: from [192.168.1.3] (p5b057a53.dip0.t-ipconnect.de. [91.5.122.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6dad195456sm424001266b.72.2025.10.27.22.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:05:02 -0700 (PDT)
Message-ID: <bd62fdc3-03a1-4125-808a-4b4ce839e0e9@googlemail.com>
Date: Tue, 28 Oct 2025 06:05:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183514.934710872@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.10.2025 um 19:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
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

