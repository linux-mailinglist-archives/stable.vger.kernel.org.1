Return-Path: <stable+bounces-75625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D59735FD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F64B24A55
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151581F956;
	Tue, 10 Sep 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8EFAJT4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4C187325
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966888; cv=none; b=C3bioMGn3Qj3njqQB+vW9TvuCuTEbdDx2pj2tf7bwJTGIMFtAOT320l0jcBjvTy9wYzD1WdzeFnd6J0FRGJxnb7F59f5F0H3UFzlSpj465DkOl4a/OzsdiKeRsjJspAf6CLpOa8i3manSAf40FGHF5I/ljziPTGrM5iUmDrY50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966888; c=relaxed/simple;
	bh=7R70qvFxYRQKCjHDlVjVMuioejDKgflNF55Yu8sguNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKuaRnl07cs7QsF105uG6HK6FjYvnqApifBGk5WtANfu75tVhC58ElZdUJEmPCKigIYaLclzi+Au/0DuUoOP82xmQRb7ijMjUY2HJ9f9kdkzFq2YdWF9wmV3u3ZyDXp8V2OhkpkEPtTFF0JSI6aRrihesHn86qiEagsu3TitKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8EFAJT4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8a4bad404so297098a91.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725966887; x=1726571687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R70qvFxYRQKCjHDlVjVMuioejDKgflNF55Yu8sguNM=;
        b=b8EFAJT4AuZSgbpB8U3vhSsAOwduNZ0z8l6aphFB9V3hcqlA1nnS+dsA+UklAlwEtC
         OMOhobPxJ07Ij/GJNjVelTmkJT+Fi4EFMA+SVK+nFIIXZJ3YE4O1h9su0oEoboWcUtFo
         rTXsozi9RvD68KnNVZCgZBWacU+8iPZEmZ8pve/AKjVcn6miuPq3LbQnfA9fDu0caO/K
         J9J0nryGMr16b9msw9fYDwTKp7nHNCyOx6kzYWeHmWV1/lwNax1u/+GnA4T3wFnS+A9U
         E2zyY26iYGcYnhfzeuNEFuvZtVPFTy8c7EuDsYks/km+GD09vQKNCwnhb3oWy5907Nh5
         1kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725966887; x=1726571687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R70qvFxYRQKCjHDlVjVMuioejDKgflNF55Yu8sguNM=;
        b=eZMZaSUDCfEr1Y23yayXfU+0mJMfk5mQpvMsbjbhY31njArEts2NDmoWcFQHeS9R1p
         xwurM7nJb/m8oOp9hfQNIWsPJC0CfTCoSpNCvVIPu3v6ISKRNQTjuGliLpaFCNhUKRuo
         315nBG3JoSyy8EFTVSveoYa1JJ1vnKlNHNWbj0gICzZIfkaIOoeWKaP0jbNBWx0LcwTE
         reHPPoZbmhn6zVo0Pz2jHFrJ/t4FqYIp7yAVQrUVl9i4+iKZ8U7vUr2nmYr3gU+Lgx33
         Z3J0J3fAUY/bjkY8xUlMd5ex0HUo0GbC9smX1sYzjYZTsa5nXZYLJZu/NI4yCMaFcz1V
         idDg==
X-Gm-Message-State: AOJu0Yw7YBdtju/pg/nND7k8oBN/tUPXc5x5cTLYIwCTX/ys/5gi3diW
	d7WNHseutjFyVgs1qqW6DzIkwzmsZEc1YYqu6VHfNjlAXXl1bo1ZrZ5wE2KsQojLy04XkmEiIMS
	7/P05Q7W1+NhWBbMUZOpBunxfF9I=
X-Google-Smtp-Source: AGHT+IFA9BIl5K6nzzFm26HbZ/XWC2bq8ZUkUz+X7SI61EMsnik7yYHU0TsUVMbVKdAcFYqRNR1EofIDip33sDTGX0Y=
X-Received: by 2002:a17:90a:604a:b0:2db:60b:3668 with SMTP id
 98e67ed59e1d1-2db060b3bd2mr4322899a91.7.1725966886696; Tue, 10 Sep 2024
 04:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org> <20240910092604.257546283@linuxfoundation.org>
 <CAH5fLgi7_=3W3WdPR2KcUW73Ma=SXo-dX20z0xx+AK4S_N3SwQ@mail.gmail.com>
In-Reply-To: <CAH5fLgi7_=3W3WdPR2KcUW73Ma=SXo-dX20z0xx+AK4S_N3SwQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Sep 2024 13:14:34 +0200
Message-ID: <CANiq72kvESNP0StA6DRukSJ7K4q2a4EtTsNTDECSAsWjmhp5-g@mail.gmail.com>
Subject: Re: [PATCH 6.1 153/192] rust: macros: provide correct provenance when
 constructing THIS_MODULE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:25=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Tue, Sep 10, 2024 at 12:12=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> > Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make O=
paque::get const")
>
> The opaque type doesn't exist yet on 6.1, so this needs to be changed
> for the 6.1 backport. It won't compile as-is.

+1 -- Greg/Sasha: for context, this is the one I asked about using
Option 3 since otherwise the list of cherry-picks for 6.1 would be
quite long.

Cheers,
Miguel

