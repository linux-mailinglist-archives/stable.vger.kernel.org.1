Return-Path: <stable+bounces-56234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3591DFCC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988DAB21F1B
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335ED82D69;
	Mon,  1 Jul 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rw4zxMxN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF2811
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837994; cv=none; b=RgHq6GojXM+uPX89E114JIodWjhugy1FjqIxgXrKRYidytC7kkDfiNjTvUwptyfB0+jN4m1oHN7a/f14jQDLD4kiTdUk88kyDxUU5sLOQ+EsjNQFQKDmzD2MMK4h29HRxunmAnd/aSNZCgR6tVA2FjuwoxDbdFNjOADqx4DJdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837994; c=relaxed/simple;
	bh=ZvwuHGU+sCm8uY5kBm3KMLgJXjHvKNtjPHYBKNZXbcs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HGWl38514J/HCEc3rsjIsovQVXHjaRopodYu7xEguIQMRcCGGTAZJ9lKaOug/KbG++tndM64YFlP6S3VTvD38ESH6+s/7XTQe0/7MdGmPYImBIjXz7DhMKx8AmlJcFp2CwAJ2PGlrnLl4mv2soWHSWxS8hAyC126C+mXnvZQoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rw4zxMxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004CC32786;
	Mon,  1 Jul 2024 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837993;
	bh=ZvwuHGU+sCm8uY5kBm3KMLgJXjHvKNtjPHYBKNZXbcs=;
	h=Subject:To:Cc:From:Date:From;
	b=rw4zxMxNWx75nqGzNUdVm4FVhBLKrwg4JejVRXMJ6wlmNfaW/m6zZuYhgZu7Xj3Uv
	 9DNQz8EaggpBagJxJHUol37duMZC3p5qOqwJT2dJr/VHGRWdYfeVsNJnm88Tdfowrm
	 0uAOBPLrnkZ2pZfWhi8H4EtlrV7SIHKXg3wnlaYM=
Subject: FAILED: patch "[PATCH] ocfs2: fix DIO failure due to insufficient transaction" failed to apply to 4.19-stable tree
To: jack@suse.cz,akpm@linux-foundation.org,gechangwei@live.cn,ghe@suse.com,heming.zhao@suse.com,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,mark@fasheh.com,piaojun@huawei.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:33:45 +0200
Message-ID: <2024070144-deviancy-plop-e175@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x be346c1a6eeb49d8fda827d2a9522124c2f72f36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070144-deviancy-plop-e175@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

be346c1a6eeb ("ocfs2: fix DIO failure due to insufficient transaction credits")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be346c1a6eeb49d8fda827d2a9522124c2f72f36 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 14 Jun 2024 16:52:43 +0200
Subject: [PATCH] ocfs2: fix DIO failure due to insufficient transaction
 credits

The code in ocfs2_dio_end_io_write() estimates number of necessary
transaction credits using ocfs2_calc_extend_credits().  This however does
not take into account that the IO could be arbitrarily large and can
contain arbitrary number of extents.

Extent tree manipulations do often extend the current transaction but not
in all of the cases.  For example if we have only single block extents in
the tree, ocfs2_mark_extent_written() will end up calling
ocfs2_replace_extent_rec() all the time and we will never extend the
current transaction and eventually exhaust all the transaction credits if
the IO contains many single block extents.  Once that happens a
WARN_ON(jbd2_handle_buffer_credits(handle) <= 0) is triggered in
jbd2_journal_dirty_metadata() and subsequently OCFS2 aborts in response to
this error.  This was actually triggered by one of our customers on a
heavily fragmented OCFS2 filesystem.

To fix the issue make sure the transaction always has enough credits for
one extent insert before each call of ocfs2_mark_extent_written().

Heming Zhao said:

------
PANIC: "Kernel panic - not syncing: OCFS2: (device dm-1): panic forced after error"

