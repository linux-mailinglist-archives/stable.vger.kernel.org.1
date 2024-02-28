Return-Path: <stable+bounces-25439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340B86B81A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C831C22594
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031E15E5D1;
	Wed, 28 Feb 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ikh1klkC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501F74436
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148259; cv=none; b=RmIJOtEA6eIQG3wypOmab+8a0u+T5TAI1bz3sd+G0frulNpmOuw+/yQb45pybQuJMTuZyPcc3mos6oM21Q3uAPG1EnyzI9x4chHNWOdUL8XJZZJuVr4OfiCggfpvGh225z7jzm8ZusAdLOrCt+56auhtp9e/FrD5/uh7zQ01eoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148259; c=relaxed/simple;
	bh=16yvQGF4TqEul7uf//Z255JvkU2yThlRubF/gIw3PP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSYRsQKGcTHqoZ3FV2Rqg8t2uWSge27sjKt5ecuzmdPiultRtns0elkZrjCQXXLsNeTL2/zEZR18qfaVJSUsEbBRPYKJvmHFdAKoJ/6XCIg6FwNLKrBktNK/67pjFks6PH1RRgN3+CshzvoHgCqKvc21QEZu8aOPEaS9kJkfEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ikh1klkC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so216688266b.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709148255; x=1709753055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUlsH9mwlheftjt1VnERMRGr0XlA6bQ63sK+GJc4YIY=;
        b=Ikh1klkCY1zX01MpbathS0jr5xmUPfXw+nhtIAqA0gp14WP6M2Y8qOcOzL3KUz2YTl
         U1oWaps0IAUQ86QGkQ/D3/01wgVNchPlvidnNcCb7n0vcrT2X7z3/wYmU+EgaTJuEZIr
         /mJ/sgUv2/R4aDEuEMRK9Kyf0ZzmTLDyaipBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148255; x=1709753055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUlsH9mwlheftjt1VnERMRGr0XlA6bQ63sK+GJc4YIY=;
        b=Yq/pyIgexuIfHsoDjNMABvybJraYBW494bZ82vbW1exMLM5nDQk+5M8fImNvbTraJo
         CAt20D8hZxbr2SZYztEjv9WrenuGYDOlYFTjemKuUmD4MoSvFU4eJRqjoOmYxYUBdyjs
         zogCniyrWJs2vivbblNu1kmD1bvTyRcyrtrU6BppvOPapKbNiiXWIOYBc6X0nPJBk0L1
         j366xVBwCsoD9R8Lj6qEJS/oLiVH2UhTuZuNTvqeE7ix0yoDFrPZwb2ktiWimpeYyPCd
         XNGBc518pGeZcfkcvYhfDITDlZbbXV/TAdjt4ntn3HH5zTmNRkoIHLTNuxPjIEZZsChJ
         KNkA==
X-Forwarded-Encrypted: i=1; AJvYcCV/uiwpfAtqGC6Pys4zSlqWoABQYHTgptnqnTa41NvMgar44E/sEOmvBttDQf35EOZVnq03qT3AoEpL3dBaiH5f+PXdSlut
X-Gm-Message-State: AOJu0YzD4/01enFP70W0WQ70FP93k7Am0QYZWO8GD2FhpHjBThb2T9jT
	xfdBI8sc7tx8uCaEHjKdUngT1/+hMc3iNOjfH+NblewPZEyHYjssyIeSG9PJpwVABncMoG+hiOS
	BfUVsh6hC1AHBHbOSwizm8+OxpGjDNl6H/4Inxw==
X-Google-Smtp-Source: AGHT+IE6IVFHssB3O0XoXNS1Yv6t0hxMflNes0j90lzSJqxQAEvvhPaRuCXLQGSbgCL9X4N+SNOny3EQNZ61LoixIq8=
X-Received: by 2002:a17:906:27d7:b0:a3c:5e17:1635 with SMTP id
 k23-20020a17090627d700b00a3c5e171635mr287940ejc.30.1709148255326; Wed, 28 Feb
 2024 11:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228160213.1988854-1-mszeredi@redhat.com> <20240228160213.1988854-3-mszeredi@redhat.com>
 <fa6cd2cc-252c-492f-adb5-7a0d09c20799@fastmail.fm>
In-Reply-To: <fa6cd2cc-252c-492f-adb5-7a0d09c20799@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 20:24:03 +0100
Message-ID: <CAJfpegsDo-P+tb8BQdhdLeNAKwJnxUnnQoJ=eT3Yd260AxUuJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] fuse: don't unhash root
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 17:34, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/28/24 17:02, Miklos Szeredi wrote:
> > The root inode is assumed to be always hashed.  Do not unhash the root
> > inode even if it is marked BAD.
> >
> > Fixes: 5d069dbe8aaf ("fuse: fix bad inode")
> > Cc: <stable@vger.kernel.org> # v5.11
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/fuse_i.h | 1 -
> >  fs/fuse/inode.c  | 7 +++++--
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7bd3552b1e80..4ef6087f0e5c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -994,7 +994,6 @@ static inline bool fuse_stale_inode(const struct inode *inode, int generation,
> >
> >  static inline void fuse_make_bad(struct inode *inode)
> >  {
> > -     remove_inode_hash(inode);
> >       set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
> >  }
>
> Hmm, what about callers like fuse_direntplus_link? It now never removes
> the inode hash for these? Depend on lookup/revalidate?

Good questions.

In that case the dentry will be unhashed, and after retrying it will
go through fuse_iget(), which will unhash the inode.

So AFAICS the only place the inode needs to be unhashed is in
fuse_iget(), which is the real fix in 775c5033a0d1 ("fuse: fix live
lock in fuse_iget()").

Thanks,
Miklos

