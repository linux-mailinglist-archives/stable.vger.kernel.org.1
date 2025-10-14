Return-Path: <stable+bounces-185637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A905DBD90FF
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AE3BDCCF
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB530C361;
	Tue, 14 Oct 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/3Rfam4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597330BF6B
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441759; cv=none; b=KwikchsPhowj+VE/sxNYYKvmRDATUiCgSdQaksWgcwSyk8pPdqMlNU/Olr31PFMoYgPAb5zjGJ7wq/RJPZoBH1krkejVlF1jHY8c+uhF1pAbhnPDtR82Lq5dIc9AexHzWIwgSR+XyDlityQqwFZbwr6x25Oq+himI2vQmkxyXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441759; c=relaxed/simple;
	bh=IzwSRK05agVnf7WULlraPY0sAZEHqquQf3TW6XzfySI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma1ZdyL1eaLBvoS+F2SQMDWA9lRS/tGd5uFccz7eYlXnqR3T7pZXxfpgVLLc7h+bJ29XRy1KF1Pdns6KxzjHLvwZgMPnHnsQAh5gsXDh9ey2A63sA19D5aUFtZroIWKU4Pn53CMVfPLUh2rpdHCI9dAmLVserlyYx5jnZhalf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/3Rfam4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE9C4CEE7;
	Tue, 14 Oct 2025 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760441759;
	bh=IzwSRK05agVnf7WULlraPY0sAZEHqquQf3TW6XzfySI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/3Rfam4ykCxRdzvRlITaSDFbqVCT+94xiLUTxlEHq2hybW0VPdseqLWG0eVauqa/
	 p+hRkk1eddM5ZbptzxcmrJoDmT4HcseTsRNTypWie7EPWQ4vCBH1W3emKT423EhgVs
	 Wt1yD5oS3uCpzsmLsuebU0Ru4L9LbcU2+RQWq5eNijoahuJD5eLw+YPN50/Nr8sfTf
	 Y6DBu6Vpp62PlPdA08tKIPCYH8ZmpmAqbL5WfSyQwjJQiznRMr69trrnvoED9CC0I0
	 /7MG8QFKUmJTEM42gkh/q4hbra7ircjjeHlA7Km+m4sRQRc7Jb+LPUPx0K1xWNkzhO
	 pe2qB9dYOPL0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] dm: fix NULL pointer dereference in __dm_suspend()
Date: Tue, 14 Oct 2025 07:35:55 -0400
Message-ID: <20251014113556.4151972-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101316-handmade-imaginary-edf0@gregkh>
References: <2025101316-handmade-imaginary-edf0@gregkh>
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
index 3d00bb98d702b..be7182adcdd5b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2595,7 +2595,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2648,7 +2648,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md))
+	if (map && dm_request_based(md))
 		dm_stop_queue(md->queue);
 
 	flush_workqueue(md->wq);
@@ -2658,7 +2658,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
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


