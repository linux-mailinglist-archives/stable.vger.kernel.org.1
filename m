Return-Path: <stable+bounces-57493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D908925DC6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27D8B3BB21
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693931891D6;
	Wed,  3 Jul 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uchv6iYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272661891B9;
	Wed,  3 Jul 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005049; cv=none; b=ioOoBl+d+AUq1ZFv57KXkKCepAyvljaT0TGP6t6U1rBN/IpRtDKZERK1jw1bqTZPNE/Y2S4WQ7pUY4HdSKqMZ1HWg6exjBOx4a9l2HnXxLz++fA+kCbP9RBxzrC6153EQaNTkS0PPsMeUQCdrf07zcxXeXhknaVmHiVXibfgO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005049; c=relaxed/simple;
	bh=nSnCfQfWCrj7MZdSlCI/fIUBurOwRf2yQ/OxJr+ZA8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwbDkceYhte+JYYfIh52Wp463GYFAN+SrJvHLzXBQ8Ly2+5A0UvOzXhjO3mDyvgTZoi8i74cjN1Z969IQ61OXldXntWeOuMqPdA5an+JE3hLvGC9e3XRmIEX61FYVqZF+eGyJUk+9Qe4BMpM+I1JPtT0AnOsp1s5YrbmvuRo6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uchv6iYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422F8C2BD10;
	Wed,  3 Jul 2024 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005048;
	bh=nSnCfQfWCrj7MZdSlCI/fIUBurOwRf2yQ/OxJr+ZA8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uchv6iYFQMWFO3/6IzI9pv/fsSKfDgi1lrFcV6IMi1kwk8bXpCc3Mv+pj2X9o/58W
	 4McDToXF4C/0Wa6dkjdguYcawfouQK8mVPGp3oVUEUwUAWdX1eaUL48XAgUWOxc0rZ
	 jsMCHcTeiESWbZPHC7/QuFdexyILQpA9S3scx4XU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Changwei Ge <gechangwei@live.cn>,
	Gang He <ghe@suse.com>,
	Jun Piao <piaojun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 243/290] ocfs2: fix DIO failure due to insufficient transaction credits
Date: Wed,  3 Jul 2024 12:40:24 +0200
Message-ID: <20240703102913.331491963@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit be346c1a6eeb49d8fda827d2a9522124c2f72f36 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/aops.c        |    5 +++++
 fs/ocfs2/journal.c     |   17 +++++++++++++++++
 fs/ocfs2/journal.h     |    2 ++
 fs/ocfs2/ocfs2_trace.h |    2 ++
 4 files changed, 26 insertions(+)

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2373,6 +2373,11 @@ static int ocfs2_dio_end_io_write(struct
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
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -450,6 +450,23 @@ bail:
 }
 
 /*
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
+/*
  * If we have fewer than thresh credits, extend by OCFS2_MAX_TRANS_DATA.
  * If that fails, restart the transaction & regain write access for the
  * buffer head which is used for metadata modifications.
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -244,6 +244,8 @@ handle_t		    *ocfs2_start_trans(struct
 int			     ocfs2_commit_trans(struct ocfs2_super *osb,
 						handle_t *handle);
 int			     ocfs2_extend_trans(handle_t *handle, int nblocks);
+int			     ocfs2_assure_trans_credits(handle_t *handle,
+						int nblocks);
 int			     ocfs2_allocate_extend_trans(handle_t *handle,
 						int thresh);
 
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -2578,6 +2578,8 @@ DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_commit
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_extend_trans);
 
+DEFINE_OCFS2_INT_EVENT(ocfs2_assure_trans_credits);
+
 DEFINE_OCFS2_INT_EVENT(ocfs2_extend_trans_restart);
 
 DEFINE_OCFS2_INT_INT_EVENT(ocfs2_allocate_extend_trans);



