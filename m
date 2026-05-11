Return-Path: <stable+bounces-245318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDCMOgovAmq/ogEAu9opvQ
	(envelope-from <stable+bounces-245318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 21:33:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4503515278
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 21:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10FD23008D23
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EE421F07;
	Mon, 11 May 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIfstDXi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C5383C60;
	Mon, 11 May 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528005; cv=none; b=GdQgtY+h26uBzMbcSpTPKIzRvAerqJgA3U/C/pDyy2Ih5oFsRVjaBtg/BSagPlSzXpGEbhGcAI5PVwrvheuD4uLdDpztE8LrSB5xr9QAcM7l/Jo6z6ljTZCTlI84hf+EIVC0QkibiXOGQRw+PUKdBZX3ZMKQL72JubRbt4lOxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528005; c=relaxed/simple;
	bh=XNXqcEP8geK7IF7CA02cuvNnQnEvyFsTr2g79+OfuOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm7d2xZ+MoXPn4kRpAWcd90JAA7Rj9Rx657jYWIRJNNRraN3vQ70x4Lzntz1XvmhoAGyxMzwv2AqnFelX8wnSoQZs9OdXFSom3E+QnQvdvhwsK6umHxlFAuKAwncv/iap/gswFdoFREifefuSo4kyggL2MVIIw2/z0vuBh4mosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIfstDXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC10C2BCB0;
	Mon, 11 May 2026 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528005;
	bh=XNXqcEP8geK7IF7CA02cuvNnQnEvyFsTr2g79+OfuOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIfstDXiJUevKsaF+OfUBsXc8fj+zlT1rsvdvFWU15hMS1WHF5YCK6Z89N6DoQNPa
	 QzJj1hVyaHSBUYJp/p01K6Oqw6OC9rlQlN4/6AkjA0+fuPE653PQBu/eLnbHp6Qqy/
	 TAk7wdNXc6j7BbHB4//LEf1JLRbn2X/GlovosEUqMdCm1ZRDvrwMwoaQb+wEcnipNi
	 U0E+2CvlaJKzPoG7JqlvGzJXRbLPcJ0Ia2k2u0DU/Hu8oJCA3JXFqDHfkrosc5LSHE
	 jzboE/zFeH0lmEId0/RMpzwgCmgXlIRLucd3VRrdX1myUn6rLu+ekBwwhO7Q9S/LUF
	 6s/SWdYoeb7bg==
Date: Mon, 11 May 2026 09:33:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <agIvBK4mEXxWYaAY@slm.duckdns.org>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: E4503515278
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245318-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 04:14:37PM +0200, Peter Zijlstra wrote:
> IIRC Steve has a test for this stuff. If this breaks things, an
> alternative is keeping a counter/limit on attempts or something.

Ping. For some reason, we're seeing this reliably now. Whichever way is fine
but it'd be nice to roll out something that's landing upstream.

Thanks.

-- 
tejun

