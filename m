Return-Path: <stable+bounces-184451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E9BD44F8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C59C402D7B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698730E0F5;
	Mon, 13 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EoDaWVff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319030E0F2;
	Mon, 13 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367474; cv=none; b=pj4tout4x26PBinKXovycaJM/pnqmpSzQEpMDnAo/U3X/toeZHJGNZE8u7PBjO3Hvvts6dSorHXiQDjAAzp974gB3wnNmM/aIHMLIqb7R1cUWYn9y3N/P9s3dhme+dLSUKEkM8cNKdrdqKpHml+eIKwhUZ/7/4GPh6F6U8NMMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367474; c=relaxed/simple;
	bh=P+jy2rSyQAzeON7lSSh/h+nVnl5iyz5Oi4qn5tAWZy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukixhg3lDoPZQKcNNamaSyRLHkgaOUho5ihepXitOsOQbNqxbHkHj338OqkmeqlpSTZiOVrGRvDVEA3+HgKqDqLSkigR7ZnbYtJo21d7TVnho1BzdMEIzwP0EFxDJgsOVZYrHK3UFcQ0d7YeGaCvb+DZwY2gN8GsdFK4yE7T1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EoDaWVff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B8C4CEE7;
	Mon, 13 Oct 2025 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367473;
	bh=P+jy2rSyQAzeON7lSSh/h+nVnl5iyz5Oi4qn5tAWZy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoDaWVffa7GhbpkadBM4TjcRdxam9tDE3pQ0arsa10JdcvPU8S5m1M4IcsOjfwBm+
	 fd+16uOvM0Zr7bIijE7yW2ubu3jQV4bqBlxWf63vmzwwn8Pd5hTGeJEG4MmGPONjrW
	 3sUBh8bajyxK0iBqItfGr8coOBL6i+aFx0pUgj2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/196] blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx
Date: Mon, 13 Oct 2025 16:43:35 +0200
Message-ID: <20251013144316.070210929@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 4c7ef92f6d4d08a27d676e4c348f4e2922cab3ed ]

In __blk_mq_update_nr_hw_queues() the return value of
blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx
fails, later changing the number of hw_queues or removing disk will
trigger the following warning:

  kernfs: can not remove 'nr_tags', no directory
  WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
  Call Trace:
   remove_files.isra.1+0x38/0xb0
   sysfs_remove_group+0x4d/0x100
   sysfs_remove_groups+0x31/0x60
   __kobject_del+0x23/0xf0
   kobject_del+0x17/0x40
   blk_mq_unregister_hctx+0x5d/0x80
   blk_mq_sysfs_unregister_hctxs+0x94/0xd0
   blk_mq_update_nr_hw_queues+0x124/0x760
   nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
   nullb_device_submit_queues_store+0x92/0x120 [null_blk]

kobjct_del() was called unconditionally even if sysfs creation failed.
Fix it by checkig the kobject creation statusbefore deleting it.

Fixes: 477e19dedc9d ("blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues")
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250826084854.1030545-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 156e9bb07abf1..2fb234ab467b1 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -150,9 +150,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 		return;
 
 	hctx_for_each_ctx(hctx, ctx, i)
-		kobject_del(&ctx->kobj);
+		if (ctx->kobj.state_in_sysfs)
+			kobject_del(&ctx->kobj);
 
-	kobject_del(&hctx->kobj);
+	if (hctx->kobj.state_in_sysfs)
+		kobject_del(&hctx->kobj);
 }
 
 static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
-- 
2.51.0




