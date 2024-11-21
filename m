Return-Path: <stable+bounces-94501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BC59D488C
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A2CB23052
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9901CB313;
	Thu, 21 Nov 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WPh99lXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FBE1CB312
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176643; cv=none; b=FlPNmGco6zKliJgft3/KRqk+fOegwYUxQZDll4VVZb5Se7qoC8l5whPKDB1khunmdBb6bWqNBYhWocM1BHecZDy56+UHduKYnG6CO8ySV+CVckVWfcJe1IcV5pQV3DRlzt+pfTz8KgCoHxTHtoJYx30433qJnPHa1DxChQuKrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176643; c=relaxed/simple;
	bh=G0y8S8FylKy9wOyLSETpxAgPzGNGTgM2QMr1+EOsyZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC0ZyX3PN38Xi75rLqaJoXs4ze09dGMr72iAsDLjVqkOmvPSuOkswifNYVBwZZUYx3qSp9HpFRUWM4AFpjQFTdn9v5zYLW3jE89Om9JhtYZTRTJiPEG58GiSvOnvugq1f9QNiI9hzu9knVQgdZwygyJDa6K28C/4gbxGtbSi4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WPh99lXO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso5228645e9.0
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732176640; x=1732781440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvFItnRaSzv8XFWni+I2CoIG7nGDmUnhDDIVa10U4XI=;
        b=WPh99lXOxRK7XaJmHOuxrRygYvwubnm3xnY1067gkzYZv0Bkt7MRc9trXd0qhE+06k
         g0nCbM3qhK5q0y9+lkwhIu9i0CMkUtAHy0gAMchJWC4tkwEwQbRRXhJij1DjbymgqOAT
         Y7ssTy1G38U7GNvgPFjVSqf7AWnHIiBQ4e0Ax02G88xriTHQMOfer8Kw3YjSuG2ThRzX
         cQRDwClHv9mNzKOZZbsWkJMSlYVXuUP0YOoLLqTEfix6fQWnBCuAxytxltMOfcyQDXfE
         xGteCRmcuxcmmeVqZSLYGyY2VJ//TRxjvg8DdVzBpo2cuPAfWIuGk4XWSd/BRC8QI0Kg
         Oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176640; x=1732781440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvFItnRaSzv8XFWni+I2CoIG7nGDmUnhDDIVa10U4XI=;
        b=F2IlGe9vs27W8+lmgVip90xQjuRPB6dUz1GeZpVmDg75vVgcZUlr2bWyowtboosoQ7
         siuEvN3emKtSdqXVd46SzPLNyQ90mC/VWuCP4dV0IkDPrfI1K3QJyUk3F5dngnHGpX1e
         7FpwA3ebch+xnQCKDG6Nsyi1UccO2EImS7BHQj1jvfW+h416Gy9rj0QEjXjATjSE5u0t
         cQMR90PFjqv9eDH7NsjH3lsgokfwIhXsrWBSLW1CiNoLJhmWjBEB2UpBQ9ZPdFwZasVZ
         23FwYlX9YBYfO6mu72qVjvZEyAUa6IFJ13Gmmof6Sn7d0w/xaFvpsPzpSBBBm+x4K8aa
         nY2A==
X-Forwarded-Encrypted: i=1; AJvYcCX6sR6gw9M7txlZhH7w08NAYhzb2DlMp28exDh4GSuF9mg2fpZ+7L0nnfcAywcXfb6n+NgBZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZYzMQCwArTn+DsuuQngt8nVFOZV+kfPnEL1FTx9UpD74YZ3D7
	Vlt64OPftbkm8mYuTu2UZf66BiYMjXvWWH7i+YYeVDYvsYNIGlMKJnvIQhdXWjY=
X-Gm-Gg: ASbGncuUnSwLmfnduQJaxe1gK3HPueIed9FwUBcFs2EYektEwh6ypXxJ+7nlSMpCsgo
	DtGlKFM+M2RF/VQQT2wd0K2twZYhaRUMnqXGeE/+DiUvp0GK/KzAqI4SDRiqtF1zLyyEcNYw2Bh
	OGVchWljw+QDH3xpB7FOHqlATIgluAPqvMUGexEiPRjF9p4NUbKG7gYqqwyIXW+4cgFyJsIRAVu
	1WGALO+n60E0JiP381dO3pgLbmy60uBw5NKqHy606KQser8
X-Google-Smtp-Source: AGHT+IEaWht0l5bmuNGPlxvgkCqr7k15F/R8lKePhz7YkRQa1YIU7EjLK0IAYMu0soZu5qf51mZMiQ==
X-Received: by 2002:a05:600c:1c84:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-4334f020b7dmr44858905e9.32.1732176640005;
        Thu, 21 Nov 2024 00:10:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d902:9409:ef0:268d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1170sm46696195e9.3.2024.11.21.00.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:10:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: andriy.shevchenko@linux.intel.com,
	linux-gpio@vger.kernel.org,
	mmcclain@noprivs.com,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sai Kumar Cholleti <skmr537@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] gpio: exar: set value when external pull-up or pull-down is present
Date: Thu, 21 Nov 2024 09:10:30 +0100
Message-ID: <173217662607.10730.15286784016289020495.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105071523.2372032-1-skmr537@gmail.com>
References: <ZykY251SaLeksh9T@smile.fi.intel.com> <20241105071523.2372032-1-skmr537@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 05 Nov 2024 12:45:23 +0530, Sai Kumar Cholleti wrote:
> Setting GPIO direction = high, sometimes results in GPIO value = 0.
> 
> If a GPIO is pulled high, the following construction results in the
> value being 0 when the desired value is 1:
> 
> $ echo "high" > /sys/class/gpio/gpio336/direction
> $ cat /sys/class/gpio/gpio336/value
> 0
> 
> [...]

Applied, thanks!

[1/1] gpio: exar: set value when external pull-up or pull-down is present
      commit: 72cef64180de04a7b055b4773c138d78f4ebdb77

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

