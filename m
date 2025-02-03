Return-Path: <stable+bounces-112016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5EEA2598E
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C33A7140
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B82040AE;
	Mon,  3 Feb 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ftf1v5aB"
X-Original-To: stable@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6151FFC69
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586375; cv=none; b=VPOJBb+y4/7Aht3l6QqVy53sOdEyjK/1i562Yhzg+j9HQ5YHJhGtpx2W9KNa4p901fjs0INdEs1toAMQ6wDpueEjYMrrx08QOu3EQ+0tvE/ZcWZLcAt+jIc052/aCD0KllNZPU0lX2h+Pq40dRnO2cpNzgLdPiCicmALR2mXw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586375; c=relaxed/simple;
	bh=nwH6/0QH08mY65c33mk3YXuGnkdycTU2prnbMtYpOdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=A7zsfh6Z69yLHZSBpBPvVtXhaKUfGqWFUAihkMsrT5sYDjTBiR4q0QM13Fl8NupI0gJ65yrI2e3tQOyKDDKpuCU/I1UFrFU5Xp7d+uCP6tQ+ilzwByrxgJHLZ9rRqthDerm8PHpUrHDJB8qSPUZ8JMXWAH/dzSuAXfJEJruIS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ftf1v5aB; arc=none smtp.client-ip=173.37.86.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2451; q=dns/txt; s=iport;
  t=1738586373; x=1739795973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=juZwhSg3ntsdALe/mMNvEjgAx5lxQ5+PH40m4ELrGqg=;
  b=ftf1v5aBGfaK3vaM96WMClGNN/WbitIQl1V2JLH+6wbSy2gzGaF9UmTk
   appX+hxmBKB1cnc7cHSWhHm5NJ3qAjuWyg4GHzPoTvL6820buluyTwYfJ
   uHuVYMII5o5/GVwFKbdxCT25JsiiNu82k4yHpAWwGwK34FbN1/61YqQ9C
   U=;
X-CSE-ConnectionGUID: nQc+aCTaT+W+HxFhVkQRZQ==
X-CSE-MsgGUID: ciARYzF+THW2AJhobgq/vQ==
X-IPAS-Result: =?us-ascii?q?A0ATAACAt6Bn/5T/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAQGCSXZaQkiEVYgdiVOLdoxHhVyBJQNWDwEBAQ85CwQBA?=
 =?us-ascii?q?YUHin4CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?XsNSQEMAYYGJwQLAUYwBQIfBwItRIMCAYJkAgERsE56fzOBAd4zgWgGgRouA?=
 =?us-ascii?q?YhNAYR7cIR3JxuBSUSBFYE7gi2BBYFcBBiCE4MOgkciBIQhgz+iUEiBBRwDW?=
 =?us-ascii?q?SwBVRMNCgsHBYFxAzUMCzAVMoEXRDeCR2lJOgINAjWCHnyCK4RchENfLwMDA?=
 =?us-ascii?q?wODNoVdghKCC4dwHUADCxgNSBEsNxQbBj0BbgedNAE8g0gmIIEOFBhQgUSTO?=
 =?us-ascii?q?JI7oQSEJYwYlS4aM6pTLodbCY9xeY4ElkSEZoFnPIFZTSMVgyJSGQ+OLQsLF?=
 =?us-ascii?q?ohVwlgiNQI6AgcBCgEBAwmNQIQ6AQE?=
IronPort-Data: A9a23:zeBZXajYhAn89xkU9OfSbivEX161CBEKZh0ujC45NGQN5FlHY01je
 htvXz2HP/7fYWLzLY1/a4u0904HuZTTzd9gSwVqrykzFyJjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSEULOZ82QsaD9MsfrY8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUew+00CEpy/
 MBbF3Mtfj6DueGP+oCCH7wEasQLdKEHPasFsX1miDWcBvE8TNWaGuPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgd/5JEWxI9EglHkayBDqEqWrII84nPYy0p6172F3N/9IYXWH5sPxxjDz
 o7A12/4KysrJvLc9Rq6qFuOhujFkjq8RrtHQdVU8dYv2jV/3Fc7Ax0bU1Spofi5g0nnc9JCI
 lMZ+2wlqq1a3ECwUtTnVRSQu2Ofs1gXXN84O/Ym4QuJx4LK7AuDQGsJVDhMbJohrsBeeNAx/
 kWCk9WsAXlkt6eYDCvEsLyVtji1fyMSKAfueBM5cOfM2PG7yKlbs/4FZo8L/HKd5jEtJQzN/
 g==
IronPort-HdrOrdr: A9a23:86BmV6qgvJt7Sq05kw0GUOAaV5oqeYIsimQD101hICG9vPb2qy
 nIpoV+6faUskd1ZJhOo7G90cW7LE80lqQFg7X5Q43DYOCOggLBR+tfBODZrQEIdReTygck79
 YCT0C7Y+eAa2STSq3BkW6FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3ABTBVBGkY7+SwPoKZj9vM/1skaNjXOXvkxzTZCHO?=
 =?us-ascii?q?xNSVWC52FZ1+u+5peofM7zg=3D=3D?=
X-Talos-MUID: 9a23:NcpuDwhE4HUjS8SPw3EtdsMpP8ZB2ZW8JgMxsapckuuEMiZ/InCDtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,255,1732579200"; 
   d="scan'208";a="314262163"
Received: from rcdn-l-core-11.cisco.com ([173.37.255.148])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Feb 2025 12:38:24 +0000
Received: from sjc-ads-1396.cisco.com (sjc-ads-1396.cisco.com [171.70.59.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-11.cisco.com (Postfix) with ESMTPS id 5422118000253;
	Mon,  3 Feb 2025 12:38:24 +0000 (GMT)
Received: by sjc-ads-1396.cisco.com (Postfix, from userid 1839047)
	id DA4A0CC128E; Mon,  3 Feb 2025 04:38:23 -0800 (PST)
From: Shubham Pushpkar <spushpka@cisco.com>
To: stable@vger.kernel.org
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	David Sterba <dsterba@suse.com>,
	Shubham Pushpkar <spushpka@cisco.com>
Subject: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
Date: Mon,  3 Feb 2025 04:37:19 -0800
Message-Id: <20250203123719.52811-1-spushpka@cisco.com>
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
X-Outbound-Node: rcdn-l-core-11.cisco.com

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


