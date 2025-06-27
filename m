Return-Path: <stable+bounces-158797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EEAEBD57
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A896A0CCC
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8C2EA73C;
	Fri, 27 Jun 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzXmYOkR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FF1C6FFD
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041699; cv=none; b=QBAiqYPP7L/OByZnPXAWcHUbMGQdDeikJC518RK7nu9I4ws4hm+29Ah7uTGrY7UenNdO0TVSFUdSCtobl1Vt1oHXVZP88wC9QWcxUqqkClBuRPNBnZ70z1yRImk8B79ZG6K2KUnAqPyUAVlaRzpxNpuvvVhYTVn/uWb7iwn+ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041699; c=relaxed/simple;
	bh=9FA9bMKxVeb5yQVsUVm+jp/IZZQX6CQBPJL+CqLfVAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3nhcWETQIrbNJDL9kFfjoqhQ0/qTiBRbEQ28zb7Q8QyxPlijnhTF+bwuN4QmW01W0WEFHZ+7KTZzGEj7dz6wm4q+KmkgpmJFa8CKqZsYfARJeh7BUFvhoSWhKDgQcvXeFMa+49Q9EVN3lQD/OqAoM+NoY/6Bla7Azy00EgtlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzXmYOkR; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40791b696a2so760615b6e.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751041696; x=1751646496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9FA9bMKxVeb5yQVsUVm+jp/IZZQX6CQBPJL+CqLfVAg=;
        b=XzXmYOkRJ409bBDin9CGpXNXJ/Rguok2syKgwL0r1XCkF0tzEEAz2jX1AHHcuDIi+d
         LeXiRWftzPsqNigFV4oEP5JWkqyiPK/Xro0o8uGqA3/2fegb9dqc+Uq2T/ESbE9o9brF
         lU8UPeuPu2nT4u1TkGszLmuGqV7KQea/xJW9wsJ3EXTLWGAFpBpIBEJY/fSAzlZR1Elu
         uUdpjsfI/OMYt0WpiPt19Zm/qlGGPLAU/t880gHT7dwScVPk4XbS3gR7dRib6frY6iWU
         X6P5sLE3lnjW39LkE+u/EQ6jtfZ0Rr6LevvTbeAZ4+Tw/CtYd9jIJhKOmdMQiMavDOlE
         NRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041696; x=1751646496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FA9bMKxVeb5yQVsUVm+jp/IZZQX6CQBPJL+CqLfVAg=;
        b=YjCsUahrZ8X619S5bXNz2viKVfqpadw9rLIClKsBDssM0MP5urlas3MlQRQxnOpMU8
         1EPJa7UKZbR0y5K4sYSpFFk9YbrpZ6OuVnUFkDnX1Tx0NSQau6s/AlPITwQke8sSaswo
         vAHi0kGSYbMRgg9+wfsWuVUXbpg4oC+7YJgDCkpCDUQQN/rdEwgj4O8U/rpvAiBklSWF
         A45g+fMzcXtnC1Mn81PP30bucvWc5chybx6rLqDZov7SukRD12iqwxNNfOB910TcGqA9
         412keY3Wbc6dalzr0e8ZGv+pCL2peesvHVaJe3D8UB4hEDjvWKCeOfUQ8jZeJcKjpZtZ
         I0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5anKgrXROHCt2c4z2lRBWu+xKr5tcle4vZTMEBD4xLdn3F5ol3/RsByJchYD+c7pOAfmGToM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxurJgbct+aBHrCyDviLxQnGPFmFJERcuOKTYPzJTIWQ4O+jwL6
	2GBWrxIrNqzEjj1YVoxqvbeJvAacLevTqbetDMn806cTH3K9ATkWlUyRD5V5PKolyFWleLU9nut
	Crp53c+wBR9azj8y1ZD9s7r+MwzRbJXGam8/cYJlM0w==
X-Gm-Gg: ASbGncv4HO4Hd8shl35e2uXxNOvcJ9jE6SY4eDmynUohXQAKBDNE+4OSIO0qVp7TQlv
	Rff1d+Ux4ogoZZUKA+/oy0HKdMkmDgiygmsM/BQHStHqRtCHjacAYsF1NCHDVsQGFWa9N3aqgx2
	A8HLTkerb1x3lwR+YembRqLcofJM2RgECBnQl4fBAPAyTT
X-Google-Smtp-Source: AGHT+IHG27gv9karbj1NOogatAO2BrlEvYrLEtmFNeu9XKhGpRsgm/m1RTB+hY9Q08ptcJZaTLUxxE8Xd6aHQ2a8Oic=
X-Received: by 2002:a05:6871:588a:b0:2d9:45b7:8ffc with SMTP id
 586e51a60fabf-2efed430597mr2254424fac.3.1751041696545; Fri, 27 Jun 2025
 09:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org> <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
In-Reply-To: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Jun 2025 17:28:05 +0100
X-Gm-Features: Ac12FXykTIPEyZRenrTTVdLWukedtCGjmkjr6e-4BGSc71M9daw1mwCSL7G-obU
Message-ID: <CADrjBPqdr1NEd+W4ATJ-6Xi36y8Gi_=81LsFNtY_s2-pBPagFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent property
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	kernel-team@android.com, willmcvicker@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Fri, 14 Mar 2025 at 15:38, Peter Griffin <peter.griffin@linaro.org> wrote:
>
> ufs-exynos driver configures the sysreg shareability as
> cacheable for gs101 so we need to set the dma-coherent
> property so the descriptors are also allocated cacheable.
>
> This fixes the UFS stability issues we have seen with
> the upstream UFS driver on gs101.
>
> Fixes: 4c65d7054b4c ("arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes")
> Cc: stable@vger.kernel.org
> Suggested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Friendly ping about this patch :)

Peter

