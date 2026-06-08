Return-Path: <stable+bounces-262105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SK3AObcVJ2rErQIAu9opvQ
	(envelope-from <stable+bounces-262105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:19:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBC65A074
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cCDbhIqt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262105-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262105-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357A7300B44C
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 19:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20313E3D89;
	Mon,  8 Jun 2026 19:13:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154783C7E18
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 19:13:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946029; cv=pass; b=cxT/Ao0CZMrXrlSWN09liASv6F388XEB7iVeSlc7JCSqQg/4ptk4GZ+k3DmHytXWz1/691IYJJPhGkJrayQK1q6LoZklZeVl2MMxlcJODUbwvrlWEG9Z9IW5LJWNeKM5bRN0/r8F+H8j7AUWQ1UpB6V84K8KCuzZOo2mJC59cDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946029; c=relaxed/simple;
	bh=hvoofYd4pRxmIJvE1bKqeI7nD4JKAaK8FOXtejNsQXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkfxDm5NEnfwmshISoR84pfa9SA03fD5vGFYH9v92So2NwAfC/EHuo/ky/ACE4zzHkkipCTm5jTRgcbWUDPOnBFe0EdnaE1s4sZ0epp/cKHgUb7baNX5kRXVvvyEhSbMy02W/c9K+HiqRUJ93yjSSoJrgnwzijmbEmnPSbsrKfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCDbhIqt; arc=pass smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so13123345e9.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 12:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780946025; cv=none;
        d=google.com; s=arc-20240605;
        b=EsNmGK3QB3KrwxfwoJmJ7NjwEmOSAck8ojfaaGj/4NV9pCpI5GYLgZqNu1e4ofueCS
         4c0YI2BIrMSiAX8A9zEzmth8A4C1NnP3PU+BTEUzFuOEBj14gVypIKouayYUPWMBdiwa
         PbXnB7+0NBULWbrI/Y6iMqrq8IgUZOB3vNa7EOiEtibtGW5uDvIoljpMTBisT3Nu6XYj
         l33ehGkDkrSvaopq0++duC/DywhmQyyQ8BX1MTMKZu1ZzacDCbpCjfXA6kOyGfCs8vSA
         pltZtlApZTmgOiigcOjjaoOgzZbZDBbQUcrz9UGOVpuiJ/4UdCntUjF2qQ1rvLbu7Hap
         8J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=whHnTBaTjZ9uRWQ64SUm9BvN/A4zwEJrOExu2aqDlTs=;
        fh=ss4OQlwrTgNsnCO9QFVxlm3C4/+ifKXOHaA/P9T9LcA=;
        b=TIHUgpwW5RU9Xxu1H6y8QmLo3yX3XePymhs6YWQ/4VODZCsCDVP5XbPbVeIbi8B0N0
         67/I8Sp3Cn0j0W98lV5kiQ/ZnzTwFjIwf6SoqCK42NBKLpVc9ArEIlecjBYC3xaLsKhU
         +1bW+8znr2kf2siW07I2F0fCN4w4M/V/8yrky5a5m+HCKLdxWfR496+Dc13yLFvFRcTk
         HregR8t5PlHq2k4bNjLP5MU7rR+wd+e+ipLmUXZBxyTbLNsBk2DGIRP3SHQN2VKBCPPb
         Zzha7qZ1pj+3X8HbqVP58cHv2cHGWxMQQ8yJSeGRAsJTf/8iL5Cz6KANF0nsFSx717un
         3jJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946025; x=1781550825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whHnTBaTjZ9uRWQ64SUm9BvN/A4zwEJrOExu2aqDlTs=;
        b=cCDbhIqtajDMci7X2YRuf6ocPo8TYJS2pNoQlOVSeN87JCUPZqkmGfK+g+eYjYa4rx
         v7PjQW5jYSzTnBwpMo3GVWBDx2c0tUK+pdWROt0fD5f0MPgLyT+53Gl8G6h5qXovMbuf
         38JKsdoJ/5XbRN65XblZafZC05R5wnWrX4U+buqSCkSqf2OdaTbs+AxfC4Ay/I1Y+85z
         S/K5I7wyTPaAWeHHO/ueyEQZ45wfneWb5Tdg31YCsH+ZuiOdHxLs7BErRpx2ZieVciZB
         RSSaKGXoKvEa4zgGhoGFvNpPSZJfGembbbGl7W7g6o22swsxvb6nCP9UFttnzDAbDu+x
         2tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946025; x=1781550825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whHnTBaTjZ9uRWQ64SUm9BvN/A4zwEJrOExu2aqDlTs=;
        b=Vh5GCIL1tP/u3RO+rFlNb0Zxb7a7/vAlEo2t6G+kbqCfcbHSbHo8NnW61ufARQEgSl
         btVamp8S+uR+XYv+hQ0+hSQRWzFsKCLuykARN6bcGLOBccYrhDHKZ88OOVcqMJxx/T0+
         BITlv1RUPtyxlWz5DeRhvWRwG7szFlrEN7bcm+KqXh68sFYV9xy/fXKYIJVvAt2UHnNB
         R8M3Z4ZMmMKcIEgF2cY0d2qFsxVdRmG26BkYJ3z9CE+5Vpdvq4o/KeQZ8WebXWyU3Oh9
         BRYghSmKJz5pZxW9VHoLJCDs7Rg/dRxEw4J5HA8hdMVH3+cbXL+INfKPVInXXnyOoDw6
         TdFg==
X-Forwarded-Encrypted: i=1; AFNElJ+lOKaiq+zQV5pTg7lbrWf01gJOgXuMvjPBXdHQo2iAKBtlFWokRCOAJEMwI16fGKhuUJ1GiWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvXyhZaFf1m7NZzezohvVM03r/3B33JmnZRrtw+Oe2Q+CZh0A
	t1a6VfhVDLkxpYFdOmFCxgrXozSY1ORY+UK2KaBQ7vKKXGXDISWA+dpXWTOUU29Zg9nA9Jwo7kr
	nqWME9NmISJd8tgB+3AmJalx5S13sHus=
X-Gm-Gg: Acq92OH7XE9RO+qlUOvsPlCg6MTslZU1synmRt860BWg6XVmd2Da7lNYUPkLI8m0Yfb
	ksuduIgwoDiXVcjXn725OxIfi9A0/C0ipqKG+fJTg1CRBwjBRAF/WfD9gS9RCekwibFlGXFUvy5
	eRKl63lfgcjcdUpy4pY1PdwJqNg2CiVfpFpXc5NuVU/Pga0y9ZANoLyDiTOZo7hO3jGGJrjgNt9
	h+/ip4GqQ30Yd8ztc1EAzajgUmMtt+YA4Iibr5Cr8IJTX08oQZBfuCzHUGfsPTSu8+JUo3r2oF1
	QLrS2tthfXvkGBvv++ulMBjMWYQ=
X-Received: by 2002:a05:600c:818c:b0:490:6237:521d with SMTP id
 5b1f17b1804b1-490c25b3ca5mr296981505e9.13.1780946025518; Mon, 08 Jun 2026
 12:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516021138.2759874-1-joannelkoong@gmail.com>
 <20260516021138.2759874-4-joannelkoong@gmail.com> <CAJnrk1bPQczAmaKkGOKAnKBb-FDb1Exmn1r_=HLPkJnKqd3T+w@mail.gmail.com>
In-Reply-To: <CAJnrk1bPQczAmaKkGOKAnKBb-FDb1Exmn1r_=HLPkJnKqd3T+w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 12:13:34 -0700
X-Gm-Features: AVVi8Cd0a2Q5GI2g-h6iKrtTSw_EFc0PI4RXNNwZ67PCmX0jhpiqZ9nMSkMZWP8
Message-ID: <CAJnrk1Ywp2rP-q7y1rmw2qCtAtJT7Un=weZXa15LtNtRSMuf_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: fix moving cancelled entry to
 ent_in_userspace list
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, ali@ddn.com, 
	horst@birthelmer.de, Heechan Kang <gganji11@naver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262105-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,bsbernd.com,ddn.com,birthelmer.de,naver.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:bernd@bsbernd.com,m:ali@ddn.com,m:horst@birthelmer.de,m:gganji11@naver.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,naver.com:email,ddn.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AEBC65A074

On Mon, Jun 8, 2026 at 11:59=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Fri, May 15, 2026 at 7:12=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
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
> > Tested-by: Heechan Kang <gganji11@naver.com>
> > Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration c=
heck")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Jian Huang Li <ali@ddn.com>
> > Co-developed-by: Horst Birthelmer <horst@birthelmer.de>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

I added co-developed-by tags because I wanted to give attribution to
the discussion we had in [1] but checkpatch flags this for not having
signed-off-bys. I'll submit a v3 that changes these to Suggested-by.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/adiiTGjP1tqZfIrI@fedora/

>
> Bernd added his Reviewed-by to this as well [1], but had accidentally
> added it to v1 instead of this v2 series, but this patch is identical
> for both series.
>
> Thanks,
> Joanne
>
> [1] https://lore.kernel.org/all/e55945b3-99a1-40b3-a145-b4867053930e@bsbe=
rnd.com/
>
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
> >         queue =3D ent->queue;
> >         spin_lock(&queue->lock);
> >         if (ent->state =3D=3D FRRS_AVAILABLE) {
> > -               ent->state =3D FRRS_USERSPACE;
> > -               list_move_tail(&ent->list, &queue->ent_in_userspace);
> > +               list_del_init(&ent->list);
> >                 need_cmd_done =3D true;
> >                 ent->cmd =3D NULL;
> >         }
> > @@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *=
cmd,
> >         if (need_cmd_done) {
> >                 /* no queue lock to avoid lock order issues */
> >                 io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
> > +               kfree(ent);
> > +               if (atomic_dec_and_test(&queue->ring->queue_refs))
> > +                       wake_up_all(&queue->ring->stop_waitq);
> >         }
> >  }
> >
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 368f4d0790eb..22ec67e39ee0 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_c=
han *fch)
> >         if (ring =3D=3D NULL)
> >                 return;
> >
> > -       if (atomic_read(&ring->queue_refs) > 0) {
> > -               fuse_uring_abort_end_requests(ring);
> > +       fuse_uring_abort_end_requests(ring);
> > +
> > +       if (atomic_read(&ring->queue_refs) > 0)
> >                 fuse_uring_stop_queues(ring);
> > -       }
> >  }
> >
> >  static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fc=
h)
> > --
> > 2.52.0
> >

