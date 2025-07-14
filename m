Return-Path: <stable+bounces-161833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD2B03ED4
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BE1749F4
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02514248894;
	Mon, 14 Jul 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ns/X6vcH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A09C239E69
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496630; cv=none; b=qSQ1ux5JNZRCvF8U78fPC/hdv0omkSvjijR41CInt6HTRB9IgyMSeFUI9gQFVzCFclJboPfAgCuiIoEoOGNVXn/66Kvd4KS+cNDsIxdWAIODfbEo4vn3d9scWnAEkxuaEeuHH0Q+2uPhSkEYruikIp4qPxqAUilNwdepYoGbWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496630; c=relaxed/simple;
	bh=ze70y/U4LiuMguEZ/qbQTQRs/404X4FXJWc3lUugnLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xzu3SzGRWx55mLetHjc8Qoj+68eectJJrn5AksFemtpWQXb1MLg396G6+fuP3si6vkkAQdSvhR2eh+M5uOmjulkafBGXNbd8OkQX5orAD6N8twSghybNovyLbZPB0RoPCo+pKKD940SbwpTdrhQRZvAj4Ti/FJqAVAaSwn91Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ns/X6vcH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso893433866b.2
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752496627; x=1753101427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxQWwN5893QgqEKCT5i+8flzUyp8H+JAUyY8KUUtFSI=;
        b=ns/X6vcH7/a9HKPSi/1JrGtCGOmx66CKvjHInTAJv5EEUUOrBQPtUf2XUyQXEhKn13
         5x5SLN0Z1l6Vva4K1JJSb6ypwg+tEIc/QpMyYsPeHUs5EpgouXxcH0QXFlSuQ95OBCmn
         BMOdyvqWHxfgjaRoLL5+zA4nqRSEKwNLzL2+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496627; x=1753101427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxQWwN5893QgqEKCT5i+8flzUyp8H+JAUyY8KUUtFSI=;
        b=Ga33u5qJxxffcOsfcFv0aVGZulTsBmzh3qnegTRmKIYkVHhsSmUO/rg4+1S3gFuhS3
         h9Uby5u8mU1LPvwYp5TEjhUlQTcGL1fYXgIMxosUsCZk6/q9Ye8FD611tj64S7cL9U7V
         PChifQjK14uYonLh1OlVQkpY+KsmbNc+nwWlsPc9Y+32MJLPGinc66TcK5ErdTP4Sn0A
         BOpSAzNArv0RrsnieJaReWJJz3BtA4rDZdcKXlyd7zkxxdhZI670twrQdsfY3gqoaBep
         cNr532UoKKrVqbA5yRgPEGb/0evXLgRIwEyGu5gEKi2sbgYDdOE2I1YB5jn3bsnr9/mc
         hXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoqzAxH6YeCRMdfNzFlwEiaGdopSAeUQOlUiHGuaKD5KvLwkH3v60hZ2eDnssKyY8tBMoax0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoU49aX/XK22MpnzinY0YRZFtIrJy6b6jRdWlMxKpp0bSSbzMa
	tOC7aBTA6+uscy1dqreTYDM4Wg3CpkUcJUmyD1eKD6lDgaW8YC7eht3PjejZkGHCUH6lFGt//PL
	17fQ=
X-Gm-Gg: ASbGncs5+CxlzngNbPjyvwFjCoVdeSi4lQYPcGfPmep3flFtep5MQcL72updAugWq/8
	WSoTxYwyV+l919RRQF/KM/o5mdt9UIz271INCG2lZaS1sHrnLn93iwqCTKGui3uNr3b2pNs/Fkv
	syQQc+YQhJnomXLjKD2BOw+KYaUPdu2+a7tkdJCBdwqmZddzd47fDeIr4djOpWnCLxGl4x2vneO
	4SIYxc8SZX+R7yiKWJo00BvTcvlsEkKgBnyWLFlYglh4BHNkDcXVc4+OgTiM9Q/W7Kpv0MTfoQa
	nH0qvk9cj5o17l6Xl35yB6huXwOZNPCkDZbmAjxwMbJVeKSxmFNRgQUMMVe2qkepGRjXJbI0v3w
	tokw6TXsFtEbuK2rzB3YjKdhEPF3T9WAek7Bxe7S1gAmhaoTS2JlQZSRNHTjnsW2h
X-Google-Smtp-Source: AGHT+IFinS6UnhS+4UmDcxWcmfCuNtPSuyhQlTZeWp3B8XNS9JGlDS2BG/LKWqR+hBYlCBe5tqRoGA==
X-Received: by 2002:a17:907:6e90:b0:ad8:8719:f6f3 with SMTP id a640c23a62f3a-ae6fca5bb7bmr1395424766b.22.1752496627081;
        Mon, 14 Jul 2025 05:37:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82952d2sm824155966b.140.2025.07.14.05.37.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:37:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so13090a12.1
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 05:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTvxBi4V7AI73EtN3w+fBeCe7oJOSbcddTh5PKwJon4EJB5McR3DoyQ8LcMYSzMCuDL5Sm7Xg=@vger.kernel.org
X-Received: by 2002:a05:6402:5242:b0:60e:3d45:c65a with SMTP id
 4fb4d7f45d1cf-6120ca85d1cmr158081a12.5.1752496625328; Mon, 14 Jul 2025
 05:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org> <2025071012-granola-daylong-9943@gregkh>
In-Reply-To: <2025071012-granola-daylong-9943@gregkh>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 14 Jul 2025 20:36:29 +0800
X-Gmail-Original-Message-ID: <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>
X-Gm-Features: Ac12FXyVzm_ojEyrAQbgVa06K6s51wQivdJmMs1O_Fv6DwV3kcnfZgVpo_aFCek
Message-ID: <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 9:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Jul 07, 2025 at 06:27:10PM +0800, Hsin-Te Yuan wrote:
> > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > w/o trips subnode still fail to register since `mask` argument is not
> > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > pass the check in `thermal_zone_device_register_with_trips()`.
> >
> > Set `mask` to 0 when there's no trips subnode.
> >
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> >  drivers/thermal/thermal_of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.=
c
> > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd=
744725121ec7fd0d9 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_=
register(struct device_node *
> >       of_ops->bind =3D thermal_of_bind;
> >       of_ops->unbind =3D thermal_of_unbind;
> >
> > -     mask =3D GENMASK_ULL((ntrips) - 1, 0);
> > +     mask =3D ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
>
> Meta-comment, I hate ? : lines in C, especially when they are not
> needed, like here.  Spell this out, with a real if statement please, so
> that we can read and easily understand what is going on.
>
I will change this in v2 if we end up going with this solution.

> That being said, I agree with Rafael, let's do whatever is in mainline
> instead.  Fix it the same way it was fixed there by backporting the
> relevant commits.
>
> thanks,
>
> greg k-h

`mask` is removed in 83c2d444ed9d ("thermal: of: Set
THERMAL_TRIP_FLAG_RW_TEMP directly"), which needs 5340f7647294
("thermal: core: Add flags to struct thermal_trip"). I think it's
beyond a fix to introduce this. Also, there were several conflicts
when I tried to cherry-pick 5340f7647294. Compared to a simple
solution like setting `mask` to 0, I don't think it's worthwhile and
safe to cherry-pick all the dependencies.

Regards,
Hsin-Te

