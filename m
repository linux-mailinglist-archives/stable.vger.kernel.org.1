Return-Path: <stable+bounces-179027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E97B4A0F6
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E823C4E1385
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED345945;
	Tue,  9 Sep 2025 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4tBE+dK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71090211706;
	Tue,  9 Sep 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393880; cv=none; b=NkP0kewKpzDN6VJ27hLWe+YzUQpq9qsXA4u7qEW9FeE4+BfDuIGex1s0u/iyOH2NpoiC8GGundflLTAYFxY4XqZPJX+EHkJYD6XuZrd6kR/T5aUUFagrHiH+6Sl0nBvWYl6CbSvtYExYv2qJL49bHnvJDPPG/X6fspPYVMd0C64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393880; c=relaxed/simple;
	bh=Tb/9I9r3+HRBGBPJda2/t0vKpz6/1fF1C/OCaKN9U4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RP11KVaXDb6glsXLVLzDa/WI95EBBYasK6fbeW0CeDi/j/4HbaTPBbZMTE1J69fl4mN8oqITtzeTPQxUePKt3Iq+pL1VPAUbObqR7Va6hAcgehlaOaRm4WCI2nfO8b5+KxmFEBC4oZjnFPUToy3C++muNjW2QVDVyWq/smqAAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4tBE+dK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f6507bd53so5522048e87.3;
        Mon, 08 Sep 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757393876; x=1757998676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l25NFxExAUe1eqmMOMVfFw3dzd2Dt4hw0Sr3RoaXfRE=;
        b=N4tBE+dK6nYiF0Gpw5GX8MtBisOEt0oJ6IUgmgkvSGgJ+Wxg1XnY+fO9PC8KOUak3X
         7W7czGjcIT9tgpDydc8U73gNdZkeneS5mkxOYZIHVeV1CSZtrKKD5rxOtNPfqrMQUEmf
         d2UYgnojmhhVu5BQXC0sg0CPUczAD90j/wOHPz6jFHvwLsu+E9DsV8twHoKArM/VnrUl
         9QGvB6C7qh5rG73crEWQrb3sbCkIaw/IE38yYTKkRfQzH/ezFWvTO496Tb3DC8MWaIjg
         yuFZic310cN6nSYiKRF5unYmnJCd0kGfpbVeQSCAn/L3GW+cKhJ6GunvVKWcvyEzKxfW
         uY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393876; x=1757998676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l25NFxExAUe1eqmMOMVfFw3dzd2Dt4hw0Sr3RoaXfRE=;
        b=L6+03xiBwLC3XdRN3ALalLzbexoNXNGr+2cf17A+QlDLvkUJiwg1P76WfslUFR6Nhm
         gweRNH0tc9c3sDdmssU+mQ3ov8LSWNayYZHOxTpji9fNGhDBh2UiaTTRn/QUiHJe0pZV
         YqJZxWMqiSKNle6+SAGPppcvOUwBTLP5S+DQoPIzoCXbwclh6vq28rDc+V5qVzMaApVs
         FRkNjtOsPzlmzqTULML8HJ9/jibMGhjX7Gs4+I5KtQY7lxaCkpZw3sV44Xf2YLJ26O2/
         48d7+X6COBypTtCN7dpOWNrwJbsQJ8s1l/Bq4kAi3/KcnTgDs2K1Clz1IGLCcvS1cMp3
         WA7A==
X-Forwarded-Encrypted: i=1; AJvYcCUOXCRbYCCQvtZIleBENIZazFsXTODlS5MfYc+/9lsVWg/cnrGzQ9LXnp+AZMao5oUKRu05PZ27n+zw8b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKGMuHE/Mi+IZCHRrBp5NN6CYrQc9+jBBcc0qRZJ8Q8CiBUR5
	NJnKAcWUkxlvT9ypBAQaBRwsQaiKtVW4QHx6OGJyQIqJq6hBP9+lzk/Rg3SFb80MOCMRG1ki6Ls
	He9cu6wu71XUR6yCExLP+4hfAUKvL5mU=
X-Gm-Gg: ASbGncvJotXXShk2DTg/DHLA7PtZRA6dSAtN9mNqHVlYO7FRkJoesiugOWXPbcZolbS
	SGpQtsPj1QJbrjRhMQAyMVpH1hJ6d8UYPt063a19PlLQTwJ6RnclHZ82eC/YScFQdeLg6GdrTXZ
	DrEfUltWou8PAZSQUqTxJYbYTYpDxIoMQA8//UYPpl/+JHhEMtqstAaW/BHkVC7lhQt0RdPUcCu
	uxHchB1ka63wF0k65XiwkUzkut05cDpssxG6MRniX4lmtOaypDrSggXfOjZ/FAL3l0bmanh
X-Google-Smtp-Source: AGHT+IE4aJVhuUj7txtOnsYYhZRub3AWkInGLQh7N4cBU32Yoh4aAHd3WHdXBY7fRpvJ76Yz+6786ilhvVSEk1wTKAY=
X-Received: by 2002:a05:6512:3b94:b0:55f:3ddb:2306 with SMTP id
 2adb3069b0e04-5626310e5bdmr2842619e87.45.1757393876318; Mon, 08 Sep 2025
 21:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 9 Sep 2025 10:27:44 +0530
X-Gm-Features: AS18NWC-8lpDwDSXRJI-52ZPSz8rigrQ13cs8hdUtHhPutYSVIO0pan4rBPN_Ww
Message-ID: <CAC-m1rqeq33V5JU2HuQ+4iw4j41CZqCpocgKG2uLjnuTnf4w0A@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:08=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and boot tested 6.16.6-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

