Return-Path: <stable+bounces-78264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4D98A536
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F42D1C202F7
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E619049E;
	Mon, 30 Sep 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4+sO1An"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57218F2E1
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703019; cv=none; b=asskgn9FYIvhEOznmyM42KD3BQXXcoxJRvHdGEC7IDCSWIzqa38kVyIAKsahL/HEcJIrng8rBafHiu20KMGZqOnE+kfF2h8ePItKGZgvy1dOmQKmHJBz0gA7Y6h9enQOMqwOAj1KdGp5kbGlzxZTcZzmucehWzRvi4Qc/XFN2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703019; c=relaxed/simple;
	bh=/n7vQQkZbNkpu/I0FxVHMtWx4dPCOlVBE4e1pK5d2Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETeSnwSKH9Phn9SnIaUBH9MGN7NdQDQ3vJ8NRgpd9eDrfssntZMnXYAz46mwrYD2U49R0zG8kLprmbU0ptlnfeKtgd+4mX37xCVnIH4+yt+GL7nTbJjlh1cC6wSkT1vccij8Pzh61Moy0VT9OSgv//jrxANESZYOOX87T3+wa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4+sO1An; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso2932829f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727703015; x=1728307815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKSU0R00wOvVqIyeSh3/UuGidxso/ZEvJ+/PBoO5j/Q=;
        b=x4+sO1An/3RVOla413bNHdkDd3F8xMn+t6fnz6KcvIgHj5wMQvQytvBZINGvoUyCkm
         UGp5kxQdVMDIcnEwL94R6X+XrNTgc+enJBzZFbjL8ryyh+oDCsgpEuOeSrze6Hugn175
         BcJqTAU1JdeMVBoXoa4cLsaZG6IJ0FO6KkrX5mN1AyWrsk1JbQlPpdc6scWyrnNeA7yx
         VZwy7GuA5BnnX3Ct8osKxMrVPQ2JwUMlWoCQbCLVx6iZCjUJQRSq7e/jwoU4LCKxwOo9
         H88CwgYjqiIQ2NKQB0YwjDPJfjhAIEVCbQTPRogxLxHs9HlbNoO0HFvY9C2QsalsDir1
         492Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703015; x=1728307815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKSU0R00wOvVqIyeSh3/UuGidxso/ZEvJ+/PBoO5j/Q=;
        b=jKCR3taoMgIbgpJJ8J8bj10qCDi/UrwppOPGifNleUh/JVzeKQtHGG/LkmjJCLDkyL
         y9h6tRrXC/o+8p4R6w1C1KP4gHR/eHynuzKGNCPZOR0hGMcP2OL4FK2WFKQc0RmdatZI
         yrRTrK/OGB7ymCzvn3twz42P/1emGIENL/uhHZQ0UK+Xy+xLkJw9QSrjpTqKCimeo+Sq
         IETC1i55JSL8TkTByqpnthuVuxovv3+koTm6ec78JLALRVWLh/OexzQBiDStD7MgZfOg
         cMFRskY+Pl7fRF6uRWpUb8RYjIjgbv6DB9B1lRHxt8wo/mlcCDYqdv38il74jOeiXuKl
         n3bA==
X-Forwarded-Encrypted: i=1; AJvYcCXJk/n3JWXwh7+OPsVC4hXKsaIru47YYwX8pdhek3W6URma6+j57HvnZbZGqf0zZelYpmWzgyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ei6LWamnbIYWR/nKvUx5OCXb0xjNslxQejRS5yZ7ou06iNOV
	sHwwwD6MKsTDNbLPgfdO0U840PI9mI1QqJwma59BFqnC9a4e3BZZKaA5e4xoMBgW9cU1jzIC+Ht
	NbG6T3B6cuSg4PYIHdUTJoizzbyufkG2covNV
X-Google-Smtp-Source: AGHT+IGhG80yy7VmFB5XiKVCMCB2sWXXuBFf/Ku6FQTSbPOTdG1KnvWxsrTZrSgBRyOLV/Ae04GMKwUzxiPFk1dR1Uo=
X-Received: by 2002:a5d:5145:0:b0:37c:ccc1:17d2 with SMTP id
 ffacd0b85a97d-37cd5a9d0b6mr6427964f8f.34.1727703015192; Mon, 30 Sep 2024
 06:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
 <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
 <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
 <CAH5fLgjnyKtXsnPbvCFz64BBRqvWPwh6reM-myWA9AEBKFhcJg@mail.gmail.com> <ZvbeCg5Ho6p-VU5o@google.com>
In-Reply-To: <ZvbeCg5Ho6p-VU5o@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 30 Sep 2024 15:30:01 +0200
Message-ID: <CAH5fLgjB-ia+UhE1P8gOxHTdjSJJ1=xKSS0c75AvGA91uo_fEw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Carlos Llamas <cmllamas@google.com>
Cc: Yu-Ting Tseng <yutingtseng@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:32=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Fri, Sep 27, 2024 at 06:15:40PM +0200, Alice Ryhl wrote:
> > On Fri, Sep 27, 2024 at 6:13=E2=80=AFPM Yu-Ting Tseng <yutingtseng@goog=
le.com> wrote:
> > >
> > > On Fri, Sep 27, 2024 at 12:19=E2=80=AFAM Alice Ryhl <aliceryhl@google=
.com> wrote:
> > > >
> > > > On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@goo=
gle.com> wrote:
> > > > >
> > > > > Alice points out that binder_request_freeze_notification() should=
 not
