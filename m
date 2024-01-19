Return-Path: <stable+bounces-12260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33047832845
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF108281964
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC914C60C;
	Fri, 19 Jan 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="otQAfsPh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7C2DF84
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662291; cv=none; b=Wrk6/bbh7YkosQZDX8QABhntBRXycaQ8HyJ1o8LoKjLR6PMUbMoypjGs7qaClY1XWhnsjQe5UdLX+t/GTRbU5UfjS34PdEmLgE2hM/o7clrUYsFHNdlgOs7uRNmsm/Lag35Qdz2NQfudhZ9Sx29+H4SGnVj5IEOx+pQaU2By/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662291; c=relaxed/simple;
	bh=s/TnUOaVcirHIg/27RVY/AorYQLtc2gpCHWKrVpCmDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ1zt06mTZWtVw1ZkGeaGY+wGrz/HOBZcmNM1bmtdIqqCzkvwvBs+DyS+8KE1xfh3nXB3HNpZUKGu5ustRXr7EOXEMV5p1UrFcKDCGMIjctWnXjM7+pkKiCDgeavPCDq1CLrmRFAQeP686/uiy+h/HroZqb0dNR7SyNbiFRhQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=otQAfsPh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28ff6445faaso657965a91.1
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1705662288; x=1706267088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4xkGKMnZA+oZi5Rpvd1qJz0dx1vB0koQJUBRdc30aQ=;
        b=otQAfsPhsqz89W1/keFEunSR/azQx8eL0jxArit3/jJknWyGKzLxlIbZ1oNJrE5I2J
         +Oh8QCjV2vheJYZMp5GOqRJAwNMDWUC53eI+qNtx4IKiDLeoxmneFOr2bLNsJCmWIQkF
         VnGWWZcTQiEjT6hFQGMiaOL5MiBVKizUO8U5b8uiYKdeHUEXwM4oezpZnd8KSduC2KR8
         RZSEgBm7deJ7p01AT/NVH7oQ5fK90nlAg4v1Q1pPSrN966xBNPmDCi4g/dU41EtzheLR
         +NXP9p0MuRXPzIobhHTwdR/lz6r5tCdo+yn7jfWKORZhJlR1SARBQCIGlWQNATYUdSOZ
         gulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662288; x=1706267088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4xkGKMnZA+oZi5Rpvd1qJz0dx1vB0koQJUBRdc30aQ=;
        b=MLx/abyrzRc9D7oiWOudpE65UR38h/f4a4JF5eaQzm6seDaYvft8rZvAIOJpEWJFEk
         oC0016qe1J4Ne/ocuMZINyG0wtlkCaO+KGyplRYmce0zwD00oXJDZFSjRO1TRfaCehQR
         aULe7jvnJYLEiRCs4296XPfYobue4bx4A1nbbBq0QlGehAUtjJL3+Fy06gyRI1iirjrW
         kPeD6JlCgkBlxCDp2ZHcCCjtdAJXjGewHVyCJNhdLf9pnQ4N8PIAd92z3dc3wdfdQMMv
         bZ+3pEOO4/9JAXC4WEFTx5BElWlf/lzISwPkPRaxBt5eHJjalE1GlDvPG+KrzgVZuDIT
         /yFQ==
X-Gm-Message-State: AOJu0Yx7b+2U1+L2w2doHjdwJuaAoqeu6qQh9Hlj/8Z8SxbcVr2OIjBT
	Z9lrZY8/WzhJpxFLhtfDTNBHSWPRtNfW4NnIS3SgAvKzgJ+YPHRFwwo/Qi56X6Yj3h73i0aDwS+
	OdqCtyXkQzDDgYNYBVB1CRM0LqnNtxr9SWhbxMg==
X-Google-Smtp-Source: AGHT+IFotxPDd4F3itxeYpRkFweI0JG79cmCQ+lLF2JoYLy0Qd3EZyAp9j+bDU8p23blDHElTZaxPzY/AvfmK8F7adw=
X-Received: by 2002:a17:90b:2285:b0:28b:fe06:5dfc with SMTP id
 kx5-20020a17090b228500b0028bfe065dfcmr2116750pjb.29.1705662288325; Fri, 19
 Jan 2024 03:04:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104320.029537060@linuxfoundation.org>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 19 Jan 2024 20:04:37 +0900
Message-ID: <CAKL4bV5YqPvGj5aChTaXCAhvimGjU2dWWhEn5pykoaMj3AcejA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, Jan 18, 2024 at 7:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.13-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.13-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Fri Jan 19 19:33:56 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

