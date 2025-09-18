Return-Path: <stable+bounces-174121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5CB3616C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA6B1881F36
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B54299959;
	Tue, 26 Aug 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u1TazvvM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73927243946;
	Tue, 26 Aug 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213549; cv=none; b=pE9Ppvbrxnug+rjhV8dJE3zNHLK0wZLrPl7/uNulMftDb5zT36Wi0so6uhOaLhR3QaBagnfkgWLATirVAOMe4DsQZnLZwIc9v23Gj+qvldYmtEtCNXAnMjePgZMeBtbliV/9Y9hCoPapG9OFe8kV6/k35hGQ8IM3NsqfkGhxDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213549; c=relaxed/simple;
	bh=diJnoiesu62q3glIOGZ7Cq30RqS326sVTqMBsVfysO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf9Kz+AQqupIWN7bTPiWGn1rQVUZFkemBpYYEr4njwVTIuIbB3mvYGYPKgpVfoMwWpAT16Z8dqfYghDKmmgPZNG5RDZdXdMiC2vYQIDF2BigXuvqzQTrCwybxm2wRcRzufx/YeVeIT1UFAITMUQhrL4hFvdwfc0K3DC9P6hu5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u1TazvvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EF0C4CEF1;
	Tue, 26 Aug 2025 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213549;
	bh=diJnoiesu62q3glIOGZ7Cq30RqS326sVTqMBsVfysO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1TazvvMvQ/x00VdNt1bp6ijEdKlT3u3JjraTSwIilWyJ0xs/MUF1jxng3HYiGsll
	 vZfJuOzVxiTj5/wVZloH/QnAFLbduq0lcuX409je3ADi31XycZf89V+Onr4YAq17so
	 O+9SbtR+ZZfxqUu2tYL2uzkvxubClgjLU4MLWEYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Baokun Li <libaokun1@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 390/587] jbd2: prevent softlockup in jbd2_log_do_checkpoint()
Date: Tue, 26 Aug 2025 13:08:59 +0200
Message-ID: <20250826111002.837240046@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

commit 9d98cf4632258720f18265a058e62fde120c0151 upstream.

Both jbd2_log_do_checkpoint() and jbd2_journal_shrink_checkpoint_list()
periodically release j_list_lock after processing a batch of buffers to
avoid long hold times on the j_list_lock. However, since both functions
contend for j_list_lock, the combined time spent waiting and processing
can be significant.

jbd2_journal_shrink_checkpoint_list() explicitly calls cond_resched() when
need_resched() is true to avoid softlockups during prolonged operations.
But jbd2_log_do_checkpoint() only exits its loop when need_resched() is
true, relying on potentially sleeping functions like __flush_batch() or
wait_on_buffer() to trigger rescheduling. If those functions do not sleep,
the kernel may hit a softlockup.

watchdog: BUG: soft lockup - CPU#3 stuck for 156s! [kworker/u129:2:373]
CPU: 3 PID: 373 Comm: kworker/u129:2 Kdump: loaded Not tainted 6.6.0+ #10
Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.27 06/13/2017
Workqueue: writeback wb_workfn (flush-7:2)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : native_queued_spin_lock_slowpath+0x358/0x418
lr : jbd2_log_do_checkpoint+0x31c/0x438 [jbd2]
Call trace:
 native_queued_spin_lock_slowpath+0x358/0x418
 jbd2_log_do_checkpoint+0x31c/0x438 [jbd2]
 __jbd2_log_wait_for_space+0xfc/0x2f8 [jbd2]
 add_transaction_credits+0x3bc/0x418 [jbd2]
 start_this_handle+0xf8/0x560 [jbd2]
 jbd2__journal_start+0x118/0x228 [jbd2]
 __ext4_journal_start_sb+0x110/0x188 [ext4]
 ext4_do_writepages+0x3dc/0x740 [ext4]
 ext4_writepages+0xa4/0x190 [ext4]
 do_writepages+0x94/0x228
 __writeback_single_inode+0x48/0x318
 writeback_sb_inodes+0x204/0x590
 __writeback_inodes_wb+0x54/0xf8
 wb_writeback+0x2cc/0x3d8
 wb_do_writeback+0x2e0/0x2f8
 wb_workfn+0x80/0x2a8
 process_one_work+0x178/0x3e8
 worker_thread+0x234/0x3b8
 kthread+0xf0/0x108
 ret_from_fork+0x10/0x20

So explicitly call cond_resched() in jbd2_log_do_checkpoint() to avoid
softlockup.

Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250812063752.912130-1-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/checkpoint.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -285,6 +285,7 @@ restart:
 		retry:
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
+			cond_resched();
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 	}



