Return-Path: <stable+bounces-230598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B6cECI9xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:17:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71C340D8A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C14304916E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1853D1CA8;
	Fri, 27 Mar 2026 08:11:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA653CF024
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599070; cv=none; b=PkY8bFltBBrWYZnh6L9XltGW+U+wWJI6hnECAngoA6J8HaFsvmcg7zAsJoXMIJUCSYtVLvtDgfpj5CkaI45cpRmvA0NQc+jFIj1xlcBbOhjGZiuacqKvby67NR/0cVv7e2hAkJT9KHaIV3/R3pk52v82nNUF23dXaY5L3HnQdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599070; c=relaxed/simple;
	bh=0bixOB6G2jM7l5g1Ih2rK8W90hezK6qbkJ+xBD5KCVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP712paH5v+Hers5WiG4ceGY3BEz+tf6nWuI4NtHamTnOHb7szk2yJQ5FmQdxRRhX0cwdF4/0ZbTUiBYvsAdzyrUq7Y9XgThcUGdxvp+H8PExGrMHZeLBTdy76NY8H5sJ8WfXTNlyQ1fzaZs46myLIe6tfEjqeU8OGagrhwI8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cc67e01deso1708234e0c.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774599063; x=1775203863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8V9hhorWdZi3ip2oyuNT3toc+rKSoRQGZZAFB2aI2A=;
        b=ff7bKyqxDSnKnkcGGUDZ34AKzQUstLJNIZ0BAS464YjQgkBCQencn5drud9ofJlK/A
         CYQWk0xxl9dHL/uKKstpAIVtIvoU8NV54Fd3lvyV6I4+NKK4zKWgDAJvYFQdyAeJMyj1
         GSJivv7U7zErp7uKXu9MoOeByxWWuVoBb3m7xEUIxaRoK/UJb9hruTUAcuKNRtGHDv5c
         MKfCIdc/x57MYJNBlOyA5anvsRkY8QLelFIQJ0btRmfZqnNv00xgy0dl9ITZgIn4IpxW
         ZiMc8gTNoKuFhhl5buYeDtX7LtplxP1UYw5AhjkE4fGbj/fRNDAmL9hO1nzbfYI64cCX
         HGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKkMMbY2hPh3DQXTiqRqh1BwQXGvf6hG650DcqLy828PNNb6DAKLC1esiyHZM6sjA/fRPGHK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDameLtKA8aJiDNOnV/hHpVzCrhozP9DjFPWIdF4vz6IgFNeZd
	Tba+hJWlQP8b0ReEIQHK5SYKW88UkHygfMca7Xh/G3oYuaIF/p//rlP7ln0Ifeh2S4E=
X-Gm-Gg: ATEYQzwpleRe8i7UPf6tTMl6rjPXLrfFx4eHJWDkQmmw+4xS5JVST0e1hmLTmb71K1K
	OYnfJ6eiS5o7swQUlWXBpAaUqWLwIBM8sQ7izHJXtSMMzY4dDGHUMKERnRigUwDITLi9HqhycTL
	DU1fS56N3ZPQP+IDybSFgHplci4L3hgJcMleJNb7lberliXlnzQBY1o3SSv1JJiYpjMpu9g1BwR
	ffVa4uHlVX46zvMo7vPp55A8z52W75+x6npXlwryDSJ5AxLzpNutgHTJJ46PcpOY03Uvnp3lWUb
	E8YwCy5D9PGu8LW26L/+HO3HM6QRX/lE1uGIWv+GZ2K+S8jf3Kp6mPV5r6h/MU8QH7Tb/3O7bD1
	7BSdGXQMpulmU+A4OCi6fkK1O/Xq6uNIs3qLLunmJ3maMlEEFeumykwYi797yI4jlCX40yOgv/x
	f9bv80RcLzq8KRcYT1eFz/z6xLLPwm0AF/gHYFvZXfTju97Vkyu8K/E7SNiI2V
X-Received: by 2002:a05:6122:1793:b0:56c:d5cd:1e7c with SMTP id 71dfb90a1353d-56d4a5091e3mr582369e0c.5.1774599062756;
        Fri, 27 Mar 2026 01:11:02 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71725sm8203361e0c.13.2026.03.27.01.11.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 01:11:02 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60294768235so1202995137.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 01:11:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUouk1QsTjgqP8maJP5ytYkjH5jcAAA021svSpVNQuxPeARzbfh+i3Jpj5YYIwMuTzQepZAvtE=@vger.kernel.org
X-Received: by 2002:a05:6102:2c06:b0:604:dfe1:39a7 with SMTP id
 ada2fe7eead31-604f90bc2famr697113137.11.1774599062142; Fri, 27 Mar 2026
 01:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326171412.1109402-1-lgs201920130244@gmail.com>
In-Reply-To: <20260326171412.1109402-1-lgs201920130244@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Mar 2026 09:10:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWY=pjuLvqU2baRsetbOYf=cFF_y4PsJ0DxH_zTGfx8ng@mail.gmail.com>
X-Gm-Features: AQROBzCCZJxwbKMT7J7XJSFJWnb4mGIFGMJKa6pkFMdZgUOlWNK5opyXCicKU2Y
Message-ID: <CAMuHMdWY=pjuLvqU2baRsetbOYf=cFF_y4PsJ0DxH_zTGfx8ng@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix NULL dereference in linedisp_release
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230598-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 9D71C340D8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

Thanks for your patch!

On Thu, 26 Mar 2026 at 18:14, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> linedisp_release() currently retrieves the enclosing struct linedisp via
> to_linedisp(). That lookup depends on the attachment list, but the
> attachment may already have been removed before put_device() invokes the
> release callback. This can happen in linedisp_unregister(), and can also
> be reached from some linedisp_register() error paths.
>
> In that case, to_linedisp() returns NULL and linedisp_release()
> dereferences it while freeing the display resources.

Indeed, the attachment is not yet or no longer available when
put_device() is called.

> The struct device released here is the embedded linedisp->dev used by
> linedisp_register(), so retrieve the enclosing object directly with
> container_of() instead.

True.

> Fixes: 66c93809487e ("auxdisplay: linedisp: encapsulate container_of usage within to_linedisp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

