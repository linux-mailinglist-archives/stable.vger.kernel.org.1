Return-Path: <stable+bounces-110266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454A4A1A382
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 12:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8686F16E80B
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB16D20CCCF;
	Thu, 23 Jan 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ijfNY9iZ"
X-Original-To: stable@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF420D4F2
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632719; cv=none; b=q/M4RgFveY1KJzi7XWUTVUlYMlec8kVl2ysbqIMvIyAh0S0iptS+7jUvR7AarC2ZTUNpqiSkIblddtpB9ix8WraeNDW+BxhUja05WawCdbDhQrrxcuNYDBihb7ee+HKLhzCEKIdaEIetaxzjikxmcPKFJ9N3sgRo3Tk6sY/6AOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632719; c=relaxed/simple;
	bh=RrFQ3aiu7p8FdCgtZ24NAWcI608oc+9FqIZSsKDaHFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=T1r1KheYP8CwRJKrVubW7R/fbMcdOstzZ5K46U5vbyWOEb/PmjLYaGGlhLcSoSZIy4CL2z31ivnX7RDYOwh0zRJBQvfd0udsKYx/OYeh0LVf6bq80fauRBlTLobCKID3WDnlLJmgvRt5mWEQNxYvZTxlTjqxfEtf+ZyjMILyGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=fail smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ijfNY9iZ; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2474; q=dns/txt; s=iport;
  t=1737632717; x=1738842317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRGxoKt8rjpieXph/y9GqL7UGmEVAGyzjb2VfxbcC28=;
  b=ijfNY9iZoD4C38z5dUmSZ31QYje+PWXbZVN/s0/rzSpa925FosnyeorS
   buIeijV6nz7yuA1kzZvJvs0Y1Ttado/n6R1SD3UDlJa4NmVY2Y6SkS8L7
   46UbYV+qb8cgEmM35JcvKm3sWDTXC/xsU9J6z6YxWu5kYYlCOFjyT9ZNR
   U=;
X-CSE-ConnectionGUID: BOr/xM7JT+OZgN5zXE+3ZA==
X-CSE-MsgGUID: goKEx5s4RO+vFhISbxqb3A==
X-IPAS-Result: =?us-ascii?q?A0BzAAA6K5Jn/5L/Ja1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCSXZaQhkvhFWIHYlSi3aMSIVdgSUDVg8BAQEPOQsEAQGFB4p1A?=
 =?us-ascii?q?iY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4V7DUkBD?=
 =?us-ascii?q?AEIAYV9JwQLAUYwBQIfBwItRIMBAYJkAgERtQ56fzOBAd4zgWcGgRouAYhNA?=
 =?us-ascii?q?YR7hWcnG4FJRIEVgTuCLYFSgQ8EGIITgw6CRyIEhCSDP6AJSIEFHANZLAFVE?=
 =?us-ascii?q?w0KCwcFgXEDOAwLMBUygRd7gkdpSToCDQI1gh58giuEXoRFhFGFW4IUghSFQ?=
 =?us-ascii?q?h1AAwsYDUgRLBQjFBsGPQFuB5wWATyDMSYggQ4UGFCBQwGTN5I5oQOEJYwYl?=
 =?us-ascii?q?S4aM6pTLodbCY9xeY4ElkOEZoFnPIFZTSMVgyJSGQ+OLRYWiFa7fCI1AjoCB?=
 =?us-ascii?q?wEKAQEDCY1AgTiCZwEB?=
IronPort-Data: A9a23:8Xvcr6MwfrL3LlrvrR3NlsFynXyQoLVcMsEvi/4bfWQNrUon1WEBz
 mcWDTjQPPyLamr2fogkbYWxpxgC7ZOGndRlHnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WljlV
 e/a+ZWFZQf8gWUsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj699JFgYmGNI6xqVQM25oq
 O4oBXNWXDnW0opawJrjIgVtrt4oIM+uOMYUvWttiGmIS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMnwsYDUXUrsTIIkmgfyonnr2WzZZs1mS46Ew5gA/ySQti+SwaYaNIIXiqcN9kUG7i
 3Kb5DjDJVIEGty+8jCV63j3r7qa9c/8cMdIfFGizdZhgFCVyX4TCR0fUgKToeSwlUO/HdlYL
 iQ89jEyoLI4/WSwU8LwGRa/pRaspQIVUd5dO/M15RvLyafO5QudQG8eQVZ8hMcOrsQ6Q3kuk
 1SOhd6sXW0pu7yOQnXb/bCRxd+vBRUowaY5TXdsZWM4DxPL+enfUjqnog5fLZOI
