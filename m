Return-Path: <stable+bounces-32172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312788A4CF
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9061F3E8B3
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D9154BE0;
	Mon, 25 Mar 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="cuc1QpGR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4117D24C
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363536; cv=none; b=sQD+uZvGnkHLmJY0vUxOyLGZQFN3KfkXZa4JzMB5x/jaUXHoVVWrYe4dVew5sMRCPOO3TlJjk1fP8ezq+tpzLMdAmnDm2PIuNPPsqvANcr6lHEvoTWnytbM8KuIQqhU3qJyRqWPqSf2fWMdRIxX9ZQFfZ1xOOaxffKMZD8dBFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363536; c=relaxed/simple;
	bh=xFssiSj+B3KNV/TbO9JFeIfvLkCfQkNPPPwZSEnIQqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF70Vk7KysbFj69bLuJq1NqtucksXi8yoimFrWnXMNewkeX8rFLcHb5LkpuxPIUxqtW2eSGngb5vXuEafyyFsdxudcOE0UlJcw91chmU65jQJ679gZ/9Kig8OjbAytgIslki6PWqeRWQBHg9G8CJnTLgYCdpUZXEgbcXMx2pt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=cuc1QpGR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1662271a12.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1711363534; x=1711968334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5cMpRTj9+xACED6ZIv7TiLSV250W68WovhxSeO3KTs=;
        b=cuc1QpGRC/xDtWsJ65VoyBozBo9WkqwnUt5HqH7IFGgOcZ5NhBPR9Heopyewf8TCat
         oRUzoDTt09FQ22LKMzYwFjPLCryLLR6+0KrgkVipgSPAeDPNevdna2iZ3UC8tag+vqqt
         xTRp2Nz1NT4E10kyd//PjTr1B7r9HKROr9Ex7p3zWQba7yh/wZIbLmDEYIrBwBocDOyG
         E+3T+U0T/OnWAW+Oex1Vofg06I+K1jHcwnr3hzehYRAZ0vo58+uigfnURsQYNP9V4viU
         RIIZ2wg1TxfAqwn7hFlF69AOBWKvh8Ed3r+9fqTp77kxxgOPyEZOz2R2m/lpZMcwa308
         d09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363534; x=1711968334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5cMpRTj9+xACED6ZIv7TiLSV250W68WovhxSeO3KTs=;
        b=lkC+40VrI2irxmcHoHusH3GqFLBFeUxou03bxInfFlDdImJzSoSvuMSoxVwlcBv/hO
         Du+HcW5uGw6GPFeUTKNuxQgtfqLrw4jHBuZe2LhrWU02SiEXIAlxp0yJjge5z3v18RwT
         vdDT0lvO8qwcfMladB2J78ypaXFIb1iZ47Iy96LwYmUUDf60mrN7K4MQc/U6C6aDdTUU
         i0kLiYQtQ6dZWFYaCrKrhAVKbT5rsUcu/cjfJW2VUREAd0uo1XYvsUDmoQm90TltvpRq
         YdkfJ+OsdAubbzbPPBliySFN2crgHuPJA5E+1hqGej2erEoiZ1j7q7l/5AVg1GZJBTvQ
         jqLA==
X-Forwarded-Encrypted: i=1; AJvYcCWEy1VYTGWS6YeOuIghYiauveQnYiyFtcFwbIi7xiWgLsrzBpLYxoSwydWC03BxpJg9VqgkVUT6+/3MRQHtvL5INoKJoqMs
X-Gm-Message-State: AOJu0YxK70Q6/7XwhLNFrzU9TNb2atwtDprv5fdV9j9Jut2Dgc8yELVc
	dYjI1fy5BV8Ct2WEX/MAOhfkojlKNtANKIjUP5gRom21OqSCGwgeNhwbnuf38RfTr6E3UBoDcZD
	mQDJGe4SYRGutFrbdFjsvqUIZXGdWfmjmva3g9w==
X-Google-Smtp-Source: AGHT+IGCBrbXDBwydAl/u/1jRtQ2p43hCT7EuFJ5ky+hUizJPwTTHeqXK1hV1/7I97X3IB5keFT0dPkbz8CL9C+BouU=
X-Received: by 2002:a17:90a:e608:b0:29b:3106:7f24 with SMTP id
 j8-20020a17090ae60800b0029b31067f24mr4321213pjy.37.1711363534117; Mon, 25 Mar
 2024 03:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324230116.1348576-1-sashal@kernel.org>
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 25 Mar 2024 19:45:23 +0900
Message-ID: <CAKL4bV47RJMAxTMJPkfHNQm+ikWCMEYg_NBfB+e0_6_7=+3fVw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/638] 6.6.23-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Mon, Mar 25, 2024 at 2:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:01:10 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

6.6.23-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.23-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Mon Mar 25 19:23:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

