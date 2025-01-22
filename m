Return-Path: <stable+bounces-110203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6931FA19666
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D596A3A3216
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A6214814;
	Wed, 22 Jan 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8uHpERM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BA74C14;
	Wed, 22 Jan 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563020; cv=none; b=D6jnEG9FMJF94uMK5nYph/h0gpTWwYCPKl+zJ74P1H96WQC13TR3BbrKDBhnUunrv+vFr5PcyuONoyH+QSbaoX66BnoyQNhz6to9fRoeieyfg+b9IcCyAUv02U2klqUhWwkebFoR7lkID1QleZ3cQHOeYXa0T5y2CRJCXnscsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563020; c=relaxed/simple;
	bh=NQ/9yKZQ8Pw6JrE0T25JCnKzA4mOWs4HJBMvLEhnigs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+XX0AJtnrlGwr5miWYKTTQ8bvKlulTqUiVTKic+UtRXGygXeONB5Hvtr8Cptwg5YCbaSdd/ENofifBC2PYYES8uMbiqlP/dJvfJRvCMHghfCk48PIXS+RgqijR2UDl9OCBlZPo1VMUfFT7aInGZq0tphyjjLLXaXwPGjNMWnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8uHpERM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216634dd574so84248065ad.2;
        Wed, 22 Jan 2025 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737563018; x=1738167818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2PL2tNscT5bmKkvJGxEtyXs08tv0MMaLhB4dURpw0AY=;
        b=f8uHpERMFG/IEJUKn8Uyj7xMuRFTi/Jb3asoEmErG2n5ZajqomDfIsBGCAELsQOO1d
         Kf/iWx8yZPhsnyiAW6PYF8oiOEvwgB94BDFr51N92oWz7oyFUi6wcAsrlyGgRMXY7uBZ
         4JqGWbOfxbA/f6eXEAy4ex3UjNXiIaTtjZKUYEnZz0ONt/mbY0qxMSwvHFJ2bPQtfCsy
         55Sq8CnkhSR9rvRZ96GLqTO2rvvGDkyYivgykuhzP3VdylIGj2xo3pMCuCi00OQqCntk
         MG+XDRRZriICltBcBJw2d5CwdcSGb+e5xbku4iYPSU8Lt/YUitpVTdvItmX7frAGFVua
         kr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737563018; x=1738167818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PL2tNscT5bmKkvJGxEtyXs08tv0MMaLhB4dURpw0AY=;
        b=oSlClNge0ZRPY/Y+d6sGA3uCrDV2G2qnC3FJvGhEfeQKNLRUzesQfJazKGcVbPjVws
         U68aCF3twPevl6KYed3hdw6vwthEeBstbSmVlKas7TNA6WWblwjn7sXm+gMFiznJPjds
         Ff/NtMxy2xaOnT30mHqSgaemKZQTzehHAJzYdGgX1DbRXL3KN8fCm6HuAqPztrudO5A2
         ORXu8TmqzdfJXfyPfKs3xo440ig8A+pkWa4G8obyEFX22eMdwNphPf8EL3u6jx/XbN8D
         +lNhJGzRukrJ0Xbs5nELs9Y+dW/apfzDaqCq77g1FE53S2G+Py30FUILfARv0eVtd/2e
         K1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYf+2QlOMHBbXBcrGulRbnfIN+gQpM6RJQ9OgEawFxGlMSILyLU8wvHqp2yGN8MzBbXJXqBLQws9w0+oQ=@vger.kernel.org, AJvYcCWpWLFeTBZlzQLlMT0K62Pv0HazaGYkcj90nEawYjtnBd2ucmD5OguMCQwg8vboXs4GNFXJifum@vger.kernel.org, AJvYcCX0irLETP98B4HKCTrL+8d194ym/PuceMEDiRe7Mgpvl97WueJyIyBAf+EtzXVf7llEHkQaOLok@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9mN8tcLsJofZGUvARPqS5dOSlGzTbqX6bg+3IOG54uA0xfRz
	W6moXtQj7YkR1CFLrTBpT8gLhG1gx67Oi5pkcKnrL/K4Wk84xp6pC31Cyw==
X-Gm-Gg: ASbGncuI10BXJP/qI/XcSxAY1xnKOoWhXG2uce5DxAv9IBuToB7o2nrEIBXXJzu7MFR
	p7TQE/OFlneVKslNbEwgIoIEloLZz5bbez/Jj2zAnX04zLkvG1L7o6Wua5Ppvw1vlY7tm/ZDwx/
	h29Giq6Q9CGB1oDMinZgTg+AWKcdks/7yFRmN7tROrjU/1wBJWUPa5oCdsIed95LlO9xGCdGTqD
	/ZuHjXgx5PMrcOV9Xr2QYa1U1M/PAq55zLqayn7e4gDC8b5sTPSzg8HyQw82nihRDXJcv1AaPld
	HymMODJZM0JHmg==
X-Google-Smtp-Source: AGHT+IElg0Am4eI+PQozPZbMcfeZadFzByE6HvjJAb4D0LxjbbiLWhhc2/lYG54MhwJ4L8DOFkt2sA==
X-Received: by 2002:a17:902:f64b:b0:215:b087:5d62 with SMTP id d9443c01a7336-21c355b5684mr363334165ad.36.1737563018437;
        Wed, 22 Jan 2025 08:23:38 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ad20bsm97020905ad.128.2025.01.22.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:23:37 -0800 (PST)
Date: Wed, 22 Jan 2025 08:23:35 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
 <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>

On Wed, Jan 22, 2025 at 08:30:51AM +0100, Arnd Bergmann wrote:
> On Tue, Jan 21, 2025, at 23:41, Thomas Weiﬂschuh wrote:
> > Pointer arguments passed to ioctls need to pass through compat_ptr() to
> > work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> > Plumb the compat_ioctl callback through 'struct posix_clock_operations'
> > and handle the different ioctls cmds in the new ptp_compat_ioctl().
> >
> > Using compat_ptr_ioctl is not possible.
> > For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
> > it would corrupt the argument 0x80000000, aka BIT(31) to zero.
> >
> > Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
> > Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> This looks correct to me,

I'm not familiar with s390, but I can remember that the compat ioctl
was nixed during review.

   https://lore.kernel.org/lkml/201012161716.42520.arnd@arndb.de/

   https://lore.kernel.org/lkml/alpine.LFD.2.00.1012161939340.12146@localhost6.localdomain6/

Can you explain what changed or what was missed?

Thanks,
Richard

