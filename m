Return-Path: <stable+bounces-197520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B55C8F9AA
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 18:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 257694E28B4
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715E2DECC6;
	Thu, 27 Nov 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EJEsc35Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9A2DECC2
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263432; cv=none; b=iPXwiUxMvhsmKLdE4eKF9qCZELh/whjPBfLrd5ReBHt06NsCHgas7wBKzNV0upkQTOLnIdJE8IxMkcT5qQZxnW69MoJjS3lea6kGagx5vDZflmjhLIBX7k9nYQh5uIifvlFdDcn9H7DoQcpBYB/+JajqLWBqv2+lYVBx3ONmyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263432; c=relaxed/simple;
	bh=FFJSR7QVGE1ZPDpVldLbU6gH7o/4h7Y3e2+amvvHE7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbMvpKeTkj1ORI3AJDHF9J49PNdc6NnPc40qs+zE41hVNJuiA3Pef2yXoBMeP/1Gxzlq+kRtwlGdmZZsp2ONvDvey7wc5vZxchttASBCqHc/yX3m4e6c6VzrC8u2/bs/yPmUoqoU03qmQfKIhKBNEuWv+TotbSeclywqJ0wOxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EJEsc35Q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b76b5afdf04so195229366b.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764263429; x=1764868229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmM99+m+hpwo3DZMblc3kjgR0n0LNQa8ZueSm4dBnlA=;
        b=EJEsc35Q60fICCQJTvhnKb2Qh6uR/x3tDMFRrwbtER+96MyKb2+tWZc2UmhZHnZrAv
         YiVr18hwhMpf3jdqdzHwaTxgdUYhTGCLBIiFWnyzzBuZB0jDKDw66MOHOGeX1B/kV/ZP
         n183fDwfqzD5JZ7iIc4vAqk41VWj0BJwupRaRQLHANVJAzLKZGb6CDiS2iQT6oXXYcCO
         2xsTs7gRx1ZZM2bI58Fhs9o0fMYqf0453m72rC+MqI35TLBDVS0fKNv3FOH+jNXUR+OC
         eQxI3TqxwVu0oP0wvaqOzdIzrCOyM0bHfzMDgh0A0m27+NjQD23jdAhsQezJ3GUayKuH
         2tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764263429; x=1764868229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmM99+m+hpwo3DZMblc3kjgR0n0LNQa8ZueSm4dBnlA=;
        b=Z1XuS0icBOQhk6sglhpY/1JdqNyjhEyfS+ezB0pfO3MT9JsTYGrfLM6zYEB4wUe/oi
         ng2oJ/bsbKbYXB6r09/TwR+7jygrZ16ZD/cFACehWHRD8DregRS3VQpwvOot6cQcjSfD
         ZId+dg00i+Fcr//r2owqQyfZdNfckosoQZt4flCjtpW3+JUZ4yMNtnK3oRzR+jg1o+go
         cHeaujaPqw6ppCmzlA6UjnDVf4KEB7SCjIEDTi8TSCSan/91x0Iwfsqrfc8JLH4zhi7N
         D52Nf1dwTQocR6fd6I3tQa4xKwNdMYb5ZCztvcWLQ7WWUs0SavjS3+EHqGa8OxHhk900
         3MEw==
X-Forwarded-Encrypted: i=1; AJvYcCWFMBvu7VCGLtAlLhTi4nGZFyRZG1HfBfDIRQp7ePRsqcEsRgVKPuM91Nc59wpf34bRJqEKjec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5cc/YHLbAkT2LjsDfoV5zv9bhfFD5kbxs353WTKZId7EHNQB
	qCXnJR/OqtlW3LvoXzCtO13GNFN6sZ8s9Z3KWpHplBFwiEFkNmJbeBU=
X-Gm-Gg: ASbGncs73Yptph8d3xrrqYZRdsnYeWsVMF9c9ixvEQ7Twu3bDYrH0uMtBKWcYXk3mIl
	10Fz4R//OKMvzHVW5od/8kP2/FvgKPQNLgKr45DWxcG9poaICm9xrXa9dAylXadasM3pxWThYMx
	2drc9ZNr90Cbji+6/9Isoxj63v1exwtUb5FN2i7tfBcooHYpqN7/IYi354Yk7a0fJ7gAKUFpsYt
	PXQmvOQ3MYgEhYP/7X4bS4RFANS1EQYf9VWCOgzgsY/lkKXmQQNulPzXzMgRD+DtqXOOjXlERlL
	xZvKTWHwAiEhfoD7eVRj671eYkLD1WRLYmVmZb1CfqZoaBC/dvg4af9p+VSjDHetOWxlWmpq2eI
	PPFBh9kFvYuyQPALk0eYhO2lDiDDUzj7NxV63738FstQWjcoMl/pTQvoXlUZbbcTJtUvGqDjjL/
	8mjHEBIqY7C8oZYNAxAaQZNyGnG4geGjoNI9hDPK08k1g1XaBoRCDWjS0zDsf01T8=
X-Google-Smtp-Source: AGHT+IFdNH7VhxLObVgENX9rgje6FV1wZfYNMIau0c1KMkhVCs+KdfIoLVe9mOYpYpw3Znyy+63fKg==
X-Received: by 2002:a17:907:3e0b:b0:b74:f827:b886 with SMTP id a640c23a62f3a-b767170bfcfmr2591448766b.32.1764263429134;
        Thu, 27 Nov 2025 09:10:29 -0800 (PST)
Received: from [192.168.1.3] (p5b057472.dip0.t-ipconnect.de. [91.5.116.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a4b926sm211121066b.68.2025.11.27.09.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 09:10:28 -0800 (PST)
Message-ID: <2d55a9b3-0841-4992-a3fb-a889df34f5ce@googlemail.com>
Date: Thu, 27 Nov 2025 18:10:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/86] 6.6.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251127144027.800761504@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251127144027.800761504@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.11.2025 um 15:45 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.118 release.
> There are 86 patches in this series, all will be posted as a response
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

