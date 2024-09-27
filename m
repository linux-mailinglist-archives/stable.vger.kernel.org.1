Return-Path: <stable+bounces-78136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25807988914
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9003281880
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C616D4E5;
	Fri, 27 Sep 2024 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDKLvxOK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F65234
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454737; cv=none; b=aWxhc3qL9dWLBHac594pOunS163RvRa2oDSy5D0Wysgva4wxk5FVI4tcJvqSlFjtNRgHhg17JdAwrnr3YBrTbAObidNdfwdtU42oWwBLbfWsmFw+VrKIMcj3ZWRsXeqervMMC1u6fMnoxCev8mvtYWOEjtv33iZi4g3miRdM4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454737; c=relaxed/simple;
	bh=6+GMeQXCf9Q0BnxZJLc4yFMZRCGRQksDHZ5OueXWU44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVfleP68XDMJu/GXrGfouYmkOr6CD6MwMNIeSx5mP9y9L01RVP/9wfAh0VBoaGXPUgzm/5xoaN/l8CR8jmbvV7f8RLMqg1PUtRb7HfdnV03UXkZCWecHbqvhxQl1uqKKEBcbk0IWutNMz22sId35VjzrGpMubpTvAnwkpuned2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDKLvxOK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b061b7299so191765ad.1
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727454735; x=1728059535; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T55+XweVk/w13JnIHjNeR6jsJ3mnW0Rl9vBiTmF/Lxg=;
        b=tDKLvxOKwpwxH6x97dbJnMUNdnkA1zIheJv6ZEar+ECLrFz3pboyLLpnrL9sucSEs/
         jPvqmmYqkeZoO/hAa+s9fok4IVTR2SrdD9V9nhxEl5jv/LI9HNMCpReqLik0f0eLqUEE
         cqPO4efKxbec2JSh2Or9i3+6d4EczyjQb8VbmeqTEUmrMLVvvCySQqakkIa/LdwEB4Z6
         z0rNDKXxJ4+ZOgjzBVpv6mQEG3Gzrr0FIiEdZ8VEhsisgvmcrDhQyxwlw4i/uf6n2uy7
         AolGchXr2Bu43yALmrDEMorJtQJDTfOi0YPUToHw7KXcw0FqrY35MpJiqRUoIAh4zo58
         CaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454735; x=1728059535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T55+XweVk/w13JnIHjNeR6jsJ3mnW0Rl9vBiTmF/Lxg=;
        b=MFkZeuHjQw6N66f8wNl0uQmPJk3hnTPlyDiS1gCrrImdDloLcMYyf3H0ES/1XndMqj
         Xr4u7rZ5Yeatph0U605A+hEueSqSfoxGhct3QNYrQgDzSDQ9gNynpGouos5d0mcvFVj+
         ZLxlUQ5mFHFEjZVzxa3fddA38zKo10/9BWQjXGSaDoRNsiymx9jQRMz9uJvwHOJ+hlQn
         PGHQ6aPSXoGl6YAAUla3JlTVQP997TJ7ksebfDoULtj/LacanX5PkpJmB25pXW+rdaJ2
         tuAtnFnrYXG8LsYDtwi3nSQD5UvKd2uIvgL88XlFGxKNQ70QAb4wMZ/so2QIj/GQksXT
         bVfw==
X-Forwarded-Encrypted: i=1; AJvYcCVMe6iyxhvAfuPmUwoqJgXm+yjpHlc2T7ScXKwOCftsIuXIfGWEeIrto/KYnF3zdmpknrv36Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3v35qIo2iuAFzIF9ttCqe2hCa+A3JmSbcX5u9Tete0TZPxen
	NS5ww7F0Lx+b9k4LnU7hjjgqE5YTC+5VRwGX3EFk9yk8L+Gr5DAoL1KuaLqU9g==
X-Google-Smtp-Source: AGHT+IERC+QZegLlyWcleseTDApGQjpHryAcyc0sQgkxXSK9L6Z5l8ucA78bfeScZAG+Qud3BsNUiQ==
X-Received: by 2002:a17:902:cece:b0:206:bf6e:6001 with SMTP id d9443c01a7336-20b3d576500mr2544045ad.17.1727454735238;
        Fri, 27 Sep 2024 09:32:15 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db29278esm1802976a12.16.2024.09.27.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:32:14 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:32:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yu-Ting Tseng <yutingtseng@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
Message-ID: <ZvbeCg5Ho6p-VU5o@google.com>
References: <20240926233632.821189-1-cmllamas@google.com>
 <20240926233632.821189-7-cmllamas@google.com>
 <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
 <CAN5Drs3TCGT1rWJjujo3FP3HxnSFUFo5hcWh=4+xhOYzDg4JqQ@mail.gmail.com>
 <CAH5fLgjnyKtXsnPbvCFz64BBRqvWPwh6reM-myWA9AEBKFhcJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjnyKtXsnPbvCFz64BBRqvWPwh6reM-myWA9AEBKFhcJg@mail.gmail.com>

