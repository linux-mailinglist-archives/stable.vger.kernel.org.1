Return-Path: <stable+bounces-180371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B2B7F5B0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09C1323A94
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4D1C5D72;
	Wed, 17 Sep 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtEIDobW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9B1E25EF
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115378; cv=none; b=obakVM6cHZ1ozSYtNFTliorQISsFPhalM6TbUEnoEZXufjo+s8Fzhtqd5tdUHJPX8DMcD1l4193Y6J45OoJ6ev91yUDoho2OElDyoaKRRqzCEl+GsjT6Uu+hdkdPMyVKjAQIARE0nGFWQIG7n+YY/ygfHRlcg5e8mFz0MxHUmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115378; c=relaxed/simple;
	bh=IXtdj43M5q2Ed5NQe9mn8kcTi6HyJvp+nQtN50y6JwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5Ru7HUJ4thShzHwaO6ttWITxIeBgtCRmqiaqLVqkPeeNo9RftMyTC+CiFW7aSxZw5rmGP2Y0CLqDhT979ijq45iQURPj4G6GhtPqd+M1jMt4mVS0/Y+U3cgM9atxeBJIrnymoZvWtkMtu3pppq37D/K5h6TWSgGqRbbzg68nKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtEIDobW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso12974211a12.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758115375; x=1758720175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=dtEIDobWRDzpGN+FdDhFfoFiHtzGUPzW0pcT/Jb+oNR3B80z0S24QkQ2+tJp6BZ+E/
         2SlbHxnjDN783WeZS11qulZHLrmY8tfl32+sUPaLEHDQxM2VdtGVjCSoAWO/81tAVN2u
         ZQwPKFJbwP2at65JIdllh/SMVVp4UfrocsykoBmIxiIski7oZfqhigY4pelh0UtMjMxY
         WvQoX61HxRKGO0Dq+//ussr1do4V2PL7DoU/mjsktCGkBr8AlvvmntplrClk9kmGL0sc
         J9DmNVrqTVEUBc1/2sp70X5gfLIDNC387OJskChrSs6DRyg/zPih4y+a+vXpqM7bLNdE
         mHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115375; x=1758720175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=Ta46CwvjeY8WXLzS9PeuXq/5haRsSivYhMrda22d2r74A2SlBGChPzEsfRXUoVDpHX
         bW8aXu01SvVI9nX7ZoF1ZbQUUctVCI9p+wKAJlxbf5Fp4F0rrMUynNyhF/ftrh7DQgY0
         mBAPyt06B1DolmBYtfyFPR1iHU1bbRqdgJhNPEsp4d/bJe291NeEwjcqTgl0vMmpRPpA
         psjBRtwjKFtLHq+kzTOqnElyWdcGHQSvQXk+95fmC8MFojQRb4ZYUMPhp1cnWDVWBVO6
         csDXp2q0W6aAp9bKcRvSwkCWDiQlzcLqkQZSANiDPy8r1/7QfQncLQBdcsQSbIWcqDdZ
         QdWw==
X-Forwarded-Encrypted: i=1; AJvYcCUSrzHMlAD79tEuYA0Y8H8fLrP/fFI8Z7Ybx5/09wMFTRrDyX2iyAT9wvMLQjVmwdG17eZVVmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8zhNPNYSkSglXsgio71MulkMX547O96XR/bTgJcXXs2EZDks
	rSSf0fmtEEJPKxa5ae0UIqi564K07tWcDZnwMtQREyFiBsb9SP0NFKE1XdsIURAB43tk2tbMlaZ
	0JrOP/eMeHYb8oiY8hw/UTkR3egIq9hw=
X-Gm-Gg: ASbGnctgF9EaM4shyzcfgqpwzUlIVQ1DDZg/vijVcawPE3FaEpF6hcCWuoK3b4dLByF
	u+WB0u4yp7UzN5sG3LJca+DoCaZ9Tpa2eudL+7EOC/0Tx9IMXPl/Qj4DFB54Iv+Yd0FzKzTTxp/
	i6AOZsuIRTN3WU/t5T2kXhp+R4cvncgwjTVzessWIF/XSR4CIsQ63XDSz3ADjjCmytQrcLLWfG+
	F0GmygKq8V59p/D+s+Ov+OlHfslTaPufmmY5Ik=
