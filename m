Return-Path: <stable+bounces-260054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PKoXGw4SIGrFvQAAu9opvQ
	(envelope-from <stable+bounces-260054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:37:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C596B637209
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 13:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chromium.org header.s=google header.b=A2Lq++DD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260054-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260054-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=chromium.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6AEC3085EA4
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F734A797;
	Wed,  3 Jun 2026 11:21:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F63C81BF
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:21:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485699; cv=none; b=O0HS+ZVNOrhhMBAr9hs+pSh8DTkt5oLE2aXGEg0UjDQSqVexIPO9ibfsCT3N4uju9W9DA1AJNSuu5WKd/I1lDQVpuTTgEHBKcVoHsOPQMCA2oGRoQ2RVWA1EePhHhmrdMiqE5O4xNk9g4bJylq21RXB1m+o7pVqF5rRquN/3Gto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485699; c=relaxed/simple;
	bh=HTPmKUvNupQRiIlnkTWVHFoNHhl+8FOWGUotjzo8VPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF/UK9hUN0lZMeKYqW1u3Wt/NBbdRurgCJyYJ1BO3vYZxcxS4EpN0Lw71ondtBHe8xHcPv00g9XGtI4vAyirJ7khDMb4KRV0zhCV+JIyVtUwcXOrVX9G6Nm/x1L+fWpeuEHE79yepHnoijWm9huv0FJWVF1F+vcY/BwJasuMG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A2Lq++DD; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so10639673a12.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780485697; x=1781090497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmWYQhsLy8u3OL3FpmVNlvrqjfjo/sGOnkY3CQlMd0M=;
        b=A2Lq++DDUCHJAv9yVUfRW0XlkDW7wmzpJreeS6LOvJEPqQ/lqVr5WfWhZolh1DLyZ3
         rPxcELCmxAsCZLP3Ci1yuw2zl9oO5MnuhIqdt36oWWRMEQPCpry1ezqnt3pq4mHQWiXj
         iy1D+84B9TKn/8ZqCg4f0P0ZOZR05iKxYvb3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485697; x=1781090497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmWYQhsLy8u3OL3FpmVNlvrqjfjo/sGOnkY3CQlMd0M=;
        b=BukRMSX1hmuILQKuQ6JYXNIN+LYoaZ9+hpc9Dzn76VqTbmXxlxw2fK3A4cwKTtdoTi
         ywryIhco2C3K8nyQkOHXbfxNlmg7Ml7lW465Cvt6KFDMqCFES2GtbKZVO64iWHPLW8v3
         HlhDUHbj22Or9MWlnF3uKiuKvoY2ZqMbVOHYP2NBfBZACGyF/pUj1qaxYZnA2rvk+95F
         birYgEQ679XYbyYWIAHHKTSGXlXFbFyY7K4PKlvcoj96SjyFUZT8/bXKRhoBnk+lNm+s
         vJzEHsBuoxRrPx86CM+eV7uia41oFNNX1MH58AOx4Asit6SqFKo/tBQlQrnCO/2ULjNo
         X4Fg==
X-Forwarded-Encrypted: i=1; AFNElJ8/DcdtYWTAxgC0j+Q6nrrF7gEQ1qvTqDdXaEza187PqzOmOZOKWnhrhRoS1ZE4jubCc8hr2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/nx9W6aj7wczs486ioUO/Ih1Uaa9F5tCeVFq2nq4jwH3ptv+
	uJELdNjNKbn1IEZP/Eq1c83YSzdgfAtmOg/rRo3VP+qzKRHyuKmyuOgkuw7UMWVo49E0w/hDov5
	Mz236ng==
X-Gm-Gg: Acq92OE8Ibihkc9XSsUdR0hpW1b/u7Pk1FJm/QJCg4xIBN8A65IRIDjZ+X+8+nWgv8r
	/D3gjQJd8QgJfS2IvnbPaaoWEL3/NPiO+xH0aOB68gCO0m+bNBwMJbdMxmQpz3abZlLBKouAVwi
	LbhHobV0lXtwX0Lt6CGRnK/AiKr5a3kuK3A+NhsYu+Lh2d5fr19lb6oFdxw/GJ/Mrjg8x4o9MTe
	2RIcYal33jClGCmWeI+DEfEvfsjMM2f95r3i+9FTm0X/L/9+pvfaiEcsiM/GSCx+MUIVpcFNVYw
	wNiMWHUkRvJ9S3nhwB7H3xn97wRGjK9tv1+fjG1oB+yRy+Q2yulyplbG5r0YE+TvupwRIi3o/nJ
	2VJs7OxkZMVCd8d2Ku6ZXKWkvvcyHzd3ggijj8hRxpKc7VD8b1BJ9lzgS4wvnVG6G5Hh311B9n1
	VkuTbpigR2+y2Tt3jV8snjKUBfWw24Syt5NprXgzdzaUIcnqj5CBujLzTI8c6CFaMg/orPePY=
X-Received: by 2002:a05:6402:3202:b0:670:1417:2132 with SMTP id 4fb4d7f45d1cf-68e70efab58mr1450800a12.18.1780485696867;
        Wed, 03 Jun 2026 04:21:36 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b5726bsm989688a12.26.2026.06.03.04.21.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:21:36 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68cec9f4c6cso5697317a12.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 04:21:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UffLMpoTXr6xlm5nKScHvB0DY1D1K5ks7Q2FzHjnO6Gj+u1vqFuSsxf1k9VBpWJbcR/byWFo=@vger.kernel.org
X-Received: by 2002:a17:906:c106:b0:bd5:405c:7964 with SMTP id
 a640c23a62f3a-bf0b3dadc24mr156021466b.48.1780485695242; Wed, 03 Jun 2026
 04:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160224.570625122@linuxfoundation.org> <20260530160226.496219768@linuxfoundation.org>
 <5e2ac444-451c-4220-8013-0e6382b5f165@pobox.com> <136f03aa6f51bdfecc786e5278f5fd03b4a6966e.camel@decadent.org.uk>
 <20260601015021.rc-uvcvideo-heuristic@kernel.org> <CANiDSCvh6u6AWnarEtso=zKPD3upEsaJBMOm1x35fHyPMaEMyw@mail.gmail.com>
 <2026060104-customs-naturist-7a58@gregkh>
In-Reply-To: <2026060104-customs-naturist-7a58@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 3 Jun 2026 13:21:22 +0200
X-Gmail-Original-Message-ID: <CANiDSCsjR5NHqu_Ui5cOqWdJgFqmYsQ9WR8O7m0WOhngaYXFpw@mail.gmail.com>
X-Gm-Features: AVHnY4LaRyBJK0yrJYhC3WjO7GVxRuwz4FcveLyMZupXOph9y2DtgyUwl2vn084
Message-ID: <CANiDSCsjR5NHqu_Ui5cOqWdJgFqmYsQ9WR8O7m0WOhngaYXFpw@mail.gmail.com>
Subject: Re: [PATCH 5.10 072/589] media: uvcvideo: Use heuristic to find
 stream entity
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Angel4005 <ooara1337@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Ron Economos <re@w6rz.net>, 
	"Pavel Machek (CIP)" <pavel@nabladev.com>, Brett A C Sheffield <bacs@librecast.net>, Mark Brown <broonie@kernel.org>, 
	Peter Schneider <pschneider1968@googlemail.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Vijayendra Suman <vijayendra.suman@oracle.com>, 
	Ben Hutchings <ben@decadent.org.uk>, "Barry K. Nathan" <barryn@pobox.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260054-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:ooara1337@gmail.com,m:hansg@kernel.org,m:hverkuil+cisco@kernel.org,m:re@w6rz.net,m:pavel@nabladev.com,m:bacs@librecast.net,m:broonie@kernel.org,m:pschneider1968@googlemail.com,m:francesco.dolcini@toradex.com,m:skhan@linuxfoundation.org,m:jonathanh@nvidia.com,m:florian.fainelli@broadcom.com,m:ojeda@kernel.org,m:vijayendra.suman@oracle.com,m:ben@decadent.org.uk,m:barryn@pobox.com,m:hverkuil@kernel.org,m:pschneider1968@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,w6rz.net,nabladev.com,librecast.net,googlemail.com,toradex.com,linuxfoundation.org,nvidia.com,broadcom.com,oracle.com,decadent.org.uk,pobox.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,chromium.org:from_mime,chromium.org:dkim,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C596B637209

Hi Greg

On Mon, 1 Jun 2026 at 17:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 01, 2026 at 08:41:14AM +0200, Ricardo Ribalda wrote:
> > Hi Sasha
> >
> > On Mon, 1 Jun 2026 at 04:11, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > On Sun, 2026-05-31 at 12:53 +0200, Ben Hutchings wrote:
> > > > This doesn't properly fix the problem.  Commit 3d9f32e02c2e "media:
> > > > uvcvideo: Create an ID namespace for streaming output terminals" (which
> > > > reverts this) needs to be applied on top.
> > >
> > > Rather than carry the heuristic and then layer the namespace rework on top
> > > in 5.10 only, I've dropped this together with its regression source
> > > 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
> > > UVC_INVALID_ENTITY_ID") from the 5.10 queue. That mirrors what 3d9f32e02c2e
> > > does upstream (it reverts the heuristic), and avoids exposing the
> > > 0e2ee70291e6 regression that would otherwise enter 5.10 in the same batch.
> >
> > Are you going to apply:
> >
> > Commit 3d9f32e02c2e "media: uvcvideo: Create an ID namespace for
> > streaming output terminals"
> > ?
>
> It wasn't planned on.
>
> > We need either that patch or this one: media: uvcvideo: Use heuristic
> > to find stream entity
>
> What id is that?

Sorry, I should have been more specific. I am talking about Upstream
commit 758dbc756aad429da11c569c0d067f7fd032bcf7.

(this patch that we are discussing)

Regards


>
> thanks,
>
> greg k-h



-- 
Ricardo Ribalda

