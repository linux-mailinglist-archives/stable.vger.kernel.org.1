Return-Path: <stable+bounces-192017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D43C28972
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40F9D4E11B9
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1823B63C;
	Sun,  2 Nov 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="MKui6PLe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78523815B
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762052347; cv=none; b=FoFioI9V7Rt6De1bKurK2SyCvE9Z7Zm2tCEfbAUmYItiPTHvxMZLGooo5hunzp3AxiHa3o6T/naxFwuebZqNstPtA6uOMfl0tN9Ft1jRhcW3t+2eCP/DvQBkpjb/E6clctB2WPWE3LfAQtdAMh2mUOQvhFpgX/7CrLDHUFVgV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762052347; c=relaxed/simple;
	bh=obt3aM36cVJabIYjFO5PbdxBdgxz9xRXrzbYELuVAn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DleBe0bMt/Tcj8n0edMAVsqrrIo6x4bdapG/9JJBHT+katMg/Xga8nKHDYgv8qsx13aYOEi4OO9qS9c6EmOkAPPOxXaBFHfOLDJxgA54Lm0AyQuw3QecYLrS9JQWMie1A1gqNk4uTbmBVIWOg/MBhPOG/nlU5CLWakLgXq6gyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=MKui6PLe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2953ad5517dso16440695ad.0
        for <stable@vger.kernel.org>; Sat, 01 Nov 2025 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1762052345; x=1762657145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLumh3cNsj4A5S7s0QtpZk3S8e1GvxVj+uYG/2PIV6M=;
        b=MKui6PLeetjOUJ0C+HiSqWhXxSHbWQFmfL1pEYWTrQKyerkIi2tw8OauoJ5yTfLjhX
         4Th/853SQuS3Ms8dH/oknqfGOpmJM43Pdz71hZAkPgfG9N0paqJSkbjJcv+P0PpZGSaF
         whk+sC0Kwu54auyVfb9F7RZw6zwvsNqe5XoI/CLA12AzARSsYCQikxLeFN+s7dXiqtEk
         1KCXBQZKYdvAOhPQW2Vu0NBIr+BYBmVekEPtAgZLIzqJdQBqdXiUY28oo7IWrG995psT
         lGQkLKtR4L8r4LiegJzlAKPUnYzVAxSmzD+iU+HKJ8f86tpnmfieutbfjzhCzPdF7HaZ
         nhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762052345; x=1762657145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLumh3cNsj4A5S7s0QtpZk3S8e1GvxVj+uYG/2PIV6M=;
        b=tiTmy3y7Bs2esNAl8nHozU/QDY7TB2HOkCZ+RCWWZSciabhkVrmRezHhLY6vFwLvAK
         jyh8N+7SEV4JqbkfrhVxRtuOK94iTOnA0qDXu5eBmu0SlILJ44HE66Y97JJW9WwpNcAK
         sfK6yEGI7YSEoAmKmZzmPk3tsb5pEMXnxCC4x3QtKP+58Cl6VCt1WjQ5+nEouSdAtjiJ
         HriVCrp1d58A2LZbImH2pyKyHvAuhGJlRQsE8KfSeaKgX7hphnFMeVwiPllqYagARps5
         Emd7PsL9bW/CnrYmqxj6fVht8R03RmQSbmsQakCQG6CVNpOyHo/X81xf5iRum3xI5/nr
         Ty0Q==
X-Gm-Message-State: AOJu0Yzj4eUNBc/Bo12/huh1KSnkDJ6ED78zaT90pSemOl23x+g2wrv3
	K9dwY9O0tigFNsTRGRZhMuCUhXMBEqqoSrZLsqwb9TFaSBrTvQOOjVGDMovZFB+xhVMSpDKfIUp
	swpj0hEEpvPmrHNrfBfEsCVvUQ8BzD7NWoli1Jq20sg==
X-Gm-Gg: ASbGncvSexDCRXburd7aOva8V4g/MSU6Z2gH1iRWxgC/86dPfZE/T+BEl3LYnR9g1WY
	Gs8CoIdsJBRLLFHXZPTHZxgKtEMH/xK4/RAQtpa6TAPmtR+kG19BU/KMThEKsdUK06sbw30Yewj
	c3z1ztUSKHW5z7kM/057CMK5mZ2nmoc3Vq7mWAzElm1SQHWMNcu9ZOrm0cys4Jy0YfzqeRHDS9F
	rz6LIzKyNbHrs8Pjm3xX7lVHA9F3ozCu6l7+PND1TAB4LYep9kqkXpV7/9RyyCG2RpF5iN+qBkO
	xaFLD/DERJpdzlhUfCOUieOdFJgL
X-Google-Smtp-Source: AGHT+IH7KUMAuAewCAP00Q6zBbvodvUMs+s5nG+cFcTWFTo/5afr/24R9eJSZ4skcRLpRH3OqFtHPtQDMzOEOkj5qXc=
X-Received: by 2002:a17:902:d511:b0:295:64f8:d9cd with SMTP id
 d9443c01a7336-29564f8dcf4mr34382905ad.15.1762052345170; Sat, 01 Nov 2025
 19:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 2 Nov 2025 11:58:49 +0900
X-Gm-Features: AWmQ_blFwNNxtlVAJhO9Sw2HMPpAD5tSqM9C6mgS06bG4B6-NzncKglA43uu1qk
Message-ID: <CAKL4bV5rU0eSF_MsKV1aW9A+FHquRi327fvakT5Hy6ATzN24Xg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Oct 31, 2025 at 11:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.17.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.7-rc1rv-g7914a8bbc909
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Sun Nov  2 11:13:09 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

