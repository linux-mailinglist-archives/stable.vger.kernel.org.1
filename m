Return-Path: <stable+bounces-83400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B0999544
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 00:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBA21C20C11
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9651A2645;
	Thu, 10 Oct 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wa9j1rSx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F41C6888
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599801; cv=none; b=qkwRaIkuDMKzeAHrwcK2e6pF7zGadQbEqIZKJUIwd7Ui1Ludaf32gAk4exKGCWgKQjUxdwGS5G54biIy2H8jn9gcITOjW0sVXUm8NO2eRfzIxDHn50hsV5rfLAR/2Yl52sSMTPfu0Ti2toJnDY0/5nh9r3pPXrMalcRV7Td0Id0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599801; c=relaxed/simple;
	bh=ndGUOdbmf0XLXi5qOt0/OM43ZwpMxj5j0YR7mZtrb0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7x5jMTIduKTFx60oNWy6YYVbuXkVWdgUolTQG2WhOpCTYBtSXOQkpoGr9Ju+tX1A6kPcuMala3+oV6fQxpfTa5dt+fR0k/IicYrmFhWM88+u75BFuKVe757PA0zEuFn6ZboK+UqlhKdseNt2KnkIHrZD8x7U7sDQ4nD0pRLErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wa9j1rSx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso1432820e87.0
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599796; x=1729204596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=Wa9j1rSxtkPuaG2PLhc1lMwrXA3NrJHkqCdfv4ccIwGm28b7A1+vXWde6ATyk9H8VM
         3ggLieKpgCmnkMzSEiC4mkpRH+n+Yqc9+YRskfJ4ygFPzs5jy2kDPypDteNjw7g9XvK2
         tn9N+00xm58W35PV6dmdV3k8h8co4c3kY8tno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599796; x=1729204596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=QzSuib6YCY6n0d0QOiVSFSxJfhYpFdCCBA/8/N+fTR+1YaFgru0U87f0GDgjEiYAj+
         TgUP0W/yO3PJYSD8bCRMCsL72WiSRhiCWivT4c70reeqO1WDVjXLbIpLqLqCjXhwiNS8
         W/V7YFLMjkthgiajrCmXSM7gSa3NRCBw9/8oGuzjCQ6zssWIppf4x2zoN7wduQzSGJdX
         C0UxcDhd+Ss4eaFWbae+P3xV0+ddJ7VXtJZZX12u8AsWA3WeopSeQrO1lIanMR3YjISk
         frB3Buq+hDwZxQjLfJxImIXe2BENiWH2Y2IQ/B0wnuoQf2aOyV+++knJpyuS155gDGaM
         21wA==
X-Forwarded-Encrypted: i=1; AJvYcCW/kCGOK6qAic7hm2I9ywrG5mTRpAGUUtk/2HFk9bA39x8yPKDclB+ht3C13ZUebHNueavf/sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxrqRYG78b3yT9Wrq3Y5EwITiZYK7amEEgzqWTWj2h36FRBJG
	SgjmsqURRCPnw+ajNKSn1boO5+KVUA9wbSjcNG1xPmmk0CzAyEPf1f+CL7GhrFEI4tpIVN/sP9g
	eRHzN
X-Google-Smtp-Source: AGHT+IGBFG/ToQAUlAGwPwIvM0POyl2iCR8kXAz6Em/4TiyWoRVKP5slcvMRs6iRzNzx0BaXK1qHnw==
X-Received: by 2002:a05:6512:b0d:b0:539:8d9b:b624 with SMTP id 2adb3069b0e04-539da5939bemr171284e87.55.1728599795789;
        Thu, 10 Oct 2024 15:36:35 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb90516csm409108e87.251.2024.10.10.15.36.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:34 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5399675e14cso1915290e87.3
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 15:36:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKML4NJN8InqdRjYxqoK8PkobuLTKDrbYeCFXRjkBXW1AUgwkPXPWSw69rh9u8nV2kXsh2YiA=@vger.kernel.org
X-Received: by 2002:a05:6512:3189:b0:535:6cbf:51a3 with SMTP id
 2adb3069b0e04-539da3d5293mr199479e87.25.1728599794291; Thu, 10 Oct 2024
 15:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-2-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] serial: qcom-geni: fix polled console initialisation
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The polled console (KGDB/KDB) implementation must not call port setup
> unconditionally as the port may already be in use by the console or a
> getty.
>
> Only make sure that the receiver is enabled, but do not enable any
> device interrupts.
>
> Fixes: d8851a96ba25 ("tty: serial: qcom-geni-serial: Add a poll_init() fu=
nction")
> Cc: stable@vger.kernel.org      # 6.4
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

