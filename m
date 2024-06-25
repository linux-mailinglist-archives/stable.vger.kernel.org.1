Return-Path: <stable+bounces-55799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837629170EF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A1282F35
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD617C7D3;
	Tue, 25 Jun 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSv52EjU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0517994D
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342680; cv=none; b=NB57HDfXACCw9ljZue7bWiw2GAA38kzWpwPbh+iwZjSu35AzG4JRpDkPK1asuPdYZZE3PsuvplIR41l09kR4PlM1Ki69XFmvMacJ7B1qx22hWvyVy6PJjwQ/0m7mgJSLAXfWbPUyBwrqbGMdyFZXprxTJcDWPSTy7tGn79JYNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342680; c=relaxed/simple;
	bh=QI2ST9zJnwwGQAo+/g0fq3WqKLv1e+CPcuPVWLbvMA8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BoNDcplKGQ/nRDvE63Rst8G8u4AHNYseqgiJzBeN9eaGj1KzoB9gp+q6Dm5cFqAwHzQng5nC0JNhGETeCCyVGHwkx8e9fWT1YLOuVj7gkkcOE8JHfCwwNpw7wudKwD+2mIN1DS8su34YBkpcsQAsK9WDHyWwrbTIyZnKWjSFLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSv52EjU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifx89QbqNTvqNTqVFeOnhXLP0jmM+ngsCZbnU659x1A=;
	b=VSv52EjUHKR0/ZvP77C9cdnDN8v5iTEU8VopdwfFmtHtLiOWp2UPdZB4ZCSNwigp96avbN
	zsKRHoA0Mn+3YsBpqwgGM/eHel6Og/PJyJUsmuJGUffunIcZfecUp442j9jqiAyquAQhto
	lDysg9CtfmVcOQ6R0MVL649zFesmOv0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-tYQf9ox_Pz-lYzfvega6kw-1; Tue, 25 Jun 2024 15:11:15 -0400
X-MC-Unique: tYQf9ox_Pz-lYzfvega6kw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b571da319dso13661486d6.1
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 12:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342674; x=1719947474;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifx89QbqNTvqNTqVFeOnhXLP0jmM+ngsCZbnU659x1A=;
        b=YJHy91zygvEPXENVNo8oAbziZFZJ5lU2UQCzmQNIjeNVnLxXSKlPSDaleZ59xrFFVx
         tYmIYu/NHg9l8vaHogrlfP2J09tAWXux/hnqtHGOD5MsBUO7kmX/na8k0rLMkDRqt/WP
         SbWH6LsqLolG3HpDk76coXBjxH70MxDnkTtw1NhB94xtA1AorOuSqcI/KxovEQzEQ7B4
         kAWE7ZoJ8IclbAML05MuxfudBIX0bfx6f/0BkkcJduBoWBEumIVybPlbkk0HDxcEvDGg
         8TBSVBfFeplIr4+TA5jIdrExgWJAlfI/uWuF2tisEt8uRecn9F8dwpn1Xm8ZDyd5itJ8
         0Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUimocfw3b1ZaKxCAp2HH6alcdhuIM2Cyb0BLcUK8gJfn7cXIRreWd9VPSLTNpQXwQ0r3WElN2hQlJCMooAanZvJE3z0siX
X-Gm-Message-State: AOJu0YyEYp+ZRTNGKtkxevUYt9UV7Pz3YFYL3WpQ4CR/ScIzAWu4Dfn5
	JX7bgL0bDxRZxQRoKBdrhqXgX6gcdh183QoF+0fcGzP1U7bY/ciK4BLlmZA5VekUv398LDYuOwA
	kq4h5qK5MKPn3qoRPy7ApEWEWj3AXCoekw3BbcZsL6qVGgnLa4INJtQ==
X-Received: by 2002:a0c:ac4c:0:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6b53bbd2640mr88923756d6.39.1719342674602;
        Tue, 25 Jun 2024 12:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Jt3WC0d7hZup1taiuXs6wrI0vbXesfenzHXw1GMzzA+zIlNjhXPp/ZyUSjSvtzxHI6BjjQ==
X-Received: by 2002:a0c:ac4c:0:b0:6b5:101d:201 with SMTP id 6a1803df08f44-6b53bbd2640mr88923626d6.39.1719342674299;
        Tue, 25 Jun 2024 12:11:14 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef54a9bsm47185826d6.112.2024.06.25.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:11:13 -0700 (PDT)
Message-ID: <2020b1333c0f0be49648b81ebc4b55f3abe0a2cd.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_ld_modes
From: Lyude Paul <lyude@redhat.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, dakr@redhat.com, 
	airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 15:11:12 -0400
In-Reply-To: <20240625081828.2620794-1-make24@iscas.ac.cn>
References: <20240625081828.2620794-1-make24@iscas.ac.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2024-06-25 at 16:18 +0800, Ma Ke wrote:
> In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate()
> is
> assigned to mode, which will lead to a possible NULL pointer
> dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..4a08e61f3336 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -209,6 +209,8 @@ static int nv17_tv_get_ld_modes(struct
> drm_encoder *encoder,
> =C2=A0		struct drm_display_mode *mode;
> =C2=A0
> =C2=A0		mode =3D drm_mode_duplicate(encoder->dev, tv_mode);
> +		if (!mode)
> +			continue;
> =C2=A0
> =C2=A0		mode->clock =3D tv_norm->tv_enc_mode.vrefresh *
> =C2=A0			mode->htotal / 1000 *

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


