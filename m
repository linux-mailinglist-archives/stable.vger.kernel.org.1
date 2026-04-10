Return-Path: <stable+bounces-235577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ6dMHWm2GkhgggAu9opvQ
	(envelope-from <stable+bounces-235577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:27:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9E3D3517
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8F1300AB2F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54C3A0EA5;
	Fri, 10 Apr 2026 07:26:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8233F58B;
	Fri, 10 Apr 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806015; cv=none; b=VSfzRlF3RfnWBajh5UzuIwaT4utaA7t5/0B6uHELVED/SGTOwNs9kiLXA0w3QuDW3/ER3W5yswyfLOCwqUfqS4L6hrnXxbkcRCUd1qHXP0iAoq442SzWhnYNjCD2Lt+Ed5DgnRNjN9vbQL0kP5LBh48GDu6n3+UsPoL8DHN7ZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806015; c=relaxed/simple;
	bh=2Dtxv5HRuf3kRhF7oX3tyEpHrEZRTULYNcLMcJ/AUu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezILzWDensxhK57wWap/0C4x3BOm7PG0UaA7D6pRYfKS0g9tIjTUhUGgXdyYuV8LCuVEc7GPTALRINQFPAWdffdIYa7nsqlT0Phh5/EwsRVLDlyZpjuEhE8/8FFLkcG5Jb8oLBSrRg1sRzbDuY8tQM5CkPVxUDkDXa9rQPzucaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (113-140-067-156.ip-addr.inexio.net [156.67.140.113])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id E5283E04F1;
	Fri, 10 Apr 2026 09:21:17 +0200 (CEST)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 10 Apr 2026 09:21:17 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, Jian Huang Li <ali@ddn.com>, 
	stable@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with
 immediate teardown
Message-ID: <adiiTGjP1tqZfIrI@fedora>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
 <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235577-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: 45B9E3D3517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> On Thu, Apr 9, 2026 at 4:02 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> >
> >
> > On 10/21/25 23:33, Bernd Schubert wrote:
> > > Do not merge yet, the current series has not been tested yet.
> >
> > I'm glad that that I was hesitating to apply it, the DDN branch had it
> > for ages and this patch actually introduced a possible fc->num_waiting
> > issue, because fc->uring->queue_refs might go down to 0 though
> > fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> > flush the queues without another addition.
> >
> 
> Hi Bernd and Jian,
> 
> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> from fuse_uring_cancel" email was never delivered to my inbox, so I am
> just going to write my reply to that patch here instead, hope that's
> ok.
> 
> Just to summarize, the race is that during unmount, fuse_abort() ->
> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> fuse_uring_entry_teardown() gets run but there may still be sqes that
> are being registered, which results in new ents that are created (and
> leaked) after the teardown logic has finished and the queues are
> stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
> never gets scheduled because at the time of teardown, queue->refs is 0
> as those sqes have not fully created the ents and grabbed refs yet.
> fuse_uring_destruct() runs during unmount, but this doesn't clean up
> the created ents because those registered ents got put on the
> ent_in_userspace list which fuse_uring_destruct() doesn't go through
> to free, resulting in those ents being leaked.
> 
> The root cause of the race is that ents are being registered even when
> the queue is already stopped/dead. I think if we at registration time
> check the queue state before calling fuse_uring_prepare_cancel(), we
> eliminate the race altogether. If we see that the abort path has
> already triggered (eg queue->stopped == true), we manually free the
> ent and return an error instead of adding it to a list, eg

In my case (Bernd mentioned that I was investigating a hang during umount)
there were a lot of requests created during teardown, so what happened
was very similar, but for exact the opposite reason.
In fuse_uring_abort() queue_refs was already 0 due to an optimization
where the ring teardown ran before fuse_abort_conn(). 
Thus the queue->stopped was never set.

How do we make sure that fuse_uring_teardown_entries() has not been
called by fuse_uring_async_stop_queues()?

Maybe I'm missing something?

My fix was to remove the check for queue_refs > 0 in fuse_uring_abort()
and make sure that even if the teardown was complete nothing bad happens
in fuse_uring_abort_end_requests() and fuse_uring_stop_queues().

Thanks,
Horst