IronPort-HdrOrdr: A9a23:dG8JYahb9gTf410YWC0e8UvE83BQXtsji2hC6mlwRA09TyVXra
 +TdZMgpHvJYVcqKRQdcL+7WZVoLUmwyXcX2/hyAV7dZmnbUQKTRekIh7cKqAePJ8SRzIJgPN
 9bAstD4BmaNykdsS48izPIdOod/A==
X-Talos-CUID: 9a23:weLVD26CKn7ZSRPO5tss3mkOXdAALV/hj1DiLGnlG1ZEC+anYArF
X-Talos-MUID: 9a23:/8FfNAba3PqWkeBTuDjPqSE/L5tSxOewJkAsqp8WosPfHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732579200"; 
   d="scan'208";a="434514021"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 11:44:08 +0000
Received: from sjc-ads-1396.cisco.com (sjc-ads-1396.cisco.com [171.70.59.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 4E5271800022E;
	Thu, 23 Jan 2025 11:44:08 +0000 (GMT)
Received: by sjc-ads-1396.cisco.com (Postfix, from userid 1839047)
	id CFD9FCC128E; Thu, 23 Jan 2025 03:44:07 -0800 (PST)
From: Shubham Pushpkar <spushpka@cisco.com>
To: xe-linux-external@cisco.com
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	stable@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Shubham Pushpkar <spushpka@cisco.com>
Subject: [Internal Review] [Patch] btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
Date: Thu, 23 Jan 2025 03:41:41 -0800
Message-Id: <20250123114141.1955806-1-spushpka@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 171.70.59.88, sjc-ads-1396.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit aec8e6bf839101784f3ef037dcdb9432c3f32343 ("btrfs:
fix use-after-free of block device file in __btrfs_free_extra_devids()")

Mounting btrfs from two images (which have the same one fsid and two
different dev_uuids) in certain executing order may trigger an UAF for
variable 'device->bdev_file' in __btrfs_free_extra_devids(). And
following are the details:

1. Attach image_1 to loop0, attach image_2 to loop1, and scan btrfs
   devices by ioctl(BTRFS_IOC_SCAN_DEV):

             /  btrfs_device_1 → loop0
   fs_device
             \  btrfs_device_2 → loop1
2. mount /dev/loop0 /mnt
   btrfs_open_devices
    btrfs_device_1->bdev_file = btrfs_get_bdev_and_sb(loop0)
    btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
   btrfs_fill_super
    open_ctree
     fail: btrfs_close_devices // -ENOMEM
	    btrfs_close_bdev(btrfs_device_1)
             fput(btrfs_device_1->bdev_file)
	      // btrfs_device_1->bdev_file is freed
	    btrfs_close_bdev(btrfs_device_2)
             fput(btrfs_device_2->bdev_file)

3. mount /dev/loop1 /mnt
   btrfs_open_devices
    btrfs_get_bdev_and_sb(&bdev_file)
     // EIO, btrfs_device_1->bdev_file is not assigned,
     // which points to a freed memory area
    btrfs_device_2->bdev_file = btrfs_get_bdev_and_sb(loop1)
   btrfs_fill_super
    open_ctree
     btrfs_free_extra_devids
      if (btrfs_device_1->bdev_file)
       fput(btrfs_device_1->bdev_file) // UAF !

Fix it by setting 'device->bdev_file' as 'NULL' after closing the
btrfs_device in btrfs_close_one_device().

Fixes: CVE-2024-50217
Fixes: 142388194191 ("btrfs: do not background blkdev_put()")
CC: stable@vger.kernel.org # 4.19+
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219408
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit aec8e6bf839101784f3ef037dcdb9432c3f32343)
Signed-off-by: Shubham Pushpkar <spushpka@cisco.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b9a0b26d08e1..ab2412542ce5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1176,6 +1176,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 	if (device->bdev) {
 		fs_devices->open_devices--;
 		device->bdev = NULL;
+		device->bdev_file = NULL;
 	}
 	clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	btrfs_destroy_dev_zone_info(device);
-- 
2.35.6


