Return-Path: <stable+bounces-131844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF527A815FC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6F1BA45BA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBF2459CA;
	Tue,  8 Apr 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YaxnJ/xF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F75241CB5;
	Tue,  8 Apr 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141398; cv=none; b=djJAnJqTOJiIVdJOSzRmpgYqTW3w8QSS4kDzVEXh9nuBc9k0PBVO8g5tE0Aw6BXTbXy787Eglijt0Auks1wPCKfK8BSz1rZywEfbw2CkKcQqcz0cYJK5xeR4fRlNFoyuOPZkWxjGCb0tFJL2GugfjgQeQhYQp01U4dYpVYXqooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141398; c=relaxed/simple;
	bh=yV15HTrE/vKKBCW27J0iRu2xsmctgldlTygl0Il5Tic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PT11EWT2GY+57vw/p9kOYOO8WBYJqTAZczYNTOCzwfyzDzJMv/y1fgEfNIEIwfHY9zefd6EFYHldVH35OmWjbyuVs0Cft3fst+80uWuz7VH1Q9bug206VoOmzi06wsPTOpo8oFrYT+LcQfJO+9xsEsp4zCNFZjtT7bc39N4iLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YaxnJ/xF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ac9aea656so5096595f8f.3;
        Tue, 08 Apr 2025 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744141395; x=1744746195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhaVg/u+b5SbQYX4VE9hUR0TbRx0qr+d12G30wYA5Vw=;
        b=YaxnJ/xFOjvNplTRQFvWMgRdRwfXS6h+0EEd/lV0bDIL1hmVeZEeR3JwCCwY3VDvsQ
         uRtaWDengqebFxaJwQFkqdC6i8kRV4M2dc/pAmQt6bsAZ/jiO4jcKFytRilm9zWrUdox
         BQR+F0Ajil5f9o/YlkhzdH4posAmADI/XPSnT/WsfZGQlx/50qLa2tITX5yssDn6ITUf
         BkZbxcXLy0FlCjYHNEJeWoYDDGPtlfxaqNcQkjNH8pCLV8w/4xIChaTSeIv2YXfchnbx
         amAVg0/yU8jnEHZnpQl2LLNcJf17Is25c+srMef2Ih+Jx2Cn3WuALAcirmUtqmp/HHwg
         KiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744141395; x=1744746195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhaVg/u+b5SbQYX4VE9hUR0TbRx0qr+d12G30wYA5Vw=;
        b=IIREXl+u+gxFQBhK/MnsfvYdOlWMMZBUiUkrftWWWQsTtKLILs9kVQermGRLYJyvfk
         HZrWFpykFVqnXnGcRzTiCQnhE9eKR85e6sD/LI2YYwWhAdGDTD53n5J62bGk/NGYc78D
         auz4QvlLAkXw5t1sc3kh8vADdumVBNB5RN5eyX4EDSTQHEkdixAukFGGul5nSTh3Ja/R
         Ds0uQGDBD+HOVPT2+mRze0Nmn7XBdW+aWxgxBnOwFrRI88DjxfYfvkCkcG081W152FDR
         W1AWYhR3BCs5VJuGtNZSYtkrb671lS+qLobXVW5MnSYVWDnyjoP30OnJY2Y3Pf748KVH
         Tb9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUhzyh/qKlZwPDJePeVyEkZVi78ueP7Hb4WufHPLwj+WPWMBE86refxwUBuf1gZFPQHxFhkyhLsCOHNUg=@vger.kernel.org, AJvYcCUnpjbhZ14yAWFlAeVMZAJSqxlNFMOuA6a7K/dTKnnlhQ3HRK7FIwB3FRcFxDmSgq4Xz1RWP9E8@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJO5GsFk79hFJPGX/4/4r9O4QvRCjjyfe8Ic4qYRwMHxHnytk
	0xd4FONthLyd9ohdvTZpUsQ3hMtT4jWclmm9lVFgn3DqvOiGJc8=
X-Gm-Gg: ASbGncuEBxOQSWqDDLFm0HEEufvAswyo2NdRlgtZ8ELMGGljzxavd/nodbdGX9yU9nj
	rpYa/FTOyVsnrkzjTNn22OMYGDJeDoqjfCQMWC9WGaVZiTJyRNAwRGk/YutCpCaeU6Bo14HdDLs
	A3gLz0AXZ98li88PW0OtrpnBhdu7sXhq2UiPGIVNfSpUiihPi6y2UwnfvYmR/cISk/+Qo2Ackxq
	60EYICenJGiEgOWu4NwCRZB+3Xn2Wd0NjbLfM7+QJ49drMgDnuZwM/pkE08NTZXW0wWyb6UZB0/
	qEm37/oirArxWoZAWSjdvyWvGYMcKy82GxJJ997YRCqGtrhQhE4yNr5nIIwd25PF0dmGhcmRYUs
	4h/2JYUGzUB5A0WU4JUdf+w==
X-Google-Smtp-Source: AGHT+IFC4RLdzeq9tc5tRagXQaUbTZ7xImbPKse7l+EXFdAMRZ4Lk6cqBp9PptCPSsId7erm159yIw==
X-Received: by 2002:a05:6000:228a:b0:391:4bcb:828f with SMTP id ffacd0b85a97d-39d87aa7b53mr401576f8f.14.1744141394866;
        Tue, 08 Apr 2025 12:43:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b057de8.dip0.t-ipconnect.de. [91.5.125.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm15491218f8f.44.2025.04.08.12.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 12:43:14 -0700 (PDT)
Message-ID: <1f2803ac-3e1f-4605-89e6-fa5b9504f470@googlemail.com>
Date: Tue, 8 Apr 2025 21:43:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/500] 6.13.11-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154123.083425991@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250408154123.083425991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.04.2025 um 17:54 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 500 patches in this series, all will be posted as a response
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

