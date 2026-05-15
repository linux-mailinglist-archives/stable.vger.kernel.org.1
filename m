Return-Path: <stable+bounces-248922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O4jE06MB2rB8AIAu9opvQ
	(envelope-from <stable+bounces-248922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:12:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE279557ADB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FEB83027942
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBE3EC2D1;
	Fri, 15 May 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCEFE8El"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8272D7DE9
	for <stable@vger.kernel.org>; Fri, 15 May 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879514; cv=pass; b=roe1okeFJ/G9NSJ7m+oGiLUt8J3FTAkzecD4HPt2xmMI9eRJpuKFyG+Rxokb2uc0vMFzguAD77zpkUqOWB/4EPwMub6OWAVDPlHWEMCF4qFsgDAySe39Ih4s+1exbeffBbcUcJk5+ENOT6l7ADD2SkNHYan87pxffaOqLxDeHOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879514; c=relaxed/simple;
	bh=3TjuOpB2lyamMgV8Ic10Si9R+GxCvn+A/B0vEzNJ99I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoaYShZRpdYSp5GA9xPhEPN9v2WRuY2vgZCrnVO2VTxIf7B8JGera/bZx/4kFD3TPCPdrq79YkUKNee8afM9rinJFUdZ5t3tL5PnmiuwwSSVWl9SpFJhG9OI8rVOvX+S6APR+f8LlO56tocJ0ySDLs+rh5EpywwSqhPXaD4xT9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCEFE8El; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so3568175e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 14:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778879511; cv=none;
        d=google.com; s=arc-20240605;
        b=Kabdi/1O5XNemNkfMpmoAKg0rlX245oxHkBc+kMbHWfQIrZeUumqHrslNquz3uHA6r
         dQXoOuSZqNLJ8BEICknuUBhaDZOiLdqDy1AO0jdF6bBoGxEoPEB52FJpKKw2brjkQxzw
         DiqXtwmYfFjzIjksROE5H2H7KtYduyc7AbIQOh2fXPjg+xq48iTSbn+biuYBh4Nr+TVR
         WvOIjqGn/DXqMIdYSxwQlCc/BUw22cdkdebdoznxXoJsuHo5ca8IUIDlC6Cz/un6UI7k
         411snRgOc5ZNQef06rfmNi/DX0o+Aoo+IuTJC301lHfcPNvwFXYe7ww5chjzF82qK7Um
         A4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9dlhdpYH17+Qki5zJW4Mxe8q+cYkrVb0hBea1Jft3jA=;
        fh=dY5KWm+KJ04VZ9X86oMOD6F8lrYAQmlpSAYDqTAxA7E=;
        b=A1zh/QtaC8R0Tj/YxbKefBHQrXB8xH9T0p7p9jNzGz9JW5LOIvrxkZVmcoZziKra5g
         XnVJYyio3w8q0VsWjexKoDzUCCqOZhc681QNgJXi6wkByr58Ifm1QnRoT8ABjM/crQXT
         L+NzRNponpnwZs5Cc4mL10tcYbJOBiVQKz/lAsZsYYTxilFpurGEO2JXipoeBf+ZjbZV
         IFe4Yh91sN8Ft99+obuCVV4cAMGuyTGDx1k4/i2ftaouu0BFQiTtuR4PBQN6IDZLF19g
         j8QbdYLH7jLsSQK4zAtjFlSNp8zhAFdCDl1ETnEACXlg8K8+cY3hpyqKkkX4c2hF5NFa
         g/Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879511; x=1779484311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dlhdpYH17+Qki5zJW4Mxe8q+cYkrVb0hBea1Jft3jA=;
        b=sCEFE8ElbYl2akXHyhtm0CW5fesPTj8Q7rNDAnUAULDe+J9T4FMJw85RPALN40OSar
         u0aqp5KmgNgg/ZsYd5WpOGgMdoMo0+qOC8kdb8WvEaSBoeFpWCXi2WLsxhjdmgND3Aaa
         AOeRlbLh8S/jkiZ5A1UUDJWiVQA5DoqlYsgXa9lIox3FXjDShuiuJPBv6EKfxHu1hyNL
         bs4+yavZI8EYEzDhabegxuhLgDK6W1SPLnQIKG6okejYxiDy14Dh07d5rRk8yON688sg
         fr8Cs0nfN5yVPaf5xLRfWz3wsGn2SrYd4RmAXJkD5B/ar3Phw2v8jmUkaW7qUL/1XWPs
         Fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879511; x=1779484311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dlhdpYH17+Qki5zJW4Mxe8q+cYkrVb0hBea1Jft3jA=;
        b=b3cyG0dy7GHRnW0/Eh/mAtttFS8Zsfp1FXmm3Y175cVq5AK1c038yxBPsw8IsQ7iWY
         lpR4F1hFd27+VYFXTMrBBF4DQejmQyskGcTSgyg3zGs0u3860Tl5uhYjwtbk73K5LBXN
         /NFoiJiMezlaDoX1tp0kqYFgdGhHhckdqipcaUwcFcPUitzxR+K9G9otD+7btedAhF9v
         Gc8rStIwU+ybnB2a1HBRV4sk5yNoEkuF1mHwbNR5DUnM2OasxeJSPVwYlKOTtIGGkz0U
         EJiktxTwOXiWkcGY6QGeUTFTfudrUcZbxKbMgq0zVksL1onPR7zsufB8C8gcoeIy5uFC
         0lww==
X-Forwarded-Encrypted: i=1; AFNElJ8nxYMeyDtqBtG2g1YGD0w4qu5/VdQMwCQWHxujMQ1xfkuFRfz2p06DXnrfvuciXHhji8gIoY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFsdNBj7vC6MuUV6ISFZNfUoRxJcBB5TRoicXVY4wmfobzENJ
	vEDw+zj8D94ikbouXlR9CLdvOTS18sq0sX9v4COWzgZKkwXsxf5/vlG+o+3RZw1UuklL9rzB8GL
	G0wdP8Oy9XootYe1i82iO02aLw+2kaGk=
X-Gm-Gg: Acq92OEDliq5IIjKcC7rFi9dfw8dWI07CXMTI9uszc7KLCFc5vO/cx5VMiXVqLzzn4I
	/IRSN0s4ZiabnlL9Ztf+T9ClgODSXFS2RalUbbiht6IZSTZi1YJ88wXTG1V6xguw7/5K6Owa2fH
	iKuTimwLuRnqisL2Q5+mLYWHAU0mh1hO2A/8dvmy3CIN+Q4ZSQXStrLKVghnUv9vwKmiuMqu1Rg
	5FX9dVfxw8STwPUz5MWhhWT4aoDq+Cbed26qH9aTtGx800P744aolAMSWxgu8RUSaZXqXJ7Iytd
	6DoVyU7Jzi1YKous
X-Received: by 2002:a05:600c:c087:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48fe60de6a7mr66320875e9.3.1778879511207; Fri, 15 May 2026
 14:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
 <20260515045541.1171335-4-joannelkoong@gmail.com> <5c010e24-b4f7-481a-97e8-00da0aec6f3c@bsbernd.com>
In-Reply-To: <5c010e24-b4f7-481a-97e8-00da0aec6f3c@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 May 2026 14:11:39 -0700
X-Gm-Features: AVHnY4L72wtPYsCQW0YZXK928lTcN9ns6pnXhedctWR6HgruyXhZFORt2QwcYKw
Message-ID: <CAJnrk1bY-2_6biL2dzsu8CLW_daYfpBM=sGxGRXOxj5qvOTFGw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] fuse: fix moving cancelled entry to
 ent_in_userspace list
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, ali@ddn.com, 
	horst@birthelmer.de, Heechan Kang <gganji11@naver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BE279557ADB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248922-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux.dev,ddn.com,birthelmer.de,naver.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 4:10=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 5/15/26 06:55, Joanne Koong wrote:
