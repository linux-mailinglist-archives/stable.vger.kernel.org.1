Return-Path: <stable+bounces-41444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF478B25F8
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED63E1F21295
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D3214C5A3;
	Thu, 25 Apr 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DkC9S21D"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB414B09C
	for <stable@vger.kernel.org>; Thu, 25 Apr 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061131; cv=none; b=u2w7atyA+A2d09A3el/hS8tlz7qLItX4W7qRAEEgyF4wUZGNZ4dUBA7WSFNHc757hs90M+lgtgSYbJUImVoOz4VhgtmCR575k985fV6PzVSmgLV9aeBoe3fn2tB1wD9xTMseUztyzPBvCnqbF38invwlYiPcHJR6Jq8Xs7MgFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061131; c=relaxed/simple;
	bh=ma3KkjWX6NDzygZRbgCm5HEg8q6NeJy/w77N/3RnFoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8QHD+M8HhHVW3cmRhjd9G09i4lTKa+cISxhMiYcD5ITYN3iC/eh4SCr+7tmFbjUiPHGeS0Ot/bz+x6ANkgIfZvD1f6AVqXUwUJV6V609KpCz0EvbyiGWjSYZnogiNHtpC3fKCoXrNr6zPTy4Kw+Mv3F5oTfrk3/bZ+UcEsw1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DkC9S21D; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78ef9ce897bso73869585a.0
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714061128; x=1714665928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqoFEBYGvr1CzCDNq2rYrl60Aa+Kl8xqNL1Vi3kFg0Y=;
        b=DkC9S21DgsYtrvfpLHjTJE8a2SMXYRUkBj407GH4yQ/MmXdH/KfjRFKgwyJb+TTfoP
         RwwgLRzFp4lRn9V1aYc1YXPS+EysaUUzQ9Vw1fJnk2T6fJR5+oQEOmf6O558Q2IPNzQf
         kDls+VJXkBl9Mib4KAq/PmnEmSgMqiyMt5BUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061128; x=1714665928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqoFEBYGvr1CzCDNq2rYrl60Aa+Kl8xqNL1Vi3kFg0Y=;
        b=xVgHHLzp3rokKXejf9eL1UpwDiGcTctuAV+TslVClQ6ElDh91f79CZ1FgSt0QK+pq5
         mldLUbrZTbAFxh9PBgQKpAvCUnjCcE5YUSI5mupa3SWy8jibejTo0VsePj6AvV870GDL
         VkgxvEN2ol88EpznX0kkr5IujYeY01dTmOGqawQ+S+42jGAtkEHOV0EiXzw+nnNatBaQ
         W1bpzKSsFQaLvWSQ1pziq8TL54I6uOAkL1Kh+IJglisV9PgNhamI6FCE/Xy8vE5fY5zw
         bpnGWuC6BNhyTKulCGcJwJBdYNaEWPBg5lP3swKNBKRkyQBVEhIxxaWt+F3svpO/Ffm5
         Gm7g==
X-Forwarded-Encrypted: i=1; AJvYcCU1StMVyBZSWq8Ze3WGXa2YuDNiFPykW0W5Nrl8iydGhmNjfw+HztjnXH1WAnFbgHOsYg/fZC5slo7TwCjNjel3zb8kAAo9
X-Gm-Message-State: AOJu0Yy3/uhz5yeTybDkyfLehF6lQIpupEsYP6O7K1jURRXll2/hhh9y
	IASKv1WdtaNpuTd5qC5/fETEVLrNmX0H2Qwn6ktlZRu1TysyKI8EDdhkDXN0IDbCt++x632QXKg
	=
X-Google-Smtp-Source: AGHT+IHifzRg5k0wJ4FyOuvcJZDkX/dfppW3H39t69VOLUG7UdCLqfHbbDzRBZ8bPqRXGDrSty2+Pw==
X-Received: by 2002:a05:620a:802:b0:78e:22c:c82d with SMTP id s2-20020a05620a080200b0078e022cc82dmr1351qks.36.1714061127563;
        Thu, 25 Apr 2024 09:05:27 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm7175119qkp.97.2024.04.25.09.05.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:05:27 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-439b1c72676so472071cf.1
        for <stable@vger.kernel.org>; Thu, 25 Apr 2024 09:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHNjaQSzJlgjUOEbrn7y1vVZZoRf1vvX50BVDSwMTH1055XAUtPVAcXB1oMycp41aQmgrnzHmrAJdSjp1EJGmyiot2t7vK
X-Received: by 2002:ac8:6782:0:b0:439:7526:1d80 with SMTP id
 b2-20020ac86782000000b0043975261d80mr330416qtp.22.1714061126221; Thu, 25 Apr
 2024 09:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425075503.24357-1-johan+linaro@kernel.org>
In-Reply-To: <20240425075503.24357-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 09:05:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xztc8iYawafEUHOJ3e9=TrqJ4dgCfw8hC92xL2Dow4vQ@mail.gmail.com>
Message-ID: <CAD=FV=Xztc8iYawafEUHOJ3e9=TrqJ4dgCfw8hC92xL2Dow4vQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix wcn3991 device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 12:56=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
>
> This address is now used to determine if a controller has a valid
> address or if one needs to be provided through devicetree or by user
> space before the controller can be used.
>
> It turns out that the WCN3991 controllers used in Chromium Trogdor
> machines use a different default address, 39:98:00:00:5a:ad, which also
> needs to be marked as invalid so that the correct address is fetched
> from the devicetree.
>
> Qualcomm has unfortunately not yet provided any answers as to whether
> the 39:98 encodes a hardware id and if there are other variants of the
> default address that needs to be handled by the driver.
>
> For now, add the Trogdor WCN3991 default address to the device address
> check to avoid having these controllers start with the default address
> instead of their assigned addresses.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
>
> Luiz and Doug,
>
> As the offending commit is now on its way into 6.9, let's just add the
> default address that the Trogdor machines uses to the address check.
>
> We can always amend this when/if Qualcomm provides some more details,
> or, in the worst case, when users report that they need to re-pair their
> Bluetooth gadgets if there are further variations of the default
> address.

I can confirm that this at least gets my boards using their proper BT
address. While I still wonder if this is the best strategy to go with,
I can agree that this is an expedient fix to land it and works:

Tested-by: Douglas Anderson <dianders@chromium.org>

We can continue discussion in response to your original patch [1] to
figure out if this is going to be our long term strategy or not.

[1] https://lore.kernel.org/r/20240416091509.19995-1-johan+linaro@kernel.or=
g

