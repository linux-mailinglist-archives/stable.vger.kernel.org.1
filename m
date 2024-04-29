Return-Path: <stable+bounces-41699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06A8B5876
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72471F240CE
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F27BAE3;
	Mon, 29 Apr 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwbXEdY9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F379949
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393411; cv=none; b=toAYV5hdO4BOzo8DqsBxdUfD0RkUwGff8vlkH1nx4xGCPmDXuP28mpOZLwd4z9WetsCDj7M1daWg+MuvaDmaRqe9zcfJ6ew2JyrKlyYRGcRIfZ8O2saNS1cUhLM8mj596qPSPu3LQyDBQXR8EML+CaCPEvjUCoZ4kImf2LmVaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393411; c=relaxed/simple;
	bh=H9tmO4FBsf+fJCiyGeiD38PtImq0LgXQ31FDjkjTA8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=et9QEuew9A5DMg8OerNfEDDT4UO6RpSyWM61ZUhwNtr5ax8feqlj823204O0yGaUxBgc9JPaEZ34Vq38Nm6TRBPn4IriEIdDw17U49cAW2Xhm7LmoiAu3tOG+dVpJ5TUWZ1ThpcOwYo1P409wmxhcSN+dQ1cI2zL+mX+lxAIr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwbXEdY9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a52c544077so3233813a91.1
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714393410; x=1714998210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnSIqS7RvlBRy7PCOZ4mk7jHwVd6VHL3yInBCZ+chQg=;
        b=YwbXEdY98E5MKDIpzVhVosjuzKzWIOu8jTA2FlgDZImQ/7ShhtlsNrC+wCNdXlh2Su
         nQnVwtplYQfIZUCmpJQwXZHv+ySPNmTex+mQfCDtmI7+oRv1hKOlIgqr09GWnnBFsHpu
         IOoBJyfu0xQSe6jZNmmDbiZXg85i4DJuaPO4KyGBxUGcEByzVqylLnXppp9nIsB9vWCN
         LS3jZKzsroOOwTi1t4Jh5x2O17eCy0ohlLDPEsUSmSXOG5qO6Kv30kmxFs2klTLCkHJY
         ykSFRkjzkYHiDQ8an7GzeA2FN1T1rogxRXfs7d8CTa95R4FykdreagNmDn1gcB/OZbjw
         Lz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393410; x=1714998210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnSIqS7RvlBRy7PCOZ4mk7jHwVd6VHL3yInBCZ+chQg=;
        b=FLH5Z2+9ezuYUz+YOnkWQNqmEoUs8F4mg9Q0ZIBts78mzbSkTagYm6qf+chm4rBjVC
         FnQwYUYs+K95B3EqqC2n0G69XfHMTEgtYb9yb24TnrTOMnV9L8V3b4ecaN5rPTh2hgea
         zx/wiGipfzWMuUEUFQzLs2yrNVhDjQsHJ3R6YMdq5FxIcxpeaDwS6mvA8wYRJod+hYYj
         205MlrZE5+PHMo1SAgo0M7p7L9K2h1gNCCXvbgqg1C2qe2ORzBz+IvO5WptjmHW92BxF
         QQEhCZyol8M0R5k0a+0Vch+HXCiWa92OiyFOpii5ZRDMCs8KmRanPfgjMTqpQt6iyVNq
         bKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnDojYfZxQ6wLvxp80thmhC7QVjVSnxmDYSzkTFzT3CyGATic9MWesYRKEYB5vIl0rnrMjGg8kl+iI1/NyDvJ0sl8g9Z3W
X-Gm-Message-State: AOJu0YxF5S0Avd3ubRSkSz0yTdiCYBIK0wjOcdP4/CjH9jHh1d/E61sk
	hr7Az23B5gbYvmg75hCLgcQFvdrjsRCilmGVT+lsleix3Bu5szN1Je0UgBgttJf7qP7ds/MLRHC
	OxyCt2itn/PxEy2W9GNierf4Hhu8=
X-Google-Smtp-Source: AGHT+IE8i+LmcnPffbEC+ZT4PO2gFF4gIsi8XfIRqMQYcN8wOd7EeItxodpJWOz5v70KqOdgpKX/27jqTJobBDUpQOE=
X-Received: by 2002:a17:90a:6d02:b0:2a6:d064:15d5 with SMTP id
 z2-20020a17090a6d0200b002a6d06415d5mr9510289pjj.18.1714393409678; Mon, 29 Apr
 2024 05:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042909-whimsical-drapery-40d1@gregkh> <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>
 <2024042901-wired-monsoon-010b@gregkh>
In-Reply-To: <2024042901-wired-monsoon-010b@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Apr 2024 14:22:13 +0200
Message-ID: <CANiq72nLGum-AqCW=xfHZ5fNw5xQ+Cnmab3VZ+NeHEN1tSNpzw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to
 allow "empty" Rust" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ojeda@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com, 
	gary@garyguo.net, julian.stecklina@cyberus-technology.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> That was, but you also say:
>         Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> which is in 6.1, so what am I supposed to believe?
>
> Hence the email :)

Ah, I see. I thought the annotation "overrides" what could be found
automatically via the `Fixes`.

Let me send them manually then.

Thanks!

Cheers,
Miguel

