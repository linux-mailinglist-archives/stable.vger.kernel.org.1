Return-Path: <stable+bounces-104172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DD9F1D12
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 07:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334197A0519
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E013212B;
	Sat, 14 Dec 2024 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Biz0Kp73"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB73A268
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734159442; cv=none; b=nG87bbOhgOOvZ6cnIBbIw6lX/Nth4f5HGo3hqyd5bXo3dVAGJinzfdmR7aEWSVGCN1SDme1gcAEXZj8FG1LwDZ4Sn68TrXjhu63oVEE8dET8vE/OVe4YjMk/K9G/P6yoz1WhLXX/vwKCOO+efDHiKEnBcoDpIY46qmohDQNiYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734159442; c=relaxed/simple;
	bh=s7Maksqyo1/cbgvd2H9KCJaNZwpklbS0ty8L690vreo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZjpsEHkh1Lhrlce1TTOe93DzLzTuYmkAiTC9/GSfBTouk/CyAv0cr5q3hEnJ9KQ/pEg2r3gDt5P2Ki9Mo7MiGymfJ/HsNrsj1IoPBndF6o3KbFO7LO02OgJoxyPv/r/0xIwOmWNFOMtQUOz8c8ydq9j0ZdoUqNkeNdL+EQ/zME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Biz0Kp73; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fd5248d663so1858355a12.0
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1734159440; x=1734764240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unpH/x6sT+wpQJiB0CaAbGxv+9w2ZHMovGzlygSlC2A=;
        b=Biz0Kp73JnwyCisYgCuaJi2RAHrcSwyTQyVYPT7cstzmUjyeYch3KkYjYg5cJnQViM
         T4EuHBCl8TZ25SV62ZhHTmpHo0Wn2A+HIS61JiDWJj6jHE1Mueljpq/unnXjilLUAGg7
         eKLXxXMUE/oJNwTDIsggckKs3xcKrEBqD09m6VyxKXLQnCRGblezwzGe2xS6XNRvSPj+
         doC+pJikdiyNXv+FF/1oZkqSJL5a8LKNVDJsJGEuaB1T4ztX9uRA6A5EeGG5vdDUYWd5
         SAHVdcPeK1HOsHyHv5uB4ukfEDmFGHeWpVCJjFeVgItecAAKtgLQI6pQoFN2kBJ5PPIO
         fDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734159440; x=1734764240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unpH/x6sT+wpQJiB0CaAbGxv+9w2ZHMovGzlygSlC2A=;
        b=KrmmF8rRWRsZlaHRL1oXIfIEhC/3Ra6TDR75RryzCvziOYk9IPWOMJDITRBiTOXHKr
         qpoTJEt3sjNl+9O+3qIlOqqm/5T+bET+BH0TbvbIPrYzapF1MbPYNOacsDx/5c0jA/ke
         BzrF+4k16hCpdRrQG0Et2RVrZu8g/jRRS/iVNDRo57+4+ANAtpBLNOhRpVefS9mqAkh2
         2HgZTHxUG3tFcUsYIu3QFmZqBaJL0y9iAk+RIhJ44ZyZN2Vnw7fSlaEKv7+OOcf75NCc
         hMoAl+s4ZmJ+SHhACWIicX3BTm+QmZU8zhUzHql+3Rld5ZDAM1HaibWIzKJU1ePDwr85
         owoA==
X-Gm-Message-State: AOJu0YxBOp0NoJJKVhiN9+S4CvkfuPEvz5VrGq76Dnx3dqC7UVETwUNi
	whecwECqCyp0JQ0NiIlZZmPGpYy7M8hKpwqtfkl3N3ugZm5DmqtiPTiJ+ineEqi1O7tqKz5DdCO
	XgrRP7QPnJ3ESxsmbhlmQT12tvG9G3RckIKLwaw==
X-Gm-Gg: ASbGnctGttAJCaKfQaFImA8K5iGIjG32M4KkUAhIO7HBs6yyTGhXmCpvtQ7mwvTpucA
	X0bSvQsS8pOmpa4cHQf4K4ZPW2cuGK2qvxXqPdQ==
X-Google-Smtp-Source: AGHT+IGfWcHf1IqCM6xcZ42qVvO2ln2ZF7gp7PWckjle/qKeI72/cD+d0i+huT9mtsOvNbU440ioF28S4h2DaAFrN0A=
X-Received: by 2002:a17:90b:1d51:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2f28fa50ff0mr7489453a91.6.1734159440009; Fri, 13 Dec 2024
 22:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145925.077514874@linuxfoundation.org>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 14 Dec 2024 15:57:09 +0900
Message-ID: <CAKL4bV4y4ftwOw3E5soaob-EkkDS_5miUmziwrp4PTrh4aK=6Q@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
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

On Sat, Dec 14, 2024 at 12:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.5-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Sat Dec 14 15:37:12 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

