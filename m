Return-Path: <stable+bounces-235657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHRxNtxC2WnCnwgAu9opvQ
	(envelope-from <stable+bounces-235657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:35:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457413DB7C4
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C0930342A7
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8E3E024F;
	Fri, 10 Apr 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="O0Bvc2aL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C43E317F
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845993; cv=pass; b=nRDINvWqp8fVJ11tq5u6xumToCdfoe8pa/+lZvpq5a3K7azjPvd6BotPtu1bKdOTFFHME8W1HcPuUPwgjPeQgbi24dS/ussN0/LVn4IccSziLFsCmz4jtkQ6Lzuw0qOYUrSIzaGbNgU7pvwVtYhUg9YyPdinirI5c7Pyk6Y9Vrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845993; c=relaxed/simple;
	bh=bjLxVnOZzU/qm7UB5DlwY9dDfszNtgL7RNt+HQuKZ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwskB0DKf2MBXGuA4F+r/6NDgfqvknzHFp8zarzhqAqkdVzDXOv/6xT2w8GIVSo9L6VOQ9zv3YMaeO4EufKlWsIfevvxF9UjIg83MVRGqs+rIyxPYlcvLeOGUtXMNWi7nbClc3iyT82RM6HU0fyPlUe0T/oKTNHhMOgj2GfmVlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=O0Bvc2aL; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46260385so27617477b3.3
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 11:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775845991; cv=none;
        d=google.com; s=arc-20240605;
        b=X5dINoD8dxWxk6sZRorgqe+W2Sp5j8oDwrfY22P/kqQDj2AxD/AmpEu1QwJcP8dF+D
         GwFcnigNnGWim6Qp04pYv0QtzRA0oXFcPJRxm642l2fxS6z1QgIYN/Cs6C62VzH+lLed
         9l13SBrDurOWrVnv20Tmo1zVauPES8F0wCtdoKPWDgD2FCZlj7HKo8rvVIqUpO9G/ska
         8DVNbuRzYgUUjkPm36DDFJQ0NmkMVEcW48Xx/iHTy2uhe7U+j/N3Vna/NOkEwUNzF7yV
         /resXHWjzTmIGf6TF+IigzDAL3/RvvW2NS7fha4W10+06C/PnZMq7bQTlI5TZKIeDep9
         0EOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        fh=XG+kGK7yUiQnpzQPOHftegnGp9w/wWfCNd6+03YAvvw=;
        b=lsYJp6Wlw//OHsWhcPDetnwt7Av0V8nd1VsTU8ROXx3S6MCrqOGyRpJqwJaCJZarnI
         kuhLSCZvDfOJ5+5qeQ3WIjyjZcPdw0CDq9DH1xX7Alp49fqSiiph1FdUgU3o5ThPcdJs
         4UavMQzoNW1IcKgZZ7Fo6lRMRgiG8BCY2IOVgVX9tUw4iTLt6jQYoqpurseInenio44A
         dOdNRHyd4luFWmrG27DnIyiv4qvyNdnBdNMaQFlDUcU/thE9L/O4NPOePGZA1sECy8Gb
         kgXfhnnYq9sNypd3Togv/cxOObMgTGMlGkCAoVTHBk333A/30fAhI+dRHSOAyFT3rAjB
         VAMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775845991; x=1776450791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        b=O0Bvc2aLOQjBnmqmW6Tp0yAn+D4mV1cHTwdXUwTkw4Ol8d9UMwzL0CA7j/y73PYz4y
         iJWa25Dfg1z8X4v1H7ipXcOxADae4Xk9P66XnB+r+xSG44J7V8ZqJfEIa7RX32ZzR86I
         yMPGmmIWIABA18aieUgTC5t6c+1Wj+BmZa8yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845991; x=1776450791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmZVgx4du5Y8gMF1xPyxrDio1rDedaQrWT161jIwWcU=;
        b=AcVtnLmqrxeKxze7NHVI5sSdSmumQMaOmtro7f8+WYMpczwtSsS8o3tYrKSwiCExBg
         LyebRu/q/bNFD09shE8zmZ+DYLqoDimq76W4SXf+fTdY89BzdaKf+AsxhR2pQWryLceP
         LOhN/O7HSjMsC48fsPQNxjAtrbR390QtMCpsDJLugT3KJYCuI4WpZBVgdxUI+pLCvi1J
         tfV60UtqcMHeLphORfZsDnWU8Yc95C2bwaiA+Lc0vePstl/ZT9AmUe3YDKPnJyxABNEx
         QkynkOFrfZQpMA+vH4pxO3H8McMa99LtRK4KK/mBYu1570TMti+gRsnj5LlOoz/hM4WV
         vGbg==
X-Forwarded-Encrypted: i=1; AJvYcCVtRZ0Oo9Z2K1kj43/oqnjqlC+R2B02XoUQVs9w7gjqyi3CFbWUqhwuqgJ+6kPFi+wVTVk9gSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlP6BIofdOem/+/Z8cxGbVzc2cbjY1QcHzggoxnU4DQH5jTYg7
	xDzplrAX3C0eIdYgKTXOwYN6xvdyZmDHeHq3Py663B4T9wQekqS89rP/9LrfJhrqnC6YlcTAGQo
	8civvWXjRFaDzNTDbL/dQt3qy3qSEm8vUVJD9WkPkNg==
X-Gm-Gg: AeBDieuR1Sl6lcGS7cZ1Q/m7Eem2+Q4umybVK+ITQX0wmdnbV2hA9jfq/zVA3vR6AHM
	A0ENBQGt2cOZ8sBePmpXZ/5VNDn7Q3uGDFOmYUYyJ8oUD/Z6sEz/pHSXTpSVOcJpb+kjJuLmNAr
	uJ4UrEmU0uLYscmb/nV90s62AHPGF6VHF6NVmygb2vOYicp0ujgsQDl885uNgg+ISUiDw+KXkYS
	GTe12YL27idkW2VM52/KWbhprHgs2/K/qxKqtLC2Np28sjoYhPY8YA6Nik4RZJbz+5YoRDvlF5M
	FiWaKcR4GwRuanlhr8XMqQqQUH0B9m5kOBXlicyGj7oJxMRW1UViJyvbX8fgKbhAkVo4slhfUOD
	qUr4EhGfyZncdMlKVfbDv0V7aAGDs0gPSyctkhyKpb5XcRERdmKIkgOtLWHdkkah0MxaltonajA
	==
X-Received: by 2002:a05:690c:dd4:b0:79b:dd37:69b4 with SMTP id
 00721157ae682-7af6f8094ddmr45213367b3.13.1775845991067; Fri, 10 Apr 2026
 11:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJQ4VyeaZyVwh0Y-tanUCAqiY8v=rmiGr8cp_XmFph=SGQ@mail.gmail.com>
 <BL1PR11MB52718837B34DB23713CEC2978C592@BL1PR11MB5271.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB52718837B34DB23713CEC2978C592@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Sina Hassani <sina@openai.com>
Date: Fri, 10 Apr 2026 11:33:00 -0700
X-Gm-Features: AQROBzCwnHPksNb0jtEzoTvVsAsoVyPLtOpmO6_Mi6ZtDuZiNJaDZ1zSwIh3Rkg
Message-ID: <CAAJpGJTeCs8x52ruotE1bLnmY1HGnaBeqcHeGKCfUt25NWN2UA@mail.gmail.com>
Subject: Re: [PATCH v3] Fixes a race in iopt_unmap_iova_range
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaron Wisner <awiz@openai.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-235657-lists,stable=lfdr.de];
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
	TO_DN_EQ_ADDR_SOME(0.00)[]
