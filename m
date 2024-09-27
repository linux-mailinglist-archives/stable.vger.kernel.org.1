Return-Path: <stable+bounces-78134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4439888D9
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C491F212D9
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8961714B6;
	Fri, 27 Sep 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM86n/2i"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B81E4AE
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453756; cv=none; b=HIan4rCsrNYUUei0DCiZIdkpoQEjiK0SB00EWPVMPA//8f6xtdvVJevVkFxGc86fvMD3hV1dj1GtqerfJ1MMpqtTYqqmlIqLnxaboPFbLbxZyNttVnSXvnuphaNtJNkNi0yIGS0ON362SD5xg24XhacHWBbdcpTfUWBS1b5Vq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453756; c=relaxed/simple;
	bh=LWrf4829vvOkSyoRdV+jBc8ktKiJRk8zXnM7DFOORlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaMqZz1lDowU0xGGw20UUBqWH4L0YWFxrwMccAKOwWm+UNMnv8y4bQ+EGCS8mBNlOOdE4ZdKA8jhi/x+w66YeUFvjQ9K8JHXIhDgRzjjO3kJBXMrld/t0Tvjh1ymxQcj6fD1XcKX+nucsVucjNzvGQr4Z1iKj5h1BOoHGUuYuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CM86n/2i; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso2306443f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727453752; x=1728058552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJFcC+sypFIzCwXHVb9UWjEcafVxnGH+H6m6XnmSRgU=;
        b=CM86n/2iBlk+7lPE2kBO2RtJZdmYpr3zPC/g4kuTAGZvzPWqPP/vug0Ows9MH8yazV
         UOFfU6b7S37+owC4gMCBs27yCo6QDNrbs71w5ahwY6FKjV1bS7kIdGzoqUgk+0ew804z
         IPZlTIR78dcE7mtC68xiCg2SI5KkuUiZNQyUw4VKvlyP/q8jlowbFBYFMlqCo9bFVMV2
         P6JH/nu86dYTVI7Ke2yNk3zyeiPTCRLSXv7SVLIvavlzlgvi8iQvb7O8VLyjitbDUE97
         tfY4WGWkhRwymWd90PpdCdyMhrlm+EveNm/9EZTbTUkziODTKcSwmyMx+lcdoCUk1/kX
         KEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453752; x=1728058552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJFcC+sypFIzCwXHVb9UWjEcafVxnGH+H6m6XnmSRgU=;
        b=un+FgFlF8/AlFze7MuVeN6oF0pvin9GbAId6+mz1Jx1nF6jnE7BMcH420HfT9CmSab
         llTjCMG0vruUWu88ww1m2o/Sv5O/Yh0aKPGDOIn96dCe49UgJtsD8VWiXESxb1yt6m5r
         6/DxhJW9DaTtIg7v5jYeVU2Ma6deO/qumGpJjgSXnCScJVpM44Zw5cNZuVyQ+G5q5D0U
         5cBNST7ucJ7i5AFAnDgxcx76XL/KgTogXJT33hNvUChEJuvHsS4BUv19amSesqLFJlfR
         wdLHMK5U8xxhbMpzKk6vNcliXSrzOodAk5BdQXw3z28TAxvDMr70msO//ZSh8xvnDbNe
         NWRw==
X-Forwarded-Encrypted: i=1; AJvYcCVlXHvm0eICWzCUegMiq2WUWUHG+YclJEDXH5rMEbnuk6UYMIMN0SuRvPwnEnm5JaUVyb8Z2OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyGOhmq/o3obbmc5GKMuFCjn4SxjZ0JNmdDcviijXJ3mdmDj7Z
	UzzBuPq8Lo2QAgFU6pNI9SmMva//qAtnUppMekzuXLcMWENKB5kK1cQEP+9pmzN+AIg5N6WnnRo
	O3+L9Irh1+YSn/5rC/46tmzviQ16EYP/yZJnH
X-Google-Smtp-Source: AGHT+IEuEn6OejQZYQUK3EEJ9NfLijLJ9S4pYRkVna/dSItUziAucRaHoS3awJeiSTgJVbzWrqJaGWCbNMt8ofA1UbQ=
X-Received: by 2002:a05:6000:4f0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-37cd5aa6972mr3101004f8f.32.1727453751872; Fri, 27 Sep 2024
 09:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
 <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com> <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
