Return-Path: <stable+bounces-235672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPFKNdp22Wn0pwgAu9opvQ
	(envelope-from <stable+bounces-235672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA43DD280
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0CE1300CCA6
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208D1376496;
	Fri, 10 Apr 2026 22:16:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665C377004;
	Fri, 10 Apr 2026 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859416; cv=none; b=j9mX3z1UuzevFcbBgwDQJVIZ6LY4FZ0OjlDQKIsgU7xvbpMXJxzP8kGSSHYYkdaR6GgaMxwZKMutLJ/tJWm3fPPwu42qKooe1SdQQ1O5mbVwkViGOd+snW3DdUBVlHUAo/peMg9cbSsUdMWUI4hQ7xSYRHwrk/nfxAL52lZ52CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859416; c=relaxed/simple;
	bh=XEBI1Ib2iXNQlGQXkb1exsBs8kcwmR5fdYB0jj/Fgi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uALw9dvONswgZptizU6klLgx/ceFYZgQaeiYabPHiARLOyqPgl+0w5YS0VJlurO35PdA/mekYJAlY9RQ76DOfIzkg+kFF8D9Hr/ELWCkkrVD190EKZ5vJKEDaPG4YyVKYOILT0xCgvvovjFs16m0wL+HOMu17mq04En2CQA8ou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (113-140-067-156.ip-addr.inexio.net [156.67.140.113])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 7C7DDE03D4;
	Sat, 11 Apr 2026 00:08:30 +0200 (CEST)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sat, 11 Apr 2026 00:08:29 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>, 
	stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
Message-ID: <adlyjDaxLZyHcSun@fedora>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com>
 <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235672-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: 51DA43DD280
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> On Fri, Apr 10, 2026 at 4:26 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> Hi Bernd,
> 
> > Hi Joanne,
> >
> > On 4/10/26 01:09, Joanne Koong wrote:
> > > On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> > >>
> > >>
> > >>
> > >> On 10/21/25 23:33, Bernd Schubert wrote:
> > >>> Do not merge yet, the current series has not been tested yet.
> > >>
> > >> I'm glad that that I was hesitating to apply it, the DDN branch had it
> > >> for ages and this patch actually introduced a possible fc->num_waiting
> > >> issue, because fc->uring->queue_refs might go down to 0 though
> > >> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> > >> flush the queues without another addition.
> > >>
> > >
> > > Hi Bernd and Jian,
> > >
> > > For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> > > from fuse_uring_cancel" email was never delivered to my inbox, so I am
> > > just going to write my reply to that patch here instead, hope that's
> > > ok.
> > >
> > > Just to summarize, the race is that during unmount, fuse_abort() ->
> > > fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> > > fuse_uring_entry_teardown() gets run but there may still be sqes that
> > > are being registered, which results in new ents that are created (and
> > > leaked) after the teardown logic has finished and the queues are
> > > stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
> > > never gets scheduled because at the time of teardown, queue->refs is 0
> > > as those sqes have not fully created the ents and grabbed refs yet.
> > > fuse_uring_destruct() runs during unmount, but this doesn't clean up
> > > the created ents because those registered ents got put on the
> > > ent_in_userspace list which fuse_uring_destruct() doesn't go through
> > > to free, resulting in those ents being leaked.
> > >
> > > The root cause of the race is that ents are being registered even when
> > > the queue is already stopped/dead. I think if we at registration time
> > > check the queue state before calling fuse_uring_prepare_cancel(), we
> > > eliminate the race altogether. If we see that the abort path has
> > > already triggered (eg queue->stopped == true), we manually free the
> > > ent and return an error instead of adding it to a list, eg
> > >
> > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > index d88a0c05434a..351c19150aae 100644
> > > --- a/fs/fuse/dev_uring.c
> > > +++ b/fs/fuse/dev_uring.c
> > > @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
> > > int current_qid)
> > >  /*
> > >   * fuse_uring_req_fetch command handling
> > >   */
> > > -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> > > +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> > >                                    struct io_uring_cmd *cmd,
> > >                                    unsigned int issue_flags)
> > >  {
> > > @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> > > fuse_ring_ent *ent,
> > >         struct fuse_conn *fc = ring->fc;
> > >         struct fuse_iqueue *fiq = &fc->iq;
> > >
> > > +       spin_lock(&queue->lock);
> > > +       /* abort teardown path is running or has run */
> > > +       if (queue->stopped) {
> > > +               spin_unlock(&queue->lock);
> > > +               atomic_dec(&ring->queue_refs);
> > > +               kfree(ent);
> > > +               return -ECONNABORTED;
> > > +       }
> > > +       spin_unlock(&queue->lock);
> > > +
> > >         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> > >
> > >         spin_lock(&queue->lock);
> > > @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> > > fuse_ring_ent *ent,
> > >                         wake_up_all(&fc->blocked_waitq);
> > >                 }
> > >         }
> > > +       return 0;
> > >  }
> > >
> > >  /*
> > > @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
> > >         if (IS_ERR(ent))
> > >                 return PTR_ERR(ent);
> > >
> > > -       fuse_uring_do_register(ent, cmd, issue_flags);
> > > -
> > > -       return 0;
> > > +       return fuse_uring_do_register(ent, cmd, issue_flags);
> > >  }
> > >
> > > There's the scenario where the abort path's "queue->stopped = true"
> > > gets set right between when we drop the queue lock and before we call
> > > fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
> > > logic that was called before fuse_uring_do_register() has already
> > > grabbed the ref on ring->queue_refs, which means in the abort path,
> > > the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
> > > to run and clean up / free the entry.
> >
> >
> > I don't think your changes are needed, it should be handled by
> > IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where the
> > initial leak was - these commands came after abort and
> > fuse_uring_cancel() in linux upstream then puts the entries onto the
> > &queue->ent_in_userspace list.
> 
> I think there are still races if we handle it in fuse_uring_cancel()
> that still leak the ent, eg even with the fuse_uring_abort()
> queue_refs gating taken out in the original (jian's) patch:
> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() ->
> kzalloc, sets up the entry but hasn't called
> atomic_inc(&ring->queue_refs) yet
>   concurrently on another thread, thread B: fuse_uring_cancel()
> ->fuse_uring_entry_teardown() ->
> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs down
> to 0
>   At this instant, queue_Refs == 0. fuse_uring_stop_queues() ->
> teardown entries (nothing left) -> checks "if
> atomic_read(&ring->queue_refs) > 0", sees this is false, and skips
> scheduling any async teardown work
>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> queue_refs is now 1, the ent is now placed on the ent_avail_queue, but
> it's never torn down.
>   the ent is leaked and there's also a hang now when we hit
> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queues()
> where it sleeps and is never woken since it's waiting for queue refs
> to drop to 0
> 
> imo, the change proposed in my last message is more robust and handles
> this case since it guarantees the async teardown worker will be
> running (since it does the queue state check after the ent has grabbed
> the queue ref).

Ok so you rely on the fact that fuse_abort_conn() will call 
fuse_uring_abort() and that sets queue->stopped.
This could work, but I would still remove the check for
queue_refs > 0 in fuse_uring_abort(), since it just complicates things
for no real reason.

> 
> btw, there's also another (separate) race, which neither of our
> approaches solve lol. This is the situation where fuse_uring_cancel()
> runs right after we call fuse_uring_prepare_cancel() in
> fuse_uring_do_register() but before we have set the ent state to
> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> though it's canceled, which may lead to use-after-frees. This probably
> requires a separate fix, I haven't had time to look much at it yet.
> Maybe Horst or Jian has looked at this?
> 
Interesting scenario ... haven't seen that one so far.

> > Issue in master is, fuse_uring_stop_queues() might have been run already
> > - entries then get leaked and fuse_uring_destruct() later might give a
> > warning. That part can be reproduced with xfstests, before it starts any
> > of the tests it does some funny start stop actions.
> >
> > Initial *simple* patch was to either add a new list or to just remove
> > the warning and to also handle either that new list or
> > queue->ent_in_userspace list  in fuse_uring_destruct(). The comment
> > explaining why it is needed was much longer than the rest of the patch.
> > The hard part in the long term would be tranfer the knowledge for that
> > requirement.
> 
> I think the initial simple patch doesn't address the hang. When the
> ent is canceled, it still has the ref on queue_refs, which means
> fuse_uring_wait_stopped_queues() will wait for queue_refs == 0
> forever. I don't think we ever even get to fuse_uring_destruct().
> 
> Thanks,
> Joanne
> 
> >
> > You then asked to handle the release directly in fuse_uring_cancel()
> > without another list
> > https://lore.kernel.org/r/CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4-pTewkHQ@mail.gmail.com
> >
> > Yes possible and this is what the next patch version does. However,
> > given fuse_uring_cancel() runs outside of all the fuse locks, it is racy
> > and I therefore asked in the introduction patch not to merge it yet.
> >
> > https://lore.kernel.org/all/20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com/
> >
> >
> > Turns out my suspicion was right ;)
> >
> > Queue references might go to 0 when nothing is in flight and then
> > fuse_uring_abort(), which _might_ race and come a little later, then
> > might not doing anything.
> >
> >         if (atomic_read(&ring->queue_refs) > 0) {
> >                 fuse_uring_abort_end_requests(ring);
> >                 fuse_uring_stop_queues(ring);
> >         }
> >
> > As Horst figure out, removing this check for queue_refs avoids the
> > issue. I'm rather sure that the check was needed during development and
> > avoided some null pointer derefs, as that is what I remember. But I
> > don't think it is needed anymore.
> >
> >
> > Thanks,
> > Bernd
> 

