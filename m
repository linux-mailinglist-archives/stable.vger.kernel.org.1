Return-Path: <stable+bounces-235508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPj2KBck2Gm9YggAu9opvQ
	(envelope-from <stable+bounces-235508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 032093D0278
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EEDD301E96D
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE26387374;
	Thu,  9 Apr 2026 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="fRu538Vv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F437A488
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772653; cv=pass; b=boprChF6akVu8HFOqgJuBniXco7Dc0k09ok5MIssP3LwgAft9SgAVl1nIomz9yQsobIO1rG3wAtrg6g7OWNCAGMsV8qrHvghxmIg4q6wXvne46egCRlsNOMvduOhh2fwyGSm7WResR8Iz3R5yM8DbPGK3KoTHAyxCtTvuZs4Fiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772653; c=relaxed/simple;
	bh=pvLC+N1HCWas7LKGP2ULVAeMtjStgVNUt66QEX2BPBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ybtakpxg7DDRFAii21XEG2b8Aw9lOe4qBBvjc4lIy4lvaWx2w0jNi+secj1ymyg2cACTZTGXB6zzPOvHX6qbOSAyWtPXgx9Jbchxrj95NOjZp6ATMFt+7PxnZ8RSR/xj1xC8hLdQl4/7elO5yo7zLiPAuH0cNe7Qfw2chknDkoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=fRu538Vv; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7947cf097c1so13878467b3.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 15:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775772651; cv=none;
        d=google.com; s=arc-20240605;
        b=TJ9tVp/WubDjmRU3gDsKpsVvpxXwBPNK0+ZP0hggwNo+inThX1AGOE7kgLs3XR71uo
         EtWnoT639n+BcgV4VQ0arjCQdHiGYNh7P+CRKi0PKizmSlOt8day5KlN72OsQGaHffuL
         WX3kjjeoyJYrsaxT9dJB8P74XXTgtb60QmPtRG5MAKT5fRqFMyhJA8VCfVRSQaspLY2j
         LxXzSXutviHsdPYSPZyWT9wli+OhGtu/TRXZuHnUxcj9mPvtp7uPS6yrmiGkjaI3DXJO
         uIbuDOvbAR1Qzfrohcf393uW7Ks2YuZ0qp+KWCa5jOUB+e5oltSAiO6jWQdh+Orc/pa6
         ZnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        fh=QOnmtXFNrXLwU3q9JcnIXJJZHp0yCXfu0rPpmihNh9E=;
        b=BJ9eHyzKNvPAJKgoZTLgq6pfxupX3Z3XU5dUq6wTkGuDtB4/bKUYW0CJnao64rfPev
         IIbaJHxayW4LVyPEgfc7NIJDSb4DBT09f8CA/MgQ6AsgGUZuWHehpOjhTzEI41H2wS6X
         oI2lCCdhKxvRQ+5JwpitoLhZVhBzMn8GYnLkWQrnA4euwbFs6m8GuEk4B6dY3gH61Zzx
         JvpeKTU5Pch0L6/Hxxk+tC+YQjebfIjpvBPro2L2GK4ExsQtuC17rcFT1Bq54rXrpIkW
         lEqXloUx+iiUImzeMaYKN35aZXryzOGuT63bAs2qCetuR8T8AiBjQeEPhEqeIB6nvxlr
         tW+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775772651; x=1776377451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        b=fRu538VvVE+2Gdc0MlDGMuSdwacdxsDixwC0L8Ta82RZVTc8ZPk7jd6yMwGWH23MJf
         Fn0zzacQGE9/NU+S8lZQxdBE6vd9eAvCI4K+iYt5UM+7dZhakTlEi7Sq/PCqUokC6z2J
         wyz/iqhtfRFhpis8lpZqRqBk71Zx4D2dZtrvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772651; x=1776377451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7nLB0Zeb5lwRxxg4uutHdC1hXI0lpZf22Utas+BEjE=;
        b=qEOJOCDU900BUC01VIPgutSW5sk+5sY5lxzUgtAMKPFoKrgjc+ZopODoQ4qReJIfhw
         eDMDX6rTEn4QYvihcCxZAcHFloluHsNUs97KoMVAaiWC9z4TYEPywP/zYHGon60jNQyC
         XihyskakyL4Q1Oxnfh67+01g39q5Q0Hj7zsC5qrusZINR2S2TQvOhsaIgCjqCDYfWU1N
         /2OOJAc3GHCB1lPa1SAsdt3GJPwwlPN5EKyB6UQ2XqJyZrRH78EyZRKDMyhLunzT6gg3
         OWP5LPyebifGYR2GjtPki1wPxRs7mzLUEfyEeB+59AfJEj6Ds+QQoSzNQ/n+bp+VMJEQ
         xarw==
X-Forwarded-Encrypted: i=1; AJvYcCVLhUC8X0wk7eAYJ1xI0USywGhul80kMNi+xSsb0khQUJYnpf7X0aIs6lZWKUo1UGsC+L/Srik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX83//LFefclzYyaQp/fX1Blxm8XUXUfwfwXo2PibLXWGj4b/V
	Jg1q8LTgGg9hd9sAD0gYb0MeDd+emjA0kHpI0NaytZhOaEdWO7blAOCUBk+hZqeLu4uUl4iJkao
	elsB2v5KyR7zlMOyWN4HqdmdrCbjw+u4juJj1sq3ynQ==
X-Gm-Gg: AeBDietVlFJuaLFbG9HEjgPErQk8e+H9fmZIk0V9fyHaKtgrOypVq0LCkxWa8prf39g
	ODyfEN9wL+r/TXXCCwJtA/47oyWMDutOY5JWBG8aXN8x984Sd1oUjbUmB7Iobz/+JE4SBX+NdgV
	dP17WQm7LhzUVvgyHgKjpKsGX1gWI8aLtrPUvYzIX5divpkRZ4uUBTSnI3z+jwWsUp7mQmweWD1
	6GzIwUOiKeoC1Ec88JpzFfuGgb0TB49sQrd0ZW3P3oqtxgcO9Q02mIFdmivLhWix3FzExkdB7ux
	ZOFPfiWI6NoD2K7gyYv2yOPOEaX7Lt7kp7IWB8ZViw5q6AMWYwjN0YrZPqfb+qoDLe/tSJs/1y2
	tTjgxdjbX3dwMJM+Ffuo+bNt7GCidWGCjRKXv4fkeJs1mz32LeGLHvlZ9JUE+O7g=
X-Received: by 2002:a05:690c:48c8:b0:7a2:a8dd:1660 with SMTP id
 00721157ae682-7af72924107mr8482167b3.54.1775772651068; Thu, 09 Apr 2026
 15:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca> <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
 <20260409151559.GR2551565@ziepe.ca>
In-Reply-To: <20260409151559.GR2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Thu, 9 Apr 2026 15:10:40 -0700
X-Gm-Features: AQROBzCfblFwr01-zmTarnevR0J0ekwUJWkBIPKJHL8xbcIaYrBhFucdllmVowE
Message-ID: <CAAJpGJTTBxSmivhC0=LNYcO37YGnKWFGREbSEq0dVbzt9s_-pA@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235508-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 032093D0278
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:16=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 06:40:05PM -0700, Sina Hassani wrote:
> > On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > > >
> > > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > > >
> > > > > > io_pagetable *iopt, unsigned long start,
> > > > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > > > >
> > > > > >                 down_write(&iopt->iova_rwsem);
> > > > > > +
> > > > > > +               /* Do not reconsider things already unmapped in=
 case of
> > > > > > +                * concurrent allocation */
> > > > > > +               start =3D area_last + 1;
> > > > >
> > > > > area_last can be ULONG_MAX so this literally overflows to 0. It i=
s why
> > > > > I formed the suggestion I gave as I did
> > > > >
> > > > Yes, in which case the  if (start < area_last) that follows will ca=
tch
> > > > it. Are you suggesting I compare against ULONG_MAX instead?
> > >
> > > iommufd does not have any overflows to 0 and rely on it tricks like
> > > this. You should just compare to the existing iteration last
> > >
> > Just to confirm that I understand correctly, like this?
> >
> > +               if (area_last >=3D last) {
> > +                       break;
> > +.              } else {
> > +.                      start =3D area_last + 1;
> > +               }
>
> Yeah that looks Ok
Sounds good, sent you the v3
>
> Jason

