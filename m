Return-Path: <stable+bounces-206063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B0CFB6AF
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D403032724
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9709460;
	Wed,  7 Jan 2026 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLNBQEKS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288E17D6
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744324; cv=none; b=biyjzAsLuH76pBYrEmHQuiGpy2w7VlMt/RRFzj7ftO7IvNK58D09L9qiUsel8myVCNWboWjvEmZV/6kmaDy87hLMUcP1YSApn2ja1aRwTrTw7L58kh1dtgjAvkF18H2OyB01oI42ADrWt6l3da/Ed2vPwCmCZOuTPhs3GIRqqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744324; c=relaxed/simple;
	bh=FJCwgkNjSsKVRA4ZLLDhzoQEsKIk6rDv4zru2NkuR7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aX2afa6tw3NZ4tT1qi3vmwW4+QFTf6LibXlD2eV1h91K5TJ8nBAN1K+x9MS14IXUSbqv8iGR6IJk8k/1x263eMQ0XVUXmpYb1fRIJ76qxJuJuweISW+9omE9wpLUx6Ny1rr4o/IUrWdpxjAuKpUzQIDtJVloBl/q6Z84EA31bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLNBQEKS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso13207685e9.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767744321; x=1768349121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gav3Va1om+aE0DQogO7gh6heL0GSyo9snkPsIMFuKP0=;
        b=MLNBQEKSRxUCivizoyAtuKPUkAS3Mu2GWuTNnw1Hi+jvxPOpzp0DdaA9YGNhqqWIQy
         GqulxSnT59tESTrcLTegmd6+Ya3zqs6Y5G0jZ4sB7MZEUZRuEZbiLLxRpku98eqlNtA0
         KQZHPWSP0zBZoVMrYJbnylqryOy82LubdK66vLf55Amxft+dYlNIER2fjkJWdzd+S5Te
         rvs7sFPFdBUIuoZle7S4qbcZUYcmkjZMm02mZs8SmMKCbOTADG3eLzt+hlHq0rl3hbrj
         dAObuq3Wyb8ibD0epo0dTiaouR9Pc9buBKA9+aAjYmB3hwap5HIPpgLBhWGf/J1YFG45
         CQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767744321; x=1768349121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gav3Va1om+aE0DQogO7gh6heL0GSyo9snkPsIMFuKP0=;
        b=LkdZaEcsUv4J9o3eYi4stsCZR0AUdpICPpREIVlqZwbmJg9jqRrGMlRiYN8NMQW8tN
         LfsswiQxGarWrlhtfDETI2UX615Rkrq36aDmzsy4mWoEoZ3tzLUOYFTCj4LQWPbZhxVT
         PIUyFKB4aIiYjVkJeq5x1GTGL3fjBrDJ/R6lP4cP+ocYN61evZAmlIsv6PzpXUaOiRHv
         K1bYq190yxKR8GBtFvAnwUu5S3aBT3aWF1COCDgpwHok2xWsoC5ZfGhnybRZDg5Q6ZzK
         Q/iOb8+riQojo59zgtfW0OdW+eb9zejsbJVIIaubxIrrpk5KKhfQX5qyvDN35cazZtaN
         GG+A==
X-Forwarded-Encrypted: i=1; AJvYcCXRCWYPxnsDu2SK/ywn0PT6bAAIAyihK6upw+y7NEfY2iSmGb2qePc/DwMkfm7hqs3HNjEkQ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfO6JXCwPgUucGpjYsGk2CPk2Q+6X5HxrTc1xsP/JAq72d0zC
	xkaVQ0xCStF4/T12eSRloGZ8/YKSP+TI/zhEIlEWBHTclQefCf+b+f6RdYTODjx58J+QKnNBX3n
	4mJjxfRKcbOvxnV7SUmrj6oc8/A8mXlA=
X-Gm-Gg: AY/fxX6zreSLNCZSUrW5PBxajcDNzUNEB4iTlh/+6aUrMlwqYbtiiEz+MR0jyws2iro
	9mpRdzOyNA97fUYbelXj/NHR9v1p47SBvAUaQy/y/3KMZTUtvEbIhtze9u/Y9zfXU2q/nVMZE8M
	1tw4N0J5Dqhp2hgTd3AgR1QLjWLLO3FFIVGf4KmbDQfuXUWEA0/xBHfMDmSiGyeFCHT0sVfDgFu
	533xpSIKxtaqUYaBWsTSdcuB4YhPkQo90JMp2A+yhsrARL6z+nv+uWEuaTSiJr5n0wDKrVIxOjH
	VCHpXheaQAMXNJolaiHULmOJlt6W
X-Google-Smtp-Source: AGHT+IGl2Ii6lYtrStKwwrW4DV2MorC6fOx6oD73asUHq44HSHQEZizOb3DdjFMp1y8uMfGceIcrW7ZpeeEipzPFUxc=
X-Received: by 2002:a05:600c:c0c7:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-47d84b33bd7mr5422015e9.22.1767744320731; Tue, 06 Jan 2026
 16:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231024316.4643-1-CFSworks@gmail.com> <20251231024316.4643-6-CFSworks@gmail.com>
 <912bf88ff3b77203c2df37aa4744139a2ea0a98c.camel@ibm.com> <CAH5Ym4j9Sgzng9SUB8ONcX1nLCcdRn7A9G1YbpZXOi3ctQT5BQ@mail.gmail.com>
 <f8e9a246a6a47a100e022d837b5ffc3f9e864fd8.camel@ibm.com>
