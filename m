Return-Path: <stable+bounces-60461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 781319340E0
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F0F1C216E2
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005F1DA3D;
	Wed, 17 Jul 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzS9NkiI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899B1E529;
	Wed, 17 Jul 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235535; cv=none; b=HqBjvUdTswhQAfdZzRF9rzqx3fxKcOE65IW6gclxKVCSVzemJN2kkhDHzPDm1251zmjmX0afX20jZsc5FKihdK1XDHKh8RBB6lwd7pSyIwwWaoVHJ+8nrUXXHJXuNs6igP8ZTHCSEOdObZucMdaNIYclTnXHoUw8gucCioorXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235535; c=relaxed/simple;
	bh=J/fZGIcpVgzURWR0AKdnRLBbXlQuODVg1v5+8HBFdME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buf3jtGrsnztuDoQQZSb1e7BwSI8DyaykyAR75DY1CwkQZilbyovj1zthOGYhXWmJVU9miE9WaulCTrDhshCPVhLnyikAfJv2gLeHDq5ELSbOqkf4pMXd55qoNMNRcw/zGExEeHLVyOTvIm8VnkQbTyw0yA8D6WatdoY1G5lSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzS9NkiI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-81ff08e24f8so287272241.3;
        Wed, 17 Jul 2024 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235533; x=1721840333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/wM4gpm0SoOpAcqjYgbNHlW7uWa52VPZvPhGBKO/CU=;
        b=LzS9NkiIdvzuZ4WTi9WwsFlyz6+1Snfo/gesIsBFsZaIZkDVoOhyPCisKTd5fTqo1X
         I8fo94lwYpmravvtw3nNZJ9xAEX4G1PdKgAFMWurDQTGHwPx7n2ehghXZXMUlxImIRU5
         wAkI/N9GJu3sWRvxlaLQa8W34vVD5ryESS1M9yKdDAI/tBUfeS0aOvUK6IwLoVRrYu9X
         XWhnoMIBFsEJI51RUN9F8Dx8OBQRnY9Xg6+gSJ6k96F1mI1GgFk4D5oPgUQuojNYpeO7
         RQpASuyHNwJik053uXJDoL+8dHyWSgeeDp4v+OwbIzInaYUU3aJMYO4Vk+VPXvtPVcMA
         rjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235533; x=1721840333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/wM4gpm0SoOpAcqjYgbNHlW7uWa52VPZvPhGBKO/CU=;
        b=ntHKhD8NlwQnlU2t6V5lSgplBWpOJJpvbwUE158rSLNnfvGL0CUG7VNJ7xMmOcDdK2
         7Er1GLgjEgNzJnvQTQlt9tjofdSTh/rzr6NbCZw8Cpbbmkc82DG++IndnDXmaOovcXEv
         4yrMf1Pn3YOiOLfUH+8dbKjWvXj0VjPc70pnRMIMYWjZ2+22FJDKsoDec4NLeZD4jA/4
         43mONoZWwmsibe/69M9Mj3xXr6+B2G4gZX0/mczqKCMagH/N77pUwzXrnsr+/mtHIyqr
         pHIm+awgPLrgm8/m+yR8RdkNnr74hnqplJ+qTmEKP79pBQxZCQBi7j5LlnOj5J4YEhHH
         UgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmqFct4Zc70V0kOEllginRj6L8k1qRV7EaWEnHaEJpdRoYFSZUDhlMISmUcgr2MYrsnscR0XI5XGRrA1KcJLYPcEf3VuOisr+1DBvg
X-Gm-Message-State: AOJu0YyboGGB+vWvbBhYNCpU1afyVEobznyFtn87bMsoFYC6GV8rGVBx
	0z+lTkgPgugLDO04tyUtCtIAbetEL2RCornMPQLYXol/cwJyOb6LVoJhqKW3wefeFgKdT7MDz81
	OBOTyjg+yZ4F+qg04CVxHHCBwGtdf6z+a
X-Google-Smtp-Source: AGHT+IEE/oz0KWLT7PiFsCDFV9xth+lZxE15maqEJA/MS/jptuXNW1DSh+OrzITCEep4T/d+cOTcq8Mp2BrSlX+IDJ8=
X-Received: by 2002:a05:6102:cca:b0:48f:e802:4b26 with SMTP id
 ada2fe7eead31-4915993662emr3092012137.18.1721235533145; Wed, 17 Jul 2024
 09:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152751.312512071@linuxfoundation.org>
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 17 Jul 2024 09:58:42 -0700
Message-ID: <CAOMdWSLvdQ6RK8wdgR4i=KeSkvp6ZxB7Bi4g5F+rFpwqEmh_Dw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.41-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

