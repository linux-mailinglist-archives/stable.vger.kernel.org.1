Return-Path: <stable+bounces-206290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144FD02DAF
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67BF3300D80D
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7043A0E86;
	Thu,  8 Jan 2026 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9cptNVb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C393A0E95
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865790; cv=none; b=dgKAPsr87oO3MIfnOkHGsbLX2LuSrDQzMrQljWGrBbvLqkreDZW8I4xXpfh/Xulc2RzuEXHkd2bCi0eLMZ+teivhH7PfSaec7ZUr5FYFlQk+xpyYDCkR0yProuAkhTPfu7jCCeEQgMPaddFJ97ra+3Poxmgy7tvQwpu4eSqX6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865790; c=relaxed/simple;
	bh=LSgV0q3gGcY2Kpse4VJqBR9Tyr15RWzK6J9RiwvZxww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2sAIOqjkSGk/OKhCHZzcgdvtz0vilEaEZRYai3dH92N3Ufmk/iSVgStpBOCvPPozm3XY2UepbUOiDBBPq30i5KhIczNZsw879ox8AlmRq/tF7I/MEsSElR9hTme+7E3Q2OVDQ/iWvs0Fu1k3RyX8DY8t9VYs7I7vgYc47wWmpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b9cptNVb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-383022729d5so9879501fa.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767865784; x=1768470584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfTVXEu/qfICAmH10yikirUeRfahcF/rHyOwKkpm8lA=;
        b=b9cptNVb3KynVFG7BWQLSKi3WLsEqcgW+1GuGbdIhGupgMPWVTvKuuGrWqYn5wpviG
         oTT88FZ1vvHQlPTTugTre5lDaml4mP+DWs5XMixg+gtc9CQ+gUzUwRHln6fwmJMZDjmY
         x8rWOw2eY1joTcmCfSRelZ5os+2aprEDvGJJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865784; x=1768470584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfTVXEu/qfICAmH10yikirUeRfahcF/rHyOwKkpm8lA=;
        b=NnDQLmRJ2gPjB4ZlnThphtBpf9XVWAegB1tUp15IiGMLuv8IYeR0vfN1d3MvqXHMto
         zfqmegvN5orR6zYz+NMA2qPqtemCnBZ2gPQE9FECLbiPnusnlUR8GwLm1bOqJfvdmufQ
         EfpQZoLrAYrUNlUDY8sqwFZRVIN7fwmBY9gS7nv+hXvQPW5svKloY6UQSgChQAt2yVmH
         Lzlk/qDwF2UoykLgFnAdcpDXfXiv9N3YHbG6Hlm/tDlRhNn1vDrUJrrhMoeyrKr+cjiQ
         p+SXJgBzDJq2k58iPBkzFmKXuRapRlcADWU8wmA/IEWRJmuu94rjxrYmL8+lXUp8TiCy
         Qk6w==
X-Gm-Message-State: AOJu0Yx6O2qgHWzz6zunz+uMZE38WSz1EKWaodfN4yy3Jo5xDy6/ydDu
	RDV9SkSUeeKqmq7XfiTR08DDg8S3Cq+tNaA42yRFXcAGmwCoQp6iDLJ0oClqkXZopNNJHCUAYUu
	vlgYEg2p07Kb1Lj5skuuFVpz5K6+E3+jsXq37CxQ=
X-Gm-Gg: AY/fxX4/7YsWmTvJYjUqAk7LXBRQ09SOE07m53GPrV7e7eiH1AOWx9tlREhiECtGz7D
	pSZKZxpvmPaNhvArL2Os65eswNbDUFlq9uLEpl0KsJY35YexiPpVQ1H0/LN2A/hrJejodTz1fZJ
	cxRYp4oZdJX0zXgkPak0/9GZdgn3IFx/mnZEwS8nQ8TT0+q1CEIdIbd6XVFzcpgJ1GIHWbm159V
	J9TMUu37ixSqr6p/AUgL+V3Jn2NFnRuTFsks2OC11u6kTz+uQgOGjeZaCLoFtNnBd5FhcDx
X-Google-Smtp-Source: AGHT+IFKVKanT7t/Ci6KMGi663xtXVRKpiAGgQfykpdYektYrYZnNA2w/XtFdYYly8Xi/vzsINjwHSNW/HtO42ubuP8=
X-Received: by 2002:a2e:bd01:0:b0:352:6aa4:3cee with SMTP id
 38308e7fff4ca-382ff6a86ddmr13789761fa.17.1767865784348; Thu, 08 Jan 2026
 01:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025122917-unsheathe-breeder-0ac2@gregkh> <20260106235820.2995848-1-ukaszb@chromium.org>
 <2026010844-dispense-headless-de8c@gregkh>
In-Reply-To: <2026010844-dispense-headless-de8c@gregkh>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Thu, 8 Jan 2026 10:49:33 +0100
X-Gm-Features: AQt7F2rh_XNiD2hr5YW9DxCJJxz1m5n5F95pryvi8XrstemMYzYjnmDo1Ot3tSE
Message-ID: <CALwA+Na-+CcsSELpo0trtpisZhuBfgQjnQPJo74YONaWN_Q-iw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] xhci: dbgtty: fix device unregister: fixup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:24=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 06, 2026 at 11:58:20PM +0000, =C5=81ukasz Bartosik wrote:
> > This fixup replaces tty_vhangup() call with call to
> > tty_port_tty_vhangup(). Both calls hangup tty device
> > synchronously however tty_port_tty_vhangup() increases
> > reference count during the hangup operation using
> > scoped_guard(tty_port_tty).
> >
> > Cc: stable <stable@kernel.org>
> > Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.c=
om
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
>
> What is the git commit id of this in Linus's tree?
>
> Please resend it with that information.
>

I missed the fact the new API  tty_port_tty_vhangup will be included
in 6.12 stable as well -
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/dif=
f/releases/6.12.64/tty-introduce-and-use-tty_port_tty_vhangup-helper.patch?=
id=3De1cf6c2ddaf2b59385d07fb49c4d7703aacc5203
Therefore my patch is no needed.

Sorry for the confusion.

Thanks,
=C5=81ukasz

> thanks,
>
> greg k-h

