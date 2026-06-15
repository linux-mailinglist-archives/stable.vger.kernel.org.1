Return-Path: <stable+bounces-263433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L4n4OApLMGrjQwUAu9opvQ
	(envelope-from <stable+bounces-263433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:57:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41B68953C
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:57:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=stgolabs.net header.s=dreamhost header.b=h5zVgg5+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263433-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263433-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D0703067758
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68B3AD501;
	Mon, 15 Jun 2026 18:56:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FF312814;
	Mon, 15 Jun 2026 18:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549806; cv=none; b=Fs/MsnAizhIAtPT6UscGhWRPKSTAQ36ARVjiaMlitSfpEvMnzgIdyptf/pBNyoOrtO+zSoS4f+XFMB/NSNfYvCXaxbB2nAiG5R+OtIoUYB1lWy+qxfG4KjSIAJE/TGagBNSQ+4EZGNnp6OWCzCud0szCjFzyCNnRmr74UQIlxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549806; c=relaxed/simple;
	bh=0+yV9+OEAzkyCRU0bfrqAlQuJ+tnl0nRv3mz1HJIBpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ZBxDemlQc2kXjEgR7ZnJT26fVfa7ghPWP9pi1iUUWQpDZVB8Z+mYza61SvZwhmMiYqXRtYO+2peTQv7DHTIW6OqppVnn2Mh27LxdcVnm4Kcl5bvVs1lgOYUxB+f515ullNgbscZrA19tXwocB9hNtjuiN7QSqZCCw9SEbLtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=h5zVgg5+; arc=none smtp.client-ip=23.83.212.17
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0A7BF8C0E98;
	Mon, 15 Jun 2026 18:46:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.96.13.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 277928C0055;
	Mon, 15 Jun 2026 18:46:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Cooperative: 79e29464737e996a_1781549200868_3726778055
X-MC-Loop-Signature: 1781549200868:2144093325
X-MC-Ingress-Time: 1781549200866
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.13.226 (trex/7.1.5);
	Mon, 15 Jun 2026 18:46:40 +0000
Received: from offworld (unknown [179.57.115.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4gfJxR0zWfz1k5;
	Mon, 15 Jun 2026 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781549199;
	bh=nN55lehzz+w0yHRGnkVVeGnjB1aJFWW1xqDvT5yfQok=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=h5zVgg5+fJ46Y7qOwB2mz+n9EPQL8yskxm+zf4HZYaY+wX+h/KLMqLxeGsyIpn7Q2
	 KR2tF24YP8EbOxD7dk7AGFsIevPoYBlkl2UfsVQXAk2jDkZJknpIebYFsE7cQQ3R8m
	 f+sox8QGLf095mymW5vKo3p9xs+prDhxK9ctxAL3H11gJYYWuMIScyQVwmgADH7569
	 H99BK0UPDZbstZYApEwi3CfVSAGQoqK3fFJcOO9OdSjW7cg1OurZ1nmjufoa6hIGBJ
	 9bVepJVRS06/1dltq0fwVDJBHgxclSU2rIFMDeUoRKKPPQmvy18GX5FK5YwKq5KRgU
	 OIH1ZyyaWF39g==
Date: Mon, 15 Jun 2026 11:46:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
	sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <20260615184620.jakmruj7czdkawk3@offworld>
References: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
 <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
User-Agent: NeoMutt/20220429
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[stgolabs.net:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263433-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[stgolabs.net];
	FORGED_SENDER(0.00)[dave@stgolabs.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:catalin.marinas@arm.com,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:oleg@redhat.com,m:cai@lca.pw,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[stgolabs.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,stgolabs.net:dkim,stgolabs.net:email,stgolabs.net:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave@stgolabs.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B41B68953C

On Mon, 15 Jun 2026, Breno Leitao wrote:

>kmemleak_scan() walks every thread and scans its kernel stack under a
>single rcu_read_lock() with no reschedule point. On a host with very
>many threads -- amplified by KASAN/lockdep in debug builds -- this loop
>can hog a CPU long enough to trip the soft lockup watchdog:
>
>  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>   scan_block
>   kmemleak_scan
>   kmemleak_scan_thread
>   kthread
>
>A cond_resched() cannot be added directly: the loop runs inside an RCU
>read-side critical section.
>
>Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
>lock only to look up and pin each task. The stack is then scanned with no
>lock held, so cond_resched() runs between tasks and the scan stops early
>on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
>iteration pattern and keeps each RCU critical section short.
>
>Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
>Cc: stable@vger.kernel.org
>Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

