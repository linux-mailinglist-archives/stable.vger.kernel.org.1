Return-Path: <stable+bounces-217234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKpEEoh7lWl8RwIAu9opvQ
	(envelope-from <stable+bounces-217234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:42:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63D154381
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B65F4302A7F9
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFA320CB1;
	Wed, 18 Feb 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAsncozs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDA3161B3
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404162; cv=none; b=cuO743JSoFUx9W838ITXGLJAHVou/gkbrFE58NGxKpr1RGtp+D+f3VyiIXKKuJlzW/tbw/I55RMFpo3NUnmLGhjld8tVb4q/wjpc4g7FfuuY9nGiNIO9tGwwt8ye+ZH5h8f4NEetTb53dosH8VOLCG21i+fFVwcq21/ckjiy1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404162; c=relaxed/simple;
	bh=LFVa+bPFu8B7yQthwOHDkUQHzURrFzuOs+tqnZdoRmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG5+FNVYo7yrRyDE+CGevsqUC+I3n9F5Lccu4Oxzez8nrqn7xQ72CgUtD6s8DSiKGAw6uIrcwqx1DEWtyvuYB+fFPPnLMv2CQ/hgdwviH5nDuqu4beycqMzvy1ifx1tke5F91XnXkd0hq1hK9+nIhpvzG2S9xANEHZmrDJsdgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAsncozs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F211EC2BCB1
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771404162;
	bh=LFVa+bPFu8B7yQthwOHDkUQHzURrFzuOs+tqnZdoRmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nAsncozs/SRBao44LLdJY4CMDItykdHUveA28eA+av605Zpb/O7M6O6BeWvYuPhd1
	 jfZUMSp4KNlizD1s7gD8bRX6uWRt9ITtATdLntPsIhbA/o+nVuwxo2iA3YwEWF4FJS
	 Yj017qejjeAAZ6dGCmAjNj6MEa7VKDocNc6EjOBwLT5pMSRMzjUfGs9+cUhCvcc9d8
	 WYzUFM4Ae7Hf4q6Sc/6kMWKMHIdyNJiCb2hian/BQtAq5+3g7rZ/K4MinsQhqYV/Xq
	 PF2gzG0U5Lqo+Vf3WrUuorybX9nWdGVbfH1BPsGt1yX53yF1G/8RX/lR/Nsal1QA4Y
	 zkwNaInWDSSkQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dcdf60427so5018314e87.3
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 00:42:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+XHHwWngUtRZ+gUBehSSb5eM7E6RYIquRXx0XSZp4/XUqy8aaICQ7Bw0iYPOUO+WqoNdvs2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rQw0eABCHqgrdqtTIa6BBu8pFf+vCgOqcCYyTSut0uLjUiwz
	W0ksLqhfIngtpq+EivTu/A4AFUrKFLncEEzcUTLWs2TuuVXsihDm8N/kuS+G5kcBLQh4kPV6iiC
	lalRc7JYOXsJBZcKN5pwk+4GEfXBYgAZ1iE0MFynahQ==
X-Received: by 2002:a05:6512:2211:b0:59f:8158:d7d3 with SMTP id
 2adb3069b0e04-59f83bbc410mr321854e87.36.1771404160483; Wed, 18 Feb 2026
 00:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com> <aZUIFiOYt6GOlDQx@google.com>
In-Reply-To: <aZUIFiOYt6GOlDQx@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 18 Feb 2026 09:42:28 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md_x+DxmW742HRUW-jeg9_AW-stKkHUP9z13+M+POd4Tw@mail.gmail.com>
X-Gm-Features: AaiRm52ASOTlVFSy1KcC7rXVpTj3xLDZLyVk9gEaUjX0icBzUhT7rA9yV7re9uY
Message-ID: <CAMRc=Md_x+DxmW742HRUW-jeg9_AW-stKkHUP9z13+M+POd4Tw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: swnode: restore the swnode-name-against-chip-label
 matching
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CC63D154381
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:31=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Feb 11, 2026 at 09:53:13AM +0100, Bartosz Golaszewski wrote:
> > Using the remote firmware node for software node lookup is the right
> > thing to do. The GPIO controller we want to resolve should have the
> > software node we scooped out of the reference attached to it. However,
> > there are existing users who abuse the software node API by creating
> > dummy swnodes whose name is set to the expected label string of the GPI=
O
> > controller whose pins they want to control and use them in their local
> > swnode references as GPIO properties.
> >
> > This used to work when we compared the software node's name to the
> > chip's label. When we switched to using a real fwnode lookup, these
> > users broke down because the firmware nodes in question were never
> > attached to the controllers they were looking for.
> >
> > Restore the label matching as a fallback to fix the broken users but ad=
d
> > a big FIXME urging for a better solution.
> >
> > Cc: stable@vger.kernel.org # v6.18, v6.19
> > Fixes: 216c12047571 ("gpio: swnode: allow referencing GPIO chips by fir=
mware nodes")
> > Link: https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> > Changes in v2:
> > - check if gdev_node and gdev_node->name are not NULL before trying to
> >   match the label (Hans & Dan)
> > - use the right link
> > - collect tags
> >
> >  drivers/gpio/gpiolib-swnode.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnod=
e.c
> > index 21478b45c127d..0d7f3f09a0b4b 100644
> > --- a/drivers/gpio/gpiolib-swnode.c
> > +++ b/drivers/gpio/gpiolib-swnode.c
> > @@ -42,6 +42,25 @@ static struct gpio_device *swnode_get_gpio_device(st=
ruct fwnode_handle *fwnode)
> >
> >  fwnode_lookup:
> >       gdev =3D gpio_device_find_by_fwnode(fwnode);
>
> By the way, should we extend gpio_device_find_by_fwnode() to use both
> primary and secondary nodes?
>

That's already done on a higher lever for all fwnodes in gpiod_fwnode_looku=
p().

Bartosz

