Return-Path: <stable+bounces-185564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68858BD70DA
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 04:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38CF188ABF0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2047219A8E;
	Tue, 14 Oct 2025 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l45ttzq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664541760
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408175; cv=none; b=MPwsPVrmnM8a705WH6K5GZu4NJFh20B/RVli3e+4IEM6yZI7M1kHc83crpFNuBaT4k7MOoPaj2Oezv17RZzHALPQ/+MqgLh9wL0eGxs1I3E8XRi6ZuHZ0JzuZ511XNpSeQsZYACIrLQPEdPKWx0DjY0HrT12Ts+78QJ4D6PbX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408175; c=relaxed/simple;
	bh=lqw3qA8Ms4xTKJFO8i4sFm/YwxGgPyC/01pyEUL3RaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZDxUXv+DN54GeYr9Z1p6UwU+bFKqDGe93kXdcJ0NedHUJReBZMKZGtGcuRiXxnIDlYIc4JoAOEjW/pfuR5o+0aG/i3KmMLuR9bSvkO4mQXcJ9sOdekawPCg6JwLfVNlw7tH0mGDDuTjUS3arGa5qGh4algXrmCBJn6Upb1aE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l45ttzq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE0FC4CEE7;
	Tue, 14 Oct 2025 02:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760408173;
	bh=lqw3qA8Ms4xTKJFO8i4sFm/YwxGgPyC/01pyEUL3RaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l45ttzq9f0ZnbS2hbaWijpUwypsSiDnjxF5CfBRGT5na9cF5H+/ExD1EjfK1WreVd
	 pCrqMw3aRrnsIm7dKg4sFSlnNGiBSEO9gf+2+u5gCNMu8WxLjDUmAzO4TWUcV0R6Fr
	 qEjdsOfn6tbTidQhza+7gk1u3KP5ydv1bhMtYvkSTEx1XDb8vmZPtvmHwkQqSGepS4
	 lAjYAnHLaKIbXKmyPjdDcwivUmwDhVTrqnR8KhH89Zi04oqavo3+MBI8+aeSjvYofL
	 yLeTRWalrIZm7YhPzdpz1e3HW8AloUL2XTD3R9OYIW5EmCxgcZioeOtJRRYUlG/nay
	 EfKsa5f96hi0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dm: fix NULL pointer dereference in __dm_suspend()
Date: Mon, 13 Oct 2025 22:16:10 -0400
Message-ID: <20251014021610.3835566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101315-graveness-treason-be2b@gregkh>
References: <2025101315-graveness-treason-be2b@gregkh>
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
index 8b192fc1f798c..26bc77d205864 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2406,7 +2406,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2458,7 +2458,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md))
+	if (map && dm_request_based(md))
 		dm_stop_queue(md->queue);
 
 	flush_workqueue(md->wq);
@@ -2468,7 +2468,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
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


