Return-Path: <stable+bounces-184077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22457BCF530
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF67B4E795B
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 12:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7A278E44;
	Sat, 11 Oct 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Bs5gMXCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F132638AF
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760185620; cv=none; b=dTuVPJLuX8zXmkxvVIOw0fuU7F/P7Wo631RJ/uB4tRamwCI1UkVepm5zWz0wZ7wAG2ZvWSwu0iSMW5MID+tu8jR2FSPS3rMcRhSrECjAIqrCRXwr8sWAI7heLrWg4XDjRqnEpV6pm5n3JHZNFVjfU4hu0nbNwdz38+5hWPfDG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760185620; c=relaxed/simple;
	bh=d/gW+e3GHHoTmcok1pFTm72qSk5L+TUgVsoAgcd1XhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IALsU9KX7zUbyBJR+3sHTAyu6UVFjeL4qcTo3SrrKX0iERuHmGNFj6nI4BMbBYhtATYT8QJEAPWNQ1yR6WKhfAuQ/d2yhjki8neJ31PO/Kw2sNHYMZCP3HeHrwLmo+8e7HmQxD6h1LPsWveNsk6K/9qf2KFxBxqyIvAIC0DQRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Bs5gMXCP; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so1960213a12.3
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1760185614; x=1760790414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NAHnoAtDAEnsbgsmp2/eZQvCq9Zlcq/EHD9Uesa57g=;
        b=Bs5gMXCPcB2UoXYxrgl374eP6IlRa1XHOFu47mve3/OybCmbxlCccz95HsDHVs0Nz5
         qIKzTaXBORW0RumteK7DG/9T5nke+382oqi42jTCxefs+eFfOUYTDQjtXVenYxDgXTqP
         tpjhlrTFnXfCZ/fxh7X/+TO+vUX+7CvE3soy65KK1Mvf+wZQRUSSxCesig0WN+Cr5bOC
         PGxo6Z5Kv0paeD9Ki+H8wjvHcrY3xBpHodoEAnqdZe2u3VaUp+245IcGZxSILWhIV8Yy
         pj8Btyap86tuyvkBcoVFIeWJgZEBC4uSopMgRSQpbF8K/DS9MBOWy1/pdh4vnEQUpfO7
         nulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760185614; x=1760790414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NAHnoAtDAEnsbgsmp2/eZQvCq9Zlcq/EHD9Uesa57g=;
        b=cC29E2W779MS31mkRrBS/zIHxsul5ozuhwXhJi4GJdhHhFmeCy0g7GTAcLmlYvMRtn
         m04XbCFxFeqZaLoW4LQdiSIC8reoEmlIIbgnGR8kfhMqF3Pxbeu+rTfbrIaMEw9mlrRJ
         GbC1XpUN3Ng6VbXU2DHDq33/qxRXVJtfYq2fopwaQGlcJ1XZNYQZaHgjc4aOLDvdA+XW
         ximajPjERDgA1ZMrHH3PiZ+5ssBfZ8N23bjRa3ybpO+PGDgQJbOvp56QQVKz3d+Y+E5v
         FMkkog/JXy0IHmA7ZFwng14gGaY85SnssnUEE7v9CL6/5OAy350yvWTTxMPqNwBjRGQv
         xrag==
X-Gm-Message-State: AOJu0Yy4aUpz0krdw5jWkac66qoC3H3lGlssYZgGZr2ajIoAi6wB4jSk
	k3/loSpEpdrOAX7SMrcuIQxdX+NEty9ilUxSayzwvXIE9qH10vU8BBIiPyyZ4QAic0D/bbmifCW
	nrbKobhZ2PK3SLvgMWdXSe5lb9FGGs0jzY9eCRr84aQ==
X-Gm-Gg: ASbGncvKzmjvQfA5xfg0sjxhvIuSEeuDhSkr0XJC909BsB2kDbEWhZvzJ+3IbqqLwwO
	Q3mRVsqsRxs8roltJnNmtezqvt6Vq1PP/boRmqw3a2RLPG8Uy4IXtwcm27Xbtpp9EkFFcA+4oU3
	mUFdaDMV5K4P1RsQ7pBBlHoroE4irc1UkwtPZ7/m8lx0pjzn/waieQ6m9a/EU16BxK/+3IL0jwT
	s7ADoJsMdMvxASjrcQucXKLww==
X-Google-Smtp-Source: AGHT+IGB0K9uNg6w4xUEupnOm6RlbrvNDms4n9KNEcFdqdNDe2QcuThbe/3xmLTU+Ir4S6Gd+o3uf+iQiYX4+WiWYgQ=
X-Received: by 2002:a17:902:f650:b0:276:305b:14a7 with SMTP id
 d9443c01a7336-290273ef0ebmr198786305ad.33.1760185614491; Sat, 11 Oct 2025
 05:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010131331.204964167@linuxfoundation.org>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 11 Oct 2025 21:26:38 +0900
X-Gm-Features: AS18NWDBFvwGIZ0Nwu0A830RD6bwht5kpABe3Vi9XiyKw1xcSWYW82-8SOUaM2I
Message-ID: <CAKL4bV6WEAjVSDOXoh4KPUNjfK=QJ=1RjuXGn7_Eo5Z3VK90SQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Oct 10, 2025 at 10:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.17.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.2-rc1rv-g8902adbbfd36
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sat Oct 11 20:59:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

