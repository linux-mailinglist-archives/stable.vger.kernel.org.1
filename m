Return-Path: <stable+bounces-54655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FC90F1F6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3DE283D3E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894A13AA40;
	Wed, 19 Jun 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1b2qQfg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA747779
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810369; cv=none; b=Co1w+Yb6ERnOCfjbQxhpR7tIEortYooG3dAsxOYauReJewXfQCJtb/+dwZi1YT3eLd1NxHXJW2sbosgok6/9oIBNY7OiE4ySWu8e8oZGcMwsoAn+Ni3yteW9D1hZaH22VKFEUSH/Az4fT9GrFsnVm5r1scSznzaRAeapyT9WSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810369; c=relaxed/simple;
	bh=BqsDjle+9R/BpBVsRysfLdG2igibKFPvS3K6gTjlh1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIa0Geyk5Ta8/UKjahmaMoj0TgwyVg0khl+bSBptAYrqoQRiI3CJK5Bz7/YYRr51tI0ZP1DBFu9VQpcK1Q2h12h1OspZ47SM+vRrgk/aJf03/UjtZ0DKTbEVRlCv/UjAK6OzkxEt578PGtsTBSLkn5Tw5zv+jtAx1sZnOahheD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1b2qQfg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so7396a12.1
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718810366; x=1719415166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqsDjle+9R/BpBVsRysfLdG2igibKFPvS3K6gTjlh1U=;
        b=u1b2qQfgz1Hh2D3EA2CGCuYxBfEbR0KB8+SIIxn2as7IxmZuGxi4VIcAHvsssNsoel
         qm2ITpPxSNHxulXLVX2xRkLyhAwPUfnLVVfF31zMJciUWSr4Ur9f5nAGM+2uvFjFp+5L
         yAbqtYmjTzh0R6V2XMj6dsJVrjBOgf5L9L00AbHXc+m9e/jp8siTKrcD43p/6PXrmPgz
         rAD6sageAX75jUXiUdMZTLbb8gE/TPX5Aw/7XPoyEXgMzYJ0DXjhji+DmdkYR3xENsi0
         i1W9d3M/llgNt1FJwqtswgz6B9YKIIGIh6R6rymFBhDnxiHeuIpibprDEgnVar3+gzih
         os/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810366; x=1719415166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqsDjle+9R/BpBVsRysfLdG2igibKFPvS3K6gTjlh1U=;
        b=EwUif1b1tQV4M7ciOhVS528H1FlnXRrS0klMKOU/8q8nHNi2OQu2el63gHl4xuXAQC
         zWDJ+2R9i2BiyKg/la0KUvAkWIyHPObUkUj/PmTQJXu6UiKf5KktXBZcyEaqdFutympS
         UtcgTRQ3EiF5IADE46sD1KGY46GK7mbpoCvUEtLcu5402y1RN7WH1jhB7mAuA36SAOX0
         +Rb1GIRyCR8UymOV9iw6jg4T4oaJYN/ohFDHGxVKYomArr7uFHErpPFeb9wXws3FBSAt
         /XYBoGIujNF2Rza7GRi43qo6FrdCFtfTY9Lly3lE4MGEHL6cECGXG20PXjxbh/3H5Tn0
         rfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF28uOEwYw27dmdazVcBbqQ0s05uYDYHawmAvzU2f8e1qD8J8X2LI39pJQ6dNUD3J5OFBPpYbwjGJbUHcPsLLsdpq4ZVXc
X-Gm-Message-State: AOJu0YwuWWPQsn3Us2K0qrVLrMao8gtFZPmWv2XgkR4Wk/33YBlTdU+G
	cpJ/t8pSHB1trXRiXNrCIH6rIO1kLYazys/f20tuMnHNBEi+ej0X140naZNeJqujB4C2n0by+ty
	b/TjeQRKMKf/TN0N4gWj3SnSeVFl60Toe4u6L
X-Google-Smtp-Source: AGHT+IFDcTDwNtM0NXWgPuz7xOFc/aj+R3JcXvYZnIl96fGEEctx1h5+IfhglJz8m0ECyiYD54fHQa5Ebjrn2xqtv1U=
X-Received: by 2002:a05:6402:2345:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-57d0ec44f28mr201574a12.3.1718810365586; Wed, 19 Jun 2024
 08:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com>
In-Reply-To: <20240619-tcp-ao-required-leak-v1-1-6408f3c94247@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 17:19:14 +0200
Message-ID: <CANn89iL_iaFNUmN8=0zAwhiW9KpyHQQATK8-kzotseC=Cya3GQ@mail.gmail.com>
Subject: Re: [PATCH net] net/tcp_ao: Don't leak ao_info on error-path
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:29=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> It seems I introduced it together with TCP_AO_CMDF_AO_REQUIRED, on
> version 5 [1] of TCP-AO patches. Quite frustrative that having all these
> selftests that I've written, running kmemtest & kcov was always in todo.
>
> [1]: https://lore.kernel.org/netdev/20230215183335.800122-5-dima@arista.c=
om/
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240617072451.1403e1d2@kernel.org=
/
> Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

