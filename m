Return-Path: <stable+bounces-111796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68887A23C7D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AED1642D7
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5EE1B4F25;
	Fri, 31 Jan 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="TNNHzvuj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400221990CD
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320556; cv=none; b=d9ILgP4kqR5g6/ziRzJxEbnde6I+CZ+ZsniPQhP1zj2kXWdKJvPccGzQ7DXoTynHm6CBA3aob1A3jtp2JSjEw1Hqr3FDhUgYJBBC86/B/KSqdh5DhVSxUGX1QU8TEquKSD84+0Z6B0B3W5jrrONWA1O65JY0ZRYLe1+mEIi/ZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320556; c=relaxed/simple;
	bh=IIYKwK6gZm3RIvkU5BV1j672fhQTKpiM8TLnp77ECi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgp0fkUgHHRMfcw177A3LU8m+cyYcGEoOvMEvgOef2E1F8ScElZeKSDBZrJ0ZPWHgT4ETUST4/HjrM51sA5SmaOc8QUiBjjaJ47dhP1sPtZECUFV4bW6uao4Gz9jA4i37ICz2OtEUGtY/TN9cDuUWu8h6awk7yAOWfVhXR2CAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=TNNHzvuj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso3216447a91.0
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1738320554; x=1738925354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBZYZHrEvu4xGP6oPB0bXa2YOEKtC4uPTQviRrKj7b8=;
        b=TNNHzvujLitZaC0N3syaPn552nxs0PmFz9PrxtWPDxcZlSGqCv2QHKR5sYrk77bsU7
         7dpr2LJ4qmkPGpLiPCITOa264kdzsk+I2QYYxsGJ3hKo6dNqtyemeLSS5DhL6c5/IZv6
         7W6EZjhNQZ9mRhhYSCHQHrt7u+LpZy0C03j/FPNmbY9csSNZ9OKkZkQSRr0jIPQ8IGHv
         ND/W0zg0bIOk6cxtSneGLWGg1om3R/fy6MukY6gYQWT/4EyE8Gdpk+cH98lHhzuXl5It
         4qFWlFgf4LtGs8/32az2qcM0/qxtjWtG7dw342Y/bdrCRGrU4BYPGAo+9kieXYqo5fQT
         u7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738320554; x=1738925354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBZYZHrEvu4xGP6oPB0bXa2YOEKtC4uPTQviRrKj7b8=;
        b=HY4/Z3G15UAHXyWlGvMPfaD/8FCgvv5ra3BqacwUQa9W/SuIx1GwvkEFvUEm5r/SvH
         WhjbuvFXV6v58/Ke6d5VFilIqSkQlZVr8B3IPKQo4HRwn24aZMjLXjw9stWvuHA81urR
         8zUi0eIRGMgLzDC47xWLJY+nqbf99/yWrMlF50RZ5RQmsR9c17yWoAmbVwmjA6ea0tMb
         9GgWYl6RcwBJfZxuq/tY6eabC1uX6vQ9GR3DS5g620gIt9s4ciJftL+IZ+YKJhPU1ieF
         ij9fgpLeNFAsgkrLJktM8fbhJ4KhddW0gPtuWyqZ9D+knRqGBCJAjgk3U19XMoM1+fTT
         u0pg==
X-Gm-Message-State: AOJu0Yw+w7CsQrmjv7+PYO2YaIC/d6/1DtXZ7vXBeqNex2bOGEAuDxmn
	Uoqfzzrm6toPHHukDVX4J39E24fqjn1fRQ2/chxPcQb3LjwrmqMok9211nvvLEtbffJxx5VDU+B
	LvZD1uHZc6C8T1thP8MjojFhdYydBq0Y//gjGBA==
X-Gm-Gg: ASbGncvV8s8YsG5q0vXsu0hcWQWxySrIy4HJBdGEu1aM7S6AwQQcJDZtLJKJG8tUu6n
	1bHvkqd+b1eSUBdLw+j6N4g4V/WhKsBbLYTayjo2KeYHUJq2qyzTBOlMTk/A5GJ1xF073wQgB
X-Google-Smtp-Source: AGHT+IFKMXzXc4z9qRfH0nkfTgT5sHmXwdaig0w8m4WIvvOQeXzdGBoKKtImAcaIob7KYzCEPrYtBvH67mycnh7TPDw=
X-Received: by 2002:a17:90b:2743:b0:2ee:48bf:7dc9 with SMTP id
 98e67ed59e1d1-2f83ac0068cmr16801592a91.15.1738320554447; Fri, 31 Jan 2025
 02:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130144136.126780286@linuxfoundation.org>
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 31 Jan 2025 19:49:03 +0900
X-Gm-Features: AWEUYZmlkcZeCyYCkqXYCWF1l8nqyTSyhAYJRU0GENQ8PIYwKOuQ7t-L7mtJL6E
Message-ID: <CAKL4bV6=tBX95okqxpYJy8WqdWEsteb3+uK65Zf1xV+K8y-Gwg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Jan 30, 2025 at 11:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.12-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.12-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.12-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Fri Jan 31 19:24:31 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

