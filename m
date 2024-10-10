Return-Path: <stable+bounces-83401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF05999547
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 00:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561F61F24621
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E001E47CE;
	Thu, 10 Oct 2024 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FsKFA8us"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3581E6DD4
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599812; cv=none; b=uJDNzcTxbQYN8lTMe0oFWLtojoMpI7O2jy8O8Nfwo6Fjfa63hnh2wQHK1GwzanjlK7rEfcSfRkf3JrelfT+X+dlgdYyDnaoOmqOqA9dbM5tZLnmGAJyw8a5mbT9MqATsCBN13sdKci5IwC01HhxQ5g8Xm+f2chqEuxdZvjXIjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599812; c=relaxed/simple;
	bh=S8MzrVyVXYrrKDN3sreSlr2FvATE3GpWfAgeOexSlnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbWW9UuVG4IxihJArGdWY841i0cUABgHIC9LE5ISWlM0hOLvBFR7f91m4snPppRY29gNxU/e9443o5PiMtFmenqmBx1gD+JEr7UGGs2VUlpCM3a+3cOu7Jo2foew0AfUfG1zJe2dnBKj6gePdERgJgNu3p/2cXlKOT7tHqdXqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FsKFA8us; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53993564cb1so1793516e87.2
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599808; x=1729204608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=FsKFA8usXRJX97+bdZbl6ozfWfzewEPBAlxnb52EG3I9UHvlGeUj6DyrSUfmcKVzX0
         xKXM/qK+hxStXMtt3j6viWeHQ2j4RMnhKFJ/F+nYrVwNslaYW86cdqgAhFt5IPkTULvf
         vca2/f3JgNNzauQtYeC1M5tJ9iXmKZPV7qGmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599808; x=1729204608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=sO4jz97eJ5ETHuPGDB0LqCRk96TFI36FylILDwhJZ9q9P1qYLJcu/h2X8SM7I/zhrT
         5TMbm/SsllntijWYJTHXVy1r4F9l/bzRX8fE77EAowYfVnst5u3NXCmTzJ7QF4O0C5sG
         Pf9IMuey54F084gg7pZof8aS0i2x/2LKbO7wh/XOxCRoc1blEDDqMLNTonMhK/ncToDi
         cGz89eGLWn2NvtGv0aFhd/rHmKuHPIfjE5jVFdbeCZ2e1J3Py8ghqlmIics1T2zTEE5U
         Yzd0KFDPLnEcjfxmH3/Lb07colDu+f/6CfkaYYpvdN9OfO4EO1nG44T/pY6d032o/5jg
         L9jw==
X-Forwarded-Encrypted: i=1; AJvYcCWTldg4FV7dY2kYv7pGlch+Uo2hZNhVB1aBHv15vX1/OM9kUb8CbdNQcB9UKBqCoIoy0AaM5eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncOkgSC6HKpXXNJh+6iw+xZUG94cn/f9HM4D4k6xRFtEX/aba
	StweOZuV4gsSua/7pmo6hbrz5Q79DQZa0eMVorsEBtp5TWXvXwLQrE56QUU9VOizdpIByfEluAN
	z8DKs
X-Google-Smtp-Source: AGHT+IFdThhXeI3SlXeorN87o1AZYvSTO96iSbN7bjRISBeknn33KwaAyHTfSQKweveEFqbMI6N6LQ==
X-Received: by 2002:a05:6512:308b:b0:535:d4e9:28c1 with SMTP id 2adb3069b0e04-539da3c6e43mr150290e87.20.1728599808369;
        Thu, 10 Oct 2024 15:36:48 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8d8069sm405017e87.148.2024.10.10.15.36.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1839429e87.0
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ7jTCI3A6/XUBu4pN+b2Sca9nwNpPe4oNmW4/nxlK+HP5NT9ZlQGvd3w404SNixXTk+FnfEM=@vger.kernel.org
X-Received: by 2002:a05:6512:3091:b0:52e:9f6b:64 with SMTP id
 2adb3069b0e04-539da4e09a3mr158626e87.34.1728599806982; Thu, 10 Oct 2024
 15:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-4-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] serial: qcom-geni: fix shutdown race
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
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 ++
>  1 file changed, 2 insertions(+)

Though this doesn't fix the preexisting bug I talked about [1] that
we'll need to touch the same code to fix:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DUZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z=
0jkH4U30eQ@mail.gmail.com

