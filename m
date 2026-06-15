Return-Path: <stable+bounces-263430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onjUJG5DMGovQgUAu9opvQ
	(envelope-from <stable+bounces-263430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C4689244
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=CPVHHc+t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263430-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263430-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5F8307B134
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087631327A;
	Mon, 15 Jun 2026 18:24:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01F2BE035;
	Mon, 15 Jun 2026 18:24:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547882; cv=none; b=IX9elHoKrNn4vvgJnEf08kfZJkfBVc1zzAt32qhEL5mKwk/cXXlBMoNTtJ6BJxwUwY0cZaeHLiZWQUpI4/VT+7Htem6RriDLf792TTeIxzKqVH5kOj/eSeGMhllatGLKlcl1ZTQAau9rqbqwfxHdH7R8HPzv6uWdMOrl0EyDNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547882; c=relaxed/simple;
	bh=GqX3nmQdXJ2BcQPGs+V8jhTLhqBB4Y8nmM3AxKEgoUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d20p2ln/r6LerZHFSLSQGnv7gYGbz2BkXw+y5eT3CkQkwWRMrgU7Of5eIR0uPWxG71oEtOpg2OR6b40Y06TWMqW/oG+DOsRymdAjEE6GbH47FgkRZ7njyviy15htghp4lCyn2+w5gbl3ki8gyhIddlFam0pFwuCp+OZIXdG6TWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CPVHHc+t; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B4E1764;
	Mon, 15 Jun 2026 11:24:33 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000D23F905;
	Mon, 15 Jun 2026 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781547878; bh=GqX3nmQdXJ2BcQPGs+V8jhTLhqBB4Y8nmM3AxKEgoUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPVHHc+tZ1mRngLyGm29F29IxKxlBGJzBEojWtBVBMikG6AsYyU0pSU+sUQf78uVh
	 qINYo0b8R1cx+8sQrTRZ092xSngkbDQtGrNjYbCyI4V0bH3Y3uo0DSNVCmJFmdC8FJ
	 NN0gNIeRxA4moyAMnRUoKzopB7e2MXSN+4m8q+6k=
Date: Mon, 15 Jun 2026 19:24:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
	sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ajBDWkeIbBXjhCjP@arm.com>
References: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
 <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-263430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:oleg@redhat.com,m:cai@lca.pw,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB0C4689244

On Mon, Jun 15, 2026 at 10:49:06AM -0700, Breno Leitao wrote:
> kmemleak_scan() walks every thread and scans its kernel stack under a
> single rcu_read_lock() with no reschedule point. On a host with very
> many threads -- amplified by KASAN/lockdep in debug builds -- this loop
> can hog a CPU long enough to trip the soft lockup watchdog:
> 
>   watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>    scan_block
>    kmemleak_scan
>    kmemleak_scan_thread
>    kthread
> 
> A cond_resched() cannot be added directly: the loop runs inside an RCU
> read-side critical section.
> 
> Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
> lock only to look up and pin each task. The stack is then scanned with no
> lock held, so cond_resched() runs between tasks and the scan stops early
> on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
> iteration pattern and keeps each RCU critical section short.
> 
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

I think the Fixes is just a marker to tell how far back to go. Before
the above commit, we used a read_lock(&tasklist_lock) which probably had
similar issues.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin

