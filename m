Return-Path: <stable+bounces-198133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E5C9CAEB
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560983A73EC
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A442D2382;
	Tue,  2 Dec 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK4aE4wc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28642C08BF
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701297; cv=none; b=uPO5mSfoG1PqsUTDH+h1PgiewfC8YW0TSN5uhbrbvgLiOC0T+gLzHPD+D/pLxH8We4yxK4Viimd7Qsa/hsMbVlOlJXjYWcS+i3ZL/DiINqJgFD+18ds3xmsH+x7xJOJ8bsNz4a/tYMeOOKT1KLf2UhxLtfercnXsX+pK4fSZ2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701297; c=relaxed/simple;
	bh=qmcfhShQh6q6Tg47kHVH1nCSCPnOjgsMPs/kyL1Sick=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJNcmCfLQ1q+8lc9heBng4ProvyVe9WrpFX7fw1nVrod2Ux/9JK98hw4NPnL6TzoT/qAqTGZmVVWek1bTdE2lLZoHntNnVu8CJ+5FoMaGcL5ZuuqDvSJyClVMdjtde9yXfHpKl3kxtycub82+XG3YxkR51rR8GarpxaGRkR4rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK4aE4wc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79b9113651so289739266b.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764701294; x=1765306094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK2nhrM29O2hgg2Ta9uM55oXWMLeg2yr8elEf68PO2E=;
        b=FK4aE4wc33gtpKoj5VGypbgR8T+2ecMIE0VhF+9S3A7zr7e7wVqR23rke+VLuRmRE3
         bcbTr4skPBweB3ZLW5fwzUCNvlUznpCHf9ybqnSSblsgZPx/XOGizIOBV/caIOvD9ceF
         8hVt9ZbHdmNY3FyAp7d94iI0f03btXlWuKT64gTmx/s4Wv437a0NNzneKb1QWoHpOro1
         X2STTZk6lhQ/+rdsCCOvkG+zFydyKbUW7V10n/KTQG+nJZ8QP2aM+I3ToedhMtJ+R1lm
         RTf1dKf5VapzdsIfog1TFpF8YRn4JBVgYeJk4bMJPcGBkU8MQtfy6l+uXq2PibmQo/w8
         Ee9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764701294; x=1765306094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YK2nhrM29O2hgg2Ta9uM55oXWMLeg2yr8elEf68PO2E=;
        b=i9bnZv/KQacQyc54kkVDrFeil36nJOn/4QApblY4kO4eOjxpJk9onFx/kNHhYd+fz1
         8j09nHvQPsZN0nQ+aO0GMB54zcyGVbrM6qY9lHUEbWlKffCXO+lzpp7b28P6EKZ/v8LD
         gk16j3Vp49Tm3Rg3sTytEVjI3d9b5J2PWeVGAHOKPCVfBNgsU4KQl45SUhNmmOOVZ64I
         WgR0CjLj5LhXb87scAej8S6nIamw/87H2VAfAoH0iECemquThFwHcnpxjfIqjPkFlIfr
         thSL5uAplG8jDsz/Xe+3rGrWFjmzSkLkkV41HaLkx3qkKcAsxWZz+rIn9z2COzA4JAG+
         qQlA==
X-Forwarded-Encrypted: i=1; AJvYcCWvhRxC2zRie6Wb5u+tesOFNJXDZ+cQNdog1mHxbPgTaW4OeETjVNV1cg2c19V7EuOPzOShEgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwe4Q7wvaT09Z5o8WnYslCQnO7DFhPXnpvChs34mUjnX08odf
	55xIGZRhbzdTwHKa3HbRZRKXg9U6iBKzugp5JpXgD+01fiMguv5NCipiZrMq7bnLotFhVUDfdH7
	obRy50TDFjd2NxpQDS0r27M7+IgokLmE=
X-Gm-Gg: ASbGnctJJzpBcVq7cl/eOnNzliVfsvHeb3clXamMsLsBj9uoaE3HQ1rzz9BqXGltJr7
	OCsEL2V4/+zb7hfXuTahcdrDg0S/FEXUsuAX3CwCj3QJdgDxlMcpS20CLeCJWYiDHdNYAZkJ9g3
	9DlabETsZW5PyNy/qdHTcLIkdCIzu/+mUJnUm4vezQtG9d4npyArwMRnrlOVKb9JcwWQ77vgxsE
	MFe1Ew66FAGNb5mfWcmfZGrZFfJ/uqYm6J4QjcC4p1J6VsE9ZBdmJ5r+udW7cH+WP67INXi8UbF
	l3iScF2ij+xAAe93DSgq4WRNH2xIRKKALW6XWqrlSgw7RIg8ivzbN1rWaldaPj3TvlEflypaCVP
	ANCaixA==
X-Google-Smtp-Source: AGHT+IEde5Ne2FWmn/NCQ+IRx4n/GD9c9A5QSTODzTd0KanvaOIf2EO3FmVJ55kB63cvLDvHqezaxI6V2mbDnsSWA4o=
X-Received: by 2002:a17:907:970d:b0:b73:8cea:62b3 with SMTP id
 a640c23a62f3a-b76c555d4e4mr3503240366b.41.1764701293826; Tue, 02 Dec 2025
 10:48:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202181307.510970-2-thorsten.blum@linux.dev>
In-Reply-To: <20251202181307.510970-2-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Dec 2025 20:47:37 +0200
X-Gm-Features: AWmQ_blkY4KethoMOw3VYF_HN2LLZpgOJNsEjED8qY3jBtSrhG66YIa0fXVjIf4
Message-ID: <CAHp75VebjUo2JH49tmuOvgjKUbsUmZg0C461wwvL-bRaDd5C9Q@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: PAC1934: Fix clamped value in pac1934_reg_snapshot
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marius Cristea <marius.cristea@microchip.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:13=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> The local variable 'curr_energy' was never clamped to
> PAC_193X_MIN_POWER_ACC or PAC_193X_MAX_POWER_ACC because the return
> value of clamp() was not used. Fix this by assigning the clamped value
> back to 'curr_energy'.

...

>                         /* add the power_acc field */
>                         curr_energy +=3D inc;
>
> -                       clamp(curr_energy, PAC_193X_MIN_POWER_ACC, PAC_19=
3X_MAX_POWER_ACC);
> +                       curr_energy =3D clamp(curr_energy, PAC_193X_MIN_P=
OWER_ACC,
> +                                           PAC_193X_MAX_POWER_ACC);
>
>                         reg_data->energy_sec_acc[cnt] =3D curr_energy;

Hmm... Maybe

                       reg_data->energy_sec_acc[cnt] =3D clamp(curr_energy,
                                           PAC_193X_MIN_POWER_ACC,
                                           PAC_193X_MAX_POWER_ACC);

?

--=20
With Best Regards,
Andy Shevchenko

