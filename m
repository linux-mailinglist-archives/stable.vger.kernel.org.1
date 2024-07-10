Return-Path: <stable+bounces-59012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00B92D2F2
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8405C1F23A49
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F104192B71;
	Wed, 10 Jul 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="DkKwCr5/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD72190673
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618586; cv=none; b=Oc5yRvgM49sxNBeRRnmzgz7E/zEBJovao1EWlg2N0Xp80pt9fAnHqH75GIfuWq3RNjeG+vR0EdElsSCIHt+ieLIryos+MJI8CANADBDY3c4nd8W/KeA9A3WudH3nvzI5IQvINSwNA41sefzdGJEK2EUitCKxWSreAYy2Nu+m/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618586; c=relaxed/simple;
	bh=WcNEWQKtSC+Dj0jBIox3Xr3GfAY2vvuavazXjG/PjMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLCisMUQu6sYz4QQvNtiQ+T2ykNGkzGM7l1q/B8vcwZ9ncjhAZQAw58TFAFawe4YE5QXlWJBTi8zVWDKFcMPm32nETEXYjnCT+Zs9XLL2FLpPE7Rno7ro4UK6KbjuDbV/WbKbNf6jfLaidapPeW7UfMWNR54CcHdtEjS1Otcbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=DkKwCr5/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c95ca60719so3961493a91.3
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1720618584; x=1721223384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+5I4HocYoLlRWtU9xSNyyq0WSjcKj0wutOR3acSvmA=;
        b=DkKwCr5/HhDZszQ8jD1Q8lP+Glcopv0cWkqQNGOth8+HssWb/d5eH9IXeXTKXmwxaT
         eTAxEfn94l/8M6KSVdf7ENpxYsb6SzKahAf7LfBC9rNIilrB4mpooCowDRl3dN0oBP8r
         scXWLG1Ugco/enDpeQyaVI3CWZFePWn0ptHjPuL8Tiz4Z33I0EOKsVblwOESLd5VMN6L
         fiir6ybTtwpPfehKo2D0mwNDrm+uP6RNKtaohFS4LsY6tILHfHJ8AveLJP/vBBj0O+P6
         xIzMK0RKMs+1LGWo5RPfBNt5gZMtQ/72JvBpG7b1MA7Lx5n5fS58d6eNEEwmr5ZK2QtZ
         lsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720618584; x=1721223384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+5I4HocYoLlRWtU9xSNyyq0WSjcKj0wutOR3acSvmA=;
        b=O97PUSe+MTXFzMJg139bJ2jBv4yMKV+FKw2iXxy+96XUbVVS60u4Pcxv5iSw7KNJCf
         0s4xTGF8XvQoAUklLu5Sca3GhDIbdNMQMcUYDcvwPA6seiqHQ94dl+KTkCii/OgWXjzm
         HjVQiUklhxUEb8UFMECF91JmPXhP9/lRfd2sHon/44a+rYojnO1XGyYBE5sPWYJu9y/r
         B9E285CqLnzcg/ftBxQTxtHxf/fw/gzLU2YlrjKXuAVzrc2nhGZY3e+Q3aJ6qz7OEhfE
         Pvwm4ura+13AZNJ8NJyl1gCg+sRZgirgwdscGQ/O1yLvVWwg24pO1edi7lDovFga0/3u
         Ot8w==
X-Gm-Message-State: AOJu0Ywjji3f7c2UDA+ANOsAgkXgm3/EddnBba6q04iapuLmFTZ5Z6Ul
	u5q+LDLtu1tkCEU/Mkcj/YyH5wMLzL7+ZNw2qJIUsN8fkBZridY3KZOaWNj0LQowEpVz04ZIP9t
	8pvxFDzFZG6PZvL+VDQID8uGPZJM8hNETjKGWvw==
X-Google-Smtp-Source: AGHT+IGVWjcx2CIKKhJpC93dsIDJRQ59BMorlnyl7TRS9pMm/YWO3qF6CzwWosQ+pKzgyemjtuMmhhNtcB7dLeMy0JM=
X-Received: by 2002:a17:90a:4b46:b0:2c9:65f5:5f61 with SMTP id
 98e67ed59e1d1-2ca35be8f0emr4813325a91.9.1720618583619; Wed, 10 Jul 2024
 06:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 10 Jul 2024 22:36:12 +0900
Message-ID: <CAKL4bV4bzzKhUv7u3SUUDD=dp_KZ35K43faoZp9aQp5GmUfTCA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
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

On Tue, Jul 9, 2024 at 8:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.39-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.39-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 10 21:13:34 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

