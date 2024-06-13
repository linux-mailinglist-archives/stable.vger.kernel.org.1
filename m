Return-Path: <stable+bounces-52060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33A90759A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CC91C235EB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED91465BC;
	Thu, 13 Jun 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="2K1szvcB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B05139CFE
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290081; cv=none; b=avkNjr4dEqCgJgDzJjmB+5pzZJIf1XuOyiNaaQ+jslHnY9+D+5PhkbxIZ23KQmHVHHRGn5AjBLRpevaTZMj3rwknRsxd7s/n4Vm0yiisHKTotogWSGn3STTgnuXbhNGbaW7UQsSFo8zn9hf+lLk9a6a+AKrGG1vlFs0632I0xPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290081; c=relaxed/simple;
	bh=ZefUIUyomFMimAAhveylaaGjEmkSppUTk1bAsNB6uJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivRC3UIh8l4hm4m9Me5sbfEYz+TRS+8T1sqqEafrG+K4M3xe3tUTBDsbRwgmQIhHGWchsTxvtc9mD1Ofdd3lyiuTmSFfFU66Bt4vxu46IXjRX3811/pifCvOmwNz0RhX4dxWK44QBs5Sb0wpcCA5qGXa4GgKW1nCd0CWE29ooEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=2K1szvcB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-656d8b346d2so854886a12.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1718290078; x=1718894878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJbpBNKH1nKMaS+tK4/41cAHjDB09P3ZLPEGUZzZCqo=;
        b=2K1szvcBECQW4keBWNgZ3JT5PxgHH+gbYrwQLW8M+dMH7TISOt6B8xukSt/qYf8xBU
         VPwJaNkp64uDKwzE0xrFcLgdvzMgpEDzG6ImC/EetYeeE1dTc81tWzwKEUftE+e6WEiR
         sY3EvqEN1xW6CdE7DdcchnpXIqBf4jsW3qwK6E2H+S9gqDS3G2eMhhHJ6QL4Ze8Tf0IN
         Oz9K9Y5zThkNvLI5s6MrGE7AvKS9IghoB/8JYW9ievsXAKfiwVhK0JCiVcGBVFNc0Nv3
         L2kfHaChIJhcH2yfAfCvbiszOtwBmfGfMwAxjZC2e0Qee2mFCM7ixnDfHrzhplMPa5Rt
         L/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290078; x=1718894878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJbpBNKH1nKMaS+tK4/41cAHjDB09P3ZLPEGUZzZCqo=;
        b=kxC77nOk5V5jCm3N9bFmifDiFDQbimEaYFZxYKMTBN88NNnZR/bzpPXwGlwDdghw4y
         erChJy/g26Fy2f2a5UkEPhWOoz0fAD6U12S4985B9KQC/jpTmTWPb97hKZVwMMjUvGlB
         VbHSWyiFHHrcT/eCxx/Z/POpyrhPePYCj+Be8z7igFJ3CABmSyTS0iGZtgclmRhBnowa
         r1Ax7XfIsKEpa9/ABzgAcZoJuojiOVsNPGFcZ/59ITLFTY5XOsC5ci348+bo+N6eBxt0
         kjOCve8E5CBLjxLT39gweOiZ0n2TJU9gw3duV6Rf8wO6TffrHVUy2npJxFR63NtTEDCf
         0WkQ==
X-Gm-Message-State: AOJu0YxkYK4LDGB97LVrn+qrMDg+bIY3v230xxEwgH0I87oaa4niJY6q
	aWQYcZ+iKdQS+vXbYoPGhaiih05VQOf+eiSoAV0saX9RhDWU+HG79t63LEgh6qcPT0vAUmuaISV
	dmZvJHNM+9I7rvgDof0nTw6k0L09JhxJOw7DVcw==
X-Google-Smtp-Source: AGHT+IGctOV4sUJXx3kX4lbRej3zxxjongFChJ+rwztXfqOuHwCwpySuoVQD6u2sUxihtO5b6CbJl6hbO99jW4+2BQ4=
X-Received: by 2002:a05:6a20:394a:b0:1b4:772d:2885 with SMTP id
 adf61e73a8af0-1bae7d9453bmr74989637.3.1718290077789; Thu, 13 Jun 2024
 07:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org>
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 13 Jun 2024 23:47:46 +0900
Message-ID: <CAKL4bV4Mmy-SNKTf2gScQ_YEr1WH1Uz_ydGHKVKN0v17kJn7Nw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
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

On Thu, Jun 13, 2024 at 9:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.34 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.34-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.34-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.34-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Thu Jun 13 23:11:09 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

