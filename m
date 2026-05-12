Return-Path: <stable+bounces-246459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMWSGFlwA2qI5wEAu9opvQ
	(envelope-from <stable+bounces-246459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B952783C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E8E3252E67
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7994351C25;
	Tue, 12 May 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9cFhHxa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4623E356;
	Tue, 12 May 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609280; cv=none; b=RsY4eblsOggE4XOTebM+bpcCIH7ZCIXzYz1wLbJllr+Tj1zL4xkBf8lPIRPT/LmrrwFNGaJ6mYZOE3YdTRwQvBp+Zzodd2kc/O+CX4iJkH/45M0HTKuhDGSHgZsYyEJ8aoF+pOlaXF5b00A8EM0jP5twnjlxqt7eW6CfYKalg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609280; c=relaxed/simple;
	bh=xksLH94WOYhCPusFolwJbcdsUf8/b4ouZ9SjLYnQQlY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rxjzNRjCz2chwJuDFh9jPDI/9e5XLDQrwNaw/DuQBaH0hjSzQt2tbMewUmUNwFGIlTo/D8JluV/RCo+aPXR4gsD/iZTQtXrV6mlLIPAyFcHfCPSPZdfAduC5OMkTLAVLG6qEBwnUCspEMuyJmm/RHj2Lmqb15A6yHWI+cRaUM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9cFhHxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7A1C2BCB0;
	Tue, 12 May 2026 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609280;
	bh=xksLH94WOYhCPusFolwJbcdsUf8/b4ouZ9SjLYnQQlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N9cFhHxazxgMED//LNrs7wOmhM0hdn2h2vGTDpOTh/gqLvXaTHkcJRXMfJb4I/WLR
	 R5TQjfX80EYjWaSOEFSryx43I0Ap9/KbnqPUftXGYIfgpbLpBUBK+2aUCsRLtm1ZQT
	 4yKT++YHYB8CmAkOFuUwXk5ITwj1GVlRmNO4AxC66YrMv5QBSXHo8Shpcxqf079PSL
	 OWQLGUoCrysvgOljySMu+98LVHtrL9njYyuYm8CyS0VZ6m93fgpq22HXGeWJ0uj5/u
	 Zw4Ps66TRHUYc4ZklFNAXOjuZNj1B/RG+Pz9dPGX6od7k7wymoayAFn3Zbgyc2B8OL
	 VvelslNY+nnrA==
Date: Tue, 12 May 2026 08:07:58 -1000
Message-ID: <056f95bc5805f7e161458984fff4b3cb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
In-Reply-To: <20260512113754.448c1f5b@gandalf.local.home>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E63B952783C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246459-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Looking at 49bef33e4b87 ("sched/rt: Plug rt_mutex_setprio() vs
push_rt_task() race"), the prio bail looks like it was already there
and only got moved up to retry:. For non-migration-disabled next_task
the bail fires at the same effective point both before and after, and
rto_push_irq_work_func() + rto_next_cpu() were already in their
current shape, so the loop seems reachable before the move too -
b6366f048e0c ("sched/rt: Use IPI to trigger RT task push migration
instead of pulling") looks like the actual origin.

Am I reading it wrong?

Thanks.

--
tejun

