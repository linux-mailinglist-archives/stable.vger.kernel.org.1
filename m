Return-Path: <stable+bounces-249966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBDJBU/NDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:03:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E55906D5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 349DF31D4A33
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A96365A13;
	Wed, 20 May 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qWJ06hh+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616593E95B3
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288044; cv=none; b=XL9D0sb3nBstbEHVV1T7WxS+pNcXl7KFDQ0gDOw1UoSJ5UX+vloucSTb/GJh/hIzElAGNoM57XI70QVIMrfV9VA/6EFYE/DWYQvrHgqnKhWlwgKGr8dF4cl64Ilnwt5tHfwURlpdzCnnpG+IW+malQEgHiwhGXFdOYstB8e3ULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288044; c=relaxed/simple;
	bh=rc0wxdFdGfFkfOWGvmaA5O5Q3LNrIPzW3c8XYXlvA1w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U8IP3HwoOgsoEHqzFX7IKuD/qWxmYkCuTOzK36OgR59MUakPUThe23iAMp8w5HcmBubS8PRvGDMC8qdNhMHhnQ6UwudxBuJYOJnStZS2YJi4NE6rOYJypNKh9LU0mdKitVefwFWkWCMnPlT53IYRkf1NnAcrGZs9ewgRtuPpNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qWJ06hh+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66AC1F000E9;
	Wed, 20 May 2026 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288043;
	bh=Nsh8J9jvl+HMc989dN9VWJbtKpymgSOjBJXEDPSMG88=;
	h=Subject:To:Cc:From:Date;
	b=qWJ06hh+wtJeRWyVQgSwwRE3pX3GL4oPu7dni2BUZ7W78yERgIpW1MDY/FTG37Iud
	 4htwfW7v/sVx42nh9lv8SOtLD7qCyQZjgeBqKg3uYpzjgmrny0mx9yrN3Hyvf2cI1p
	 O3yOw3H5CvHZLb+I9kyfPCtw+hCt+Bsgrw4T7bCI=
Subject: FAILED: patch "[PATCH] btrfs: only release the dirty pages io tree after successful" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:40:38 +0200
Message-ID: <2026052038-bullish-pregnant-98e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-249966-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,suse.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C01E55906D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4066c55e109475a06d18a1f127c939d551211956
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052038-bullish-pregnant-98e3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4066c55e109475a06d18a1f127c939d551211956 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Thu, 30 Apr 2026 10:37:22 +0930
Subject: [PATCH] btrfs: only release the dirty pages io tree after successful
 writes

[WARNING]
With extra warning on dirty extent buffers at umount (aka, the next
patch in the series), test case generic/388 can trigger the following
warning about dirty extent buffers at unmount time:

  BTRFS critical (device dm-2 state E): emergency shutdown
  BTRFS error (device dm-2 state E): error while writing out transaction: -30
  BTRFS warning (device dm-2 state E): Skipping commit of aborted transaction.
  BTRFS error (device dm-2 state EA): Transaction 9 aborted (error -30)
  BTRFS: error (device dm-2 state EA) in cleanup_transaction:2068: errno=-30 Readonly filesystem
  BTRFS info (device dm-2 state EA): forced readonly
  BTRFS info (device dm-2 state EA): last unmount of filesystem 4fbf2e15-f941-49a0-bc7c-716315d2777c
  ------------[ cut here ]------------
  WARNING: disk-io.c:3311 at invalidate_and_check_btree_folios+0xfd/0x1ca [btrfs], CPU#8: umount/914368
  CPU: 8 UID: 0 PID: 914368 Comm: umount Tainted: G           OE       7.1.0-rc1-custom+ #372 PREEMPT(full)  2de38db8d1deae71fde295430a0ff3ab98ccf596
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
  RIP: 0010:invalidate_and_check_btree_folios+0xfd/0x1ca [btrfs]
  Call Trace:
   <TASK>
   close_ctree+0x52e/0x574 [btrfs d2f0b1cd330d1287e7a9919d112eadfc0e914efd]
   generic_shutdown_super+0x89/0x1a0
   kill_anon_super+0x16/0x40
   btrfs_kill_super+0x16/0x20 [btrfs d2f0b1cd330d1287e7a9919d112eadfc0e914efd]
   deactivate_locked_super+0x2d/0xb0
   cleanup_mnt+0xdc/0x140
   task_work_run+0x5a/0xa0
   exit_to_user_mode_loop+0x123/0x4b0
   do_syscall_64+0x243/0x7c0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>
  ---[ end trace 0000000000000000 ]---
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30539776 owner 9 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30621696 owner 257 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30638080 owner 258 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30654464 owner 7 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30703616 owner 2 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30720000 owner 10 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30736384 owner 4 gen 9 refs 2 flags 0x7
  BTRFS warning (device dm-2 state EA): unable to release extent buffer 30752768 owner 11 gen 9 refs 2 flags 0x7

