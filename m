Return-Path: <stable+bounces-61276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3993B0EC
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853C4B23241
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AB158A09;
	Wed, 24 Jul 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="GN987aRs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF3158875
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823923; cv=none; b=K9TgEq85OHVNOGcD3CuggJQIuHX6AozGs+cvdqEcQgKUMVD8/7B8/wSooHSDM+CCJmz3DA071qGaDX8XDePdC2jddQNEZwWwDb3sko83HcIrNZpeNsXdotRtYNzRDIAC9gcxfOvA4ASrzCOwm8Vf37tvqps30tHqiiGx/EfjMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823923; c=relaxed/simple;
	bh=m+AY9XXCbeFV3aqKY9wXH1NrnIVbO8URw+wWbywIXT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvUWxkJio4uKU7/pSC+EkrUBouheJtUbOrjKi111HDe6clrU4vuPSfElXK66oxGhJaJrK5nwP7EkMf1Xl0e23KJK1MtciJPJ1nvcuCfv98kgoUtd0D9z/H2krsRQE6SBi75ovoySp+KyHnjQwoZb4VBbZJcsIuEc/syGG3SLX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=GN987aRs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-71871d5e087so1317726a12.1
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1721823921; x=1722428721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR1NOFGImD8V01Eylz118awkhJ4FlI17uyTTajCNlVU=;
        b=GN987aRsXtxCgATbtnBCs5/+KBXU4SdZYhfeLAXPtNRm503+558UievFP483fyi2yk
         bp6vdIrLJjf1I+ZkBdAu+ENe4Mw+ntevjjIxCVntZ4IaUr3GI+2m1S7GB75Ybx7QhOIm
         an3soS3wk7mriL8UBjjNyIvmFTMIMioRqimmYO8oBFSUp7Vpwv0ko1/POvxb38V9jHrF
         e79kZ3mDDiv3y5SzqeR8V4xozPR/G9NBjVIwjiujhvQNFnKYVr5oRNKaZ6fmURy8763D
         8qB+wc6nHZEROwbLA01+pEozQ5ozQGxGYZ+l4kj5opiwBc7I2inQeIo093MBCuj/uCTx
         o+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823921; x=1722428721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rR1NOFGImD8V01Eylz118awkhJ4FlI17uyTTajCNlVU=;
        b=mm/fUrtrvjP7nXq0yZ2uhKEUQkMmRRBfkSU+J/Ih7UHb0m65JIHlW1glHFW41PclEZ
         Bxr+pzxxFr6WfDUzDWzK5J7CuVv5bw56K8oulhDW98r6zwu2dQ/6ugrGZgQnJUFK1xk+
         sXG7WPlrrWF8MKzUd2wkBoT6YhoS8YUMu0n2SVtVpYMTKnzjXkVH06JPqE4FbhIZdGM8
         K1ZQHoOsqKmIAWIDUghj8kTrMfirJda7NW8ZLg5rOpmQXviZ0DaeEdMq5gqW6+35yn72
         xfi4GBA/hBMQacysJVAHuC3KrFl54MsFk9bGuvn31Xm6REX4boNG/dCEgddBzQxDTFn6
         59hw==
X-Gm-Message-State: AOJu0YyxLeMKOy+cplptJJQy1gPmRTMbwbXRBf0C9eq8UQ4KdxpJ2fCo
	e5ScZrwaXtBQGcFEMa/dpyuXCjhaSwCnUTGDDQ30LakUtYmRI/k3qFNuYiAP5msXUIHdwC1gGdV
	OD+bIEyB0ufM5+sPHwSLuHQJV3U4s/1hhOVigCA==
X-Google-Smtp-Source: AGHT+IFNrhLEu6zYUQrWi8eM5KK85j2ewBswZa1CUWGuWeU1O+O24u56JMEDx1yShrt3gYrIIBoDz527FwfqqAbpOIo=
X-Received: by 2002:a05:6a21:328f:b0:1c0:e54b:5651 with SMTP id
 adf61e73a8af0-1c461963cefmr2258455637.24.1721823920681; Wed, 24 Jul 2024
 05:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723180404.759900207@linuxfoundation.org>
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 24 Jul 2024 21:25:09 +0900
Message-ID: <CAKL4bV4Y=P1zn19bKnxDzF=brsZP_YscAUOWPopbsi0zeLHTsg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
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

On Wed, Jul 24, 2024 at 3:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 18:03:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.42-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.42-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.42-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240720, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 24 20:33:24 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

