Return-Path: <stable+bounces-98877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9A9E61B4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F471884E0A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F42F30;
	Fri,  6 Dec 2024 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wELYwgHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CF819
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443605; cv=none; b=fs0KEaPgyTSTUZZMzOgnwWUyGDNViUgbSvAXKc8qlA7XS5x4/ebSGqiH43usAQUg8DfMhH7usS6W9WHypVyjzHdqUha8wDREkOf0bsHQMfn0ZJyAA4kbsLoyRLaSxP418Cx5x33JTXh7o4gFIZUC8iQHT6ceInTRakYXQC+Tcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443605; c=relaxed/simple;
	bh=Il1Tlrx+OKzJ/PUrGqPeDzuMUeLEedZh2EDsrz5JTrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOmAZ7IqXUySTMARRWDoZwOZesTCkaWc0jYTDXN4EATKf8Af/8Uzga7wLu9dCpKPjE8DYX571+czP/ViQRTUUu91m/+b/Pllm1yY/xLjGiT11hBdBBx4MjHZW9OVQvquq2A1UgwG1WixUJygyGTkC+Ux1dO1hrAZmtYF5T1bFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wELYwgHI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e2ad03bb3so422497e87.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443600; x=1734048400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqZWstnvS5M7KlsauJVlhYbS8zK4ZfCAjPX+o2siRvQ=;
        b=wELYwgHI4qRUqGtPFeTUtv5Dp+Xf3C1VIMY7o2Rq2RGq0UuAV10YXVr3byaTnAte0U
         qNTTOtfKnLEhvcl+1+nOFuBn1HlrI70ZryNJEvdUfy7qimWDhuIu7CZZ/PL4OY8lZHwN
         rK3qwVBsU3L5n+A0Wzmk8EGSGyEDboP63yxCAEOUJPPZz6MWcP5xIrpK6CTB5UPbrFWg
         M2Cd6qpnui0VH3IUiXA/vvdJ+5C+RNW/Bup+Xkb2KR2EYdsHFaKju1s+LfhoaF3zomGQ
         ibqMLlnuh3Dqg8HjmlqyZz54JOvHNb5Mp+uvNSA6SmUPdOuvJqj60O6xg5Bm/AWmo5q/
         ddyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443600; x=1734048400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqZWstnvS5M7KlsauJVlhYbS8zK4ZfCAjPX+o2siRvQ=;
        b=thR/O6VxaAjpbbMZvW5lw7g5hZEaXXwvMBpn4nBdYJxbcIi5Qc2um/q3RRqiFdmfYW
         yg9lEQKLRin97vjCIrrvYH/Gb2ROjw0Uxe73h1k5YJoUA3luSu37QT0t7JEO+IHOQ+7x
         O2icVK1hs0xsfvgrUEEiyhHIqeAX6sCoPSg0sneOE6HvQTF6X0sDnrRDa4GZP3d9P4iD
         Og3c8oNcXiQpwk/PRAQIbH/TO0YNBgjPYGSV3us5z96AkEnOjXSx1O7V0/HC2+FzXhL9
         7KCv+s1lC43x9d+QA8l0NmSwsRNnk+xh6txgPYN4Y5YRvpN1T4YSsjJbm+13+6Rq5O3E
         wSSA==
X-Forwarded-Encrypted: i=1; AJvYcCXY6bF7LSR7/LHCQ6qYz2f9VmzZDzXnnr3wH/eoX58R7qCp2CQekKbhABOrEG8dpPo7aXvOcn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHkwonrs7KEqsJdN7q9of85oVd4ZSPyqiAusN3KJUh+hA6VZR
	SPc0LTpM11W4+6zJR9dD3NvrgryxkF/8JXas59aCpUl32+Mp7Ye9meyNMWm82zyYXZwfoF8rxI6
	Q141dsiKCh7kkbdiUy57haIvWWQDzFCJvHm1Z
X-Gm-Gg: ASbGncvL/tLlNZW9zKURD0tj/sIl6sJSSwUUCko0uQjuSO4f8OptIUWNmt6ARW8SAW8
	m+/57iQSn/SJCm8m5uzOZCRYmibq10g==
X-Google-Smtp-Source: AGHT+IFMKCgNjf7EuTIfzy1U+mxlTHH4A6RijBLU54vNTWXHVXJQWJqIB/kHPOOCzpMc5RVjG0prBUt0JknyJqn08+E=
X-Received: by 2002:a05:6512:4024:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53e2c2b8f76mr213110e87.20.1733443599437; Thu, 05 Dec 2024
 16:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221726.2247988-1-sashal@kernel.org> <20241204221726.2247988-8-sashal@kernel.org>
In-Reply-To: <20241204221726.2247988-8-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:06:02 -0800
Message-ID: <CAGETcx8bhzGZKge4qfpNR8FaTWqbo0-5J9c7whc3pn-RECJs3Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Thierry Reding <treding@nvidia.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, elder@kernel.org, ricardo@marliere.net, 
	sumit.garg@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) wit=
h backlight-lcd0
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@=
notapiano/
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/d=
isplay/drm_dp_aux_bus.c
> index d810529ebfb6e..ec7eac6b595f7 100644
> --- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
> +++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
> @@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
>         aux_ep->dev.parent =3D aux->dev;
>         aux_ep->dev.bus =3D &dp_aux_bus_type;
>         aux_ep->dev.type =3D &dp_aux_device_type_type;
> -       aux_ep->dev.of_node =3D of_node_get(np);
> +       device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
>         dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
>
>         ret =3D device_register(&aux_ep->dev);
> --
> 2.43.0
>