I'm using a stripped down version, which seems to trigger the warning
more reliably:

  _fsstress_pid=""
  workload()
  {
  	dmesg -C
  	mkfs.btrfs -f -K $dev > /dev/null
  	echo 1 > /sys/kernel/debug/clear_warn_once
  	mount $dev $mnt
  	$fsstress -w -n 1024 -p 4 -d $mnt &
  	_fsstress_pid=$!
  	sleep 0
  	$godown $mnt
  	pkill --echo -PIPE fsstress > /dev/null
  	wait $_fsstress_pid
  	unset _fsstress_pid
  	umount $mnt

  	if dmesg | grep -q "WARNING"; then
  		fail
  	fi
  }

  for (( i = 0; i < $runtime; i++ )); do
  	echo "=== $i/$runtime ==="
  	workload
  done

[CAUSE]
Inside btrfs_write_and_wait_transaction(), we first try to write all
dirty ebs, then wait for them to finish.

After that we call btrfs_extent_io_tree_release() to free all
extent states from dirty_pages io tree.

However if we hit an error from btrfs_write_marked_extent(), then we
still call btrfs_extent_io_tree_release() to clear that dirty_pages io
tree, which may contain dirty records that we haven't yet submitted.

Furthermore, the later transaction cleanup path will utilize that
dirty_pages io tree to properly cleanup those dirty ebs, but since it's
already empty, no dirty ebs are properly cleaned up, thus will later
trigger the warnings inside invalidate_btree_folios().

[FIX]
Normally such dirty ebs won't cause problems, as when the iput() is
called on the btree inode, the dirty ebs will be forcibly written back,
and since the fs is already in an error status, such writeback will not
reach disk and finish immediately.

But it's still better to get rid of such dirty ebs, if we ended up with
dirty ebs but the fs is not in an error status, then such writeback at
iput() time will be too late, as all workers are already stopped but
writeback will utilize workers, which will lead to NULL pointer
dereferences.

Instead of unconditionally calling btrfs_extent_io_tree_release(), only
call it if btrfs_write_and_wait_transaction() finished successfully, so
that @dirty_pages extent io tree is kept untouched for transaction
cleanup.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8a11be02eeb9..c0a30bb213d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4686,6 +4686,7 @@ static void btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 			free_extent_buffer_stale(eb);
 		}
 	}
+	btrfs_extent_io_tree_release(dirty_pages);
 }
 
 static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 248adb785051..194f581b36f3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1293,14 +1293,13 @@ static int btrfs_write_and_wait_transaction(struct btrfs_trans_handle *trans)
 	blk_finish_plug(&plug);
 	ret2 = btrfs_wait_extents(fs_info, dirty_pages);
 
-	btrfs_extent_io_tree_release(&trans->transaction->dirty_pages);
-
 	if (ret)
 		return ret;
-	else if (ret2)
+	if (ret2)
 		return ret2;
-	else
-		return 0;
+
+	btrfs_extent_io_tree_release(&trans->transaction->dirty_pages);
+	return 0;
 }
 
 /*


