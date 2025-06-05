Return-Path: <stable+bounces-151548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E86ACF52C
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1115516D6C0
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508627C162;
	Thu,  5 Jun 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwAyXaEw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900527BF80
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143766; cv=none; b=qYKeyrqhDG+Zm+8SFanErEaFjsSDqWAfZMCOFgU7akW7rKbG5piKPxFP8frAQH3U2yisZeig+0PeUBJdx3v71/FRJiYvwaHMQexr/z95BTcHnHn0GCM5jyxkFAnwmlA0/gNQc8uIOmqH3yVJ0k39xmTjF6lcOcCuok3iHDp4kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143766; c=relaxed/simple;
	bh=BsygIKSp4Y3uOUd9YvjvTHCT2OkAn7HB5ddVxCuXJEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD/6+svThKXu63IKLIudi5ubjYjcyyeJARsS4AkRNbRziEx9cZvxvOYDpwTOIYwWj6no9bZh6v8wnC5C5movnS7qa2/GPKuFbs6Qi+k9XNtBnyJOIaW0ncpIriaqsy4B5RcLVXnIBFHvHsiHt5JC8ODs6E2IeTx9BsLrr/JWAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwAyXaEw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso635a12.1
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749143763; x=1749748563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPVE+qJAV6lF2hHXHMzzV+2De3yTj5blSt0gISYXzwA=;
        b=MwAyXaEwlZ7Nxrxm/X6cB0znXJd7O7WKJzf2NblihAy3Ww9LpVGuJtoIsh4BW8CRAX
         1Epaq2CeQzEsTahYiq0LArwfoMvR3WlIuTUvc3dBJYzVdWkaeOc5HP9h4yiDgMkHTphT
         cdz/srYV1XFjAFAcHK0iC79USIKJTN/kyKgrV/koT3pUbLuIXO6E4nuWycE7JLE/G/QP
         3w6oXGuOH4dRw5cvDXnru7LfvM2Z+1yyZI8bSt5CEtBuIVY3Ad1GG8TdEoiiyjPGvN5R
         mL0Z6rShShxT7tIr3JnrIdQP8FGHF2KOAHbU0PNG2i95oblAB5Dajimsf6tin2zbkZ9V
         qYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143763; x=1749748563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPVE+qJAV6lF2hHXHMzzV+2De3yTj5blSt0gISYXzwA=;
        b=runMHQLYDxraBgucJGRwEUQRdcigZX+gyc4UpHaGEC+opGs57+n6gQgyA8gDWuCpL1
         TZf5rnqj3425ue/vAlVr+w6DZYclgICwnn7qNk2YxFt8OYYb9q/113KyQgcMib/fVbNp
         KpTrRa3xRbpw0Kdr7Yb1Uj3j76tCy0Za201TIdGRRDeqBVhJ9HVbq7xJdQ7vh4soxwQV
         koGO5yj36BV0x507lKXMO2hcqWLeEIJuKjTkk/7dvTcNB0LdiTNTr/dgDHYyqlQ1kHHW
         Mz8AtfQ5UdxYC1tzf0LGyBYkyjM2nKy0m9Nqj2Z5e4nkCEY+lciO+Gvj3qoqWwVTgoTP
         te+A==
X-Forwarded-Encrypted: i=1; AJvYcCXrfbYwLOu4ClPsHwGkUZsx/BVtWacvSBJoU1zRf3+NU2pBBe2nwytFyqf2LEXxfghmjipmIcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiG8K9VAqGLoMji6IkiDhI42HSD4LlU9fEHJiRKOmDW1+ECcF
	dwaZdAOVyaRC48WglXNG9ctETG/d5NEz8uL1w5J/bqMIBCGAZ5atl4M9FmCwMBv6kSU8DCNJHom
	QibZLUgWLc4obHgAS6qV/ScR+28qC3m1PKrW+Ilji
X-Gm-Gg: ASbGncuehaKwWHUwGlNCQqdz3XhBfbYJePu/tpMyRws54mDwaaxChh61DhKBKnruRbY
	NXzV97TiGIxmfic3OQI24M4h6mS8J7HcyAH10NWwf0VWJ0TRH133xtYnnEx/6H6gpwMo3nmiDWl
	L8uCkCFVxagJYt4HrCLMghmOpnnKzIY+fu6YK/yVuvYn9HNsoYWy80blnwBDfrtW7KHKP3RJY0N
	A==
X-Google-Smtp-Source: AGHT+IEsgNzktdJh8pc4Dp3J6fwwrOaLSQOcszvs7/V6sLuXQttJOIsOGPFSPRrS9VKP14E+I/IdyLbh1uIoYp0lGsg=
X-Received: by 2002:aa7:d9d3:0:b0:604:58e9:516c with SMTP id
 4fb4d7f45d1cf-60728a7df98mr100839a12.5.1749143762656; Thu, 05 Jun 2025
 10:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604201938.1409219-1-hramamurthy@google.com> <20250605081301.2659870c@kernel.org>
In-Reply-To: <20250605081301.2659870c@kernel.org>
From: Tim Hostetler <thostet@google.com>
Date: Thu, 5 Jun 2025 10:15:51 -0700
X-Gm-Features: AX0GCFvU2CbYecoDIb-s7wGpB4WkLnNVAMUQD6Cou3zqyUzrgIjk7T8up8uY8kk
Message-ID: <CAByH8UvMV94aVmmwb37f-wT8HpPKB3Nf8AF+67FM87XBz7+pww@mail.gmail.com>
Subject: Re: [PATCH net] gve: Fix stuck TX queue for DQ queue format
To: Jakub Kicinski <kuba@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	joshwash@google.com, jfraker@google.com, awogbemila@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 8:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  4 Jun 2025 20:19:38 +0000 Harshitha Ramamurthy wrote:
> > +     netdev_info(dev, "Kicking queue %d", txqueue);
> > +     napi_schedule(&block->napi);
> > +     tx->last_kick_msec =3D current_time;
> > +     goto out;
> >
> >  reset:
> >       gve_schedule_reset(priv);
>
> gotos at the base level of the function are too ugly to exit.
>
> Please refactor this first to move the logic that decides whether
> reset should happen to a separate helper, then you can avoid both
> gotos/labels.
>
> goto reset should turn into return true
> goto out should turn into return false

That makes sense to me, I'll refactor this in v2.

