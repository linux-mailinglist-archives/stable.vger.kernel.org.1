Return-Path: <stable+bounces-205040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ACCCF6EF6
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDAA4306D538
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F13093A0;
	Tue,  6 Jan 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKmoAYrc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9A25783A
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682422; cv=none; b=NgRn6m+nxdjzAeLgWCWobqZ3NND7TpjkJdpA4vyNm/JWJNOXf8vbrwg51etmQj/Z2PemZ5QRww1UW6xqSAhUnULeZMIz+a4VgMpExCbplxUUrHqaM+7e5TTtqVOQkyaXyf+pdUPk21HZlkZgFMPGsaOroRZFRUugoqb4vcYkAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682422; c=relaxed/simple;
	bh=yI2uKGGWact6aw8Quq2svhMk8YRVXCsIc0sLg9mWNFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flJuQsdq2iRRQ5zLC9i0qRxSfb23E094qdrtYUTZErqkJ7hgaKepJTpkRss5omx7gJAh1Oz4K+2QZHfL8vWO/dtK48/UqSgMnWO5G4rMOKcS+rErNXkCzitHRIRbVUy+JxYWT1yvpenTnbKBEBEtGv+EDIJmXebqjvV7tGvlq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKmoAYrc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso300176f8f.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767682418; x=1768287218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLU2SMeJcQK8EmXGGVWWd23Q8mPEEIYZ05BQxSoNnUg=;
        b=KKmoAYrcaxkF6PDMFGcOIZxRA+Ue7oWG8Use5pgWlDjEqTIzb6hyH9Eq15rXADWlbz
         ET51xkYTKpxLfOmjisEJ2mazbtvWvgEMEFrJ7w0w/mU0TSinu+KN4+Gtjqi0TC0H0Y9b
         M6rCl+n045UEhQSTYnVFG0nLomGpJvATaSwIqtG5DJoh3NaT13rYkY4n2pZcDDyndhjA
         y5jgBYPcla9JxFxzjQF/BXz3qlrEGSN8GGgWFvJdZkzt94omv/P5DrPg8rJZlJ28U/Oa
         l/s1RYvRSfcFE27yeM0n12i1evyeQakVUIqP+rkzLqA0zqtcIH2IiGVAOZ8J80icpJq7
         aLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767682418; x=1768287218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLU2SMeJcQK8EmXGGVWWd23Q8mPEEIYZ05BQxSoNnUg=;
        b=j8jEU1XwhB3OoeFRjRbv5uiYn8K6rAsV9AVVHg1suSXJ1jz1dIptHV6LXT+D5Hsayq
         bO9kW2I3cyhdc6Ofo9fttQI6vjA4OKDWRxiHFMtR2DK/tepRUut5fxR3Roh00bN2zUto
         QYW1odn2zhfv4BzGVGLze2clrmEZANmCfKCwB+rtS7rHBz2tzii4cR1U0TRQkrIT8pdq
         clCgp/i5KGyg9oOdHENRCQim7IstNdcZOI1w6sN7AtyadjcOi1jP9tnvK6nSZ0dTrDnr
         PESPXymwXvERk5eQBdvtCNM8T34jCevpSX1+wNFjkaRK906EFhtMy+ZbUTDne0RO03gD
         FbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbbW18i+hIzrrfP+sIh2PBkZeupCLr765mGeI6aNMjB22uNl1yUlUSOwFMb+VzfQeNfi6n0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ua28eKAQoxk3FVabnWx7fPSewGFTJeJ+kC9Wj3PHfIbGMcwJ
	ep/jy7mTf55UOfIpU0wIQlyZ7ILyJ/ate7fWMMLZpimeYq1dvNaWIXDQCIt5Ga7F0t1URhU6Apd
	gKy6WPkHnXKNAgsMt0wSOJC8SLGMdxGM=
X-Gm-Gg: AY/fxX5b3ZOojBasCvbKn+HBSYHOWr1ShM+3y+VvyIrvLk5ae+KOuyhzBPq9KXIEVYi
	6m5BsT+NNGQXS9CBlGD70ojQecbJtr6FeMsiZmN3Z7kx/+Ktn0s99PmGlW1DIiEPIyiZEQdFWJ3
	LFWBScFYoJkVayv+tltApW8USRKP1saZjIMniQIDnVdv5p0pTPuN10PkNRvPymCjavhcucTMCi8
	TR6wIO9P1ppR3k02PUTmS9qOEHk4+IbrK5p6PiW4wqIUVFUBOFLA67wWvoThNYFyc468d3TEqVI
	9Xk9QUyZwI3g1ULMXoTVz9RQ9GYw
