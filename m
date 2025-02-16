Return-Path: <stable+bounces-116511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F498A3725B
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4E3AB777
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C615383D;
	Sun, 16 Feb 2025 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bebWdZ9P"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E03C15445D;
	Sun, 16 Feb 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739690382; cv=none; b=qUp1K9lz8uPCgLcDyTRmANgyJvYE9k9xswuK355rlDIVIN8Klz0L5locETL5WCcRgSX4c5t50Z0kyhiPk8f3muJrDTajjyMe0oU6D3BGmQvrY0v6Z9zv3QEbs8l6/ZQr7Xk3S9hbZc2QZ/VIc+9+1b5c19uteO5c0xMfdJe6r7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739690382; c=relaxed/simple;
	bh=h8GLSyu0qMrP7keJKlTVF3CUjBxx96cUnU04Y2WSPPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE+Tk/2thD2aEsre6GgnDSUoraabB3T55ot8v48tEG4rpDJZPEpSAstiBWl8Gn7fmvh0hjg70uVKo9u4RGHes2YziYid6sJjJkeUVKy/itQqrVKJIms11aS31VcBNLLUg7bqFbVPyiD0FPFX69Njc9pcuDYHqjq39irNThOGPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bebWdZ9P; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f286b5281so1459568f8f.1;
        Sat, 15 Feb 2025 23:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739690379; x=1740295179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJ48bFI5nmQNNKRHP45qr5Uw0E1Ug7S7l+n7QSTbTcs=;
        b=bebWdZ9PR5egA1lwSXUFt5Cx4Tav6TeWRs6imSY2AFmmuE1IOD+BE9Oj9QNTVG24MQ
         CDUvdr4CIR6/SwGKCAxjkz04RkbRU3fu+W2pgGbMs3SLxpcX/eA9NjOkZCpHNgmlKEIO
         6701dcv8DiG0+0Y51j2Tp5xE+BG8v1FDgMoZPbgiWd02+I5ktwmu9rQPsOL5oq39Mpj3
         nGS+7qzrsDPDP0dps15HeP0q+J28swgJGue6/QpUaFkF5GZWnu+/WUBVS5GZf1Q1Azzj
         imLOLPCOhO7ORpeOfB9rwuePDIyvcklgGW31gVgjLvzuDeeAyR0XIAIJfWvb5Ucf3K9G
         EpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739690379; x=1740295179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJ48bFI5nmQNNKRHP45qr5Uw0E1Ug7S7l+n7QSTbTcs=;
        b=megjzE7yXUPInFbrhBDijXPLMB9KTNMxntVphD1LCWPLd+6Q+Jct4ILeRTTae90HID
         65atyzDwMtH7lK3GjUaLd0pDHWO8Rw1ArfFiovt88lEUP7efuBt265HfESuJxZpxSCpT
         jx09bBY7J0u+tOHdEcbzFLfzwanzY6uoPR6DAb0s0b+Jp+5FGSxtRDu7mGL3cwtV0T54
         bcnDDlVV6t8g4JuOnjKvp39bZkpyojQ95AP3uBTaEOBgBcxH8Y8zYuhUaVqmKJByhAb7
         mCtN/tG27igTFQH+riUQgM/cVYqglqdEbLbJr0EIRzvj7dwz+l4mhH4VOjKYBylSid+T
         8eYw==
X-Forwarded-Encrypted: i=1; AJvYcCXViWHwxnqxKxLU0YlSixAga/3AEpplYX0QCh1rIVfMbM/9eAqNQNBweM1aw/mfwMShyBaFi8vmo6xAJ2Q=@vger.kernel.org, AJvYcCXeTjmBobd8DBfscZaTxeCCAOPIifdCy+sISf0EWRld18tbNj4KBp+CZbo5AN0mFfSuaOjlqIgl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83+0k26VdijycUmW3fAbRZQhGR3YJY5eoFWmZehz2sj6oUa/q
	RK+peuUsSv4xS+68+OIdDqrdIb0gtQ0X3dZlOTWJ+w8AZFTZM20=
X-Gm-Gg: ASbGncutZHIkG3FsPQRYNH3Zj4+q1fF9OMEA8NUfsc8b7g3Jcu3sg8gkjzX1ufjtWwH
	1nSljFvs+UQiQbt+4tbADK02nHSivFGNnjME2PewJCvzDp1YNnWRhYrXlEm8644w0/YMeQtwMmm
	JqJUT+F8L4dHhrEQ8qQh5gaPfaaZQAnCihpEt3+19iD5qD3JcFdl0ACB04GpK8vsjeoyBlJD314
	uYRgDoRNmAGE/mp9AK/1wZz12cZAzUZAxwtLiYM535hrBbnc9xTZKV3A2s8QFLCV80vH8uhswgj
	kqD25ic7qMykvVB4T3HjUgbtl9VCIgs/wS26gOIaF+33qSZvYufwSYXVm7/IjFr/M8Eo
X-Google-Smtp-Source: AGHT+IGm4hiqnMQWTqMPbhPKO2hNADidPmmiKUb3hBslmIgtWXuoigTeYkXT9sNM/irggrjxCpN+6Q==
X-Received: by 2002:adf:e74e:0:b0:38d:d767:364 with SMTP id ffacd0b85a97d-38f33f1c8bamr4413943f8f.13.1739690379125;
        Sat, 15 Feb 2025 23:19:39 -0800 (PST)
Received: from [192.168.1.3] (p5b2b47ca.dip0.t-ipconnect.de. [91.43.71.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm9086555f8f.99.2025.02.15.23.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 23:19:38 -0800 (PST)
Message-ID: <545f056e-fe4b-463c-afda-653cf558ad12@googlemail.com>
Date: Sun, 16 Feb 2025 08:19:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250215075925.888236411@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.02.2025 um 09:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
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

