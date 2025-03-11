Return-Path: <stable+bounces-124110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C726EA5D333
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 00:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B6A17BD82
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 23:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDBC23314B;
	Tue, 11 Mar 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q7BPZq5w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175F1F09B4;
	Tue, 11 Mar 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736352; cv=none; b=pjpiV3EAnVbJobicd9JlzjLqytkP5biY5U4QBmnNtdPiDV+76Ts+HutM21HKrlv4VhO9iMLFdJX6gWuZOx2owaEM9AggyNnx08bmHqCGGDrCUuKnQUUkra15K8UIDC8mmNycuMEPR/cpk0Ktyw0jX0xAXLsKTKRkEFxA/cAwJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736352; c=relaxed/simple;
	bh=6HAhvN/5aIuhTDN6TVOI/FwZa+MffuFYrNaRthKhni4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb6vB89RC2g9P3OmdSslJxY9qbmQWtOoFVDcZokq0jsjwUxXXIH0NAfcjNWHNwmLzL9de+Uc4IkAvaTYUE6hNB6tfGbWlvi5VLw8X2LT4zgGKjaw7/JT8PZQ2U3RQV9dRj7wsRJq87BJvQKlDXCZ9udlQvC0J9KVh/9khC1QNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Q7BPZq5w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913fdd003bso164081f8f.1;
        Tue, 11 Mar 2025 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741736349; x=1742341149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fr/QFLpp8Z15v7bm6/9JOnLIJ+4Di2Fpgl7HneN3Q24=;
        b=Q7BPZq5wXUkbAtrs/C0bOPzQteH39H0KMJGVODAW9mVruABkixuh53c7YVWw1d6s9a
         Vd7+Vc+jGDmSFK7LW3ry34I7BIgiMIGEN5S1kS79uLMGLcr8AKtODktFMF72sWVCHkK0
         N1BvmVv0A5VWtHwkymQfjM1otWu0fWcXy7NiN4ynP33QNBEG6ijBylaCPo0hXIgeRNSK
         5K767RJQ/3Gh7zjp5sYMT97Llz/QYN99HBu5IZUauQYiehRL0MX8jGBkdSsquekXZDpo
         N3pKML6+QNVfZw4819bam1CNkuzi/URHTrnUz3q2qksndDtwT5CI3hNcElWX0+cA8iCA
         IdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741736349; x=1742341149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr/QFLpp8Z15v7bm6/9JOnLIJ+4Di2Fpgl7HneN3Q24=;
        b=ZEQ9fFd2LmPork2Nfi5X96GqBrhz+z4wkhVB7fGw5VMtBnwvJA3ieqLPDhQmm54Y8o
         DDF2QvjQ7n1FUBDW8TZg78rdCvp8niRc+1i6cPUErcdsFNl+95A1q59RvDDo+IZ0TEGW
         B2XQByy+it88Coh+zlrMSdemB92ywXIuDOK0LGJL71ggrznJZWAOyCSnRISXTXC6oAVi
         6SKgTCyndlv1VIRgPaQBW1CKk6DJ8X5OGa83FL/tei2tzmFIpXs7g94w/kq0d35YYtXR
         M/QNJHkRmlvhQ95Z+UdU4D7USv8hkXyawYuTyjerueeXoc0ppXo097GUiDy+ehDB44XY
         5ZKw==
X-Forwarded-Encrypted: i=1; AJvYcCV9CeWdSXJei2KnhDx38gmoAMuXn8n5Wk8g4eGXdhgAs+GPUgW2LjPvXQsaWjJvgDAcAZjC3aR0@vger.kernel.org, AJvYcCVy2omKTgk7a4Pk/I1CaEWvoo7EdPnSFbOI6j/fDYgzpqzWhhCfdvagu9V76zGrK1gDNQzh1SHR8BVjyJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDvxpFCPcBXFVcoZkoV3ri1YqJAOZvmlYXJaNjVYlYYB1J6LE
	vq0lfghvXeyAANu0m/CVLBlNmLz2Pi51wJBCLtiFXcjM86kwIzI=
X-Gm-Gg: ASbGnctlXuGC95tMFzOdp1kQeEsbd5ujUfMZ8OZVCzwIhOfaX0V/IcqiBlqDaiPweWP
	9L3dy3Ca/BLcj5rW51L4RnH/bNhAa3M6kYHNsU41svrNPoyCoju65RO3wEeew3LNxb0iibmL8FM
	GKFkxAzEr50FZ9JWgHwdqbhGfZVMm6cX/T4HswnEjRpoa32Vll8PNhSgtD+1VdT0dyxZHoU68y7
	M1HmqTZ9tZnRebBacDAqZFE1N/zgmoJQsjpsvxujc9Fq2atDyhaiRuYuBW085w0zC7n8S8rz69d
	UpUTLqYzNKN9m5PSuDfx/KlLWIf2neI1ZXYvFLL7v2bnFHT2sEcjvbXxMKz3Ojts/eEq57DGDfS
	zs9oNFYkBebMbDQNX701wRg==
X-Google-Smtp-Source: AGHT+IElgO/rn+31rKgW6EfhYeGVsPC6cevj0duDKkcYSFutb4R8C7FdoW6sdeXEklTLaxi3bXA8dQ==
X-Received: by 2002:a5d:47c2:0:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-39279e5172emr6258102f8f.23.1741736349266;
        Tue, 11 Mar 2025 16:39:09 -0700 (PDT)
Received: from [192.168.1.3] (p5b05767c.dip0.t-ipconnect.de. [91.5.118.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb7ae4sm18857564f8f.5.2025.03.11.16.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 16:39:07 -0700 (PDT)
Message-ID: <da0b659f-b1db-4ff0-bfa6-b875e4be76a6@googlemail.com>
Date: Wed, 12 Mar 2025 00:39:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170457.700086763@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.03.2025 um 18:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
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

