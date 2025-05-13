Return-Path: <stable+bounces-144158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF84AB53F0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DF93A5727
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD628CF7E;
	Tue, 13 May 2025 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="NupMLPoz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1728C5AF
	for <stable@vger.kernel.org>; Tue, 13 May 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747136338; cv=none; b=TENEikrCAB3O3hCyfiBauL1RN7bF62TnwOS9Gv5w2OGyTxOZK0TpBMibRPNl3HPQMAXO9ZKiUrG6FRos2kjbw7QqYo9QYD6vZ2gXr8+ZbUMhcBVgDoERT4MzUWYH4PhmysVwn71upgjw9J2aK3IeVYzHY9LMxpewef0TJn/9s+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747136338; c=relaxed/simple;
	bh=QY0m5Mq3QK+qfBlMurOu9d2I4hNQNM9XNrP3mIvuRdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmSTnI5tg5BlqwfH8eFuEFr2lpxVNPJsSd5x4kyEK5/o704eVxp9hDcu6DjlYy0an7XM3UBsEeex2LoPKTrPaQ8vIz3R1XHPwzS4zujDueYP4OH8oOZgBaD0MnkhWw0R03wLutQ12xWJoblmgYvbU/Ppg16Y9pfGePb6aJ1PFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=NupMLPoz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b1fde81de05so3494865a12.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1747136336; x=1747741136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCDA/phudC5Ubp3SYy7GMsyot2oOw8W6PSjAa8fXQIM=;
        b=NupMLPozXzGpaR85/35iHBmprYRuIhjhVQDmZuP8/X/fXWjA6A2dwrRP4ZKW8DBQkl
         dH+XSxfQCvAhtlzd/7HDN1fc/9+2xcZjb4qd5sgu+zL2i+w9YRBW9kGxKl2IOuAsbe7D
         TePrCLrxKmCvYiEeiqLDMwBy8z8z2Ot/D1XrWoUBWTfFfkMKs30dUo1+R3WjZGBL2TNq
         9bDqCy7meupTVLW8qqPG6bSDA/R/Khg1egPCGGdsK2sLvQF7EAGbKepuUqtoMF3Zjr/l
         Ou/7glMlUC3x0m4ZkT6prHSivTemXd0zr+SJdhOUi9B0ifTkYaOtY6oqL8+wQ9ZOwe3N
         Qq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747136336; x=1747741136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCDA/phudC5Ubp3SYy7GMsyot2oOw8W6PSjAa8fXQIM=;
        b=scwyGcNJ8ryOUwYNFwbuN3Qf6DeQj4WOCCNhiLFcmxrvyAhHfiVx20ZpkNM7XBtbxG
         +tK3OODaT7Fvo0Skaj8Lt2kB4MFA6d6uIsNXKPrOMt+E6BjjqSrlB/kh6sWj4X5OYdoA
         qiXerV6wN1eROG+V+hA8l27Z6cT/19iyb4xHBS3xN/dTF2HMmMXGBX93cck1GYHiB/RT
         SG+s2+ATmu0fx0POiyvOifsQUo9f0lOSW9A6NJ96p8BzLGyvYAk1nb8KQYLE+SHY9FUO
         yt5/upllyuViQagsiUGn7yGXz2f+EX6uESD3o8+uqfFZeSb7d83Xx2ebgv/Y6rDGdveu
         hrMw==
X-Gm-Message-State: AOJu0Yy4cJYVLYbZQz0nrX5hJekZ4X+EUu3aFqELUy06PKYkVqYcQcrK
	UKcOZwVuk7KE7xtGRyVizHQlLDtQ6mW8UBAhCJgvEwx94P4oIJYGsEHKoT8PVo2ugBbgQhzUihX
	EtGhaZD1wAzVzyY7wmkOZtgdMhtz1fY205nxHoA==
X-Gm-Gg: ASbGnctbFsGDvYB7Ch8f7FdgLngMuVi2OS7RPg6yWbrvWOq+7iQNLoCUAGWkoUwKMHx
	1UngVi8gvWdXn7BYg2/3fpsAj/pXaX3AtEO2B2StMRZjN+uXvrtFp+YtxCCoNlyeqI5VfMiQQwe
	P/A6D4rXRGE5byW6bjpNUfecgeEDo1KYSG
X-Google-Smtp-Source: AGHT+IErFEavacYkaYzKyCsj03GcwMurqloDPo5UyC1bTq/RXs01iErBjbluQ3pLpthUG2UvLKbubccEK3QOiy15YTE=
X-Received: by 2002:a17:902:e492:b0:22e:39f8:61fa with SMTP id
 d9443c01a7336-22fc918875dmr204499885ad.34.1747136335849; Tue, 13 May 2025
 04:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172044.326436266@linuxfoundation.org>
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 13 May 2025 20:38:40 +0900
X-Gm-Features: AX0GCFsWaVdpAcTWj-O0CPOKts0lC1GIeXOFV79lBRasU6leEtinvJHx6zatOhY
Message-ID: <CAKL4bV6qHhnbm=Q-pXp5wzba7GKhwCwgWGc1QsRCq-eACo_CxA@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
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

On Tue, May 13, 2025 at 2:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.7-rc1rv-g4f7f8fb4f8e3
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Tue May 13 19:59:27 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

