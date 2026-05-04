Return-Path: <stable+bounces-242871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I+WJNlY+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC14BA399
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81AA3306D0C6
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E1331A6D;
	Mon,  4 May 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foVmCKOb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451C3321B1
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883152; cv=none; b=JbzWD1BuQZljA1qZYtx4WWDQL1EB6LkkOIF5eN/wSdMTwnVK0XAH+wc84ExFyhHrSgW6gENWkBokiKEGbevu44pmEdw4wqOW+Zdqq5j2cFZdy3PO84h8e7v1ECO2YBCBBT4aOI2hr2f+1HeDveYs1/WT5g0ZFpbis8rkXUVBO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883152; c=relaxed/simple;
	bh=G0HlUpP+L59SM/PgS9XrkbbqRt4wRveUjJziSIIppL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/b6OhhMU33nPlU9zqTQofabBB9e8NDFN+YdGZMEG6NkKGf7csI1rq37/mPM49MJDcnET2DT/Qo+cKODM0ZRFPCzCUJTLpAH4bQ4o5Y4IV67YMFWCf0raiVdMgJN1BUffSQvIzTHkjx2y/qee1nl8ittnJ89TGz6VAXtnKVnKlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=foVmCKOb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso489477a12.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777883144; x=1778487944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9R8zXqHCtcGHTYvHcfHWaBjDK5mDDl8ovVVHVrbBYhw=;
        b=foVmCKObcKLZeyoZEq3WGlFNPTnzkdRRGZkDiXi3U97qO5ZcJjJeOXpK/bAfipWQc2
         yiobeiMY/5nhbCEjV6RkOuHYJO8Z1Sl0ewnwBNMSOJoQjTiUFh1y9ifNTYN0dajBSfwQ
         CGxy3HcFuYQ+EpWoPRXX5WrnahOwLH06ILtEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883144; x=1778487944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R8zXqHCtcGHTYvHcfHWaBjDK5mDDl8ovVVHVrbBYhw=;
        b=ryq8z4Y4A5KtWXY1nqunYxKQRtq1g8S91K8loN5NBLMFL/DksaHAJB7yLuzXOEM5Qf
         QifrogRUtUixCyjbv+Pvci76SrI3SBQoi69LL88WCTAZPRO96WsnP8L1kW1D1eHm4KYv
         /9WtsJeAlb+zcSAYlOKIS085Pc5WVzYL4Knkq2kz9DhbBq0FeJQyLtMPRNio8b7usBC7
         gRVdmngNI70hPtL/qfaKeDei9s9ICeLtFesglq84xL7hVe1gaTgQk+r+20FnHxHyIVgJ
         rVV8ace7W3C+k7Y9jZbmk9YtiUykJwFWYiwz0EG3ugemRsZ/p5aaTttRuIP3wZUVYO6P
         4/uA==
X-Forwarded-Encrypted: i=1; AFNElJ9Sx/GWt+GJBgG9oOvj8Hpv4aYwV//19/gGfFf3D5MQluh1P63Kb1klU7D+NoqTpvc5H8G4ou8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMu1aqEDmIzamQBd/SNNpPGU4kydaf5G0tacxl5K2bMOE7Uks3
	+Vk6oI5Y/iC+krlXsKou9iygbjVUA276+ROr1+vbY2zTLvNr569WbMb3IPi5YnmrjtLP8QiBKVP
	eOu7GoFz9
X-Gm-Gg: AeBDievyXqrsuGelOHN04twyOReAWw1rW7b1c+IodIEaHvAOj96TG9sdlehlcvupe1Q
	g/bxb/HMuODjdEPoeoP0SVPA7HY+3Ht7jChTTwIt6E/36ijUh5zPADZY1h9anJFfTxMGY4zPscL
	Gms/Mkdxo1iuNUoD1sUynqolw7ugbOJQv1oLPKOrnIyf1iAuNMqxjbhgTTtESD9wv+diG+wfDub
	vQIGoqT99VXsk7xGhnQAy9Eu6x6PgmdWXUhJWN+bXAvPPGYHF/cRXnuvMsVO103IdXSjV0L/mkj
	IKRVK7e4o5s1kt0T1voo2fACKrINOGEjjt6SNBP1gPTofghAYue3FQ5QAZYuf+L6DdBsKBo//fp
	xw3t6zPM//0LFFSG2NYg+OSBse74s9UuaX0Hrj0jkktYHBzsu7b5eF6k4Poz+tpw/y7hFEZo8R+
	Fg6/jD2VEE4OIYzG7kP3ohWZ7WjB5ZTYkUEOXRDnTeT3c8aTgisI8Pf4DeHVLI61RS2Wm2n9s=
