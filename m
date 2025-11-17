Return-Path: <stable+bounces-194997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C8C655D2
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED9D04F2EB3
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E0313E36;
	Mon, 17 Nov 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3w1EO4G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E31314A6B
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398872; cv=none; b=jiQhSvo3/qaAuJobUPBx3BactFLy8q9w3tEhinarbVoAHkkt5T3somHqXgPTOSIvusnndvrD5jlFQl3ESEWMlQ477YOUySNnRSWA5tRKPlTBFXiVIjvmuwGAWy/CTJAtR3HOuKXOh10yNZldHO2fk1IvGCKgLIrfCbPTba2wITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398872; c=relaxed/simple;
	bh=a0gmv3cr6yzpTZMCrPFgXxaJnHAafIdNRiQ5YegVyFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5GQQ+dTCLRMqtCWARU0ETkOJC9YrrzQM+OKER4eiUW7ckku30P8PCxgog1oumuX+qxKT3PEGYlKOIWJ63cwBUUnvOsEYvLBhODkZbNm3MvfbxrXBT85ZnYGMIKiLw+X0+fwiHrGbyoYSWcFln9LlcP2hJtb5Zy3I2cUomToh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3w1EO4G; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so23492405e9.1
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763398869; x=1764003669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrvtw/Rswq8+B9TnlFi2ew9Mp1XeM0WsQ0OHTdv2tl8=;
        b=Y3w1EO4G1uaK80fy2uMPoSHuJwjwVCSTevnF+XzmTVLsxMNBwqP0nkqWxlpZPghyyt
         FOQMLx37Z6MP0agZQ1iovJwziJumbIcHTzU4qgm+W+VML272itzwF0J7u9cQjxlBoxCJ
         BSK2Qf2y/g3g/c0dqhPCpweAfOvjjQ9ndovA+qnSNAgcUo/OYyJvrfNYBAj/nE5xBF2i
         GUWC88BSBeSPo+2M7KKICqW8Z5BSpkKfX/NNwgfZLU4aePGzR9urPnaBkVNg/up01/Ri
         CZzfCge5VCGbGbTd/N9kO3ylycUWZVrFXyykmuDZspSNaaStPynJQhQNe+HLBTcf59nJ
         SAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763398869; x=1764003669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrvtw/Rswq8+B9TnlFi2ew9Mp1XeM0WsQ0OHTdv2tl8=;
        b=XdDPWY/WaLyE6wxfg8R5Hk1pnL0RMXg0beYungDbtvHFzuF8U6wrS9KFYk9RPUg21b
         raNdYT4oNOY45edJorbGVNEEMBFIOuafAMaTv4dYtbuxKcoqJNDHKPwntAXqYHQ8CDLC
         XEzTVLtk+mbZZHhDuO3hnXtA7dRaSaxWr69+WG/v6ys+FZ+YGZ7mqYgRxXaXXgz7o87j
         fUOmyZKIHiwDGiqn2kg4G4rkjGg2HzpRLj/QjXYljxJhd7vE6oft9G/8m9BdNZD7lue/
         rzyvBCmrQFUqxOkFAjvswCK7tjFfMP+HKieEaS6mI9Hxf6diX/2yTDhFUsKXUIrAW0Df
         GG3g==
X-Forwarded-Encrypted: i=1; AJvYcCVtQC7AFiRs6YKElPRn+uHd4ZmSFi2LTyqhBD1dZ5lQwy8l37fEIyogq/H4ZE2CGBQ5aoZ+Cyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrPzSCn6wAfaSkQ/pj9iuvMxze65F8T3VucCVyKwdYySncFN6
	GwbJLGN38HawfuoO71oPuEsrZI98q8jG1TkcSTlXWktATPMj1SuECYvkz8JZ/8bZXRg2Oa4JFgc
	IvyVwTU7B6hg3NRqQHGvnsBgF9o6LZU4=
X-Gm-Gg: ASbGncvsXHuTgrxcEZcmN1YiYgPTFhTq99oOOAGF4afvGA1O6CPWyFQXPVwBTS2Weug
	R9+WrcpHogQ7u6MTrfIqSMokIZOJ1ZppqPWZpQFExaqe/yZ4U5pSkxOAKIAhh6UBNR7tnvtLU+F
	if4CAM6EuspLhkZKWjBa36luSTVWQ3WXPYDxmbdJXUnxgOiZJMOK2XA0hJasY2z4ya262KJ9hxC
	DsKIiQUx8aIyXEL4eDAYGKsDU9tqFH6hEAlM6h6JzY2RqvkgUBrAXi1UlnO6PqWaXY//+mU
X-Google-Smtp-Source: AGHT+IHc577QP/XWpm06YyklOAy//OYNIlKxETH+iz4sWNeks3uVvpT/Bd/YSOdVpPYJRI9WOaWsm75J/zxH/lh3VGk=
X-Received: by 2002:a05:600c:1986:b0:477:28c1:26ce with SMTP id
 5b1f17b1804b1-4778fe41be4mr118253745e9.7.1763398868617; Mon, 17 Nov 2025
 09:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
 <aRtM1qdOprtHrw4n@laps>
In-Reply-To: <aRtM1qdOprtHrw4n@laps>
From: Max Krummenacher <max.oss.09@gmail.com>
Date: Mon, 17 Nov 2025 18:00:55 +0100
X-Gm-Features: AWmQ_bl8G4BIKTtRL0DktQi_qrY3hm8E1p4iJbPM6nIlCRMubn9bxiCX-G_2754
Message-ID: <CAEHkU3VOr0NYzmxhRM0eJtcVYdhy8F+zxmqebg5UVV4KYGpzeg@mail.gmail.com>
Subject: Re: 6.1.159-rc1 regression on building perf
To: Sasha Levin <sashal@kernel.org>
Cc: Max Krummenacher <max.krummenacher@toradex.com>, Ian Rogers <irogers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Mon, Nov 17, 2025 at 5:27=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Mon, Nov 17, 2025 at 05:00:39PM +0100, Max Krummenacher wrote:
> >Hi
> >
> >Our CI found a regression when cross-compiling perf from the 6.1.159-rc1
> >sources in a yocto setup for a arm64 based machine.
> >
> >In file included from .../tools/include/linux/bitmap.h:6,
> >                 from util/pmu.h:5,
> >                 from builtin-list.c:14:
> >.../tools/include/asm-generic/bitsperlong.h:14:2: error: #error
> >Inconsistent word size. Check asm/bitsperlong.h
> >   14 | #error Inconsistent word size. Check asm/bitsperlong.h
> >      |  ^~~~~
> >
> >
> >I could reproduce this as follows in a simpler setup:
> >
> >git clone -b linux-6.1.y
> >https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it
> >cd linux-stable-rc/
> >export ARCH=3Darm64
> >export CROSS_COMPILE=3Daarch64-none-linux-gnu-
> >make defconfig
> >make -j$(nproc)
> >cd tools/perf
> >make
> >
> >Reverting commit 4d99bf5f8f74 ("tools bitmap: Add missing
> >asm-generic/bitsperlong.h include") fixed the build in my setup however
> >I think that the issue the commit addresses would then reappear, so I
> >don't know what would be a good way forward.
>
> Thanks for the report! I could reproduce this issue localy.
>
> Could you please try cherry-picking commit 8386f58f8deda on top and seein=
g if
> it solves the issue and your CI passes?

Cherry-picking commit 8386f58f8deda makes both my local build in the linux
source tree and the CI setup work as expected.

Thanks for the pointer and fix.

Regards,
Max
>
> --
> Thanks,
> Sasha

