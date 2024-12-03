Return-Path: <stable+bounces-98170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB959E2DB3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DED281356
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BD208978;
	Tue,  3 Dec 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LAy3oHOW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9161207A2E
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259352; cv=none; b=UBIkzMOTgnDm60nrg3DYgLe7uw1RB/D7P7vO1/f7WAqx6F1de8mKuCLiUt1COki92Qmwk7PbJSBf4fsNjtZClSYugL3ZadrSkNC0xTIbhbgfVtVOmnrMZElDyxHBzlkz2AVoqDygCtgBbZha9x0CXk5KviDqb6RWlS0sem+m/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259352; c=relaxed/simple;
	bh=eLcYDxcnynl1D64i+3DMguwY4XPCJg81k3dnaDdJIbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB/0esxYvnfMejJQ2/oG8iq8HuDx6jDpA4pn1jHGy26LTD2eF3auCE4vbjaS4QeeSmmdhNlHwJE++pliZAhQFHH/uMvtMDTPC26Jq7GC6MLJ8ZtyWpngqQ9TpkDR97aemvbHMy5j9S8rukvcmNJP0dRp8AZGUWC4S7Y+6pNbVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LAy3oHOW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so92801631fa.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733259349; x=1733864149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itGnniQM+p/vJK3/mgQYD2qiAW1SyPNKjRN6TdQ/bi4=;
        b=LAy3oHOW7689Xu8hkfLCcn/zdcmseTsoMEnlCZ55MSsgTS7beqYRu9VZKYxsFKtIjj
         FozwZoBjThDrIw0DMmLViENMn34PLHJZ7FG4MaPOFBQgyzLoQthiRq2AHWqfGri4Qrwt
         NIQdwjswkT+lLmXOLWsbXiqpaTavzzp7uWpkbrvCCYsNc6pdwrrBTBn8eXCmGuqUs6uY
         f7IO756gTnoHWjbL6JttF0Kah6WP1hgIN30nZPCqZBkF+FHU52CuTrb02Jj+tTdCiYoV
         3gig1jSpXZgdmASm/jh9nv6YuoGIB051fVOFwq2R1nGu2res8qWcKFtehClksOvU8umq
         1ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259349; x=1733864149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itGnniQM+p/vJK3/mgQYD2qiAW1SyPNKjRN6TdQ/bi4=;
        b=cumXRBVXWqeKN9zDBnrpDM3imToOuq8fBvwj4IxSCOx9huW10Njf+PfMHs84Objvko
         1PHaRrKDuMBeMyqtcGCrREH7cjT7zAtyuoaLVllTb7iVJLcOXHCDEog9HVgQj9350H3e
         4VWAZ5DI6Tb25BHOsrUF3FSnIAkw5fXLPaUk+YadC8bkoeJdzb2obKa2AA92dZvCav4Z
         wYxLmULr3jGFirNMaM/ArTD0M+iIKdEeQU+m+Hyo15d/UFg2oBJ5WGviTe62Xm2VrH7S
         qaa6EjWLiuF8bTQBTjlVT2oqwQL0Qm22lNEPnZ4mJ1U1F1tATt7jonmNsx00h3PQjSke
         qGww==
X-Forwarded-Encrypted: i=1; AJvYcCXZZtppSbB0ou2Sd+lho0Hv2e3i3q1gRHu9C55A7bBDRrriT33gkU2ywakRPG+5NLb83mqiMGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzduY7gsZt8tMRB2G4qtGNKNf9Gd1EF958yGLWMC1Yuz72EtfRi
	omWPuGhhKCwYg2oyCn/DufhGP1rV3bRxOXbE5OJWq7g2j4eeXn7D5Vj9HComPE/wqh6WUHv9Btd
	+6gz9+kqnNzO7Tl4W3vwdMAEmjyTcrILEx81D+A==
X-Gm-Gg: ASbGnctDwhg3Oxq5ZwPx7qlYxkx11Luf3V+m9b0ujmI9VBp5EnAqBMeDBduQ7PZStHq
	f1Wt4QLWTIV276vTtEieNg84jOlWAcuw=
X-Google-Smtp-Source: AGHT+IG067Jk4LL3da1h5lHM6wFo0Vn15+FnIBImO91v0eGyNeKMO06aLWq6wdCh9MkvyOn+7a+4HaMe26FA43Y2k1A=
X-Received: by 2002:a05:651c:19ac:b0:2ff:c8a1:c4c9 with SMTP id
 38308e7fff4ca-30009c46233mr36458081fa.1.1733259348900; Tue, 03 Dec 2024
 12:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org> <20241203173503.GA1510@sol.localdomain>
In-Reply-To: <20241203173503.GA1510@sol.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Dec 2024 21:55:37 +0100
Message-ID: <CAMRc=MfGWOPogAqpC6vifQC3BYfSVqpVC80X1SL9XWypPLZPzg@mail.gmail.com>
Subject: Re: [PATCH 0/9] crypto: qce - refactor the driver
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Stanimir Varbanov <svarbanov@mm-sol.com>, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:35=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Tue, Dec 03, 2024 at 10:19:28AM +0100, Bartosz Golaszewski wrote:
> > This driver will soon be getting more features so show it some
> > refactoring love in the meantime. Switching to using a workqueue and
> > sleeping locks improves cryptsetup benchmark results for AES encryption=
.
>
> What is motivating this work?  I thought this driver is useless because A=
RMv8 CE
> is an order of magnitude faster.
>

We'll be extending support for this IP with some additional features
soon like using device unique keys etc. This is just some refreshment
of this module.

Bartosz

