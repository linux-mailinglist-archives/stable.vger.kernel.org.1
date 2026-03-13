Return-Path: <stable+bounces-225401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 98pzK3SgtGlxrQAAu9opvQ
	(envelope-from <stable+bounces-225401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 00:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F52228AB71
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 00:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14B530F9DEF
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EB3E51D9;
	Fri, 13 Mar 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C32twsm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBD3C552D;
	Fri, 13 Mar 2026 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773445231; cv=none; b=Rf1CsEz1DG/mOaxHK92UPXbnB13tDLOzzbN629Eq3X5bUDEb6qQlbVaVsmjgbzYw0+htWkOvzRXZfEmiYSbMbOLiYXXKG8Pq/mRCG6ysvvQwBdFNk2rmM7ffCp6DfhTnJVg9oU9DiEIOLIoGuWpRpOmlmmM86ZFnMYMO2IGwd4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773445231; c=relaxed/simple;
	bh=diDZ4t93o+Rf0IOUn0/DF6Qjjum05J/e29qbsPhZkp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDMazPzygMTMSwQGbqKxuAzZtlcvmKHizCgYic4AXPpW0PARnm3oLHRLKusWotOoxe6Z1wq7yhWGIA1n6mAGwMElCHplqUxVzNpwmDaZeHrGzocXpU/3A7hOef+Jy/boWAXE3HfEMhobNGafKL2lUDO21zkRD6evrsz+kTYQnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C32twsm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB2C19421;
	Fri, 13 Mar 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773445231;
	bh=diDZ4t93o+Rf0IOUn0/DF6Qjjum05J/e29qbsPhZkp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C32twsm7DujBauXg1gp2P4PHnRBTfRCqhPncllIb0snO1e4wxE4R1B1L6hUDjunb4
	 XnZGxadolRgl8MOApp6yycb4wCKsjGndxh51lTbLYxJJoeDRMQO02ul6pFZCFnejlV
	 NP7l/LryZ/t6PsvN+QKMMPv0417kHSVYUnAhBDLkTrGp4Amc0LijmB1S8IP2djT/ml
	 8Xn4ku0S9eJ+nvKqikSGyRejkBmbBIFFNai7TtJqcK4pZBF86SEViFe8lcuLqd0LpI
	 eAbWtEPH4oXx14NQuq9uxsqw0lq3lsqWoKz0m41tjQcgXUnQWFIPy/0zBZzXNPgSIF
	 8iJdjQe71Ai1Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/stat: monitor all System RAM resources
Date: Fri, 13 Mar 2026 16:40:22 -0700
Message-ID: <20260313234026.48872-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313044449.4038-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225401-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 0F52228AB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 21:44:47 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> says it monitors the system's entire physical memory.  But, it is
> monitoring only the biggest System RAM resource of the system.  When
> there are multiple System RAM resources, this results in monitoring only
> an unexpectedly small fraction of the physical memory.  For example,
> suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> 500 GiB System RAM resources in order on the physical address space.
> DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> situation is particularly common on NUMA systems.
> 
> Select a physical address range that covers all System RAM areas of the
> system, to fix this issue and make it work as documented.
> 
> Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> Cc: <stable@vger.kernel.org> # 6.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index f9a2028483b05..3ed71db33e899 100644
> --- a/mm/damon/stat.c
> +++ b/mm/damon/stat.c
> @@ -145,12 +145,57 @@ static int damon_stat_damon_call_fn(void *data)
>  	return 0;
>  }
>  
> +struct damon_stat_system_ram_range_walk_arg {
> +	bool walked;
> +	struct resource res;
> +};
> +
> +static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
> +{
> +	struct damon_stat_system_ram_range_walk_arg *a = arg;
> +
> +	if (!a->walked) {
> +		a->walked = true;
> +		a->res.start = res->start;
> +	}
> +	a->res.end = res->end;
> +	return 0;
> +}
> +
> +static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
> +		unsigned long addr_unit)
> +{
> +	/*
> +	 * Use div_u64() for avoiding linking errors related with __udivdi3,
> +	 * __aeabi_uldivmod, or similar problems.  This should also improve the
> +	 * performance optimization (read div_u64() comment for the detail).
> +	 */
> +	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
> +		return div_u64(ra, addr_unit);
> +	return ra / addr_unit;
> +}
> +
> +static int damon_stat_set_monitoring_region(struct damon_target *t,
> +		unsigned long addr_unit, unsigned long min_region_sz)
> +{
> +	struct damon_addr_range addr_range;
> +	struct damon_stat_system_ram_range_walk_arg arg = {};
> +
> +	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
> +	if (!arg.walked)
> +		return -EINVAL;
> +	addr_range.start = damon_stat_res_to_core_addr(
> +			arg.res.start, addr_unit);
> +	addr_range.end = damon_stat_res_to_core_addr(
> +			arg.res.end + 1, addr_unit);
> +	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);

The third argument of damon_set_regions() is the number of ranges (length of
the array passed by the second argument), so '1' should be passed.  But the
patch is passing 'addr_unit'.  It will not cause a real issue since the value
is set to '1' in this case.  But it is an obvious bug.  I will fix this in the
v2.

FYI, I found this issue from an AI code review result [1] that published on the
internet.  The review also added two more comments, but those seem irrelevant
to me, so ignoring.  I don't know who made the web site.  I only got the url
from a social.kernel.org post [2].  Whoever made the web site, thanks for the
review.

[1] https://sashiko.dev/#/patchset/20260313044449.4038-1-sj%40kernel.org
[2] https://social.kernel.org/notice/B4E8DdeZY07PseemfI


Thanks,
SJ

[...]

