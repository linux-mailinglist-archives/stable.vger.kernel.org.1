Return-Path: <stable+bounces-147893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4951AC5DC2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 01:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DAE4A2FFE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73519CD1B;
	Tue, 27 May 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WcAFA9nj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECC215F48
	for <stable@vger.kernel.org>; Tue, 27 May 2025 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748388289; cv=none; b=h+7nuWIt86V/u6X+kfDI5YRRweRsfLKRHZ9JW5mL2WBQnUWY9hY9arHSOkGLpCEq2ng+JYib5VagtOez+HdF7cDeq8QobHetr6pM4IvlCCyOqdrWkC3mtiah4Aa3P12h/PC6D9if8JNZkyVVdNnT2s3BKSmUqo8IHUqsf0u7Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748388289; c=relaxed/simple;
	bh=jKy9NgchQt+WvfZ21StHpNggfPe2eTnQo5wDW9nwTDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpZ0zaZQtYlN/+kt7Utv93uw2Brbg5RMOaIVEnry6xnKni+HG5g7ysF2u2rgvOuygh+JUTr7ztucdVpEn/9fRaunKqyUvwUP+L9sMCcLVCHJS3DRi7Arg9VRKCZ57AymJOQiwoVelxyy7h5AMZq069JcXPF6cn2/JtSZjVla1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WcAFA9nj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso2248965a12.0
        for <stable@vger.kernel.org>; Tue, 27 May 2025 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1748388287; x=1748993087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/AdhCxX+fhaAjqKIeGANn/dtdFJvwGse4cpAiUUl8I=;
        b=WcAFA9njMa2VYAI8j2ZPo/zHc5ORWTTIycFo221I2UboREN/oMXU35jOmFhihfNKtO
         +pyzt1L47IOh950wVEh/zeFIX/TIbCUO/52qCPLeHg/KSyekuA2QmZJ0kVdhSry1xCA1
         22/nyj3G4TUzQ8XooQqvURm+Eoqto7zwRYRczF7gVWjPg79xDtYOLJJx18rsZ+BZD29j
         S2g/slpOuXFlnfbvYIeWT6rABL01hK+e2i+e9NMMgIMNziSJ1Q5e7fzwbmmA/Za+jI3J
         dds7yseeUKLHXDyQBlvtjU6ss2K9QnLgQbs8PNIeGkptOj/+eT84mUmRZXlmD8zNvXcC
         7Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748388287; x=1748993087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/AdhCxX+fhaAjqKIeGANn/dtdFJvwGse4cpAiUUl8I=;
        b=m5u51rd/WAXKRburH/4JLN/JyC7pYo7zTRu/UFzJgcnEO8d2fGwduYxJeo1pVej6zm
         3h2MS1clICH2B2OwXeWUT9PA722O8ZAcPYssfL11m6iZpFwwzkCJLt3SRnmkUD3Zmscs
         nSvZEK+3Z9HomeWgrEAbrfQ1s2YwP5SNO6JvtDS7wDLrL5/p2BAm85lTYt8GPaeqldul
         gxTRGnLPnuFlIyvPcNvrAxRwg3yN8Rt94X1LhNOoU5ir27+QZIEG17eYdihp/6hmkTDd
         5oxhZT9ebkMAqCbbVIYwaXVP/7Iwxsp7YC5coX4xqYfp5/9ThyE3d40BNWsB8zPBX5fz
         gT6w==
X-Gm-Message-State: AOJu0YxM/luyfnI4+1Gx84BeGeqL6Qv1h3v/CAoSo5WWq8LlaJq+c9TI
	XD7H6HBqfTqX6qtegHgkIBRSQa2Tq7ZLZSpMh4GMsVFwioOkfyj+kbxP2723bLls/4jRrkDzOl8
	yT6RboYzvvRVx3OIfhIaIiehDJOLp4zFgRe8DG1TgKQ==
X-Gm-Gg: ASbGnct7EYEzegC2b+Zj5GZGGNm2Xd+TPtBuqrgC3ZWduyBcEEcOvHR5ljFRyRnqaVc
	WP23SGYAY3qsfDiUj5+7Vis6svDi99ydfHLz26ehyPc6sELw1JywJhjFQ8nbB8yP7yr1Xt9uYZT
	IY3PIvH2d2uUmSbCx5f1My+rdeA93Ug33P
X-Google-Smtp-Source: AGHT+IFmwubUy4FOTdwjh+r8gzogSmYCj71cSJuKN6sXG+aSYoZbuPnq23rLrIFrYEL3P6VofYv7oiykuQvdMbGlOtk=
X-Received: by 2002:a17:90b:2790:b0:311:d670:a10a with SMTP id
 98e67ed59e1d1-311d670ac7amr1862164a91.21.1748388287317; Tue, 27 May 2025
 16:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162513.035720581@linuxfoundation.org>
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 28 May 2025 08:24:31 +0900
X-Gm-Features: AX0GCFtS3HerPG9aWFxPBUWJU-YtanQX6WBozRmlEInmQtVP7B-aaEmISIQqRe0
Message-ID: <CAKL4bV533B2X7zzAUY5VMUD0VWey8AK5LFVC=nXOdYu8stf8-w@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
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

On Wed, May 28, 2025 at 2:19=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.9-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.9-rc1rv-g10804dbee7fa
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed May 28 07:41:25 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

