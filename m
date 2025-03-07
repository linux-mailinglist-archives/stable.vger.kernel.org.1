Return-Path: <stable+bounces-121373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D2A567BF
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC701890F19
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE64218EA1;
	Fri,  7 Mar 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oPhHG8xY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E99218E81
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350319; cv=none; b=hI1l47orNkeVO3oHwr7pSsvIrnCiUMdDk7fPSTdiWtIY4gYgpWZKmZvt4uBCHlKOOQmsns3BYfb2LtFXs4xI73ZxIfDmTdx48ew+wNimIYJYpIZEhu4lwJ1M1foZmYQRxZqobJ3Ryn2FCpMHHCJlELh4qt4Bieh83kLpA52a/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350319; c=relaxed/simple;
	bh=cWtcLtZgpaH/BcPDoH4lq4uUZE4PyN6b3+uskMHMYW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBHcxsDujWAtrLEZjDcXRDc6QlQrZniISwcoQp0ZkPZHeWbDEPULFoor0VFGwUGpeEKszt8lmCx2rpAN7RhfNDrlaVilBkWw/GRUGOx6oHn9DsYAvlJCnlMcxdqlhwL1hEW/iomKkMN1m566YGYAs35V/zwQDt/pS+5+3GphyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oPhHG8xY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2feb867849fso2815810a91.3
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 04:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1741350317; x=1741955117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDU3rB3lwTDhzbpDMnrAAgHgs/LQWtd52vWgHpI2VSI=;
        b=oPhHG8xYH2ADeWUJKhE++2F063+/AUZGT/1zCgbheDMdTkeJpdKpIqwRrLNUhIP1pz
         i6m3enEzt4OOaTmZDkBNZj5IbtoyPfIZlTxIZ1zaODv93Ou8yYUNdARVq3xpysbiUTnY
         ZiSvBp7AT4otsCHGw1aKsLA5fpeSAmKJZFBmo3rI1SAOqZdo0bh3eLOhvMTYtkGNxE0n
         ++4Kft6wJQc5ifXcpagqOBislwk3hOuPYHcGaW5aNbi2H+wIg6yXqN/p/CTqGEarlSO4
         t56InySi0W5gNAx5OxvPu+YrcPlFwEznE06wqoz/OmyiZceZviomeM5dERqr06LN/xPO
         TGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350317; x=1741955117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDU3rB3lwTDhzbpDMnrAAgHgs/LQWtd52vWgHpI2VSI=;
        b=VyPhABjV1meyeDAIqPK39YjTarrvWW3UFXvMXtv4u3N6atNfNUYzyz9RUbVsIYpc02
         ZNa87B9Y1/S6t2THp9RLCWex3nfMhqRh2NHgjD862QtiFFYB6yaZ6vmsw0B7gsp5hAFV
         y7rTtq7TOStRXW5Fm4E5kR3lXWM1OH0r5U4DLgLL6nGVy4Z7eGruclAi1gQdEvtfOvjj
         qk7M6lkt7b2PMDlS0Q1l6qSKg8FvPJC3oJf3Gx733QPb/YbPJqWqzFvWln+7HVRz9k8Y
         ajuosMAaiU5Co3J/YhSL85QhUKNNibBmsy/BvvPDzX+j6LkT1emibAWMPNSLJLllpJTs
         7dag==
X-Gm-Message-State: AOJu0YwvX6kEHw6GAwjO5uO6/aLUiNFhfjFtaMMF+m98BR2SDwUmwV6J
	coKUq6ZeJWDzqkECXi9B02Prx1nor0rmErZTmyDZCyKFjZ8ok68qstzmQ4sFIeQNnNmgEjBRWzV
	Vr0Ta9j0/S6OhGQz/XD1moIfl5Dr7Tt+MVm4Ihg==
X-Gm-Gg: ASbGncvtIWg6U/GQyYM678R+xe5EXXWbf78JoWnYY8rDplzAsMsNN+Io0DxLti2rP1G
	vbMWp5HygJsDkxgFXZmi8TeBgcHfj3ERhSDHSvt1KwBSynd9pJCV6KWykbGPfWFW+p5KDbfa6Id
	ujuaeeahyGqZZl+IdN8JavI3hFfg==
X-Google-Smtp-Source: AGHT+IGIGXETSpV0breS5/h5u0O7Kue3nNAf0M2JvAyRjW//VoTRE04GF88gdeHWev8c3/TxvH+ghyGuEq0/lEZFOuk=
X-Received: by 2002:a17:90b:3ecb:b0:2fe:6942:370e with SMTP id
 98e67ed59e1d1-2ff7ce70a09mr5339946a91.7.1741350316997; Fri, 07 Mar 2025
 04:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151416.469067667@linuxfoundation.org>
In-Reply-To: <20250306151416.469067667@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 7 Mar 2025 21:25:00 +0900
X-Gm-Features: AQ5f1JrjYvBGN-wb9TdEeE7hFb2s31KStFO0Mmp9jf2eKZUcyW3LZfYCdYbFDbc
Message-ID: <CAKL4bV623WMkm3dXFKhd-84yVDCCxxCJK9g_zAE6_ign9=2m4g@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/154] 6.13.6-rc2 review
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

On Fri, Mar 7, 2025 at 12:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.6-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.6-rc2rv-g3244959bfa6b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Mar  7 20:34:19 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

