Return-Path: <stable+bounces-144156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC305AB5365
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBFC1887B49
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC628C5DF;
	Tue, 13 May 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EMoLE7XP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12F28C5A7
	for <stable@vger.kernel.org>; Tue, 13 May 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134150; cv=none; b=DsXOa88aGcDxXflrBwRhQ0Elwack+rslE7z+ictkuWK1Qw/PMWw7Kg7BuWEk6XyBcjrpWG4lkG4afbbGgL/Jf1eIbXSIx1ixtupZIiGQn0oqmE7ngsjBYE8iC1ScpC8UvsQohOVwX9rWtI8lFD1wDb93yVs1LCbvmZeEXdxxhtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134150; c=relaxed/simple;
	bh=mssKbIoY65LmLl/b0fCd0FyJzxFycEEFgEHhfJY3hHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8oMwTwcigZY4ReDXa/PA0BMPHQ80QhA03Q36prYzZfnll1vAZoKuwbZ+0nzTfvboRrZBEQB9AppLanAuTAAMak2CRyKPp+OkV5qRq0PEtQMXOO2E9LoqWz+qnCttSfsguYbzhsu3jCmiXWiteM6AgjtgQBtbcugkEi+NYaNhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EMoLE7XP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so5029968f8f.2
        for <stable@vger.kernel.org>; Tue, 13 May 2025 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747134146; x=1747738946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o26ZWiTP9c7iIOQX7GPOxDhZLUi1kJ7hn4K0Nn53HKc=;
        b=EMoLE7XPE3TTmkTn9bTQyZREiIRRGX7YVuqCWkphzI9ddUp97JommvmRhnOeydvBAj
         5uYo2197zoJvfViND81fRgVY9vn2k2iNuzcmZWZZFBA7dJcrrYmJiJNOq69n7mFrpd/r
         aRfIYYx0A9LaU3rMyYBThw/E9nw+83fs3APRrDdoTAKZdl8rAjrnQ/xCTOrm/3s3Oj6n
         M6am0bYek9vV7wDwNQsBudi1TEGSO7GkAA3Xz2ULryoHMI17a8npEM/rZF0mvfefoyvA
         q6bdqH2TR++reOoqgKQ2aEh7IOlzs+y1Nr01J5xCohyO1cOIliELvgIVqfJdJ69sHnua
         pSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134146; x=1747738946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o26ZWiTP9c7iIOQX7GPOxDhZLUi1kJ7hn4K0Nn53HKc=;
        b=OSAx6dNwfUPZVeJNHRdn4Em/bDjo1Nin7jJMQX8BQK126OLNAVTZdu73gZMscKxWmZ
         O6MRyGa+MpnJA9caFRcAUsG0Y32JqdfJglfmfHnSixcDYEDe1mD7oba1UWCuuBCfT42M
         lkYIkAJCIMIA5wAhW5t3m6T/xBhYpYfCJ44lnl7nXEIgHoS6ZVXPpQujti0OH+S2jYeM
         67s2QocyuWvabu+0fbhR8QYEplmWfgIG1xL3bEpMbtwTNARqJ8uziNaRB9zKblDPSF+K
         SgFM3U5BCVEC9760yRAbbSwJ/e++SspSnissHOoj2wLESjoBA5MdSZWO2qXuURJRnbjo
         fdmA==
X-Forwarded-Encrypted: i=1; AJvYcCVcqPjtbWUH8rOks+B5yFXi32S8xiABPxK+GZi3Q1A2vznYpKKWJvcKBmd4f4IezlVqm7gBPDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRQh51SPsgC56jKJNwKgyRU9u3Gjhv1y9cBOEydSngoMWnUAi
	diHBJ8/IvQiJ5NtU9nTsXdbfD5hUXsYD4uJX8vUcuKus0kwk5lztHiOcojv9Y1A=
X-Gm-Gg: ASbGnctoW89ckRBtrm3BZCR14zLX+MSJoipOVQlfIYj3O7xc4si3YO5f15bYaP8jFgI
	n2TkGbfI24PSRHLylG/5sIO53YgEkROC3NYrVN1SMtT+KFHAEA1mU5hg5D9FCmX0kc3yd72/qoL
	ua/ALs3z6ym3ScOOr6yKZpztIim83XcBc6QYw6BDKhMCTMFiXEWsTVhUeO3OMvZkws8iv+GmNDE
	e+rRDmRlsJ8tNEX0OLr3F/uDAAVpUdxoNBoCq9UTg8mWCqK1gtDQZq3zhdg4Wr03e0V2HaFoVxG
	VmJamEaat7m90srz7iQeO131QtQ0HpAsSDQjLtYByGjGSLbdVc7LAAgtiIgM+CrJrbOq1CYCq6a
	hqUP/fE027EdXFk1BpSBY5GRg
X-Google-Smtp-Source: AGHT+IEFFJTx+ExeQ0LxjZrLVtDg/lSkbV461KmtV93IzN3+6IjslOyP/QaT3NmsrWAQb9LLcZHxEw==
X-Received: by 2002:a05:6000:4287:b0:39f:7e99:5e8c with SMTP id ffacd0b85a97d-3a1f64c0df2mr14090834f8f.51.1747134146531;
        Tue, 13 May 2025 04:02:26 -0700 (PDT)
Received: from brgl-uxlite.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ca47sm15851252f8f.73.2025.05.13.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:02:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3] gpio: pca953x: fix IRQ storm on system wake up
Date: Tue, 13 May 2025 13:02:20 +0200
Message-ID: <174713408243.11101.5617298935758722435.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250512095441.31645-1-francesco@dolcini.it>
References: <20250512095441.31645-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 12 May 2025 11:54:41 +0200, Francesco Dolcini wrote:
> If an input changes state during wake-up and is used as an interrupt
> source, the IRQ handler reads the volatile input register to clear the
> interrupt mask and deassert the IRQ line. However, the IRQ handler is
> triggered before access to the register is granted, causing the read
> operation to fail.
> 
> As a result, the IRQ handler enters a loop, repeatedly printing the
> "failed reading register" message, until `pca953x_resume()` is eventually
> called, which restores the driver context and enables access to
> registers.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: fix IRQ storm on system wake up
      https://git.kernel.org/brgl/linux/c/3e38f946062b4845961ab86b726651b4457b2af8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

