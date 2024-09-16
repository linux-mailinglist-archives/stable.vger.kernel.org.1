Return-Path: <stable+bounces-76183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CB3979C1F
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC4628436C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECA482E9;
	Mon, 16 Sep 2024 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aoooqz6V"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D43E47B
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472321; cv=none; b=u2Onhyxtai4q6acIgwPbA3ZqAYGNmG6GuF0uQ8sLf6IsoA8mAtQrPVP2TcUDl0o6mj7wyl2vpDiJkVu9edBr/JO3Czyj8ke7ez12Luka3gy2Z9CZY7/YfcaGKloM0KNtcF9jrFc5txUGAMFvd8qzJOt2sQB3k4oNGrtH/943Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472321; c=relaxed/simple;
	bh=bfGccp6AX6ctsn7OvWNp8eIJ0+HTNTPN4PrYJ1iNARI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1eiXIL0rBTfCG4GCElbP13D1Mh50vFspUk1FBE1RbB/SVv2GxX7A/q6GzlA0/iNqwHC8dWVHK2+oO8+T+M4gV8b1bYd5LVFKerd6gyU1/Qx0uwFx+65Px2fmyFPxOSlCbKvuadYHCeEVJ75S6ymeekZz2saT3mpYmoUpHHE5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aoooqz6V; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4582b71df40so491051cf.1
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726472319; x=1727077119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfGccp6AX6ctsn7OvWNp8eIJ0+HTNTPN4PrYJ1iNARI=;
        b=Aoooqz6VWyEAOBovksP3cpvp8bfQHdeoyCa/D4o2iOe1sSIPdBoVCd6IzLdXmt8T7s
         SoG00KPwn/hYRjtyTZzLP8J9R7ynoL+w/aYwVMusZeFKTs91TPOT0rxG2dJL0njDFdas
         J7Jypdl7fBh9hPu2hoymrTzCBfx2ZuTpwqfDB78KPF+E+gAbdoSugnZ79sONKcFU/m8e
         x9elBG0ZegbzkFuDwTFHwh/XkUvPlrK9erAri9jnTVToNMhkDnKc3OwQCe6w15TbjbwN
         kuWXejdQAJ/uBSeMAh7R97hu11U16pCyv4e4ZZq4999cpoJh7/aLl9pA9tzXcduf0QdK
         wBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472319; x=1727077119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfGccp6AX6ctsn7OvWNp8eIJ0+HTNTPN4PrYJ1iNARI=;
        b=Sj2iKodguXfmK+cvRsnHfB74HnB7wppSQ0VeyjOmOpHDdxt/pkOfFPMcDGMIXHGPMO
         BIyvK45uHX2YqSb3FpU3AsBHfmL2eptdOOOUPJpl2PjKvouJJvUkBQy+6zehukXBD/du
         pyeySebScTlI0t2zeed5ILAvZUaeIVr5TFvpVS2Hx2J5b31x0Q3kitE9EuFuI+sK2PD2
         E/IVQJeFe+ZafoaazWwHWAmJVU4ZVqU73iOCHvxXmMAqmMzDNw6nvBdxkjdUrSLI4Hel
         LNfwEfVyp641ktHRAhZh33TmWVO9NKynqvdwUZGKs9hI+yF/W+oHqCXcBRIUXh4exfKp
         Kw/A==
X-Gm-Message-State: AOJu0YzQLNqIUeb4AR00wcbNeGPFEJkQG7bES5wbItknBF9mI9CV6aG9
	36xALVMl5+0wjSrdg0PmZFGjU/tH06SE9+1cOM4DjMKuWyaXlUdT0YgdywF78SlmKjDdWvjxYyj
	9p5f1N2cBQ+jPg1Qj9gVhDL9HOLQE1BosBjiF
X-Google-Smtp-Source: AGHT+IHs1YEUgowoMdCsA2y4LCNJTNAcSW4n4W/kpbSoFpbzJ1ilTLq0GNJqRhkb7d/U0rAvQb70DTSn8FFJ8HfM328=
X-Received: by 2002:a05:622a:24f:b0:447:f3ae:383b with SMTP id
 d75a77b69052e-45864518544mr12478191cf.19.1726472318556; Mon, 16 Sep 2024
 00:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916043441.323792-1-tjmercier@google.com> <2024091643-proved-financial-0bb5@gregkh>
In-Reply-To: <2024091643-proved-financial-0bb5@gregkh>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 16 Sep 2024 00:38:26 -0700
Message-ID: <CABdmKX1_zvT=EDGr0-hPmrbyf97JrzUB_Rw40JT9au6v4zaMUw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] dma-buf: heaps: Fix off-by-one in CMA heap fault handler
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Xingyu Jin <xingyuj@google.com>, 
	John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:02=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Sep 16, 2024 at 04:34:41AM +0000, T.J. Mercier wrote:
> > commit ea5ff5d351b520524019f7ff7f9ce418de2dad87 upstream.
> >
> > Until VM_DONTEXPAND was added in commit 1c1914d6e8c6 ("dma-buf: heaps:
> > Don't track CMA dma-buf pages under RssFile") it was possible to obtain
> > a mapping larger than the buffer size via mremap and bypass the overflo=
w
> > check in dma_buf_mmap_internal. When using such a mapping to attempt to
> > fault past the end of the buffer, the CMA heap fault handler also check=
s
> > the fault offset against the buffer size, but gets the boundary wrong b=
y
> > 1. Fix the boundary check so that we don't read off the end of the page=
s
> > array and insert an arbitrary page in the mapping.
> >
> > Reported-by: Xingyu Jin <xingyuj@google.com>
> > Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the c=
ma_heap implementation")
>
> This commit is in 5.11, so why:
>
> > Cc: stable@vger.kernel.org # Applicable >=3D 5.10. Needs adjustments on=
ly for 5.10.
>
> does this say 5.10?
>
> thanks,
>
> greg k-h

a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the
cma_heap implementation") moved the code from this heap-helpers.c file
to cma_heap.c in 5.11, which is the only place it lives upstream now.
The bug still exists in the original location in this heap-helpers.c
file on 5.10.

