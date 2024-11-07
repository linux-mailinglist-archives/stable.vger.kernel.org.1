Return-Path: <stable+bounces-91811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A69C05DB
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A55281E6B
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4E1DE4F0;
	Thu,  7 Nov 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Px2gSJpk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA920371D
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982649; cv=none; b=JoUtOlJZpshZkg10wZK8sC9ys3T64D3bUnQ+oICFT/zHrVs8jQHlDyhXwl/aXEinSam7FqTa1B7U2igvqh0tWY6bW2YhX6rMdzETozX1RoTSlZY/MRJO/DCRY1fslDmGjf1QmApoBwtJdXDLJFxdAMKRgFX169nQmwT6uFI/fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982649; c=relaxed/simple;
	bh=Fdpm4FLE82MD1XDbrFQIihI7Gfg+HRHDdnITsdrbq74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLF/UqFZ23XNKB6TROU7onKclGpEzVeYPbFvsFj6xK6LwtdPAqkO2v4Gb9XzmQU7SPJ82au2c2f1jXZTa3tbvs+eWTdRZe3bTjYuTNSDtQ7cIWOJe9BmKb3PwEFcOHF0VbouH7kSaMWv6uW36EJhJpRVj6s2A5/ftlEfTozKncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Px2gSJpk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2bd347124so684986a91.1
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1730982646; x=1731587446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HguBX7zMS72hjPxZuVUTMy+OmRB6kPtYztXecte9GL0=;
        b=Px2gSJpkfPsUbnLVSi8bGwMtCct4aDg905izC5Rs9f/dlVRdfMn2hQ9TeoU+RpnGPQ
         l5IKT1wKgtLL5IjtT36THWq4IQ/Uob41/KoMBONEMXhTYgau6gRjNLNGXrgnBeulgc2E
         1tr26LjKMx0O1+63ERVzOgKSCxYoZISoTHhFYceeq3nxdQ0+0yaLRAEy86yLXEaCMVXq
         7T/tu7F1Ek1F3b1oNnQ3hpULHyHV09ecLkbImReJ0lw80R071EZ2p0VuvSrV5uIORH7y
         SmcYOV7QEmQHolJYP7RmRVHnalnxk3RjAIjLOu/APRGmxFguLxBZQf32gBs4hWmAFI0U
         rV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982646; x=1731587446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HguBX7zMS72hjPxZuVUTMy+OmRB6kPtYztXecte9GL0=;
        b=OV7RI2QZpvZWlFrxCkXM42DX+WSLoo8kdXo7MtWtfQBALeasIO/odmg7JpNKiRC03/
         sbRB7WMobsQwVoM2P28tDsV75Du70PUfPUIY54+qRXM34iLxpxjlLQIYYf/xPs5vSjIp
         e7hrDcdwD8VRjSybEV6oAB82knEc99U6VlW/0qT7CCzpAtpVwhDCcnoOvtnZb0EuqTrP
         6rBK6SecwxQ4EZNl3cuZoZ2Ddtjve22uD6olEkJOOKdPNyozjp+DyiFcRRI4HEoeTdlV
         Hfg5M3HyCvAhCo1JOczpCU1T32BSXdR6eJfiIbx+oprOvaNkPy2Hh8+GULb89pT1Ic+J
         VcEw==
X-Gm-Message-State: AOJu0YynL0QNuKbbgiki03pWohNCWSJi1rPCE60/w8LbUBr0Wk8FreNp
	960JHNLz7vktJTfHDVuyqPYKq+fm8FeMUcBGT4yOjWFqjdvUi/TyQFkEDXrOH5tOPfvZInZXTKY
	O+hLHUXXar5OCxtH6ods2VLJQdQTNOL0H7L7xmQ==
X-Google-Smtp-Source: AGHT+IFuYCrgtftLSJSRbDtHKLCIhR89jTMV22jQXYNjvu3k10LIWdr4KCxiqdPjI/FxckDfOt8KKDQPO8snlswhv7I=
X-Received: by 2002:a17:90a:6341:b0:2e2:8f4b:b4b2 with SMTP id
 98e67ed59e1d1-2e8f11b9f74mr45004766a91.27.1730982646361; Thu, 07 Nov 2024
 04:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120308.841299741@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 7 Nov 2024 21:30:35 +0900
Message-ID: <CAKL4bV5NcjMRzVmLDr6-_z3hxy_pBTJCmdQ_URbPKAuVmkMQfw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Nov 6, 2024 at 10:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.60-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.60-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.60-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Thu Nov  7 20:39:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

