Return-Path: <stable+bounces-83402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C299954E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 00:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C77A1C2101F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 22:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B51E885D;
	Thu, 10 Oct 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CrC4/ZJK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B81E7C02
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599821; cv=none; b=Q/jPhO3VVL8s7ZLZ5Y10FXWW6wUSC32JLxU//m7S9M0EUydcr/1m4ivc1nml3QmKuAbHve8CVKUXAEAFdGB4Cf/IWB4DGGKKdxa8M/UMRJht56gaODyU6AkluVPpMsLP+AlzF9JDa4xcTvMfTFrA1Y7staKHF7Apf4mkD432SDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599821; c=relaxed/simple;
	bh=Oxl2smtTASJ6MycM3FoVyfEsgbMMCGZ1Gfzk4oNcX8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewZd6R32W204Ayi6i7nCr/+aoBgfVH37APMd0pSsnamPeTOPQKIuTdIEH5U6hyAnmMRv7GYUQSw/4+Buw/UQmCJGGW3lULQSumDaZafQmw5DlmXbh1tJgj5Lp9fxoUSfvtD11MHEXkUBJ2oJUJMHPPWpmzcl3MGQF/hPmf6C4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CrC4/ZJK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3110b964so2323221fa.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599814; x=1729204614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=CrC4/ZJK/XRWlvSVjGUOjlnjIiNfYEIiBTWSO0nUFsTA92R/R38QoZ+lQp8yc9RWhU
         mNwNemzpfbJsUER9ohdpJyFvdyS3aZcXYgRtlN4dfNg4AXN1IEQGkBO2qATTgfUKFXPJ
         LHoe/ghN9kxHqBvpxDB4cS2e8c6hcCXphzfhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599814; x=1729204614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=SHyrDPJXs2ZfjOb2qZv6QeWPJfD47hTkpYafWsaXwRQUhV/9HxUK/I7bC5DpvUt3FQ
         js7AITRb4jfTBlbjR9lUsiaPZBLJr5f0Y1rpvkInl4sV7mgkM4xujN3r9boUnO2TZzw9
         1Z1CbUsxPymE25++dRiFKVFDHCkJJ0HMeIt1pKdQ4HQ3gWPPwKc8mVd8W/wZ713BbpW8
         /jBebraY6jj/hEvNJ+7CZZuKJB6bPOzd3VPQEXyqpaj75uI8kMGtb64tkBx3xSo21o+v
         xTU+VolhJJdJnGhi/pse8/K6NV+HXqKUQm07UcOmBhsyRLAbDu1m1DKHbIqEz1c/qphD
         iwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuALVbskw/sH43hZgQVNcWjuuaH94R0xQvQxy4bG4O+t4rG6XZsO60SV8Vo6pQotLtPtiOp4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5G55N1/T0W28oqDkBdvXhtch2Rf8QL+Q27LX9pQ86yJheZ9m
	sejqgjV/lf66rMwPvKSv0p6/CAH0Dx1+m2jC4zvXXh87jSxWCnpQ/gmJx9oinD85DilOwW1aaCt
	WmBGW
X-Google-Smtp-Source: AGHT+IHA31zBTiNl3GQjdqRJzqwFGZK2ktWfKvJ82JhGCAvk4bYQ6xPa7T3gELmk2ul5OxmLweOTFg==
X-Received: by 2002:a05:6512:3a8d:b0:539:9155:e8d4 with SMTP id 2adb3069b0e04-539da3b20c7mr181447e87.8.1728599814123;
        Thu, 10 Oct 2024 15:36:54 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c1607sm409643e87.25.2024.10.10.15.36.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac187eef2so15840821fa.3
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWM445f6KDT0m8OEpTdRq4VzNOnwZ4T3F/5avDNYg/atyIRcFnqFHmD/ddXpDs7SMVKI2zMJxg=@vger.kernel.org
X-Received: by 2002:a05:6512:ad4:b0:539:8bc6:694a with SMTP id
 2adb3069b0e04-539da55f2c2mr163074e87.43.1728599809960; Thu, 10 Oct 2024
 15:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-6-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] serial: qcom-geni: fix receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver is supposed to be enabled in the startup() callback and not
> in set_termios() which is called also during console setup.
>
> This specifically avoids accepting input before the port has been opened
> (and interrupts enabled), something which can also break the GENI
> firmware (cancel fails and after abort, the "stale" counter handling
> appears to be broken so that later input is not processed until twelve
> chars have been received).
>
> There also does not appear to be any need to keep the receiver disabled
> while updating the port settings.
>
> Since commit 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during
> console writes") the calls to manipulate the secondary interrupts, which
> were done without holding the port lock, can also lead to the receiver
> being left disabled when set_termios() races with the console code (e.g.
> when init opens the tty during boot). This can manifest itself as a
> serial getty not accepting input.
>
> The calls to stop and start rx in set_termios() can similarly race with
> DMA completion and, for example, cause the DMA buffer to be unmapped
> twice or the mapping to be leaked.
>
> Fix this by only enabling the receiver during startup and while holding
> the port lock to avoid racing with the console code.
>
> Fixes: 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during consol=
e writes")
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

