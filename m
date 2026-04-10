Return-Path: <stable+bounces-235658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGN6GCZJ2WmkoAgAu9opvQ
	(envelope-from <stable+bounces-235658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:01:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A103DBC04
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ED91301BA6A
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A82A2D3EC1;
	Fri, 10 Apr 2026 19:01:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B52336EE1;
	Fri, 10 Apr 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847715; cv=none; b=nPieDhjMKl1hqU7cojehfa1g6dn1tOEQWN/qQPRGr5ItKaiOcXu1QCgQWruqwy96n6ya6dRy+zU9l38oISKYDs9BCOZpUmiRcJn55AwOibkBsVv3T+Cum7KiuK15sZGdWMTfzndOp3w+Jf+dwRPkJizkI1+1xQy57+2DGhjwYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847715; c=relaxed/simple;
	bh=uF/tNSKxFJCiDWNBVZ0HgIRhwm7YuanhgVLGVWK0EGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXIqUdfXigvEhnvZfG5vKDjlx0Z2MKkDX8nCLH07njmYlSvbtCZebPFEs0FN3FPQzvjMosVZyiNNy6QkOtfl/cjOTLEgG4Mg4gPtdX3BjiONUuvlyRixsyZTYTFeMEh3HuJBHAQAWTEumavMDhCBPaOn4JkwouFFA9/nn88oTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (113-140-067-156.ip-addr.inexio.net [156.67.140.113])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 53E07E0731;
	Fri, 10 Apr 2026 20:55:30 +0200 (CEST)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 10 Apr 2026 20:55:29 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>, 
	stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
Message-ID: <adlE6dSPAlMH-ek-@fedora>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora>
 <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235658-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: C8A103DBC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:09:36AM -0700, Joanne Koong wrote:
> On Fri, Apr 10, 2026 at 12:21 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> > > On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> > > >
> > > >
> > > >
> > > > On 10/21/25 23:33, Bernd Schubert wrote:
> > > > > Do not merge yet, the current series has not been tested yet.
> > > >
> > > > I'm glad that that I was hesitating to apply it, the DDN branch had it
> > > > for ages and this patch actually introduced a possible fc->num_waiting
> > > > issue, because fc->uring->queue_refs might go down to 0 though
> > > > fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> > > > flush the queues without another addition.
> > > >
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
> >
> > In my case (Bernd mentioned that I was investigating a hang during umount)
> > there were a lot of requests created during teardown, so what happened
> > was very similar, but for exact the opposite reason.
> > In fuse_uring_abort() queue_refs was already 0 due to an optimization
> > where the ring teardown ran before fuse_abort_conn().
> 
> Hi Horst,
> 
> Just to clarify, is this with running locally patched changes on your
> ddn kernel? In the upstream code I'm seeing that teardown is only
> called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> it's possible for teardown to run before fuse_abort_conn(). Is there
> something I'm missing?

Yes and no ... ;-)
The original patch this whole discussion was started by had a call to
the teardown of the entries and I had that applied.
But even without that the problem can still occur that queue_refs is 0
by the time fuse_abort_conn() is called.

> 
> > Thus the queue->stopped was never set.
> >
> > How do we make sure that fuse_uring_teardown_entries() has not been
> > called by fuse_uring_async_stop_queues()?
> 
> If i'm understanding your question correctly, your question is what
> ensures the teardown logic in fuse_uring_async_stop_queues() hasn't
> already executed by the time we drop the queue lock after checking if
> the queue has been stopped? In fuse_uring_async_stop_queues(), the
> async teardown work gets continuously rescheduled so long as
> queue_refs > 0. The ent holds a reference on the queue, so when the
> queue lock is dropped that async teardown work will be continuously
> running until it cleans up that (and any other) ents.
> 

You understand correctly.
If the fuse_async_stop_queues() runs there is still a window where
we have queue_refs == 0. If in that window fuse_abort_conn() runs
we never actually stop the queues and we can accept requests which
will never be processed.

I have never seen this happen without the patch mentioned above,
but with that 'optimization' it happens regularly when you are able to
kill the fuse server and the application using the file system more or
less at the same time e.g. by an OOM event, when the kernel tries to
free resources.

To me this looks like nothing will stop this from happening, though,
but maybe I'm just not familiar enough with the uring code ...

> >
> > Maybe I'm missing something?
> >
> > My fix was to remove the check for queue_refs > 0 in fuse_uring_abort()
> > and make sure that even if the teardown was complete nothing bad happens
> > in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().
> 
> I'll look more at this path today.
> 
> Thanks,
> Joanne

Thanks,
Horst