> > > > > return EINVAL when the relevant node is dead [1]. The node can di=
e at
> > > > > any point even if the user input is valid. Instead, allow the req=
uest
> > > > > to be allocated but skip the initial notification for dead nodes.=
 This
> > > > > avoids propagating unnecessary errors back to userspace.
> > > > >
> > > > > Fixes: d579b04a52a1 ("binder: frozen notification")
> > > > > Cc: stable@vger.kernel.org
> > > > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > > > Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgT=
zwVpwqk6RWWUNKKyJC_Q@mail.gmail.com/ [1]
> > > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > > ---
> > > > >  drivers/android/binder.c | 28 +++++++++++++---------------
> > > > >  1 file changed, 13 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > index 73dc6cbc1681..415fc9759249 100644
> > > > > --- a/drivers/android/binder.c
> > > > > +++ b/drivers/android/binder.c
> > > > > @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct b=
inder_proc *proc,
> > > > >  {
> > > > >         struct binder_ref_freeze *freeze;
> > > > >         struct binder_ref *ref;
> > > > > -       bool is_frozen;
> > > > >
> > > > >         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
> > > > >         if (!freeze)
> > > > > @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct=
 binder_proc *proc,
> > > > >         }
> > > > >
> > > > >         binder_node_lock(ref->node);
> > > > > -
> > > > > -       if (ref->freeze || !ref->node->proc) {
> > > > > -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZ=
E_NOTIFICATION %s\n",
> > > > > -                                 proc->pid, thread->pid,
> > > > > -                                 ref->freeze ? "already set" : "=
dead node");
> > > > > +       if (ref->freeze) {
> > > > > +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFI=
CATION already set\n",
> > > > > +                                 proc->pid, thread->pid);
> > > > >                 binder_node_unlock(ref->node);
> > > > >                 binder_proc_unlock(proc);
> > > > >                 kfree(freeze);
> > > > >                 return -EINVAL;
> > > > >         }
> > > > > -       binder_inner_proc_lock(ref->node->proc);
> > > > > -       is_frozen =3D ref->node->proc->is_frozen;
> > > > > -       binder_inner_proc_unlock(ref->node->proc);
> > > > >
> > > > >         binder_stats_created(BINDER_STAT_FREEZE);
> > > > >         INIT_LIST_HEAD(&freeze->work.entry);
> > > > >         freeze->cookie =3D handle_cookie->cookie;
> > > > >         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> > > > > -       freeze->is_frozen =3D is_frozen;
> > > > > -
> > > > >         ref->freeze =3D freeze;
> > > > >
> > > > > -       binder_inner_proc_lock(proc);
> > > > > -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->to=
do);
> > > > > -       binder_wakeup_proc_ilocked(proc);
> > > > > -       binder_inner_proc_unlock(proc);
> > > > > +       if (ref->node->proc) {
> > > > > +               binder_inner_proc_lock(ref->node->proc);
> > > > > +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> > > > > +               binder_inner_proc_unlock(ref->node->proc);
> > > > > +
> > > > > +               binder_inner_proc_lock(proc);
> > > > > +               binder_enqueue_work_ilocked(&freeze->work, &proc-=
>todo);
> > > > > +               binder_wakeup_proc_ilocked(proc);
> > > > > +               binder_inner_proc_unlock(proc);
> > > >
> > > > This is not a problem with your change ... but, why exactly are we
> > > > scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? F=
or
> > > > death notications, we only schedule it immediately if the process i=
s
> > > > dead. So shouldn't we only schedule it if the process is not frozen=
?
>
> For death notifications, we only care about a remote binder's death.
> Unlike freeze, in which we have a state that can toggle at any point.
> This is important for suspending and resuming transactions to a node.
>
> Sending the freeze notification immediately allows for (1) userspace
> knowing the current state of the remote node and (2) avoiding a race
> with BINDER_FREEZE ioctl in which we could miss a freeze/thaw.
>
> > > > And if the answer is that frozen notifications are always sent
> > > > immediately to notify about the current state, then we should also
> > > > send one for a dead process ... maybe. I guess a dead process is no=
t
> > > > frozen?
> > > Yes this is to immediately notify about the current state (frozen or
> > > unfrozen). A dead process is in neither state so it feels more correc=
t
> > > not to send either?
> >
> > Okay.
> >
> > On the other hand, I can easily imagine userspace code being written
> > with the assumption that it'll always get a notification immediately.
> > That would probably result in deadlocks in the edge case where the
> > process happens to be dead.
>
> There are different ways to proceed with this dead node scenario:
>
> 1. return ESRCH
> 2. silently fail and don't allocate a ref->freeze
> 3. allocate a ref->freeze but don't notify the current state
> 4. allocate and send a "fake" state notification.
>
> I like 1 just because it is technically the correct thing to do from the
> driver's perspective. However, it does complicate things in userspace as
> we've discussed. Option 2, could work but it would also fail with EINVAL
> if a "clear notification" is sent later anyway. Option 3 changes the
> behavior of guaranteeing a notification upon success. Option 4 can cause
> trouble on how a "not-frozen" notification is handled in userspace e.g
> start sending transactions.
>
> As you can see there is no clear winner here, we have to compromise
> something and option #3 is the best we can do IMO.

I am happy with both #3 and #4. I think #1 and #2 are problematic
because they will lead to userspace getting errors on correct use of
Binder.

Alice

