Return-Path: <stable+bounces-181565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF6B9814F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 04:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624E1B206D6
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 02:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262C215F42;
	Wed, 24 Sep 2025 02:36:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AF1FC0EA
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681386; cv=none; b=iZhJvZZFsCtFcMGvs2xu22aUTeyIlcqZlwPlas0On8CEwFXh4q9ByWkXRz7lzpMKuD5iv/cXAvNl2AbrhwMfH8HDHEdScATz78ZzDmwDVaRn08+iroI8Hamzf2tmdJNvJ5N3GI7i4KISA43pqQHxO6ucHWz95xenP53bfBnYfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681386; c=relaxed/simple;
	bh=5z4mGW0neqU1p2toTBLHOR3tmPL0UaXh3Z9jWlY0Hig=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=rOTfUTO8QiFVKIarbvwNldmhWtQ1A7aA4mjgQAuwmib/Qh6wR1joe9myqk5lpIV5f1WDSbovepXHPyzLPVj4f849zaM8B9887fo7RhwXMugV9GPvVtCm3+7CoxCYDA5+KjdUnhY7TnZ5r9z1EmKb6hO5RgIUfyuhcpEj5L4fHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cWgpP5hrlzddSF;
	Wed, 24 Sep 2025 10:31:41 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E254180B63;
	Wed, 24 Sep 2025 10:36:20 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 24 Sep 2025 10:36:19 +0800
Message-ID: <7f6f5d7d-385d-ea47-43b8-bbd6341e2ec6@huawei.com>
Date: Wed, 24 Sep 2025 10:36:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Sasha Levin <sashal@kernel.org>, linux-stable <stable@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
CC: yangerkun <yangerkun@huawei.com>
From: yangerkun <yangerkun@huawei.com>
Subject: [BUG REPORT] Incorrect adaptation of 7e49538288e5 ("loop: Avoid
 updating block size under exclusive owner") for stable 6.6
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Error path for blk_validate_block_size is wrong, we should goto unlock, 
or lo_mutex won't be release, and bdev will keep claimed.

...

-static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
+static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
+                              struct block_device *bdev, unsigned long arg)
  {
         int err = 0;

-       if (lo->lo_state != Lo_bound)
-               return -ENXIO;
+       /*
+        * If we don't hold exclusive handle for the device, upgrade to it
+        * here to avoid changing device under exclusive owner.
+        */
+       if (!(mode & BLK_OPEN_EXCL)) {
+               err = bd_prepare_to_claim(bdev, loop_set_block_size, NULL);
+               if (err)
+                       return err;
+       }
+
+       err = mutex_lock_killable(&lo->lo_mutex);
+       if (err)
+               goto abort_claim;
+
+       if (lo->lo_state != Lo_bound) {
+               err = -ENXIO;
+               goto unlock;
+       }

         err = blk_validate_block_size(arg);
         if (err)
                 return err;
                 ^^^^^^^^^^^^^
                 should goto unlock

         if (lo->lo_queue->limits.logical_block_size == arg)
-               return 0;
+               goto unlock;

         sync_blockdev(lo->lo_device);
         invalidate_bdev(lo->lo_device);

         blk_mq_freeze_queue(lo->lo_queue);
         blk_queue_logical_block_size(lo->lo_queue, arg);
         blk_queue_physical_block_size(lo->lo_queue, arg);
         blk_queue_io_min(lo->lo_queue, arg);
         loop_update_dio(lo);
         blk_mq_unfreeze_queue(lo->lo_queue);

+unlock:
+       mutex_unlock(&lo->lo_mutex);
+abort_claim:
+       if (!(mode & BLK_OPEN_EXCL))
+               bd_abort_claiming(bdev, loop_set_block_size);
         return err;
  }




