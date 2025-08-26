Return-Path: <stable+bounces-173732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4AB35EC6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2158116E075
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB3307484;
	Tue, 26 Aug 2025 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3+pRQgF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103426B747
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209979; cv=none; b=t20TVROXv/7nStFaNBJ89+G9z3weW+xXJchkKqvXXH0s5b8Vz14IfOYOrzKp4BFJ/vMVC8aSohvXsrBVmziSxbdVfAIOHuUqi/Fr1ONpozCmdSfHR8xvrCcDZtDYsNfWWH+MullntPYren19JOcLf3gNW1cPgwL0yrVNfh6DXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209979; c=relaxed/simple;
	bh=bSRRUAqhvp44h3dVi1WARRkNFMByO0ADl300jk30jNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsvFPAD1JSs5pWlUGjFdQHG8jU4qQYB4RVUyBILOx8L63wK2PqoB+hlL8SlG5nSmtV6sToq0Ke9uUDb6Sp3gwd76U7h9WY+Kj/Qk9qL0HcL2AzArdP4YwKutmcqCe7kZQD3jnQu/utGgqp/wdcSDIfiEm9w8O8T4ZpcmbHy8nEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3+pRQgF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb73394b4so782306866b.0
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756209975; x=1756814775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lxFjkTB2P79PoUaLxLAUp+gv0c2aOYdZxNYZuNh3BDw=;
        b=F3+pRQgFkpzCCYJ7wQ3Odb12m1NnauCMjLfwz3R88V/o068VVmnJwLdcbZ3TKgeER0
         j4QTlKzDI/eTaobO9531MJDSjHATCSqZoKUNfMxJgx8LfagE5YZ/jn1YgplEKVLBrGay
         rot0DUgC//tgLU2brQm4i4q/pJdWaY4QfY+HFsVHwYdFeWLA43wdAqrf7tJnIXlaY1Xh
         Y5udcfd7K7KIJqtQ1tq3paHmiQMqgynhay41Gv29Le5E6dbXGdsgZVMa9k1hzQ5CZJRr
         mVaD4QVyNi2mJWXfu7WxrOutA+HTEPGLsueBVlkCbNWpnS1K3Lk4AyZ7ngDRCod0LP08
         x+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209975; x=1756814775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxFjkTB2P79PoUaLxLAUp+gv0c2aOYdZxNYZuNh3BDw=;
        b=mD8iRbJfuKFOSFn0LZ0gRAbcmPdxENhOrtRTAMQ5WcuiWNMTDvz0jK/aA9VGWjz4BR
         OrhUp31bqs5kTPV0Xh6PMcY7fTVh5hV8T/7MwiSU2wbViqY2gVcm2JQEhtun+bwW173C
         PAtaKtclDRTkdWPvdWQanp10Sigu+vBYJYCbyubWKI0IQhU5l23emKYZ/BHLjltM5Vhf
         fE55jD49ZbQ8irmdhcSdpDhiWYch2j2as2aQkLSbHX7ZEqZQ01jrlJglzAjEY6gqmbAG
         LGsH2n9qpfxs7mSK10WNptpe/MZhlKW5aOhexk8Xs1ERD8/t9cqIegJgEwkudfAsSf+U
         QVBg==
X-Forwarded-Encrypted: i=1; AJvYcCWO6CcikzqlL7RWV3XI6HNzpVIOgHu1fOdhNHALc2vLL1SXWV9J1SlXYMoNI1w2ELOAH18ItQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZ4CPw6xioPobfjUEZzxeCpRVs5u7BIqBZ9tyRTyiKFnnaWl0
	72i1+k1OJf/dIP2uBgFcqo/j+P6ZcWdxW9JdJR5zNDlnOCluuVlSnbPhdt5LI8Ve4UJwtEvw310
	RPLDd021UrZvBLOUnHFPR1dp3w4B5aCw1rofFaoNZJg==
X-Gm-Gg: ASbGncvrp4SPZKB2nTgVhy4cy1kGxbZJoDhu4PWtmYuV8cmge7iQ6XuKfdRG0jKx5zG
	tUl+dsgU4sFtnTVJB2OVi7Lglg/BqzCOlO0fvbw989ZKdlszht683p/TWB0sYY68UcNKK2GBCMM
	k8JVonTHYL4umGtEUExRfFBsZ0pRxgmePlc9gZQuyV2uBnP32XVUB7U2/cGB/gvHzUvE67gaxj0
	Fuba48qmm7zljTJo1xE42jphn9wTDH2CqX2G+s=
X-Google-Smtp-Source: AGHT+IHCPPogA5I5xYJjZ3AF2Jj1OEbjkizkVIqqQo3oG7dsb9k66ChvqgzLqUtgok2+xdd2moMuf4gTw379MNCuFxA=
X-Received: by 2002:a17:907:3f0f:b0:ae0:b3be:f214 with SMTP id
 a640c23a62f3a-afe28ec592dmr1369727666b.9.1756209975430; Tue, 26 Aug 2025
 05:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124458.334548733@linuxfoundation.org> <CA+G9fYt5sknJ3jbebYZrqMRhbcLZKLCvTDHfg5feNnOpj-j9Wg@mail.gmail.com>
 <CA+G9fYt6SAsPo6TvfgtnDWHPHO2q7xfppGbCaW0JxpL50zqWew@mail.gmail.com>
 <CACMJSeu_DTVK=XtvaSD3Fj3aTXBJ5d-MpQMuysJYEFBNwznDqQ@mail.gmail.com> <2025081931-chump-uncurled-656b@gregkh>
In-Reply-To: <2025081931-chump-uncurled-656b@gregkh>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 26 Aug 2025 14:06:04 +0200
X-Gm-Features: Ac12FXzW7NUCjgYWSamJwSOH-347hP9Z3Gi-swjOizdLDz6f5VXnlkQBVvbGglE
Message-ID: <CACMJSesMDcUM+bvmT76m2s05a+-T7NxGQwe72yS03zkEJ-KzCw@mail.gmail.com>
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

On Tue, 19 Aug 2025 at 13:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 19, 2025 at 01:30:46PM +0200, Bartosz Golaszewski wrote:
> > On Tue, 19 Aug 2025 at 12:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 19 Aug 2025 at 00:18, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > >
> > > > Boot regression: stable-rc 6.15.11-rc1 arm64 Qualcomm Dragonboard 410c
> > > > Unable to handle kernel NULL pointer dereference
> > > > qcom_scm_shm_bridge_enable
> > >
> > > I have reverted the following patch and the regression got fixed.
> > >
> > > firmware: qcom: scm: initialize tzmem before marking SCM as available
> > >     [ Upstream commit 87be3e7a2d0030cda6314d2ec96b37991f636ccd ]
> > >
> >
> > Hi! I'm on vacation, I will look into this next week. I expect there
> > to be a fix on top of this commit.
>
> Ok, I'll go and drop this one from the queues now, thanks.
>
> greg k-h

Hi!

The issue was caused by only picking up commit 7ab36b51c6bee
("firmware: qcom: scm: request the waitqueue irq *after* initializing
SCM") into stable, while the following four must be applied instead:

23972da96e1ee ("firmware: qcom: scm: remove unused arguments from SHM
bridge routines")
dc3f4e75c54c1 ("firmware: qcom: scm: take struct device as argument in
SHM bridge enable")
87be3e7a2d003 ("firmware: qcom: scm: initialize tzmem before marking
SCM as available")
7ab36b51c6bee ("firmware: qcom: scm: request the waitqueue irq *after*
initializing SCM")

Bartosz