X-Received: by 2002:a05:6402:1515:b0:670:b72b:4044 with SMTP id 4fb4d7f45d1cf-67c1ada377bmr2548086a12.15.1777883143902;
        Mon, 04 May 2026 01:25:43 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b877d5ab2sm3219987a12.14.2026.05.04.01.25.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 01:25:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so6526661a12.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 01:25:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+DSzL5kqY/7s9dqvfu8q9n5/B3xX2H+xEaWoE5649bucKlByFtzNQ9TiZQqFqIwx9sCHAhH0o=@vger.kernel.org
X-Received: by 2002:a17:907:d87:b0:bc1:a5cd:9a67 with SMTP id
 a640c23a62f3a-bc1a5cdb3efmr195866666b.34.1777883140796; Mon, 04 May 2026
 01:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501-smatch-7-1-v2-0-a2fcfb2531ac@chromium.org>
 <20260501-smatch-7-1-v2-5-a2fcfb2531ac@chromium.org> <afhXQOcJn11-UGCq@kekkonen.localdomain>
In-Reply-To: <afhXQOcJn11-UGCq@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 4 May 2026 10:25:27 +0200
X-Gmail-Original-Message-ID: <CANiDSCtmjKu2rcDCyCtZrnv4obvY5T49NUwDS7OTRRpn6NUEdQ@mail.gmail.com>
X-Gm-Features: AVHnY4ILmFd1TWdg3HI0oqY9t2ArMATGJOzQAzGapqrP0BhJPZ6QfuhOAXwot78
Message-ID: <CANiDSCtmjKu2rcDCyCtZrnv4obvY5T49NUwDS7OTRRpn6NUEdQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] media: staging: ipu3-imgu: Add range check for imgu_css_cfg_acc_stripe
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@kernel.org>, 
	Nas Chung <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keke Li <keke.li@amlogic.com>, 
	Yong Zhi <yong.zhi@intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EBEC14BA399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242871-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,samsung];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,chromium.org:dkim,chromium.org:email]

Hi Sakari

Thanks for the review

On Mon, 4 May 2026 at 10:22, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Fri, May 01, 2026 at 11:32:50AM +0000, Ricardo Ribalda wrote:
> > If the driver's stripe information is invalid it can result in an integer
> > overflow. Add a range check with a WARN_ON to expose this kind of
> > error.
>
> This would be an underflow, not overflow. There's also no longer a
> WARN_ON() here.
>
> I presume this might not be the only such issue in the driver.

I have updated the commit message in my local tree. Will repost in a
couple of days to allow more comments.

Regards!

>
> >
> > This patch fixes the following smatch error:
> > drivers/staging/media/ipu3/ipu3-css-params.c:1792 imgu_css_cfg_acc_stripe() warn: 'acc->stripe.bds_out_stripes[0]->width - 2 * f' 4294967168 can't fit into 65535 'acc->stripe.bds_out_stripes[1]->offset'
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e11110a5b744 ("media: staging/intel-ipu3: css: Compute and program ccs")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/staging/media/ipu3/ipu3-css-params.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
> > index 2c48d57a3180..92cce31e35c5 100644
> > --- a/drivers/staging/media/ipu3/ipu3-css-params.c
> > +++ b/drivers/staging/media/ipu3/ipu3-css-params.c
> > @@ -1770,6 +1770,8 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
> >               acc->stripe.bds_out_stripes[0].width =
> >                       ALIGN(css_pipe->rect[IPU3_CSS_RECT_BDS].width, f);
> >       } else {
> > +             u32 offset;
> > +
> >               /* Image processing is divided into two stripes */
> >               acc->stripe.bds_out_stripes[0].width =
> >                       acc->stripe.bds_out_stripes[1].width =
> > @@ -1788,8 +1790,10 @@ static int imgu_css_cfg_acc_stripe(struct imgu_css *css, unsigned int pipe,
> >                       acc->stripe.bds_out_stripes[1].width += f;
> >               }
> >               /* Overlap between stripes is IPU3_UAPI_ISP_VEC_ELEMS * 4 */
> > -             acc->stripe.bds_out_stripes[1].offset =
> > -                     acc->stripe.bds_out_stripes[0].width - 2 * f;
> > +             offset = acc->stripe.bds_out_stripes[0].width - 2 * f;
> > +             if (offset > 65535)
> > +                     return -EINVAL;
> > +             acc->stripe.bds_out_stripes[1].offset = offset;
> >       }
> >
> >       acc->stripe.effective_stripes[0].height =
> >
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

