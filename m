Return-Path: <stable+bounces-214884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPe2Lz2CiWkg+QQAu9opvQ
	(envelope-from <stable+bounces-214884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 07:44:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292AF10C31F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 07:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D28A30062DE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3430FC0A;
	Mon,  9 Feb 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gk4IK5zD"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D58176FB1;
	Mon,  9 Feb 2026 06:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619447; cv=none; b=jEx2zkPtV6UqzTR1o4jmYMDzHCHNwlbksEnP5ohMMPrLXQnbQknt2uNWQUOc21ll8TzvhUkNZSDTeHMs4RKOD9DqpxbQLH/ASa2/To8eaKPxmmVb9eTbd+yOfHcV3EVxO6KxMI2nHaOPN8ucqhqf0RHLBPzXIdz+IV3pVU0J7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619447; c=relaxed/simple;
	bh=tcS9dOGPIVKdw2PRy6hrOK5m20Ybb/O5DexFXdS7eZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjdToz5mRihiMcgd4YKyqLnIr/+KfRAObk8+9WEtu9MzbcFvP7oj5cWWGDjwfe68K98SAnBq080TaCvOoT1/smuseQ80D5eAl68l9KroaTCH96HgqLVoRvEkAIr+y6RV8pIax2QFXbxe64OaLUrqpQ10d626U+VpfcKamZvaRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gk4IK5zD; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GD
	puaZDxFVdIR5XCpiwOISUf173r8Fq/huCbbthjHiI=; b=gk4IK5zD34xzRd2lFD
	oATTTCp0yVWpW6SnybMPy2sVp1dLQstHYevFgcOFATFsW1PaugEcXbjskAKb926E
	NQLf+YIGHUfe2EgwgqUD+NJImt0OzXThicr7g2sjD6UUdt6B3CBPCWAzbb8fnKul
	AAjdML4s55cgJ4p6a62oKTBtQ=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXlPkTgolpYcNILA--.24663S2;
	Mon, 09 Feb 2026 14:43:32 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] btrfs: fix racy bitfield write in btrfs_clear_space_info_full()
Date: Mon,  9 Feb 2026 14:43:31 +0800
Message-Id: <20260209064331.1748206-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXlPkTgolpYcNILA--.24663S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4UKr1ruFy7AF4kCF1rJFb_yoWfurWkpr
	Wa9r9Iyw4kJFn5Wr4kWw4kXa1fKwn5W3W5tr9xA3WrZrn8Grn8WrWqka4FvF1ktrn5XF4a
	qF4UGr15XF15C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziRuWdUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3hRi+2mJghTJhQAA3p
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214884-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,bur.io,suse.com,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 292AF10C31F
X-Rspamd-Action: no action

From: Boris Burkov <boris@bur.io>

[ Upstream commit 38e818718c5e04961eea0fa8feff3f100ce40408 ]

From the memory-barriers.txt document regarding memory barrier ordering
guarantees:

 (*) These guarantees do not apply to bitfields, because compilers often
     generate code to modify these using non-atomic read-modify-write
     sequences.  Do not attempt to use bitfields to synchronize parallel
     algorithms.

 (*) Even in cases where bitfields are protected by locks, all fields
     in a given bitfield must be protected by one lock.  If two fields
     in a given bitfield are protected by different locks, the compiler's
     non-atomic read-modify-write sequences can cause an update to one
     field to corrupt the value of an adjacent field.

btrfs_space_info has a bitfield sharing an underlying word consisting of
the fields full, chunk_alloc, and flush:

struct btrfs_space_info {
        struct btrfs_fs_info *     fs_info;              /*     0     8 */
        struct btrfs_space_info *  parent;               /*     8     8 */
        ...
        int                        clamp;                /*   172     4 */
        unsigned int               full:1;               /*   176: 0  4 */
        unsigned int               chunk_alloc:1;        /*   176: 1  4 */
        unsigned int               flush:1;              /*   176: 2  4 */
        ...

Therefore, to be safe from parallel read-modify-writes losing a write to
one of the bitfield members protected by a lock, all writes to all the
bitfields must use the lock. They almost universally do, except for
btrfs_clear_space_info_full() which iterates over the space_infos and
writes out found->full = 0 without a lock.

Imagine that we have one thread completing a transaction in which we
finished deleting a block_group and are thus calling
btrfs_clear_space_info_full() while simultaneously the data reclaim
ticket infrastructure is running do_async_reclaim_data_space():

