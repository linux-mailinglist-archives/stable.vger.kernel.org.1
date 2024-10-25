Return-Path: <stable+bounces-88198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDA9B0FA1
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A931B1C212C6
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006F1BE871;
	Fri, 25 Oct 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0zmDbAW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880520C337
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887365; cv=none; b=ZWHKXI7+PusC34ao2KEtr2Rlhy5XDe5l49vwJjFCn720xkqJUG7wQtGabcGTvldX88zY0BCKFiSX/RZTsArJsPBsUTFBXYGw9ZVHDkF+Z1kXJ8+q3LrdOikDK+pTxBdekagxWi2m1mhSGpFKQ54ktEa46YjrNdew//kUFQAFNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887365; c=relaxed/simple;
	bh=HXwNlsDX65qK5k66z7IA8yvdHHI0vAUZEoGmEzH1HZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RL1+qNEkuwtZYlxoD0b37+rPgbwDRzgvuRU32ZtJ7P2d5OnhutrlpjV9QWmn3gbo6xderh1wq26l1uk07nULAJ7qahb813R1iWbO8sOQHkC+0ZpI1xgEvCACrf/05YttrLaGT3THJ29IJdo4AI1wUhcemtO+1d+StfHcrdTzNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0zmDbAW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so2845315e87.2
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729887361; x=1730492161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrfKOY+CFQBFpuKjqQn+EovTIGUgf43WkJJ5IpUgMGA=;
        b=b0zmDbAWTCZoENFtPAIXDx19kkEjUiYrIzOTvABHQIYGBBu3pxEp2j0S4qfISGixYj
         ntC5jhZBiUBDoFkn3crgUlr31E0CF+RH6B19CR831E0x0wkFzf6JGKMrXEHBVfcqpwqY
         92C/Fd8CNuGe9jVVeDObcxE74SNzrA1IY5mCUNIX2ULTl3Vz7nD8tmu1n0RU6s4ZAHJb
         Ib5k4ZGVSGEQEziaFDA725NEJOlJlc/wEDXSnIR8C3RrKybipQmVrwYYzkwq+7B/IDvA
         h2ONgs9jeoSHaO18J1CVxmLAbLdob2bKotMTxwxEfQ5WsqQEIcWFFXP69vDmAyJ5/rwG
         aWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887361; x=1730492161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrfKOY+CFQBFpuKjqQn+EovTIGUgf43WkJJ5IpUgMGA=;
        b=AE/GSdNSludnOWFSRw13DRTbTqaVzS0mteEi/Y9f0vE4jBB5X9Uxr61snKU8GB1+Op
         0L1RcBiA1QrQXZgYMXMfIhFngW+A3P08HhkE4r3amIxPrw/9I3p6sXXHMXORSSrHn5wB
         GsMzZbwCD4PKK/1TekxkApUF3/mQMPm1uM8IEVYlhNDtubiD2lLHP2KljYhIzMxiNWuV
         0UtMalTurw2MCqUMsdT6Vj+YuzTRqPKJuzRxQrLZ/65h8mM75la57+01VSG47Is3UP/y
         DXvHoosuPNFvbVPgpIPR5LbmHDbibGLdar0e9aIcjLT/VUuLtkEulhTgAC9IXrUV1aWK
         TMlA==
X-Forwarded-Encrypted: i=1; AJvYcCV5nvjihth1Vk3088srPCHyUaRLmXj6RqmCyeU8lAOxu9H0RZnOWiiRFdXhM3073+PyKQ5GqIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxKc8szcalgKBJG/ba+l9CL4K5Y+c6TupTNII7/6Nc6K806wY
	a1g+lCJseYBE0SeCQZ+j3Efacav7HxVnQvT1PWXNdI0duw+VkcjR0OS3IBJX2b4Esi3AXCoZpqT
	GobP6TlR6OIqHP2g3n6EFIbRR1/6IEnwK3mRksA==
X-Google-Smtp-Source: AGHT+IFhpeik0nSV3W/KgV00KKhCd+MCqLZInlp9rhg6YetJwEu4kfb6FuXzMeDghjhw01tKCsjFDM0Iin7o1GFcDsY=
X-Received: by 2002:a05:6512:3e1b:b0:539:f4a6:ef40 with SMTP id
 2adb3069b0e04-53b34b395cfmr248111e87.54.1729887361373; Fri, 25 Oct 2024
 13:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025121622.1496-1-johan+linaro@kernel.org>
In-Reply-To: <20241025121622.1496-1-johan+linaro@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 22:15:49 +0200
Message-ID: <CACRpkdYowN4gWohH+Qmp6GAmHUyXNCdA65Uwp_9ii4phrd_+Rg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi: fix debugfs drive strength
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anjelique Melendez <quic_amelende@quicinc.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:17=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:

> Commit 723e8462a4fe ("pinctrl: qcom: spmi-gpio: Fix the GPIO strength
> mapping") fixed a long-standing issue in the Qualcomm SPMI PMIC gpio
> driver which had the 'low' and 'high' drive strength settings switched
> but failed to update the debugfs interface which still gets this wrong.
>
> Fix the debugfs code so that the exported values match the hardware
> settings.
>
> Note that this probably means that most devicetrees that try to describe
> the firmware settings got this wrong if the settings were derived from
> debugfs. Before the above mentioned commit the settings would have
> actually matched the firmware settings even if they were described
> incorrectly, but now they are inverted.
>
> Fixes: 723e8462a4fe ("pinctrl: qcom: spmi-gpio: Fix the GPIO strength map=
ping")
> Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller dri=
ver")
> Cc: Anjelique Melendez <quic_amelende@quicinc.com>
> Cc: stable@vger.kernel.org      # 3.19
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Patch applied for fixes, thanks for digging into this Johan!

Yours,
Linus Walleij