X-Rspamd-Queue-Id: 457413DB7C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 8:28=E2=80=AFPM Tian, Kevin <kevin.tian@intel.com> w=
rote:
>
> > From: Sina Hassani <sina@openai.com>
> > Sent: Friday, April 10, 2026 6:10 AM
> >
> > Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the
> > loop
> > body when getting to the more expensive unmap operations. This is fine =
on
> > its own except the loop condition is based on the first area that match=
es
> > the unmap address range. If a concurrent call to map picks an area that=
 was
> > unmapped in the previous iterations, this loop will try to mistakenly u=
nmap
> > them.
> >
> > How to reproduce: I was able to reproduce this by having one userspace
> > thread mapping buffers and passing them to another thread that unmaps
> > them. The problem easily shows up as ebusy errors if you use single pag=
e
> > mappings.
> >
> > The fix: A simple fix that I implemented here is to advance the start
> > pointer after we unmap an area. That way we are only looking at the
> > IOVA range that is mapped and hence guaranteed to not have any overlaps
> > in each iteration.
> >
> > Test: I tested this against the repro mentioned above and it works fine=
.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sina Hassani <sina@openai.com>
> > ---
> >  drivers/iommu/iommufd/io_pagetable.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iommu/iommufd/io_pagetable.c
> > b/drivers/iommu/iommufd/io_pagetable.c
> > index ee003bb2f647..e306871de06d 100644
> > --- a/drivers/iommu/iommufd/io_pagetable.c
> > +++ b/drivers/iommu/iommufd/io_pagetable.c
> > @@ -814,6 +814,14 @@ static int iopt_unmap_iova_range(struct
> > io_pagetable *iopt, unsigned long start,
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> >
> >                 down_write(&iopt->iova_rwsem);
> > +
> > +               /* Do not reconsider things already unmapped in case of
> > +                * concurrent allocation */
> > +               if (area_last >=3D last) {
> > +                       break;
> > +               } else {
> > +                       start =3D area_last + 1;
> > +               }
> >         }
>
> this could simply be:
>
>         if (area_last >=3D last)
>                 break;
>         start =3D area_last + 1;
done
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

