Return-Path: <stable+bounces-94371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574929D3C2A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A5E1F25251
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927821AB6FD;
	Wed, 20 Nov 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQjrB5NS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EB1BF7F9;
	Wed, 20 Nov 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107705; cv=none; b=YEWbTmQGpuHAKsdPd3fpUNui3MyqI6pPKWPd8WfwwrHAuqivaVBwpY5kCMcMYWTeHB3SNgG4+QDYLQHkXI/3tTkGjZYb1HmT2Yq4N8r1pwNcocrVhPhAGftxcmfai/YVPZ/1ZcTYnrX7QlRrDDGnxdf95xcspJjltTnwo7AF7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107705; c=relaxed/simple;
	bh=E+2j/NDJRWAVzIifzBkAhFKSpus5OwgvJ4X8P69xM48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REH6Z+duqF4v//oLSOoIR6L+/E5j0tb3mGY5gdfFpBArvmyRFSZ7vf7HFQlHdFzxoQC7+uHbupgW4a/oMQAve7ep643mm+OzQcDbiBHhQRgrKt/WvnZmDPcfECKwH696fXOyLjSIrowNsAnz0D+qFRoCecT14R1HRZPW925NN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQjrB5NS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB1CC4CED1;
	Wed, 20 Nov 2024 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107705;
	bh=E+2j/NDJRWAVzIifzBkAhFKSpus5OwgvJ4X8P69xM48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rQjrB5NShLrmLh2d4Mf9S5M09zd2AariPZ5f0TBZIvP6NCvdhv7JaMVJVeAObdRnD
	 g9YQI6oZwFrDrZYkSqOrMNZNWZa8tPIJNYPAKHSupV2IT0WPdMtNWBnCUEMYqRHS5L
	 hy73glAeuaBeAtdTTr6srtYTTNDi4JehR6gOWGVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 6.1 69/73] null_blk: fix null-ptr-dereference while configuring power and submit_queues
Date: Wed, 20 Nov 2024 13:58:55 +0100
Message-ID: <20241120125811.262768885@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit a2db328b0839312c169eb42746ec46fc1ab53ed2 upstream.

Writing 'power' and 'submit_queues' concurrently will trigger kernel
panic:

Test script:

modprobe null_blk nr_devices=0
mkdir -p /sys/kernel/config/nullb/nullb0
while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
while true; do echo 1 > power; echo 0 > power; done

Test result:

BUG: kernel NULL pointer dereference, address: 0000000000000148
Oops: 0000 [#1] PREEMPT SMP
RIP: 0010:__lock_acquire+0x41d/0x28f0
Call Trace:
 <TASK>
 lock_acquire+0x121/0x450
 down_write+0x5f/0x1d0
 simple_recursive_removal+0x12f/0x5c0
 blk_mq_debugfs_unregister_hctxs+0x7c/0x100
 blk_mq_update_nr_hw_queues+0x4a3/0x720
 nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
 nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
 configfs_write_iter+0x119/0x1e0
 vfs_write+0x326/0x730
 ksys_write+0x74/0x150

This is because del_gendisk() can concurrent with
blk_mq_update_nr_hw_queues():

nullb_device_power_store	nullb_apply_submit_queues
 null_del_dev
 del_gendisk
				 nullb_update_nr_hw_queues
				  if (!dev->nullb)
				  // still set while gendisk is deleted
				   return 0
				  blk_mq_update_nr_hw_queues
 dev->nullb = NULL

Fix this problem by resuing the global mutex to protect
nullb_device_power_store() and nullb_update_nr_hw_queues() from configfs.

Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20240523153934.1937851-1-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/null_blk/main.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -392,13 +392,25 @@ static int nullb_update_nr_hw_queues(str
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -444,28 +456,31 @@ static ssize_t nullb_device_power_store(
 	if (ret < 0)
 		return ret;
 
+	ret = count;
+	mutex_lock(&lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
-			return count;
+			goto out;
+
 		ret = null_add_dev(dev);
 		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return ret;
+			goto out;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-			mutex_lock(&lock);
 			dev->power = newp;
 			null_del_dev(dev->nullb);
-			mutex_unlock(&lock);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-	return count;
+out:
+	mutex_unlock(&lock);
+	return ret;
 }
 
 CONFIGFS_ATTR(nullb_device_, power);
@@ -2102,15 +2117,12 @@ static int null_add_dev(struct nullb_dev
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
-	mutex_lock(&lock);
 	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
-	if (rv < 0) {
-		mutex_unlock(&lock);
+	if (rv < 0)
 		goto out_cleanup_zone;
-	}
+
 	nullb->index = rv;
 	dev->index = rv;
-	mutex_unlock(&lock);
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
@@ -2134,9 +2146,7 @@ static int null_add_dev(struct nullb_dev
 	if (rv)
 		goto out_ida_free;
 
-	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
-	mutex_unlock(&lock);
 
 	pr_info("disk %s created\n", nullb->disk_name);
 
@@ -2185,7 +2195,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
+	mutex_lock(&lock);
 	ret = null_add_dev(dev);
+	mutex_unlock(&lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;



