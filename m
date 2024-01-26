Return-Path: <stable+bounces-15907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DC83E0DC
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4421C21205
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975820335;
	Fri, 26 Jan 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTL+ze/c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176D1DFD2
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291263; cv=none; b=H132szxoSmztfW97tLKVzZ2n+To+D519bcbuQiidDNZfpIluHMjHNpPBVUNl8JQOIy6OoF6eoVNCfiVmGw2gLn+AHu2xJCgHgOiCuR/Tts5JmKOX7fKIsfv5C67FSBKXeFn+XFecywdlXFRMypkhCE8StGo3sSod/mafig8rj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291263; c=relaxed/simple;
	bh=mo0Zb5IxAaVSxuH7aZv0jdRMwxfn5IPdm6aKawjw1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X38CN3ErpsAGto9jDQ9DEnTuNO3ARXuBXul+TDgky1F21fTIttZrDooucH1d3vEpZH90E68KBGdWEKreB9GRoQmTwA2ZrgCcz/CmguixsER+0JoUEd/Fej3vN/hhydLz1K/c/E9jIAgRKRcQ0B3yqTNO31xI9u+bt1m9oU6h4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GTL+ze/c; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ed1e78835so10486305e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 09:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706291258; x=1706896058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HynQcdHHZlfZlhzBvDS92YNUyRkwcuZt7YudJij5RKQ=;
        b=GTL+ze/cV6CjcTPrY7mXuSajFn1JI27sxp/ZfHmW9cABhTLFo3fW2yTo5XsgMoX8oe
         EltO3malrblZwVFnYsRvrAH8VIp0m3r4dnVt//k7sHWr0RhvY8b+SmejxyU589CDQPRm
         hmT36mfpMPI9KAfiyBReaBTvxV9ZOC1O+lwPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706291258; x=1706896058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HynQcdHHZlfZlhzBvDS92YNUyRkwcuZt7YudJij5RKQ=;
        b=rTtz0gWqrTEaHuASnBZbMS4bzx61Z754v7hCaGaOxMoFrRCYbBRElAUATVuFPfU6Lh
         Sx+/+6r/RxnQ2+FmpklZqbIL/77XH8GbLGwGNb9LMchzqht2XRyx0MUuIoSuQnijgdJm
         v++uTsce04jmGVSIkciZGDGxQLWIZ9h61VV6sNMV1W00/S3SHcrX4S8Sgj9PTPSvTqwS
         RNRND5j1wAQpum+f5D7f+gx2InVzGC4kmUm5Aza6l1Vbe0PPyAONkueWBzdvYd0X4M9V
         /ugA7RU1FLKGuz0I9ktki3pRqNp0A4JcQ1a8zKU/GORu8aj8eV/Qpz/G9X3CJTp8TNzE
         eqxQ==
X-Gm-Message-State: AOJu0Yx4x72aumhYTADzPHgZgpZgxFwRqN+0FDUK6ByHXUGiLWFWyNzW
	yUXKpHU8UFU949mmffTaHgFqowg7oLD36psqUBC+NwydCUx9cWyH6lF/RKlKPwQJWwszpZKtxJw
	hcGsj
X-Google-Smtp-Source: AGHT+IFVn3F3HXpR4kGz2Ookme/WOtJp91Q6m2BJQny3t18N2ctXsOIGqiHYA4L4scXrKgLDzRnhsA==
X-Received: by 2002:a05:600c:6d7:b0:40e:810b:c17f with SMTP id b23-20020a05600c06d700b0040e810bc17fmr113629wmn.163.1706291258603;
        Fri, 26 Jan 2024 09:47:38 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id af19-20020a170906999300b00a3165058624sm845234ejc.185.2024.01.26.09.47.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 09:47:37 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eb95cbe52so15e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 09:47:37 -0800 (PST)
X-Received: by 2002:a05:600c:510f:b0:40d:87df:92ca with SMTP id
 o15-20020a05600c510f00b0040d87df92camr164431wms.3.1706291257547; Fri, 26 Jan
 2024 09:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126170901.893-1-johan+linaro@kernel.org>
In-Reply-To: <20240126170901.893-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Jan 2024 09:47:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Message-ID: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-of: fix NULL-deref on failed power up
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 26, 2024 at 9:10=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A while back the I2C HID implementation was split in an ACPI and OF
> part, but the new OF driver never initialises the client pointer which
> is dereferenced on power-up failures.
>
> Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separat=
e modules")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index c4e1fa0273c8..8be4d576da77 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> @@ -87,6 +87,7 @@ static int i2c_hid_of_probe(struct i2c_client *client)
>         if (!ihid_of)
>                 return -ENOMEM;
>
> +       ihid_of->client =3D client;

Good catch and thanks for the fix. FWIW, I'd be OK w/

Reviewed-by: Douglas Anderson <dianders@chromium.org>

That being said, I'd be even happier if you simply removed the
"client" from the structure and removed the error printout.
regulator_bulk_enable() already prints error messages when a failure
happens and thus the error printout is redundant and wastes space.

-Doug

