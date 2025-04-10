Return-Path: <stable+bounces-132084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C053A841E4
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3059F8C0DB3
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315712836B9;
	Thu, 10 Apr 2025 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="M9MwfTiA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599228153F
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285078; cv=none; b=el8EY61o+L/8D/fzksaNVjF62FlL2YmugywAehQB+L2hViIov+n9C1mz6MCIrOr3cgPFdPa+O35u4hbaVOCBiIK/vG619Maf0YPIw0ebTd7LNpc/JZdEazQYPix/EThUBZFTXafogzheMlOjCS7oeB/S+kqMc+zN7REkpEZbWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285078; c=relaxed/simple;
	bh=0Of5U4z8afXfK7Xi3Rsr1a6ex6vo7JrOynH81ykhVz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+enPQsvp/oyyo6hdDWtYh9ZyAqgVoZO663FYyMLz9X+YUkgQn3BcpjqJ6LRCl31Wp9v5lXlR93ww7Q2bLKEYL73NhmE58NfzppyDakjSAwqUGrKd0ya0XKih8ne3VedVqrHxjkzWVaNgtEZN1npkgbTrISOO+LbP1+L9Jv7hI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=M9MwfTiA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b00e3c87713so654869a12.2
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1744285074; x=1744889874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f9QEAX1CJe5R8QcJVmzqkTEC/iZNvG/J6WAAg8e6aU=;
        b=M9MwfTiAP2Gw6YZ1GC482IM8gpnAnqd+4HCAiYpK2BuON0nJRSBO1okRRYiAnQJPuS
         yGkieZIAOdTScdhtbUFGnscNT+hwA4BOwoAkkrTeD7JKQghT5WWstvTqI6ET/1dESJwP
         An4fqDQ2TE4GhE/0lM5pcuDMWNQzdvlc4NfB6hrhr2Zo5RbpRa2Jrlu9p5vmOeaudImL
         vgjtOtcVGw/gcPzxbN7qTdoTfWUDmTRsmX15FLmU2wa9t7veAgRpfFjXGZlK+kJWQ/vY
         OxL18GltJL5vtPyvdag0Zfb+48Io7yFGtJzmIJuWCwxBiVxEWGEBWuZo0JsBb/TtH9Rj
         JBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744285074; x=1744889874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f9QEAX1CJe5R8QcJVmzqkTEC/iZNvG/J6WAAg8e6aU=;
        b=qrPMeTgCKdwW84Iga3WZCOwvVdN6pBNCxTEK4EfCJtdnzi3CHhEYc8Yj/MmwIjCE/2
         NjUZ6n1+JVG3YiOuj/huG7QYUTsFjrPalEfgz5zL6HjE/Eul8GIRMczczGmg8ZjPOrPu
         WblqhP1pgptV7SVPQ2WED5XQiO+HaVkmpkAOhj98fjid82ydyK/lk23q9FVT0nGHJA+1
         1xJE3F55QGgfmWe8JnY1dOBT/H+gmYgq/TjevFMdQ8HfMcXchGl9B5wQ8hQog7opNhkN
         P2V6L1ZDXdbLppEIN7zNrybHWWgb+FyNguizRGMHppcv1n7fz8sJ4vRQiTXiSRmZYZFY
         4fVQ==
X-Gm-Message-State: AOJu0Yz+itVkp83+aCpMduvB5WBySEQDPbL/Rha65BVUJPePzBXFMxw7
	nXaLgJe9i3zihXpIEUcwFepe0HRLcHOzbq/+GUnlmxz71QR+tX6EW931hz/A9JEJl0lBc/OBIAw
	yDI2JdP6Ve4A0Vb5koPJ6odxb31VWdeh+EDX5Bw==
X-Gm-Gg: ASbGncvDAAvKW/wklrbciUfzEErKgBC+OTsP0O3r+9OJlaUTQMZsq1QN/Ye3Ki8s0GK
	wHfo9wovf+L3rdtgu6iRx8JeSP+aSJwF9P/XO4+GG9d1/99kSyPFxPa9Mo+vS4l5j+7XzvaR+uX
	5vg1qtAROL9auvPZJ/e6jQjw==
X-Google-Smtp-Source: AGHT+IFf9b6rD0mshIXEsi9eKtMgmQeW8WAUbIpHUW9028hvz2quBzJ17jpTHpfufL5MoDKUhrB0LBxePV2EC/lvj7w=
X-Received: by 2002:a17:90b:2d47:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-307e59995eemr3269202a91.17.1744285073875; Thu, 10 Apr 2025
 04:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115934.968141886@linuxfoundation.org>
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 10 Apr 2025 20:37:36 +0900
X-Gm-Features: ATxdqUGFfH4m7c8SppFhuEE7O4S7fKdsw8gN_V0ons2x8pr1JB25QeDueDaMLTA
Message-ID: <CAKL4bV41OA2u8LnGk6WuC_5sO8moTSK-w-U2r0yqEQ+fbFsTGg@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
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

On Wed, Apr 9, 2025 at 9:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 726 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Apr 2025 11:58:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.2-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.2-rc4 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.2-rc4rv-g2cc38486a844
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Apr 10 19:57:30 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

