Return-Path: <stable+bounces-254214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKcNO6S6FGoiPwcAu9opvQ
	(envelope-from <stable+bounces-254214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:09:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D535CECE1
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32BFF3014285
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCD31A56D;
	Mon, 25 May 2026 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FLFxxuGX"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCDE19D8A8
	for <stable@vger.kernel.org>; Mon, 25 May 2026 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743392; cv=none; b=WYwhefQOq7DNDcxOvCWQIkYKXO+LldbQoS8rHgpNqpiAWjSYyB2810PtfbzkvVIa2izdkLjdtWG0jc6oQPcE5g8Tzgbukfd/0lW63Thzc3rn3+H64UnGOHTky6HkGj5k3JB3Ufrk8fa7hie4Z3vIEMTCQsBtnT+5YwN1bIKCwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743392; c=relaxed/simple;
	bh=+cNOAp2028JXp6edK92run+tWtoHNfBFzInSepj/RX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8KGSoeo84g9lIytP9732r3BjycVM1WM35UbeRDXgLQTm97j237WJrWX6kJD04VNH/1BVoWGS0FjWCXTcwyBOCPWho0wse2/QXA7mn6tY82wZsDxfKj7S+2vlRZUVuDYcMbLW7II4tInwZI16Az0TElmtT6ZwSyhtvHQ/dGiLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FLFxxuGX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gPT6L6l6Mz9tpW;
	Mon, 25 May 2026 23:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779743387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MJb6/CP5vqre61pVwaQFM6mT5LkgE0KcEkYykb14Ss=;
	b=FLFxxuGXsxlH0woWLrqSuCwdQ7cLsESWrtfP/5/41qNG/fgT5A03tefsVsN16qOHlKMtUS
	bUtFlpWYvCayqqXuL4ZmvraP30H0RZRihZKUlUtzn6MxJ1r+aWMnKZzlcDz2/GVYD/fX15
	QqEw2HhPkSYyY46WqJzgErLo4YXa7djdoBru71ngy8BYcwWF2uOkYvBW6wJS08TON0w0kp
	12qAsO5c2dpKzTj9x3VE5/Vz/bXg/qDZbi8aSoT2FnPSIXPi+TI5WYxB26DG/LF1lU5hKC
	MobvjEddZRW5EfOS18Ls2IIuKKcJ7fXq22/Y5g4InXbhO8gtva/TEi74tQMg+Q==
Date: Mon, 25 May 2026 23:09:38 +0200
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 6.12.y 0/3] backport missing dependencies of d66792919d4f
Message-ID: <ahS6ksSyBL6HimBh@lukas-arch>
References: <20260522213120.1205100-1-lbckmnn@mailbox.org>
 <20260524-stable-item004-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-stable-item004-reply@kernel.org>
X-MBO-RS-META: iom4retsz3t7hpo4bcxysstc18nbpcc9
X-MBO-RS-ID: d512d0f8e072fd5317e
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim]
X-Rspamd-Queue-Id: 42D535CECE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 08:09:19AM -0400, Sasha Levin wrote:
> > Commit d66792919d4f ("sched/deadline: Use revised wakeup rule for
> > dl_server") in the 6.12.y stable tree (upstream commit 14a857056466)
> > depends on three upstream commits that were not backported:
> >
> >   commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
> >   commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> >   commit a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")
> 
> Thanks for tracking this down. Before I queue this, the series is
> missing two more follow-up fixes that both carry "Fixes: cccb45d7c429"
> and that are needed for the dl_server logic to behave correctly:
> 
>   4717432dfd99 ("sched/deadline: Fix dl_server_stopped()")
>   bb4700adc3ab ("sched/deadline: Always stop dl-server before changing parameters")
> 
> Without 4717432dfd99 the dl_server_stopped() check is inverted (it
> returns the wrong polarity after cccb45d7c429), and without
> bb4700adc3ab the per-rq running_bw accounting can get out of sync when
> dl-server parameters change while it is still active.

I did notice 4717432dfd99 while preparing v1, since it caused the
conflicts in a3a70caf7906. However, since 4ae8d9aa9f9d ("sched/deadline:
Fix dl_server getting stuck") removes dl_server_stopped() entirely, the
end result is the same whether 4717432dfd99 is included or not.

That said, including it is probably better :)

> 
> Could you send a v2 that includes both follow-ups on top of the
> existing three? Then this should be safe to apply as a whole.

Yes, I will do that.

Thanks
Lukas

