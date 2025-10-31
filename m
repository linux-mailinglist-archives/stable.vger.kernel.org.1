Return-Path: <stable+bounces-191941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA95C25EDF
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C00A6350E72
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F402EAB6B;
	Fri, 31 Oct 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fwN9tres"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BD2E9ED4
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926245; cv=none; b=a96yVZAgxlCtYyUcvRmWZTDPRCMDQ+MzfN90lt2Mh7vH2MyZ2+jCQWZcaVMDvaKZGuK46cfZwgZSFpuU8UUbwdQF6y4KIFtC0e4csg7XJSuwtO0xbfNrCdbX682FnQky3VnytxmYkZdjUtLG20qT2EdgNowi49/xN5IhDKLYWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926245; c=relaxed/simple;
	bh=yjHBWC05s3h3HRSExiyGSQQjmN1twKVXh2uNlBYdM2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLxgJiyJrgPDcBEJTU6ohdGDIYcehuIWJVCVTVDgEk9pdYM9dymiioB5G6GH0XhW0OICL4DFsnGoXEpABabM5l69ekgh3r5oK4pmh9GEExawv8zMzp415f7o31kmx9oTnpTL1wjNAAZ4SnqA74kFrvSiZ4HSiZUp/dhtXfw3tCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fwN9tres; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b704db3686cso536557366b.3
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761926242; x=1762531042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nI+jUGUgrFwdA9J/BWhhFb2SDMktkHvnyj/zPRmzijE=;
        b=fwN9tresWOg1cdG3fZ4c832HvC+AZylVC3VBLWrDNFN3FFKqS/zy00NjcRBsU330ja
         VtiGrF3fS2pFsapADEgh9ShqU0GLfx/KNe9qd93uE6nVYUNjtHGq6pyPKgNOZptFXKH7
         6PabjL45+5URVvEJOoPoW15fkrNjGvxzBr7aqIrM2DFkasr+Q7/1wFl7iPvkfHvxYTwd
         TFe9igj9rQKn8xEXOrjrLp+jZVOxY6Rtx+4Z1ve2bmyVZKUf/phig2/fJMabRKHMRo3+
         z0gpvFJx7KJRb2Wxvg5onj0dcAdpyoJL4Bg1c8dAs9aKe+izobD63sAqv6VZksX/cEAQ
         STVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926242; x=1762531042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI+jUGUgrFwdA9J/BWhhFb2SDMktkHvnyj/zPRmzijE=;
        b=vYUuJAsK7q4cm8GM9uLXbbnNfxnqe3EyvYyjWDFzDxmspQaY5yiN5n4k6qfYOrmfnG
         zGwSJ+2H5v80NDtmdS5dpr6Ca0OV0W+3JDBpI+0igyammhmq0n1lQ3kpdma3TZ1unqLq
         E7XrpJbRO4sj7o4aL7QWud1/8IALOBFvy8RaliJ/mbkcfmv4k34FFX6GQ0dSbVc1ydfy
         S29azAgO5Um8mIJi0AEhuPd2HCUOYsC7KX5M7QjzgrHyN1LNqU4otlhYbxMBPY5hZFUe
         R+3oPCctqlykVj7yY72SU0snz1Qe3YUA9jXC+q86CEdyx1zshSmNfNTbJPRdgVQEwIm+
         f6ag==
X-Forwarded-Encrypted: i=1; AJvYcCURyPg2KWjJ73WQLa59aCpYJfGjg+l63At3dubl3hfDkBMJZW9TV3Osg0bH5WPWW5E7MnVeYks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeIc4bHEKSIkANP9XWYr1D+ibGxW3kkUtMj8bFDNbKH2eWM4N
	5d8Xdh8nTsldLGC0mHo3AC0jD/r8Vx/Qp2AacU5R1VDDO4fIO+GLgd4=
X-Gm-Gg: ASbGncvkprv7aULmddfAwFcBhab+Tht4E7o6IxLMtFd0IJYrwZwTh+vTyVMIkvGFtTm
	sNoAZh/ccsCK4Eg1RbJTS8CdO57V/vPCksr0chjMvQoN+HXg7GFg/y9EEzaGMyiJXVejNptyOPp
	gFieLxEFO95aBPjE9e54Zsijr7rT5KdHRRjNQydXDUSRdhsu9lZxY0BPPtkKITCXlTkBHsgeaQD
	bzd0YTLyoYuRN2H1GFcLnC0stdXacezNE1UQ2Mdq1orTCoUO72ALo1shPUAOxxkc/fUsz6lT0Ij
	8BrWCn1iYA7E715rPxCj1jyXY9qh9ZiCFPvPUku3UdnIuzqjP/+TljKv8TAHEX+ezZG4M2BYgu2
	ATOWFDdrsWV9emN85DceC12MMK0CrUKXpr3WqSf7CYNkjQLtFljLfBUnADP8pzlO1+fQoZQqRRt
	Rb0o/CtS2zZVfCaloVRjJZNvSqAZGZT3ngvL+vgTdl+xF6TwSUH0qy4A==
X-Google-Smtp-Source: AGHT+IHdC5nEkh3EIsfe801CuOexng04liN2h1LnrXQkauZMgdGcyum5TaU1FRbxBKL0FAJSkSNDMg==
X-Received: by 2002:a17:906:478b:b0:b6d:603b:490f with SMTP id a640c23a62f3a-b70704c40b5mr378182466b.35.1761926241353;
        Fri, 31 Oct 2025 08:57:21 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac3bb.dip0.t-ipconnect.de. [91.42.195.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077d065fesm206856066b.72.2025.10.31.08.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 08:57:20 -0700 (PDT)
Message-ID: <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
Date: Fri, 31 Oct 2025 16:57:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.939381518@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.10.2025 um 15:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
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