On Fri, Sep 27, 2024 at 06:15:40PM +0200, Alice Ryhl wrote:
> On Fri, Sep 27, 2024 at 6:13 PM Yu-Ting Tseng <yutingtseng@google.com> wrote:
> >
> > On Fri, Sep 27, 2024 at 12:19 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > On Fri, Sep 27, 2024 at 1:37 AM Carlos Llamas <cmllamas@google.com> wrote:
> > > >
> > > > Alice points out that binder_request_freeze_notification() should not
> > > > return EINVAL when the relevant node is dead [1]. The node can die at
> > > > any point even if the user input is valid. Instead, allow the request
> > > > to be allocated but skip the initial notification for dead nodes. This
> > > > avoids propagating unnecessary errors back to userspace.
> > > >
> > > > Fixes: d579b04a52a1 ("binder: frozen notification")
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > > > Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com/ [1]
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > >  drivers/android/binder.c | 28 +++++++++++++---------------
> > > >  1 file changed, 13 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index 73dc6cbc1681..415fc9759249 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_proc *proc,
> > > >  {
> > > >         struct binder_ref_freeze *freeze;
> > > >         struct binder_ref *ref;
> > > > -       bool is_frozen;
> > > >
> > > >         freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
> > > >         if (!freeze)
> > > > @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_proc *proc,
> > > >         }
> > > >
> > > >         binder_node_lock(ref->node);
> > > > -
> > > > -       if (ref->freeze || !ref->node->proc) {
> > > > -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFICATION %s\n",
> > > > -                                 proc->pid, thread->pid,
> > > > -                                 ref->freeze ? "already set" : "dead node");
> > > > +       if (ref->freeze) {
> > > > +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION already set\n",
> > > > +                                 proc->pid, thread->pid);
> > > >                 binder_node_unlock(ref->node);
> > > >                 binder_proc_unlock(proc);
> > > >                 kfree(freeze);
> > > >                 return -EINVAL;
> > > >         }
> > > > -       binder_inner_proc_lock(ref->node->proc);
> > > > -       is_frozen = ref->node->proc->is_frozen;
> > > > -       binder_inner_proc_unlock(ref->node->proc);
> > > >
> > > >         binder_stats_created(BINDER_STAT_FREEZE);
> > > >         INIT_LIST_HEAD(&freeze->work.entry);
> > > >         freeze->cookie = handle_cookie->cookie;
> > > >         freeze->work.type = BINDER_WORK_FROZEN_BINDER;
> > > > -       freeze->is_frozen = is_frozen;
> > > > -
> > > >         ref->freeze = freeze;
> > > >
> > > > -       binder_inner_proc_lock(proc);
> > > > -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> > > > -       binder_wakeup_proc_ilocked(proc);
> > > > -       binder_inner_proc_unlock(proc);
> > > > +       if (ref->node->proc) {
> > > > +               binder_inner_proc_lock(ref->node->proc);
> > > > +               freeze->is_frozen = ref->node->proc->is_frozen;
> > > > +               binder_inner_proc_unlock(ref->node->proc);
> > > > +
> > > > +               binder_inner_proc_lock(proc);
> > > > +               binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> > > > +               binder_wakeup_proc_ilocked(proc);
> > > > +               binder_inner_proc_unlock(proc);
> > >
> > > This is not a problem with your change ... but, why exactly are we
> > > scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? For
> > > death notications, we only schedule it immediately if the process is
> > > dead. So shouldn't we only schedule it if the process is not frozen?

For death notifications, we only care about a remote binder's death.
Unlike freeze, in which we have a state that can toggle at any point.
This is important for suspending and resuming transactions to a node.

Sending the freeze notification immediately allows for (1) userspace
knowing the current state of the remote node and (2) avoiding a race
with BINDER_FREEZE ioctl in which we could miss a freeze/thaw.

> > > And if the answer is that frozen notifications are always sent
> > > immediately to notify about the current state, then we should also
> > > send one for a dead process ... maybe. I guess a dead process is not
> > > frozen?
> > Yes this is to immediately notify about the current state (frozen or
> > unfrozen). A dead process is in neither state so it feels more correct
> > not to send either?
> 
> Okay.
> 
> On the other hand, I can easily imagine userspace code being written
> with the assumption that it'll always get a notification immediately.
> That would probably result in deadlocks in the edge case where the
> process happens to be dead.

There are different ways to proceed with this dead node scenario:

1. return ESRCH
2. silently fail and don't allocate a ref->freeze
3. allocate a ref->freeze but don't notify the current state
4. allocate and send a "fake" state notification.

I like 1 just because it is technically the correct thing to do from the
driver's perspective. However, it does complicate things in userspace as
we've discussed. Option 2, could work but it would also fail with EINVAL
if a "clear notification" is sent later anyway. Option 3 changes the
behavior of guaranteeing a notification upon success. Option 4 can cause
trouble on how a "not-frozen" notification is handled in userspace e.g
start sending transactions.

As you can see there is no clear winner here, we have to compromise
something and option #3 is the best we can do IMO.

--
Carlos Llamas

