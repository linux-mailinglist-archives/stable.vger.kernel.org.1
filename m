Return-Path: <stable+bounces-145771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E513ABED8C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FC33BC4B8
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B87236457;
	Wed, 21 May 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="fEtTnU/7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A2235BFB
	for <stable@vger.kernel.org>; Wed, 21 May 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814801; cv=none; b=UIZ7d4bDKOPionBkN0uCwdglC/H368Zt+D98+qmc0XY4Z9nlOEMXAksQXcbSARS2LB1Eo6ImUkOYX+vPZJHoTBxYZ4oRCygNFDbaaIIcM6C9/4UlH7JcWtQKolDnwzCrImErQ37lgo5XOo6ZPFuCX2E6vGwLquCPz5rYxepAhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814801; c=relaxed/simple;
	bh=vZqa7QqgtnSp55HuRvtuDX+8vOfAactf7efmJjZGr04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j050j55rmO2fUdyz2Ewh0bwbrdhuFmwERkc3vc4WFyVBEL4Jw477vRU995d1M9IptwXwgngf6UGgJqnoWKvNsgbMnChOV14eH6PVT1pFSGJcncL/hCTVDI91Ea8rMwlk1VT6P+gMfCcslcHkjDFadoVnIijnnhJkB1f69oMBLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=fEtTnU/7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so4904417a12.0
        for <stable@vger.kernel.org>; Wed, 21 May 2025 01:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1747814799; x=1748419599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pdXlyN7IyvbDBMyrxaqm4MW5jGasMnJapEHCIL2mBk=;
        b=fEtTnU/7VjidV8wKgo1Sxls6m26yc0gQSxCGw3Kl3oQnaU7X+ZPlQsoV2bj7f+dNtG
         RhRXLy25stYuhnrhZxmqWdxkHQiA6U4JANbWuAwwf9zLpOxqC/Nj9EBUbkNTDu1AuY+n
         Y6uO62uXgjGyyu+NOXvDvoK1AZFiHF1ssh0gUSiV92HjmA8r1J767ntHE992z3l/8oF8
         bZq9bePiNZEYzSTaUkWfI2XCYhEtveVRRQFXks0gss8bzau1AQhsSvA8D44dD7/82WF6
         8MV+8jy/9uNMP5hqMLQIZgOvwGu2LBAG2/+3gK+izbZqA4sHMbrMW4D003Luaa5XlnbM
         6Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747814799; x=1748419599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pdXlyN7IyvbDBMyrxaqm4MW5jGasMnJapEHCIL2mBk=;
        b=X6ytlENkTwRCOSatgJIk1CokcBju31aAVAcevt2RFw+dkfkUCE3i4Qn69skd0d7r+/
         JT7lG6wowyb1wpHvhGQENV7crP7DWqXwWFEWZb49mQyvn2SWieY+URU55/RQCgFzyn1X
         s/RispiuM3bvpKUI/o/YaIGOfGQWXhersZdNd4/+rHuOqaEgDC8lJRVwKqhGhX9ivW/r
         aGtH8UAtVlyV/PL7cnRpfw7c+lR6R8SDMg6jO2UmLHvGHMFxKbUTeGe66ctEvx0oOEKL
         IMURRuvZ+G5Vx/3x3AKcc9wHLX+Tb6XX1ZclVSRz0ujKJ2vk7mYfwvjPsus2HlT7cEfM
         5Jyw==
X-Gm-Message-State: AOJu0YwgtqrTt+t/+e7oz2fZN350l1WLDRfJq2Z2TpH1/uBD893Ef6dz
	Poa8j22my1V8pfCty8dxPNU1MW5J5rbmQprde7prSlcPYbMCaCrA3/5+Dn/ya7F6oezGPNxN/PZ
	mOHbJ8nxX9dOnsx9u+8Wx37widJUfXn4YzkPD0FXQpA==
X-Gm-Gg: ASbGnctLyLMymwb4FLP3FUEjaVlueOjAK0yrqmGFEcTgrsuOHrdPhdXSWen1Q66a9xA
	fcmC/NHc+1je0EqaGGzj4TxOe/3GwZ9TG2BRynPR7UkBQOGMOE5JqFpbaDtReaigToTBy9NR6aM
	YYytC8vIX9XgwNmrlmY8GVQgMEY5qiGEmi
X-Google-Smtp-Source: AGHT+IH8DuEEvWdJYePRJFj9EsmVuI3c/VF6QNMD7FNOGA9tqxrDD1VHeHav+B3+xGsZ7taklXBLW/jmBwwiWEj+LHI=
X-Received: by 2002:a17:902:e54c:b0:224:216e:3342 with SMTP id
 d9443c01a7336-231d45ab600mr292557845ad.43.1747814799030; Wed, 21 May 2025
 01:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520125810.535475500@linuxfoundation.org>
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 21 May 2025 17:06:22 +0900
X-Gm-Features: AX0GCFuegfYXgvNDF5A7pd3344VsOpt3BHbZs1QL3qKaXeOd37d7EocBJK-bb9Y
Message-ID: <CAKL4bV4vnUVisBk1OZtJU7LF6h3RzKsTrTkY1pPfExJymC3x6A@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/145] 6.14.8-rc1 review
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

On Tue, May 20, 2025 at 11:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.8 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.8-rc1rv-g75456e272f58
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Wed May 21 14:31:31 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

