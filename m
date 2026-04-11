Return-Path: <stable+bounces-235758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH/1F9eO2mll3wgAu9opvQ
	(envelope-from <stable+bounces-235758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:11:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2313E13AE
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 20:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F02F830205E8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50B2FD66D;
	Sat, 11 Apr 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRjUG/hU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA002FB99D
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931085; cv=pass; b=WHscqw8OmDs2YiGOzE+uwJqQ4O2YihDPY2VzHtyy/X1RbCd0Rv6kzY5YK3l+TsT9LbT0z5F2XwwCYorWwnzeVBMZIc0hTHRR+M5eq5S355o78B8/MrHTquSWy1FKE8avHf+aGpljTOIfKzaOTUuoJUBMXPuF1rdcQ1y9jnLw5+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931085; c=relaxed/simple;
	bh=HAGNwk6eHFPNXLeAMHem19pzCjDCbOAo2Tsz0Hx0Xv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ZXKDAYvrx8YPVv5q9zvD4Dn6jX/uaCn0gM8TAnU4fV1w1WTPkesxdr9cmlsufzh7s8Uws2VpgxZpRkV4m3xdiv47H3AFhNctZphp8zvnCALh2ESkPwnGG3d7OD5mEpi1i08vbO1Qc1tZ6dDJiMTuQDFqULdsZfZaySR/srgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRjUG/hU; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3072158f8f.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 11:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775931082; cv=none;
        d=google.com; s=arc-20240605;
        b=deYFNHstAk50RLMBXEEWX8wvkTBql5qJjvhFleuPWbAOo1iPQC5fMczWSdXCAh+XSR
         dSmlFqd6n3rvtdbEfYOVdTcot2TiMA5gbZuuZ069K0QngKvzjJQLjEKwXUDJpyURotfY
         ZRuLwB5hDtpVhDvANPGDmkDCPDHMGZ9jkxxt7OI9HpW+vli+JZxEBQ8JFR8Rg+Bxm6+h
         1nkG9mMK1iB4ZJsFVRYAM61o7g3eDiE3XE45x6ZzqndQZOGTPrBDUR1jf2KWllE8JtsI
         7GjJoqQc6EvxA4H9VhZo6UjEfDAzbXjFbU7bqbnaSAYV92Qa28tcC81zXw3rcllDXpdz
         WJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        fh=3IJhAMLq1+iYHG6QyYCnXF4rAXaoU5N8OhnFQp8Ngqk=;
        b=R06QGkuv9VBFU+iOqQ3xCVkBoX4lXI8bSi4Ogy2Qb6FWKSTiXYiry0LnuCprD19xf2
         9M+WdqxsjA9W2xkfCD3RlpmZBVaFLsFo5DH2FIQqmE1WeDl/7VpRiwQPyM0L6WEBTvzx
         iD4Ir8GbnO/xSut+bsveNsyq5moOze248urlmCE/KAoKn+kNZULrkI0VjysTnPQFhSD5
         KRype8hW+n90sUMT66ZDszbAjYL2Pmh62FxqgC59ogH2X0dMPdIPy78rgewiq5+QoHDP
         +VnPPZ5GqwOlgZ5lE253Get+UeHVB4w3UE2Q3pO42rO6YSfg2zL0F8TFT8xh4q41fc50
         6u2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775931082; x=1776535882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        b=GRjUG/hUSMnnVHaghJg5hkWZuVEobZWejAjLOnsDgaONak1rpOuXpGbBGnICqz7O27
         qAMGEAlh91xNRd1w2CQOrzE+oR66BY8npuv2jkWWKsM3CJ4yvlX99CTrHjxmD3sbLguW
         MKvMO8YBUQBNbdzMNvkhMvePLZeP5qWo4fjjrvyB8VKkJf41n4iu2dJpnIQcGt1VIzP+
         1SvGoEWbANurfcSzASoci+5x4AA+NfUXTyrOL/8o9FwHG3ptCEkMJCT+Y+YHrjmFZ4Ma
         s6nlisYtzURH2WRHqfhiId7U8CeZiT+NAdaPoQLkk4r9/N0eQWDTGZDLpu6TssFhaObt
         TXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775931082; x=1776535882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NcztKu6tkjFwFoPUMiwrM+axM+c0vDxR0aI4xG5+Yxs=;
        b=hTY/AOMi0xM2j3kxUSPkHoggq+1+bwXNZGjYyL02YuoIu04Ce4+bz23EgHgBEG5Y67
         xltThCKqPBED1Uwo/g9pHYkFTQWuiMM/TMssx//8AGX5642tyZ2FbjF+308pK6DQ8z9n
         5soMqYhMiZJwTTDyFCXrv1MUYhYmNbOUIovPkaLB5QpJsD2bjIB13g0NTVKPkCqR+x3h
         Enf4aoRGw67RsMXgnbjGyk19/LNTl6xd00FKH2t5VKRZD5acGTuy5TbJUiU0+NGtVNWM
         T/rq2Bm5ZoDpNL7jLvIuFo0Fywo9MZyUI/gXHDj6pFVoeu1/Qe1fDo5L7z4miNPn2tpx
         Yqgg==
X-Forwarded-Encrypted: i=1; AFNElJ+3WjUjgrCpbGsr+70kYHYqt+oeLywTeHQslue0vEhWd1ts4kF8GG/xYv/WN6Dct4BAcHsz9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO75JKTPwp/ZjRS2Qwb+lBCtRRc6cI2ohRLaWBVVToQy87FkE2
	/uDv412QDCYfxXLUfj4ho0+glh+E2wzd9/DDHYwJVdnx9i/7JyPsMmlk1BaafiSCNelTcXZ0XV7
	9kwDbf/ttACUVa2GbPUU0XbH+XKBIGQQ=
X-Gm-Gg: AeBDieuKOv6FekAcijajk5YDZgjtKB7fl88G0CccdMKebbGWZ7uXH6KabzUGuM5I/cE
	73bjw3oc4y5rgou6vvAYpI3vqTpi6OIR1yon7b8FkmeU8lPb5LUrNosmERnCabTXQMuUjLm6Cc5
	JIjacpQnPKeE59K45//FqoBzqRgPxixgUBk74gGyoPTF9mZJRKiF2T/Z28ALl/EDZDwYF5CAUZz
	IkE3eBv3kAVYV850pJhawglCkqssaqw6l8OVA9PTJbNe+gNrfJz7tiSKubALxeSs3xskqxxjcct
	7l5bZQ==
X-Received: by 2002:a05:6000:2886:b0:43b:7ff5:fdf7 with SMTP id
 ffacd0b85a97d-43d642c8664mr10955212f8f.29.1775931081774; Sat, 11 Apr 2026
 11:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com> <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora>
In-Reply-To: <adlyjDaxLZyHcSun@fedora>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Sat, 11 Apr 2026 11:11:10 -0700
X-Gm-Features: AQROBzBqtLUAi3m0PoX19LqBOySrg-A5_gLcNCQCf44cmRnrw7zewYYalY8UYOc
Message-ID: <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235758-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bsbernd.com:email,birthelmer.de:email]
X-Rspamd-Queue-Id: CE2313E13AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 3:08=E2=80=AFPM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> > >
> > Hi Bernd,
> >
> > > Hi Joanne,
> > >
> > > On 4/10/26 01:09, Joanne Koong wrote:
> > > > On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 10/21/25 23:33, Bernd Schubert wrote:
> > > >>> Do not merge yet, the current series has not been tested yet.
> > > >>
> > > >> I'm glad that that I was hesitating to apply it, the DDN branch ha=
d it
> > > >> for ages and this patch actually introduced a possible fc->num_wai=
ting
> > > >> issue, because fc->uring->queue_refs might go down to 0 though
> > > >> fuse_uring_cancel() and then fuse_uring_abort() would never stop a=
nd
> > > >> flush the queues without another addition.
> > > >>
> > > >
> > > > Hi Bernd and Jian,
> > > >
> > > > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > > > from fuse_uring_cancel" email was never delivered to my inbox, so I=
 am
