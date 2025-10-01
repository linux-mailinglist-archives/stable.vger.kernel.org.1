Return-Path: <stable+bounces-182984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E44BB1615
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23874C3B17
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31BE2C033C;
	Wed,  1 Oct 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsEUWvSR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFE24C077
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340379; cv=none; b=f4xyg4FHLZj7De8ioPnV2fPcAaTfC2/AL1U8x9IeLOgI79cV3fxZ6fcCG3AVXXdctW9RN9SI96g029ACgKALVuCP8N/E4fvXERW7zCs3A2gFntJQWyvHAZxoH+U8s0MW1J+h1k9U/IMVjhgqXiGlbG6Qxgw+LtRmw3X2V6+RKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340379; c=relaxed/simple;
	bh=85ybsFmz254A1jGBcJtvJCoNVq8PIXBF1LySDzHbvOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoKhH9PHR7/K9JtGE4kaZ3BYvoIQK4ca3sGF0etthjDntK7bt6M2zRmv32kS3Xu0YrQACsn+GB0vsSejiDTDjDF3bajRs6rbk1m3NcXAX67rHhx1b8B0dsiDDYesb8zgDGUpYVO2FSeYkcsscO2R87QsjgL2tFjLvn0Zf6DNoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsEUWvSR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-269640c2d4bso47485ad.2
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759340377; x=1759945177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQvakTh55fyV5nLPousva+V7NX5CABwuk1WiUyfWTVI=;
        b=GsEUWvSRjSdC19PuNmsomHWoivxGs1Bw5l7gq0i1LgHcrRhsAlhfwyFTK35Jj0zoLy
         DzeMffHTSnFhIVNv0NxovX7zkicaTDqO2DV2zIKJ7Zh18IkC+PDFtUCHFactij14geTO
         DbulbcaWrViVWkUV2c3GzuII6MU+pZfxAMcfHy3bbT7vGaB1CBLIPiibs0pXfbuowb5I
         UGrUUs/Jic8VsaJrYWXAeQdSOGnBt3RIikrMi6LPqdIgS4TNYB61zZMBME4GU+51Pl1W
         oQ3y8q2QU+LVKXk1hdUtK8ON8MKm/xTbRLRDvc6Bz+hbWNDrv/kTtCygnlcZubhYiaLW
         Elow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759340377; x=1759945177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQvakTh55fyV5nLPousva+V7NX5CABwuk1WiUyfWTVI=;
        b=Qxv02V8zEgTtjGf878EVUXVGzWnSHJjB6sZTt81ts1G/hQ0y1wbHmAvIOiZMlh5t0m
         YgXvxSMYCldo3a8/03azPlOYVilHHJbzIMwj0iVpt+lt08puaTTMWdJnsI2MsaLe6RWr
         Xfoys58XDoJ2c0btZroaw1VmeF/JoS1/ZfZ79p0iIBRwEFuHkJfpWkvMOAJn3d0ltrf2
         Y6rh9DctTVA8I5+aMgPSZJn6423REQGB6+mbnwyuQPiG0den76vMZ0c0edW6BDqcr7/p
         lwH1J0V54HBNWoGJSxL9FPFkz1Tf1tEoCg/XLJqaSgrAhNrTFiUPi+bOeO7f3f8RIm7F
         W0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWde1+btBTXIozK8kLUDu+3hbxDz1JcaVwjnQAC/JeiMvSQE07WwUePJdZYhXGKSsI8cMldM8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pmMw7XEmQn/h77UEgYsC1RpHl7qljw0GfvPEtUp6Hw0LnnO3
	TLnvR0qooNu7FnyMr157lDM6QoBB53zX46/HovdTS3Od+D83Ps08ZCDnY5bCyv+2XHn9zrXLWXP
	0WRbdox7jY36aQjFWE29qAvFzpaisEv0=
X-Gm-Gg: ASbGnctnAYfUP3/+Id3TDY4f744cHW36VFLiXp4lejx4plhqloRTRFXr1PNV99tUzYI
	oKNmlZtI5AfGmdFuN/p/ULELrwkrmpTdYltEGXOG3/f218ZgEIT5vhR3BMQYMxcnoxJIob5vPPT
	C9kc8+1ira87vfFoK99qxVljoppO8J478jBF/2owJZodQVr+VQS96z3ZlJTVw8m1gLF1QVL/iXv
	l47UA70TQXW5OVF/m6Rmx545fSKbrJexsLi5yymW4ZyZM+cG/t1oZCaizNxG4tqvjhaUbh/mimX
	WR+/WRju1ZHzoeePyFpDThskFwNPJPTClwSZfPkaohndTGjqJQ==
X-Google-Smtp-Source: AGHT+IEAo7MdrES82JI+qedmq0v6ZXfOy0hmBxYLr8FX6CjRdMJwyM1E8v22WT+xn5jumhDRvJY349Nd0KpWQf2nKXo=
X-Received: by 2002:a17:902:e890:b0:276:76e1:2e78 with SMTP id
 d9443c01a7336-28e7f448d94mr30508305ad.10.1759340377295; Wed, 01 Oct 2025
 10:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025092127-sprint-unwomanly-fc76@gregkh>
In-Reply-To: <2025092127-sprint-unwomanly-fc76@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Oct 2025 19:39:25 +0200
X-Gm-Features: AS18NWCqJcoQHUwvuNJjw-a65R82SRhfh70nzMGK2HX0p8yXV9Q9rquWnRWaGkU
Message-ID: <CANiq72kEzOa60EhLQ2YnBOD6bsAHc7qA9v9-MP2FtxMa04Q5PQ@mail.gmail.com>
Subject: Re: Patch "LoongArch: Handle jump tables options for RUST" has been
 added to the 6.16-stable tree
To: gregkh@linuxfoundation.org
Cc: chenhuacai@loongson.cn, ojeda@kernel.org, wangrui@loongson.cn, 
	yangtiezhu@loongson.cn, stable-commits@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 3:05=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     LoongArch: Handle jump tables options for RUST
>
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary

...

> commit 74f8295c6fb8436bec9995baf6ba463151b6fb68 upstream.

Huacai et al.: I wonder if we could get this one into 6.12.y?

Maybe no one actually cares in practice, so please feel free to ignore
it, but it is the only `objtool` warning (a lot of instances, but just
that kind from a quick look) I have in my LoongArch Rust builds I have
in 6.12.y, and it would be nice to have it clean.

Thanks!

Cheers,
Miguel

