Return-Path: <stable+bounces-28146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F4B87BC57
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E58B23F06
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673D6F51F;
	Thu, 14 Mar 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="GY3fyDat"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82576F077
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417405; cv=none; b=lvwo/HTjhZYv4KZg/MK9SHAo8rtAD5aTRGz2jvQe1owjS0bil7255hcZcZA2La8/T+UAfwGf8wYJvtDszyN4dZy4mlPM4wUOInL3zetW3ZmPRLRa3nGGRyaNGg0B2x+5OxoDT1GIKCBjMZ3nbzUOCf8JxZkbM49i2c2p9ZHFyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417405; c=relaxed/simple;
	bh=o8OahQ2IfKmevJvZ/JlIf3M5F6oSHP6kSEIatKk9MuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8J1t1Iblbo/pxfTH1KGiVKczRz67Qr8ifd8QyDru95tq9O+W+4Tuctq2Ep0cpA9QehXxwcdc8ipZkL5GUxmuyBZQrFAAIVwfZwyNR1+guxycPRvfYJ/bTUgNTZ+VhPUXug5kEWSVlpNVFHOpYFQzVvq34Ugu003YJ5RqVBoRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=GY3fyDat; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132600824bso5043705e9.2
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1710417401; x=1711022201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63qU1pQexthQyQ0D/vKb5+706irrAm1wxcqN7e/LedA=;
        b=GY3fyDat7d1wMwfK6zDoT07xYEA98d4ISYeazz3llzBQnjGQc81FPm1p8VNyDlslvz
         easz7wdPpjcv8FhKhrRU7k+ZVhLbieAXG1SReasFQ9suqGGKuuHmldOIMMnO9QXmTKhh
         n6W1/+tmy/h3wLKvL3E7QytsfT1jOGceob6tI9ddSmHhLMyIEyyKRrp51N68JuyK13O1
         sET7+FD9BWnffP2l2Ya4uY6/8FAU9aebljXFhV9XH6cD3fBf/j+ajNcheA/uj+VcbWAe
         yfIx/Mluno0r2DToLNN17yc495ayUub2NmYeQ0M/VivR9qjk1y0gUYjqnul3ER9G9iUw
         0Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417401; x=1711022201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63qU1pQexthQyQ0D/vKb5+706irrAm1wxcqN7e/LedA=;
        b=Qhy72kjO4JVDm5mHXW4f2TueYed6iEUW0M781m30FDbgUFzaBzSc1YvcEWxgDFpIvv
         bXIVIB7ws3U5b5yGdAxKyUdDfPbL1IkNn733HkuD9bfQr0KmQGNtKOI4RrmzfjNRVo9B
         qGKjXa6tKrqf/dI1WqUpM6lHsCkN5q/v64XKo1dUDBej9WO6h7REJ7urfRq17aD6JLNS
         6HTvRwuLDCgoS/BNpYZjcyIIVp0qw2vlfx+Cp1C9BPIrTjjCmkMdjVjMDRU9CicPcc7Q
         Hn7Stt0miL6VWefIWTMz8t/HSRAOKYllJyUXCpxaVRkmLVdh2KBpS+fJChp08s4pV1+m
         cMQg==
X-Forwarded-Encrypted: i=1; AJvYcCXKnzxM3Lcx2PAPiLbEn+MZXWjwq1fr1ICPficMEVRXNB/NTBqVsX0IKoRkR3ls/AYxVNw+vG455OG2g938IfhdswxANpCv
X-Gm-Message-State: AOJu0Yxhr6NWWZ4pgzITZCkbUns0zUTAX/BtpEtQYtaePj1Il48sJK5b
	F/9rqNQ4l45qCPu5T+9EabAF2qBPzzRbJNf4R37wPeZgkUccjA0X69kw7VU1lHaDBqoPGdS+O4m
	e/juJHm/PiPTT8mV9FC54M4FCooacDg+D+TmJng==
X-Google-Smtp-Source: AGHT+IFS29KIbWdyvDFQopfiWBYzNI2pGo0ACAdrx1xRAA3x5/leW1fMf9iwOy5k/p6QAlRK+7PmS5w1/QiFLvBOFj0=
X-Received: by 2002:a05:600c:3d96:b0:413:1012:5b6 with SMTP id
 bi22-20020a05600c3d9600b00413101205b6mr1224527wmb.22.1710417401091; Thu, 14
 Mar 2024 04:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163707.615000-1-sashal@kernel.org>
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 14 Mar 2024 20:56:29 +0900
Message-ID: <CAKL4bV7Nr2h5ZLm4vYBOtEd4CQ0w148jwrVfktGu6_0pDwHQGw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Thu, Mar 14, 2024 at 1:47=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.21
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

6.6.22-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.22-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Mar 14 20:32:45 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

