Return-Path: <stable+bounces-43691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0E8C436F
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD177284875
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706523CB;
	Mon, 13 May 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b09+3B7r"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6B1865
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611464; cv=none; b=s15HnlpwaZ8HdGmKuivuTqwqnyi+uL7LWmyBt9r4A5Bp1DFBrVz9RxYFt7ZdQSyLIxWUUOjIjgh4xoE5tcz/Hc7wkM3nzzT3uAiy79oVtR6PLTum+nydF2ENWhesZ4UWYLl/6lN9bEM2uclp1ZWo47rAAfe4RO207oOaXL6fg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611464; c=relaxed/simple;
	bh=PGH5EKFrwXnc6SAKxeaLWgGaxFocDB0vN1JuUbMOVs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNvp0epmPMF2XGZo/rHerOsO2avt92pYpGdY6MWHQNphVvN/FCPeRLV6f/PGjLf2Igykmb6OX87LjHjTqv/MFmHDnUzn5Lv+DyCRx2Gu3QMA2+u7F/reELOegIpF/70/9//ou3ZqnUpNOHUCZ2CW7D7ksy4lWFupEeRYUlXvEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b09+3B7r; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so50087201fa.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715611460; x=1716216260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8TFwEQvvdokHmszhYJGVySuPPaVg+BA2VD/ff9rusQ=;
        b=b09+3B7r94POgi4Lm4+DyVXKnsKQC+r9t0J+J2tTj2QGSAvTL/rNHL1nq8UnaNvhlN
         msoISDvn6Qidx/g2ERBxMQR05DcN6girDnHT7YZwS+B+I90waV6btZw6FXjGjQY9cFY9
         mQ6/FYQlMvij0y/AwqZmKb7cpEnq3hyvdP7PEMUBdQYNBK8goIf81T9ppe62JxFxGjeN
         pqqg4OJTPmIDk7Dtlzmcc7bSIO/ipE27BQlROmCq554EPdQjRBi72yBH5qzYqly3BD4P
         bnOJDD7LW+RxUqYL3DVT3xqkfp+TCisgHnGDKKvYw54k8w8x+uAuehj7gjzAp2nIcCMG
         rXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611460; x=1716216260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8TFwEQvvdokHmszhYJGVySuPPaVg+BA2VD/ff9rusQ=;
        b=TOfSh8sCdDK6DYI0iiyOaEVyJVMWlY2LX9EGNWlfjsvSFqbkrzCzrIoni9gNTkWVjf
         i7S6tMLG6qv61rmXNGen1x0sR6QfYI+uCfvK3XeIO++ap8wVk+Ed06tBAZ/T73BFOZWP
         523QRXgeMPFoMiPAFcmJhxSOHxVyc7WYoFFuzYdNS96SMyw/bQBPOTRdd9o7bYgIHIjK
         v9zERMHW/37akEtmHdgqm+CzLchaHUmJqBctHSfFGYwk8Eq0c9KVQ9UegQvB/gXhuZzS
         c07XHXpfpEbBP/v5wX7WipczI6BYox2eP0/bclsGExeV3feNTy3u6BHGZiFqm9Il+5KN
         KWWw==
X-Forwarded-Encrypted: i=1; AJvYcCXQrtkvt43PgoOYX/e6HgT10Gj+tIE8mmMXt0TYNuIBSRJQEx4ItJF/HTy2zZfd4vW/zkzYL56TWiNzOMISdr9yhzQqBEY+
X-Gm-Message-State: AOJu0Yw1Wg8iytwyYbmT5WGXtjc8hCwNfLqNqgCJW4wtaSsQwPaW74kP
	n/BsZjzl9bj+oMGz7t8/5sDlCSHTWP87yNe8eXvhQz4g1dKnH1bQPRpliiuJeykNk7oi9qSg+hf
	L0DJkB1si08Uh0gSkXt1aj45PCQghLH41dxABbqNB7NJwiMha4kxe7Q==
X-Google-Smtp-Source: AGHT+IFkMEnn6N0RdwmvD1IKIDFdU3HKeqr6HF1ESvZFGRFOZtiKvhAeSzF2qAbo79NCXZjtZEfV1scQ18WGXGBVoW8=
X-Received: by 2002:a2e:8ecc:0:b0:2e5:5ef9:2a56 with SMTP id
 38308e7fff4ca-2e55ef9309cmr58721581fa.36.1715611460141; Mon, 13 May 2024
 07:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506193007.271745-1-sashal@kernel.org> <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
 <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com> <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
 <d2857f45-caa6-4d69-989d-bb95dfcbc7ff@baylibre.com> <Zjo9PrCgSm0Jn3KU@finisterre.sirena.org.uk>
 <2024051310-spindle-resort-1219@gregkh>
In-Reply-To: <2024051310-spindle-resort-1219@gregkh>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 May 2024 09:44:08 -0500
Message-ID: <CAMknhBHwxd6ThV_ddkBNsJ5F8gmDEfx21g6JSnhnatCB_siHzw@mail.gmail.com>
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 07, 2024 at 11:39:58PM +0900, Mark Brown wrote:
> > On Tue, May 07, 2024 at 09:22:48AM -0500, David Lechner wrote:
> >
> > > It's just fixing a theoretical problem, not one that has actually
> > > caused problems for people. The stable guidelines I read [1] said we
> > > shouldn't include fixes like that.
> >
> > > [1]: https://docs.kernel.org/process/stable-kernel-rules.html
> >
> > > So, sure it would probably be harmless to include it without the
> > > other dependencies. But not sure it is worth the effort for only
> > > a theoretical problem.
> >
> > The written stable guidelines don't really reflect what's going on with
> > stable these days at all, these days it's very aggressive with what it
> > backports.
>
> It's "aggressive" in that many dependent patches are finally being
> properly found and backported as needed to be able to get the "real" fix
> applied properly.  That's all, nothing odd here, and all of these
> commits have been through proper review and development and acceptance
> already, so it's not like they are brand new things, they are required
> for real fixes.
>
> > Personally I tend to be a lot more conservative than this
> > and would tend to agree that this isn't a great candidate for
> > backporting but people seem OK with this sort of stuff.
>
> Again, we want to keep as close as possible with Linus's tree because
> ALMOST EVERY time we try to do our own thing, we get something wrong.
> Keeping in sync is essencial to rely on our overall testing and future
> fix ability to keep in sync properly.
>
> To attempt to do "one off" backports all over the place just does not
> work, we have tried it and failed.  To not accept the fix at all leaves
> us vulnerable to a known bug, why would that be ok?
>
> Change is good, and these changes are extra-good as they fix things.
>


I see there are differences in opinion of what a "real" problem is.
And it sounds like the opinions have been shifting while I was away
from kernel development for a few years.

If you prefer to take this patch and all of it's dependencies to keep
things as close to mainline as possible, I guess that is fine.

