Return-Path: <stable+bounces-38031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C778A05D0
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 04:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045981F24D9F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB30B320A;
	Thu, 11 Apr 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEAGRLyW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDF9449
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802382; cv=none; b=jyHUJwoa13DE52hJKnmxoYRRBcjf6fq/eGQirPvtWhcTlk+7r5B8vZCQxcQm349PcQ1nA+T9XpXIHrKBuMjBI5F2OFGcZ47Mk4VvZJ4pnTy6lzGsjJzB+RxnksOkHT/v7u0/0LLZsvhuwX5AfMmYeu4gAjbNhiZgZanzjIZ2Rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802382; c=relaxed/simple;
	bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE57bJcRh6DAQ8Q3ajJy+XjVyF0CZmVGl8BkcusaiPICJq43BxF/9smYy7FsKITZg3HhjSXi0Zbw28qZ0VSutaMhpUyhrMRj58Tnl4nMZ/y8a4gALYBNXTw1tbGFqWXrpAptQQEPH4VMqNYG6f6gZNuoKSdSFcmSgjd4aTU2vqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEAGRLyW; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43477091797so93921cf.1
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712802380; x=1713407180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
        b=OEAGRLyWraUqmw93STYIsFYWNKvqu0EqRRtw8GfQQNfllTju2Wxqpxttv9CCrJ4tS9
         KOGdbI/SuAe/W2oAv0JwOqCc7NC0EJMGsOiTYGasSodAtgfAzofDhpODKRI0SsU5kpAv
         rD1ioUalP4Sd7gJt1s/Rj774wDZyGkm8G4sjdb+XiElTGxwskGAWZj5aStWN4db26zKh
         tGlfXjuSNDZETs+Ov0onK76ibHWmIKq7wuoFHzhz+rK80QW7D6B20+ql7yHb5YQdoO6q
         MmkuepzQygnaoHGwxQbLT22ARJglurln3lUXvG3rQLoNfkouNZd5goOOK4LAmAQILkkd
         yvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712802380; x=1713407180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXJSmZxNI75aHxqgtrGql6qZ0waGZlG3tYEnH0qUS7Q=;
        b=q0eAaKsYPI72gKfzhgCeSUFkNIbNzADJyvpdsoFg84pDPqGZDceRWtoi+872oaymC7
         5pet/VfSmw6ASGWr+WNFdLd9hhQ0CAbup1kL6ijuQmvPUb7AGq3SmxTi8kL4aJM6F+cV
         Z7ahmVCRiaDkAoFFIqsqxTkRT+Sq6y0Jnj2McQJS2/fKpxCIjdNa5CqNzJ24CKhVzP50
         IoV/8nX1o6tjufdFBttv6xcP66ycErXzDETAa3mlmL4IuJGUQLG6Xgy3o8UY2PWcnkRw
         lAREvdhxX3hrs6fn334vWVOuGGikYb5LG7aEsvCqtD7OdEzyWqqpNS+nBor7Mmfq4IHs
         WN0g==
X-Forwarded-Encrypted: i=1; AJvYcCUMzgklkaD0FURzG4KKItQ8J31xCOetFqJ8euTUbJeb+/A1bSMhaWzLJ895twf9eNR3xe8LyxOQyzstj0c1lHn8bpDFVPyV
X-Gm-Message-State: AOJu0YzEg3tRyxZAJsojIuLIa5G9sLy/1NwP6KVzqI8D5eUBkndKjVDD
	rPNs7S5RW0yR9MyPnfHv/alF/BNi+qoxSQLPpBC9mK29t6LxXvt/miM1ujiLip+yre+8k37Z8p3
	agxwITiRc59zCjlY9vbjuzrXiwQ6Brp+TOhn/
X-Google-Smtp-Source: AGHT+IFPg5vORmoeTvYI/uTQ7j/zK/tZPyZEFI/0EvsxjhZAYdby9Des1k8yuS9qmNN9z2fJqX/gxMcyeTA58eMTClQ=
X-Received: by 2002:a05:622a:4c8d:b0:434:ec62:970c with SMTP id
 ez13-20020a05622a4c8d00b00434ec62970cmr131218qtb.12.1712802379873; Wed, 10
 Apr 2024 19:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410182618.169042-2-noah@noahloomans.com> <CABXOdTe02ALsv6sghnhWMkn7-7kidXhjvWzpDn7dGh4zKEkO8g@mail.gmail.com>
 <D0GS8UL1WKI5.1PLEUUWOD7B8@noahloomans.com> <ZhdIc3vt3DFvT066@google.com>
In-Reply-To: <ZhdIc3vt3DFvT066@google.com>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 10 Apr 2024 19:26:07 -0700
Message-ID: <CABXOdTetbKE_VWQsK4K6PB4Lm456BO7FfWyHtBBMhP77+QhzPw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_uart: properly fix race condition
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Noah Loomans <noah@noahloomans.com>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Robert Zieba <robertzieba@google.com>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 7:18=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Thu, Apr 11, 2024 at 12:06:33AM +0200, Noah Loomans wrote:
> > On 2024-04-10 at 21:48 UTC+02, Guenter Roeck wrote:
> > > On Wed, Apr 10, 2024 at 11:29=E2=80=AFAM Noah Loomans <noah@noahlooma=
ns.com> wrote:
> > > > This is my first time contributing to Linux, I hope this is a good
> > > > patch. Feedback on how to improve is welcome!
> > >
> > > The commit message is a bit long, but the patch itself looks good to =
me.
> >
> > Hmm yeah it's a bit on a long side. I'm not sure what could be removed
> > though, it all seems relevant for understanding the bug and the fix.
>
> Applied with shortening the message slightly.

We might also consider applying the patch to all ChromeOS branches
directly (not waiting for upstream); we do see a number of crashes
because of it.

Guenter