In-Reply-To: <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 18:15:40 +0200
Message-ID: <CAH5fLgjnyKtXsnPbvCFz64BBRqvWPwh6reM-myWA9AEBKFhcJg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Yu-Ting Tseng <yutingtseng@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 6:13=E2=80=AFPM Yu-Ting Tseng <yutingtseng@google.c=
om> wrote:
>
> On Fri, Sep 27, 2024 at 12:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.=
com> wrote:
> > >
> > > Alice points out that binder_request_freeze_notification() should not
> > > return EINVAL when the relevant node is dead [1]. The node can die at
> > > any point even if the user input is valid. Instead, allow the request
> > > to be allocated but skip the initial notification for dead nodes. Thi=
s
> > > avoids propagating unnecessary errors back to userspace.
> > >
> > > Fixes: d579b04a52a1 ("binder: frozen notification")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVp=
wqk6RWWUNKKyJC_Q@mail.gmail.com/ [1]
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder.c | 28 +++++++++++++---------------
> > >  1 file changed, 13 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 73dc6cbc1681..415fc9759249 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binde=
r_proc *proc,
> > >  {
> > >         struct binder_ref_freeze *freeze;
> > >         struct binder_ref *ref;
> > > -       bool is_frozen;
> > >
> > >         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
> > >         if (!freeze)
> > > @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct bin=
der_proc *proc,
> > >         }
> > >
> > >         binder_node_lock(ref->node);
> > > -
> > > -       if (ref->freeze || !ref->node->proc) {
> > > -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NO=
TIFICATION %s\n",
> > > -                                 proc->pid, thread->pid,
> > > -                                 ref->freeze ? "already set" : "dead=
 node");
> > > +       if (ref->freeze) {
> > > +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATI=
ON already set\n",
> > > +                                 proc->pid, thread->pid);
> > >                 binder_node_unlock(ref->node);
> > >                 binder_proc_unlock(proc);
> > >                 kfree(freeze);
> > >                 return -EINVAL;
> > >         }
> > > -       binder_inner_proc_lock(ref->node->proc);
> > > -       is_frozen =3D ref->node->proc->is_frozen;
> > > -       binder_inner_proc_unlock(ref->node->proc);
> > >
> > >         binder_stats_created(BINDER_STAT_FREEZE);
> > >         INIT_LIST_HEAD(&freeze->work.entry);
> > >         freeze->cookie =3D handle_cookie->cookie;
> > >         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> > > -       freeze->is_frozen =3D is_frozen;
> > > -
> > >         ref->freeze =3D freeze;
> > >
> > > -       binder_inner_proc_lock(proc);
> > > -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> > > -       binder_wakeup_proc_ilocked(proc);
> > > -       binder_inner_proc_unlock(proc);
> > > +       if (ref->node->proc) {
> > > +               binder_inner_proc_lock(ref->node->proc);
> > > +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> > > +               binder_inner_proc_unlock(ref->node->proc);
> > > +
> > > +               binder_inner_proc_lock(proc);
> > > +               binder_enqueue_work_ilocked(&freeze->work, &proc->tod=
o);
> > > +               binder_wakeup_proc_ilocked(proc);
> > > +               binder_inner_proc_unlock(proc);
> >
> > This is not a problem with your change ... but, why exactly are we
> > scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? For
> > death notications, we only schedule it immediately if the process is
> > dead. So shouldn't we only schedule it if the process is not frozen?
> >
> > And if the answer is that frozen notifications are always sent
> > immediately to notify about the current state, then we should also
> > send one for a dead process ... maybe. I guess a dead process is not
> > frozen?
> Yes this is to immediately notify about the current state (frozen or
> unfrozen). A dead process is in neither state so it feels more correct
> not to send either?

Okay.

On the other hand, I can easily imagine userspace code being written
with the assumption that it'll always get a notification immediately.
That would probably result in deadlocks in the edge case where the
process happens to be dead.

Alice

