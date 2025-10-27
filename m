Return-Path: <stable+bounces-190033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42717C0F3BF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7ED4664A6
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE8B30DD2A;
	Mon, 27 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsMdE0O6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554A27C842
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581080; cv=none; b=V4LFSth5bhhW/MT+J96OqBP4kN4gP4RAUNab6Yvsd6RmOc5a11TGwWtWdbEEvE8EDXS+N9O9vogbaDvPslq0Uy8pYCKjOmwBYZYRCHkOJ3/kr9geDR9xjHSyhWVG0byQtQMLUKZgmmkhziWD0bmXzkCTEl+2AlttGgYvZQkR0Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581080; c=relaxed/simple;
	bh=2063pxklqusQxNqj6V9Nfgba5zH13grbuHqPROtkanQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P15lUal26aqmZJRPKn29RtQuXQYe2ujFMg7RkMbi3M52tGsNVoIV/q2DQne1WLjMJJMKLVccHUJV0MOKv3oOXz1CRLjwHdyFGUvUqXPrIx7YEV9O3sLi/1AdvPRA6FXQcIkfibZXOyh6sXbaLws7u+TKQKV9M7d48V+3Nd8QDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsMdE0O6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso13867375e9.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761581077; x=1762185877; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vg3OblHUFTR5cgBEbwg1qfvtW4LF0GYw01JmGM+cw2g=;
        b=RsMdE0O6aZjQnfFSjEuA1wyj2NmIl8Ts0i5dL9tFOwWDKpOOnEIk8zP5Gjo3c/5jTX
         00feD9igIMWQb/u3cE3wGvtIELjgU6fiFf48O2ek7IKvB20fFmeKvvtJPSTn2X6V7qhr
         oRWmXFXWyZdUmpRgeEgQXZJo4U6srcaQUhs01UQz1kt1TMVVJIGSauCOeQ0B7DBSzry+
         AtYv8iwue0vyOxaoMupAuAQ5et3VduAkJQ59yk3iYTbo5+4779h6y0+QWPi+hW2I5sZO
         TLnEKANCi3IX8YkJIlGH8G2dSjpQaReA/K+KO15Ql/PypL1POOq6MX0Gyvco31KF7P7m
         /f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581077; x=1762185877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vg3OblHUFTR5cgBEbwg1qfvtW4LF0GYw01JmGM+cw2g=;
        b=qt+fnEMbg/XAQ4RMCLMhkT58K/gdHwR5Uhdx6LASeRaJcxwphlAaeVhDZZknXaj5/P
         ndVIjN03ybFyWkPM+zvc9UWqDFFB/IrJHCYkKzH0ake8Z+9ua/27EPYAWvkXk3mkcGHL
         RRBXD6FeLc/1jNjqNgk1q5OTFqK6/+uGG6d52W4qt2MwOU/2gGFAtkJWWVQoDVq9LyDv
         H1bSQ9qX9qMffHko1adCURT9YghFuEb8tm/YMiSxTjudUEmFUHyJrweB+pbDqGZz+e9N
         3rjsaOHiEqQWPKi1ILlvUsDva8lXDZRejm6GEh0jgmd053h9nbiIIPFI5TWgZGRLH/9r
         y36A==
X-Gm-Message-State: AOJu0YwGLfWe6YkOJ+b9KhTf3Wsrv6i+nnHwTCaA9JX1fsySFqwYUpSt
	98mQYT4sKi0kSb2nDkxeJFhk+mL6AHpszHPCqHbepAFsd2qFKI3KusE+
X-Gm-Gg: ASbGncuCU+K2aHYM+zpcqm9oJz23AStF3/dU1ECJHQ/haLZDErOnwkAUsMUY5Ummmeu
	TPwOpRYRVRhidfOPpnYPDJDA5ADByjt5bvs3zclhcUZir9QQB+kHHCv/hqkDoIxpN0cGyFfXSr5
	AjZY7MrI+hKp/3mCjELAaKzxldnDLGaD9wqn3NCaV/pVaYi99JBebraDtIopPvYF8Il++i6U5//
	k9C3Q4ZoDWD0da+pSqjB6uLfYMGljcmH5mTWnulWKcOYm+RcUtguJyJgc/6Ht/pgPp/U2L80MVY
	JvA/yRK6ohL2qOnY2IYSMGNuzfTZ23Y9+A5n6RCa4nYkUirKpRM36Abm7DsIVLzWEjV2wJL4T8l
	ncJuLaCECRirD4fxd2Iey2Ouy+0k1Cl3xmQFuZ+7oGqmjtkQ6Qz8RTgOvRmJygJAYHEH4ogFQgW
	Drww9rLYcQJ6lB8EsqF+c=
X-Google-Smtp-Source: AGHT+IEytXao2mgX8yrfl9oB4UaAMNKRdCeCXGPN2ypjlDiGpr6ck1lmJGhadthbosUq0yKGoSRQOw==
X-Received: by 2002:a05:600c:46ca:b0:471:3b6:f2d with SMTP id 5b1f17b1804b1-47717e7a668mr1065825e9.38.1761581076812;
        Mon, 27 Oct 2025 09:04:36 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02cbc6sm147055475e9.1.2025.10.27.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:04:36 -0700 (PDT)
Message-ID: <42e7a6644812626d7c1a58eb51bc7418ff31c0c4.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
  Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,  Andy Shevchenko	
 <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Mon, 27 Oct 2025 16:05:11 +0000
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
References: <20251027150713.59067-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 23:07 +0800, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
>=20
> Add a check for the count and use the return value as the index.
>=20
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
>=20
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 41b96b48ba98..a9578afa7015 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct =
file
> *f,
> =C2=A0
> =C2=A0	guard(mutex)(&st->lock);
> =C2=A0
> +	if (count >=3D sizeof(buf))
> +		return -ENOSPC;
> +
> =C2=A0	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf=
,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 count);
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	buf[count] =3D '\0';
> +	buf[ret] =3D '\0';
> =C2=A0
> =C2=A0	ret =3D match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_sour=
ce),
> =C2=A0			=C2=A0=C2=A0 buf);