> > > > just going to write my reply to that patch here instead, hope that'=
s
> > > > ok.
> > > >
> > > > Just to summarize, the race is that during unmount, fuse_abort() ->
> > > > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... -=
>
> > > > fuse_uring_entry_teardown() gets run but there may still be sqes th=
at
> > > > are being registered, which results in new ents that are created (a=
nd
> > > > leaked) after the teardown logic has finished and the queues are
> > > > stopped/dead. The async teardown work (fuse_uring_async_stop_queues=
())
> > > > never gets scheduled because at the time of teardown, queue->refs i=
s 0
> > > > as those sqes have not fully created the ents and grabbed refs yet.
> > > > fuse_uring_destruct() runs during unmount, but this doesn't clean u=
p
> > > > the created ents because those registered ents got put on the
> > > > ent_in_userspace list which fuse_uring_destruct() doesn't go throug=
h
> > > > to free, resulting in those ents being leaked.
> > > >
> > > > The root cause of the race is that ents are being registered even w=
hen
> > > > the queue is already stopped/dead. I think if we at registration ti=
me
> > > > check the queue state before calling fuse_uring_prepare_cancel(), w=
e
> > > > eliminate the race altogether. If we see that the abort path has
> > > > already triggered (eg queue->stopped =3D=3D true), we manually free=
 the
