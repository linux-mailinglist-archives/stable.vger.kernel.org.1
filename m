Return-Path: <stable+bounces-176967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63757B3FBB7
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343FA2C2A0A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387D22F290B;
	Tue,  2 Sep 2025 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKPL8Nvr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493F2F1FEE
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807411; cv=none; b=rXXpve16vUMgMcyuE7xV7FQW4/xlKoX/QDMpjvmerfsVUDsSSqJgGayzCDCjdlCokN9LQGCZWy7VNnbAFJaUdiyVPOtzYmnWlS4ncE40sR/YVi1m0+7d9yHJMlGpHDvbP+tZjFjRVpMhEs2gEKddqvNIxjlKcb+Uja7BMi3DJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807411; c=relaxed/simple;
	bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHhCQbKfNAGs2PiBXqb0eRXnu8KtM+4PmAQ1TAc291OtUu5bdC7gdgTjdKeHqj8RgW9Ee1lcy3foxflK6vndFDWru21mn7v9Q7Zml7ZYLWMOI7v3VLGGRb8S76hbri87ZUA/UI+cI8QWdp0CgMN8huks/w88Bl52AbRNaEi2OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JKPL8Nvr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso3529626e87.3
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756807407; x=1757412207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
        b=JKPL8Nvr1t8aJ1PNt/35It7dkYt5pQZa023xPSAvyWqItoR3lwVnz4nF5tna3rs+Ou
         1k5JQ8bqK9W/rMsW0zhEBjQW67g5JAeSne/NDhiYZY6UOxYVI+nYg5deydTeU++UHbE6
         yzHEzRlieXIMiONQv2ovW1LrVMp3Q4+MZTxTwGrclhqNQ/Hj6HEq3OWbBlAzqzwGkSzQ
         VQ0PdczWInkY/ZYRF0gVtPXmBUsPeataa3qrcs9cGzcU1m5TN3OrCHGI9ey5SR2FUhJh
         LyZ4GaYecdcd4imEENmNQwoz12omr598xDlC13d7zaLotnjyE0ZcFC0RmmdlLVgUK3Tp
         t6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807407; x=1757412207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMt8f1svkhZE33FXRLY0yAkh9fTWrIdcWz2YobDS3hs=;
        b=u8yMPl/75dzm5SfKDtSQdZgD/zhOZXerEvM2RfjC81vkqrWu1MF3ajgCqpYceqM6Gw
         hLerSbbAtgageeoX0xLzwgegmoYp83cAbgsnTx2jEBcndexbs6aZV/8aQWoHHHsqE4hA
         ywdw2CRZcBynMYLHYnt4yjyUa+SNm/DYsosIEtTVamabl9tzh/zZs6vxc8snGXW5wcLC
         W1bEvIUqECBGptORu1rwHzG3//yKutIiQ7soVLyWVA7qJ/T2XVFxWg0wKOc7KlrAA/3s
         XSXl+1mew49NEIQBTlQst46Zv5sYHobI7OX0k4o56fQpZVxmIaDyjSYgwxsAiC1yaFAd
         1ucA==
X-Forwarded-Encrypted: i=1; AJvYcCVXM/gl901vqe90cVk/wmo0YGLCBmx9nORnzRMK+wpCut3T6gLiNUI6nWNljXzVO77c57ZrSMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEf/DspQEM8O6c8cFNQsRKSVmIoHLpkneV6CC5pbCoe0XJEJD
	aFp0z8nWUtA1qGi831HNU4LRfp7Bd0lL2UMjHgqxLB3+k09vpcWS1WeLzx9oyxjUWdLAEDrpy8F
	Xe85RrWIzZ20QwT4ag/vrWQY+3QEZK0Q8TNsG7k37Ew==
X-Gm-Gg: ASbGncuc+64IR/MXN0kfnUB69BQlHro3OI7Hs08MoA7pQxhz7GrXa9ndoAMr4Lv3l2d
	SH8QckZ/IjUhpVupgPrleNJGv0AYQj3vKu1+NFWf2aP2GrWIeg/um4DqpZSX4j3qncG/xvUkeHX
	GLDbZrMogbWHCf0nmTHjCBR5zLtpW2mNBjSzzk2VeXpiKwvqVYUuapYpx3qbBtFkpWsYyg4ywpp
	3MaBqyMgV3n2vxJGw==
X-Google-Smtp-Source: AGHT+IFdHvcUVxSylVwD2vnKLU9FQTJFLwj42u6Z7wlm3bxT33e3D2bu+wc3U3jlI6g8xaBcDAr/McPTMKQVI/EszFU=
X-Received: by 2002:a2e:b8d4:0:b0:336:7121:525a with SMTP id
 38308e7fff4ca-336cab0981bmr32752001fa.25.1756807407065; Tue, 02 Sep 2025
 03:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org> <20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Sep 2025 12:03:15 +0200
X-Gm-Features: Ac12FXx83c_FhzzXPFUThYNZRpQMbuI8Pyqd_lvAWb4e0eyemL5lMdz-E0s3cCM
Message-ID: <CACRpkdbLoa518Nu6UqFcqgx5fvqv9Uj5o_etybO+sxZpDQ3_Mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lee Jones <lee@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> removed the return value check from the call to gpiochip_add_data() (or
> rather gpiochip_add() back then and later converted to devres) with no
> explanation. This function however can still fail, so check the return
> value and bail-out if it does.
>
> Cc: stable@vger.kernel.org
> Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