> > fuse_uring_cancel() moves entries that are available (these have no req=
s
> > attached) to the ent_in_userspace list. ent_list_request_expired()
> > checks the first entry on ent_in_userspace and dereferences
> > ent->fuse_req unconditionally, which will crash on a cancelled entry
> > that was moved to this list.
> >
> > Fix this by freeing the entry and dropping queue_refs directly in
> > fuse_uring_cancel(). This is safe because cancel is the cancel handler
> > itself - after io_uring_cmd_done(), no more cancels will be dispatched
> > for this command, and teardown serializes with cancel via queue->lock.
> >
> > Since cancel now decrements queue_refs, fuse_uring_abort() must no
> > longer gate fuse_uring_abort_end_requests() on queue_refs > 0, as
> > cancelled entries may have already dropped queue_refs while requests ar=
e
> > still queued. Remove the gate so abort always flushes requests and stop=
s
> > queues.
> >
> > Reported-by: Heechan Kang <gganji11@naver.com>
> > Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration c=
heck")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Jian Huang Li <ali@ddn.com>
> > Co-developed-by: Horst Birthelmer <horst@birthelmer.de>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c   | 6 ++++--
> >  fs/fuse/dev_uring_i.h | 6 +++---
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index d9108b5b5db8..f4ba64a1796a 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -511,8 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *=
cmd,
> >       queue =3D ent->queue;
> >       spin_lock(&queue->lock);
> >       if (ent->state =3D=3D FRRS_AVAILABLE) {
> > -             ent->state =3D FRRS_USERSPACE;
> > -             list_move_tail(&ent->list, &queue->ent_in_userspace);
> > +             list_del_init(&ent->list);
> >               need_cmd_done =3D true;
> >               ent->cmd =3D NULL;
> >       }
> > @@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *=
cmd,
> >       if (need_cmd_done) {
> >               /* no queue lock to avoid lock order issues */
> >               io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
> > +             kfree(ent);
> > +             if (atomic_dec_and_test(&queue->ring->queue_refs))
> > +                     wake_up_all(&queue->ring->stop_waitq);
> >       }
> >  }
>
> Hmm, ok, I had done that via fuse_uring_entry_teardown(), but this way
> is also fine.
>
> While thinking about it over night, I wonder if we should abort the
> connection here. Calls for fuse_uring_cancel() / IO_URING_F_CANCEL
> happen when
>
> a) The daemon dies - that is what I had written the function for
> b) When one calls
>
> With reduced rings queues we would actually need to have per queue refs
> and if a single queue reaches 0, it would need to re-calculate the
> queue. In general this gets complex and from my point of view, if
> fuse-server wants to re-initialize queues, fuse-server should:
>
> a) wake up the ring thread with an eventfd (libfuse already has that)
> b) we need a reconfig SQE (like FUSE_IO_URING_CMD_RECONFIG) that
> requests to re-configure things
>
> Right now that is all not supported, from my point of view we should
> call fuse_abort_conn() when we call into fuse_uring_cancel()
>

From what I see, I don't think it's safe to call the abort in
fuse_uring_cancel() since the cancel runs in the io_uring submitter's
task context and the uring lock is held when it gets called. The abort
logic can trigger calls to io_uring_cmd_done(cmd, -ENOTCONN,
IO_URING_F_UNLOCKED) (through fuse_uring_stop_queues() ->
fuse_uring_entry_teardown()) which will lead to a deadlock in trying
to acquire the lock that's already held. I like the idea of keeping
things simple with just aborting, but I think in actuality it might
lead to more trouble.

Thanks,
Joanne
>
> Thanks,
> Bernd
>
> >
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 368f4d0790eb..22ec67e39ee0 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_c=
han *fch)
> >       if (ring =3D=3D NULL)
> >               return;
> >
> > -     if (atomic_read(&ring->queue_refs) > 0) {
> > -             fuse_uring_abort_end_requests(ring);
> > +     fuse_uring_abort_end_requests(ring);
> > +
> > +     if (atomic_read(&ring->queue_refs) > 0)
> >               fuse_uring_stop_queues(ring);
> > -     }
> >  }
> >
> >  static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fc=
h)
>

