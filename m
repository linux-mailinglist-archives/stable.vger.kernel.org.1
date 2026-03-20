Return-Path: <stable+bounces-227552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG4LMmNgvWl09QIAu9opvQ
	(envelope-from <stable+bounces-227552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:57:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8A2DC218
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6383A30E177B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277013C661D;
	Fri, 20 Mar 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnBL06xQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF03C5DC2;
	Fri, 20 Mar 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018062; cv=none; b=ktuQxtlZEOI0eebT79MQZO75sjEEEEw7/owidkKAY8UKDaBD8OMwKbSemmtZP+hJ/ODKnfvMyUgOksR7oYLDTpdO+mxpNAQyufdSnlxyPZXi9oUcmFfuzI7Y5oiuCderqjs1II1a4nsiJMV0Ibmhy/msFLMX0lItZaqhwvhUGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018062; c=relaxed/simple;
	bh=xJo2T4vc+YcK0Zp0uhjPMvQz9+xZATwcssrwN2pYBAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnT/Iqn+C+a7B//cQM6vTjqPjg19113Vun63N/J1Nhsp6wfTyl0FCoqW2lkpoXSZjEyzFMXJ9ouZmgXSCBNsvVunNXNe3scOzz1z4RJavk4RrxBzXdWO+Zg7oRuC6QwJv6jbgNELhHu/ic2IQOiy3uHEIT1WzuKXY+cwuPXf4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnBL06xQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B8C4CEF7;
	Fri, 20 Mar 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018062;
	bh=xJo2T4vc+YcK0Zp0uhjPMvQz9+xZATwcssrwN2pYBAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnBL06xQzPc5XvlnrVn4NDvd8X+YFlTc/+xOq8Y+z/xBCzb4FFIy7PGInTy12pQGz
	 RfWdT6uiyt921qgEvimwLWKgRxVkX2SXGctJ93xh7hlfoILxeer9vvh+x3+Lobt/r7
	 v61g4JwXjHVsyRXefeaOtLHXGfKpvxDV95pKgrXvOgwvvNNHasnXdoa6RewHVaoLiT
	 F9JjfVfnCKwjkHAK4dIKdxhWc6P6qZkrG7jMb6ix3GpK0YFnktSyGbQFCqe1OSdKhi
	 sbVeGWBWdlQg5wpm+MQNKllgT4ZPmc6E5Bii7xz7UBX47nFQVfkMrCFElumW+CQl6H
	 5gh1uFWBtiCBg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/damon/sysfs: check contexts->nr before clear_schemes_tried_regions
Date: Fri, 20 Mar 2026 07:47:40 -0700
Message-ID: <20260320144741.91848-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8F30B2A1-240C-43D3-B756-20E327F5BCF3@objecting.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227552-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: 6BD8A2DC218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 07:06:48 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 20 March 2026 02:13:17 GMT, SeongJae Park <sj@kernel.org> wrote:
> >On Thu, 19 Mar 2026 15:57:40 +0000 Josh Law <objecting@objecting.org> wrote:
> >
> >> The CLEAR_SCHEMES_TRIED_REGIONS command accesses contexts_arr[0]
> >> without verifying nr_contexts >= 1, causing a NULL pointer dereference
> >> when no context is configured. Add the missing check.
> >
> >Nice catch, thank you!
> >
> >Privileged users can trigger this using DAMON sysfs interface.  E.g.,
> >
> >    # cd /sys/kernel/mm/damon/admin/kdamonds/
> >    # echo 1 > nr_kdamonds
> >    # echo clear_schemes_tried_regions > state
> >    killed
> >    # dmesg
> >    [...]
> >    [63541.377604] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >    [...]
> >
> >Privileged users can do anything even worse than this, but they might also do
> >this by a mistake.
> >
> >So this deserves Fixes: and Cc stable.
> >
> >>
> >> Signed-off-by: Josh Law <objecting@objecting.org>
> >> ---
> >>  mm/damon/sysfs.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> >> index b573b9d60784..36ad2e8956c9 100644
> >> --- a/mm/damon/sysfs.c
> >> +++ b/mm/damon/sysfs.c
> >> @@ -1769,6 +1769,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
> >>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
> >>               return damon_sysfs_update_schemes_tried_regions(kdamond, false);
> >>       case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
> >> +             if (kdamond->contexts->nr != 1)
> >> +                     return -EINVAL;
> >>               return damon_sysfs_schemes_clear_regions(
> >>                       kdamond->contexts->contexts_arr[0]->schemes);
> >>       case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
> >> --
> >> 2.34.1
> >
> >So this patch looks good as an individual fix for the individual bug, but...
> >
> >Sashiko commented.
> >
> ># review url: https://sashiko.dev/#/patchset/20260319155742.186627-3-objecting@objecting.org
> >
> >: Does this missing check also affect other manual commands?
> >:
> >: If a user writes UPDATE_SCHEMES_STATS, UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
> >: or UPDATE_TUNED_INTERVALS to the state file after setting nr_contexts
> >: to 0, damon_sysfs_handle_cmd() queues the corresponding callback via
> >: damon_sysfs_damon_call().
> >:
> >: When the kdamond thread executes the callback, it appears functions like
> >: damon_sysfs_upd_schemes_stats() access contexts_arr[0] without verifying
> >: contexts->nr:
> >:
> >: static int damon_sysfs_upd_schemes_stats(void *data)
> >: {
> >:         struct damon_sysfs_kdamond *kdamond = data;
> >:         struct damon_ctx *ctx = kdamond->damon_ctx;
> >:
> >:         damon_sysfs_schemes_update_stats(
> >:                         kdamond->contexts->contexts_arr[0]->schemes, ctx);
> >:         return 0;
> >: }
> >:
> >: Could this result in a similar NULL pointer dereference if these commands
> >: are triggered while no context is configured?
> >
> >Sashiko is correct.  Privileged users can trigger the issues like below.
> >
> ># damo start
> ># cd /sys/kernel/mm/damon/admin/kdamonds/0
> ># echo 0 > contexts/nr_contexts
> ># echo update_schemes_stats > state
> ># echo update_schemes_effective_quotas > state
> ># echo update_tuned_intervals > state
> >
> >Not necessarily blocker of this patch, but seems all the issues are in a same
> >category.  The third patch of this series is also fixing one of the category
> >bugs.  How about fixing all at once by checking kdamond->contexts->nr at the
> >beginning of damon_sysfs_handle_cmd(), like below?
> >
> >--- a/mm/damon/sysfs.c
> >+++ b/mm/damon/sysfs.c
> >@@ -2404,6 +2404,9 @@ static int damon_sysfs_update_schemes_tried_regions(
> > static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
> >                struct damon_sysfs_kdamond *kdamond)
> > {
> >+       if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
> >+               return -EINVAL;
> >+
> >        switch (cmd) {
> >        case DAMON_SYSFS_CMD_ON:
> >                return damon_sysfs_turn_damon_on(kdamond);
> >
> >If we pick this, Fixes: would be deserve to the oldest buggy commit that
> >introduced the first bug of this category.  It is indeed quite old.
> >
> >Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
> >Cc: <stable@vger.kernel.org> # 5.18.x
> >
> >
> >Thanks,
> >SJ
> 
> 
> 
> Hello, did you give Reviewed by you? Or not..

Are you meaning Reviewed-by: tag?  If so, no, not yet.  I want to get your
answer to above question first.  Could you please answer?


Thanks,
SJ

[...]

