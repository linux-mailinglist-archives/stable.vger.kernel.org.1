Return-Path: <stable+bounces-270309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w9Z4GB/HRWooFAsAu9opvQ
	(envelope-from <stable+bounces-270309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:04:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C154E6F2EDE
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 04:04:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="QVwQSf/g";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270309-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270309-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8C68304F2CB
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C42294A10;
	Thu,  2 Jul 2026 02:03:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE7274641;
	Thu,  2 Jul 2026 02:03:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957817; cv=none; b=O8Rvz9etcWNhlT4KkHYpjEZ49+IKfmNQlqeP/I6M+8UR8b/sdv/BKIWqVnsWssTLKS8NCqOexVN48CVjS3yELXyD5lhjVhICKk/hysfEmXln9S1nWkHIENgGnxDgMF0Zu8bl0i9mFRDmEbp0vQmuplSF9EHgoe7QCgMeMh9e1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957817; c=relaxed/simple;
	bh=chdDI0qumb+k/Kq/v5mhwGYduCv65aAfmV2HQgdTjOA=;
	h=Date:To:From:Subject:Message-Id; b=G4DSXgt2kFbgOXcTtLZ1c9P5aGpZkiockvDCzEneYHhvH93rLMJFtdt9wNBuNWm8kH5MDYXb0rrGwf7i+Q50w/7ptBegpj+cEgeh0s6NNuZ4iLEsWfDAlPJInj96pJkbmZwtlKNWDKV+Odw2So9ICJQM4RKQYpKTa4K9qGmrF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QVwQSf/g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A0C1F000E9;
	Thu,  2 Jul 2026 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782957816;
	bh=7FNXPJ7vFX5bNWaFaOjTpDHLMgJ1YkLce/eEP8W+Mps=;
	h=Date:To:From:Subject;
	b=QVwQSf/gxhaPPvOvZEShTFzKqTQ51ymMmXnZHEZlAHLZKkIJaKCCx7W385ocgZ9Fa
	 JAgJWqVIwyq9BmCK5tdDl5UtjfrTD0POSp0rTRO08kB0Sdrby7E6dRrG6RFvJ31Etz
	 bmAd+ty/T6wTBz6uoZrY2vjXGg/RSUxcGxfosKUQ=
Date: Wed, 01 Jul 2026 19:03:35 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-ops-common-handle-extreme-intervals-in-damon_hot_score.patch removed from -mm tree
Message-Id: <20260702020336.08A0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270309-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:sj@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C154E6F2EDE


The quilt patch titled
     Subject: mm/damon/ops-common: handle extreme intervals in damon_hot_score()
has been removed from the -mm tree.  Its filename was
     mm-damon-ops-common-handle-extreme-intervals-in-damon_hot_score.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/ops-common: handle extreme intervals in damon_hot_score()
Date: Tue, 23 Jun 2026 06:58:31 -0700

Fix three issues in damon_hot_score() that comes from wrong handling of
extreme (zero or too high) monitoring intervals user setup.

When the user sets sampling interval zero, damon_max_nr_accesses(), which
is called from damon_hot_score(), causes a divide-by-zero.  Needless to
say, it is a problem.

When the user sets the aggregation interval zero, the function returns
zero.  It is wrong, since the real maximum nr_acceses in the setup should
be one.  Worse yet, it can cause another divide-by-zero from its caller,
damon_hot_score(), since it uses damon_max_nr_accesses() return value as a
denominator.

When the user sets the aggregation interval very high, damon_hot_score()
could return a value out of [0, DAMOS_MAX_SCORE] range.  Since the return
value is used as an index to the regions_score_histogram array, which is
DAMOS_MAX_SCORE+1 size, it causes out of bounds array access.

The issues can be relatively easily reproduced like below.  The sysfs
write permission is required, though.

    # ./damo start --damos_action lru_prio --damos_quota_space 100M \
            --damos_quota_interval 1s
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/0/monitoring_attrs/intervals/sample_us
    # echo 0 > contexts/0/monitoring_attrs/intervals/aggr_us
    # echo commit > state
    # dmesg
    [...]
    [  131.329762] Oops: divide error: 0000 [#1] SMP NOPTI
    [...]
    [  131.336089] RIP: 0010:damon_hot_score+0x27/0xd0
    [...]

Fix the divide-by-zero intervals problems by explicitly handling the zero
intervals in damon_max_nr_accesses().  Fix the out-of-bound array access
by applying [0, DAMOS_MAX_SCORE] bounds before returning from
damon_hot_score().

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260623135834.67189-1-sj@kernel.org
Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org [1]
Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/damon.h |    8 ++++++--
 mm/damon/ops-common.c |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/linux/damon.h~mm-damon-ops-common-handle-extreme-intervals-in-damon_hot_score
+++ a/include/linux/damon.h
@@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(
 
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
-	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
+	unsigned long sample_interval;
+	unsigned long max_nr_accesses;
+
+	sample_interval = attrs->sample_interval ? : 1;
+	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
+	return max_nr_accesses ? : 1;
 }
 
 
--- a/mm/damon/ops-common.c~mm-damon-ops-common-handle-extreme-intervals-in-damon_hot_score
+++ a/mm/damon/ops-common.c
@@ -143,6 +143,7 @@ int damon_hot_score(struct damon_ctx *c,
 	 * Transform it to fit in [0, DAMOS_MAX_SCORE]
 	 */
 	hotness = hotness * DAMOS_MAX_SCORE / DAMON_MAX_SUBSCORE;
+	hotness = max(min(hotness, DAMOS_MAX_SCORE), 0);
 
 	return hotness;
 }
_

Patches currently in -mm which might be from sj@kernel.org are

maintainers-s-seongjae-sj.patch
mm-damon-core-validate-ranges-in-damon_set_regions.patch
samples-damon-wsse-handle-damon_start-failure.patch
samples-damon-prcl-handle-damon_start-failure.patch
samples-damon-mtier-handle-damon_start-failure.patch
samples-damon-mtier-handle-damon_stop-failure.patch
samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails.patch
samples-damon-prcl-stop-and-free-damon-ctx-when-damon_call-fails.patch
mm-damon-sysfs-kobject_del-target-normal-context-and-kdamond-dirs.patch
mm-damon-sysfs-kobject_del-region-and-target-error-dirs.patch
mm-damon-sysfs-schemes-kobject_del-scheme-dirs.patch
mm-damon-sysfs-schemes-kobject_del-scheme-region-dirs.patch
mm-damon-sysfs-schemes-kobject_del-scheme-filter-dirs.patch
mm-damon-sysfs-schemes-kobject_del-scheme-quota-goal-dirs.patch
mm-damon-sysfs-schemes-kobject_del-scheme-action-destination-dirs.patch
mm-damon-sysfs-kobject_del-probe-dirs.patch
mm-damon-sysfs-kobject_del-probe-filter-dirs.patch
mm-damon-sysfs-kobject_del-probe-dirs-in-probes_addd_dir-error-path.patch
mm-damon-sysfs-schemes-kobject_del-region-for-populate_region-error.patch
docs-mm-damon-design-update-for-damos_quota_node_eligible_mem_bp.patch
docs-abi-damon-document-probe-files.patch
mm-damon-tests-core-kunit-test-damon_rand.patch
selftests-damon-sysfssh-test-multiple-probe-dirs-creation.patch
selftests-damon-sysfssh-test-coreops_filters-directories.patch
selftests-damon-sysfssh-test-dests-dir.patch
selftests-damon-sysfssh-test-all-files-in-quota-goal-dir.patch
mm-damon-core-reduce-range-setup-in-damon_commit_target_regions.patch
mm-damon-sysfs-split-probe-setup-function-out.patch
mm-damon-sysfs-split-out-filters-setup-function.patch
mm-damon-sysfs-fix-typos-in-probe_addrm_dirs-s-attr-probe.patch
mm-damon-core-introduce-damon_nr_accesses_mvsum.patch
mm-damon-tests-core-kunit-test-damon_mvsum.patch
mm-damon-core-always-update-last_nr_accesses-for-intervals-change.patch
mm-damon-core-handle-unreset-nr_accesses-in-damon_nr_accesses_mvsum.patch
mm-damon-core-use-damon_nr_accesses_mvsum-in-__damos_valid_target.patch
mm-damon-core-use-damon_nr_accesses_mvsum-for-damos-region-tracing.patch
mm-damon-sysfs-schemes-use-damon_nr_accesses_mvsum-for-damo-regions.patch
mm-damon-core-remove-damon_warn_fix_nr_accesses_corruption.patch
mm-damon-core-remove-damon_verify_reset_aggregated.patch
mm-damon-core-remove-damon_verify_merge_regions_of.patch
mm-damon-tests-core-kunit-remove-nr_accesses_bp-setup-and-tests.patch
selftests-damon-drgn_dump_damon_status-do-not-dump-nr_accesses_bp.patch
mm-damon-core-remove-nr_accesses_bp-setups-and-updates.patch
mm-damon-core-remove-attrs-param-from-damon_update_region_access_rate.patch
mm-damon-paddr-remove-attrs-param-from-__damon_pa_check_access.patch
mm-damon-vaddr-remove-attrs-param-from-__damon_va_check_access.patch
mm-damon-core-remove-damon_moving_sum-and-its-unit-test.patch
mm-damon-core-remove-damon_region-nr_accesses_bp.patch


