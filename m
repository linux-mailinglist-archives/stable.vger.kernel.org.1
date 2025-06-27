Return-Path: <stable+bounces-158758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08948AEB31B
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446156056C
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F1271464;
	Fri, 27 Jun 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="iQpTZMnt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A20293C6E
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017171; cv=none; b=nBOg1WWRC9yqnLccDRiVMzc6pWTtI3CV8nlQ/mWMbjrExDXgOyd/E+BuO+aMbFHnK90QpOa/+XZq6RtvmTzHS0h9l/Z0seaiypb9QvGVz8/sgjr575fx/7e/nSavxtg98eXPgKkAaakVoyze44ygvh+PeQ0rlJzrqwTFKv1DmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017171; c=relaxed/simple;
	bh=sqHLSnoPdND2n2YqIlO9rU36LPxSklJW5fcjecRMfIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN2+Q96QUxnzVztEpdEtMrEpsOWeDMPYS5CcuFBh2Escfwj2seOUCrq5swV+0YsFjEuvfeiDQNWC2ok/RNJDHlqZAWHQCk/0WqW0PxxrgklzregWXgOiWg6oqHbXsBLsZLXoZsSU73X39v20M2DWuy5LpNfRhutryJUr7mx/S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=iQpTZMnt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31c978688dso1145986a12.1
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 02:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1751017169; x=1751621969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EoXolbAXfPP7jncmJ+OthdgINgb5uiOwXnkRnnjQZQ=;
        b=iQpTZMntS1cfqk91R40wtBZthKh0HYZdXof1ML/IjyPPHjGkpK0m8zr/OgErcECd2H
         Y7oqc5J8KSDO7gcsVXIwICuk2pzqalXutB4zrYB040oRGvNkE48htrA1KLyD/FYVLUXe
         WcrDQa07TC8b0GTNAGFo8NhxQUC7tWy0OGNuzau7A0Lw/VK8qjdJNc5f4PPS8CbpWl3P
         izOtG1P5QUj1f8EmL6hVh+ujtWrkGq47VXX405oYT/V+as9lvx3Oh6F+TVSdUpXl4vFW
         du4MWaM6qnV+/PxXDdI3jw/oQBbJFrFSyZkQsW5qgJAujSJWfqVW6gX0OPo6irV1GO+N
         drKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751017169; x=1751621969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EoXolbAXfPP7jncmJ+OthdgINgb5uiOwXnkRnnjQZQ=;
        b=qZ8vbulWURbMneDGCzPWHr2GSLkpu6F+YzAagao2IxGmKFGsUwW+oZdGS6su3NMhei
         04nxRNv/X6SV0oayXGVCF5kN7opXlMFpgJ9warq6yqOW0br9EDsCoyEMd8rxriqbi4oh
         YIYJcbSEcS49kU/D5NpYDjpkc1pmYCWy+lUIKbvZv+XfBLOZkeTC092wAsSHVRetcr+4
         qr2YpwpnVUTqt8r0LXdarzSaJoSHVcZcO5Ng9RtjHZYC77JtCpJI4dbgUpkyRuD7eEoi
         J2XE8ln0NmwV+mBavN7/wzuSEgFUIO0bmkEEYaeszlRMhG7fYd27QZBB5yoFzdCEIzwh
         7pTw==
X-Gm-Message-State: AOJu0Yye9jGw40pFp9i6bRlhOFo6e179DHw5l68ApwtrlwPSwn0CI8W9
	RsfMJZ53XfrpiL/Y7PYw11CJIrQjjIw3INcQZLIccTAC4gMj08m6ZCQFqwb+m9vx7dyzpxPd7qM
	ixffnqi6Sb/Hz0ZWXWIZEQCN4lFMWTqVXtCwaL1Q+cQ==
X-Gm-Gg: ASbGnctBKbrpSokh9NlV2GaB0CBx0/Bh6J4dGgagDRGymklcqpWWyeFXkqsjLkCbTGf
	Vq29K+t5mR3bgi6wBO1bWZGpiGCN/kRQuJM7wEfB0q7NMTM/5njsRrVvfOIGVUwvQvRe/L2FIi+
	FrXRACYXvfplImoqWqDZ3K0huh2TauWuWgo0pH8EK+ias=
X-Google-Smtp-Source: AGHT+IGP36mzrkCAQx/61O1uVwnGrnhnEFQFaqi7Au+tCZKEUAsLtA9E3QNCQ4g5Lbjr9hqyOV0ruBng7xb3pRA7xMQ=
X-Received: by 2002:a17:90a:f94d:b0:311:c5d9:2c7c with SMTP id
 98e67ed59e1d1-318c9250375mr2738869a91.23.1751017169338; Fri, 27 Jun 2025
 02:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626105243.160967269@linuxfoundation.org>
In-Reply-To: <20250626105243.160967269@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 27 Jun 2025 18:39:13 +0900
X-Gm-Features: Ac12FXzLbc93PcgOHbJI6EISu6a8l58rrpz2xfCSW65gNinqzCCU2fndTSOrQ-Q
Message-ID: <CAKL4bV5mKKAAE2AXWDVLRhzUNiG51Q7jsx0FhKx_GsDJMRGpjQ@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/589] 6.15.4-rc3 review
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

On Thu, Jun 26, 2025 at 7:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 28 Jun 2025 10:51:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.4-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.4-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.4-rc3rv-gd93bc5feded1
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #2 SMP PREEMPT_DYNAMIC Fri Jun 27 11:57:58 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

