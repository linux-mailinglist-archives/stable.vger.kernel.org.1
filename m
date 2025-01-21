Return-Path: <stable+bounces-110077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6402A18825
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E403A18F1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB41F8912;
	Tue, 21 Jan 2025 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="RxssFxIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96E1F8906
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500756; cv=none; b=QnJGe765Bpf+5UcDNvBUgLyZMUiscWD94ObFhK2gOsW9u500e9+Z19h9bCYhl86qnoT7rbILrxhAmQBb9rRFcfrdjuaGeITQ3SquV3V2aSIH24v2GQNV9mPJGDceWEEHYZyEvz5BX8q++O1h/0uP0PYJz8jmmC68HQVwWXNyP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500756; c=relaxed/simple;
	bh=F43YpV97/2e34lwkgwRzcQwPcwiyx7mnf0CMM3+/Oeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMLAEuOpAIoWEHiRe9KBzuIdaWOsDdvq/i8gDSCBY2M4jAglZnIHVv0Cf9BTBwa0NzLIKUhGDnDaSJITx4giY6gpvXNY5iSx78bLhT0v0HWdbnSchD1QHlZJcHLGYbF6CguYnoSaKiuEwJIEehNNaCiOJeLExDIZNWjquAcddzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=RxssFxIr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso8736879a91.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1737500755; x=1738105555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbc+hOIvCMSLBiq+LSaps9a+lLu/i8zz4uUX9B6mAUs=;
        b=RxssFxIreCave3KCjd7uLcEpovj6m0BN9YrG7XkPVI6jisG1f+idsidNQAG770cMbN
         u+DBq/2v/yNAapHjVnVUn+JeeOWucuJ6GQKKoVnT07dwKQBWWK6ptR2u61xnkjJh2hrR
         rrtaoydqIBL4wsrHvGzwlBnykb0vo5WucMrLkGH1p9I+5rfE/8GKokEyq86utPiS2mw1
         Oz5XOzsskeNpQ68MjK2HFxTl3fQfva5hYAsTcJ/EphvNp/Q8SaogAfH52W/mLjiDi1fe
         /Km5QIO5KdJSnWBB4QOcqWJ5Qdr7+vsKu2Svv8rVUp5CnhUPl+DlC/lsaT0Zai1WG8qB
         fhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737500755; x=1738105555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbc+hOIvCMSLBiq+LSaps9a+lLu/i8zz4uUX9B6mAUs=;
        b=Uy0Dm+BEF5GcMiQ+FuJ5ELgEwBHs+xPbN0VjeMVPIZ83Dkp4mX54BaiFTcqF08PNT9
         3nED2MGWPs01ivuBm7FM934tEE3VYnVbUPfbOdP0Yu+/5gj3+0hFXtxbu674kNslPnmH
         +oCh03vQL5zOykl1Khc24gKbPDsY9vO7CmvefFhdpaI53r1RWMCCIweyK+NXh+UAUN6n
         lVSIf0xDpyTalK9Mf6aiEj17Vu4wAiRmnVeUXQy+F/S4mnDAyeBy/fIIh/rO/xLaPAQY
         BEBJgwUAm7o6AcbaZyFKS18xtIlWal2V0szhOHquJfqLJLHrq329vhShQaJOLQJdOyZX
         nwGw==
X-Gm-Message-State: AOJu0YxA5CU1D4UPQa2Xz9CUF10vdYjgYj6Zbz6nze6CJIIMUD6QfJvj
	jYLrL8lCC9gwaYOBVXHR9eX7UwmcrVICO7FvfPUV8Ahklw/wJMsY2LrYJmh20MYYgziwh/iIbhm
	6WMXcDuzbi346cCSWcsThVwCLhKGOj74KEAR+HQ==
X-Gm-Gg: ASbGncuNygXvpnwXyNsGBAJzi2Pownyk8MvA07/vKoiZRL24bx+VYI2MZI/ZRNPg03I
	aXSrR8qEiHkG1dAp8kPj7G5oh4fC249JzuSiN8hq+SEA1nDvEDWM/1Xi1CaamOQ==
X-Google-Smtp-Source: AGHT+IHkVyzJhhaQnkoo0AJ3z3opglPTYUcs4UNSGyTQPF9cYLQEHNy4jQCtu9Xo+kRPGM/3YECqs1hsiy+Rk+liXg0=
X-Received: by 2002:a17:90b:3a0c:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f782c70168mr27143860a91.8.1737500754764; Tue, 21 Jan 2025
 15:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121174532.991109301@linuxfoundation.org>
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 22 Jan 2025 08:05:43 +0900
X-Gm-Features: AbW1kvYfVZK62JDtxQbJM_cj5GViCl6ulHuCvzA9Y8vq2d1LiNMgoRG34ryGx7I
Message-ID: <CAKL4bV6wb6uVUTQHxAokCp=fR+82_d8gfnRSUokGjACrW5pCxQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
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

On Wed, Jan 22, 2025 at 2:59=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.11-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Wed Jan 22 07:38:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

