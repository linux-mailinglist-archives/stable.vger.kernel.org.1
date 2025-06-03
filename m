Return-Path: <stable+bounces-150700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A81DACC59C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D3518921C7
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED8122CBFE;
	Tue,  3 Jun 2025 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="Rd3Itndm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069ED22F762
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950839; cv=none; b=oSUMAY4jbzoSbWADM3o7mqEO8CO7zFy/kRJ9HcxARHta7O7gJvX7efDafKlSL0W3g4yIqP2Z0jZWjKJ4ClgCm5aCtwAB6xtthOc2IBFFS+Ht5izxSrYc8ZaXieZZT7W8G4AjRaHpAfB0qrXWqETQKJ6hUVmWy3GIHMVOUx5xwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950839; c=relaxed/simple;
	bh=ydJW/LoDzPRJt3Rv04zweiPDrb2AloHSlubJhACP+CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VII1FOGdYXVduGMy+NUatAoN+2MuIOm+4cwRO3N1MzyYtDtShJyreMK+fQFZ/jg3g9JVQOw+CFlHupP9SCZ6CQgXOA8DipVjKMma8qxvi0r409XRLlP2NfQLeV6Pg7jW1Tj/VVykkq34zz4dYYmemcYUCiMudbCNQIONluHhiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=Rd3Itndm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so4672721a91.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1748950837; x=1749555637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icZx/2AfzMBw1r6SeRjsuN5YEn+p0qUPm4S9o6uO9EY=;
        b=Rd3ItndmFROTSBm7zOmjGxFFHUzsOBgmWOUXidN7o/d/BJ/xZ9iGrriUJAn/kfFtgp
         O04qhz5EkzjTfacc8HDZTa5GjleOmlTcoK7Ui2TjRJbKYP81suMsGZ25wQu8YYn2qb+v
         vTv/N7gPTUd6dMkHuUVso+LeS35fV7qWhCVuAgvNa48pptaeuQP0lST0RJpJVERRobpb
         xO5qpLEPZRuhswu3+RDWEpQTZvLoTOkgT6bLx3XacaXWBds9pL6ZwVLDDx5Y44JJA7+m
         hWhtEWCxrH5ymUXVN7nhCJsPr4rYweO/VCyXFyH4qxqy/piSIRgO+C+yf/F1z1j6QWT7
         3wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748950837; x=1749555637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icZx/2AfzMBw1r6SeRjsuN5YEn+p0qUPm4S9o6uO9EY=;
        b=FX2LroL+hqz/aLTP7cmlDjbKPkOrOqATuX2gCY9Pxmnn9kDK6h74+rYqGDpg9WmxKv
         BqnUdyMzecyCVV9HIG4vpGdRPrNr4T/q4PPsXq2SoRJpAHABG4Q0zZh19cc8ncspITOg
         439H/DmUSG4jOVU1DMaRqLpYdEj1X8K10faB8RLq43jNpmB2HqRqSm5Ydz7z1UOfNEeW
         fRvoPsiX2OVvLhJd0Bz2fNVmBXQ7V3h6AU/ffTVYzodyj8+6jzWWBTMy4GIbJIL5dNAS
         oJohEA2Rj1SixCeQjX6F9q/4OF+xzTSv5c3WvtFglQ2tZLv+vQ6quMtzgeRleZPXV5MV
         zgLA==
X-Gm-Message-State: AOJu0YzCFz0DVbbA43J335S2NY072wYYDeI2OnQHwc/bDSbL3ceuej1z
	i11NLfMcbWFqdaF1ZT+rnWxWaqHuiGKqH9w+h4oZ8nqITwuTu+e0vNByhDYpbzjyspPjFa7nLfc
	cG59Z6pqhMNnB8/Zi75LpdIPtRd5YDkLqYX9srBX7ag==
X-Gm-Gg: ASbGncvcd8NHIq5cT6pRfcgrXafA2nX71n949FabzAYyUXSH59++sVcvHW0/XTiXxAi
	PkaM3+U7zffujzTrh3DICrCuJfzzd02tTnkcBSbkjT77DkjxShDel/rZiKKKL52c1nTsz/zTVNl
	tH5dQw+n4OCGpFltHAjd3qG4nYJV+XH1qk
X-Google-Smtp-Source: AGHT+IF0haHNNQFhqF/wVyOzL7nQAg6E/2DprECkNGJEFD7A3Ta3cIiSJF2MKzFfFrOObGQ4hE+8hgwD+Eg8ExjuydM=
X-Received: by 2002:a17:90a:d650:b0:311:f99e:7f57 with SMTP id
 98e67ed59e1d1-3127c72e6aamr14719693a91.23.1748950837161; Tue, 03 Jun 2025
 04:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134237.940995114@linuxfoundation.org>
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 3 Jun 2025 20:40:20 +0900
X-Gm-Features: AX0GCFsMfxUVTqS0QyB76gobjArUIvPeTmaHwVNP3N04POsePCAEXrHz1EuTjsw
Message-ID: <CAKL4bV6Jb64fXnYWZ_wP54FE2TRUy7Bp=Tzt+1tmUOzjbnghCQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
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

On Mon, Jun 2, 2025 at 10:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.1-rc1rv-g86677b94d603
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Tue Jun  3 20:09:59 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

