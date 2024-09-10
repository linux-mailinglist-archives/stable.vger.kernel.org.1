Return-Path: <stable+bounces-75545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC1297359C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A214B2331F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475AD18DF72;
	Tue, 10 Sep 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCl2Doim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC85381A;
	Tue, 10 Sep 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965049; cv=none; b=cUKMMlVozweJ6se2wcQyPPD/r6BAkpBKN0mJ6ffoHaaPxiEJIFyXFcEtDlNnf3QTbpk6hd87bTF+9RgTLzvD7WQQ1CHJykyeZjFzHkuwkfFFh7uqvChkbSAyxdALnNnEy+PRbuGBEuxPFeC17jqmD8QKdYkhaWZPcnmeuUN0L4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965049; c=relaxed/simple;
	bh=8B+C0CNXF7qZu44/5rhPUpRRKxUlVYU00KawDhZi51g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsDbzOCB+ZjSUT7MnW+6R6EYwbE4m6OXJdXxOSN+ex0g/7QKJlr8lISRNjBoqO0fU7OXKmgfJ9u6Rq3caGDrNePETlz9qGf/M574/qjXoQ7hT8E6o7QbxZzIsGgnzqBDbDWMtG7iVowV+w43i4uILWpf3vR9OfH+VpKEQg7byC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCl2Doim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D88DC4CEC3;
	Tue, 10 Sep 2024 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965048;
	bh=8B+C0CNXF7qZu44/5rhPUpRRKxUlVYU00KawDhZi51g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xCl2Doim7W2N5640q7hk4AiTKbDcCjeVbrT2QLxjfr0Tn7mNDMIx0A/g2+q/jCsrA
	 H3kHd31IXLREqaD7e8EDV3jUYgFtYxHKc0in82cVtz5JoSKsy++o17qEKW3Ka0i38V
	 DHhKfG+nmiQa55RqYZpdGh7Vcl2huMLERtkx4IxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10 092/186] nfsd: rename NFSD_NET_* to NFSD_STATS_*
Date: Tue, 10 Sep 2024 11:33:07 +0200
Message-ID: <20240910092558.301458534@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit d98416cc2154053950610bb6880911e3dcbdf8c5 ]

We're going to merge the stats all into per network namespace in
subsequent patches, rename these nn counters to be consistent with the
rest of the stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/netns.h    |    4 ++--
 fs/nfsd/nfscache.c |    4 ++--
 fs/nfsd/stats.h    |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -25,9 +25,9 @@ struct nfsd4_client_tracking_ops;
 
 enum {
 	/* cache misses due only to checksum comparison failures */
-	NFSD_NET_PAYLOAD_MISSES,
+	NFSD_STATS_PAYLOAD_MISSES,
 	/* amount of memory (in bytes) currently consumed by the DRC */
-	NFSD_NET_DRC_MEM_USAGE,
+	NFSD_STATS_DRC_MEM_USAGE,
 	NFSD_NET_COUNTERS_NUM
 };
 
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -673,7 +673,7 @@ int nfsd_reply_cache_stats_show(struct s
 		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
 	seq_printf(m, "mem usage:             %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
@@ -681,7 +681,7 @@ int nfsd_reply_cache_stats_show(struct s
 	seq_printf(m, "not cached:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
 	seq_printf(m, "payload misses:        %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -80,17 +80,17 @@ static inline void nfsd_stats_io_write_a
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]);
 }
 
 static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_sub(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 #endif /* _NFSD_STATS_H */