X-Google-Smtp-Source: AGHT+IH1fnd7pg1OiM+Vful9dVduFaBmJC8BwTm18iho+3iiqRU+5s4WiBnxugsYrfCl+j7st2Br4O7QIh8RDO+5yVc=
X-Received: by 2002:a05:6402:34c2:b0:62f:65f5:a8cd with SMTP id
 4fb4d7f45d1cf-62f84213d25mr2465122a12.7.1758115374571; Wed, 17 Sep 2025
 06:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:22:42 +0200
X-Gm-Features: AS18NWCj5D-vA3jAqNwkPHxdj4sWxauOvPCPJajJmK9sXPHNO63KqrqU8QfOTfU
Message-ID: <CAGudoHHiH+2+LdQGBs8cS4Hr6sDWk6diEG+JQ7HMQbWdiNtKAA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:13=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 2:44=E2=80=AFPM Max Kellermann <max.kellermann@io=
nos.com> wrote:
>
> I don't know about ceph internals, so no comment on that front.
>
> > +/**
> > + * Queue an asynchronous iput() call in a worker thread.  Use this
> > + * instead of iput() in contexts where evicting the inode is unsafe.
> > + * For example, inode eviction may cause deadlocks in
> > + * inode_wait_for_writeback() (when called from within writeback) or
> > + * in netfs_wait_for_outstanding_io() (when called from within the
> > + * Ceph messenger).
> > + *
> > + * @n: how many references to put
> > + */
> > +void ceph_iput_n_async(struct inode *inode, int n)
> > +{
> > +       if (unlikely(!inode))
> > +               return;
> > +
> > +       if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> > +               /* somebody else is holding another reference -
> > +                * nothing left to do for us
> > +                */
> > +               return;
> > +
> > +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n",=
 inode, ceph_vinop(inode));
> > +
> > +       /* the reference counter is now 0, i.e. nobody else is holding
> > +        * a reference to this inode; restore it to 1 and donate it to
> > +        * ceph_inode_work() which will call iput() at the end
> > +        */
> > +       atomic_set(&inode->i_count, 1);
> > +
>
> That loop over iput() indeed asks for a variant which grabs an
> explicit count to subtract.
>
> However, you cannot legally transition to 0 without ->i_lock held. By
> API contract the ->drop_inode routine needs to be called when you get
> here and other CPUs are prevented from refing the inode.
>
> While it is true nobody *refs* the inode, it is still hanging out on
> the superblock list where it can get picked up by forced unmount and
> on the inode hash where it can get picked up by lookup. With a
> refcount of 0, ->i_lock not held and no flags added, from their POV
> this is a legally cached inode they can do whatever they want with.
>
> So that force setting of refcount to 1 might be a use-after-free if
> this raced against another iput or it might be losing a reference
> picked up by someone else.
>
> If you got the idea to bring back one frem from iput() in the stock kerne=
l:
>
>         if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
>                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
>                         atomic_inc(&inode->i_count);
>
> Note this guy still makes sure to take the lock first. As a side note
> this weird deref to 0 + ref back to 1 business is going away [1].
>
> I don't know what's the handy Linux way to sub an arbitrary amount as
> long as the target is not x, I guess worst case one can just write a
> cmpxchg loop by hand.
>
> Given that this is a reliability fix I would forego optimizations of the =
sort.
>
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.
>
> I see you are mentioning another deadlock, perhaps being in danger of
> deadlocking is something you could track with a flag within ceph (just
> like it happens for writeback)? Then the local iput variant could
> check on both. I have no idea if this is feasible at all for the netfs
> thing.
>
> No matter what though, it looks like the way forward concerning
> ->i_count is to make sure it does not drop to 0 within the new
> primitive.
>

That is to say the routine async routine should start with:
        if (atomic_add_unless(&inode->i_count, -1, 1))
                return;
         /* defer to iput here */

this is copy pasted, no credit needed for anyone

As you can see there is some work going on concerning these routines,
I would wager that loop over iput in writeback will go away in
mainline after the dust settles ;)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries&id=3D9e70e985bdc2[1[1c6fe7a160e4d5=
9ddd7c0a39bc077
>
> > +       /* simply queue a ceph_inode_work() without setting
> > +        * i_work_mask bit; other than putting the reference, there is
> > +        * nothing to do
> > +        */
> > +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_=
wq,
> > +                                &ceph_inode(inode)->i_work));
> > +
> > +       /* note: queue_work() cannot fail; it i_work were already
> > +        * queued, then it would be holding another reference, but no
> > +        * such reference exists
> > +        */
> > +}
> > +

