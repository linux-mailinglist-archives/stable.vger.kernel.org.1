Return-Path: <stable+bounces-197563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C428C91220
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF5DD345D83
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609DD823DD;
	Fri, 28 Nov 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNXFJ2+G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC01F94A
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318166; cv=none; b=qQv4yfL9gBv5SR7Mc6+8W4eWBRzNeTk+3ET81gctWmRay9gV2ykKntqsG2UuEBcc/k5uw/+lY0IhF37bGeZlj5JcjlOBTd9y89uQiVpF+gpA+cma5PDrIiyrJq7C/b5JhGNIMECwHxU5JMRMupn6OaYZuiQK3BYtctpg3W6h9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318166; c=relaxed/simple;
	bh=7oOJGGhMrog+ToQ8/FvfvQvGeOOCMZ+IneBzQFWOz6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOBihLgtgA/lUwFFtAWKttSlp9uY+22BJCpbG+4Y0Y5ETsMkJs0DKDSMtJwsQBdvTF6ijVUWxzSCwwgaKSWy+1D+n39APcN6v44x2/6K5W0Cv7Dd1xdjObbTLNqNF/1N/Vv01LNkBbZaKovxRckgEsVEhooEBPaZOSdig3+Y6nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNXFJ2+G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so1515354e87.2
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 00:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318163; x=1764922963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHCeuj8gB2CuW6wprwhSKdOXpBDmYx45db33xCoSj/w=;
        b=bNXFJ2+GRis3iqyN5uHxkEr+ekeybE8pHna2iQ1chs/ySI94LmmgWx608PUPD/VNvl
         HhRIXRyUP1ulvb9eol41YO1U3aStiNiTV0WJF4n4v105FlFAhPbOz4pjI0B0j+hlQvCa
         /UdUB8+GgOTxCuIFKdnFzvtF2fIbgMRy937BBtNzIFUOzDCvZ4vputjPtBFknamjI/a0
         cSqhyjP6LeVMJTWp7fIjt5FH7XM8+VcRpMNIzXaXTS6reRyalSfRYxjsQLSMcI26l8z2
         MSV4WZV1/NIZNSBoW+dCMuVrWqi3dmadr7QvvB9jf02oqmzDmUrlDVrwcz/kFK/aAjoL
         hyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318163; x=1764922963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHCeuj8gB2CuW6wprwhSKdOXpBDmYx45db33xCoSj/w=;
        b=DIcPGYWR/udSyDY5D103cRUcIaPWI85Z6pY9/tUOczB8eOg+CiCfqANblYm34hfYa0
         /yrxuvurosSCZZmNnwAPez0VGbPvQ4abYkqjbw4PzJNx86LDPSRSISFZOmukNaCeHAlD
         d48/a1PChSCAcjss4De4W1PRM23akRpwmtAGsoHZ3vm+0MOsnYzpdNhYfqg6rbIF/XMk
         +fmnje8FS67G8nthH5Lm0YH1iY0d2BYwMv4aaKcbQM91mfV2ydOKh0SQHfG9AA0ZpKtd
         1guWbQhhMr+joJbFNyCnNGF21AVSNa1NBNwgj5AA96PYxQ0Gp1eNx/wkG3Rf7+cpjJnO
         s7Hg==
X-Gm-Message-State: AOJu0YyFtkibne8P0W2C4ao2OA5RD+K8BA5y8OgxsaFelHw1LFork0PC
	PB6XVkoygX4yLpqtTuw+KNeSO1BtmHmJgHOoexsMcR1MRN3WImEt1LZaECpxuj5x0AfT325ooxO
	0tuNm6jDwnuadMOcu6m11vKRoCMaFAoY=
X-Gm-Gg: ASbGnct+y4myYSVvVjZcqWFdR1LRnhvClc1fovlNVB1La1lFO6S4CFBPPp+Z6JL2o7g
	BSBUf3lXJEA2PS2Iri/3066nKOemzjBnKjh7HNlks5mLAz6UtApWxHYtjpnhv+SR42RqOQC3V+m
	Bs3fbbum0Ra4PPaTetQt8girjTWf/KicLtx9Ghmg15TzX/d3fHgznLtm4kI2PVrwueblGTc4G0H
	mJhsSFIpm/hPycqHgiMHs77JLTgXW14Y2zydMZp48VIKUnYDWD7l6MG2tleR9oyYBbPD46OquzB
	S4auNtSvQa+5csIS1GjXd4ofl0g=
X-Google-Smtp-Source: AGHT+IEE0Ltog1BqZAp6EBgcX2H5jbG0BwiSehNgXi7ObjiEkhdk1nthjYej3asc2kjkPYi+ttWpAPwjSZUDybQpYhI=
X-Received: by 2002:a05:6512:104f:b0:594:35b7:aa7 with SMTP id
 2adb3069b0e04-596a3ee53cfmr9323339e87.48.1764318162632; Fri, 28 Nov 2025
 00:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150348.216197881@linuxfoundation.org>
In-Reply-To: <20251127150348.216197881@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 28 Nov 2025 13:52:31 +0530
X-Gm-Features: AWmQ_bkJLsxwXDpSbB7s18HNg16Pz3k5EoQWRGjiTBwxrQHtrf5TCwhI-g3Cd9w
Message-ID: <CAC-m1rrQKJPKs_TvpPjbYXkHDet_Gnzw8awNHdWWRLDfq9fiiQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/176] 6.17.10-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.10 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Nov 2025 15:03:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and Boot Report for 6.17.10-rc2

The kernel version 6.17.10 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.10
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 6c8c6a34f51808e7b3dedc4227e8bd060559a0e2

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

