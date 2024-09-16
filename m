Return-Path: <stable+bounces-76185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBFD979C39
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FC5283F76
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2B3BBF2;
	Mon, 16 Sep 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4QrnFA0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682223A9
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472898; cv=none; b=PXu8BvpN1cntC5tO3Hi/gEkAKqzHCytpHl4Prp1zu3e+seQs2W73tDqm6nLtdZdV/EOUtGfBtj1xfleX+DWa3hegbXQSpGu9HNEJ/2hX+nlOkGLZyIiUELgvwMSthJwCNIHAuU+EfQkBVngBQ+MiWCdidKGiDEoDKpoMctLGim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472898; c=relaxed/simple;
	bh=P/E3nPwW6Agec2ec7CAwVn14BuyzsSTAA96TaPCrU+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1spRLE0elOHMyeNLb96bbATKA04aXx4WJfyGCW6v2clkKGI7cZ1UGcu8STjgQVE7h1wASyenKufIMfnaxVSxCX3Cda9XFRoYwdKoFPdFip3u0mcIGwFp50ZnHC0kcb4bbql1tXxxptT8WkWWKwtjXW5Aj2kRjrQauB20wrsQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4QrnFA0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20546b8e754so239995ad.1
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726472896; x=1727077696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/E3nPwW6Agec2ec7CAwVn14BuyzsSTAA96TaPCrU+4=;
        b=U4QrnFA0ZcvO+6NLL12LexS0YzD9KtRlDILkMWP9dGByir7DjtQ5Gjegjmpo31HP0v
         r7VgP3M9dKtBpNVXHW1lAgsdWQlI703HCys/A5w//Xh6QWArKsXHajCEpyJdrqvvt4Dp
         kNzNqKWo8f4bY7Lp37tt1qJJDMKDy6d8mdXaX4eZG35j5JCHwVxHZYBz/tPWFdkdxK1d
         YsxC85tK7+yW8BgDzE5OXL5V/HH2Ck6kAeIOx8oYZdBUQ9C2MU36kYvOnqeQYnsk9vAU
         Fm8lYnXZiu/H8wCstaYV/+rtZ1pCB9XWzqAN3RYVqhFl8Rp6uHqI77gudCuJQyRevnc5
         WlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472896; x=1727077696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/E3nPwW6Agec2ec7CAwVn14BuyzsSTAA96TaPCrU+4=;
        b=tcgRsuRPMlCT9YxTJmk+BIYzD7IvlnmnEqGFVwREuNNkWTlaz4KyjqTXaJtfn1Vpqf
         /B6dHR/ckx/Rvw8LnPW/4YNJCTmOsVQMEDisBFI1lBOpkK6ZIb+OuvnNS804DorqFOh5
         dAYH+eGttSGlXpRTPsPTIB0MTOD7OFYD67cyojAqj0j3bHsdOX6VWH5SifK32bL3c8zx
         6zz5vesKOuxj2HemIZSdQeC3xQOkvjuay6orsvP+q8oqa9+6FAylTX02QDLfrx+6iEQB
         8jJlyVaKh7eLU7n+VPaD0MyQcahd+7AEl8kdq0hdWpXN24rXO6rANown5qiRWWKaQ1eB
         R+PQ==
X-Gm-Message-State: AOJu0Yx8eJZnmycJSJRJzC/qMRRGiUeVx3RK4OkGhzCkGLKY4iqE/wsP
	LQsZAAeTbd0RLt1Wg5nsEK9NwRRGsS2SXCvj6TYlZL6qpC3kwBb7PHyBC5FIChLIeRHIx3uL8z1
	OUPCdYs/UNZx67uXzhTkdUuGiZMG1Abc3aUeW
X-Google-Smtp-Source: AGHT+IF0TfRx6EniF4V0Rybh95286X0u6npG8agYOVtuXdQBy7GXIWoyjmvJR4qll+egGRuV4682YXoBSz/jo2qvObc=
X-Received: by 2002:a17:903:32c7:b0:207:14eb:c884 with SMTP id
 d9443c01a7336-2076e6ac67cmr9902995ad.6.1726472895830; Mon, 16 Sep 2024
 00:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916043441.323792-1-tjmercier@google.com> <2024091643-proved-financial-0bb5@gregkh>
 <CABdmKX1_zvT=EDGr0-hPmrbyf97JrzUB_Rw40JT9au6v4zaMUw@mail.gmail.com> <2024091614-headcount-headstone-b2f4@gregkh>
In-Reply-To: <2024091614-headcount-headstone-b2f4@gregkh>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 16 Sep 2024 00:48:04 -0700
Message-ID: <CABdmKX19wDVmjfS0-iTh0LfYDuDsWGdRzj18bEPYS5XV4cGXqw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] dma-buf: heaps: Fix off-by-one in CMA heap fault handler
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Xingyu Jin <xingyuj@google.com>, 
	John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:44=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Sep 16, 2024 at 12:38:26AM -0700, T.J. Mercier wrote:
> > On Mon, Sep 16, 2024 at 12:02=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Mon, Sep 16, 2024 at 04:34:41AM +0000, T.J. Mercier wrote:
> > > > commit ea5ff5d351b520524019f7ff7f9ce418de2dad87 upstream.
> > > >
> > > > Until VM_DONTEXPAND was added in commit 1c1914d6e8c6 ("dma-buf: hea=
ps:
> > > > Don't track CMA dma-buf pages under RssFile") it was possible to ob=
tain
> > > > a mapping larger than the buffer size via mremap and bypass the ove=
rflow
> > > > check in dma_buf_mmap_internal. When using such a mapping to attemp=
t to
> > > > fault past the end of the buffer, the CMA heap fault handler also c=
hecks
> > > > the fault offset against the buffer size, but gets the boundary wro=
ng by
> > > > 1. Fix the boundary check so that we don't read off the end of the =
pages
> > > > array and insert an arbitrary page in the mapping.
> > > >
> > > > Reported-by: Xingyu Jin <xingyuj@google.com>
> > > > Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into t=
he cma_heap implementation")
> > >
> > > This commit is in 5.11, so why:
> > >
> > > > Cc: stable@vger.kernel.org # Applicable >=3D 5.10. Needs adjustment=
s only for 5.10.
> > >
> > > does this say 5.10?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the
> > cma_heap implementation") moved the code from this heap-helpers.c file
> > to cma_heap.c in 5.11, which is the only place it lives upstream now.
> > The bug still exists in the original location in this heap-helpers.c
> > file on 5.10.
>
> Ah, then that was the wrong Fixes: tag :(
>
> thanks, I'll go queue this up now.
>
> greg k-h

Ok sorry about that. Thanks.

