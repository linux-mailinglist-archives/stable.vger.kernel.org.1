Return-Path: <stable+bounces-94491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BD9D467A
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98652282163
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAA1AA7A6;
	Thu, 21 Nov 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="lk4vJ8Wf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFA2309B6
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162216; cv=none; b=HcJzP3tETeINhcQeSPsw8Y/B8bOsZuRsp70KWWiMgGPUXnYxfGwROwD1yuYDIRXhlyI3dUpK6YQspzLT3OPYg/7uQytIgnxXcGix+T1hXauhe6CmBluOKn27YKN7rmA21aIdQb8ISUZrvQi+0PhL8yaXhZy6328bsScWyb3goFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162216; c=relaxed/simple;
	bh=B7xihZT26qiygX0gKCUDPAr5CIdT5RCJ87wuM5RULLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrBfYDN+Nw8YpaW0inBJBxmP5OAl+707srzXedAnA7xIFyem0kcu4/Ldezmllz0Wtklwy+6qO/AAEiJ3u2AMLfILjIZuoLXM6cRnpev8278/du0YInjy4w5bs2G2epGKqgInLWuYQGzzKwNZrZjsvPNbn6WJV7HSQrQq8HClQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=lk4vJ8Wf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-723db2798caso429022b3a.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 20:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1732162214; x=1732767014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eW+fFrqUQmQKRzIcmuovs8hOwhvb53DeD1uVIRrkq8=;
        b=lk4vJ8WfI1lN4x1+F0xBSugcCX2qyNdwQDYpqVOC21L44F+C9GGp0N4xPC7BWkjBvq
         DAuX44KFSnyCfwDL1Y0/wk6Lbx3EDvfl1TiWW0uNFTMUu8QyaWH+Phq3XSOKtvglm5LJ
         WY7IgoYjJuguPlnia8Btt1PDLGcYfj6okrwhsnxseN2fsdX8e8XdFFtZZ0VTaGLVxbhl
         4H6xVTosdI/iZh/eU/xdcA6VKqJARNxtsFPbfDKxf0noYNm+8JX69Dft2TLIIjeeUjGE
         YV8r4gmLth+HlFYpHh38HbW1m973DYUzU4tW6XOZcNKRXv4+VrLs2pHbPtK6MHV66Eaw
         o4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732162214; x=1732767014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eW+fFrqUQmQKRzIcmuovs8hOwhvb53DeD1uVIRrkq8=;
        b=OQtSSQTSGWrGguf3H0KmYKreCcWH81yh8tbbVBLq+P3EENsQpXPIJGVyL4E3XIvldY
         /PPGd4J8erTLRTlAm35zdM6ue0k6vfaXiXL+gaLp+FyZg5vSN/Lgocx0A7BzxXlCfA+s
         PsFuzaTH6gLJK3Ej5n0/qhj5cbSRe7wlz9mYRVICFOO86FjkSO7D5s4FWTAUfsin1zo6
         Sb1p5lRB8miwt8Im1kLTQ0dav4l+P+mFZzc0/n2GNITf+9ZOHY4ELAqB2GTM8FR7Zsmw
         uy2w6DVml5Wn7ccL/LNYIiJyijEehrOR6ol+0kahS2stB73HD74QdwFPGnk1cNqX6bB9
         vWfQ==
X-Gm-Message-State: AOJu0YytFyuktGsUhdg25IlA6zmUD6HHUF/T+YhXGiivXTF4BodwCUAG
	4j2xil0IoBEg04g61G8Y7C44pzzEpzNetBWekPoJRl5cG7QBP7ZvOsgZQfiTivqK+sNlOH4i9g7
	cj6TH45YQ0Nx6xiMeGqINWTlYa42PIWqtDkH4hA==
X-Google-Smtp-Source: AGHT+IFdPQvHbccmjyatlDgiS9cIuoXmk/x192oJMaXaoFIZ+y7bREGGD/Gs+VCdZ7po1w9u+EDS8LYFG90e1gtySXI=
X-Received: by 2002:a05:6a00:1743:b0:71e:702c:a680 with SMTP id
 d2e1a72fcca58-724bed98ce6mr6543640b3a.26.1732162214596; Wed, 20 Nov 2024
 20:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120124100.444648273@linuxfoundation.org>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 21 Nov 2024 13:10:03 +0900
Message-ID: <CAKL4bV5EzB3HVJQ7YcpyhMECmjfH3B_6JcJxeuuxrE3+Z0vNZA@mail.gmail.com>
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
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

On Wed, Nov 20, 2024 at 9:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.1-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Nov 21 12:38:33 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

