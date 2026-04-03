Return-Path: <stable+bounces-233204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP9TJvriz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:55:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78183395FF7
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B703004064
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E93C7E09;
	Fri,  3 Apr 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5wGlcuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3513C65E7;
	Fri,  3 Apr 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231732; cv=none; b=B4+KBWFuku395cpNF8LD0+0rzFnxgnggJwVqKsdb2x22Fa4Ol9Vty5+/fUxTegna4V62ysXzuI3+PNQ5LfrJZETDZTp8yDhLauEBAsYKlrTy4KWbcD67FfprZTzk4Ry0xut6aeC6L6MaXvSrOb+gXwqEXHLlaOskiailoW3jQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231732; c=relaxed/simple;
	bh=35zDWu2wx/9bCgEmtX9C9yeqHPmuELOVI34fAibz50w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7KBc5I7B0fM43QROqU/ODd5mrdKlxGZhk1NJxLyNJP9P16W8KQB6TFumUdC3IUQpCOAfs0RubOVbkNnc3U9XqYoKkiKz5q8GV/x6LwmTpnlu6E3bg+N7djEFbi725+6CEueV2LOCB+JpU36U0ifEAzEU17rl+00JEZr/zSDPws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5wGlcuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D1DC19421;
	Fri,  3 Apr 2026 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231732;
	bh=35zDWu2wx/9bCgEmtX9C9yeqHPmuELOVI34fAibz50w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5wGlcuDkRVhAWhsidqFtu41cD2ec26NkSP9vokXUafjFY+fSNVIdEP+obwOp7mYT
	 7ySHIol3/nFQI4a2lHU6B13jWfivtsmVOMccVxStaTi6OO/F8VnG9s2bSgRHYwE1R4
	 Q82EnuYDmTDOGfD8gN02SrPRCPzAvxFy7Dbjjm8ZYaYaOt+VvY4ZKCGqjcYaqsusVG
	 lHU2txyH4qWsNFROjrtoD7GyxxlAketkaGqDoAttPHFR3XOUR5Fe6NGnmn9WeTZUT0
	 fR/45hOsuzZMMvoRMZqvJA64PYaXnx108TDOGInGrR56u24BaGMc1eN8EkBFRBy0s9
	 IeEjwwX1dZvlQ==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	yanquanmin1@huawei.com
Subject: Re: (sashiko review) [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 08:55:29 -0700
Message-ID: <20260403155530.64647-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403083125.5654-1-aethernet65535@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233204-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78183395FF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Liew,


I recently learned not everyone is interested [1] in sashiko review.  So when
I sharing sashiko review, I now try to drop recipients who are not necessarily
interested in the review.  My choices at the moment is the author of the patch,
maintainers of the subsystem, and the mailing lists of the subsystem.

So if I was sharing this review, I would dropped stable@ and yanquanmin1@ from
the Cc list.

Please consider doing similar when you share sashiko review.

Everyone including myself is learning how to use sashiko well, so it could be
confusing.  Sorry about that.  I'm planning to make a guideline for sashiko
review usage in DAMON subsystem, and update hkml to embed it, hoping that to
help reducing some of the confusion.

Anyway, seems sashiko found no blockers for this patch.

On Fri,  3 Apr 2026 16:31:25 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit 525a0116b6d91612e679b30ae84e489a7540edbf
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/lru_sort: validate min_region_size to be power of 2
> 
> This commit adds an early check in damon_lru_sort_apply_parameters() to
> ensure min_region_sz is a power of 2. This prevents kdamond from unexpectedly
> terminating when given an invalid addr_unit.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..3fd176ef9d9c1 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> Instead of adding this early check here, could this be resolved by fixing
> the stateless validation in damon_commit_ctx() directly?
> 
> Looking at damon_commit_ctx(), it currently sets dst->maybe_corrupted = true
> before checking if src->min_region_sz is a power of 2:
> 
> int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> {
> 	int err;
> 
> 	dst->maybe_corrupted = true;
> 	if (!is_power_of_2(src->min_region_sz))
> 		return -EINVAL;
> ...
> }
> 
> When this validation fails, it leaves the active context marked as corrupted
> without making any state changes, which causes the kdamond thread to terminate
> permanently. Moving the stateless is_power_of_2() check above
> dst->maybe_corrupted = true would resolve the regression for all current and
> future callers without requiring duplicated validation logic at every
> call site.

We discussed this before, and decided not to add the check for now.

Keeping this behavior also makes the expectation for callers simpler:
damon_commit_ctx() failure always means kdamond will be terminated.

> 
> Does this missing validation also affect mm/damon/sysfs.c?
> 
> When a user starts DAMON via state_store() -> damon_sysfs_turn_damon_on(),
> the code calls damon_sysfs_build_ctx(). This calculates min_region_sz and
> then directly calls damon_start(), bypassing damon_commit_ctx() entirely.
> 
> Because this bypasses the is_power_of_2() checks, kdamond can actively run
> with a non-power-of-2 min_region_sz. Core DAMON operations like
> damon_set_regions() use ALIGN() and ALIGN_DOWN() with min_region_sz, which
> perform bitwise masking that requires the alignment parameter to be a
> power of 2.
> 
> Could this allow userspace to trigger incorrect address boundaries, massive
> unsigned underflows, or infinite loops during region splitting?

Good catch, but none of this patch's business.  I will work on this.

> 
> >  	if (!damon_lru_sort_mon_attrs.sample_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com

[1] https://lore.kernel.org/20260331043441.67196-1-sj@kernel.org


Thanks,
SJ

[...]

