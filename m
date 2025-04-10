Return-Path: <stable+bounces-132029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649CA836D1
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 04:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DCC8A05CD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7271E9B12;
	Thu, 10 Apr 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AS7/sY4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6181E573B;
	Thu, 10 Apr 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253212; cv=none; b=p60qevsWLlkhmStClD/M8Izmjfe0Mb1/jR2dIMvEqpaLamQss1cHyrzfPjWe3tVKuCLVVyjs6EaqH/MhO5F1OtBuxeAEUkvPk4xQgtVMmXMZhUX6+mJkdpevULZtlGd5650iwz63W46m5Y/PpXhs2qaOJKcLTEieHlEkfdcIpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253212; c=relaxed/simple;
	bh=QOZQEHQyBXXxcPrT6oX3nR5O2Rhae5MEEUplAr+tytI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb+k8T82P0Sr+IskxZjsTmeY5zKfBJ/L2ZVA8HEs/UDJsZHMwrMoesjajkRdN5TwVt5Qbaarz4wBe/83FuIXVT91j0pbq39+4FFpmVbxDZpf1++wsKvUrr3d8SMKga3oHHUwGAILQOlI9TSRRqltGu4bPayiPDPeUQaLK9IRcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AS7/sY4O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39bf44be22fso112241f8f.0;
        Wed, 09 Apr 2025 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744253209; x=1744858009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ph0sMnCNGa5VTSi5U0q7oZGDLT8fbaCzu7xWDmfDqw=;
        b=AS7/sY4OX0R/rkXbtOcl33kO7nbq2RlBfNey/rmXr+qUjotIH3qMO7sEr0GodFktR5
         DzRjiJq+nOjXraaZoBp6xjIU65/mtjKKv0Sl8ge2CbzTdcr24jl01CAt9SpRtyGz22qP
         F8hUDLahym2qSS06MmcyzMeqV13kCEe5D5sp+M6eMzclez6gj2jnOBmMO9P4jwd0W0pS
         v09gECzn/aA2JXdAzFvFvyuqntV7RlNtqSTQfYqir8WU0+ZoCVWXfKSJMJm40r7BFS8L
         FKN2UiCJO3KOg/3hTlfD1tADUqRdKhQvT9PedjzLCAj6pBQ351HkI3dF5Q54LorHooUa
         0rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744253209; x=1744858009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ph0sMnCNGa5VTSi5U0q7oZGDLT8fbaCzu7xWDmfDqw=;
        b=kf4Cal9XfZlvrabgYcbfz2cnpLosCbFoAd6jWe/1QAOR/zl38ZEJ+96IrIejc85tkz
         TGSUDOH90aFmN7twEF3JUjU5BApy/e7Hi8xBRDEZYcsWByMySy1JN6aupAvY/K7wEHrr
         1AL7N5FTgtAQ8/zLzkKs4aWH+w/raUT41osa7PNxIbjIZFi8OzPXZrNKOT82ncsMB9q7
         yUl/hoL8HN1wrej5j/16eUPObzSRpjuXRedPYpyBQXRpO9/orymc0fyJt51aZvbqBu/X
         qznffPj1JA2zkC5E3vpfUj3KDE3y0KK+ii3ibqTSblbGKTAK9DzsAnDqDlvwGaN6hwyK
         pVLw==
X-Forwarded-Encrypted: i=1; AJvYcCVFKOga0ywX/23IDiRgNpZDj3mgxz90C3Ha+08UG3xSTo98zU5Tmke3KBRCSsa8AYHOX+1CPyG7IOjMIFk=@vger.kernel.org, AJvYcCVhQw/zxeBEvTlGtsbUr82+3YTJbBnghpHYvErFip6jduEH8B4Hl+okR93rn44dH2W1ai7ATR8/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KPmMGYLMUyF3Gj5bm/7sJRg3jfjVu5pjpvVdWwt93I+JaShT
	DDEuN1EzrmSh5KxH6zxfyayHl1TTku5uEZTKqqI3ArMqWfpX61s=
X-Gm-Gg: ASbGncvd5wXxcO9GTqMu40wfdOHIGT4ZD72A+aKeExsOuZ9Ix+umjU8JA8kJtNHQCpG
	mzmH2zc4ojDweaVx8sPNk/b0Gr2mcZrmuxQsPn0O+5EPbeAVMff05Ki1lhuNCKboxjYT7mHslu1
	3WlB+QEc2Ld3FUZR+/cJUvwN471w+JhYWDmtxNIVbYu2eYeis9clPpISYkSjiiQDsgC91Fh1uA8
	Snz+HwGygYADmEi2ql1nDha51xrv9TT0cNOeooyc125cfl84la9KcEX4afMBWG8GTRC+RWwEvgP
	sUN7Tq1EFy4dXFncJ6oH0pP/xKlsuzKvuQZXGUMEnx4gQNzvRbxRPoJgEwWBajI1aYZM6J4YnbJ
	pvMOfCx0vdy0yT2/q
X-Google-Smtp-Source: AGHT+IHOE7jiEy7hV+dNeZEvjMEJVqKsUfhz2BDR1aM/BcXoA5fDODP+FoIOTe8FppaftAyDPrucgA==
X-Received: by 2002:adf:b643:0:b0:391:3094:d696 with SMTP id ffacd0b85a97d-39d8f4fa19cmr511308f8f.54.1744253209347;
        Wed, 09 Apr 2025 19:46:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b057414.dip0.t-ipconnect.de. [91.5.116.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89377785sm3229950f8f.28.2025.04.09.19.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 19:46:48 -0700 (PDT)
Message-ID: <b0b3c83a-862c-488d-bb05-67b9d3a5019b@googlemail.com>
Date: Thu, 10 Apr 2025 04:46:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/205] 6.1.134-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115832.610030955@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250409115832.610030955@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.2025 um 14:02 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 205 patches in this series, all will be posted as a response
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

