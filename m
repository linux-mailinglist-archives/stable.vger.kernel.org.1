Return-Path: <stable+bounces-177551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F7B41003
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58687188BCC3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD2D27702B;
	Tue,  2 Sep 2025 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="PGHMFI+O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D726D4E2
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851904; cv=none; b=kJ1Jer2wru2+URG8MUDYF7fQ7ToXL9+JIoKH0dXt8ec47UeDDgOVwFGFiBvs5kS1VZ+MVRZVvnQd8l9PdSbhOpMVw7bo1Wp2Zq+chTexWeua79Qbz7vRaZba4CzbCJ9UrUr+EkfNLLgtJ0j98tyqVLgiAfl3074Tgr392rRRFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851904; c=relaxed/simple;
	bh=1iy1UuTw6lEJ2NwgCGNoKYrNukFmN3deNRw2dmxMW9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glFqy/y1/lpTSeSTrMnwp1i3wIYe4i9J8sU+9ytBio5OlUn42qkk5iOPSxMivvMlPoQw0QDUhNBVuubFYL5hXZGOaj/xmGeJQQMBYDplAgtBAGYAr6JYBc1grqxyRlnVEflFSnG3Hmgor4Vqi+0rs7BvljtU8rT1gGC6e1jwL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=PGHMFI+O; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so304745a12.0
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1756851902; x=1757456702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goWE8+4wadNs8Lr3ZlBGwSTIYXLGfMy0Q3cAuxNQchA=;
        b=PGHMFI+OwD3E5L6bsg/XMFZSY7VzSlgQFcAewJ8d/S0bVALIbgmNmBs6VUd6r3XQIR
         ZU7sX7oYTtD/DTXwJkFfjKjxJrq0+GhFVZ5vPu0p0wnr+qyyBIe8QLXGUGowf06yMcDA
         4SzSNRs69atYPJ2BybvP/pbCOpPSYMdlPDTcYOO/uJPYVHClstsY+9PdBMjXYbvNjVs3
         5h8/5/rhlsgHjWCZa0lu6N5UEEHAXXlQkN/2iRm3jQPgCcL8ebF61FhVY1vkkEwYzwp2
         QMDaSeR1K0NO6uqhoSlamr9Cc1J0Twr2yOXO//VbuUhAL/1vc9djk0IoxoU+imkpDSyA
         lbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851902; x=1757456702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goWE8+4wadNs8Lr3ZlBGwSTIYXLGfMy0Q3cAuxNQchA=;
        b=mSG/GU/C6tNOTs3W9BMxR5Tg+HBmUD9v7+22gfNuPiIw/gGKKH7HB7xV0RqJrVVfpY
         7mWiuRGn5Qwpix9HneEGEtUoSRUce3P4GJC76OFW+4Xm0TTgYgQvPkFSOLjXFnDhCZaW
         0yh+YsXKaDmwm3XvnYTcTCePDYIjVYpjH5B9TiK2bvHSZwxX8Aa5UH+nELX4GlG4cAW2
         6Jh689OpGnKD3OrnJEn6SlooHGZeU+8/gnAKwrvLGHTGPQ+4SMXf2jBkvMYeGPyepd2p
         U9jDd0YBAgfMMNPRQCoF42yS7iwxLELLDRnH0s8WhBPZ/ThoZ2ewr1jpvgNhqNRZqmc/
         LpiQ==
X-Gm-Message-State: AOJu0YzAI4KU5fqfTBYtQ7aPKVHH8CmiNn3RzXvi1Gb0MR5/sgyZWuPk
	nfz8hvuSeinLrbedyKMPS/NS5asp+yHInMmy53DWfuLrDtyk7dmnYd14u3yw61721M/dkzPEwlS
	dZo6fkuYKof1ESHttAz4vI6UdpTYBSyXfkupB6NI7IA==
X-Gm-Gg: ASbGncuxtq5UXhgXX+ElmHsd+rWKOF8HaABPZOXcR+2Iw7UgZ1GmFBqNYPNEFCbNKV7
	kH/lrmXwkS9ISzqKQIANtUplG7fArHd8H3004we1iVEXNSI772pTz9V/G4x6hiW1IhaxXAc0cHF
	c1M/RMNaaMND18XFnoJQ73OedAD48K2E/RSDZj6T8jVPa97f2UIZRaPl9zngPNRPXpCAYZ0ZiTP
	ACQMuPj7oj+iEvE8A==
X-Google-Smtp-Source: AGHT+IE+GuPuwIi0HALNRYE7COclZsdxu+LtC3uR80YuYT0Ap6u7TRJrOcZjbn/+xL05gLgJGPzhKrW2ZZxS44wSvgk=
X-Received: by 2002:a17:902:fc8f:b0:24a:4560:49be with SMTP id
 d9443c01a7336-24a45604eeamr165939475ad.28.1756851901619; Tue, 02 Sep 2025
 15:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131948.154194162@linuxfoundation.org>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 3 Sep 2025 07:24:45 +0900
X-Gm-Features: Ac12FXwiesQX507YxRyjZkNgjnZMjLVD0vNTuMmrfDECGQRtT0AQVZvnJkRsc7k
Message-ID: <CAKL4bV5ZuM9J9-6oy27WVMrmA-sX384NowBacG57x+t+Ydt60w@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Sep 2, 2025 at 10:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.16.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.5-rc1rv-g6a02da415966
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Sep  3 06:18:52 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

