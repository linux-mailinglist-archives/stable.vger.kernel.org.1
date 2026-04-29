Return-Path: <stable+bounces-241824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEKSOzmr8WkAjgEAu9opvQ
	(envelope-from <stable+bounces-241824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:54:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473AF490054
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6ED63037438
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09339C00B;
	Wed, 29 Apr 2026 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9uUbZAs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FA399002;
	Wed, 29 Apr 2026 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445652; cv=none; b=c54qAlTvwky3MAsfFY8QyknTSPKSZ75p4VrvTQoLFr1b/RoWRrIL8QezN+L18bwIftZfHrEyNc6qGB0a3Qa1GZl63DPu3U1gGy2AgBp3hX0WIx7pZwD8EK37VyhIIhIGUlR13m7m5FdVCKFnGc7DiEcvDFyA/UX4Gi1nif3kt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445652; c=relaxed/simple;
	bh=OCH72BvuomwWNneN8sOVciqRkH0HBB40GoDCMKg4IPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN5hxQNy+cZt5V/t+UIKvdLv1Xw/JAs4SYCDdj8e5ZnvqxYenKyheMCoGpFPrgGv6iAn9yB5YNf2MMBIY7CBlc8P6s/tMa3kXoRnMVLFHAJLgJl9bKdZyhYsTlW7DybCyKyFBHIVwpFiZGkqrMPHYo/wNpWYmrZp8905c8uu2q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9uUbZAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746AFC19425;
	Wed, 29 Apr 2026 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777445652;
	bh=OCH72BvuomwWNneN8sOVciqRkH0HBB40GoDCMKg4IPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9uUbZAsbk0tKSSiCWcKiNXssnsNgIK/AQQOfoWZWJBZuTQ3JMH+2VXIXZC7CfHEA
	 gvFwO9Fboz1I8t9CVssS2KM1bmd/JQxyI6ZRkBpAMtnm4OX7UL0bWQ/+t50us201B7
	 UA+joCWlKsuyJuQ5rWETsfFxSOIQLvjMSgEjqZFSiHCP22a2ihBdzIePTcpuYXFu/N
	 AGEbJKllUIWXtHDG1qLyynOIaV5IsUYX+N6MJyptXZzbu/2F0OF6QnWYyByin9OAkw
	 aNdFbBn4By+baXTjrm3oZ2UUu6oiC/5bXWAeD4p16gWXGxfirE3KKMAK03ZPU52r8w
	 7sl5zH+R3u6Kw==
Date: Wed, 29 Apr 2026 08:54:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Soheil Hassas Yeganeh <soheil@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20260429-november-speisen-3084d769d316@brauner>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718085948.3xXGcxeQ@linutronix.de>
X-Rspamd-Queue-Id: 473AF490054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241824-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]

On Fri, Jul 18, 2025 at 10:59:48AM +0200, Nam Cao wrote:
> On Fri, Jul 18, 2025 at 09:38:27AM +0100, Soheil Hassas Yeganeh wrote:
> > On Fri, Jul 18, 2025 at 8:52 AM Nam Cao <namcao@linutronix.de> wrote:
> > >
> > > ep_events_available() checks for available events by looking at ep->rdllist
> > > and ep->ovflist. However, this is done without a lock, therefore the
> > > returned value is not reliable. Because it is possible that both checks on
> > > ep->rdllist and ep->ovflist are false while ep_start_scan() or
> > > ep_done_scan() is being executed on other CPUs, despite events are
> > > available.
> > >
> > > This bug can be observed by:
> > >
> > >   1. Create an eventpoll with at least one ready level-triggered event
> > >
> > >   2. Create multiple threads who do epoll_wait() with zero timeout. The
> > >      threads do not consume the events, therefore all epoll_wait() should
> > >      return at least one event.
> > >
> > > If one thread is executing ep_events_available() while another thread is
> > > executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrongly
> > > return no event for the former thread.
> > 
> > That is the whole point of epoll_wait with a zero timeout. We would want to
> > opportunistically poll without much overhead, which will have more
> > false positives.
> > A caller that calls with a zero timeout should retry later, and will
> > at some point observe the event.
> 
> Is this a documented behavior that users expect? I do not see this in the
> man page.

The selftests rely on this behavior that timeout=0 sees events from a
concurrently running producer. They would fail at a very higher rate
after this change - believe me I had a similar patch that changed
something in this area. I would explore the seqcount that Mateusz
suggested tbh.

