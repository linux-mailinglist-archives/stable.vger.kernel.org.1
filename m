Return-Path: <stable+bounces-147957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12120AC69EF
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D575B17A0DC
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C22136347;
	Wed, 28 May 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="hh3VhMnG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63D2AF1D
	for <stable@vger.kernel.org>; Wed, 28 May 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437300; cv=none; b=Wisp9PlhZiB7Sjb+a4BDg38rfoSuwUa6c3l6qCbooL72FqFuPT6zXmLXHbxrxFwK5URKcIIBYf9VmFT8XhSQGMtpFK9Wi2DJK9zm5c3rJYhpgWXCMdqxUpJDhE9jgWgaYvvGxf+fe9Gj4lF8SefjnMdDXtB5GoFzxl34G4+BHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437300; c=relaxed/simple;
	bh=IDUpsfHZ2AH+U1rKwA/IQTqNl27rntnPiEG0JxCqPMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttN8kPNh1odOCtnTH4yTnSHR6E1vWuMZCvgzZ/peyMu0dZ6+KlxDhGm6P+qLS8YZDTGc/jUPQOqgK7eCW1auAnYeh2BBePhNg9tBlYSGcxAsZWqByyMB6/YDJHycs+ZjN3ONYeMqH3J9hrRg30blHBBpu+H8i82AWiWEhwMLBjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=hh3VhMnG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-477296dce8dso40186171cf.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1748437298; x=1749042098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdTBfL4v5yjVyTe4ji2bqNzULXH9IrkaNLBy8k+ftBw=;
        b=hh3VhMnGPlCTz1gzMd370EtwUETu+YexgFvsP0VXAQ4X9miH/5WohfEb4iyWuRsEOV
         89MEqHYyydywQbr0ds2YxGWoE/npFBP4Qlcfsa8WdvUYWay2YkBhALEV6qabzXnytrQn
         seXAKNiYQl1IDbGmIFaGnjnTxqGXsBDM38QvSERAOMXKxd1Xm22XXTsKTkHNbwyWZ7E9
         WZvFCY3zBlgwXAWIMz38lXi8xyBhCGgFRLBbzTBVaTVNxRPNiDGy597OZzQuGFFdLJ/X
         0LquhmP7l+9WVnrs6JJ8i0c9zzS5olgOwn4LkUB/taXglTllVgS0u0E5V0ldC5AYiA33
         z/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437298; x=1749042098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdTBfL4v5yjVyTe4ji2bqNzULXH9IrkaNLBy8k+ftBw=;
        b=aMv2l315ZbLegYLIOWClqUsBQPMgcA/2ye4KH7GrTF52HUwei/NQvu10RZMDKTK42R
         pu12eCWkJbBUs6M4j6NdtJfs7c+JVG6U8gR42KqsT8g68s0KPwyNNnQzlXLc6JJpTYpZ
         LI3Zj+P8E1FkJyD83PvCXuIwHFRJPDwA+tcD9TPO4F14oZY3eWvvibKbHIp6zqM564Ls
         IN3njOaFyqBMCynoOTYiHesu3eWZB9kBfXPP9iMLj6e+rhoPKRIGQfVhoLaaSXvl8jas
         XTPdX/gJaFkPifyp5W0AGlsGhOHs1IzbDl0kKk9WIBt5B/7CgR924PIdNfbloCaBIEEZ
         gmzw==
X-Gm-Message-State: AOJu0YwOU66XqIfcYRB99z6NtTXuvaI6Qe08Z1ncFRqVB+9Vx8wZ/hJd
	jR54G985RP2Fjk49UkR7bI+3aSXMZ2tosgHkCKmkBMqjKp829zg8Ey2B6OcVqTq1TKkHcWYds/W
	sr3eojkjIclLKnvECRGTEHtdzgpvjdaqm/ysrIY7nKQ==
X-Gm-Gg: ASbGncsf/m/+4WavPc5DFL9cmSSWyYDpd28pZUQ4jl5T0UmQ4zAPCkd2ZPSvhqP0ZZW
	KP9FCgQ7XIme0l19gSG5Fl2AO1bAJjaORpXqpB9eOz5Gq1aH1YbFCg65LpYtU0fZnE0OCfjkiLE
	bYOVuwDDwaXCJ75DLj4CBuj+fBXaAyYBF3
X-Google-Smtp-Source: AGHT+IFU9HRd8Z2NHXDUti6Rzo2QxfPYr9ibpOVOYfcSdksMHy6ckLo7YTZaTUCa9+aafWQRbLsvRBJms4rHDxY/5NA=
X-Received: by 2002:a05:622a:1146:b0:494:a099:daee with SMTP id
 d75a77b69052e-4a3800e6784mr35251551cf.19.1748437297821; Wed, 28 May 2025
 06:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527162445.028718347@linuxfoundation.org>
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 28 May 2025 09:01:26 -0400
X-Gm-Features: AX0GCFsWHcrqN1_NeXTzUkCpGXT3fVMnMV6OhgqOX67GdQ4WyBq7Uin5PrObcX4
Message-ID: <CAOBMUvgRZmc=Q-dCS7X=9QzFgUHzgkXkqAtNcncLZUi+Fu0Zxg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
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

On Tue, May 27, 2025 at 12:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

