Return-Path: <stable+bounces-176399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA11B37102
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFA08E47D8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7D2E1757;
	Tue, 26 Aug 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUOtQCt9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5131A553
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228375; cv=none; b=Vtj9V98dmS20rADkfN8+pcegHYCthZSDOetS59ATEkll9lq3LMrtXIfPIDZFxyIoitzYH2PpROPZVPXCVecVxnNG1ZV1y6ExNhST2D1XnL3D9lxGtGti36jILAYbm14hq1oiYknSJsR6XTK9dE4/U3P26a++BlDrixZVqAVUzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228375; c=relaxed/simple;
	bh=Wl6hEAcjBCw0wkEsxYb8Q2g8em736QyR8FGC2G9x+0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C++7vPqXtcF/gEyl+Ru6fz2zHD8tm/RQn31mN3UzrktpwzmfCmvTZUKif/vyITTyffKzvq9tHgRDsm+NUa83WHbLgHZ0k6jy4mumXMyz1UHPoI+HpzxwC1/XFhRTMONfbxE/1SteXEaM7p3/mMD0DG6F85pVk9ao+3KqHDso8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OUOtQCt9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso844787466b.1
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756228372; x=1756833172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmiQEbEAvOozmFqw9ji6oPoxgyycKFjBNvTezQZX36M=;
        b=OUOtQCt93IXM/pEmE6Rb6RkJb1nN0SSFnyfm/jnr6NM3YxsLZAfKWh214SGVi/EVwV
         9pd+Pm8YhNiqnWyOotw7g18PRysrzgvYogYO0squ336UTVuAbmp/mw26BJMUtRURBfQa
         k8s/qUtVXuiShevh/POIUq+t0KT+mFfc15oN1F1hkzwwPsm+xTpDVUV1+rWILfceLznb
         emcZehjgvNNIJP7KxNS+G8koxwB70k5m9K+jKJmJiuQcWo6TZlkXvTBfZmwiNqsV7u9h
         jeMw9jOBp8z2dPtIEd/50VZyRs3hhhK4EGonwQV8YVY6+H1UtP5Zy8l7Hk0fawRpRxfp
         BqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228372; x=1756833172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmiQEbEAvOozmFqw9ji6oPoxgyycKFjBNvTezQZX36M=;
        b=asRiWdaF0NN3NzybkkjhFnBKI36Zkb7Ps8eJSxDrbK5ML/EwOIBEd4Za3iD2DOWvGV
         iAOHo3WyCnxnXCq3r5hBo1Hk9tixKA08i51laPPuOysBUPtluk+dU8Khkn6BqFK0IjfM
         EeHbg03Z/ArlP+5iRzXBswYjAAXXm6hVrgLNCf61yy5/7fdgFR7FwzUW1BYyDmNsRoV4
         v1TXk3NClFsomyP/T1pkbimaswtlsQqvmJLrSbSltmNjxRQeZ3lxy07aa6KaY4zy9n6A
         OjJ5NkaFWbr0Uvmg7fSJVyVYnsZKtVWC315N7psDN0PeIe7hY7Dh4oUj1HDh4ZwTd1Fq
         tg7A==
X-Forwarded-Encrypted: i=1; AJvYcCVxwombTmTdWCzAx6FYXtV2n2hxQdhBMQWg1cGrBqvW/eIUXh/lg26x3hqN/PvbOUA6uE8MY/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7egk+JuppvJgeGU45cSC9UjZp6m8SvIzi04Z3+oHrrnky9wIE
	xU2J1SogjQL+s/0pXd3p6GitvRRS9Zr1OO3K7RVKthL83+K/cpDLkaBajebb0Wa2dm/XxO9I5aj
	P1CW70tp5apW9kWcagI9zSZX/e/cliSP+rEigKHtZWA==
X-Gm-Gg: ASbGncui+qeqAtkD77B2Pij6rfU6AIZnM45T4F5fGRkkfob6X0xaY/JXL52Q+rBllr4
	0EYNyAVE6J8P2gtf/HlNrmtlzn2b6QUZlYKlBdXb7zZ62t4j7BIBMB1NcOl5hsCHkREeq3yCmnx
	gRo6QmW4jM9/aRhcxSa5UAi121iV8nw+mzmUvMsgID6Q3ddOfHRoDu46fi2nvgav57dK6MQcoVM
	enQcfJ3juZncQOL7k+zzpiOtk7j845FBrSmiLg=
X-Google-Smtp-Source: AGHT+IFDZvNaU3eL+sPBd2g+8ckgsa/t5Cv1DlJOj7IrzVfzrcw4klg/uE7e1fiMAWwe/BWU80WL1sKNP8AidkFE6Go=
X-Received: by 2002:a17:907:3f0c:b0:af9:a2a9:b5f8 with SMTP id
 a640c23a62f3a-afe28fc1d5dmr1553038066b.18.1756228371757; Tue, 26 Aug 2025
 10:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
 <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
 <CACMJSeu_DTVK=XtvaSD3Fj3aTXBJ5d-MpQMuysJYEFBNwznDqQ@mail.gmail.com>
 <2025081931-chump-uncurled-656b@gregkh> <CACMJSesMDcUM+bvmT76m2s05a+-T7NxGQwe72yS03zkEJ-KzCw@mail.gmail.com>
 <2025082612-energetic-lair-ee26@gregkh>
In-Reply-To: <2025082612-energetic-lair-ee26@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 26 Aug 2025 19:12:40 +0200
X-Gm-Features: Ac12FXxkgjfxjtCqgbWi4lcdhlWZDxk1sUygzZJ-Vm9DflOQJnoV5kzUn5n4oQw
Message-ID: <CACMJSeshuCMDiKWBKYD9OB5QvZugkz-87EEu-yi2g+7UF+WUJg@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/515] 6.15.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, srinivas.kandagatla@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 16:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 26, 2025 at 02:06:04PM +0200, Bartosz Golaszewski wrote:
> > On Tue, 19 Aug 2025 at 13:52, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 19, 2025 at 01:30:46PM +0200, Bartosz Golaszewski wrote:
> > > > On Tue, 19 Aug 2025 at 12:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > >
> > > > > On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > > Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> > > > > > Unable to handle kernel NULL pointer dereference
> > > > > > qcom_scm_shm_bridge_enable
> > > > >
> > > > > I have reverted the following patch and the regression got fixed.
> > > > >
> > > > > firmware: qcom: scm: initialize tzmem before marking SCM as available
> > > > >     [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]
> > > > >
> > > >
> > > > Hi! I'm on vacation, I will look into this next week. I expect there
> > > > to be a fix on top of this commit.
> > >
> > > Ok, I'll go and drop this one from the queues now, thanks.
> > >
> > > greg k-h
> >
> > Hi!
> >
> > The issue was caused by only picking up commit 7ab36b51c6bee
> > ("firmware: qcom: scm: request the waitqueue irq *after* initializing
> > SCM") into stable, while the following four must be applied instead:
> >
> > 23972da96e1ee ("firmware: qcom: scm: remove unused arguments from SHM
> > bridge routines")
> > dc3f4e75c54c1 ("firmware: qcom: scm: take struct device as argument in
> > SHM bridge enable")
> > 87be3e7a2d003 ("firmware: qcom: scm: initialize tzmem before marking
> > SCM as available")
> > 7ab36b51c6bee ("firmware: qcom: scm: request the waitqueue irq *after*
> > initializing SCM")
>
> 6.15.y is long end-of-life, so is anything still to be done here?
>

The same applies to all other branches for which Naresh reported an
issue: 6.12, 6.15 and 6.16. I think only 6.16 is still relevant.

Bartosz

