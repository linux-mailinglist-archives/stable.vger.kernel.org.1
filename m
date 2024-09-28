Return-Path: <stable+bounces-78178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D975F98901C
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CB8282056
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91522098;
	Sat, 28 Sep 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="g9Wrf6Hn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C24204D
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537951; cv=none; b=PyMilKA86zsAxk6z0SGls4dsEFN/DxX+rF0lMpNUS5/mpsefi29dKpIbJW2Ibtn5PU8IttLGlxHF9ip7Ps2RIQNDzHRbdnujLQP9SYMLG8YMh8DKzErlJJ6FOWaApmi8aIQ0uNh729FIrZX7zUkb+F19aptykOsgeikJ8lVOTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537951; c=relaxed/simple;
	bh=Jcwgqmrk7hrevC2k2xJQkkfVs640nD7arnhpY4rl8lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJD+L8Q0dFmoPtB9Jb8AkdtTuBevtrZzpcbOyqtNCdr31H5aKJJ1L3Yntc+Ed6oglGNBj6v0HoaTNcsfR1VlmY5utheEjl3y2Kc79uP3iPV7m9wFLx1fEgImPIiRkt92/yUmIXCXuOLkbS2+MqRo0S+FUKqUzxhHSZB7u0KRUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=g9Wrf6Hn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ccc597b96so2079869f8f.3
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1727537948; x=1728142748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7aENbVHrbvubesI/cqKrU4sOUEl+g1GzFRVwX3oKYw=;
        b=g9Wrf6HnAk59KDHLgmmFpIzjj5LgFIIrfThLZvTrqHme3Ptlyd9LtRU4Yc6FeU1HMh
         pvHJQ2hXLJeL+YDwxApl/746xhCZtujmM2KoEfEDCW0QgvbZncjnd5CaJtMZY7V1K34G
         pt4iiJATqw47jljVxMf9aYVZu1ew3ynFzYGqdRSe1FummLKtfIThI0p3lSqhaF8Kibjg
         5am6As4pwPqXYDehXAGSmoHN8t7OEkQEStu6Mnr2ys8SnMgK4mLzH5uKADtSu6bvS86B
         WcanrsvBt2P8LbpJOpuW9UHh9T49xBhAqzYM+B7cBQwMlPNbH1p7iHyFaznWPLKd4dlO
         /EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727537948; x=1728142748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7aENbVHrbvubesI/cqKrU4sOUEl+g1GzFRVwX3oKYw=;
        b=qDKyptp2AmeJrIk+UeZmuEUFQ137XAqquOFJ9314nfxM0hARVlV0pM5lXuFCFkFaMj
         0JcqqA3xTFHWLYbtwH1lia3eYXXHSlLwoLTmO9KJuRiBSWvlNWVs3AsMwolpbLQMJ+a5
         IvgkNTMGHyJ5J5ymOPIegibIlhhthtuxYY0zxEYrgHcjGIqBglkj0psSrdQODDwDurUP
         7KV+kVXcMnG6cMbA3JHQOcbEA3yXyKTnvIpp//v2v3kU7GD2iEa7BCUzANk/bxKZHTJ3
         UpNXMLKPyYjq/9ms0A2TM4OwpnF2lq9Ecdw2tEuhHSUJFogbvORBzCevb2/RGmfddY1K
         A3Zw==
X-Gm-Message-State: AOJu0YxT+OhK1znIoHE2Xdd4P5vpOuurCQc/HVBqr4QTQNEk1b3p9bni
	exxtzx5ovUoRZiRWAZLWhwp70N2f8fa5VJeNcjiiNgt/oZVRgwr5veqDH47nCOYflMGy+HKtncn
	u4rL5o2bESUM4HYWptWokhofTv0cEwEwzzCC7lQ==
X-Google-Smtp-Source: AGHT+IENz0+ya7bPS4gQ8rnB5EDXaQ9xmNq2ebP8DILfBv1Tj1+FcWPvQW6UPkGkD9Bi3+cHYW6jTXQv0SY+blo+hDQ=
X-Received: by 2002:a5d:6741:0:b0:378:e8a9:98c5 with SMTP id
 ffacd0b85a97d-37cd5aaa6d4mr4083932f8f.34.1727537948113; Sat, 28 Sep 2024
 08:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121719.714627278@linuxfoundation.org>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 29 Sep 2024 00:38:57 +0900
Message-ID: <CAKL4bV6czyU05L2eUMmaE+s_fY_hX8nN6Tim7m4Fgvs2oDXZqQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Sep 27, 2024 at 9:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.53-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.53-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.53-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sat Sep 28 23:37:43 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

