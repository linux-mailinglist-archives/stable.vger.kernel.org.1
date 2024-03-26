Return-Path: <stable+bounces-32317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD288C229
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 13:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72361F3DE0E
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB22433A9;
	Tue, 26 Mar 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="u/nHwhSb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9954902
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456372; cv=none; b=DZtDz7nTqxT7h9cfCrDcZgW6lCvVKbI59zyZjzZJTajQD1yP6ysALM1heaIDNW9z6qidkbxX4okRzyxwhoQQZ3uVblWCQE1UCA4vY0w9Fq6rFEf8/bwtnxmX6ObVE5JUgCrk+EFopMtDD1nn117HP+76u7ftrn7/TG0wdeRS6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456372; c=relaxed/simple;
	bh=+TTMS6GstYCX8enwCzaDrp4EKZyUaw11ymfdNiKNLI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1cGEHiDEHYQmIiQH6xOWY3KF2IRDpai/vEuyw7hPqKNjdHbAFnLcfzpz7PHKFEv6VRxDDgRw7xXxLUl8lfz2xjK3EDci63phk6sC0xWqiC2FH0ijEh0EjZU36iydWCDClgQSbD0UJK5mS4krp2nrqaUG6wfsQrdvz4ve22amiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=u/nHwhSb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0d6356ce9so12159545ad.3
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1711456370; x=1712061170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK+6QXN4TcCCwm2JgFdztpoGu8OOn8ysvZ847fB5fws=;
        b=u/nHwhSb6cpQ58U//kywD+E0dn9OLxluyNSsYWGzPHqJgHEAXD1ANqtsMGvhbZneG8
         DPXdLJW3SNLVxs8HnTpee2x6x2pEsBTmhUn0YyDmXcbZSHCIvTapdecb78LO9KJFcKhy
         ZjPiJxlFsYvnvMXzNwOQwGtYCgDifvtXrnUrS8JKgaaL/T/8Ekwq3BkDBDnpf8Y4+wML
         wHlnp7QSk84b+t21mE/CN3sNXY1UiAoOZniYz2iCOC8TYopsK9yrU87Exu+v5KSuqQVc
         T5jb8UHy9nZph3dXDWWZw2yh36ypmP+aZWpi7LkIsLSZxEzs2CL8FFiNUSkQLjubVtRN
         7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456370; x=1712061170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK+6QXN4TcCCwm2JgFdztpoGu8OOn8ysvZ847fB5fws=;
        b=gkkEz93XvdyWhN36XXAf0n5ZbaY8lEiwrtwJXBIpAzwzL16wvlQGSlH145arFA4bB1
         2Lf7JfXxQ3Wag7nRFSNs08VCdWLw8s7BLsJigLyH9iliQB7vafynlV1gSUL7X/u/OM5Q
         qBfeoGXJ0wGAsXjU8gI3Ep0qqr5Az1fO2Rl4njS0NI3efdwD8SEvLUvcALG/t5ykXN2+
         qeO1XnvrD83KWLG6AQM8bcouzMyyxQX7E7QErmi7rPDmNpkLjZPm6IQYrQSSyhkjjuD5
         dEoJHnN5qGA6c/5lilSYlSSj84cJjEq6gYo9Zb76Tu3OupORkjQwsGrJ9E8w1qVFute+
         AC9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+TcVMWtCMtsVTgstiKs8pznZJqQcl80gJkMYjPHex4t/s5F2SJhadAF0ZLSFcHX0fytY6EQZb8UmCtIKcItTeRy3+v48O
X-Gm-Message-State: AOJu0YwgC9MffaNC0D3MDA24FZ3MVOAl+ZRK//ntLLHI7WpEuc+Idevx
	0o46C3EhdkucxzIHGhxam9NILrVave8uWT1n80/OKSUnehI2jjQ6uKSbcw7r+4IiLl1hnmY3M/b
	XfnT/b2mc1bVVBXtp2w+G1r1hWysDvRVb2PVNHg==
X-Google-Smtp-Source: AGHT+IEeX6I08TajZ7onirE65m1mprFAA5BwwUaMFPC+mgRyFceOIoabWAxxwy62vLG91qYBhgDQwVg4RWugkzvK/NA=
X-Received: by 2002:a17:90b:128a:b0:29c:3c24:a5da with SMTP id
 fw10-20020a17090b128a00b0029c3c24a5damr6999204pjb.27.1711456370525; Tue, 26
 Mar 2024 05:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115951.1766937-1-sashal@kernel.org>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 26 Mar 2024 21:32:39 +0900
Message-ID: <CAKL4bV4hB=mWzgSyw7direNfzP+42faVPdEAC88RzZ1Nf3GKaA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Tue, Mar 26, 2024 at 2:59=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

6.6.23-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.23-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Mar 26 20:27:44 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

