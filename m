Return-Path: <stable+bounces-77722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD0986600
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B75B288714
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E178B50;
	Wed, 25 Sep 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdbpWG0F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F614A00
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286772; cv=none; b=YMB5Yb+SPUVyqKTsQKqRyo6MyAbTjErCaWC97BV29PqqmJjGIzPE4ERRgpGCLiUMJQRwG+fDLLpSNhAin8pofZ3SkjsWUvCX5NdJI4Q2hISWwe+i2yGEFA+zXLzfK1Lz6n1oatMQMJqRBNPI1yi8Vsm83o4J8AG37Q/l8jbs6eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286772; c=relaxed/simple;
	bh=NXPj7UQs5FYQe46mR6uLZDq9KIt0Z7v1AyYqDxDaWX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYvTIXPL0zvk58/aNdZ/xyakcwCHu78/u2cthZLgqjs14cNBDVAQyCkxhXm2ubtprNOGV9aLaG7+TzuQ9i9/BpvyWDFZ4PkKiChYI8ohg/i0xfeM3ctwNwDoNjiwshEMiVaxqREWUq8I+gxONqHdH43We6kb5/FvqT1HjFar/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdbpWG0F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso8125305e9.0
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727286769; x=1727891569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2unEEHoIuQRELKECQsB1K6g1jsAFDMcY5c87O7Y6xKo=;
        b=FdbpWG0F7u6M3Y1pm19Y1WFOPkfGeXh8DHCzcq4EHPEj7BVHmecRwLy+Nn7hkfQJ4y
         EkjZQP00VDPh2qLZ6oHXeY11edXS9j3q0aYjCn1iX+nvZzrdNkza/ptOkH8LiL3Ppuob
         l4ifI9D6/hr3BvTRYFAeqP4gIu8ki/TLi3H9jr7V2TOfygKS/tyOwVLmPRvE79hwP1pK
         /o4/9zwakTdeBKX8BHDLZI1KvyXbrzpoAMcoDx7HyrlqmMH93R4PghV16AbWDKrt+9cT
         AMGHkbpgh6yMkkdmAy+/GGNi8+sVgloNXC5Kt2vo+i6ifLb/Tgmlk05T1T8GIfGe+SgL
         odQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286769; x=1727891569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2unEEHoIuQRELKECQsB1K6g1jsAFDMcY5c87O7Y6xKo=;
        b=RQNxdaLDK1N+vUN2t8CthU7hiMo7T1urBJ7dRI7hvGoRTejSXJRu6a+UrzH6ufl6/3
         AfqPVnjVfI2omMpeLiWccI6VkC2ATWAaYqmeB6006lyiFnkg+b92J/PCF79ZZpceeDCg
         Y1yyd2gxnkcsubWxRJn25XetntLBN87+SakYH5bnrsSiq8DBmIp4kM302TDr7eC9dSSi
         6OLH9X3+mpo52qUZ0+Jy8ZVrZ1UbbaNb66yVp2OZjA77Ect9csfEpag+MaSuCWm9H27O
         viLriMEBEcZkWZYe33Bm0WPsRocGohK/VDNnMN5H7HZsylnzvBwoExJBN0NuKRh4Elo3
         3d2w==
X-Forwarded-Encrypted: i=1; AJvYcCVnno/gkGsJuC/0UOOejltXkxyOC1aPKrc1O9YQCXFCO1tADam1LDu8mh64Da6Q3RZ7TB2uTvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdTQ1KuC7UArWhXkrs0Aa8f5jCaK5+SqvazQVdqusvKQW1EEXi
	3kI8uaMC87IwF1Y7VJNDfa6zbl7DdlrVru890PsAXydArj6volZ6WKuhIVJAu8S3vkqwqx9ntkO
	ZFPn4Wh7J6LQB8rQ3FPSouSkWMwo9Dw4Z2SoW
X-Google-Smtp-Source: AGHT+IE8dLxE0FCzX80Cj9DLtMxNU+LwXCOeuZOJKT8r9VE7mUoq/MW5RpPRoVX5UFNkyYFbKrXPNqKMSXcll08TlwA=
X-Received: by 2002:adf:ead1:0:b0:374:bcfe:e73 with SMTP id
 ffacd0b85a97d-37ccdb80376mr223190f8f.28.1727286769342; Wed, 25 Sep 2024
 10:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com> <ZvRM6RHstUiTSsk4@google.com>
In-Reply-To: <ZvRM6RHstUiTSsk4@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 19:52:37 +0200
Message-ID: <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:48=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Wed, Sep 25, 2024 at 10:02:51AM +0200, 'Alice Ryhl' via kernel-team wr=
ote:
> > On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.=
com> wrote:
> > >
> > > In binder_add_freeze_work() we iterate over the proc->nodes with the
> > > proc->inner_lock held. However, this lock is temporarily dropped to
> > > acquire the node->lock first (lock nesting order). This can race with
> > > binder_deferred_release() which removes the nodes from the proc->node=
s
> > > rbtree and adds them into binder_dead_nodes list. This leads to a bro=
ken
> > > iteration in binder_add_freeze_work() as rb_next() will use data from
> > > binder_dead_nodes, triggering an out-of-bounds access:
> > >
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >   BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
> > >   Read of size 8 at addr ffffcb84285f7170 by task freeze/660
> > >
> > >   CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga7278=
12a8d45 #18
> > >   Hardware name: linux,dummy-virt (DT)
> > >   Call trace:
> > >    rb_next+0xfc/0x124
> > >    binder_add_freeze_work+0x344/0x534
> > >    binder_ioctl+0x1e70/0x25ac
> > >    __arm64_sys_ioctl+0x124/0x190
> > >
> > >   The buggy address belongs to the variable:
> > >    binder_dead_nodes+0x10/0x40
> > >   [...]
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > This is possible because proc->nodes (rbtree) and binder_dead_nodes
> > > (list) share entries in binder_node through a union:
> > >
> > >         struct binder_node {
> > >         [...]
> > >                 union {
> > >                         struct rb_node rb_node;
> > >                         struct hlist_node dead_node;
> > >                 };
> > >
> > > Fix the race by checking that the proc is still alive. If not, simply
> > > break out of the iteration.
> > >
> > > Fixes: d579b04a52a1 ("binder: frozen notification")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> >
> > This change LGTM.
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> > I reviewed some other code paths to verify whether there are other
> > problems with processes dying concurrently with operations on freeze
> > notifications. I didn't notice any other memory safety issues, but I
>
> Yeah most other paths are protected with binder_procs_lock mutex.
>
> > noticed that binder_request_freeze_notification returns EINVAL if you
> > try to use it with a node from a dead process. That seems problematic,
> > as this means that there's no way to invoke that command without
> > risking an EINVAL error if the remote process dies. We should not
> > return EINVAL errors on correct usage of the driver.
>
> Agreed, this should probably be -ESRCH or something. I'll add it to v2,
> thanks for the suggestion.

Well, maybe? I think it's best to not return errnos from these
commands at all, as they obscure how many commands were processed.

Since the node still exists even if the process dies, perhaps we can
just let you create the freeze notification even if it's dead? We can
make it end up in the same state as if you request a freeze
notification and the process then dies afterwards.

Alice

