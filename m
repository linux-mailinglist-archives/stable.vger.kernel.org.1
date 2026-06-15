Return-Path: <stable+bounces-263177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SCyZAP3eL2r3IAUAu9opvQ
	(envelope-from <stable+bounces-263177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:16:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C0685A42
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 13:16:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=cdY4lVPE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263177-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263177-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D266A302BE00
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9C383C92;
	Mon, 15 Jun 2026 11:16:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452F340A4D;
	Mon, 15 Jun 2026 11:16:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522166; cv=none; b=pY0jvc+DpcYY+xDu0KwCajyeNYVHy8Nc3gKUZ/LykfPf2faz/Z3G7N+kx6YN073ByhqxbjyBLWWJ4XF2YPCC2VM8/uIbwpgzjAJ6tHnqverfv2TxGfPfMULc9A3lfD92X0OJmmTE7wnwmJF3d10haUXQCgyfzrc7p1ttrpf+nv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522166; c=relaxed/simple;
	bh=Gy0LHTdLmlPA2i+iN2Je30fdWIJBmw4l6fKDIDT15Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba/30AdFAiV72pduls/pmNoF3BolEeThvijThXerg4Lh2XY9ViGkdED0PgcHVAaHmugns1w+aM2qtrT1kjrDqWosLHOUeANC5QTHN1fAr+TZa2UAYZd41Wbq+r1hlbT4bxR8UPCsWGolgrr+H/OQWhuvctK2wAdoR7bouKWGRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cdY4lVPE; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7194328D;
	Mon, 15 Jun 2026 04:15:59 -0700 (PDT)
Received: from arm.com (RQ4T19M611-7.cambridge.arm.com [10.1.32.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E643F915;
	Mon, 15 Jun 2026 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781522164; bh=Gy0LHTdLmlPA2i+iN2Je30fdWIJBmw4l6fKDIDT15Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdY4lVPEYrNPl4E1WB89Pyctf4ei4UjwuF0x5VaUZ/uHD8RP//KUfcDlDlXD/ZTMz
	 4jsOCEDRAult1wHuB6kgB9dPNw4l/aXf3iKX5DOr7uzAVhOh5XiMoI801LGS3cOdFY
	 iYUnfiVA+rR0pNdM9dXCMb8naE0yjNA7UicT2d5I=
Date: Mon, 15 Jun 2026 12:15:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev,
	Davidlohr Bueso <dave@stgolabs.net>,
	Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ai_e7gfv5vze5tB5@arm.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
 <aiw9u4BllwZXDH2S@arm.com>
 <ai_EVJVfe42glgKI@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_EVJVfe42glgKI@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-263177-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:akpm@linux-foundation.org,m:lance.yang@linux.dev,m:dave@stgolabs.net,m:oleg@redhat.com,m:cai@lca.pw,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D98C0685A42

Hi Breno,

On Mon, Jun 15, 2026 at 02:27:13AM -0700, Breno Leitao wrote:
> On Fri, Jun 12, 2026 at 06:11:40PM +0100, Catalin Marinas wrote:
> > 	if (kmemleak_stack_scan) {
> > 		struct pid *pid;
> > 		int nr = 1;
> > 
> > 		do {
> > 			struct task_struct *p = NULL;
> > 
> > 			rcu_read_lock();
> > 			pid = find_ge_pid(nr, &init_pid_ns);
> > 			if (pid) {
> > 				nr = pid_nr(pid) + 1;
> > 				p = pid_task(pid, PIDTYPE_PID);
> > 				if (p)
> > 					get_task_struct(p);
> > 			}
> > 			rcu_read_unlock();
> > 
> > 			if (p) {
> > 				void *stack = try_get_task_stack(p);
> > 
> > 				if (stack) {
> > 					scan_block(stack, stack + THREAD_SIZE,
> > 							NULL);
> > 					put_task_stack(p);
> > 				}
> > 				put_task_struct(p);
> > 			}
> 
> Should we add a scan_should_stop() check here to allow early
> termination?

Ah, yes, I think we should, maybe as 'while (pid && !scan_should_stop())'.

scan_block() already bails out early but it will still go quickly
through all the stacks which we don't need. As a later clean-up, I
wonder whether we should change scan_block() to return non-zero and use
that.

-- 
Catalin