> > > > ent and return an error instead of adding it to a list, eg
> > > >
> > > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > > index d88a0c05434a..351c19150aae 100644
> > > > --- a/fs/fuse/dev_uring.c
> > > > +++ b/fs/fuse/dev_uring.c
> > > > @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *rin=
g,
> > > > int current_qid)
> > > >  /*
> > > >   * fuse_uring_req_fetch command handling
> > > >   */
> > > > -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> > > > +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> > > >                                    struct io_uring_cmd *cmd,
> > > >                                    unsigned int issue_flags)
> > > >  {
> > > > @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> > > > fuse_ring_ent *ent,
> > > >         struct fuse_conn *fc =3D ring->fc;
> > > >         struct fuse_iqueue *fiq =3D &fc->iq;
> > > >
> > > > +       spin_lock(&queue->lock);
> > > > +       /* abort teardown path is running or has run */
> > > > +       if (queue->stopped) {
> > > > +               spin_unlock(&queue->lock);
> > > > +               atomic_dec(&ring->queue_refs);
> > > > +               kfree(ent);
> > > > +               return -ECONNABORTED;
> > > > +       }
> > > > +       spin_unlock(&queue->lock);
> > > > +
> > > >         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> > > >
> > > >         spin_lock(&queue->lock);
> > > > @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> > > > fuse_ring_ent *ent,
> > > >                         wake_up_all(&fc->blocked_waitq);
> > > >                 }
> > > >         }
> > > > +       return 0;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_urin=
g_cmd *cmd,
> > > >         if (IS_ERR(ent))
> > > >                 return PTR_ERR(ent);
> > > >
> > > > -       fuse_uring_do_register(ent, cmd, issue_flags);
> > > > -
> > > > -       return 0;
> > > > +       return fuse_uring_do_register(ent, cmd, issue_flags);
> > > >  }
> > > >
> > > > There's the scenario where the abort path's "queue->stopped =3D tru=
e"
> > > > gets set right between when we drop the queue lock and before we ca=
ll
> > > > fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> > > > logic that was called before fuse_uring_do_register() has already
> > > > grabbed the ref on ring->queue_refs, which means in the abort path,
> > > > the async teardown (fuse_uring_async_stop_queues()) work is guarant=
eed
> > > > to run and clean up / free the entry.
> > >
> > >
> > > I don't think your changes are needed, it should be handled by
> > > IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
> > > initial leak was - these commands came after abort and
> > > fuse_uring_cancel() in linux upstream then puts the entries onto the
> > > &queue->ent_in_userspace list.
> >
> > I think there are still races if we handle it in fuse_uring_cancel()
> > that still leak the ent, eg even with the fuse_uring_abort()
> > queue_refs gating taken out in the original (jian's) patch:
> > * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
> > kzalloc, sets up the entry but hasn't called
> > atomic_inc(&ring->queue_refs) yet
> >   concurrently on another thread, thread B: fuse_uring_cancel()
> > ->fuse_uring_entry_teardown() ->
> > atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
> > to 0
> >   At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() ->
> > teardown entries (nothing left) -> checks "if
> > atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
> > scheduling any async teardown work
> >   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> > queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
> > it's never torn down.
> >   the ent is leaked and there's also a hang now when we hit
> > fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
> > where it sleeps and is never woken since it's waiting for queue refs
> > to drop to 0
> >
> > imo, the change proposed in my last message is more robust and handles
> > this case since it guarantees the async teardown worker will be
> > running (since it does the queue state check after the ent has grabbed
> > the queue ref).
>
> Ok so you rely on the fact that fuse_abort_conn() will call
> fuse_uring_abort() and that sets queue->stopped.
> This could work, but I would still remove the check for
> queue_refs > 0 in fuse_uring_abort(), since it just complicates things
> for no real reason.
>
> >
> > btw, there's also another (separate) race, which neither of our
> > approaches solve lol. This is the situation where fuse_uring_cancel()
> > runs right after we call fuse_uring_prepare_cancel() in
> > fuse_uring_do_register() but before we have set the ent state to
> > FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> > though it's canceled, which may lead to use-after-frees. This probably
> > requires a separate fix, I haven't had time to look much at it yet.
> > Maybe Horst or Jian has looked at this?
> >
> Interesting scenario ... haven't seen that one so far.

Looking at the io-uring code for how cancels are handled
(io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius message
about these two races. io-uring already serializes this for us, the
io-uring code unconditionally grabs the uring lock before invoking
file->f_op->uring_cmd() in the cancel path, which means there's no
interweaving between the fuse registration logic and the cancel logic.

But I still think the more robust/resilient fix for the memleak is to
do the preemptive checking at registration time. I think this fixes
races in the force unmount case between registration and abort that is
unresolved with the original patch. With the original patch w/
fuse_uring_abort()'s queue_refs check removed, I think we can still
hit this:

registration vs abort:
  - thread a: io_uring_enter -> register sqe ->
fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
yet
  - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
fuse_uring_abort() -> fuse_uring_stop_queues() ->
fuse_uring_teardown_entries(), skips scheduling async teardown work
since queue_refs =3D=3D 0, returns
  - thread a: grabs the queue_ref, queue_ref is now 1, rest of
fuse_uring_do_register() logic executes, ent is now marked cancelable,
ent state is now available, ent is placed on available queue
  - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
and does a "wait_event(ring->stop_waitq,
atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the waiter
never gets woken

whereas if we check preemptively at registration time, we explicjtly
free the ent and release the queue_ref. I think the preemptive check
needs to check ring->fc->connected though instead of queue->stopped,
because there's the race where abort and stop_queues() may have been
triggered before the register sqe path does queue creation. I'm hoping
there's a better solution than having to grab the fc lock and checking
fc->connected though, will try to look more at this next week.

I think we can hit this hang on a ring creation vs abort race as well:
* thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not set=
 yet)
* thread b: abort is called, calls fuse_uring_abort(),
fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
* thread a: creates ring, creates queue, creates entry
- if thread a takes the queue_ref count before the rest of the abort
logic, we end up with the same hang as the situation above.

I think for this we'll need to check fc->connected state under the fc
lock before doing the "smp_store_release(&fc->ring, ring);" call, eg
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -243,6 +243,11 @@ static struct fuse_ring *fuse_uring_create(struct
fuse_conn *fc)
        max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZ=
E);

        spin_lock(&fc->lock);