In-Reply-To: <f8e9a246a6a47a100e022d837b5ffc3f9e864fd8.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 6 Jan 2026 16:05:09 -0800
X-Gm-Features: AQt7F2psWTlbRQ7Z6mrasZWFncIjjEh3ebIkKaATeNF5GViz3yWadmundV3id9k
Message-ID: <CAH5Ym4j4SbR7DMOZaLWD4v5HOj6Eejv07pcyE3TsWb9R_jFLcA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ceph: Fix write storm on fscrypted files
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	Milind Changire <mchangir@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 3:11=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Mon, 2026-01-05 at 22:53 -0800, Sam Edwards wrote:
> > On Mon, Jan 5, 2026 at 2:34=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyk=
o@ibm.com> wrote:
> > >
> > > On Tue, 2025-12-30 at 18:43 -0800, Sam Edwards wrote:
> > > > CephFS stores file data across multiple RADOS objects. An object is=
 the
> > > > atomic unit of storage, so the writeback code must clean only folio=
s
> > > > that belong to the same object with each OSD request.
> > > >
> > > > CephFS also supports RAID0-style striping of file contents: if enab=
led,
> > > > each object stores multiple unbroken "stripe units" covering differ=
ent
> > > > portions of the file; if disabled, a "stripe unit" is simply the wh=
ole
> > > > object. The stripe unit is (usually) reported as the inode's block =
size.
> > > >
> > > > Though the writeback logic could, in principle, lock all dirty foli=
os
> > > > belonging to the same object, its current design is to lock only a
> > > > single stripe unit at a time. Ever since this code was first writte=
n,
> > > > it has determined this size by checking the inode's block size.
> > > > However, the relatively-new fscrypt support needed to reduce the bl=
ock
> > > > size for encrypted inodes to the crypto block size (see 'fixes' com=
mit),
> > > > which causes an unnecessarily high number of write operations (~102=
4x as
> > > > many, with 4MiB objects) and grossly degraded performance.
> >
> > Hi Slava,
> >
> > > Do you have any benchmarking results that prove your point?
> >
> > I haven't done any "real" benchmarking for this change. On my setup
> > (closer to a home server than a typical Ceph deployment), sequential
> > write throughput increased from ~1.7 to ~66 MB/s with this patch
> > applied. I don't consider this single datapoint representative, so
> > rather than presenting it as a general benchmark in the commit
> > message, I chose the qualitative wording "grossly degraded
> > performance." Actual impact will vary depending on workload, disk
> > type, OSD count, etc.
> >
> > Those curious about the bug's performance impact in their environment
> > can find out without enabling fscrypt, using: mount -o wsize=3D4096
> >
> > However, the core rationale for my claim is based on principles, not
> > on measurements: batching writes into fewer operations necessarily
> > spreads per-operation overhead across more bytes. So this change
> > removes an artificial per-op bottleneck on sequential write
> > performance. The exact impact varies, but the patch does improve
> > (fscrypt-enabled) write throughput in nearly every case.
> >
>

Hi Slava,

> If you claim in commit message that "this patch fixes performance degrada=
tion",
> then you MUST share the evidence (benchmarking results). Otherwise, you c=
annot
> make such statements in commit message. Yes, it could be a good fix but p=
lease
> don't make a promise of performance improvement. Because, end-users have =
very
> different environments and workloads. And what could work on your side ma=
y not
> work for other use-cases and environments.

I agree with the underlying concern: I do not have a representative
environment, and it would be irresponsible to promise or quantify a
specific speedup. For that reason, the commit message does not claim
any particular improvement factor.

What it does say is that this patch fixes a known performance
degradation that artificially limits the write batch size. But that
statement is about correctness relative to previous behavior, not
about guaranteeing any specific performance outcome for end users.

> Potentially, you could describe your
> environment, workload and to share your estimation/expectation of potenti=
al
> performance improvement.

I don=E2=80=99t think that would be useful here. As you pointed out, any su=
ch
numbers would be highly workload- and environment-specific and would
not be representative or actionable. The purpose of this patch is
simply to remove an unintentional limit, not to advertise or promise
measurable gains.

Best,
Sam

>
> Thanks,
> Slava.
>
> > Warm regards,
> > Sam
> >
> >
> > >
> > > Thanks,
> > > Slava.
> > >
> > > >
> > > > Fix this (and clarify intent) by using i_layout.stripe_unit directl=
y in
> > > > ceph_define_write_size() so that encrypted inodes are written back =
with
> > > > the same number of operations as if they were unencrypted.
> > > >
> > > > Fixes: 94af0470924c ("ceph: add some fscrypt guardrails")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > > ---
> > > >  fs/ceph/addr.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > > index b3569d44d510..cb1da8e27c2b 100644
> > > > --- a/fs/ceph/addr.c
> > > > +++ b/fs/ceph/addr.c
> > > > @@ -1000,7 +1000,8 @@ unsigned int ceph_define_write_size(struct ad=
dress_space *mapping)
> > > >  {
> > > >       struct inode *inode =3D mapping->host;
> > > >       struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode)=
;
> > > > -     unsigned int wsize =3D i_blocksize(inode);
> > > > +     struct ceph_inode_info *ci =3D ceph_inode(inode);
> > > > +     unsigned int wsize =3D ci->i_layout.stripe_unit;
> > > >
> > > >       if (fsc->mount_options->wsize < wsize)
> > > >               wsize =3D fsc->mount_options->wsize;

