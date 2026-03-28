Return-Path: <stable+bounces-230786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOVhFGfYx2kQdgUAu9opvQ
	(envelope-from <stable+bounces-230786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 14:32:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBB534E86B
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2499F30166FE
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB8220F49;
	Sat, 28 Mar 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhO2hofa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDC4A3E;
	Sat, 28 Mar 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774704737; cv=none; b=KzscYfZdjhICsSiI1RfbW6dumgb6HDvw/cBteFH1JqnxqB9x5DV28/06zarfmYjol+dDoZm8s3fta8/MNK165McSjJcyRgWiS9Zk5s2BYKEkV+oZ98QCY5UFPuz5SDJWKDppvUFGH9hv4ENU1ArV9T+J8eU+/32Uxk3CULSOyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774704737; c=relaxed/simple;
	bh=iN2nAOvFgHdRaJFroDhcaD9ZuEASjAVpYmSsSO7MG1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EosscrEyVxCnlDpeH240DShoEjBqs2wdHVX/3sNHIJE2Mx4Ei5eJEkCgUSTFpsq5JIWYCSkrNZGNr43OfNrft+eczjXb/8Wvyn975GSc0pm3Tjq9m0lltSt6lB86Z/PCSRYe1JqgAFc31aPPf86HJdwPSnvCVzFNqK827TGz0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhO2hofa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92405C4CEF7;
	Sat, 28 Mar 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774704737;
	bh=iN2nAOvFgHdRaJFroDhcaD9ZuEASjAVpYmSsSO7MG1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhO2hofa6+3lYiZaEde0HHBPhe9ZGHPsQ2LSq1Kn3ukb2SYQeegyR5A9GjBjd7fKU
	 vpre8iK+afxqBfvUW7JEvRnX2gmjkuvP7GEccQFoiE/TF1JBAhx2ZhN9YKNyzOP291
	 tnUAIF6YwHG2RKzwSBVPdWRmiunsRvKMM7oupl1iJfYVyzlo9E3kfA60D5T7+MQhXK
	 2HNitmVZNcRcsDwioM062afplwo5NgcQ9IqHbppt24U9TV+ZLratI9Fyz05PNK/SsQ
	 rYq/P7WrHV6WOV/ob8zg383A0oTB75/dUb+/1clv5K9fDWDvDT/Bf1qCRTDQCwCcUo
	 OUkB11T8nA24Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
Date: Sat, 28 Mar 2026 06:32:15 -0700
Message-ID: <20260328133216.9697-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328022956.8415-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230786-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABBB534E86B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TL;DR: good catch but orthogonal to this patch.

On Fri, 27 Mar 2026 19:29:55 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260328005412.7606-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit add63112781ae04626ae6cb9bce55a85234f6e49
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
> 
> This commit adds validation for the given memory node id to prevent out of
> bounds access when calculating node memory metrics. If an invalid node id
> is provided, it defaults to returning 0% used or 100% free memory.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2239,12 +2239,24 @@ static inline u64 damos_get_some_mem_psi_total(void)
> >  static __kernel_ulong_t damos_get_node_mem_bp(
> >  		struct damos_quota_goal *goal)
> >  {
> >  	struct sysinfo i;
> >  	__kernel_ulong_t numerator;
> >  
> > +	if (invalid_mem_node(goal->nid)) {
> > +		if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> > +			return 0;
> > +		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> > +			return 10000;
> > +	}
> > +
> >  	si_meminfo_node(&i, goal->nid);
> >  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
> >  		numerator = i.totalram - i.freeram;
> >  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
> >  		numerator = i.freeram;
> >  	return mult_frac(numerator, 10000, i.totalram);
> 
> Could this result in a division by zero panic?
> 
> While invalid_mem_node() checks node_state(nid, N_MEMORY) to ensure the
> node has present memory pages, si_meminfo_node() sets i.totalram based
> solely on managed pages. If all memory on the node is reserved, i.totalram
> could be 0.
> 
> Additionally, since the node_state() check is lockless, memory could be
> concurrently offlined after invalid_mem_node() but before si_meminfo_node(),
> also resulting in i.totalram being 0.
> 
> Would it be safer to explicitly verify i.totalram is greater than 0 before
> calling mult_frac()?

I'm not very sure if totalram becoming zero is available, but seems making
sense.  But orthogonal to this patch.  I will work on this with another patch.


Thanks,
SJ

[...]

