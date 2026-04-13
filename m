Return-Path: <stable+bounces-235967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIoLMQuy3GmbVQkAu9opvQ
	(envelope-from <stable+bounces-235967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34A3E98B3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82596303D310
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF73A7581;
	Mon, 13 Apr 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="COkrJ2g2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076137EFF6
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070763; cv=pass; b=mIGlXOJlhMKF13/bcqziNKAsJ83ZpGwKtRUG7SWR4wvkccZcmKQ1sShm85o6D3vR1hVg4oT9egFwzSzfsJcnLbo2RiFxLrpfr3h1NPZ2U2Vb2zfg0UMJ+//fS36t2aM3piplE+33kXigWZax7sotJNkk+dRC9ynFQugnhWZ2y/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070763; c=relaxed/simple;
	bh=OZDnoThjdvQ5hGBpd2Z0yEv5u4OPjen6GiJaG+8kNwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU5zHm4o8GBhaPkl3Fev/oPgLHLa85Kp6yr/wJ76BFtA3lKwlX3GLgbOLUe6tvoeYMj2fPwVxL+UxCBSV5TqPDBE/yN58ZyBbaC8RurASXbvIzpocAvsNYr1crRezUpqz2uhAxISpzOGW9Jt4kaMLXJUyOH40WWUBxwa44bIUd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=COkrJ2g2; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso540200666b.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 01:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776070759; cv=none;
        d=google.com; s=arc-20240605;
        b=DT2UZ8PvFJQuLGVZUJ878qgilvQ1fVwt1VCzbcy9TALWLKuynZksHUZ+JVugwk/1HG
         /2EsoGAINVjHBZWsthvNzGXw1sszkt1ToFSGFOcPdUaCigXKjk1MpPv8IngWS92OSOpv
         M0SSyqKP4hHFuIf1JHFXE7A83oIMLThEkPFRAsKn/Js8/lNk8S59hJ3eRj2V4DTedBWG
         WOrm1QLj3DHabzJ2UKEt8xh9tt0ikoYO3QdKT/H6bQXNrbupvygY2onj5cP4aiNxiat6
         HTQIAarj3z08zF4tGch4GdMj8VdlFS9Rlgnb7Dxi4P5ZlUBACIMbFG2h714jlIRHTE3M
         vIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAMWWoHN87Ee/+pyKFMzgtVkPA85yfs/c3PtD+48H+0=;
        fh=ZcEdx/fTWg6k4JN34aFBFseJJjELfdyF5Rh/io694X0=;
        b=UVeULDSjSt3vA5MXP4NnfXzFKcxT1jN9qabZqDPlCuW9nBKXAII3eVj69Uwdq50JoV
         KKa9hlgxCGKkCXMkED1DMdhPb3r+Dfgv/7+XHmdd7DULxQoGgv6pbG1u5U2/j0aP7tHd
         jANqaj+p9VYDsQ4J9YJgb0azrX7tAim/vCvpryh0fCSMfO2qGJhfvMd16WZSFkabJxyk
         KkwyqRmJ9GzM/IdaI85+I2ADvhumTtBru11rodx/VJtwuivwuql5Uy8mpVlHJCRUfSwu
         1TB8oLNj+dIJS83ntXhEA5NZFbMcq4Y91kErKpLSotLjnT7EVlYEvIxOoWYlgF2xaQnl
         J66A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1776070759; x=1776675559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAMWWoHN87Ee/+pyKFMzgtVkPA85yfs/c3PtD+48H+0=;
        b=COkrJ2g22hnfxMMHeJr4yP7Jr+/nm/G7dsrmq9LyuBwAAa5XjyiVgqGeuv3MaAKqgi
         ev4REzCRNx1REORCdHsl/twSyAWGEcc/4FUM1WQvcmXVaMaHnvcSKwHYHoPSMM0FCIwN
         ze6Z4ci8QTUiNb/wrDhcV4NpNCai7NP7hw6/F4H4Lavcnazh7ThBgNaq6xEfOwDmwbqG
         DW2eg9UOv8k4xWdxvJ9jfuCSa0tGFjry+k3clEyJHA9QFQtLZxy7Bkc7L6F/sLG1ICHC
         rD9X02w4zUSxNr69bciLn+GGUH1TP1EwVGO7oZoJ0dJDsO0N1CWOywUp+uQ5sFWEttHU
         IMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070759; x=1776675559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAMWWoHN87Ee/+pyKFMzgtVkPA85yfs/c3PtD+48H+0=;
        b=idI7QDZuHlq2bPQeLBz/DdM4UsJNmoF4d6nG1VNqCVgifVs8fOJJTJVZOoc4qvO8Mp
         pGni0krR21EI91It8lmEw9CJs3Dyr1VFiT46dWaZKLmr5xQ3NnwFRMN/RnDWW6bq1h2S
         xR7CwznAPjimRz8SrJOap443ya5FoI0QhLyWLmsT9+I6zg72atLlOmjV/OBZQWXjgpZz
         iJQ1TTQ3aRvU3G8TcilSwUTaq+MZpeBe8iLQFz0toXB4WHfR/1LgzwUsQyZJaVN05cxn
         iEQ1vfHOdDbn++t8gBu8D9bEr9d1awJd9rbe6BgNBh7Ddn5GU/Z3w/YavKNtZ3enrf6V
         OCFg==
X-Forwarded-Encrypted: i=1; AJvYcCWq3kfL6DbcAUPBtmSCetLRmHe0jsykE3igjDcJ8dZUvHO2LUfvH5kRkhNad4a3OWm+vfZtTx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA0/mby4PkeEvzK6aUnEBH4U/hMLwFwSVkzkPeSsgIv4PsKx5
	cuIYPQxy4Oygg1bPnwcJdCruntdrR6e/D2EuNZylCmkWlXuGHd2Oyc15dezQJoudziMgtIBbW0p
	W93dfyhmMJYvWN3AAUcAn2XM37l3nHb5Qp1+3glJCrA==
X-Gm-Gg: AeBDietOOGhvj9+/T7TldPmErdH2Ldyj2pQp//i2Iu32/EFCZJhauie3WpBA9+KMroq
	3NgltPg2m0yQnF6w0e9kyGDrdDcvgdC7Gmg4Ln17UQa9lvsy7XZQaPylBDFMGAB3knCSK5kmoIZ
	92gxp73YIAKnoqzVZPylkn7ALSiYIb2heMcA//JmIq2uM3Kkfh8+A4GSTqfh86UgLSDBbG53Bpk
	KCDC+uHO0KwvbEv0PbIHgLqAgJPF6fe+gh1F4UgU4/HlTy+53KnfVBM6rwgoIfq3pXNL0yeI3M3
	Cx0fbAM=
X-Received: by 2002:a17:907:6d08:b0:b9c:c855:d93e with SMTP id
 a640c23a62f3a-b9d72657330mr599135366b.29.1776070759354; Mon, 13 Apr 2026
 01:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-fusb302-irq-v2-1-dbabd5c5c961@flipper.net> <2026040344-uncouple-maroon-69a1@gregkh>
In-Reply-To: <2026040344-uncouple-maroon-69a1@gregkh>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Apr 2026 12:59:11 +0400
X-Gm-Features: AQROBzDVkGFL5JJ3iG4BGVyI5-KaGi92PFmHIl19t6XVa-P1xFEcB47n7Pxo9r4
Message-ID: <CAKTNdwGqKqK80-B75Bto7muzqdKoqCuCUaxVwNx=9Cs+fb8WsQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: fusb302: Switch to threaded IRQ handler
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Hans de Goede <hansg@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235967-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,flipper.net:dkim,flipper.net:email,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B34A3E98B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Fri, Apr 3, 2026 at 10:36=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 17, 2026 at 08:30:15PM +0400, Alexey Charkov wrote:
> > FUSB302 fails to probe with -EINVAL if its interrupt line is connected =
via
> > an I2C GPIO expander, such as TI TCA6416.
> >
> > Switch the interrupt handler to a threaded one, which also works behind
> > such GPIO expanders.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 309b6341d557 ("usb: typec: fusb302: Revert incorrect threaded ir=
q fix")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> > Changes in v2:
> > - Re-added the IRQF_ONESHOT flag to the request_threaded_irq() call
> >   (thanks Hans de Goede and Sebastian Andrzej Siewior)
> > - Link to v1: https://lore.kernel.org/r/20260311-fusb302-irq-v1-1-7e710=
5706629@flipper.net
> > ---
> >  drivers/usb/typec/tcpm/fusb302.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/=
fusb302.c
> > index ce7069fb4be6..889c4c29c1b8 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -1764,8 +1764,9 @@ static int fusb302_probe(struct i2c_client *clien=
t)
> >               goto destroy_workqueue;
> >       }
> >
> > -     ret =3D request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> > -                       IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
> > +     ret =3D request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_=
irq_intn,
> > +                                IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> > +                                "fsc_interrupt_int_n", chip);
> >       if (ret < 0) {
> >               dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=3D%d=
", ret);
> >               goto tcpm_unregister_port;
> >
>
> I'll take this, but the testing systems rightly point out that
> chip->gpio_int_n_irq may NOT be initialized before this call is made in
> some situations, so this whole irq handler might never be set up.

Thanks for the heads up. I've been staring at this code from different
angles for a while but I can't see how gpio_int_n_irq can remain
uninitialized and the function still reach this point in the control
flow:
- The whole `chip` struct gets zero-initialized at the beginning of
the probe function
- For non-zero values of `client->irq` this field is explicitly set to
the (non-zero) value of client->irq
- For zero values of `client->irq`, the helper function `init_gpio()`
is always called. This function either sets this field to the result
of a `gpiod_to_irq()` call (which must be a valid interrupt number) or
it errors out early, terminating the entire probe before control
reaches request_threaded_irq()

Please let me know if I've missed anything here.

What can be problematic is that the check `if (chip->irq)` is too lax,
because any negative errno or IRQ_NOTCONNECTED (a.k.a. -2147483648)
would be treated as a usable interrupt, which it is not. I believe
request_threaded_irq() would fail on them anyway, but the code's
intent seems to have rather been `if (chip->irq > 0)`.

> I know your change didn't cause that logic bug to show up, but can you
> send a patch to fix that, as you have the ability to test these types of
> changes?

Sure, I'll test the change on chip->irq to filter out negative values
and send a patch if all goes well.

Best regards,
Alexey

