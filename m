Return-Path: <stable+bounces-235950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJmCF96j3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:05:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2433E8C62
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B26A300B112
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FB39D6E8;
	Mon, 13 Apr 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJtlyuCw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC237C105
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067118; cv=pass; b=P9/FYbG3Ctj+f0GWIxX/5A2iKbySctndwEZy8w9af/+2Z/zDqrnqzLZXgG+3P59cR+9rJpkMgepu2dcS6k93OM4lNiUiwVXNBpHMYTGOYEZTH244TW+bwnC3LN5viE0lhEsGOdBDAToTX2HsVdzbOgRp4diDVAwTlfE00HOlVqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067118; c=relaxed/simple;
	bh=rCO1b6jT4qW3ldfK0o55NFQ/frBnnfo6DXzmtZ5lzmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2JwOawoU/LLpOJrTcko9tbKIPIjAeT9Y4+Vj4G6Vy/aPIr4S0Q7A2rNZPX1n6dm2HHL3i3PRjfXLr6LrJ3qd0TzA+6s/73Wyo6YSm+xAtrgbJEcG7uzYwIUV7j/gFgbWEnaT8dw2tYXrvOEQxZ3Ex0/NYffgWcK3+IlglZ9dlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJtlyuCw; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-650221149e2so3814371d50.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 00:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776067116; cv=none;
        d=google.com; s=arc-20240605;
        b=FSI0gcDMjgeW8zL4x6WlAG7w1eYrU7wo6w4MeUv4LdN1phM06dKSVNihbIHHF1ZGQo
         1daX/U8lGoim3RKgYDRJJ1hBbmpMgN+WXTlIe40G/xKCLeXlf4azT7HGC8ivq8fNI3uJ
         qXImT3mIuhpWWAF3x91KbXmEQv1zcAzIjZKbCutxfIITWG3Epj06DJI5w3/ir8bFAVPD
         D0AHSeyOB5ymmGJrfuBjA5d9KwPEaUYe3p2VRjGP/DCUN0NNQtiQysn8KMJicK2fewJ8
         //vjr7bLVuX63Xr/vj3PBioi82hUUVuo13L99M3P6KEWYgq6W9N/G/E0Wc+tsVF3Jc04
         tOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rCO1b6jT4qW3ldfK0o55NFQ/frBnnfo6DXzmtZ5lzmU=;
        fh=Q9kW8oF4I1iCVZzdvt9JXqNZxo5Hxwt4FL+BFuDEyC4=;
        b=RvSCpt7Cxd1/14LQokwtU4JmUhE9D8xxPYgALUZ6GHPRQWdaih5YwY74kokA3VRjoh
         ppGy6266sdgQERuig+ylNVQ7Cvk8KHrehtc0Z6B2ZlMSCXg+H+iXCnuy8JQ86UJvpX1/
         hbgGJJC6ltzHrvS1Vm8ZHxvg0oeqLQo/0tGRfQxZHjwJh57uIZ+xnFGyK8eHe17uIxVC
         qDX4FiGNs/nCfKk1Mi99KugzzeEY+i5V2attgaE07VZJCdO3MIum/v4zEMVMwcxVqIlY
         WqIGlrHXsuDMolfrHQtVyBOB7OGik0IXCsN/l60UEMekFaIMJwVlP6seeJDgOUX34Zym
         LmOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067116; x=1776671916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCO1b6jT4qW3ldfK0o55NFQ/frBnnfo6DXzmtZ5lzmU=;
        b=fJtlyuCwWx0MSLgj21qE5kLOBaP/bIcVdQtpz299tNutl3KVM3CJu3ZGvx3Bz2kPos
         WTwYE24Pw475nOdXqyRQWW4PtS6q936RjafZAIuFZ95aJe1aXpcTObzJaopQSu4lg8T2
         CV/LmkvHiZOT3sU6RQJ8TCWmjcbyLkEpvDC2UTXBFTdm4Qh6BqMoi1C7zj9vFFM2X/u8
         Cs/23kPrW1qucbHmU7gmkc58rEfCAwH25DGotYQkgNkhAVJBVxtu17HEaQTsQ66OnnJr
         LXit3//8tVjL8zwAZVdQF2SP2p5jlTqzYQDNnRk3GB8cEeJMmECx2310t7USjhnTeXQF
         eC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067116; x=1776671916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCO1b6jT4qW3ldfK0o55NFQ/frBnnfo6DXzmtZ5lzmU=;
        b=hisd3Jg5shzFz1SwX2Y24J0yycUxJ/U0bBpxpMBSffXswkVTCR81hBTrfMtIc8S8AS
         YmwaGWq6PW04o22jl76gtM155Xo1How4FT1KtfGTEXsmKQYdz5HuXHds3RZHnuUkrFml
         UFRwUBPvBZKZd5tPas8T6JzwluP4VFA7zuxSTe5D0PXWkry8XAet0UncGqIjUUSBMOy1
         QJA1ZFYtRB59v+vXopLPpSaTGvrqA6ov+M/b4CzsOrImudTjsNhoQ0m+IGzZ3/KUmVQT
         j74XyGXBXHzSVfbM1l0hBdUxW52hYUKG9VT5wdt9KMilIH5cK2KADLS0qWD7ly1V7Ooj
         6bCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gTUNPmFU6JqhhWVAEfTmLyzd4XCvftAgC/7MEXIaVNYEtiOm+82YpTmliP34p1QGvmpv5E38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlhFiKODR6/Y6IYaKzgqCNd8DPJeVSSkQLJn8NoRMwgs8Wmjn
	mLB74KWnbyIbccVlKMnWy4FETq0WFJRfxBlsRq1qEZQgK+zFUQ6bz/Z0gQb5fvfF0FRK3B6zC80
	luKOR3azCriEg0TTmOA6MYGOfGZzKyDd5mQTY/ZC4XQ==
