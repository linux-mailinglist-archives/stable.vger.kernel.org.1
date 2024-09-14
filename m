Return-Path: <stable+bounces-76126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2ED978E68
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 08:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2642E286FC4
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 06:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866245027;
	Sat, 14 Sep 2024 06:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZCg9qDF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876D1805E;
	Sat, 14 Sep 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726295331; cv=none; b=Itojo1R/W1cRNs7AoccVW0153YumaHgozXIRLQoPuUr1+xOXqA4k3mcoQu0IndlE9QQYghZK7n6OvvJn0mQQ8eS1PiWZTCbZgkiqJOYqG8XNDoGp9zFvrPjO29QcDH+LcJKygChZdkdStkzBY1KLj7KnMFyQ9HiwvuHv4IEz9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726295331; c=relaxed/simple;
	bh=1qR9wHfPRJFwvSE3B98E7SDsBj44G8aq26FBsusaxmA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGrKY+VUs4EeXUuDK0b/emyf1+UOn0uwkgCLPYJEb1bj7FKrH6RaV9fuUTGk0+f+ZP9ISk38wyPV/0DAkIJcb7SwPBzY2mEVKM+Jyh0F1Wn+eam1ltkQOlEc3+8CkEACW1zemfADrwucCfwxaWo0ZnjhZsQrKH4n+x+weUbLnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZCg9qDF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581e7f31eeso13772501cf.0;
        Fri, 13 Sep 2024 23:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726295328; x=1726900128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:feedback-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/LGgXmIndL3SCPEW9jZlfhiJ8WqrC9UKkvceLgY3EA=;
        b=bZCg9qDFw20ILhsmFS6aGKQjNDkf2V+vIO8OirV5rytWGWuk+oK4JknQSV2bjck98U
         5gs7Cm4FdL6DuOyhfUaqAhIuck6OJFxVHMB2yH1T5x3Oc868mRUlCgowkQPQ6tPi+S2+
         2UdN5u6Zrlx1zNKfEqeCZpNDKlY28t6B012EX/ieZajttyK60c+qNNJulIXyVa7NanWu
         rrbLGAHBDJfim6q9Pn9DkxbDxKrdmgSsDVfi2BzFyPsUP8Q6n/dVqzkTxHHpoEhXq26l
         qe4gsijA+8Dw9wJT3G6l3T9W1cHPR9fpzjEVCu12bk6+PzG6eLjx2fx4ZOXuXyWc60TA
         7T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726295328; x=1726900128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/LGgXmIndL3SCPEW9jZlfhiJ8WqrC9UKkvceLgY3EA=;
        b=Edj6g6htdaQ2rfu4WrDmhpxNlnRjwhi+STbfZRbE6rNl5udp1YPAlZuPkivncs2n31
         CVS79DMTrEUEiyVTJ6Qp7z+KCXrpcckSZUg1d3dqwR3U5fCRDJbs1PhQnfQg8ijSeldT
         CqzRcvipc998Ug3HQIPNZHT/0A5sdHOdFpNMAG/X9bJPRunW0UKlcq9QY7r3QZ1b1rrh
         XRVbJp7HZ2wOIG7hBUa0krBW52xa+b+BBOWR5WtDbvT3xsKd5ckiryuE5naEHzPbCDUP
         5Nlk03kqMedasgKgp3F9/YufVLRiggPVix1IATatGOUTHzvxFabfpZiQBlaleT6f1x7n
         Rl/g==
X-Forwarded-Encrypted: i=1; AJvYcCU2shFU53yjU/R9seswy5y28HdY7HQZvMFalNXTm4qmdDh+pQcqkdoSD8COlwyiepJh4zx8gRGDfSIKGqA=@vger.kernel.org, AJvYcCUre3MExRWfDA3U60wTXOSY+khMSvQrd4QSSK4rwkhHwMXdjxDZM6ScvHNGC8jxW6Xbag3zgoqy@vger.kernel.org, AJvYcCXlry13XSFHrVRMJHXi9SEfsXeehTfAQmro4KVekqBlNl13spvTHZ668mkf0UNbts/DbqCOUvVutabv7/Yi2rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3BmEO+AhpU3mHvz/b8JwILhIS/ev/6142KekrS+CCwYDmcXP
	yR30uK88uIKIYi2Hd4rygO8YKSsGIiJYuOo0Gfg/PXkjA0jmeyjh
X-Google-Smtp-Source: AGHT+IHBJi3CzFMFwQpKBZFUGTbIzDHa18QYekID29Lw1qGBfZdJgqNzoqPu3k7CS8cjG+qG8L9o2Q==
X-Received: by 2002:a05:622a:15cf:b0:458:4c86:4564 with SMTP id d75a77b69052e-4599d29c7b0mr89071481cf.37.1726295328309;
        Fri, 13 Sep 2024 23:28:48 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac99ba7sm4218521cf.47.2024.09.13.23.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 23:28:47 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 43BCC1200068;
	Sat, 14 Sep 2024 02:28:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 14 Sep 2024 02:28:47 -0400
