Return-Path: <stable+bounces-151869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E30AD10FB
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE29318876AB
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 05:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00517741;
	Sun,  8 Jun 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="yMebrNsP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A801AA782
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749359648; cv=none; b=sURDl8meaCk7Q/L+hZ9lChiNCMQASeIJjUQypUDckfN0q8nIaEQ5An9DbZsP173mLdAZad+N1lfShT9YYznCYMoxtrNEAWetLl5DjQy09jYiFfHc5NnUCinF0Jf3Kbm0LpbITQlCpxHnouk1Jz8j7sv7hON8//OX6JYTRpdfBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749359648; c=relaxed/simple;
	bh=R7yFIfJJ72yu/12lLfw+YdCnKdRGHYhVeS9kfsURIWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZVLUxqyOsBBHC5CgtP+LfT4WGvVlKTVCT70esgkaHt5rHoR1lU53yvgTcsQ3Vf2GsCMRAT/IeJOcb0sFAH27TGPon063cq2KZ1llr1z5tdaeMiAj5KxeOvj5jgnihDG3uzxe3uYwyJaMPWtdIUieJZw5hcETJ8DlVIqnQAMh6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=yMebrNsP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so2457565a91.1
        for <stable@vger.kernel.org>; Sat, 07 Jun 2025 22:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1749359646; x=1749964446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq24FXrS96fZ/hOloFhOjn4H+O+16opz4TqnnVXi5gI=;
        b=yMebrNsP1oACfWNxO4xg1CXaswNMsX4L147PY7+uUlMY0Wxv16N2k2m9KIFboq3IZj
         BOYC4FCQWg1BKOCYw0Ix2p/NJ6GN7Jsm6jNcEx/po/S4HG/uuoibiwewWdCPx9eAUOZi
         3BJdagFSvrkFXByChe3G3jEVInXtwjEytiymg/TknhXP4shiv44BLLD+MLm1ygoeCBz4
         Amu5jK72aYc3HGbxWnpNmJs9foWiJB1Qcx/hRoXDg8pwLZd860jiT+F74ZinyjLz8LJm
         jhG6KwCA0cDD0MsNldLMLJJwEI5Gix5jgUTv+Wa1ipMebqA7h48/z8MeNntqJ8jIqSDU
         Aqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749359646; x=1749964446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq24FXrS96fZ/hOloFhOjn4H+O+16opz4TqnnVXi5gI=;
        b=fD5IbL5q3bjjcp+8AFRw3AUJdE/zBSnbMM4PGUE5jH3eWjX8wIV5DJcEmKbRFfB9Vs
         jE1YOWsa8C99YDM8+v0R8k3kPqsLeKRbDhKn3EecHFAAxchyA2nDjeX6OFKnpTSNwNh3
         1YuE5uphp3htXjBnGHa/iZFZTK33fBIVq3rlw9e0GE4IjGjOfjNAgE1kcx7eMT/tCw/I
         mV4cL/SAEp/UBd++/Ve0/r0ENUcF+CQXBcQ5787Qf9DDhVZFScbXN29NZlZsR6kGJd+u
         8G4VrayuwafcsVHkLPqfF0oKTAzypmVh2QcTXevLVGvRcVihSCVnFzW+N1DWdBhV0xI8
         LtvQ==
X-Gm-Message-State: AOJu0YxjP8VbHRSoPSaccfdQ7nGSEk4+ScLOWs1wfQC63WFz1KXPUAOP
	zOVnHLyHg7TELJ+A9LKAI7aohDrCpGNziv5C8tjOCqOE7JcPsodgztgm6Rrz3SQtuuUXXGJ3Kd3
	AmX24H3n45ZNYc9bJhaNkkSWnzNbX3U7rsJshRCjvSw==
X-Gm-Gg: ASbGncvPwocpT1F+1oLUrHyJ+iubgUPosm8b9/Mz9w7Zc53776psmvfCfc8SgWTZ0tm
	CINp3mgQVpqonl5udDxYvVIBAik8J+QxB2Pq/G1V/Zrp2vL2gp6J/qpmLmmdjxteJCqGmP61BET
	ceIM6bYEmxamTjwSe6csOKLxwW479qcUvX78yS5DWeclc=
X-Google-Smtp-Source: AGHT+IENDAqgfEmWtDHYiRyVTLe/VG6n9eA8bBw+SHHFtxygDA218GlKFLInc20fHWa12oeOBRLbkK6qXbDoHPE0cPk=
X-Received: by 2002:a17:90b:1847:b0:311:eb85:96df with SMTP id
 98e67ed59e1d1-31346b56aedmr16157454a91.17.1749359645765; Sat, 07 Jun 2025
 22:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607100719.711372213@linuxfoundation.org>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 8 Jun 2025 14:13:49 +0900
X-Gm-Features: AX0GCFtkSD6iMqXwA4mvNAHmJR_H_fErF2XtQqI6x3N-rGaSjH3mHz7rlegcE3Q
Message-ID: <CAKL4bV5xfxq+Hvnd3C6DdjTT-WO2dcjgK_yLGHSPu-vuq2iW4A@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
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

On Sat, Jun 7, 2025 at 7:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.2-rc1rv-g04e133874a24
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Sun Jun  8 13:31:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

