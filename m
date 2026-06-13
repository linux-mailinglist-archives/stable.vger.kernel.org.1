Return-Path: <stable+bounces-262985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YB9dHgOqLGpjUwQAu9opvQ
	(envelope-from <stable+bounces-262985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 02:53:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C859E67D5A9
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 02:53:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J51QmfVH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262985-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262985-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA601313DABC
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D69235358;
	Sat, 13 Jun 2026 00:53:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D01917FB;
	Sat, 13 Jun 2026 00:53:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311999; cv=none; b=c/Hlj6xIj9CrG6UANheT9ArWNb2zhUXVChdC76eSigJapdLQx4LJgcjS2Umg6tAGDYOcxW5z8FKayCBe7FUkZ/HkhRX0dkccRnr03I4Fe/JiYf2X+m8/wQV+6LHlkh6acjt9XkYAUqXebhUV9Vyb0orl2//B93ECWos04D0ru/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311999; c=relaxed/simple;
	bh=blMYnaojF0GC/Gm3Ho9sgHT4gawEbGvWRJKdjxTamPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSTyZk8+ywqC2IOqB0OXub2FV7eOtMQ+b51Lw1h6h+bfks9IsllkQw0nvjHb2zDTokjLI2vDZjVEabBFDHgGia/Ztg8LYgnaVgzjmGNrthQq4w3UXEhkIaTEKJtfD+4v7+iuiPn1nylcHPm+BFZPPBzThwtBFvDJiHnnxPH5RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J51QmfVH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352481F000E9;
	Sat, 13 Jun 2026 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781311997;
	bh=nhowGWyw12bvZh9JeBeCLCL7/SYp3UQQwnsR0tQHv60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J51QmfVHX75UM5QrzmUrUsWsKlvTnDo4hcc+W/tyuE5FmH6ZU5is9fRfnwE0sLGiE
	 SFyvVpCbiFQrdwEFi2gflZ5z1XyQT/MZbmBDV/ie+Zb7PsRagrP1RGrvt65XyWLU/I
	 VRq4KHbS9YQSL7tYaaTuZkfgD6qfW/R0npDo+NfCMrBcvydZEzoWGJmKTzGjYiXMEI
	 ISUzCfHzWEf652McBgivQ0Sv2oJDojH+IP97pijy9k+vrlKUPhOVtpiYT1QGsbnGM7
	 sSKyP/nk1SXjbGTjg1O3dvr14EaSAVIawAudOSA+bMo6r+GTIO/56rJLZKBLo4YOHI
	 xEMO9MRE05Okg==
From: SeongJae Park <sj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: SeongJae Park <sj@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Fri, 12 Jun 2026 17:53:09 -0700
Message-ID: <20260613005310.2120-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262985-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:sj@kernel.org,m:catalin.marinas@arm.com,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:oleg@redhat.com,m:cai@lca.pw,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C859E67D5A9

On Fri, 12 Jun 2026 08:16:07 -0700 Breno Leitao <leitao@debian.org> wrote:

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
> Borrow the rcu_lock_break() pattern from kernel/hung_task.c: when a
> reschedule is needed, pin the two iteration cursors, drop the RCU read
> lock, cond_resched(), then re-acquire it and continue only if both
> cursors are still hashed.
> 
> If a cursor was unhashed while the lock was dropped, the thread list
> cannot be walked further, so the round is aborted. Such a round scans
> only part of the task stacks, which would make live objects look
> unreferenced, so reuse the existing "scan interrupted" path to skip
> reporting; the next full scan reports the real leaks.
> 
> Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thank you for fixing this, Breno.  Nothing stood out to me while reading the
patch, other than the below tiny and trivial nit.  Regardless of that, please
feel free to add

Reviewed-by: SeongJae Park <sj@kernel.org>

[...]
> @@ -1890,11 +1917,21 @@ static void kmemleak_scan(void)
>  		rcu_read_lock();
>  		for_each_process_thread(g, p) {
>  			void *stack = try_get_task_stack(p);
> +
>  			if (stack) {
>  				scan_block(stack, stack + THREAD_SIZE, NULL);
>  				put_task_stack(p);
>  			}
> +			/*
> +			 * This is an expensive loop, we must to call the
> +			 * scheduler to avoid lockups

s/must to call/must call/ ?

I saw Lance also provided a suggestion for making this comment better.  I think
that's also good and maybe even better than my suggestion. :)


Thanks,
SJ

[...]