+       if (!fc->connected) {
+               spin_unlock(&fc->lock);
+               goto out_err;
+       }
        if (fc->ring) {
                /* race, another thread created the ring in the meantime */

but this is a separate race from the main one we're talking about on
this thread.

Does all of this align with your analysis and Bernd's analysis of the
situation or am I misanalyzing something here? I'll try to spend more
time next week looking at this.

Thanks,
Joanne

>
> > > Issue in master is, fuse_uring_stop_queues() might have been run alre=
ady
> > > - entries then get leaked and fuse_uring_destruct() later might give =
a
> > > warning. That part can be reproduced with xfstests, before it starts =
any
> > > of the tests it does some funny start stop actions.
> > >
> > > Initial *simple* patch was to either add a new list or to just remove
> > > the warning and to also handle either that new list or
> > > queue->ent_in_userspace list  in fuse_uring_destruct(). The comment
> > > explaining why it is needed was much longer than the rest of the patc=
h.
> > > The hard part in the long term would be tranfer the knowledge for tha=
t
> > > requirement.
> >
> > I think the initial simple patch doesn't address the hang. When the
> > ent is canceled, it still has the ref on queue_refs, which means
> > fuse_uring_wait_stopped_queues() will wait for queue_refs =3D=3D 0
> > forever. I don't think we ever even get to fuse_uring_destruct().
> >
> > Thanks,
> > Joanne
> >
> > >
> > > You then asked to handle the release directly in fuse_uring_cancel()
> > > without another list
> > > https://lore.kernel.org/r/CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4=
-pTewkHQ@mail.gmail.com
> > >
> > > Yes possible and this is what the next patch version does. However,
> > > given fuse_uring_cancel() runs outside of all the fuse locks, it is r=
acy
> > > and I therefore asked in the introduction patch not to merge it yet.
> > >
> > > https://lore.kernel.org/all/20251021-io-uring-fixes-cancel-mem-leak-v=
1-0-26b78b2c973c@ddn.com/
> > >
> > >
> > > Turns out my suspicion was right ;)
> > >
> > > Queue references might go to 0 when nothing is in flight and then
> > > fuse_uring_abort(), which _might_ race and come a little later, then
> > > might not doing anything.
> > >
> > >         if (atomic_read(&ring->queue_refs) > 0) {
> > >                 fuse_uring_abort_end_requests(ring);
> > >                 fuse_uring_stop_queues(ring);
> > >         }
> > >
> > > As Horst figure out, removing this check for queue_refs avoids the
> > > issue. I'm rather sure that the check was needed during development a=
nd
> > > avoided some null pointer derefs, as that is what I remember. But I
> > > don't think it is needed anymore.
> > >
> > >
> > > Thanks,
> > > Bernd
> >

