Return-Path: <stable+bounces-185568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55854BD7228
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63A418A28F9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07525D1E9;
	Tue, 14 Oct 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKjO+tOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD71E990E
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411017; cv=none; b=aktfo93zMiGE+4yB26HklvuIYb0zQQFRxkpgBJv734x47jMs0TiZ++vn2byqyHc3nx1ujc808bm2ukmTQR/LQ2cscNfMuiHPppqUbIrZ74luoat26XYZkI/h+dhPwkXhmxTOcqrGPVi7EDNI6mjLNDwvL6LjTzgVWOZFEHdt1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411017; c=relaxed/simple;
	bh=rz43q4dVdGruZuaz55FIjgfrnCodP2sTg4aqQBm95jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjTZHKnvQmWD6aiD80GCLjVyKbBvmvUDGmlshpEkHu0u9kz0UGdwnqzTmHBVnnaF5FoQ/i4I5Gk5bLMXIgRdbDb9uVHi/dyakaHgh5KxdOx4iPTPqanNbW26ja8IWSC78zFI0KJIiVIv2iGEWPLwQ69pYPcD66TRT+e1JwHZdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKjO+tOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ABBC4CEE7;
	Tue, 14 Oct 2025 03:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760411017;
	bh=rz43q4dVdGruZuaz55FIjgfrnCodP2sTg4aqQBm95jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKjO+tOKt9Wy7/s9GUG2gq0Tb62BgXi5XxkIWKGRL42ZD4dM/ZPuJctr/IT9XwpmF
	 oWGIqccvREyBlIEpKylYBD6RX4le7sObK0/dk/d7KHWoEIvIInC9UHoDM61rfGcoDC
	 VBr/3D+FdKzhI5tlL2D4Jw9K0YVlOCFjUVLqse7yod6IXoJsB4fFvte8V5lM7ij96t
	 Rn19uGDR92RR9TOpyCbwHyU6tNX4xgfgs8sf/UvxqE9V/dCQQbGoe9fzMvsXANjTvL
	 lXrfqAmsQnoNRa+/i4Pbmks/HRykDyri2bILFcRARCD1/DUR2Axsz5+lTZFmMApH4W
	 onMi/gl3D2zNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] dm: fix NULL pointer dereference in __dm_suspend()
Date: Mon, 13 Oct 2025 23:03:34 -0400
Message-ID: <20251014030334.3868139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101316-favored-pulsate-a811@gregkh>
References: <2025101316-favored-pulsate-a811@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 8d33a030c566e1f105cd5bf27f37940b6367f3be ]

There is a race condition between dm device suspend and table load that
can lead to null pointer dereference. The issue occurs when suspend is
invoked before table load completes:

BUG: kernel NULL pointer dereference, address: 0000000000000054
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 6 PID: 6798 Comm: dmsetup Not tainted 6.6.0-g7e52f5f0ca9b #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
RIP: 0010:blk_mq_wait_quiesce_done+0x0/0x50
Call Trace:
  <TASK>
  blk_mq_quiesce_queue+0x2c/0x50
  dm_stop_queue+0xd/0x20
  __dm_suspend+0x130/0x330
  dm_suspend+0x11a/0x180
  dev_suspend+0x27e/0x560
  ctl_ioctl+0x4cf/0x850
  dm_ctl_ioctl+0xd/0x20
  vfs_ioctl+0x1d/0x50
  __se_sys_ioctl+0x9b/0xc0
  __x64_sys_ioctl+0x19/0x30
  x64_sys_call+0x2c4a/0x4620
  do_syscall_64+0x9e/0x1b0

The issue can be triggered as below:

T1 						T2
dm_suspend					table_load
__dm_suspend					dm_setup_md_queue
						dm_mq_init_request_queue
						blk_mq_init_allocated_queue
						=> q->mq_ops = set->ops; (1)
dm_stop_queue / dm_wait_for_completion
=> q->tag_set NULL pointer!	(2)
						=> q->tag_set = set; (3)

Fix this by checking if a valid table (map) exists before performing
request-based suspend and waiting for target I/O. When map is NULL,
skip these table-dependent suspend steps.

Even when map is NULL, no I/O can reach any target because there is
no table loaded; I/O submitted in this state will fail early in the
DM layer. Skipping the table-dependent suspend logic in this case
is safe and avoids NULL pointer dereferences.

Fixes: c4576aed8d85 ("dm: fix request-based dm's use of dm_wait_for_completion")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[ omitted DMF_QUEUE_STOPPED flag setting and braces absent in 5.15 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 0868358a7a8d2..b51281ce15d4c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2457,7 +2457,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2509,7 +2509,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md))
+	if (map && dm_request_based(md))
 		dm_stop_queue(md->queue);
 
 	flush_workqueue(md->wq);
@@ -2519,7 +2519,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * We call dm_wait_for_completion to wait for all existing requests
 	 * to finish.
 	 */
-	r = dm_wait_for_completion(md, task_state);
+	if (map)
+		r = dm_wait_for_completion(md, task_state);
 	if (!r)
 		set_bit(dmf_suspended_flag, &md->flags);
 
-- 
2.51.0