          T1                                             T2
btrfs_commit_transaction
  btrfs_clear_space_info_full
  data_sinfo->full = 0
  READ: full:0, chunk_alloc:0, flush:1
                                              do_async_reclaim_data_space(data_sinfo)
                                              spin_lock(&space_info->lock);
                                              if(list_empty(tickets))
                                                space_info->flush = 0;
                                                READ: full: 0, chunk_alloc:0, flush:1
                                                MOD/WRITE: full: 0, chunk_alloc:0, flush:0
                                                spin_unlock(&space_info->lock);
                                                return;
  MOD/WRITE: full:0, chunk_alloc:0, flush:1

and now data_sinfo->flush is 1 but the reclaim worker has exited. This
breaks the invariant that flush is 0 iff there is no work queued or
running. Once this invariant is violated, future allocations that go
into __reserve_bytes() will add tickets to space_info->tickets but will
see space_info->flush is set to 1 and not queue the work. After this,
they will block forever on the resulting ticket, as it is now impossible
to kick the worker again.

I also confirmed by looking at the assembly of the affected kernel that
it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
the assembly is:
  andb    $0xfb,0x60(%rbx)
and similarly for setting the full (1st) bit to 0:
  andb    $0xfe,-0x20(%rax)

So I think this is really a bug on practical systems.  I have observed
a number of systems in this exact state, but am currently unable to
reproduce it.

Rather than leaving this footgun lying around for the future, take
advantage of the fact that there is room in the struct anyway, and that
it is already quite large and simply change the three bitfield members to
bools. This avoids writes to space_info->full having any effect on
writes to space_info->flush, regardless of locking.

Fixes: 957780eb2788 ("Btrfs: introduce ticketed enospc infrastructure")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ The context change is due to the commit cc0517fe779f
("btrfs: tweak extent/chunk allocation for space_info sub-space")
in v6.16 which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/btrfs/block-group.c |  6 +++---
 fs/btrfs/space-info.c  | 22 +++++++++++-----------
 fs/btrfs/space-info.h  |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2dda388c9853..a08e03a74909 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4156,7 +4156,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			mutex_unlock(&fs_info->chunk_mutex);
 		} else {
 			/* Proceed with allocation */
-			space_info->chunk_alloc = 1;
+			space_info->chunk_alloc = true;
 			wait_for_alloc = false;
 			spin_unlock(&space_info->lock);
 		}
@@ -4205,7 +4205,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	spin_lock(&space_info->lock);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
-			space_info->full = 1;
+			space_info->full = true;
 		else
 			goto out;
 	} else {
@@ -4215,7 +4215,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
 out:
-	space_info->chunk_alloc = 0;
+	space_info->chunk_alloc = false;
 	spin_unlock(&space_info->lock);
 	mutex_unlock(&fs_info->chunk_mutex);
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 00d596a8176f..12f8f55bb993 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -182,7 +182,7 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	struct btrfs_space_info *found;
 
 	list_for_each_entry(found, head, list)
-		found->full = 0;
+		found->full = false;
 }
 
 /*
@@ -361,7 +361,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_readonly += block_group->bytes_super;
 	btrfs_space_info_update_bytes_zone_unusable(info, found, block_group->zone_unusable);
 	if (block_group->length > 0)
-		found->full = 0;
+		found->full = false;
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
 
@@ -1103,7 +1103,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
 	if (!to_reclaim) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1115,7 +1115,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 		flush_space(fs_info, space_info, to_reclaim, flush_state, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1158,7 +1158,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
-					space_info->flush = 0;
+					space_info->flush = false;
 				}
 			} else {
 				flush_state = FLUSH_DELAYED_ITEMS_NR;
@@ -1320,7 +1320,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 	spin_lock(&space_info->lock);
 	if (list_empty(&space_info->tickets)) {
-		space_info->flush = 0;
+		space_info->flush = false;
 		spin_unlock(&space_info->lock);
 		return;
 	}
@@ -1331,7 +1331,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1348,7 +1348,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
-			space_info->flush = 0;
+			space_info->flush = false;
 			spin_unlock(&space_info->lock);
 			return;
 		}
@@ -1365,7 +1365,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 				if (maybe_fail_all_tickets(fs_info, space_info))
 					flush_state = 0;
 				else
-					space_info->flush = 0;
+					space_info->flush = false;
 			} else {
 				flush_state = 0;
 			}
@@ -1381,7 +1381,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 aborted_fs:
 	maybe_fail_all_tickets(fs_info, space_info);
-	space_info->flush = 0;
+	space_info->flush = false;
 	spin_unlock(&space_info->lock);
 }
 
@@ -1750,7 +1750,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 				 */
 				maybe_clamp_preempt(fs_info, space_info);
 
-				space_info->flush = 1;
+				space_info->flush = true;
 				trace_btrfs_trigger_flush(fs_info,
 							  space_info->flags,
 							  orig_bytes, flush,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0670f074902d..6b93974a75a2 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -126,11 +126,11 @@ struct btrfs_space_info {
 				   flushing. The value is >> clamp, so turns
 				   out to be a 2^clamp divisor. */
 
-	unsigned int full:1;	/* indicates that we cannot allocate any more
+	bool full;		/* indicates that we cannot allocate any more
 				   chunks for this space */
-	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
+	bool chunk_alloc;	/* set if we are allocating a chunk */
 
-	unsigned int flush:1;		/* set if we are trying to make space */
+	bool flush;		/* set if we are trying to make space */
 
 	unsigned int force_alloc;	/* set if we need to force a chunk
 					   alloc for this space */
-- 
2.34.1