X-Gm-Gg: AeBDiesLopgHniA+hEJUoIPUuFt0lLDC3zMRhXNXHqn16QQejCZ7VovmTwaHqy3+IbD
	8lC6PEjK3XtjH7jJ7GEI2VFbT3frpgFHPOYC1pEBtbxxzXxr+Vj4RmT3vQT+8bwumFXvqj8rLue
	iAuTm5b40oD8yJ2OeaoHxtJS8KV5BG8Qv3N2MWkR1r2A93H8yCazzZypblTEvXnCYK5LlA4rOxp
	SWzprTZXeDXL7xvbGzfUcO1gL6wDWscQiBncFK8XqvyoWpAwz2mqRXVAa33Ae39zG4+XfbRSX5h
	wmj5bFdNarIrD00ZjQ==
X-Received: by 2002:a05:690e:e8c:b0:650:2ff9:d660 with SMTP id
 956f58d0204a3-65198a7767amr12034664d50.1.1776067115857; Mon, 13 Apr 2026
 00:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412161555.2568840-1-lgs201920130244@gmail.com> <adyd3Ud2Pl_KRl6_@hovoldconsulting.com>
In-Reply-To: <adyd3Ud2Pl_KRl6_@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 15:58:27 +0800
X-Gm-Features: AQROBzBa2pmk3obezMourkIfU8jvs5w0tQK3bUeHmsgO_W_ALcjIAu_XQYSC2cc
Message-ID: <CANUHTR9PP4rOK2gdH2KYOcwW58qTJ57W--pqHuC4GJQzriXncQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marco Crivellari <marco.crivellari@suse.com>, Ben Hoff <hoff.benjamin.k@gmail.com>, 
	Yuhao Jiang <danisjiang@gmail.com>, William Wu <william.wu@rock-chips.com>, 
	Terry Junge <linuxhid@cosmicgizmosystems.com>, 
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>, John Keeping <john@keeping.me.uk>, Lee Jones <lee@kernel.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235950-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,gmail.com,rock-chips.com,cosmicgizmosystems.com,collabora.com,keeping.me.uk,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BE2433E8C62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

Thanks for the review and for pointing that out.

You're right, the correct Fixes tag should be:

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")

I'll send a v2 shortly with that fixed and include your Reviewed-by tag.

Reviewed-by: Johan Hovold johan@kernel.org

Thanks,
Guangshuo

Johan Hovold <johan@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 15:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 13, 2026 at 12:15:55AM +0800, Guangshuo Li wrote:
> > hidg_alloc() initializes hidg->dev with device_initialize() before
> > calling dev_set_name(). If dev_set_name() fails, the function currently
> > jumps to err_unlock and returns without calling put_device().
> >
> > This leaves the device reference unbalanced and prevents hidg_release()
> > from being called. Calling put_device() here is also safe, since
> > hidg_release() only frees resources owned by hidg.
>
> Good catch.
>
> > Route the dev_set_name() failure path through err_put_device so the
> > device reference is dropped properly.
> >
> > Fixes: 944fe915d00d ("usb: gadget: f_hid: tidy error handling in hidg_a=
lloc")
>
> This isn't the commit that introduced the issue, though. This should be:
>
> Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
>
> With that fixed you can add my:
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
>
> Johan

