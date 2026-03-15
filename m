Return-Path: <stable+bounces-225484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JpHOeIFt2mKLgEAu9opvQ
	(envelope-from <stable+bounces-225484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 20:17:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC029236C
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC0A30107EE
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA11372689;
	Sun, 15 Mar 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL/9PmUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB001EFFB7;
	Sun, 15 Mar 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773602269; cv=none; b=CCjKG78mgYk3I1aNxfW89W0i0Y1Wb7IDjKr+LIhTli78NYC49RHnxa3lLjsPhLr7E5zHxIztaoNjyJRaxpRxrELjve6nnzU4j5vdaNezbbh8iBkGfe0EvjXChUwmhq/SNWxaYhP2af0Rj3x7XOloyOjSBlY6scgeNXdnSVieNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773602269; c=relaxed/simple;
	bh=lnmezolbS9hPqh6D5aE6eJP3t19p6P+GRKf1MW+dOjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/bsIezgPaHHBAywHeRbHKQIwH4xy4V5swMsTSURkvd5m0PNb26MH2waIQXqHWqQ71I0tu02ax0r+kE3lY9RwYql2ExXYjY7eNMlAcd9ihocD0i6bjltt+4WsPZ8+ueg+Rosf22OAxcQ5fFONvUPByarVeedOtto7ja9E1ZWAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL/9PmUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85299C4CEF7;
	Sun, 15 Mar 2026 19:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773602268;
	bh=lnmezolbS9hPqh6D5aE6eJP3t19p6P+GRKf1MW+dOjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZL/9PmUtoKntf0zCvjFDx8vgOM00T8LuhM3lw7fxsGtBty+RhVV6BFVhTn5CbwLW6
	 GNEkIFHzn8YIVi/EM8H5c+YTbMT6n81G/7v+Q8glLjiEDd2mPBYPrMXzDUUXTtk1EL
	 VlGaPoF3xHbrKkYQxsQjTobxdeQYmvVZXCsugB6HrJA4cSLA4O3KT/X6L85mBgDF9m
	 UG7UU8oqHu3HcYAxNLsLB2J6PMXEiTDoJHzXMnmmW8rcisnMlfWwoM/HDOxYN2wyxI
	 yTrh2nn3Iopxrokme22Re8eTwOPlRiHRhx4wVCSIXrm8BDftTskZM61yJVgxGdAOSq
	 rhkDx5DiQ12yA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/stat: monitor all System RAM resources
Date: Sun, 15 Mar 2026 12:17:40 -0700
Message-ID: <20260315191741.88931-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315162717.80870-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225484-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 4EDC029236C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 09:27:15 -0700 SeongJae Park <sj@kernel.org> wrote:

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

sashiko.dev adds [1] below comment:

'''
Does this single bounding box incorrectly include unpopulated address gaps
between discrete System RAM resources?

On systems with non-contiguous physical memory, such as NUMA architectures,
there can be massive physical address gaps between memory nodes. By coalescing
all resources into a single addr_range and passing nr_ranges = 1 to
damon_set_regions(), DAMON treats these unpopulated gaps as part of the
monitored memory.

This appears to artificially inflate total_sz in
damon_stat_set_idletime_percentiles(), where the gap could completely
dominate the distribution and skew the percentiles to report that nearly
100% of memory is permanently idle.

Could this also wildly inflate estimated_memory_bandwidth in
damon_stat_set_estimated_memory_bandwidth() if an adaptive DAMON region
bridges valid RAM and a physical gap? The size (r->ar.end - r->ar.start)
would be massively inflated and multiplied by nr_accesses.

Would it be better to collect all discrete System RAM resources into an
array of struct damon_addr_range and pass them to damon_set_regions() using
the actual number of ranges?
'''

My answer is no.  It is an intended behavior and no negative impact is
expected.  I think the reason is in the patch description.  If any human needs
more clarifications about this, please let me know.

[1] https://sashiko.dev/#/patchset/20260315162717.80870-1-sj@kernel.org


Thanks,
SJ

[...]

