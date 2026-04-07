Return-Path: <stable+bounces-233725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APw6GXuA1Wn36wcAu9opvQ
	(envelope-from <stable+bounces-233725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 00:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF53B53B2
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D176030CA8DA
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670637F73C;
	Tue,  7 Apr 2026 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="W2HJaC3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C537F724
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599453; cv=pass; b=lkWrdJA2cVzOJjUCJjnvDK3K4RSRf3ZrthGNbstCd+HpyDK1hZ1J2A6Mo0TXSontyarvc/WTJlWJeJ2vdDHdqYAXQKCg1KaoTMMcjpwuqOOATD30TdtaBd/vQI3JpRaFKMqqPUieTsXD/DFX4roGKI8w+WqtJTn5NWC96RIDGeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599453; c=relaxed/simple;
	bh=J0ok1UgS2bPn5V58cGyuMXbk6aARtIyxbOkZy2VAM2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJUo8ZAHqTYvzzpqUnrosjemXc0kcr8ZwvMSCjZzSmropy8H1UTPbFRDhkYrE9JDj9Qg/PgPCRVbqnT3fn6BlL09kNXXEERt8UbYhcTC54KM+zPAjb/jd1n9SgO2w8d74Dd2JXixjEHiHu72TGhIF3NA/3uoMr6mh37gM3sYYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=W2HJaC3o; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79f855b2575so56297127b3.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 15:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775599451; cv=none;
        d=google.com; s=arc-20240605;
        b=g2GXZMyr3874iX+et1BhchduTqNKqB3E04BqV1ijywq5NusOgJjhF6we4FZUYrIs11
         6X9ACiM8W6datLpGWZy+T2Pbjf4OeU3l8BeAG00gLeQSILg15WEUkeX3lHRGmPdGDMrO
         sTW31dsw+CHEMGaA24AGgwSLLJ4N4NJuDMew6T8ejHbggiHW9QMaYOBp8UKVpMwWuNO/
         vpC2gYhDJ3mhUvqUUIQ4ZCUomrSL/bmywGQIq2BVmX75QcONDkXKVLp3x0QCC9g0WW4D
         rSVBtqe4rIywRE/nO5ueF+u7/Lni7k0o+vO3xcixDou75FbI2gbQzDQQYVRM6OMbkpv9
         8i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        fh=TXnJ5nS+Xj6u5bvH2fUvetOUWIT6NyERVG0vxhhbkzQ=;
        b=SFO/IR5rzNO6wUyvvH2SARNcIsoWo6IGj7bpr9evo5CKXcVA7bamWvtRrVM4wco8dv
         GYNNIDnLv7/ofN7uF3g7z5bogAw7/VL0TbP6xiDy9Ul9wK5kFq+LrJtRkhIvtpikiWss
         R+aZL78kBRzJ+BvJyporcca2WqFjKuEfpTfP4Lz1tzeU33dhZgG/KrVQqhwtDKVhglXV
         KOHOig0VKbbjnecjhUs9HNBoONV8N1MW1BBC6tL578Nnr7QdVdbKJDT/918evCl361rs
         M7PWM6t5caYcQ68fVWmdlHyqjWG+Si5Ut9RNBJdZxCohd4Xs0qRXKI9RJXICTxvuSZk4
         HWrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775599451; x=1776204251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        b=W2HJaC3orwL6Ns7bSa6hTQ59v0tAdjBBL7Sdp42AGFdIhThNwqDd9rEjx23xKkMZqP
         7tzbIZluTLkkTrHSNzu3oMsOOaRigvYkbMY0ljn6+3otGwZCn444Kr9EhyiVlIFZv6Av
         yxTsgutSHSZZzRZRrNaxn//VZxG0fH2sHxAtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599451; x=1776204251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtPj7Ef85yI425sjR5PAdJDDVT9TZGTbmZEYRDqH1RE=;
        b=JiX2VQv6x0PUMWRW0i7t2SiWQeQcg9EI9B5fXh91rycxVf24yKhKOfX1bzWUBXGMS+
         ULm5xF3O33l1B3RwcGluGUAfARpYUmcHqII7zevbcwhbk62mN9uw1y7+ZOGLKQdrdx5p
         kmJW/HwGZvpiWfUlgb9IfVf9QBtZrVIKMR18lC+glSzBt4QZivWZvhixftWEPRG8DrjX
         e7bWP8HMHpxij3pL5VLlk6mD6rHt92WNT/KitJUTbZplh4sZF5OcQ5iNikf2+4M+pYHm
         K8DCHlLgRqV8ENHfJ0ss2xybiC2I0Aa8aIZqkintrcQGkUGlcz3hDaySuSP2mvLNAZY9
         wcfA==
X-Forwarded-Encrypted: i=1; AJvYcCUrd/9jNglpxO31dZHYRc+LquapCnplZpRGrv3IFCM+1oxzIbf0k8ki6Yej9ucy5+tRneLnLRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVGzbTwgRukXFrva3W8ENdHYa8xsqBT9h1PddmlqCEZm5z4e9
	NL4oha4esbqt+NzKrptWLwjshpYoxp/IJ6qWtduX+3zp7ONtAgDis5yMDTPY+Rt94zrUTNl8oCZ
	6iWe/3BgoGkHRjpQvEG7Fsmtlo3jMRKKvI9SD396Ldw==
X-Gm-Gg: AeBDieuDkROwuOkosO5DK9GrVNGQtyp4UYyIliCV251K8h1LoMLIT9A1F17uqTWtlxy
	I6NQcvBJiB7JT9DtLqP+eVSzpNG+QltGv4d7fkMrguV+xqyfoMcCyVcHmWCu6rkhcdK/hayDQSy
	TZnwerhZe0CXYnhF7HNcOpCp4FqL6NYNnMpZiUwF0Us2J8/FHk3LI3sKAsRl9X/sltxfGJVbWO+
	xCbRpi1ClX5qPaf+qRAEBNyrSn0SGKBN4tsJ9m5as5k0iQWNubDv9F4n2Ac905hp+MdExluhcnV
	Ect9f5Xb6VF5zO6nUKr4BzIv/CEts6YVKhTNPD4qYOUAzpOyisd2mnOcqyIh8wzNBRRGC8bwR5C
	CWfEbdNDgzk3Y2YRSAl+IZeC9p1LtxYG0Dfpc3e+ZdEOJXeLWVhjLEREtAbLF7VM=
X-Received: by 2002:a05:690c:6891:b0:7a2:4cdd:6b22 with SMTP id
 00721157ae682-7a4d5f5389fmr191889267b3.39.1775599451147; Tue, 07 Apr 2026
 15:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca> <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
In-Reply-To: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
From: Sina Hassani <sina@openai.com>
Date: Tue, 7 Apr 2026 15:03:59 -0700
X-Gm-Features: AQROBzAnPVkw7OB8rG_YeO6I6vQFGrIE_41cIYIVP5BqIXerL2I7kB4wz6TnJ9U
Message-ID: <CAAJpGJT4YyvoT88qVJ4oLmWQXG8GfnGQdFSTXBmHh7X2v+kHsg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233725-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openai.com:dkim,openai.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D3EF53B53B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Friendly ping

On Mon, Apr 6, 2026 at 6:40=E2=80=AFPM Sina Hassani <sina@openai.com> wrote=
:
>
> On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> >
> > On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > > >
> > > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > > >
> > > > > io_pagetable *iopt, unsigned long start,
> > > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > > >
> > > > >                 down_write(&iopt->iova_rwsem);
> > > > > +
> > > > > +               /* Do not reconsider things already unmapped in c=
ase of
> > > > > +                * concurrent allocation */
> > > > > +               start =3D area_last + 1;
> > > >
> > > > area_last can be ULONG_MAX so this literally overflows to 0. It is =
why
> > > > I formed the suggestion I gave as I did
> > > >
> > > Yes, in which case the  if (start < area_last) that follows will catc=
h
> > > it. Are you suggesting I compare against ULONG_MAX instead?
> >
> > iommufd does not have any overflows to 0 and rely on it tricks like
> > this. You should just compare to the existing iteration last
> >
> Just to confirm that I understand correctly, like this?
>
> +               if (area_last >=3D last) {
> +                       break;
> +.              } else {
> +.                      start =3D area_last + 1;
> +               }
>
> > Jason

