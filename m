Return-Path: <stable+bounces-93492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3EC9CDB17
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A78F1F21239
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A118A959;
	Fri, 15 Nov 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="tXfKv/XC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC718C01D
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661660; cv=none; b=fPos6Yppatb+Yz+iG4uzpevhGMxoDuiQe+cntcPDDxstxL2Mbkcq6CPmdZDoROiOggZdBNAMjWov3bj6tY7g6cl4nwybeG+0iGSF+DH754/J2rssxLECSo828UQ86d23g24/STDE56V2xJ1oKnVR4YkpzEygbW+X0uJib99zxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661660; c=relaxed/simple;
	bh=LX2q62WYby1zXSo+OspoR6SQ4JOEQtEGQY1uhwAGwsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr+n58tT1A+NqpHwkJMya5kZrYwK4feNIjmUc8XIpg3XyQxOIzDOmz9anAeNHpOoYSAAy8rdlWODrdbddt1C2Hl+DqBsOUGuDxJnPrAxkq1ruvtBDhxNv/W9qGACMivcQ2DTLr7W9bQdpMOzVOOru17rRHmXUdIePlwUJ9pjrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=tXfKv/XC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1213992b3a.3
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1731661658; x=1732266458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/GGcDKwuNPpMFO6GIJo1U2NCmyHIGhmOInYHhaYUCk=;
        b=tXfKv/XCsYU5lC0X13pUcbWJ6VDCYtcRNu2i1Oud64L9LZvIJB1bEGbD7EWz6E8Mwa
         j+rPT/2uKdUI6fvxk2lV2Lv8YOmA6mbx6Fu9Y/YjWtDYoAiYNqbI3EPDL/wK/YIskhAg
         UjCjLdCztHce0cjVzexF2/Fl/RY76D9Jtt+nAN5lhIauM63fxmJsp+wg8m5NJKUrc0UO
         i4Zm6H+VgKTQ5ww7BDOAQ56dHv1c7Z9UQp47nQ5tWuiRe9XgYM3pAHhl4XoKDfcCdLsF
         Txw5h8rCeOnEW7SoghafUVqrY4yHWr3y0rMbD2ABhjKRZ7FFxxOMBry8IYHdr6w3R6sx
         /NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661658; x=1732266458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/GGcDKwuNPpMFO6GIJo1U2NCmyHIGhmOInYHhaYUCk=;
        b=rCdx8+m4TnhZn4I90zL9xf6ovwavU5vz0IrtU8fS8CnekjQ4/i25PitVQAhm/A29zO
         fJ8OgE7pP3I+q+Q6RD5R1usst8B39gWutUtwUedy/axbx6beFRwAUYBWiKwxievjsDJ5
         HI1nvBNq9YNQudvrRapOVgCR0kPIEF87XC5G/lUU1VtTUcJJS0DjEBXVosRgzImKEyJr
         SFIdMZHzl9y4sESdJNy4FLEN+zKOGk73x6JOfWExWxuiaO/J49/2kTcsccXif8RuKh+T
         nCLmrgLtMGQidCJCjLBM1uk6iW6j6BiQ0QGHnLkIQ7dOYIgc0XpyyrOi0uWiiRqT8pbu
         F43w==
X-Gm-Message-State: AOJu0YxYwIgUCCTxmwOGp9dYBEgNnhPa8V90B+deay1rUFtUT2eL7vvI
	7tsZbsmINKbOmifRn1V2Qy3yM5d0NnzFjZbVUrAYEuWiU/RBpExJjaw8SfVRBK/rpJOz6YppKnb
	zao57M3jcMlJADsgSXIirzdgbJ+9ynuAAtTkoog==
X-Google-Smtp-Source: AGHT+IEipBAtaSO6qTco6CXlymxGLqUFgKpppjq1+DZHQLwOzlZTO2vDwCJPay9SltCtNZBs+tQmMU2jQDqrwF3BKco=
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-72476b96ccbmr2943756b3a.8.1731661657842; Fri, 15 Nov 2024
 01:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063722.962047137@linuxfoundation.org>
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 15 Nov 2024 18:07:27 +0900
Message-ID: <CAKL4bV48qydBq=_LGWDHW=bYB5JPvKa=3Nwg1WZC_aU3Upf8Zw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/48] 6.6.62-rc1 review
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

On Fri, Nov 15, 2024 at 3:51=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.62 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.62-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.62-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.62-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Fri Nov 15 17:47:19 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

