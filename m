Return-Path: <stable+bounces-11986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2811A83173B
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E61C223AC
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA522F0F;
	Thu, 18 Jan 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZacZ9bOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0563219FC;
	Thu, 18 Jan 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575288; cv=none; b=YYMIYeVGEx4k1X2uaslXHr869N1KL8Alrx5zd5ERA0oNGqAU7vgbFMmKIWDn+26jzLaNT4NxLhXWZN0kWCwf8KWmBOLNYMe4w7+3Nkfh+J92BxZt73SpN5eFcezc8i8o71PGcftZmh3UX0RkAD4TsDFFlJ7vM+6BBDqhnIZQgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575288; c=relaxed/simple;
	bh=QRKKWX4Fjo/2WHDKQbSb/03sZktNuJQHjQFBroPHwZk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=aWpgTtUtqCusNl7b+Oq6UJTmaGwyMTzqEB0VDibaQ9cDklPtR1DG47h3H9uZ413B6DG19OA1gMUsvlBkI3xFlz7x7HOAVoYmWOpI5a8rlHaMZg4ac1xZpRK7gnftT+uIzxTJg540Xaw8BwxFznztAPu9ycETBIm+b//vECLq5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZacZ9bOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731FFC433F1;
	Thu, 18 Jan 2024 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575287;
	bh=QRKKWX4Fjo/2WHDKQbSb/03sZktNuJQHjQFBroPHwZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZacZ9bOSA7J3rr/RPmrAxizLB47rMiw6Ay+lLLH4Ds9w8kAAhBO0cf9Q3D+RW2lFd
	 sFPXmctFozcMIR2xWc9zfTMKwnPfBcox/gwkL7Y0sCOzmf73b2MKyQ2b6CharFVg9q
	 VFnqt7o6InUy/Yt3uzPOQEndf9mfvI1/CYfWguoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/150] jbd2: fix soft lockup in journal_finish_inode_data_buffers()
Date: Thu, 18 Jan 2024 11:48:20 +0100
Message-ID: <20240118104323.586830822@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
References: <20240118104320.029537060@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 6c02757c936063f0631b4e43fe156f8c8f1f351f ]

There's issue when do io test:
WARN: soft lockup - CPU#45 stuck for 11s! [jbd2/dm-2-8:4170]
CPU: 45 PID: 4170 Comm: jbd2/dm-2-8 Kdump: loaded Tainted: G  OE
Call trace:
 dump_backtrace+0x0/0x1a0
 show_stack+0x24/0x30
 dump_stack+0xb0/0x100
 watchdog_timer_fn+0x254/0x3f8
 __hrtimer_run_queues+0x11c/0x380
 hrtimer_interrupt+0xfc/0x2f8
 arch_timer_handler_phys+0x38/0x58
 handle_percpu_devid_irq+0x90/0x248
 generic_handle_irq+0x3c/0x58
 __handle_domain_irq+0x68/0xc0
 gic_handle_irq+0x90/0x320
 el1_irq+0xcc/0x180
 queued_spin_lock_slowpath+0x1d8/0x320
 jbd2_journal_commit_transaction+0x10f4/0x1c78 [jbd2]
 kjournald2+0xec/0x2f0 [jbd2]
 kthread+0x134/0x138
 ret_from_fork+0x10/0x18

Analyzed informations from vmcore as follows:
(1) There are about 5k+ jbd2_inode in 'commit_transaction->t_inode_list';
(2) Now is processing the 855th jbd2_inode;
(3) JBD2 task has TIF_NEED_RESCHED flag;
(4) There's no pags in address_space around the 855th jbd2_inode;
(5) There are some process is doing drop caches;
(6) Mounted with 'nodioread_nolock' option;
(7) 128 CPUs;

According to informations from vmcore we know 'journal->j_list_lock' spin lock
competition is fierce. So journal_finish_inode_data_buffers() maybe process
slowly. Theoretically, there is scheduling point in the filemap_fdatawait_range_keep_errors().
However, if inode's address_space has no pages which taged with PAGECACHE_TAG_WRITEBACK,
will not call cond_resched(). So may lead to soft lockup.
journal_finish_inode_data_buffers
  filemap_fdatawait_range_keep_errors
    __filemap_fdatawait_range
      while (index <= end)
        nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end, PAGECACHE_TAG_WRITEBACK);
        if (!nr_pages)
           break;    --> If 'nr_pages' is equal zero will break, then will not call cond_resched()
        for (i = 0; i < nr_pages; i++)
          wait_on_page_writeback(page);
        cond_resched();

To solve above issue, add scheduling point in the journal_finish_inode_data_buffers();

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231211112544.3879780-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 9bdb377a348f..5e122586e06e 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -270,6 +270,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			if (!ret)
 				ret = err;
 		}
+		cond_resched();
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
 		smp_mb();
-- 
2.43.0




