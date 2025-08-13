Return-Path: <stable+bounces-169389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA30B24A5D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DFA3B4A39
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2562E717F;
	Wed, 13 Aug 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="S6G+uz4j"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E8185B67
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090758; cv=none; b=q7WXaCvdc72Up5+SWq3MszR3jsV1miDd1bEWsOooz3+10N0nivgcbX90LrUrPbHh+hChOktcz3BuJFOxbcmzN9LJeLcNEmXCuFkyy4B36s3dF8/FDbYcxWdAyIloSXsCNuRIy9Qr7L/Y5Pe8Q8NEZvq419BTOiOR3+rDYKDFyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090758; c=relaxed/simple;
	bh=GgUzu6LME52TpeiHWzbrdSV93Ja1LmmwWYtxTAV0V6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI3KJ2YiMjY/VPzd/MJiC4uAOIbNnJhvZmLLSDMt0gUPH7L/okCPbl4rSZyURfdYutsZdkt1wQGQdLktDVRLl/tzSqca4rs04UpoEzjCqc/UkrpwqL6yxWRphBp7OfMrRz8RUEOm9aWAwBSAwGe43e0LdVBCIYufCi4beuEUz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=S6G+uz4j; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e835e02d96so455269585a.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1755090755; x=1755695555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtU72p9c0fOalcp8RP9DRRIkwqBXfYTQn42C9LNbTEE=;
        b=S6G+uz4jYb3MjRBJvjzapqoHEdhXk8RDJLFLV2fyffZEpHcpdyAK4Co7vnopfLovXN
         zH/cBJRTsbFv19iCA3aLUHetQ2tXKW1f7q4GVqkXurPNAn49CCvTM1zgSdLv9m1r3ZZC
         fDxhPrjKM4FbLlq5m+G7aSnhGLhBoKHh6JYKTehyfq7q3Pc/w2PcKvw7mojulZF3Z1hM
         3b0FGQu23lnZUTNaxF7nPELrkdJzqIEPD/tdt0onS5ES9Im6hpr+/kAUN0hQraTLiD90
         pT7vOeZ+Lgp82w0G4lBSRCI6NzJb/9S9Tc36PdF2WfzADU65xWfGC50quBBV9YKggnRU
         yhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090755; x=1755695555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtU72p9c0fOalcp8RP9DRRIkwqBXfYTQn42C9LNbTEE=;
        b=CxknBC51iFB+NC7E8boE5xtY6iT62LfztlNSUjEG/6EO1ulU+NJjm+OroRTvpkNomM
         w5IO4qdeoeWdUncIk3qKSlqDfDjj0VvUG/xJwrKromuF6aQIYQP0MHCAe/GhsVMzLK5X
         gFQT6lsvr1obIRpE6TFxFbxHd1Cv2EJxg2NXCLsLPpaXIRi2FCk4E660NvMW0+Tji+gF
         f+8e67amgQnK897S3SHekySh8KeJ1eXbhNYzPJjvBak1s7f+JibjDbKwVsB1bMzuqbAs
         HwlBVXB8HHCiIsdGOhWCaywEF5nTKwouPHgoGCNL9aowdU4bMIjWXbaTjT/pAFtrQ0gm
         7TSQ==
X-Gm-Message-State: AOJu0Yzs+sQ3BRKK3UDyt7tCTosM4fvo0Pw17JEgJSVrs4/4Fq5O036R
	ZV/8gRdZdYaoEWzWX1KcHz27E9PhPB4+kA3BW3mFjPcMV66hAK61bBMPPBkDNSiiMTCT7CsrUeM
	4ChunU+5Gz60fKZtF4MwCB0yA6rDF/Baj46V8WFQurw==
X-Gm-Gg: ASbGncvTeFcZtICeezjMA9ZGINzjexOfBDApAA04R0XbD/5P7rJu6kXz8Z3JcravFV8
	Kb5FbCU5z68xkkNpk4nbSRvlTEO2Pd//c/NRY1UwcFnCDas8JkXRGVevJMpMZQm92/V58mbKfI2
	dD/TyeF7k9j1gWin1tTf9Fjaw9moavFuGKjJADSiBf3qLQ3tCirRPxhAc+iv2G1N+hD4EJVJoke
	CI/cuK+
X-Google-Smtp-Source: AGHT+IG5QZZnM8BOlOZuuRDsxed9T4NNSIcdVy3asdv+WEHOb8IbJxfeZVezY2LY6qu6NbPDuHh/ZISvs4Hz6d9Xaoc=
X-Received: by 2002:a05:620a:5613:b0:7e8:39da:9735 with SMTP id
 af79cd13be357-7e86524c86cmr343807085a.14.1755090755377; Wed, 13 Aug 2025
 06:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173014.736537091@linuxfoundation.org>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 13 Aug 2025 09:12:23 -0400
X-Gm-Features: Ac12FXxImiV90KDqFEsliS51c-s2jeKLqGC0XUvACkuiyfMmFUbXrGmqeZOS8OI
Message-ID: <CAOBMUvjaYR2b3grBiXntb16ny_8RqVVH6NGJnjEYUFU=TmDqVQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
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

On Tue, Aug 12, 2025 at 2:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.42-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

