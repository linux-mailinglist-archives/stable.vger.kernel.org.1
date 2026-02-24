Return-Path: <stable+bounces-217978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLWMI/kbnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB54C18CE7C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C04303A909
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0A298CC7;
	Tue, 24 Feb 2026 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qGUOcby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3D271464
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969526; cv=none; b=JOHRSK7wAqMK04Gnyra5Vxt7M2TmhpTsG5GWItCuDbGT0dkPamlDE3iDT2Jir5qaMvFxbx3JLCq059dA3g6yurUIEP16XCv7C1iw545j0sfjqJKj61EDLR9H0p6D+vylwB+MtVq4qGsx9EITo8zP+0A6pskWHCzZrOOqMohezS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969526; c=relaxed/simple;
	bh=qv/dshWwTYz07d5lw4nKmcugQCX79T0JBIJQzIVq7ec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K4/SS2/czrCIgA00Skj5gSChlstjciXcujThJ/BytpxtQronwQFQrudzHuCBOHWj8oom1jXx/Ww0Z+54/3+t4EWPha3Fvfi/NGGJfPhhDAydo4GNNkIa+pSnLDdW1PrGRH4uiz1Jtp0HnI8H6u4+LUsUeJFo5v7QbZGrUnYt0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qGUOcby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3382FC116D0;
	Tue, 24 Feb 2026 21:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969526;
	bh=qv/dshWwTYz07d5lw4nKmcugQCX79T0JBIJQzIVq7ec=;
	h=Subject:To:Cc:From:Date:From;
	b=0qGUOcbydsEvvv4An9oZZUrHNtNRH1R7mNdIyc1WwM+zyEgYCyRqpY3/V18a+zT64
	 PNd3SrVXnbzinsPourZ6cqNxRIzXEm7w68BesmQBNvHvH6HbOxHXVI8AiS+ZntK8V/
	 V1hzzGzdnCVh62DxhJU6oLav9IF7OcvGK97hoArs=
Subject: FAILED: patch "[PATCH] ext4: fix dirtyclusters double decrement on fs shutdown" failed to apply to 6.6-stable tree
To: bfoster@redhat.com,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:45:19 -0800
Message-ID: <2026022419-resonate-expanse-908a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217978-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,huawei.com:email,msgid.link:url]
X-Rspamd-Queue-Id: EB54C18CE7C
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 94a8cea54cd935c54fa2fba70354757c0fc245e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022419-resonate-expanse-908a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94a8cea54cd935c54fa2fba70354757c0fc245e3 Mon Sep 17 00:00:00 2001
From: Brian Foster <bfoster@redhat.com>
Date: Tue, 13 Jan 2026 12:19:05 -0500
Subject: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown

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

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index a9416b20ff64..4abb40d4561c 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -567,7 +567,7 @@ test_mark_diskspace_used_range(struct kunit *test,
 
 	bitmap = mbt_ctx_bitmap(sb, TEST_GOAL_GROUP);
 	memset(bitmap, 0, sb->s_blocksize);
-	ret = ext4_mb_mark_diskspace_used(ac, NULL, 0);
+	ret = ext4_mb_mark_diskspace_used(ac, NULL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	max = EXT4_CLUSTERS_PER_GROUP(sb);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index de4cacb740b3..dd29558ad753 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4186,8 +4186,7 @@ ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
  * Returns 0 if success or error code
  */
 static noinline_for_stack int
-ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
-				handle_t *handle, unsigned int reserv_clstrs)
+ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac, handle_t *handle)
 {
 	struct ext4_group_desc *gdp;
 	struct ext4_sb_info *sbi;
@@ -4242,13 +4241,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	BUG_ON(changed != ac->ac_b_ex.fe_len);
 #endif
 	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
-	/*
-	 * Now reduce the dirty block count also. Should not go negative
-	 */
-	if (!(ac->ac_flags & EXT4_MB_DELALLOC_RESERVED))
-		/* release all the reserved blocks if non delalloc */
-		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
-				   reserv_clstrs);
 
 	return err;
 }
@@ -6333,7 +6325,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
-		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
+		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
 			goto errout;
@@ -6364,12 +6356,9 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 out:
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
 


