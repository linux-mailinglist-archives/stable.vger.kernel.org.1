Return-Path: <stable+bounces-164360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC3B0E900
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 05:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0D1C27E4C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 03:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B622F77F;
	Wed, 23 Jul 2025 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="vkSOBmOG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173741F4628
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240697; cv=none; b=JxDWt47Tg3dDwyuLTJwpW8Dg2MkGCG/n3iDfdk9MqOpgKhevdrP7cp7jLm3ptlcDOUlg8l6rDRF5JegLwUegSuABuqlt3FDejzzdo5sJkY/id6qTOUOsQRg5AcieOwW+3CtURJRqjVDY5LWY3hmVT1DevZdJb6ow8jJxZjcOns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240697; c=relaxed/simple;
	bh=Jj1nHlTCLCXZrelEKaT80nPdzgo7kuaJ+T2W2YJp/Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxLdDFOjVLdBuaZar1wfIrder8Y9Fkpq0QVbtrUVxYiwlYDD/RoblaAFabxO73LJXlM37qC8Me4iTZvtOfk0b0VzZICLh+/qTmiQ9bpBWn9MSIQ+U7NmR9BewinQin/sJZMKstW9fOGFzpe832DTTUfWe0RWMMTGF6gBf+1qSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=vkSOBmOG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3226307787so4851507a12.1
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1753240694; x=1753845494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAXZxXro2VcJVTfJJWOX/tT5LapatOe/C5I7V0PTlzg=;
        b=vkSOBmOG1rahudLyDFSNkti21HdSdK+1ni39xGg8WPbl7yfr28iauCzOTtl5kOPlzO
         EjkkoUHTD2ksCX45YcppfdsOgfgl4sIgoXwzv/IASapvF3qPh6zoXTkwqnTRdMBkIO6h
         c9qIafGugnkKtR1oPxXJP/oy8H2KkQWeAsO3y6X0WGxh671nJkoS+IAQOLYEo6XNV2jd
         Xjgt//KE0/p1aUiBTRhRi//HawuUnWeP6ZspCMilJ7X31VMICtcE7QyXcOwrZ7b9Oi88
         Vqa1LcNE8lEU0sm4vpAVGz5jiiQPa5UIEevkWVFAVnq54/riOIGblJL6n2Fqbc7sfDMN
         ve1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753240694; x=1753845494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAXZxXro2VcJVTfJJWOX/tT5LapatOe/C5I7V0PTlzg=;
        b=NqDMpWr/YKW9/6jg6hzmqfhTLuu1DwRyiZbhOzmC8AcfwiB5i3nr5+I3yfxyu9odgi
         ScBox3vEdBgIo8u6LCI1IC7EzHZo0rS8Kj/J4FXfC585DhzkOygZaIP5/Vwf1V5BLapo
         Bd4HCYpwAdkJyYdxNtpHY+Hdy8JresRjC0icveibJ+kXt+uffC0tTYI5MecRi1fKIoT3
         uFmWWSpLUdT9JpDGUcpnGYNHIuCJWZNtI4EXVfQfa2aovdzESLtPAvM+6UyrDsd7FWcw
         utCouM1lIVZU5JVEKwX0l/s+3aaczJG2fdrpA+39x6T35FWcwQVPmdPEfNN/3fZGmT+4
         RreA==
X-Gm-Message-State: AOJu0YxkxRAjN4dzQZQi5eRLoxh6+N5myrHIukZDukPe29haXsA+8LOR
	f0LON1NKMyMx6M3uPMowBfXwBo7bNfI+5NECjEwHdTYLRhs+9RqPYAu/R3yRJwjlhuLJI8OmXHi
	ksdZ/BQnT5m5YgAWpnbAtp6Em9iSCmFCcqbQNFTsnCg==
X-Gm-Gg: ASbGnctmh6mLxR/erwjkgPVVoAUm0tkuStJBH0DP3xJoXVos1x2e51a5NrXUYhL7t+7
	5uoPH/S1FK5ZouSqGTShAnqoeIcg/HhtDsV2IDn7zHm02Jqv/pKhdIaY4F3OYW9YY8+Oa3VAqvI
	d6wTTKsMmYy9cC+Zl6vNQrNUqxM4SOYkWs3O00YStpDGZe5r7yTUhzXzaQNiXSwD+4SHMqw8r1b
	z5JF9I=
X-Google-Smtp-Source: AGHT+IHJ9ArR+zlC/SPVpA9/p1l6jmOzapJgENHOUMr26UwB+T1uLDYtBqKQ1u4M/Erz0yDMixnnER7Oae495KILO/U=
X-Received: by 2002:a17:90b:3f8f:b0:312:639:a058 with SMTP id
 98e67ed59e1d1-31e5082e792mr2407391a91.27.1753240694279; Tue, 22 Jul 2025
 20:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134345.761035548@linuxfoundation.org>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 23 Jul 2025 12:17:58 +0900
X-Gm-Features: Ac12FXyoO9CqAAyXnvlMvvvGkmvaI8NzV2KaJHA-FgOauwXAyn_6Ibd0WmE6lJE
Message-ID: <CAKL4bV4khO3rU87Zx2khs2b_v5BatHeO09HqP2yYFeS8eKyoMA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
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

On Tue, Jul 22, 2025 at 11:19=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.15.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.8-rc1rv-g81bcc8b99854
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 23 11:14:10 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