PID: xxx  TASK: xxxx  CPU: 5  COMMAND: "SubmitThread-CA"
  #0 machine_kexec at ffffffff8c069932
  #1 __crash_kexec at ffffffff8c1338fa
  #2 panic at ffffffff8c1d69b9
  #3 ocfs2_handle_error at ffffffffc0c86c0c [ocfs2]
  #4 __ocfs2_abort at ffffffffc0c88387 [ocfs2]
  #5 ocfs2_journal_dirty at ffffffffc0c51e98 [ocfs2]
  #6 ocfs2_split_extent at ffffffffc0c27ea3 [ocfs2]
  #7 ocfs2_change_extent_flag at ffffffffc0c28053 [ocfs2]
  #8 ocfs2_mark_extent_written at ffffffffc0c28347 [ocfs2]
  #9 ocfs2_dio_end_io_write at ffffffffc0c2bef9 [ocfs2]
#10 ocfs2_dio_end_io at ffffffffc0c2c0f5 [ocfs2]
#11 dio_complete at ffffffff8c2b9fa7
#12 do_blockdev_direct_IO at ffffffff8c2bc09f
#13 ocfs2_direct_IO at ffffffffc0c2b653 [ocfs2]
#14 generic_file_direct_write at ffffffff8c1dcf14
#15 __generic_file_write_iter at ffffffff8c1dd07b
#16 ocfs2_file_write_iter at ffffffffc0c49f1f [ocfs2]
#17 aio_write at ffffffff8c2cc72e
#18 kmem_cache_alloc at ffffffff8c248dde
#19 do_io_submit at ffffffff8c2ccada
#20 do_syscall_64 at ffffffff8c004984
#21 entry_SYSCALL_64_after_hwframe at ffffffff8c8000ba

Link: https://lkml.kernel.org/r/20240617095543.6971-1-jack@suse.cz
Link: https://lkml.kernel.org/r/20240614145243.8837-1-jack@suse.cz
Fixes: c15471f79506 ("ocfs2: fix sparse file & data ordering issue in direct io")
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index f0467d3b3c88..6be175a1ab3c 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2366,6 +2366,11 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 	}
 
 	list_for_each_entry(ue, &dwc->dw_zero_list, ue_node) {
+		ret = ocfs2_assure_trans_credits(handle, credits);
+		if (ret < 0) {
+			mlog_errno(ret);
+			break;
+		}
 		ret = ocfs2_mark_extent_written(inode, &et, handle,
 						ue->ue_cpos, 1,
 						ue->ue_phys,
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 86807086b2df..530fba34f6d3 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -445,6 +445,23 @@ int ocfs2_extend_trans(handle_t *handle, int nblocks)
 	return status;
 }
 
+/*
+ * Make sure handle has at least 'nblocks' credits available. If it does not
+ * have that many credits available, we will try to extend the handle to have
+ * enough credits. If that fails, we will restart transaction to have enough
+ * credits. Similar notes regarding data consistency and locking implications
+ * as for ocfs2_extend_trans() apply here.
+ */
+int ocfs2_assure_trans_credits(handle_t *handle, int nblocks)
+{
+	int old_nblks = jbd2_handle_buffer_credits(handle);
+
+	trace_ocfs2_assure_trans_credits(old_nblks);
+	if (old_nblks >= nblocks)
+		return 0;
+	return ocfs2_extend_trans(handle, nblocks - old_nblks);
+}
+
 /*
  * If we have fewer than thresh credits, extend by OCFS2_MAX_TRANS_DATA.
  * If that fails, restart the transaction & regain write access for the
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 41c9fe7e62f9..e3c3a35dc5e0 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -243,6 +243,8 @@ handle_t		    *ocfs2_start_trans(struct ocfs2_super *osb,
 int			     ocfs2_commit_trans(struct ocfs2_super *osb,
 						handle_t *handle);
 int			     ocfs2_extend_trans(handle_t *handle, int nblocks);
+int			     ocfs2_assure_trans_credits(handle_t *handle,
+						int nblocks);
 int			     ocfs2_allocate_extend_trans(handle_t *handle,
 						int thresh);
 
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 60e208b01c8d..0511c69c9fde 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -2577,6 +2577,8 @@ DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_commit_cache_end);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_extend_trans);
 
+DEFINE_OCFS2_INT_EVENT(ocfs2_assure_trans_credits);
+
 DEFINE_OCFS2_INT_EVENT(ocfs2_extend_trans_restart);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_allocate_extend_trans);


