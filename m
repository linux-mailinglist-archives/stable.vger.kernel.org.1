Return-Path: <stable+bounces-182932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EABB0479
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B763B451D
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA12E8E0D;
	Wed,  1 Oct 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="CKtFaDZg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8292E8DFE
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320490; cv=none; b=Jl5iUsPQ/+4qVR4wvOab+4JF74yxGcY8ojwq0xDRoICfd7YUnzeNdZ3dkWy3A0g//GRGEfNV29HAMyKjZ1CQv61MmqZw5jX7mBzL2VxA//k07SXEN4yGeKQdfYW8JNbWaoAWIkkyZ8JVWJDJyk8qyeaZCRpNKhRu1ti18MxVZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320490; c=relaxed/simple;
	bh=csMzOkqhqq0NPGbJ1AMy9xSJB/pQW18xDTmUjopzve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxn23vCBHtBRKTddp+MkA3DvQLijjzTZh7bTjwMlp50BmHYcGx8MMhAZZqs27UKOvE8o0GYNHU2KRcQWwpgystwTW3JQYphNjIESUS8zy/wtwo3u1ocbQdhGKINKD74p9cjqe/dEU7uwaNJZQ3gopdQFVzdTK1CRA6fb+RECp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=CKtFaDZg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28832ad6f64so42968445ad.1
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1759320488; x=1759925288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBoe7Syk3GxvADKCt3WjIA+BL5jslyqexantunfoqDA=;
        b=CKtFaDZgbHRHQZOCNDTQ7pdMHFT5COGtFNzGVlBCH9lJ68dRYGMMP0ILRUwWSinkVo
         r4ZFA0BOKajDmJduFxgifWIp7dOZY22yiHpHr3t+m/UUI0jeu1Xw01iuIYRk/aLjs3eu
         B+Pm4m3MeXgTbk6Lr7+1uNbl1FsKY48L/O3XHRn28Tzx7colOuDZiIQOyFjeY83qKoZ+
         zomLtiLF3FqmfoRh+8jg8cpwN9ytNde4r/h3gx5cHsViluUG0OYclYHqqgpSnX6v/D21
         jF7uB4t1lKJR0WPHhiQS+X1u5y0R2q15HmQzzyatAHTcUPtdtumFMImQY3NEiH4It2A1
         sBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320488; x=1759925288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBoe7Syk3GxvADKCt3WjIA+BL5jslyqexantunfoqDA=;
        b=kchnLln5/PMJAb5Rm2WobREpABZziKDIHT002RzTvfS2FdXk1Y5n0bLnP42/A3Hcv8
         GOt5hPnrgkns8mAPJWX0k201gzzKOYzD6H7c3Y5wfLPJaAwznXwhxaecWNA4QwlYc8p/
         niaFfn1G8+VJfv6pfeL/myfpt3uAJUeGLfXFzNEEnRzsTFs/CjsSjA+X7mS2hB7sFfsi
         QNpFK/558DdufSVC++CKdVQ8o2VwfYX6e1eFW0dX5N917ULcmqpc03YFGdPz36dV5E9p
         c0iFDkJf1MG6sWR5svweMLOsdhliuAxOT0LcoXRxpYJwVpVPMe5I9Gr/PNhVUu7m8UIs
         DGbw==
X-Gm-Message-State: AOJu0YyTNz3kZBhh5bWFXofOaVLsxqnkkUvHEAbbujWsZmT6+mtJlEQD
	tmQ/nQvA7i2DqqPeHZtAJ4rQ0GWtrcohZ1HXQXk+aaHK0ctno+6SldcP+usyuYUR94BJ3PnW719
	NvI8JmBS6wki5lmrd/IlJVWMTnhCQk5B6deaRQdETRw==
X-Gm-Gg: ASbGnct+VLgPcc6+hbVElUyLuILDjoP+W4L5hYOfu3fC8kwV++asJLjw27/FETHGium
	g9Jg2Ggai9c40s+jzMNhmLHNT0jnUEcXVnUr1p34hLtm+lAVLWg4CPNT9WCj7D0qPlxtqVVYX5g
	eC4zOv102HmEW81ubutZK83KnxE8Btj4wWCCtlDlMUZOU1kQpI2pu4zFjJJcw5P/NSqDIwPyLiM
	gmR6FTBDbcqvpdOXNOuaVls8FneFvI=
X-Google-Smtp-Source: AGHT+IGkPZJTB8z3YoAexgiC7CsgHER9u++uyAlZFkQM8dP//udEvGRt/+iF4QEmHB9QwVCUV1hh0lfdrjEX30b/qN4=
X-Received: by 2002:a17:902:cecf:b0:264:f714:8dce with SMTP id
 d9443c01a7336-28e7f32ffcamr46563735ad.36.1759320487851; Wed, 01 Oct 2025
 05:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143831.236060637@linuxfoundation.org>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 1 Oct 2025 21:07:50 +0900
X-Gm-Features: AS18NWC1OTooJzZIFpum2zpAjYDZsdXN6RoJ1TZRIvF1fudfKrE19_yzu_OSpNY
Message-ID: <CAKL4bV5d8nSDD+PdAC-SB-fu=FVu9BDsYDM8irwkWnEVrTUQfA@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
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

On Wed, Oct 1, 2025 at 12:02=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.10-rc1rv-ge1acc616e91a
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Oct  1 20:37:04 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

