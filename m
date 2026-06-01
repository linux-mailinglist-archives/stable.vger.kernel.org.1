Return-Path: <stable+bounces-259456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK07LtYtHWo4WAkAu9opvQ
	(envelope-from <stable+bounces-259456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 08:59:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA761A869
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 08:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F1EF3009887
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E40380FE2;
	Mon,  1 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zORcKruJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FcOzPlV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01402347BBD;
	Mon,  1 Jun 2026 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297097; cv=none; b=lJTQXp2TCx+lN4oIOycMjm9pYk56oJKpfAolGPlN/KyowTjUqeG7cYg8+r7+IY4ugrvpA7czS4Q4ZnY2b6fFDPP4UhW7BzvNm+8DCFqqiczAKhyLJ5NUhkYhaus5yEjFE3xtmYCHef8hFg9/uhiO3RsLpq/PsDa7szCL5MXXONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297097; c=relaxed/simple;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8eGHmq90KuXCMkVCPnC91orW5yYk59xMWW9Rr/kCDeX9RacMUe/Co1j+uScU1ja/FTJgzIrVmjzMIpepIK6GNuVUdlZixrOP5juEBSxOloGK66Uqinn1y9oNHChXuALaHQzrvmYlzRJzVEC2ck6w6fWGC1UHp5b3b+TNToDcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zORcKruJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FcOzPlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 1 Jun 2026 08:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780297094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	b=zORcKruJ9QJOtW4JL1Pm23rr8Nn7859O839uqpFCiRaLhnVpt3vH5A45v3oD0GwU5zEKFp
	5KoiJpX7ERkDuyC63RVc863tn+FhxNrbtSYDFuc9XRyXQKe098LP/duwnZ6B+DMlsG+va6
	gBMoGhERg8d+Qryv1wRUdCzFR/nyy6IWl7NJxOE3QEiINHdZOIDw93MtX4O/A0Tg2Zl+Ot
	VMBejWMXFzpGnedfK2hJIGqYdCc5QQYg+xqIBqUXRnN3N8J2NkblzOca2Dhpg2ox4QKjDM
	vZpyeqt2EeCZ++90Cu00ZypywIJUdXYBZVkgN7cYdaIuJqTu3S3KeSTLp8qWZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780297094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJy0CmnIxJjAFp2xvW0lH2ZU1wwcYRyC/5qf0dtOaLU=;
	b=0FcOzPlVIato7qS/odBjpYZVeForAreWqj7U1P+j8gvuU5FR/47koS4F5+qJ3QtgejkaMS
	lLIMMvRIEAawgHAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Hannes Reinecke <hare@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 09/10] mptcp: pm: avoid sleeping while holding
 rcu_read_lock
Message-ID: <20260601065813.Z8V8Tb6d@linutronix.de>
References: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-0-a5ae7791754b@kernel.org>
 <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-9-a5ae7791754b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601-net-mptcp-misc-fixes-7-1-rc7-v1-9-a5ae7791754b@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259456-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 95EA761A869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-06-01 13:10:05 [+1000], Matthieu Baerts (NGI0) wrote:
> sk_stop_timer_sync() calls del_timer_sync(), which spin-waits for the
There is no del_timer_sync()

> timer callback to complete on non-RT kernels. But on PREEMPT_RT, it can
> sleep. Sleeping inside an RCU read-side critical section might trigger a
> lockdep splat.

It can not sleep. timer_delete_sync() does not sleep. It can block on
spinlock_t and schedule but this is okay within a RCU read section.

Do you have a report for this?

Sebastian

