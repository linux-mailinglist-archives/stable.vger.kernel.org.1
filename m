Return-Path: <stable+bounces-225740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEFjK2nouGkllQEAu9opvQ
	(envelope-from <stable+bounces-225740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5242A402D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D20A301CD86
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8636E489;
	Tue, 17 Mar 2026 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A841uQKU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179637F012;
	Tue, 17 Mar 2026 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725794; cv=none; b=N/NQ0HKHiaBlqB7ezLydiJCtvBio6if/iQD4362Co2Mh7SVitSwIgGE9zIi8lkcCyxFw4/FxN5RGF0x/g94IJqRKmT1DfNPtcYPo/waGPVFmGvB0r2cf1oRn8H3cDZD4D2sTbqxZQKlgZ6FBBf/1SeEzWgVSyfVfqXlP1CtLSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725794; c=relaxed/simple;
	bh=/21WQ/IOtHu4dvnXgF2/nu4A18vGdKJxEcpXgHCCKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9QC5ZxmVmiUKOqaEQjZbnMt6xx8bKq0eDk+2hXlOyzCKIs0LfdXMHL6qC/qaBCWzdGmjQUohyiL+YYovLwNwUksahRe0otoD8IqGYGdK9JlM9Sf+sS4FqOfNmFrGBnZNV+xodKj4Z+8XPAVFA0VMKo4BzJBzZyXXf8oLuJnR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A841uQKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5A7C4CEF7;
	Tue, 17 Mar 2026 05:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773725793;
	bh=/21WQ/IOtHu4dvnXgF2/nu4A18vGdKJxEcpXgHCCKGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A841uQKUOfqgjvLaPC0o8iVD3qLdenC2SHF2SBaJEZiRlJ+edfKAGybSXd4hMKI7G
	 GRi7lY7658ozFWQWFXC2Ue5g4vGpDybr1of1ClBghi9RV3JTQzcukZEQnPDsElDt3R
	 5YLPiXL6V91zmefZNpbZcz1wwofiOqDUSLNruYWZNMAB6X2vEDMuGQQQzBw5v8QlbZ
	 W65ihHvHH70srQ/eFmdtvhCkaGjSBPKpWS3v1bAJ3JkDC1NRpXMDIPgN17y5ouNwlQ
	 fJRzfMm0YfWFx3+STjKA48vqkuKfv3vtOWssYhtbAlRru0OAeVq7PqZbIbH9de8dvo
	 MAtSIYcvKnqhA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/damon/stat: monitor all System RAM resources
Date: Mon, 16 Mar 2026 22:36:30 -0700
Message-ID: <20260317053631.87907-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316235118.873-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225740-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A5242A402D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TL; DR: sashiko.dev found a problem in this patch.  Andrew, could you please
add the attached fixup, or let me know if you prefer v4?

sashiko.dev added [1] comments.  Quoting the comments with ': ' line prefix,
and replying to it in line below.

On Mon, 16 Mar 2026 16:51:17 -0700 SeongJae Park <sj@kernel.org> wrote:

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
> Changes from v2
> (https://lore.kernel.org/20260315162717.80870-1-sj@kernel.org)
> - Rebase to mm-hotfixes-unstable
> Changes from v1
> (https://lore.kernel.org/20260313044449.4038-1-sj@kernel.org)
> - Fix wrong argument for damon_set_regions().
> 
>  mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> index 25fb44ccf99d0..c5af8ad4bcb65 100644
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

: Does creating a single bounding box from the start of the first RAM resource
: to the end of the last one force DAMON to monitor massive unpopulated
: physical memory gaps?
: 
: On NUMA systems, memory nodes are often separated by large holes. Passing
: this single large range to damon_set_regions() might spread max_nr_regions
: over these holes, which could dilute the accuracy of the memory bandwidth
: statistics since sampling non-RAM addresses yields zero accesses.
: 
: Would it be better to dynamically allocate an array of struct
: damon_addr_range covering only valid System RAM boundaries and pass the
: multiple ranges to damon_set_regions() using the nr_ranges parameter?

Yes, it can force DAMON to monitor massive unpopulated phyiscal memory gaps.
But, because DAMON utilizes its adaptive regions adjustment mechanism, the
overhead will be negligible.  This is an intended behavior.

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

: Could this silently truncate physical addresses above 4GB on 32-bit systems
: with PAE enabled?
: 
: The function walk_system_ram_res() scans the 64-bit physical address space,
: and resource_size_t can be a 64-bit integer, accurately holding addresses
: above 4GB. However, this function returns an unsigned long, and DAMON's
: struct damon_addr_range uses unsigned long for its boundaries.
: 
: Since damon_stat uses an addr_unit of 1, any 64-bit physical address might
: be truncated to 32 bits when returned. This could create an inverted region
: where the truncated end becomes smaller than start, breaking the
: damon_set_regions() initialization and causing out-of-bounds memory accesses.

This is correct, and the consequence is problematic.

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


: Is it possible for arg.res.end + 1 to overflow here?
: 
: On 32-bit architectures without PAE, resource_size_t is a 32-bit unsigned
: integer. If physical RAM extends to the very top of the 32-bit address
: space, arg.res.end will be 0xFFFFFFFF.
: 
: Adding 1 to this value triggers an integer overflow, resulting in 0, which
: is then assigned to addr_range.end. Passing a region with a start greater
: than 0 and an end of 0 to damon_set_regions() creates a structurally invalid
: inverted region, which might corrupt subsequent DAMON calculations and
: sampling operations.

Again, this is correct, and the consequence is problematic.

We can avoid the problematic consequence by checking if addr_range is valid,
and return an error if not.  Below attaching fixup patch is implementing it.
Andrew, could you please add the fixup patch?  Pleae let me know if you prefer
v4.


Thanks,
SJ

[...]
=== >8 ===
From e1fd7cf6469977cf1a58ee98b977eec53219ffc2 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 16 Mar 2026 22:11:22 -0700
Subject: [PATCH] mm/damon/stat: return error if monitoring target region is
 invalid

On 32bit systems with LPAE, the end address might be overflowed or
truncated, resulting in invalid range (the end address is equal or
smaller than the start address).  Return an error for the case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index c5af8ad4bcb65..cf2c5a541eeea 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -188,6 +188,8 @@ static int damon_stat_set_monitoring_region(struct damon_target *t,
 			arg.res.start, addr_unit);
 	addr_range.end = damon_stat_res_to_core_addr(
 			arg.res.end + 1, addr_unit);
+	if (addr_range.end <= addr_range.start)
+		return -EINVAL;
 	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
-- 
2.47.3


