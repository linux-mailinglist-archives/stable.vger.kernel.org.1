Return-Path: <stable+bounces-225244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yfqAIlCWs2n+YQAAu9opvQ
	(envelope-from <stable+bounces-225244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:45:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C938627D4B0
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742503097E8E
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 04:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383D29A312;
	Fri, 13 Mar 2026 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0aA3IvN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262028852E;
	Fri, 13 Mar 2026 04:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773377098; cv=none; b=FhNIqh6wZ5hykWN0OmlfLsVTxLHqPr8HYu+3uaF1WmSAp7SeFNhOBkamTFg8WjunEjjFUI24fxd6tsoTiOLqxyfuM8n+y5O9oZp5+Szepqd3nhMhJeNbeSLR8nc6ofdfFmMQlNtVKKHEC+YO9Wlo7/4EUxrbkyyKsPyo18xluiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773377098; c=relaxed/simple;
	bh=XrYj7XvkjVOrSZUvKRwcxWJvhLvpmnJnSlNXlwKIaTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3+cxCL4O7+yI9kc6trKT0Ytzp8aEcTL6kXUFpTHxVWRvwFTNnhROG15m2mscMszJQNTDwS7HcqQewa3JmShu77OLWufpOIpM4luX8ZC7RXW/eKz1OkEqV54o3+RasY+MuKUOw3PSSLDgHmaS0GI/V96wpE6+twYkEesUs5D/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0aA3IvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B247C19421;
	Fri, 13 Mar 2026 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773377097;
	bh=XrYj7XvkjVOrSZUvKRwcxWJvhLvpmnJnSlNXlwKIaTg=;
	h=From:To:Cc:Subject:Date:From;
	b=H0aA3IvNRoRHgjcHUUzksuzmMWNJLmK4v9Lp48NTbH9e0AkbLkElRqbWZayjAPLbg
	 x+GoXKm90rStryfp+ullE7dqATkwSMnrcpKaYaeFX28NCEdDzvVn0Zw5jDlW0czAJs
	 eX1rDZXX+XK1ViKtJ+/lAWC+24LB3/EoKAoROgDjSRZ+bQMnxT6nyw6YwaZfvpA619
	 toeR62XHeVE55FV2ujkN7fP4gCs26O3txwrcpEttmrZ7jnoX2lJQmeXM8B14v3e6HA
	 yxeDVZFPCQzeYhHuRM9y2E3JShr3xKYpyMr7hRWVZxTCBbxueKef6aHjYAOpSEyr+h
	 cFgG9SxQo41Aw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/stat: monitor all System RAM resources
Date: Thu, 12 Mar 2026 21:44:47 -0700
Message-ID: <20260313044449.4038-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225244-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C938627D4B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
says it monitors the system's entire physical memory.  But, it is
monitoring only the biggest System RAM resource of the system.  When
there are multiple System RAM resources, this results in monitoring only
an unexpectedly small fraction of the physical memory.  For example,
suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
500 GiB System RAM resources in order on the physical address space.
DAMON_STAT will monitor only the first 500 GiB System RAM.  This
situation is particularly common on NUMA systems.

Select a physical address range that covers all System RAM areas of the
system, to fix this issue and make it work as documented.

Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index f9a2028483b05..3ed71db33e899 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -145,12 +145,57 @@ static int damon_stat_damon_call_fn(void *data)
 	return 0;
 }
 
+struct damon_stat_system_ram_range_walk_arg {
+	bool walked;
+	struct resource res;
+};
+
+static int damon_stat_system_ram_walk_fn(struct resource *res, void *arg)
+{
+	struct damon_stat_system_ram_range_walk_arg *a = arg;
+
+	if (!a->walked) {
+		a->walked = true;
+		a->res.start = res->start;
+	}
+	a->res.end = res->end;
+	return 0;
+}
+
+static unsigned long damon_stat_res_to_core_addr(resource_size_t ra,
+		unsigned long addr_unit)
+{
+	/*
+	 * Use div_u64() for avoiding linking errors related with __udivdi3,
+	 * __aeabi_uldivmod, or similar problems.  This should also improve the
+	 * performance optimization (read div_u64() comment for the detail).
+	 */
+	if (sizeof(ra) == 8 && sizeof(addr_unit) == 4)
+		return div_u64(ra, addr_unit);
+	return ra / addr_unit;
+}
+
+static int damon_stat_set_monitoring_region(struct damon_target *t,
+		unsigned long addr_unit, unsigned long min_region_sz)
+{
+	struct damon_addr_range addr_range;
+	struct damon_stat_system_ram_range_walk_arg arg = {};
+
+	walk_system_ram_res(0, -1, &arg, damon_stat_system_ram_walk_fn);
+	if (!arg.walked)
+		return -EINVAL;
+	addr_range.start = damon_stat_res_to_core_addr(
+			arg.res.start, addr_unit);
+	addr_range.end = damon_stat_res_to_core_addr(
+			arg.res.end + 1, addr_unit);
+	return damon_set_regions(t, &addr_range, addr_unit, min_region_sz);
+}
+
 static struct damon_ctx *damon_stat_build_ctx(void)
 {
 	struct damon_ctx *ctx;
 	struct damon_attrs attrs;
 	struct damon_target *target;
-	unsigned long start = 0, end = 0;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -180,8 +225,8 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	if (damon_set_region_biggest_system_ram_default(target, &start, &end,
-				ctx->addr_unit, ctx->min_region_sz))
+	if (damon_stat_set_monitoring_region(target, ctx->addr_unit,
+				ctx->min_region_sz))
 		goto free_out;
 	return ctx;
 free_out:

base-commit: ef772f765091af645985f2bd70390143a9820970
-- 
2.47.3

