Return-Path: <stable+bounces-183394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB066BB9855
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 677FA3469A6
	for <lists+stable@lfdr.de>; Sun,  5 Oct 2025 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418C28B3E7;
	Sun,  5 Oct 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="XPJbynRL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41358273809
	for <stable@vger.kernel.org>; Sun,  5 Oct 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675049; cv=none; b=XbZkUkAhfTxFAAaigTfbCy0gpOD5UUkws2dkZaQ5xlDfK9i+wxCulAGpCZcqGCbna4GePE24pQ4w6OMi0mjgNRAm3kUrGgPh2eT7AugRrNDayTuAYu+2MpjrO5NbENYtF46yiA6DP1Xoj6QGsnaCLyTLRAMc8ofWz7/iy0pCjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675049; c=relaxed/simple;
	bh=68Hs1m2KCNgUTWFrubMbAjOMlruERL80FpRXR3jtVUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9+CRXbPjtfbhumwYmoW0jt8RVBN+o08B8rffqLDCsOtKNBjHMRx1/mcFiRvg0MTKvV1SAf4cTk7Cxw3XOx8bCLPXqhoxqZPvsMZCSSMi0mP3puH33Lq6LcuNndrXNdo19R889eHAIYXxh8zohnjAOMcW5wz0kdFAcVzb7Or8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=XPJbynRL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so319322a12.1
        for <stable@vger.kernel.org>; Sun, 05 Oct 2025 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1759675047; x=1760279847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqeLcDuce/fJEO6dWcvk7aWGQEF9pvPJT1tdDWjmEQM=;
        b=XPJbynRLo2d4Z3Qyidy8Ih+M/8YJ5cj5EaMTXzDtNfHfFyRBlgU8zcFFQeegcMoQQz
         dVI3WsHNo8sJIphjVniH6/inQVTGA7T+OVU3m77d2TB7wrvDuPS63GrBFG6FsoSjOabT
         tc5gvNenzTAAqY2pq9o8ufVw1dMCL/wUt3OIS7vny1XO/AJzSJjqcfytiOUcZgLQxnGL
         frdpTH8dj+hJBNp0twFV20a/ENqyFgGIPP8RJ9h75SMGmRMLeAPYZdsEfBlt4konE8V2
         nf5I3QqJdmw9u2y4eKGYxw6r0N5xh7w9T7jP5VrmfpJCn1/9TDVyaakDiC6xubAATkGa
         oKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759675047; x=1760279847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqeLcDuce/fJEO6dWcvk7aWGQEF9pvPJT1tdDWjmEQM=;
        b=iER8O3PPScuNOmmAGSQePhOLELnfT8l0dbTcTU/suEpRakNrCnEP0q18d5heLA0xC7
         PG/CSwhR5b5mxfZwfCP68vJ5aVqY/f56rPOsjfCU7wCyUIX5gLi6qhisIRxNiugDab//
         +SoOU9IzIhUmCKnPuS03QfTCzFaRx6J8PazpNDee0zxhVBT//1PzqqiHCgKxKsJija8Q
         btRG1ZPGG49ys+S/RhCj9UHvE8EOjD1Hr5zzPMI/vTT18r6WwrjaZiyUnJrzWnqubt8O
         o/8ehz3Ezz/vCsJuCbZmcJmQSBUw8CV2C8b5mOJVdSMcgrG1C+27xGDs+XExWbcM4U8N
         N3MQ==
X-Gm-Message-State: AOJu0Yx5mcPPMOAYtx4p6zNVWRxqWWRx/VxAy5l96imS5b50VyvMM/6h
	g3bgYvowbWDZd4gszwn8tf/I42R7j1sPGfcae6fa8+5WZte1y6m4KyZW3bLTygwJU6/xVI9DpQA
	5qEhVw483aVSNKC6X9+RL3JavN60OvbH2nwiFlXZeiQ==
X-Gm-Gg: ASbGncsWIK/TFm9TwmTfcrejFjo1AYr+2Td10bYm+y1dCzo5gAUP3DxM3RiqqoeC6AA
	uq1zvfmuJ+7i0HS+uGOPYqWr53K8fTUFK6WYLwcdkowv0NXCxwTmVBCxw/9neR0KFsfJBEGaVMj
	FM+8kQL0k8SnsenQNUDvm1xoC54VdiK4UlXD/iJ/VC6uJt7bff9yiBVUNr+m3b0Rgs4CfDCCx1Y
	XsmLQwF/ef+qgIx81ujPo0Yn1UQ5TI4lB9sd/W2xw==
X-Google-Smtp-Source: AGHT+IF2SH2TFu3dkLS6uR8T8yDPp0+s2BJIdcXwXmq/VC0MdS0nzpDNEz9+ew3L3311RjuGHEf4dr7QtIGIj6GFOYw=
X-Received: by 2002:a17:903:3504:b0:24a:fab6:d15a with SMTP id
 d9443c01a7336-28e9a5665f8mr106992295ad.20.1759675047357; Sun, 05 Oct 2025
 07:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160359.831046052@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 5 Oct 2025 23:37:11 +0900
X-Gm-Features: AS18NWBfJZ5Th1MJIXFkn-PdqzYH5JpHlnaEZ3ST9sWDu2YJAX0wQLCac07MmBY
Message-ID: <CAKL4bV6Gw4KL0=bnh3hWk1bwQ2txSAViM=k+BKZa=FT4opoXGw@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Oct 4, 2025 at 1:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.1-rc1rv-ge7da5b86b53d
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sun Oct  5 22:53:48 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

