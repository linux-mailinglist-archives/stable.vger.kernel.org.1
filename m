Return-Path: <stable+bounces-206209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5132CFFE98
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBDE53003FDD
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51932BF2F;
	Wed,  7 Jan 2026 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="PjNzeWWq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421D33507A
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816363; cv=none; b=Fij4sQVcfae89chCr5iRXqDbPAguz4QD7ntoGDycV0gVT8Oq+M6SdzU/X9KpmRxBAbigxJwnh8BNh9aU4yX4AV1ZyzMVAKCPGKOTBmOtSclP5LcVMaFalbIqPJb8lyOfVULf49krxQpcXELY4RF4T/FXHoqqUbxIjSJRw6bDm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816363; c=relaxed/simple;
	bh=t9A9hORhtN3HCYm96L1VHkZAq5Vd1DywfLUoz+Q5yWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPN1UZDoHxxA2LlnvEX1jm/Zg+1LfoQkyc5n89FYizT9hpvBRpSn2jwJKC1e18+Z3VSONtsj5oB84Tnf8Gu52Op6t7BQuF/Bhwx4ycTNmFVm8tBx1psHFcCYiUCUU9H6LCG0jzfCHZmxrJherWo3fxskv3SB9l6h5Lhett2zlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=PjNzeWWq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a3b9ddd40so16196826d6.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1767816352; x=1768421152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdItqAtOdKbHygORltxGl3KfHwHC+ySfh2k0akOHf6s=;
        b=PjNzeWWqNIH0lvyV2R1onU7dDqGgWC8FYbXKknD+74NeKeuojMk4QU5iUhdrVp0OaI
         /4ZCUNnazkVI/OTCalfEg8bSFYHOsutl1DKt7OCiumNa8boOO70/cB1CGpfsODpp+9wQ
         V1PygVLhjhwv1ybNvVZPBGAfDCHMKgaCnruU/l5PXK6VFaIGZIQd4WRElvaRGE+mSglZ
         DUB91bFDhvyHbKiPe+Xe2TCExYZn2OvJxERt5yniSnC+wE4C1dJo3WhtbNsRNsSDU2J8
         Ttx7feVN7mPDgVOucZlJP8rI/RFuV2YfeUPWTqtCj9Hn263Z6ux9+DCIGdyIXRqSCUhI
         Bitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767816352; x=1768421152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdItqAtOdKbHygORltxGl3KfHwHC+ySfh2k0akOHf6s=;
        b=cnkdXdJbopCQL0vSwhjH+hiREUfRmp98DXrpzRTR/cHi3c0EXBvCs90UWrWLKg7UM/
         tgNZR8QBuBPrhqN3hVkYTklgHl8z9ay8mO2qk8RAzn6w0TdI3EGbDqSzPCNXJdRZr8Z0
         k9bt48VbSFkecJQ2j1l2z7bpEGZ7Xa7Xahn87FoM8z5xevj3epGTKrDTQS2loRBKdSLN
         SvShRNfGi+T5+ZpfnJLkZUQb9ChRFSgWncmIpSioYHtfGpjMn4AylaCZ2f3mXOfbyEZw
         V2D1GdJn4+NQJzrmqk11N/rJJ4/RPuINmer8i2QUfrMzGJvNUyxcLAt10yDnXmTjJp8e
         3G4g==
X-Gm-Message-State: AOJu0YzUeXXguzxxu0ZFwbCFgA7A6v7+Y0jgsWtI0FFEN07gA8Q5vQ5n
	aBKJpb6MFbE0R+PKDMyqb1cWBTXsbZAPn+97q7Jxao0s51EFW44xWvApFuQ8ASR7bL73gEixCuX
	QGwPZFbmUntaTGeldNvjizXwgAPkFOi663PAh/Zm9Zg==
X-Gm-Gg: AY/fxX5U4x6yv72x23Pkm3zMpfQvLw83dfPcpl6KqHzkKkZMMjGlj5TjihnJLerf2zY
	qc/tznzQWdZr4HCdgmDjQC5+T4bMIDg3FJhZlcYgWFTj2XBLjwMybkVPzujTEoGUhiPNKErbLrd
	bj7zKOhKe+/52Xgvyh/1qwk+yEgmjPrGH7ft6O00FAF5VCslZoHyCQ/17mCM7Gku7OXec3SpU/b
	ZR2LDjDqEpjw4LK5jo1a6QLuZCl3y+m/gJbYHgiDN68YLo5ep4kpM4ha4YhfBoTvoGx/zRu
X-Google-Smtp-Source: AGHT+IEuk9tPmnvmyGvFyLAmgkHtv2aAK6/xA2+VUYm8MzCaKkoYfBuP8RFfZgyxIH2P6GWVu5oquafUmUEO3WWQfDY=
X-Received: by 2002:a05:6214:460a:b0:890:744b:9fbd with SMTP id
 6a1803df08f44-89084183a52mr49510436d6.10.1767816352044; Wed, 07 Jan 2026
 12:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170451.332875001@linuxfoundation.org>
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 7 Jan 2026 15:05:40 -0500
X-Gm-Features: AQt7F2ov7z1jVxyxz3XzKNh8kYSCNbZ45HWfSmYQ65xpT-Ot1X7tkmswrIwS-g4
Message-ID: <CAOBMUvjTnbz0t4sKBzSq1HWUGEPQpq1RQahY4cxVT=Vc6uymiA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.64 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Jan 2026 17:03:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.64-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

