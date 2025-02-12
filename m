Return-Path: <stable+bounces-115031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD5A321C9
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8FE3A5A89
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361F205AD1;
	Wed, 12 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rHoWqk9K"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C5205AC7
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351341; cv=none; b=CUZC+HTFbJZMJtZQiuzDqFM3XF47cS/GeFtV1o65CfajoC9QIqE74osEJsGD670QZMUmgicDDLP2V3jbrN8agHsG2R3kEUetJWwbzpZwr7gTUH6r0B/amhpXgHpEY5Ib8QpTxsDdpD7g1HWcUorFLxF8HSnopnAOWDyMX5j0NYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351341; c=relaxed/simple;
	bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZiHPMW9xInY8Bpk8Q4F+6EVS2X5t+Hs5fBFhwc3u7l23WQCyqnr+4TMBsokAPjMAQjtfT/n+x5T65yukZL5iyA0N164SvV/cxkUwwWC/xeM2YnLKeeqvEaCWD7ivUB0hNOTCePAg26nsFdvBNYsrMZ4vz1Z2FBjjeWPc2SkpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rHoWqk9K; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54505191cdcso4203867e87.2
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 01:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739351337; x=1739956137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
        b=rHoWqk9KET0/UQ/ypo46bbvtDE7KVr2A0Su0zP99gIi13A5YypM+5rtXFlf9+Pi9XG
         S1p7zWrmM6Cpf4+oEjbBfjNNPAUn4RXEJWT2lB92AYtmk7OU1OOF53vNerZYnsRNcrit
         3WTY4zd57B3VAxztrC4hOGhKP1xPmbrur1pGgTi3NnrMX8uA0MC8gPyUn5Pe0t4WyMb/
         J8e6BstzphqbwUUjxcB3b+EjL91JKnWq/UhyrShnawCmKwugtdXjAYBhPMNPiKeV96ch
         LBzU8yDrM0bj2PSV/7FG5WlLQ7SPkcRxwobkU6MfLZcs8L1cfH9tfnrHAbbyKnSciCcq
         6ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739351337; x=1739956137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5wGpnFwIRrA8Xe201rtdK31/WPbH4qcC7pqdJpe9PM=;
        b=NPrGO8IkJMH0SE3mDuw+UC406n+2pMO9OwH8qSt6cnT4dnhwf1U1o9cdDqDNKOO26S
         D8o61H+yGHKF6qCBl6eJUDber3OUIXB0mWp7jEsLbc2S3r/ZAr0upMn03mYV0A8XNP7n
         ZtOlRJZSOT5nfASYko5NOetAlP1FqMCwTYTuSXp/81QuOcq7THdxb2YU75uI0TmDRL2H
         2uUcHDG2Ufb4lt/jpJHHt1KfOOaLeWiaNDohpI92bRGS0j+NxMLCCy5qdY7bUgoW5CR2
         HzBcaXvkOsLXesP5lLyV0hFM/8l00YgeZ9rHT4qYntHQTQJK2VpCCAFR2528nGjHhpOP
         46FQ==
X-Forwarded-Encrypted: i=1; AJvYcCX19IAwxebFGu4rgSOQUBQd7maQtzMU7j32s6+qUsl+p7fJMkemI0ehw8KpWb1mFutfdsgIHDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0OWLnHbkCc5Szzv9FD2tHaGUWdGaLO+q+nx7UFzu85ED6WYs
	GuxMocIrjmkF4rZFqL+vtqFetfHHnXBstsjICSxggTOjNNHTWEZUNF3mDm7YdNWE14Em9PMtmKp
	9tfngB5M/8qhBBzvWPEz+CiVdxpAIev5FK+JTzw==
X-Gm-Gg: ASbGncsLR1Uz+Z+BxEdBIF4KobawbS5zFxtLZ7AtxnO462ar2E9J6vjqLYAl5b1/IiT
	J1doOQY0JTxHgOjZHFy1dNqVEiBY+MKUkchTL8yOzgcVXyNoouiKj9upM7hsx8j0BHruT+utfmK
	YWNEQzyRHra2ySprYeHIsx8h5BFlVC
X-Google-Smtp-Source: AGHT+IHMVhNH1DsYiwDgLt8aoqLJRbGu0lSkpmAHQUbgHbclESRiO+lCCFE5NmUMNPANjy2YyCxX/m9IzHXzQl+nN4A=
X-Received: by 2002:a05:6512:6d6:b0:545:450:74b9 with SMTP id
 2adb3069b0e04-54517f7b432mr715928e87.0.1739351337360; Wed, 12 Feb 2025
 01:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211203222.761206-1-superm1@kernel.org>
In-Reply-To: <20250211203222.761206-1-superm1@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 10:08:45 +0100
X-Gm-Features: AWEUYZlOaG0fdFZcvnZdGV-_YBOc5ks7TZt7wQR5Pn3UZrMzduFNjTZra-BNIVw
Message-ID: <CAMRc=MfOjfHWYGWMx3jcqQpnn6Kn+TFHVLZ355P7zG27JkqFDQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro ANV14
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org, 
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, 
	stable@vger.kernel.org, Delgan <delgan.py@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 9:32=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Spurious immediate wake up events are reported on Acer Nitro ANV14. GPIO =
11 is
> specified as an edge triggered input and also a wake source but this pin =
is
> supposed to be an output pin for an LED, so it's effectively floating.
>
> Block the interrupt from getting set up for this GPIO on this device.
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Delgan <delgan.py@gmail.com>

Please refer to process/submitting-patches.rst - don't combine tags.

> Close: https://gitlab.freedesktop.org/drm/amd/-/issues/3954

This should be `Closes`, not `Close`.

I fixed the two above myself but please keep it in mind next time.

Bartosz

