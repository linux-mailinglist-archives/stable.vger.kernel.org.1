Return-Path: <stable+bounces-256569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCt6Ff5aGWoLvwgAu9opvQ
	(envelope-from <stable+bounces-256569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:23:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6115FFDD7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 859F03075C7A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006FF3BCD38;
	Fri, 29 May 2026 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4d5H3qa"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB7326930;
	Fri, 29 May 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046284; cv=none; b=hwXybccTWJMrCs5hVR9myVWtsIyhWQg87OAnijnfz9qJK+mvpI1k5oVl6Ok40hqwF8yMlNZHzdjcNgZdKDrQ7KpPWhNn1psFEc/8M4DWYXkYNMQQhhJefQqdmEiQvMeT+pM2hm4I0roTIzT+zUj1t0IYGYQJkrUDhDnFz1I3PJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046284; c=relaxed/simple;
	bh=UKXf1wPA+hemjuXg7ukP/htrv1MeVbTufACnpt4UqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBTKpPcBB43DqZasR76OuW7y7uul8TeyUO4tZERc0DoVPoDHNycZ0pS7vjCqx2mhhoGhZMq1KpeuJYSOsF/pXgp/vn2HWxhFRu8vFMQAHmSeTbQDmux2Tw8jT20ro4Gyb9H0Im7YhIHB2IQoGRQYPKkCxcZO+ZBBIcjFXy2EFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4d5H3qa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3X+h87zVQbiADPCPME4wwho65wKw5nknhCHOBBKB/ZY=; b=S4d5H3qarX01z/0rutOkGmmtgH
	SmafBLNzWSuRikquCnziG8k6GrnvLHPFhPRuOT3QvQS2TPy297K/UTdkimkO+hxne3sSLUIZTmNAq
	9c/6l3GZ8/JCT+v6HV6Dlub5gF9Em85WhV44v4LajUdu9tII/JQ/jgZI65gHLSM86P5h7L9LcKWv5
	5r2xmaLIMNNV81Rc5+dlEfgCzl2AMuzm/uByCPPZv3+cyzS3wvEIgWb+vsoIbvY1CSCSyKgZSiCAI
	Q/RlCxJFIptG3MUxVHbnkVtyL8t2sdTzIMxejtZ4mGhP0o8T1F4YAvIaLiBOi0i/aCqzCwwhA6pe6
	8G2je/rA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wStLn-00000000t4y-2wo2;
	Fri, 29 May 2026 09:17:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4C5E301CEB; Fri, 29 May 2026 11:17:54 +0200 (CEST)
Date: Fri, 29 May 2026 11:17:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
	venkat88@linux.ibm.com, yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com, kprateek.nayak@amd.com,
	srikar@linux.ibm.com, riteshh@linux.ibm.com, stable@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] sched/topology: Provide arch_llc_mask for cache aware
 scheduling
Message-ID: <20260529091754.GO343181@noisy.programming.kicks-ass.net>
References: <20260529075712.1181039-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529075712.1181039-1-sshegde@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256569-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,kernel.org,csgroup.eu,vger.kernel.org,intel.com,linux.intel.com,amd.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 5B6115FFDD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 01:27:12PM +0530, Shrikanth Hegde wrote:
> Venkat Reported a boot kernel panic next-20260522. Git bisect pointed to
> b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> 
> Stacktrace points to llc_mask being null.
> 
> NIP [c000000000e58504] _find_first_bit+0x44/0x130
> LR [c000000000e58500] _find_first_bit+0x40/0x130
> Call Trace:
> build_sched_domains+0xad8/0xe50
> sched_init_smp+0xa8/0x164
> kernel_init_freeable+0x250/0x370
> ret_from_kernel_user_thread+0x14/0x1c
> 
> On powerpc, cpu_coregroup_mask is available only when the underlying
> hardware support coregroup. In shared LPAR, QEMU guest or power9 etc
> coregroup isn't supported. In such cases llc_mask was being referenced
> when it was null leading to panic.
> 
> On powerpc, LLC is at SMT core level. So assumption that coregroup(MC)
> domain point to LLC is wrong. Provide a way for archs to say where its
> LLC is if it not at MC domain. 
> 
> Based on tip/master at 5c89783224e9 ("Merge branch into tip/master: 'x86/tdx'")
> Cc: stable@vger.kernel.org

This seems unwarranted, the patch breaking stuff is in tip:sched/core.

> Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com/
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com> 
> Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Co-developed-by: Chen, Yu C <yu.c.chen@intel.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks all! I'll stick this in tip:sched/core to go along with the
patches that broke stuff.

