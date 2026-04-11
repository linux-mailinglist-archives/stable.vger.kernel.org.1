Return-Path: <stable+bounces-235703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKTyNM8U2mmAyQgAu9opvQ
	(envelope-from <stable+bounces-235703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:30:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115F3DF28F
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E26BE301C6E7
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C233A9CF;
	Sat, 11 Apr 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK4gK+37"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DA3064A9
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899851; cv=pass; b=HbVrSzlGdVYPXYPhl9ZOZ6Mq2JN04n1gfXRmbNSeUdYRZoUfFfnQ5DkzvtL6866QM/M3K5q16Yk/fKz3RHBSuCYaBq6z0gLBhhOGes/LvKaf0qAa7u6RYlgTktmys5U6yhOMDC0x49ENROo7JJgNTN+b89+IdaLQN1NyRY+ASoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899851; c=relaxed/simple;
	bh=cXKSu8prgsxZ7y3532Cei9WNm8Ushqsy6GopGdEKFM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNSuudUi8F9cEhK5sMz1S2g6UfM4M2lt/M9qSZ5PkJIYRbpKR8d19zsSCqHagKanFJO4pfkKQkoBVqEa4XoM1X0TtVvgn0vg+5GkuxlyJFH3hyXTjPW7pcy/e6SelSkecMPezWMsZRpw7D0JGEOF1vEfn8PE0kyw/A9Dgo/wxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK4gK+37; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7a469383e0bso21864817b3.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775899848; cv=none;
        d=google.com; s=arc-20240605;
        b=Qf1Pofn7mwAsY/2n722cymQfsz9iXkT5cxaUuqA9YykErIfuwzGn97dbwD9o5QI5YY
         9CuZJ5KUJrvkgbMgEASqquYrSsAEdRKiN7gylUuLuqmV8ea4O5rm5zM5TP+3NJSvkgT2
         o1Vys8q8HPirlpCwQK5HKSzEovr9Cq4brk6z+nHLHP2QRjht/Xl7u6bedfv7VAJnzhW6
         BD7xh3SQS04lOFwyIkEvIFDeuKrJgEVna8H253PqfxSyNRJ2aK+eQRi0dUP1p+fqZSE6
         WsgWZBfyCR0rLacSAqYCxEVcqugTOogBJEXAik8S1q7xxxaBoNitd2wuWWTzCWAkQu/9
         B+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        fh=9uiAUnrpt9RP+lQsxxttCMOCXKAqhW68Y2xdslVHqT4=;
        b=LFQySa+0KJfkOssOjwglj2+WO4oFtoeMydHjD9bvID/7efMmxUjFiXZSoSORBmPfK6
         6YzXDXFM0e2AYAvOvWVa0cNr6CDlIsPdf1+XPn9phwCkcMSxuaZVIeSP23UGi3lygd2r
         1eGm0AVTJPEx05WSy8DakzkKE/OIwMnNxOiB0j/F6RP4bzbCxPG+u9u6VFB+Q9D8DpeK
         TkDXW4pxE6CUIELhWqAnETIHr+ci586yMmknbuu2oQYwi1Oka/ItoNpRs9gL9GxX9boh
         RUdcVNp7rh9YooaHDUuQG4iZTW/RrVhZ702ZxDGz7oJa+8EvGSmfczI0Sv3hA+Iykqma
         wPkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775899848; x=1776504648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        b=LK4gK+37mea3KWvKKsx9KX9lJGDt5QvfMiRy1WP+KGKHZFA6ah8VSd182mJCRfWI8u
         BvLi/V5Oo74ZEFQzzChtXgh8AfmH9Xlii258Xf4arQfhrWPDJPuPsbuv+MlZy9ZpMB34
         Ybz3zhhmBNgPWi/g4n4LdDZ9EkVn26dikvl38kg7GlH/skamBXf9qwWyHy2jl6HrRm7y
         nR3ZXX2oYRASUBkrKhKtRkRBj+qAbZVrFYtY4CTTPPIODxKYBbE5ueDk3ZNLD58Nrv9+
         pbI7E41oG51nibf5bHdLyTLFlYU5pTfB6uUkV6eg7sGspN6USdIopQYedUib6DF9llfK
         eAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775899848; x=1776504648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        b=k4g364hKr4/bdvn5WSdsSA/RaVj/Cu2xwuqiZmco/atNWjKsDvW1zhUa7SMuphjOzW
         4yzVaLdoxc+UopuLPSl/fytXPSV2dPWCR+sIyacGycS4ys3jwescxgWjG7xKb6hvU5wg
         IT/VekmGMpuilq1xfwQ9tf53RmZtllcyuvjVed72v7MkFPnwakEH2ucVa0uf+15x2TPf
         jO+9ippiuADdBxFvNAHbdvUdsp+pFn1RvIHLCMxI7jivtc6MM9t11AKPmy9YPdYQQH+G
         nsaa1ZsqBa9ziGPVOUA/h22SIn1bqOtSjEkUUKcvZtDSTCp0MR7Eo4CZyRLBk/w5sUE0
         fHHg==
X-Forwarded-Encrypted: i=1; AFNElJ8EAPVBK+NEnrPfurgeJqveIIkjef83QvBnKyH1tBwt+a9HVVbY5Oa2+drvmeTXJekxzbk+Duw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhwytfdu1/plfGivcoTeJ18uqSuFaqFawO4ceiKLx73YkLGv0s
	Ix0WtO7l7ltbq3bzriiurnt6dm802BKJPfJg73g8d1ybmXOAdPWW10OXDLeAeEEMm5/fpn1G8h7
	tUwRcWn//XUtEU6XfqcRHUcQtH5gmU7Y=
X-Gm-Gg: AeBDieseavrjL61Cxb3Wv5EeIHolCUM3cMt6FpfQbVGTlYpzopTYFeEVYSmwcAytiOQ
	7GrGtXBmhzsieOAr76ELppgVfvI9+b8zNq8jJUbOoTzTXO5avtvLkLTFEaxRGlTKKrROqqozmGX
	y+FzrmEJag0yxgnoihETHGwET0qsYvOzKz05laoAK4UiEdPAh+ih+65meuYoSixxBTf9QX0nDzH
	2q4nXWdxYViibCqVQIegHw9GBhzvGhK43Ai7snbSzyy6hsAXDoDjMGYLVswIUlMnE4NT71kPFDw
	xHv3QHg=
X-Received: by 2002:a05:690c:768f:b0:79b:deb2:f5e2 with SMTP id
 00721157ae682-7af6ee49711mr58014857b3.11.1775899847966; Sat, 11 Apr 2026
 02:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411080435.2125626-1-lgs201920130244@gmail.com> <adoEfbDRO_ZsIUx6@stanley.mountain>
In-Reply-To: <adoEfbDRO_ZsIUx6@stanley.mountain>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 11 Apr 2026 17:30:36 +0800
X-Gm-Features: AQROBzDz53mV2WKlgnrPeDto-2h3oj2JZDFfc_Y9BjGEHLf9CUWBJA3INxTEoPs
Message-ID: <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235703-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5115F3DF28F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dan,

Thank you very much for your review and for pointing this out.

The kernel version on our side is `v6.19-rc8-214-ge7aa57247700`. For
clarity, below is the full `viio_trigger_alloc()` function in our
tree:

```c
struct iio_trigger *viio_trigger_alloc(struct device *parent,
       struct module *this_mod,
       const char *fmt,
       va_list vargs)
{
struct iio_trigger *trig;
int i;

trig = kzalloc(sizeof(*trig), GFP_KERNEL);
if (!trig)
return NULL;

trig->dev.parent = parent;
trig->dev.type = &iio_trig_type;
trig->dev.bus = &iio_bus_type;
device_initialize(&trig->dev);
INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);

mutex_init(&trig->pool_lock);
trig->subirq_base = irq_alloc_descs(-1, 0,
    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
    0);
if (trig->subirq_base < 0)
goto free_trig;

trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
if (trig->name == NULL)
goto free_descs;

INIT_LIST_HEAD(&trig->list);

trig->owner = this_mod;

trig->subirq_chip.name = trig->name;
trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
irq_set_chip(trig->subirq_base + i, &trig->subirq_chip);
irq_set_handler(trig->subirq_base + i, &handle_simple_irq);
irq_modify_status(trig->subirq_base + i,
  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
}

return trig;

free_descs:
irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
free_trig:
kfree(trig);
return NULL;
}
```

So in this version, both error paths are reached after `device_initialize()`.

That was why I thought `put_device(&trig->dev)` would be more
appropriate here than freeing `trig` directly with `kfree()`.

Also, since `irq_alloc_descs()` can return a negative error code, I
thought changing the release-side check to `trig->subirq_base >= 0`
was needed as well.

I may be missing something here, so I would very much appreciate any
correction if my understanding is off.

Best regards,
Guangshuo

