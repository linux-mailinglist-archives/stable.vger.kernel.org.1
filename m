Return-Path: <stable+bounces-127527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A0A7A46B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EEB175D54
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0E24E4D4;
	Thu,  3 Apr 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gnLvg6sS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD25524E00D
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688612; cv=none; b=HRoXKNqK1kt1AF2RdHiTHlO+6N5eEgX9h04kf0f97DDP/AVjE36B5QeItwq3yHC2Kdx8JNsCLrdn8DH8f8lra/hdutTPxgpaayJlX5N0Z7L5678+EZ2Now2egj/OBKQyN13gZGPldWpEwbQ8DyCR21k5c0ncjznqlmmJ6hu/GUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688612; c=relaxed/simple;
	bh=vL1Fbgp526X3IYUv3jqvaisXbeRKQFXoMWoQUDtRM58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU6VQHIICgOLRukgRMKRfLTdhc0oWpbGYYiF/v/VFbxeWuzwXURMN7wSfcq2gmLtg9o5pgqsnM3hMog92nVFtXU/JmS9kOOg3yQO7PiJfqsIUxSo+c6fPlpM7uGNfnnvUrWDNXahYoQm+5xvBEXA1LcRuRiE1XiF93+WiV25DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gnLvg6sS; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so8472461fa.2
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743688609; x=1744293409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL1Fbgp526X3IYUv3jqvaisXbeRKQFXoMWoQUDtRM58=;
        b=gnLvg6sS/676/EWEUTXuLojLRftFFoGXwlZsb4uMzhR8XYCPUXE1kNfzGx4+sfcQyg
         72QEWNvUc83iXaOwVuDlHiWXmjepK9NKhMoU+cK0AB8C0kANVBLOBgZ3EBUizzK3EHaU
         0WUsgR2XozY3eGZMyvVU6b9+TIR7OENrsWyV5ScgoQ18UNjJ6OH/FCatZIG7Z6xR2cXa
         s3JYlHFfGfWi+2szzC7du3PrJLz0WInrsfDh/k8XnMfs0wtq+wQi6rQLPOe5CCZRA7cA
         NamEVCDilZUfzQeir90wLEbTErKRTroIvOTguFoLY9YpxtAtQx/iRjdeR6kRHGrOELER
         JPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688609; x=1744293409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vL1Fbgp526X3IYUv3jqvaisXbeRKQFXoMWoQUDtRM58=;
        b=XcJXLbIl3hhg+8rUGDjJDfdfNravaeyQb5c002RgaH5KS9YiYWd8uTzc3UfL84hHUu
         jnNUYrYZo7+PoLaEea6s40QUTREAeTOqNesv7HXv4MHMrvL4AJsN+3HNE2SpCuYJSdTR
         jvK/PbSPZPmG4N3q9+1osY4cyKBWXDai8HWt8l9HGIPqnmh1h1Q732JEwclV6dMrZaey
         npMG1nbTtKPZxRUm8g35eW0sB3zntl70P+UjuLX4vOEojONZtRowY+vJA3i2EDR0CwxG
         czVwsgAOjm6l+28wgIWhnZauVg0lPRrq4cN5pMwSvb48ld3cDwDnwAeR05WiFwdPymjx
         NNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkcFVXhg/zZLsQpPgopazEKYBO+uqCdXAWJcsmQzH9q43kI8f+gaLX/Yl3SOF2QhQcIG9AUZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4YgupHrc6YS8LaKnf4G4+/PzLE+6JYf9teiB/yDwcrb5Yrh1
	UU3ovZUg8NxfrMhlMSMDMwlUKOM4TRSNoMPCH5dNQlIXa3VH2V5Uy25QPn9BhVSqSiiG15EcBgG
	Kv3+4sZickd30CCiv58cB+n23c3r3yCqeMho/kg==
X-Gm-Gg: ASbGncsZkm4hv4q7Z6qGtT0cY4bYbVW9o7k9GUWW33vHdSPtw7CEzorKSlxZFY33Tn6
	ChsCsvhytUM2prvEn752KQi0A++8BG5xs/+AaVXtdIKrTB6Qh1sUjTxaLUiuaiGEaKCw7TckRIr
	d7iN8xD7XTXiYx+jSSZrZ56lALlq5cBvUDV388pZUYm0ilB4dgL95ZkCAX
X-Google-Smtp-Source: AGHT+IEZq8E9hUMdI8woaEMXoL4h1fGDLU3IWtKUPdoaZP6pLIF3F/ze7rrIOIyIeiS4I9dFtpAdyL29xHsoa9HtLBw=
X-Received: by 2002:a2e:a106:0:b0:30b:d474:12d1 with SMTP id
 38308e7fff4ca-30f02c0049bmr10396971fa.30.1743688608736; Thu, 03 Apr 2025
 06:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326173838.4617-1-francesco@dolcini.it> <174368202234.27533.1000100252310062471.b4-ty@linaro.org>
 <Z-6TGnGUEd4JkANQ@black.fi.intel.com>
In-Reply-To: <Z-6TGnGUEd4JkANQ@black.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 15:56:37 +0200
X-Gm-Features: AQ5f1JoNS8eoE-Q6tSfDVMvkGBz_l6XQrBcrR5WM1qQ5o9XFEN8_s2-duQ2N2l0
Message-ID: <CAMRc=Me15MyNJiU9E-E2R9yHZ4XaS=zAuETvzKFh8=K0B4rKPw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: pca953x: fix IRQ storm on system wake up
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Francesco Dolcini <francesco@dolcini.it>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, 
	stable@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 3:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> +Cc: Geert
>
> On Thu, Apr 03, 2025 at 02:07:05PM +0200, Bartosz Golaszewski wrote:
> > On Wed, 26 Mar 2025 18:38:38 +0100, Francesco Dolcini wrote:
>
> > > If an input changes state during wake-up and is used as an interrupt
> > > source, the IRQ handler reads the volatile input register to clear th=
e
> > > interrupt mask and deassert the IRQ line. However, the IRQ handler is
> > > triggered before access to the register is granted, causing the read
> > > operation to fail.
> > >
> > > As a result, the IRQ handler enters a loop, repeatedly printing the
> > > "failed reading register" message, until `pca953x_resume` is eventual=
ly
> > > called, which restores the driver context and enables access to
> > > registers.
>
> [...]
>
> > Applied, thanks!
>
> Won't this regress as it happens the last time [1]?
>
> [1]: https://lore.kernel.org/linux-gpio/CAMuHMdVnKX23yi7ir1LVxfXAMeeWMFzM=
+cdgSSTNjpn1OnC2xw@mail.gmail.com/
>

Ah, good catch. I'm wondering what the right fix here is but don't
really have any ideas at the moment. Any hints are appreciated.

For now, I'm dropping it.

Bart

