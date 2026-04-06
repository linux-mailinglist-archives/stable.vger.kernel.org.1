Return-Path: <stable+bounces-233461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A5gLTU91Gl4sQcAu9opvQ
	(envelope-from <stable+bounces-233461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:09:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7FD3A80D9
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D63733004CB3
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBBB38F248;
	Mon,  6 Apr 2026 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNOr5jAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED79285CA2;
	Mon,  6 Apr 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516971; cv=none; b=oux0JqThVyRoJcWB4ryC2hNFhwbxiuG+wECVJ1drgHjeBO4sKzw8JYueS/HiXUq9HgJ0eh4z1XsD4/BftLCy2XFKDEasElJnZ1XEXdl8+rFJMVAwSpfY2c+PApenHQmIgx+Bm3RqjbgdBIJDErXhLfxWy+1aParfGXaXzJsH4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516971; c=relaxed/simple;
	bh=FRbTrVhWMnxujlN10Up8FFtNyRTOSZNKIaL9nyCjejM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGa3LIz1oNnodJSJFhP1uTYNzprQy/Cskt5caV8h+xcEkiBjVhI9G6EY+OrTZUJNtv3pm6CxY7hT+thDuoR4EWbAOMYdFLZ+tFUcUCdci0fgYQH52GilkRFZTlCTPETHsC2UTXGoVuQpbYRuBuhF85I/kC7ItNqn98oexdxwUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNOr5jAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3051C4CEF7;
	Mon,  6 Apr 2026 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775516970;
	bh=FRbTrVhWMnxujlN10Up8FFtNyRTOSZNKIaL9nyCjejM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GNOr5jAVIw2SiVAKSAz8B6u5+Iov3lExanL7COUnMipZVZzbj4R0AmXVlTJQVBuK+
	 +v9tulWbtjt+3FeBo9acyMaYM6Q1qlkAo4rOHO5QMiqoT8RjKaBYLcTqxetHEnvaFN
	 V3KJp3yshmpBOky8WXYV+qH0ZsPfvsOaul9nP0RmTzBkGRAk532lszBFBO63ymCZXx
	 nEu3j6EP63oJIqX+tzUPNbEXwhxVvJZ35hkmhy4h36hAzZUbbEHlPbw+JOe5voy64H
	 FnoCLXRDharK7JZOvzsNYkb05Hv00gZgSh5yb3sasmpgUU90zxi04j+JlC79Ak8zNC
	 4I37OVkR0nCCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49AEFCE08F9; Mon,  6 Apr 2026 16:09:30 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:09:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sonam Sanju <sonam.sanju@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmitry Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
Message-ID: <eb96908a-9cd7-4305-b5d5-4296bc59a58e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260323053353.805336-1-sonam.sanju@intel.com>
 <20260323064248.1660757-1-sonam.sanju@intel.com>
 <acwPr_Aic9xd95_R@google.com>
 <2d080c02-9602-4b22-94ce-1f7a71cc19a4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d080c02-9602-4b22-94ce-1f7a71cc19a4@paulmck-laptop>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,joshtriplett.org,redhat.com,bitbyteword.org,chromium.org,vger.kernel.org,goodmis.org,efficios.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD7FD3A80D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:51:11PM -0700, Paul E. McKenney wrote:
> On Tue, Mar 31, 2026 at 11:17:19AM -0700, Sean Christopherson wrote:
> > +srcu folks

[ . . . ]

> > Unless I'm misunderstanding the bug, "fixing" in this in KVM is papering over an
> > underlying flaw.  Essentially, this would be establishing a rule that
> > synchronize_srcu_expedited() can *never* be called while holding a mutex.  That's
> > not viable.
> 
> First, it is OK to invoke synchronize_srcu_expedited() while holding
> a mutex.  Second, the synchronize_srcu_expedited() function's use of
> workqueues is the same as that of synchronize_srcu(), so in an alternate
> universe where it was not OK to invoke synchronize_srcu_expedited() while
> holding a mutex, it would also not be OK to invoke synchronize_srcu()
> while holding that same mutex.  Third, it is also OK to acquire that
> same mutex within a workqueue handler.  Fourth, SRCU and RCU use their
> own workqueue, which no one else should be using (and that prohibition
> most definitely includes the irqfd workers).
> 
> As a result, I do have to ask...  When you say "multiple irqfd workers",
> exactly how many such workers are you running?

Just to be clear, I am guessing that you have the workqueues counterpart
to a fork bomb.  However, if you are using a small finite number of
workqueue handlers, then we need to make adjustments in SRCU, workqueues,
or maybe SRCU's use of workqueues.

So if my fork-bomb guess is incorrect, please let me know.

							Thanx, Paul

> > >   4. The mutex holder never releases the lock -> deadlock

