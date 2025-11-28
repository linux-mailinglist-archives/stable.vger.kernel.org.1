Return-Path: <stable+bounces-197565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16BC91245
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53AB8347BC0
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE11288CA6;
	Fri, 28 Nov 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RODh7kAE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA2823DD
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318513; cv=none; b=hjxgvi0btCO8IClRhGh91tIJ3GQBvnBvRlgLJavpN5pkKHs9J0CwPbK4aGF/xZu45L/q/pkl4vdpanXBFjrQYUhZpgDDZZAGr217nY+LyjQe9j717GlBjaV/oDytvtfuYkNY+trsB5fjwJh+fzL8Hful89TadjATfd/jP0etdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318513; c=relaxed/simple;
	bh=/8MpVidaF0C2tottb6A7dUZ5ejYnmonLxpLNyjy3b9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjcxVZdoWNOQjIHXslnPeDGVOXRzefEgZHwyySJTD4npVw34/mG0sm6Ddn5K9NqtphG2MM2rxWh5CHfBlVdoLyWMlAzA6yjbjlwOfyAkENV1fM9IEoPz7OFgm2QNMI2otjRyY17oNHm67JOd41nDutZiOJ4Qip0uo/cluGUzkc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RODh7kAE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59583505988so2006187e87.1
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 00:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318510; x=1764923310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpQOTOoOF9sFuSAn+dzFUWimFlC8PZeQxb8bTh5aMpc=;
        b=RODh7kAEoavx4JiGNXBylizFuS0Ry549lKvEFEi7zEMSe/U2WJ0/et7Bwj8laKYaM2
         so/jVq2t1d2vxtyurrg0IF94ezldEiVxYHr68i07+SrXLZSO9t3/2cIGXLlO5evFmYVN
         Fh51yfvXl0OqrRTyGcJHaV9k1YRbzYgfdVPtARU6VMcylMzvapiA4Vev2zyrxDY0q0up
         6uEUCxsn+M/1Eqqgpq0OVCzL5jVbVBeR2zJCRxxm1XLw7UYZEVXhrdIje0pNa7iqn9Cz
         G9wT8XG9+mehq424IVs3Wm/HNKOPToZwDrgGBXvSDOnXILkt0a/RASKQ5HSnn9CVG+Uy
         t/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318510; x=1764923310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JpQOTOoOF9sFuSAn+dzFUWimFlC8PZeQxb8bTh5aMpc=;
        b=vWIxAOT52tIVM1HFzQ5v+Icsxygv8ClqMFmBoG2fdyi+hi978DUl/dIsiB8V23EyR1
         PUsizlyta0HHqO4jot2cqApHsKS0j+qqqwENNs2ftO49HdkZFzfQ/9MsnekqoX/EVyca
         dZGLOOAngiNfpp1LBvLpt/+r+eNp/gLc6YKm5VwhDwkxGSNm9yHPCb2s+//5wTIDi3l2
         DSzDuJYDJ/nRcYUyO291SskK1VWkXrL5i5acbv26ZMT1Ut8+5LP03qxZxG96AbsV8Yzt
         cykbmjKpPtZ+k0/F7Nd658FKy1K7eKgJrElrIXoWV6XeyhS0nYQNHk9lGY/tNwifZX6c
         yzDw==
X-Gm-Message-State: AOJu0Yy+NCJ6MZVMl+8sz9kOQA++D+RQahwGU7dJtyzwGQxup2Lfh5ln
	7YF2Eri2ZICASvn6oBE6rGvffMs+oV1fqIyp9xrovKwmX3OI0kjSXKfcdU7i2gyobnHSyUAJP9m
	xE8IfBTNDTpH6OUv9iCF/FPVC1FnIRW/jDCsf
X-Gm-Gg: ASbGncstwlb8yB/pXZ2L6N9x0Ww8ZmSzoAfNt/jgxFTKjYUlrKaPZjvyP0u2YW0nPpq
	mCZMCvNnJDaZ4IuJtyJJEF3LLZWJrHPM25uroird9noRjKdePdiXzielVWVbiLb6bYE6RpBMoqe
	gA7/LfK82StZpnfYvltt1qoAXfPQk/CPKIHvKeMIkSuOVk0aAcnrsfA5gS/ncrkFSDPc4Hq3X6N
	gPEZ1Yynqwu5DyZhGTZO9iRpog39ppb3t7MlX8eraMpkkVHyb7ggJUp2fH9Fmiw7r6CrD9Dqoql
	aeDK7qe1rUFfF9a52Y9XKaarw4r1r3AQWtCplQ==
X-Google-Smtp-Source: AGHT+IHfAwSo0cIUFrGGbj2fEYULevXZsHUaUQQqiCzQnU/McOErCMAsLIvu4tf93pcqGd5RJfQKdTQbEbhuG6nMEaM=
X-Received: by 2002:ac2:4e04:0:b0:595:90ce:df8e with SMTP id
 2adb3069b0e04-596a3740821mr10010768e87.5.1764318509959; Fri, 28 Nov 2025
 00:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150346.125775439@linuxfoundation.org>
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 28 Nov 2025 13:58:17 +0530
X-Gm-Features: AWmQ_bmc_K7aCanFLO7qdo2fGHzO0zxm9yMvnui6MUBzFQXyf4lOh4FX9NEdnTc
Message-ID: <CAC-m1rqSYR5ytkSvFXkbG+rdeRezjYAiVmVWMYL1F2ndkVvKyg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, 
	Sebastian Ene <sebastianene@google.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.60-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

[ Please ignore my previous email it was in wrong format ]

Build and Boot Report for 6.12.60-rc-2

The kernel version 6.12.60 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.60
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 375669e5645f465d87d534f0be2eef993e3c7bab

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