X-Google-Smtp-Source: AGHT+IHnmWsRhvAmhJi01atOVhTVco7Qfzi5gMMpzC9P2bXKgrhvQMwIfLnCc9ASdkf4qP/a/3OdyDg2/KZZ7ogdtKQ=
X-Received: by 2002:a5d:5887:0:b0:431:266:d132 with SMTP id
 ffacd0b85a97d-432bca4a947mr2536178f8f.46.1767682417611; Mon, 05 Jan 2026
 22:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231024316.4643-1-CFSworks@gmail.com> <20251231024316.4643-6-CFSworks@gmail.com>
 <912bf88ff3b77203c2df37aa4744139a2ea0a98c.camel@ibm.com>
In-Reply-To: <912bf88ff3b77203c2df37aa4744139a2ea0a98c.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 5 Jan 2026 22:53:24 -0800
X-Gm-Features: AQt7F2pglkIvwKwPeRALxY2XVk-FbmtxYeP0YLz7UZ-lZb7mhqNJHohdNE6NF4E
Message-ID: <CAH5Ym4j9Sgzng9SUB8ONcX1nLCcdRn7A9G1YbpZXOi3ctQT5BQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] ceph: Fix write storm on fscrypted files
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Milind Changire <mchangir@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:34=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Tue, 2025-12-30 at 18:43 -0800, Sam Edwards wrote:
> > CephFS stores file data across multiple RADOS objects. An object is the
> > atomic unit of storage, so the writeback code must clean only folios
> > that belong to the same object with each OSD request.
> >
> > CephFS also supports RAID0-style striping of file contents: if enabled,
> > each object stores multiple unbroken "stripe units" covering different
> > portions of the file; if disabled, a "stripe unit" is simply the whole
> > object. The stripe unit is (usually) reported as the inode's block size=
.
> >
> > Though the writeback logic could, in principle, lock all dirty folios
> > belonging to the same object, its current design is to lock only a
> > single stripe unit at a time. Ever since this code was first written,
> > it has determined this size by checking the inode's block size.
> > However, the relatively-new fscrypt support needed to reduce the block
> > size for encrypted inodes to the crypto block size (see 'fixes' commit)=
,
> > which causes an unnecessarily high number of write operations (~1024x a=
s
> > many, with 4MiB objects) and grossly degraded performance.

Hi Slava,

> Do you have any benchmarking results that prove your point?

I haven't done any "real" benchmarking for this change. On my setup
(closer to a home server than a typical Ceph deployment), sequential
write throughput increased from ~1.7 to ~66 MB/s with this patch
applied. I don't consider this single datapoint representative, so
rather than presenting it as a general benchmark in the commit
message, I chose the qualitative wording "grossly degraded
performance." Actual impact will vary depending on workload, disk
type, OSD count, etc.

Those curious about the bug's performance impact in their environment
can find out without enabling fscrypt, using: mount -o wsize=3D4096

However, the core rationale for my claim is based on principles, not
on measurements: batching writes into fewer operations necessarily
spreads per-operation overhead across more bytes. So this change
removes an artificial per-op bottleneck on sequential write
performance. The exact impact varies, but the patch does improve
(fscrypt-enabled) write throughput in nearly every case.

Warm regards,
Sam


>
> Thanks,
> Slava.
>
> >
> > Fix this (and clarify intent) by using i_layout.stripe_unit directly in
> > ceph_define_write_size() so that encrypted inodes are written back with
> > the same number of operations as if they were unencrypted.
> >
> > Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index b3569d44d510..cb1da8e27c2b 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct addres=
s_space *mapping)
> >  {
> >       struct inode *inode =3D mapping->host;
> >       struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
> > -     unsigned int wsize =3D i_blocksize(inode);
> > +     struct ceph_inode_info *ci =3D ceph_inode(inode);
> > +     unsigned int wsize =3D ci->i_layout.stripe_unit;
> >
> >       if (fsc->mount_options->wsize < wsize)
> >               wsize =3D fsc->mount_options->wsize;

