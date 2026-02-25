Return-Path: <stable+bounces-219643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGK+IFgNn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:55:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 931611990A7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B0A6305D936
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D613ACEFF;
	Wed, 25 Feb 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjPXwUwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC93D3D1C
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031154; cv=none; b=jzAh1KbnQ/XiEh4FsWlO8C5t6gKAZ8g73kG5Euz5PbGVWOwfqQWJ2/V4/ElsbPjb10Hl8RSmvC5+WL0Gv5ayH4uzdJcliJXUul6rImRYR7rsOQZeUqjP9sywTELTv+ozWkDJmYh2hznR/2+5iGNKfd1u461jeau9ykBSyYVgTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031154; c=relaxed/simple;
	bh=6yut/uymorE6TLTRey2GUBafQ46K3AhzMXmheKyKb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/RrRIiei9SJRrdSUupV6vnswF5GZjae9c+Vts+nJmPLnP45zbJrDMjPdy8Fza9OwF/OE8PgqVsZ4xAoCHWJTLdOmQfUYn2z62vcOyW+N4vIOw8zKfa0asyEDkCwsrzjh2qUpgvjjHOZkwFcsJ6j8Lqt9ibi7bncHwDNZhuOxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjPXwUwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE1C116D0;
	Wed, 25 Feb 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031154;
	bh=6yut/uymorE6TLTRey2GUBafQ46K3AhzMXmheKyKb9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjPXwUwaJu6JyqRgxP/qswfUaemqYjwz+WolxnYXSrIO95dXE6yQIT0TEk8D6xjEe
	 pa+pAWxF1fvT34JM/xGbXGjB2D+ruDLDeKZQOZ5o/5nCDb/iIbh9BzlpYmuJ8nWADI
	 5zzsIIeKrh33HTU27JmM+2b342ylrjZ6XNzvNZ13HdeBmqOD7XaF8Hvk5s8yroCm+g
	 jHYRrX+Oxl8YhIYfyHMdqVRhG55l19s8cthiIdim9jajZuySzkQsWt4Cfj87fmyFnX
	 YxxCeNUo63C1LACwMxolbnd13pqEdP+Goke6HTxPUYlsI1A2W+s+7mBPzV0ocDzAK/
	 9Vr1kW/EN9E5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Foster <bfoster@redhat.com>,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ext4: fix dirtyclusters double decrement on fs shutdown
Date: Wed, 25 Feb 2026 09:52:32 -0500
Message-ID: <20260225145232.546260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022422-deviancy-scanning-ca65@gregkh>
References: <2026022422-deviancy-scanning-ca65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219643-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 931611990A7
X-Rspamd-Action: no action

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 94a8cea54cd935c54fa2fba70354757c0fc245e3 ]

fstests test generic/388 occasionally reproduces a warning in
ext4_put_super() associated with the dirty clusters count:

  WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]

Tracing the failure shows that the warning fires due to an
s_dirtyclusters_counter value of -1. IOW, this appears to be a
spurious decrement as opposed to some sort of leak. Further tracing
of the dirty cluster count deltas and an LLM scan of the resulting
output identified the cause as a double decrement in the error path
between ext4_mb_mark_diskspace_used() and the caller
ext4_mb_new_blocks().

First, note that generic/388 is a shutdown vs. fsstress test and so
produces a random set of operations and shutdown injections. In the
problematic case, the shutdown triggers an error return from the
ext4_handle_dirty_metadata() call(s) made from
ext4_mb_mark_context(). The changed value is non-zero at this point,
so ext4_mb_mark_diskspace_used() does not exit after the error
bubbles up from ext4_mb_mark_context(). Instead, the former
decrements both cluster counters and returns the error up to
ext4_mb_new_blocks(). The latter falls into the !ar->len out path
which decrements the dirty clusters counter a second time, creating
the inconsistency.

To avoid this problem and simplify ownership of the cluster
reservation in this codepath, lift the counter reduction to a single
place in the caller. This makes it more clear that
ext4_mb_new_blocks() is responsible for acquiring cluster
reservation (via ext4_claim_free_clusters()) in the !delalloc case
as well as releasing it, regardless of whether it ends up consumed
or returned due to failure.

Fixes: 0087d9fb3f29 ("ext4: Fix s_dirty_blocks_counter if block allocation failed with nodelalloc")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20260113171905.118284-1-bfoster@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ Drop mballoc-test changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0fd921ada8973..e16f64daf1334 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3836,8 +3836,7 @@ void ext4_exit_mballoc(void)
  * Returns 0 if success or error code
  */
 static noinline_for_stack int
-ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
-				handle_t *handle, unsigned int reserv_clstrs)
+ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
@@ -3925,13 +3924,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 
 	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
-	/*
-	 * Now reduce the dirty block count also. Should not go negative
-	 */
-	if (!(ac->ac_flags & EXT4_MB_DELALLOC_RESERVED))
-		/* release all the reserved blocks if non delalloc */
-		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-				   reserv_clstrs);
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi,
@@ -5803,7 +5795,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
-		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
+		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
@@ -5835,12 +5827,9 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		kmem_cache_free(ext4_ac_cachep, ac);
 	if (inquota && ar->len < inquota)
 		dquot_free_block(ar->inode, EXT4_C2B(sbi, inquota - ar->len));
-	if (!ar->len) {
-		if ((ar->flags & EXT4_MB_DELALLOC_RESERVED) == 0)
-			/* release all the reserved blocks if non delalloc */
-			percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-						reserv_clstrs);
-	}
+	/* release any reserved blocks */
+	if (reserv_clstrs)
+		percpu_counter_sub(&sbi->s_dirtyclusters_counter, reserv_clstrs);
 
 	trace_ext4_allocate_blocks(ar, (unsigned long long)block);
 
-- 
2.51.0


