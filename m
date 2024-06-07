Return-Path: <stable+bounces-49967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A2900235
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A2C2851CA
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED38218735C;
	Fri,  7 Jun 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="ZdiivRZC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD12837F
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760007; cv=none; b=APsKdPO3En4BAg2M822O/JFU/43HS4ss1yI9RNlz1ZsC8StSzHbJXWTz0KMgRanefQq4hauwnT5jteTZJgKKHutsH+p0YnHoQS/orarHBRjLr8AjPD1KCUZCWhuhZYCvSai2VyHp3d+BCQKd/xIQeSyF3R4xaHuQQQNXPYzK+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760007; c=relaxed/simple;
	bh=2wr+lHAs0v9eNSflllxbXQVFuP35fXI9JtBvHoVR5yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oeg7RMk0QaNt5DNH4SpTo4EbjefuAlkVM5Kg1SeO61DYIg9zLMg8GgANYCQ74ZNB3mziGqSzychfV6YheqDE1dBWnDebb3U/S/2tYin0YCPYHZ8uiUWhwpdwErIxwTZfbcCFfI46Si7haIqWYSXTtbXPUgFtHnNvo3KbJYp563A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=ZdiivRZC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6cdf9a16229so1487113a12.3
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1717760005; x=1718364805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xONs9cG3bwLvzUz0akmZOGXQK5GwoaC52V868nn/RM0=;
        b=ZdiivRZC99xXYQgs9WyaxAoG2w3FyDm9Dr66kjH251lHJf33zxDFyKRZfkos+u1wA1
         Fh2iyodJHd22B/lTCuak0s0CQdZZvAjVlM5gF9jJoa22n1uwpcdAWO05Ht2BySi8inEI
         W4pEIZ6ePj4ndRo8i3JxmufGKh0z0ThPg2hau1ON+QywkGFi8F/+h5cH56pdOYNgrWpz
         APpp9M9Nw98sFDKL28X5QSKr1yUFUYJka4zeLwAsCVE8wbJ2F+PflJU2jeHufB31WEmd
         aXKtHnm9F9XxUdrE7PerCVYLFVpgo43vjkzLmOdXGLaFPQXJYVWztSD6oLpDaAhmuaZ/
         DTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760005; x=1718364805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xONs9cG3bwLvzUz0akmZOGXQK5GwoaC52V868nn/RM0=;
        b=qD766dedBZNFORLhd66V+Fjt5sLTQSSGXmS8wTlt8ti7MNn3/ir1up9ViXzCf5s9Ba
         VehWOrzS6NbP2jpCGGXY3tCcp7Ir3Pcn7uHxHmqNN8KPR2Oipe0VVj6/fQpZYwaWuEL5
         iho7YZsSeAvTssCyz2LGjq6hGHo73rgzf0sM2kTkeRXWn1LeDy/S2ERD1RoRnlckgcN8
         OOjOVB7q9K9+MSzSKhA3xN/FYeuCXYWCK8eAHt3Z3E/HNfIO0s32FeC/hLSUJIZlLm5f
         3auKhdFIdu7ru1RvDxtVnPSiNIwLeFcGjLGMrNM1S1IWoWDNrTKn00HZ4gFzyymjtx2r
         QNfw==
X-Gm-Message-State: AOJu0YwHFyARd2rO49kjGh2humkNmg9khXi4+0Gz1/jVc+1jg1MBgkKL
	36XsKIX064+2+nswDWvhQUacZ9udAU0mRUVP9O/hc2sLb5+HYUHSNCl6kxNWjF7j6r06I2owyVx
	tlB65Vh1ox3DjYKxrYTFR8l671FZphvhyhkQfHg==
X-Google-Smtp-Source: AGHT+IG7+ZIc0p1zJoLLk91skDbqRsWdWPxDuKxxght4BciIei9F3bE1Mu7itn3uqV0BQDye1Nze6/TKU7qLlbcHg+E=
X-Received: by 2002:a17:90a:5207:b0:2c2:1d0f:3c6e with SMTP id
 98e67ed59e1d1-2c2bcc6b446mr2113104a91.37.1717760005426; Fri, 07 Jun 2024
 04:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 7 Jun 2024 20:33:13 +0900
Message-ID: <CAKL4bV7_mPSr6FKH6j75hsHiOG-Zu20+rotzG4uU04qz91eAJw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
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

On Thu, Jun 6, 2024 at 11:18=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.33-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.33-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri Jun  7 20:08:16 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

