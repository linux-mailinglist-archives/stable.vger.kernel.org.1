Return-Path: <stable+bounces-206289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D03D03D77
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B19513037BDF
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FD289376;
	Thu,  8 Jan 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imNphwHq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C593D3008
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865526; cv=none; b=uvMZmJ8VjXsfMv9VOPrDU7paYS8OHHLyaWl/0IaAuHJj8ahmnMLffQrF54q9LtLPirM7jwFbufnCXka1gyDHkEiIaJlwgjh346tKW5zjBbWPLx7f5egVgY4Hqbj24xPUSD040OD3wUIlDIxZmR6gTWDDNaWZvk6mFqZ+2bc9mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865526; c=relaxed/simple;
	bh=wLIWL74uqRZ0MG32DtebybhVE04jaG3SotfUJ3nbQKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyylO9wrZyRht6v6GDXtV+2Uo8xO49/4zSvZeT3WF3c1kKJRxdxzszdvKur7ESpjea/G2/xHKP63oSb77cS7QtXq8JUT4aZOK1ykHcBoL7pXCweQLKGSKN0oGIqQeJWhiVxy/YTfThiqDTjjsF1gHCk4aKR8ejcVLoVIXBDick0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=imNphwHq; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-382fd8aaa6eso16271941fa.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767865517; x=1768470317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3e6OTtKJfcSSJP7UkAzuBTTHphz/T3Qg2RIC0GLIQoE=;
        b=imNphwHqRKlY0AMKD4MnlSu83LxrriPiwNIh9Nid+Tt2F4P9qeAFJ7U0fVDGIjx146
         oIzZwrXnWqF26c3JbURDLGQ5CFy/lXk2bUY+nd4Hzr9BRbjYI2Zd2ALMgm1TywnCVFMx
         sckYu9vtW5snVxn1afDa5HdKWvydWWmexHcfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865517; x=1768470317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3e6OTtKJfcSSJP7UkAzuBTTHphz/T3Qg2RIC0GLIQoE=;
        b=gzWXzXjYzfLAH7ASP2opCQjjFHCKJiCLVFystRi4eUtUt2/1LLpPbN21iBy2lgD2h8
         09sZeSmATaPO1Yc9x4Cp9ek0Eyvm3s8qiQmc3zQ0xDekSnw1aJjXPFzb0tJy2pDLsO5W
         xYUT0c4uXi3yruxjKgGjLp51t2Hvqe84N009vrKrj/yqaDK45fHAJ5AVWAFVIS/HU37j
         8q++zJLZ3takn6fjSMWfhC1FPv+IZpqekYtIUb+sX12D+VDPulJzIev1ZR40fUsDSmuG
         2T8vAI4h+bXw5iBk/rPVPzt8FzkcZRw1ZCKM3QTnzM83u65y2bwYDaPD9hrtO6/scyI0
         F/Sg==
X-Gm-Message-State: AOJu0Yyy0+bsH8ZsrUPKPhn/xJwNql4cohMma2n2/1EXy/SlQBOaVBt9
	EMEAvcAqrkCg9SeGIFOnDVjQbZaVxJfVXEW2LLtQxsopSRHXV3O+3PxMa/c4ydtsDSx+HFZmk80
	gcquFkkQInnSzOQtMTTlBpqLb4KFtnhs0kAIOOXc=
X-Gm-Gg: AY/fxX6XE8XfgmTXbWtfLJN3IaQEj+FN0/37p2C/vnmLwFtnKuPmJ2lCVv3IQnYRxfl
	JlVQxoGPvJir/8edgSgQodFK112TfOMQwDe+k8fxKdO+x8yofmVGMtTjcfZrjvhpdKSNzIQE0MY
	5icpgkYnYb2Y5Y6U6nYHpXjyS63m4NvbRnBWWWXDhvhs+3cu6MrIpEZeMEgv6wfdwxwuSpsRpEp
	JhX9AIoktKzotZAK2trJY6DqSdEpreIkLIaFckpqh1NcJ+jZwZfYY6g0PJ/5MTmhbeFll7X
X-Google-Smtp-Source: AGHT+IEs4fUUJ3pMxRRABtOPO0u5xxTJc4YzICb1/S7PSESPqUAIhX1ox4ouAAkJqWhP4/naw6JYVwyiFT9m9r0uiPc=
X-Received: by 2002:a05:651c:3050:b0:37b:9977:7e4f with SMTP id
 38308e7fff4ca-382ff708909mr14541401fa.28.1767865516669; Thu, 08 Jan 2026
 01:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170451.332875001@linuxfoundation.org> <20260106170509.599329945@linuxfoundation.org>
 <CALwA+NZCSz26m96R0gjKP7=O3Z_kWmnt82SiaqvOukR9vFxv2A@mail.gmail.com> <2026010832-scrutiny-talisman-cdf9@gregkh>
In-Reply-To: <2026010832-scrutiny-talisman-cdf9@gregkh>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Thu, 8 Jan 2026 10:45:05 +0100
X-Gm-Features: AQt7F2oaaaOl7LEle_7kOIQFDOKt78J4Pqiy8M9UNyuYXa2v72nmHPp7fh7Tzq8
Message-ID: <CALwA+NYNHGN3p5s6tgCkkUm=1sxQPYbBir6U=gnXtfCkCBRb6g@mail.gmail.com>
Subject: Re: [PATCH 6.12 493/567] xhci: dbgtty: fix device unregister: fixup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	stable <stable@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 07, 2026 at 01:04:37AM +0100, =C5=81ukasz Bartosik wrote:
> > On Tue, Jan 6, 2026 at 6:43=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.12-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > >
> > > [ Upstream commit 74098cc06e753d3ffd8398b040a3a1dfb65260c0 ]
> > >
> > > This fixup replaces tty_vhangup() call with call to
> > > tty_port_tty_vhangup(). Both calls hangup tty device
> > > synchronously however tty_port_tty_vhangup() increases
> > > reference count during the hangup operation using
> > > scoped_guard(tty_port_tty).
> > >
> > > Cc: stable <stable@kernel.org>
> > > Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> > > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > > Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google=
.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/usb/host/xhci-dbgtty.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --- a/drivers/usb/host/xhci-dbgtty.c
> > > +++ b/drivers/usb/host/xhci-dbgtty.c
> > > @@ -522,7 +522,7 @@ static void xhci_dbc_tty_unregister_devi
> > >          * Hang up the TTY. This wakes up any blocked
> > >          * writers and causes subsequent writes to fail.
> > >          */
> > > -       tty_vhangup(port->port.tty);
> > > +       tty_port_tty_vhangup(&port->port);
> >
> > The function tty_port_tty_vhangup does not exist in the 6.12 kernel.
> > It was added later.
> >
> > I sent updated patch
> > https://lore.kernel.org/stable/20260106235820.2995848-1-ukaszb@chromium=
.org/T/#mb46d870145474d04aaabeccc76aaf949b34bbf86
>
> The patch before this one added that new api, so all is fine here.
>

Thank you for pointing that out.

Thanks,
=C5=81ukasz

> thanks,
>
> greg k-h

