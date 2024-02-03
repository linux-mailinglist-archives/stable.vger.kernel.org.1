Return-Path: <stable+bounces-18732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E9848965
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 23:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2671F242B6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF71E12B9C;
	Sat,  3 Feb 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="g1zG+LoA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69A12E50
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707001118; cv=none; b=A5ZhE3oIjkpRV/eu3G8YOl2rNeEU+kFHd0YYWDs/VienLcUmeG9So0ibJRWHFhlLc0cnf3zZGwPyO6eeDhKKuVf1c52eOFw1ntne0D5/eIkW4X2wKVZXqodZ2P+oG8Zw3BNGOyMnobrFS9Y7SK1VVXT8gt3MMT9T+pQy2y1fRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707001118; c=relaxed/simple;
	bh=9XCEwNXOtd3gfH5JnXX1Mn8plFmt8A7TjyEul2rhlno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHGOLHc7aArD5LkCzCZYL9TtgQ6r4RA4kFsvu+QFNNiz/u79v1ZMC6h+nHusQFhd7kQJAe/jgowUCIZ2Fnw6NKFNeovpJFlZLLYVQDxVgN7VGssd9o8Y8JzVQ6322SHLNIsa9X4rF9hD7C48OXVsXf0Wx3v3ZkbX8GemTaLBnhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=g1zG+LoA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2656730a91.2
        for <stable@vger.kernel.org>; Sat, 03 Feb 2024 14:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1707001116; x=1707605916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzRLggOhgGcyJP2PFv5GAw1K1ynDOSTnUjo1ML5xufE=;
        b=g1zG+LoA+n3NIlme6qiQwbthBJIMiCXGmjaZSlsimS6PQ3ab1X95lp6Dn1FrrT5Rva
         4SNhlxKGTnurs1la/wHFO3CfPxXGJ634T2pPzLqz+hw76y0N7ldpUqDLNlTtHFvJqK36
         TZaXezVCW1qeamwP3LlyL1nKCBEUIOdL6hYXYF3k4PhUaQHaQNfxZZ8ZlDRl3ITOYmbv
         U54+a4DBTCRtDTMokC+43b5mh4oalnRBGKWxOoHc23XraTUFtgsTgwu/wL0GPSBFqU3R
         zykFzDcj91U3dliIODLtAyHA5fudZCjsju9sC8hq0iwtifOAqho/4zXx20MkZZ4JgJNX
         jsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707001116; x=1707605916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzRLggOhgGcyJP2PFv5GAw1K1ynDOSTnUjo1ML5xufE=;
        b=RcOzt858R391Cw45TsBx37R1cSZau0Jr1ZwLIvTfrJmzYrG3YLBD46raeHN0HsLD2q
         EsAuQp/6vwKOQ6UaHXeTqLhT7YJkwlVH8+JI8vY2lOPMmSxaQsIEtERQzfaSOLYL+vOv
         4LeLrjus9l9jkMPXyMPc7hLfyg6x8n9IPYdLMemSCsLG9WEps5zXuc1ZqHo7OEO3KxJJ
         9bVNS/bKJMAI2ypIDkQUtD4kHQHhm71p42/5zhURpYjdYwUCwt+HeBTSGtP7NyyQ8eAO
         WDKsKUBmhiwb53AeJe9L3T73ns8QFHF6QZTNrQzWScKTAcfeYzmKU2tlhmK67PzYRzd2
         DrsQ==
X-Gm-Message-State: AOJu0YwQIZjfi2pJXcDOrk5qEtqm4Z0XXO/qtasMTCDrqzFdA+l9H6yt
	fFY9CYvOVKFr9T4nxETkaUFlz8raNOh1brwD9lkk5uM2twqEIBc+0TKUdHbFc6dJX9PiNAmnkeB
	uyNq2JRSOSAEGKncSIuYkXoF/BbcqTbKi5KQp2A==
X-Google-Smtp-Source: AGHT+IHWWixaZzUEfvpK6e39qOuHLzQpqN8E7hRV7h68UZHwCnqjdYRWOopQDCpbqGA2fe+IlNtUWZ8LSX2Bstq1xmc=
X-Received: by 2002:a17:90a:eb0f:b0:296:6eeb:ca2b with SMTP id
 j15-20020a17090aeb0f00b002966eebca2bmr1543366pjz.26.1707001116163; Sat, 03
 Feb 2024 14:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174810.768708706@linuxfoundation.org>
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 4 Feb 2024 07:58:25 +0900
Message-ID: <CAKL4bV7e9d6Q7KXpWMrvRvMfD0EkthH4NKSg-LtrvgpWm5yvuw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
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

On Sun, Feb 4, 2024 at 2:53=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.16-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.16-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun Feb  4 05:25:23 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

