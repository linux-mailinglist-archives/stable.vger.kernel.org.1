Return-Path: <stable+bounces-98206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324099E3190
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF50916826F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CF54765;
	Wed,  4 Dec 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM+jVT3b"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFCF507
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280346; cv=none; b=P2ezuGZumq4wfQFq54/hFX92iV9FSn/AKWT1OubdDn2BewHWejTJ1yYVxE2wcWEyclUvuGuWIWh7mBZ8jvET+uZMJh8Fr+1KlpAfxpp/NpQO0yN/NXW6AJIvrfQtbzN3G/C52Sqz+ErxZVPyLq2vAS9OE/a237ZEE7cHOmX/8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280346; c=relaxed/simple;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5SR+EFx61IQVqYF+bi1yDTPzyjduxytUDminD71rFCB+njzVGamOYoWGadZMlUkuApMviq7yEmoIy5zqMxg5Ndgf1v7+3lGgHuLSS9Vq/sn90XHtnQCem1+GmCYu31hVIgzrCSMU9/zQLlvSuG0Yw/tdWasu+NRjrzlNFMNza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iM+jVT3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	b=iM+jVT3baJLnfuEtxTLnmWsRlHQGzlYlsYA8Y6/Q5NnjVPUk+Dyvlwzxl2qvaG6KiifLl9
	Xdv18RtQtoFYEounDnIFPGjTDQ+3MyaG5u+VQugwI7yMfU1/N4aFHoBIBPCRuxUaddrM2r
	QJ30NGanOTFhReveTlOQCh1B5VJlFYo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-HPkO41hQMlqNKjfZAP6n_A-1; Tue, 03 Dec 2024 21:45:42 -0500
X-MC-Unique: HPkO41hQMlqNKjfZAP6n_A-1
X-Mimecast-MFC-AGG-ID: HPkO41hQMlqNKjfZAP6n_A
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4afadc82021so64543137.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280342; x=1733885142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
        b=GTAUCK3sdmOMo37hvVuWnvXpK9zdkTzmypqsn9JaoQayfE98UG9ilzHy2jRxijt4vW
         jr4Z/OGaOiz6UbyyfWUiEG2XzkR+d13PQN6jfmNH14EnJ1Yi6Rrg4XzBb/1KFZ74tk/G
         +vXxER82/IvysKx7OCWnJGqCkloAWakYbR1/oH7cVOZK7g0xdNJbOMXhjFqoaaRP1kBm
         n9lWGnNMcRyS1HxqGd1ytTTjrUVYOnmO0d9EikNvDylDLHpk41UiEQWsJcJUZ1b64ZAZ
         3x1SI5E0nTIOTboIHiRzzhyT6QKgUplKRZkGTmLIIMA8AUHIQbEPd+5/8qCrOO7sRDpH
         pECg==
X-Forwarded-Encrypted: i=1; AJvYcCUEeXKZj1G2MiRTVLfNUG5GJ74sQrIHqmoYRwkuA2G1LtykalVUUDg0417s5dWelwY/hyqrUE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybk4reCGh3sqeOZ+roXgRWxcoVPmhCnAFmxzAIoPFI8aOAYinc
	lD/nnQzDIwoHDpaotclRXOpzdoW1qHhzEWVbYPU9bOSBquh7WJw8Vcp3Rs+hXL6LoOXcy9tlGXx
	RJAfwD4RsmzGmCYIVfLBNJHudsB/TbfAk/FVW0bqH/zy8R8V03dCeBuAC9kUZn9fYcnfAFiW04U
	X0S5HSj8h6S/LZSo+q8zCyRzhPirVV
X-Gm-Gg: ASbGnctKUZNV/hH73aJyOXFvjn08r67UH/n9hJ4TuqB8eATd2qMIoeL13f5QHnJqQk2
	xoUiznPLOdgtfBc9BqVNQI1r6YlulqXWC
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id ada2fe7eead31-4af971b193emr6430666137.12.1733280342251;
        Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+v2rQ020MNSJM5uPbSBJm0D0/Db89xQqRoZNc5welU5BaKs9HJz5sd95RktgMEEi3m5Dwg3PuqbEbHeQzKSU=
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4af971b193emr6430646137.12.1733280341977; Tue, 03 Dec 2024
 18:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-4-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:45:29 +0800
Message-ID: <CACGkMEsd_fVOFcFGmW0g7DbD_G5cAudWuxc9LD9PNPm=HvNHQw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] virtio_net: add missing
 netdev_tx_reset_queue() to virtnet_tx_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:32=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
> be reset.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