X-ME-Sender: <xms:Hy3lZlIpUIhu1C2YHldeNZSKVV7ost2PfL4uCf67MTJFkaRSnzuFMw>
    <xme:Hy3lZhJgz4rZs8rBmh1OKw35-oNtCnbXTE49mFaKx2AIYiC8l-9jMGCs2YFapmaFQ
    nDtHF-YRyCkCQNSag>
X-ME-Received: <xmr:Hy3lZttrlI4ibLq84ZHUgBGRUlSptpcXlXbHHW4YIWnH2FJFUllBWIwrMx_jMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegudegfedtjedtffdvleelteefuddvkefgheej
    uedujeehfeelkeetjeegtdefgfenucffohhmrghinhepfhhffihllhdrtghhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtg
    hpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprgdrhh
    hinhgusghorhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepthhmghhrohhsshes
    uhhmihgthhdrvgguuhdprhgtphhtthhopeihrghkohihohhkuhesghhmrghilhdrtghomh
    dprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Hy3lZmYa4KroPslS4loDGh0mdPYR8Q-r0TmqTmu4w-SaVMHpeVEfuA>
    <xmx:Hy3lZsalbh_lLyndKZ3IDjPP_KZKQumQqFlHF2iPdbD0oZrVfRKHLw>
    <xmx:Hy3lZqAVe9JzYN8e1WCOjCk4gdxOhLS5tVRdq2W00n8HJEQqdZ7v-Q>
    <xmx:Hy3lZqaG81VMtAkGJzv6H4gtBlK2pHe9vqK2Dmywn8aPY7Ep7cxuUw>
    <xmx:Hy3lZopFYoE7hK_uTQlzSPhe4nthZzEft_hV7Xv-vLG_-Cs2mnaEUfLb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 02:28:46 -0400 (EDT)
Date: Fri, 13 Sep 2024 23:28:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <ZuUtFQ9zs6jJkasD@boqun-archlinux>
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
 <ZuSIPIHn4gDLm4si@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSIPIHn4gDLm4si@phenom.ffwll.local>

On Fri, Sep 13, 2024 at 08:45:16PM +0200, Simona Vetter wrote:
> On Thu, Sep 12, 2024 at 02:20:06PM +0000, Alice Ryhl wrote:
> > The `impl Sync for LockedBy` implementation has insufficient trait
> > bounds, as it only requires `T: Send`. However, `T: Sync` is also
> > required for soundness because the `LockedBy::access` method could be
> > used to provide shared access to the inner value from several threads in
> > parallel.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> 
> So I was pondering this forever, because we don't yet have read locks and
> for exclusive locks Send is enough. But since Arc<T> allows us to build
> really funny read locks already we need to require Sync for LockedBy,
> unlike Lock.
> 
> We could split access and access_mut up with a newtype so that Sync is
> only required when needed, but that's not too hard to sneak in when we
> actually need it.
> 

Hmm.. I think it makes more sense to make `access()` requires `where T:
Sync` instead of the current fix? I.e. I propose we do:

	impl<T, U> LockedBy<T, U> {
	    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
	    where T: Sync {
	    	...
	    }
	}

The current fix in this patch disallows the case where a user has a
`Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in different
threads (they would use `access_mut()` to gain unique accesses), which
seems to me is a valid use case.

The where-clause fix disallows the case where a user has a `Foo: !Sync`,
a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
`access()`, this doesn't seems to be a common usage, but maybe I'm
missing something?

Thoughts?

Regards,
Boqun

> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> > ---
> >  rust/kernel/sync/locked_by.rs | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> > index babc731bd5f6..153ba4edcb03 100644
> > --- a/rust/kernel/sync/locked_by.rs
> > +++ b/rust/kernel/sync/locked_by.rs
> > @@ -83,9 +83,10 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
> >  // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
> >  unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> >  
> > -// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> > -// data it protects is `Send`.
> > -unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> > +// SAFETY: Shared access to the `LockedBy` can provide both `&mut T` references in a synchronized
> > +// manner, or `&T` access in an unsynchronized manner. The `Send` trait is sufficient for the first
> > +// case, and `Sync` is sufficient for the second case.
> > +unsafe impl<T: ?Sized + Send + Sync, U: ?Sized> Sync for LockedBy<T, U> {}
> >  
> >  impl<T, U> LockedBy<T, U> {
> >      /// Constructs a new instance of [`LockedBy`].
> > @@ -127,7 +128,7 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> >              panic!("mismatched owners");
> >          }
> >  
> > -        // SAFETY: `owner` is evidence that the owner is locked.
> > +        // SAFETY: `owner` is evidence that there are only shared references to the owner.
> >          unsafe { &*self.data.get() }
> >      }
> >  
> > 
> > ---
> > base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> > change-id: 20240912-locked-by-sync-fix-07193df52f98
> > 
> > Best regards,
> > -- 
> > Alice Ryhl <aliceryhl@google.com>
> > 
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

