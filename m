Return-Path: <stable+bounces-112000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D572A25732
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FC11883E38
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9F20102E;
	Mon,  3 Feb 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="jR3rUWX3"
X-Original-To: stable@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79259201009
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579446; cv=none; b=fahuGLZ2cc4OHiRL0Y8rLk/F1b1TwpqJ5TQZ1BKUziyUv2llD3ZtFj5Z5p0WLgRWDnVPmvlRayaBD6SKf8+URNbV521H1hH5CdYKy66NeCNZoHTOTqZEKq6YkJ5qfOw48RYxFsquOx5JdBXqYOkuWrRr0vZ4iYVhOyaZfw4CncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579446; c=relaxed/simple;
	bh=RrFQ3aiu7p8FdCgtZ24NAWcI608oc+9FqIZSsKDaHFU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m8kW5P4URgR8x5URhO+MKi5MhRos4v7OS2Tz/84ndDj/ebtLgdZwWuxGB2nq5FwhM6cmXCdeaImMWAWsZ5QwIdosPlk03rIguwPFQsaUsRbLC2s/KAuuf0Xpn6m29ZoCMKb9VBLAgwapstLNZ4vaLDS/9JKAd3rFVYxsEHWPzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=jR3rUWX3; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2474; q=dns/txt; s=iport;
  t=1738579444; x=1739789044;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRGxoKt8rjpieXph/y9GqL7UGmEVAGyzjb2VfxbcC28=;
  b=jR3rUWX3EjCfEQukMAsQqfQrzSOSHlpWFZm1dERrirfm6+VFET6MSDRk
   INjaHdJbUGFHRfkdE32yDn3tJnT+2FVndHGEiBHsNhiInOGWz3ADS6/k/
   sDN0aYHHQ9GirR66x1rmUfi/gz1L+sE0MfAG7PIqhe6ChqOVMAfdeDBon
   0=;
X-CSE-ConnectionGUID: 4fsEOs2FRLmQo4eFTKaU/Q==
X-CSE-MsgGUID: q7JaN9j4SdiZH680x1qA2A==
X-IPAS-Result: =?us-ascii?q?A0A5AABonaBn/43/Ja1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCSXZaQkiEVYgdhzKCIYt2jEeFXIElA1YPAQEBDzkLBAEBkAUCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThXsNSQEMA?=
 =?us-ascii?q?YYtBAsBdgUCHwcCLUSDAgGCZAIBEbEaen8zgQHeM4FoBoEaLgGITQGEe3CEd?=
 =?us-ascii?q?ycbgUlEgRWBO4ItgQWBXAQYghODDoJHIgSEIYM/olBIgQUcA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBcQM1DAswFTKBF0Q3gkdpSToCDQI1gh58giuEXIRDXy8DAwMDgzaFXYISg?=
 =?us-ascii?q?guHcB1AAwsYDUgRLDcUGwY9AW4HnTQBPINIJiCBDhQYUIFEkziSO6EEhCWMG?=
 =?us-ascii?q?JUuGjOqUy6HWwmPcXmOBJZEhGaBZzyBWU0jFYMiUhkPji0LCxaIVcJ3IjUCO?=
 =?us-ascii?q?gIHAQoBAQMJjUCEOgEB?=
IronPort-Data: A9a23:NZUb5KmaW+06tHyMK+zIsZTo5gzGJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZWW3UP/+OMzSjKdoib4+w9h8F6JTSyIAyHgJr+3xmHltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pa31GONgWYubzpOs/nb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FdEW4ctQGjtgz
 9gdETdRYz6/pOuLh4vuH4GAhux7RCXqFJkUtnclyXTSCuwrBMifBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYz/7C7pm9AusrmLnbiZYsFGcjaE2+GPUigd21dABNfKOI4fRH5wKwBfwS
 mTu5jvbCzdLNoCkxTu30iz83v+WhAqhcddHfFG/3rsw6LGJ/UQIFBQcUVaTv/a0kAi9VshZJ
 khS/TAhxZXe72SxRdX7Ghn9q3mes1tEB5xbEvYx70eGza+8DxulO1XohwVpMLQO3PLajxRwv
 rNVt7sF3QBSjYA=
IronPort-HdrOrdr: A9a23:SH7x+qitX0Hi62gMvnEgGePBBHBQXtEji2hC6mlwRA09TyX+rb
 HKoB17726XtN9/Yh8dcLy7VZVoIkmslqKdn7NxAV7KZmCP0wGVxepZgrcKrQeNJ8SHzI5gPW
 MKSdkYNDU2ZmIK6frH3A==
X-Talos-CUID: 9a23:MDr8Pm7Z6L2wd7NUEtssqEAPN+c+KFPn6HLpJBO1J1pKQYDScArF
X-Talos-MUID: =?us-ascii?q?9a23=3ADM39bQ4K6Al9Vwy7icxp0VqOxoxxvIanLhEPza4?=
 =?us-ascii?q?Kuvuka3woK26EpW6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,255,1732579200"; 
   d="scan'208";a="313321769"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Feb 2025 10:42:55 +0000
Received: from sjc-ads-1396.cisco.com (sjc-ads-1396.cisco.com [171.70.59.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id 6A1AA1800019E
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 10:42:55 +0000 (GMT)
Received: by sjc-ads-1396.cisco.com (Postfix, from userid 1839047)
	id E47D2CC128E; Mon,  3 Feb 2025 02:42:54 -0800 (PST)
From: Shubham Pushpkar <spushpka@cisco.com>
To: stable@vger.kernel.org
Subject: [Fix CVE-2024-50217 in v6.6.y] [PATCH] btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()
Date: Mon,  3 Feb 2025 02:42:54 -0800
Message-Id: <20250203104254.4146544-1-spushpka@cisco.com>
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
X-Outbound-Node: rcdn-l-core-04.cisco.com

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


