Return-Path: <stable+bounces-225402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 954pOZattGmDrwAAu9opvQ
	(envelope-from <stable+bounces-225402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 01:36:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511728AF82
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 01:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E78308ED5D
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 00:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3CA296BC8;
	Sat, 14 Mar 2026 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXyJMDzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A631A0BD6;
	Sat, 14 Mar 2026 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773448595; cv=none; b=VOZwp7/Ubb6vTdA2b1Yy11gdD3YVCr26wUhY/w9bhi+pxLS7W6eIWMKrqCNAcp0ptA+wK5reC9+VNzDCDiQFhdysxS6+VCXn3HEfHAWDwN47MIr5M1BxWdA795oS+Qm0gROpVlEQajJ3s9n66IdPLEgxTNT3Cj7Uwux34gRj/XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773448595; c=relaxed/simple;
	bh=FowyrWUPuB+tCjsK9lYkRm2bV4LqWIMEHeyNsO7g9Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX6nn7/CsqhAzfSYOdlZ3QwcQ+1VOXmvwzFRJMl3opnyJ+NQ6XHaSgs3YpbT39RcuEnf0dYZGYm2roUKcpk8l6qHIGRyr/xyr9EzpBmHMYhM0ljPSKWEWodNc3tAdAQmSnWhGNDk11KJWPavD9z2Q45yJN/+G1n9QZoN24yU/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXyJMDzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326AC19421;
	Sat, 14 Mar 2026 00:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773448594;
	bh=FowyrWUPuB+tCjsK9lYkRm2bV4LqWIMEHeyNsO7g9Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXyJMDzQX02Gd4BouBC03Hr5qQIcmmWyOuKp6xs0qijRdX7gQjQHsSx3x3Mb9uL4v
	 xH9oB2aT7KFxmF8WM+M3R+WmMucOjIIOArKqLmnpzRG/dAj59gM9qQtDQboVIG8MdO
	 kkzJGzjFy2huALBnU/wxkCzchnR4wereOemiTF/077M8NoKv5S2flAB/jXFDwxjgnX
	 +MnfiOq/vbbfQFbCW6ds0+ro/QL3RPDimUxx4CPOteO988ebzKeVUmbCJZLLMubZ+/
	 MOXp+Wk/HjLaBMl3YAp3hqTqEhVwHdSL43XDrFqoH+GS7xImFCgXgHSYDNzG3iUzZK
	 oiZMFF/TJNayQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/stat: monitor all System RAM resources
Date: Fri, 13 Mar 2026 17:36:20 -0700
Message-ID: <20260314003621.80567-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313234026.48872-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225402-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 4511728AF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 16:40:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 12 Mar 2026 21:44:47 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> > says it monitors the system's entire physical memory.  But, it is
> > monitoring only the biggest System RAM resource of the system.  When
> > there are multiple System RAM resources, this results in monitoring only
> > an unexpectedly small fraction of the physical memory.  For example,
> > suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> > 500 GiB System RAM resources in order on the physical address space.
> > DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> > situation is particularly common on NUMA systems.
> > 
> > Select a physical address range that covers all System RAM areas of the
> > system, to fix this issue and make it work as documented.
> > 
> > Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> > Cc: <stable@vger.kernel.org> # 6.17.x
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index f9a2028483b05..3ed71db33e899 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -145,12 +145,57 @@ static int damon_stat_damon_call_fn(void *data)
> >  	return 0;
> >  }
> >  
> > +struct damon_stat_system_ram_range_walk_arg {
> > +	bool walked;
> > +	struct resource res;
> > +};
> > +
> > +static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
> > +{
> > +	struct damon_stat_system_ram_range_walk_arg *a = arg;
> > +
> > +	if (!a->walked) {
> > +		a->walked = true;
> > +		a->res.start = res->start;
> > +	}
> > +	a->res.end = res->end;
> > +	return 0;
> > +}
> > +
> > +static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
> > +		unsigned long addr_unit)
> > +{
> > +	/*
> > +	 * Use div_u64() for avoiding linking errors related with __udivdi3,
> > +	 * __aeabi_uldivmod, or similar problems.  This should also improve the
> > +	 * performance optimization (read div_u64() comment for the detail).
> > +	 */
> > +	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
> > +		return div_u64(ra, addr_unit);
> > +	return ra / addr_unit;
> > +}
> > +
> > +static int damon_stat_set_monitoring_region(struct damon_target *t,
> > +		unsigned long addr_unit, unsigned long min_region_sz)
> > +{
> > +	struct damon_addr_range addr_range;
> > +	struct damon_stat_system_ram_range_walk_arg arg = {};
> > +
> > +	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
> > +	if (!arg.walked)
> > +		return -EINVAL;
> > +	addr_range.start = damon_stat_res_to_core_addr(
> > +			arg.res.start, addr_unit);
> > +	addr_range.end = damon_stat_res_to_core_addr(
> > +			arg.res.end + 1, addr_unit);
> > +	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);
> 
> The third argument of damon_set_regions() is the number of ranges (length of
> the array passed by the second argument), so '1' should be passed.  But the
> patch is passing 'addr_unit'.  It will not cause a real issue since the value
> is set to '1' in this case.  But it is an obvious bug.  I will fix this in the
> v2.

Or, Andrew, if you prefer to, please pick below attaching fixup together.  I
will post v2 on Sunday if this is not picked up with the below fixup by
tomorrow.


Thanks,
SJ

[...]
=== >8 ===
From e5f029441de038289320a7cb99a249800d99471f Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 13 Mar 2026 16:41:00 -0700
Subject: [PATCH] mm/damon/stat: fix wrong argument to damon_set_regions()

The third argument for damon_set_regions() is the number of ranges in
the second argument, but the code is wrongly passing addr_unit.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 3ed71db33e899..c5af8ad4bcb65 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -188,7 +188,7 @@ static int damon_stat_set_monitoring_region(struct damon_target *t,
 			arg.res.start, addr_unit);
 	addr_range.end = damon_stat_res_to_core_addr(
 			arg.res.end + 1, addr_unit);
-	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);
+	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
 static struct damon_ctx *damon_stat_build_ctx(void)
-- 
2.47.3


