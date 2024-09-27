Return-Path: <stable+bounces-78133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5E9888CC
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9831C21958
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF91C0DFB;
	Fri, 27 Sep 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyCtzk6/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6621465A9
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453630; cv=none; b=jGhHmtKegzRd7W9MzALArcZE58OM7TzKpjLMbdk2U6GPtRILooAZpivXNFqFJPiQKgJvounhacjgEAolNeRnqBpyBdtAMGablEg5s3pPeWgI82yNGGZnepv1d9AQOa0crS24EukzzOrL3DlPoeuXpknm+oOKZuWp5M6F9wUPT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453630; c=relaxed/simple;
	bh=7kU6XoxUAcIgBj0KIhY5INXnY9DzzTkhFr/l3iiJ8JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrMumFlH7OpkuK8uh6lTxgf47LPLURV7oj+ip22vybPT7DZM0YMOpsJsiKP65NtPyjQMYTKGBzlMrQl1dXDJPWZ6uPN/jS6cAq9tb8a6zQKOsR96Y1fJQap5r8yyTM16bucTV1s59vdc8wE7EoD3XbSCFYtZcn+usgDas3MzmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyCtzk6/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b3d1a77bbso165525ad.0
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727453628; x=1728058428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEfwOX0k0jsdiAz/mx4JtQIPRHf7GHZcKBgddoeHMM0=;
        b=ZyCtzk6/2CU9lSsVFR/r9ziw1TPZDJtiNNvvokiqDkQJ+kukM1Y/2oLGP1DgR2EWGb
         KhftS1bJPCpdLrbTyO8ZDFj7HJgIGLp26aWOgSLoD3O0hfHztkgRsVkyLSJV9BqhNIeR
         1jKhIglAe+BVlRRHw8Y5m++Wfsl4do3SOXqjqKJaSJcrR0DmTTlSwVAkkyg3NQs9woW8
         sFRIvwdtI1/6nY0A3+k/qsfUlFhTX1vXb+Q3ilv93km/BpNMsYcLyqNysiLo10S+N2Zn
         oh59hivEu75zCR9llUosUuFZA0RmMNS0RaI80ZWwMJg+fv4PRte3jPTTRA1it83SC8sb
         +yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453628; x=1728058428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEfwOX0k0jsdiAz/mx4JtQIPRHf7GHZcKBgddoeHMM0=;
        b=CqIkfCYP06eOKQlia3KDbVd7HRvoj9nYY+yFR346npYjk5Vk4bS+nVFIM3hEwkgeON
         82kYAf1ewTQnB6osR5oiIwVFDwhi8TIxVJGTNpfPDaUxjiWUUPe6SVWI+Y7xw2zBbKDT
         Lbylp5oxyfpRImBdZa08klcuHsD8IrlutqCsrizlZhpgmQ+D/HzylntcIdLKW4b8lu+M
         TeXbmK5Idkr+AIHSXZVRld4ocjqZEIXhu9EfDTKJhNBsKjlNqBljISvvPpJ6+7Hqi5av
         Ea9+sWTy+YUV/jv1SniQqO9KxzHyFO2GS/KG1QP5mYyHamD4FOnuVU2fIvIBkUphRVKD
         IgTA==
X-Forwarded-Encrypted: i=1; AJvYcCV/4XFnWuKgp9Uawk5tqZX0oqYSpTWJ/5uQI3VJuAHaWn2IN/+Xk6B7kswDzqHd5pwd2qq5Bdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY68oyQf/t+qHe6gRchJml/CRoumOq/4ssTxAgktt8U2HZkPV+
	qOATL44OBKFysxa2KHNAdQtElnzTsIjasEphzUVzCMdvgV/HyrU70TR7BU2vAXHPzzlGzbVK3b9
	LZl/xJhnQuow+toKAbM0EoU3z5NOEatiMI6pX
X-Google-Smtp-Source: AGHT+IG8N/hvJvaxu+2E3iccFfkOGWuZB6ZYaUmHLVfB3/2b9cxpaCTbUmx0migIGXlRtEDU+IRgbFFUAICLwolBmHw=
X-Received: by 2002:a17:902:f686:b0:206:aa47:adc6 with SMTP id
 d9443c01a7336-20b3d5764f4mr2377275ad.11.1727453627640; Fri, 27 Sep 2024
 09:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
 <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
In-Reply-To: <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
From: Yu-Ting Tseng <yutingtseng@google.com>
Date: Fri, 27 Sep 2024 09:13:34 -0700
Message-ID: <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.co=
m> wrote:
> >
> > Alice points out that binder_request_freeze_notification() should not
> > return EINVAL when the relevant node is dead [1]. The node can die at
> > any point even if the user input is valid. Instead, allow the request
> > to be allocated but skip the initial notification for dead nodes. This
> > avoids propagating unnecessary errors back to userspace.
> >
> > Fixes: d579b04a52a1 ("binder: frozen notification")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwq=
k6RWWUNKKyJC_Q@mail.gmail.com/ [1]
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 73dc6cbc1681..415fc9759249 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_=
proc *proc,
> >  {
> >         struct binder_ref_freeze *freeze;
> >         struct binder_ref *ref;
> > -       bool is_frozen;
> >
> >         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
> >         if (!freeze)
> > @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binde=
r_proc *proc,
> >         }
> >
> >         binder_node_lock(ref->node);
> > -
> > -       if (ref->freeze || !ref->node->proc) {
> > -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTI=
FICATION %s\n",
> > -                                 proc->pid, thread->pid,
> > -                                 ref->freeze ? "already set" : "dead n=
ode");
> > +       if (ref->freeze) {
> > +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION=
 already set\n",
> > +                                 proc->pid, thread->pid);
> >                 binder_node_unlock(ref->node);
> >                 binder_proc_unlock(proc);
> >                 kfree(freeze);
> >                 return -EINVAL;
> >         }
> > -       binder_inner_proc_lock(ref->node->proc);
> > -       is_frozen =3D ref->node->proc->is_frozen;
> > -       binder_inner_proc_unlock(ref->node->proc);
> >
> >         binder_stats_created(BINDER_STAT_FREEZE);
> >         INIT_LIST_HEAD(&freeze->work.entry);
> >         freeze->cookie =3D handle_cookie->cookie;
> >         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> > -       freeze->is_frozen =3D is_frozen;
> > -
> >         ref->freeze =3D freeze;
> >
> > -       binder_inner_proc_lock(proc);
> > -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> > -       binder_wakeup_proc_ilocked(proc);
> > -       binder_inner_proc_unlock(proc);
> > +       if (ref->node->proc) {
> > +               binder_inner_proc_lock(ref->node->proc);
> > +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> > +               binder_inner_proc_unlock(ref->node->proc);
> > +
> > +               binder_inner_proc_lock(proc);
> > +               binder_enqueue_work_ilocked(&freeze->work, &proc->todo)=
;
> > +               binder_wakeup_proc_ilocked(proc);
> > +               binder_inner_proc_unlock(proc);
>
> This is not a problem with your change ... but, why exactly are we
> scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? For
> death notications, we only schedule it immediately if the process is
> dead. So shouldn't we only schedule it if the process is not frozen?
>
> And if the answer is that frozen notifications are always sent
> immediately to notify about the current state, then we should also
> send one for a dead process ... maybe. I guess a dead process is not
> frozen?
Yes this is to immediately notify about the current state (frozen or
unfrozen). A dead process is in neither state so it feels more correct
not to send either?


>
> > +       }
> >
> >         binder_node_unlock(ref->node);
> >         binder_proc_unlock(proc);
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >

