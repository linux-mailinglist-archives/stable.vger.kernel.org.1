Return-Path: <stable+bounces-191427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E2C14384
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A91A63A92
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC93074BE;
	Tue, 28 Oct 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Ao9ZCU5R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54302304BD6
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648571; cv=none; b=oPx9YoNN9r81LAnc7+cN3WR/H4qqozlFLXiv5ki9RdyLC0s3oZK82819Ug3pOTvlqw0ThHdHt2OO7LAY2LQfEDR4rDe9HN+r1mSVDugWGdL63F1m05ecaVPULAAepq3mnJvd9Bt93p/a/ul7x4S3EehHpreKgsU0Fn3PBae7bhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648571; c=relaxed/simple;
	bh=LfGgAPErQXeXoyFHe8PvWIEu71qn/w79FkU6l/R8Cto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kx/GeFsG6bS4WlJrqBAO2O3i34dwg3LaY7NOZCzSLy06GjyXrdjTQP53iu12LA3pi6LoCD0RhdeXBv2+ev/pdvG/3JaXwopM4InKAJttvFgrpLwoUqKNLkliMeI0hDfI7GztYDAQDr4UY4As7k6fNHJwAzuVn6rRATQtdn8bgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Ao9ZCU5R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290c2b6a6c2so60726975ad.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1761648567; x=1762253367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyrXWow90L7YCheeS5gmaxrFltylHWAvgVWWr3hrODA=;
        b=Ao9ZCU5RVXnwg938UrqPIaYSy2ZGUgd8IuUx7mneUm+y6tVcjGhzLt2JfsMwvg3JsY
         f3Er6VfEOzUd3nDaeXKXR2Y/juUz9YobcjwaK3IcpVw2W+02nmakoFy6ZTlG6a7LFah5
         m2Q+0A/wu1rPuP0POzmLndlHrFS8LAmJl6mqMac1C8Sts2+xRHnyLeb6kFYwRZTUKDk1
         XvH7+4TUWAzfQ4PdI51imLfAbaVfqJGmFBARX3WBzBfxRqOrjAk6vKt4KaWFPT/YU36i
         GEhq7FZxb/BUTw9t120+vhueOBAoEUs7dK0hS4Y5qkHjqAMkCf/gxp+eBHiSrXq/z1YQ
         sh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648567; x=1762253367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyrXWow90L7YCheeS5gmaxrFltylHWAvgVWWr3hrODA=;
        b=uO0fdw+UAmkaTyXntsY6y/LWOW0cTMfABUR0c1XPuoM9IqTeZvlug/DzqGk+dfhxhH
         /KUL4qXAob/8WstHg/CxsOQpiHXLW/1+wRxyVcoQQq9fT+YyCQL1zXYX9M//StHR4VVN
         LNwpi2xXcbQ3gjqrezRSkN0n+I1VOak82UPd2Uyhadn8EqY/w8B9AA+6eHeIv/YP/JIC
         d9gU4LULJxHNSnupoxicA0Yv1W5BScCyccNPBYxzDMdtNwrnp/IVzyraVt31gpjeVELN
         bzTHwtVbiARMJRSEt/NiWARq1y4BYcTB+zaCtOGWUsFefnoGu2dM/UWTvi4rstZwt3sU
         AbJw==
X-Gm-Message-State: AOJu0YwvMHqO0bVyL+0US8gZiM98bbvQK4Lxz6cJN6nUHHIZ9SayJcKf
	jO4MdO7eEUSv8vebbR0mcWyY2RD2fqlztMZ82entcsI4fMMI2hEmHTaEigC0/n45WKRqGuap0pF
	+4PFwW3xFg0LLS6wV8ZqCV0+YqvDB7QXTjuq3wEjoZ+RqsS39PHRshdw=
X-Gm-Gg: ASbGnctq4t8eJBo5Ao+4D8gQIafSsEY4k/1Js6hh0QpLQyi77Q2fCnFH85BqIbVxhVI
	jys81VhnXkOZZIoiVnjI7MQpotTF9EVg1vfkJibfrrwhObl3It+AaVYyozyQTaklXCvnw0jVeGp
	ie4IJipKvZn588sNoLW+7/1rnQgNnfX5dprnmCxpDIEm4XcAEMsmoykd5f5n5+oGEACj7lGQ7hP
	wde7wwFX7SUGxCOGVbCITXY3xlg9+w3u53qwNBRq5aU7+ZdbJpH5MKC9sJx7R2VnX8+n8Ne5xA8
	zP18SlGp4TdYzTsiag==
X-Google-Smtp-Source: AGHT+IF3dhR4n5aqKeDp+Vo+LbBF2UMwZi7my529wiBD8hSsnjWc+zt+s30wJlDBzL40QuQ1+dCmkhZugs8gcsNfW9M=
X-Received: by 2002:a17:903:1249:b0:290:9934:fd04 with SMTP id
 d9443c01a7336-294cb4f2ff4mr35535735ad.28.1761648567248; Tue, 28 Oct 2025
 03:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183514.934710872@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 28 Oct 2025 19:49:10 +0900
X-Gm-Features: AWmQ_bkjtaUA0BELjnw4P7h6Xptc718dXITNsaZ_Mm7C6-RhotK2D0-z3iB_A4s
Message-ID: <CAKL4bV7qVfhVdp=gDShvsjLY4g0asdhTmgsT2gj=FC_4c62pwg@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
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

Hi Greg

On Tue, Oct 28, 2025 at 4:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.6-rc1rv-g10e3f8e671f7
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Oct 28 19:19:34 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

