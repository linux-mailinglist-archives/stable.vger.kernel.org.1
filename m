Return-Path: <stable+bounces-230398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id texbACSAxGkazwQAu9opvQ
	(envelope-from <stable+bounces-230398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:39:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747632DAB1
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68DC5302C6F2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D802D8DD6;
	Thu, 26 Mar 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh8YUanE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18253224B05;
	Thu, 26 Mar 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774485533; cv=none; b=NhITlZsrBQJ0HIhAUu2LjECTZ1rPGIsAkiT/96X9aT5baUWAaq5VH/h2LcTyyw57K6bc3NRRrSiVuQ/xFTT4AqSNHU433/XQF/HLgkxcTSKBJbr1zbkSwsilksEcluIonPqq9euEk68zoGbtep44eJMz2rsbrrk6+ws++oYR3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774485533; c=relaxed/simple;
	bh=FFUCjB4kqdoVSzQIVahoi0U9tLwThKz0ltut+AgLlCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7DFZQKZsfyLMmlNJ4zSgZsThRpjHHv7ml0xaxQ0xsZ9phM33sq33PiCkCW40dGwXVql7uRCINLfWGjrZdUocw40bhIlNWYyKgTcFdq4BOH4a0wGGllwjpdWkW1i+vBSKHmvOOopkt7gMYqd/5ccNFBUNuDGWBx0GOFT99+baFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh8YUanE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3133C4CEF7;
	Thu, 26 Mar 2026 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774485532;
	bh=FFUCjB4kqdoVSzQIVahoi0U9tLwThKz0ltut+AgLlCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bh8YUanEvEHCeFdyPxQTDjAlpfJiy8k8klzB6eh1WQhmo0J6+5zqrcdTU3+O/z7O6
	 7TDzgDCXWE2xsdhjLPpVJLEfrb0y3nj4xoTuf/HMS5TfXpUbTQ8hqYqRvnbhyaOvvW
	 8fqyMtbWm5vpOPSSJyMgnbGSBsDKIWEsJx6KVWipLW2ciGnFAiX7+i0t5uI8eHOELV
	 9XrgwL0x2sbo16h5+c1rmYhk2Ar1hK36hKgm6b1OmRQQA++BhrcsNKT7SNpFVUahPp
	 rd+N+97jetE6mn5cY1uyqYFkKnSCDPVfSrcFFRDh31hvSS8yBF3GeGS2457HzIHX+l
	 xPr6YhIRr6T6A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Josh Law <objecting@objecting.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: (sashiko review) [PATCH v2] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 17:38:44 -0700
Message-ID: <20260326003845.77426-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326001051.76219-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230398-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: 3747632DAB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 17:10:50 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260325155221.202700-1-objecting@objecting.org
> # start of sashiko.dev inline review
> commit 24e25058b8f508495d0b3db33bed16564df7fed4
> Author: Josh Law <objecting@objecting.org>
> Subject: mm/damon/core: validate goal nid before accessing node data
> 
> This patch adds bounds and node_state(N_MEMORY) checks before using
> goal->nid from userspace to prevent out-of-bounds access in NODE_DATA().
> 
> Cc: stable@vger.kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..ed45a7443abe 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2245,6 +2245,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
> >  	struct sysinfo i;
> >  	__kernel_ulong_t numerator;
> >  
> > +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> > +	    !node_state(goal->nid, N_MEMORY))
> > +		return 0;
> > +
> 
> When goal->nid is invalid or offline, this unconditionally returns 0.
> For the DAMOS_QUOTA_NODE_MEM_FREE_BP metric, wouldn't returning 0 imply
> 0% free memory?
> 
> Could this cause the DAMON feedback loop to interpret the goal as
> severely under-achieved and drastically increase the scheme's
> aggressiveness?
> 
> Should this fallback logic check the metric type and return 10000
> (100% free) for FREE_BP metrics to fail gracefully, mirroring the
> existing fallback logic used when a memory cgroup lookup fails?

I am also thinking similar to sashiko.  Could you please make the change?

> 
> >  	si_meminfo_node(&i, goal->nid);
> >  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> >  		numerator = i.totalram - i.freeram;
> >  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> >  		numerator = i.freeram;
> >  	return mult_frac(numerator, 10000, i.totalram);
> 
> While not introduced by this patch, since this function is being
> modified to handle node edge cases, is it possible for a node to have
> N_MEMORY set, but have 0 managed pages? For example, if all of its
> memory is reserved for hugetlb or unmanaged ZONE_DEVICE memory.

I'm not very sure if this is really possible.  Josh, do you know?

> 
> If so, si_meminfo_node() would set i.totalram to 0. Would the call
> to mult_frac() then cause a divide-by-zero panic when it evaluates
> x_ / d_ ?

If sashiko's theory is true, I think we should add a zero value check here?

> 
> > @@ -2261,6 +2265,10 @@ static unsigned long damos_get_node_memcg_used_bp(
> >  	unsigned long used_pages, numerator;
> >  	struct sysinfo i;
> >  
> > +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> > +	    !node_state(goal->nid, N_MEMORY))
> > +		return 0;
> > +
> 
> Similar to the function above, returning 0 unconditionally here for
> DAMOS_QUOTA_NODE_MEMCG_FREE_BP might artificially trigger maximum
> reclaim aggressiveness.

Similar to my above comment, I agree to sashiko.


Thanks,
SJ

[...]

