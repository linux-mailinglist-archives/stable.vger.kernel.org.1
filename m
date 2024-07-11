Return-Path: <stable+bounces-59163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDAE92F04D
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 22:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715641F2310E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792D19E82B;
	Thu, 11 Jul 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="phnp6ar0"
X-Original-To: stable@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E913D626
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729811; cv=none; b=EgNF+xevOi2MVUGDjb79CKjd0cUm6nCYsnjx+CzuNY6/UeqDcceg0MErPdlHXkYoUbni3OMk8q9NVaUkyzr1ossV4HHqW8C23I/ecMAN55Bsa1LUM3Hxd+5pLzfs64WuhMKE3fcBaNig9etGdQDYA/CiZjmzByHOmsRL9qSKngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729811; c=relaxed/simple;
	bh=Q8J4u+TRue0SPONN75ke4O5RBuo7YiRTdfcxYd743y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YppXT1VcHOLulcIbSK9AkSLFXbWYcv8cnYM5Bc72BigwXVtKCtzhMP92GWB0xEMd1fWBbZgtsRkP5JgWkpCiaqxs/e5wRkj/SeQwRmebZoebY1i6OMAHJdnizZVbq7oGdoz8hC3xYT/zXLOoTIVOSs24W4wfXfE8asgDuMBEw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b=phnp6ar0; arc=none smtp.client-ip=193.222.135.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 38260 invoked from network); 11 Jul 2024 22:23:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1720729406; bh=N6X9s7DMvS4stOXC63Qh/ErDHC3LOgu0EjpBk7+EkOE=;
          h=From:To:Cc:Subject;
          b=phnp6ar0kMcwf1akCDf+9+zLCRr/I1uB3sshilQ/BMeuDTajBw+bw2If7k09R6kv8
           JGGxCQncjJiftKxWL0qs4bAczezOZcTsUB51wvvguP0tU1x9rUlVk6x0Q8nAUXA+Ay
           gQwRCYVp8gmPVd6GgXbPhGPWkmjAH4zaZOi3mKAk=
Received: from aafe223.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.134.223])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-raid@vger.kernel.org>; 11 Jul 2024 22:23:25 +0200
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	stable@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: [PATCH] md/raid1: set max_sectors during early return from choose_slow_rdev()
Date: Thu, 11 Jul 2024 22:23:16 +0200
Message-Id: <20240711202316.10775-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <349e4894-b6ea-6bc4-b040-4a816b6960ab@huaweicloud.com>
References: <349e4894-b6ea-6bc4-b040-4a816b6960ab@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 845761608838002fc020863bb3b1a580
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [MSPU]                               

Linux 6.9+ is unable to start a degraded RAID1 array with one drive,
when that drive has a write-mostly flag set. During such an attempt,
the following assertion in bio_split() is hit:

	BUG_ON(sectors <= 0);

Call Trace:
	? bio_split+0x96/0xb0
	? exc_invalid_op+0x53/0x70
	? bio_split+0x96/0xb0
	? asm_exc_invalid_op+0x1b/0x20
	? bio_split+0x96/0xb0
	? raid1_read_request+0x890/0xd20
	? __call_rcu_common.constprop.0+0x97/0x260
	raid1_make_request+0x81/0xce0
	? __get_random_u32_below+0x17/0x70
	? new_slab+0x2b3/0x580
	md_handle_request+0x77/0x210
	md_submit_bio+0x62/0xa0
	__submit_bio+0x17b/0x230
	submit_bio_noacct_nocheck+0x18e/0x3c0
	submit_bio_noacct+0x244/0x670

After investigation, it turned out that choose_slow_rdev() does not set
the value of max_sectors in some cases and because of it,
raid1_read_request calls bio_split with sectors == 0.

Fix it by filling in this variable.

This bug was introduced in
commit dfa8ecd167c1 ("md/raid1: factor out choose_slow_rdev() from read_balance()")
but apparently hidden until
commit 0091c5a269ec ("md/raid1: factor out helpers to choose the best rdev from read_balance()")
shortly thereafter.

Cc: stable@vger.kernel.org # 6.9.x+
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Fixes: dfa8ecd167c1 ("md/raid1: factor out choose_slow_rdev() from read_balance()")
Cc: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Paul Luse <paul.e.luse@linux.intel.com>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Link: https://lore.kernel.org/linux-raid/20240706143038.7253-1-mat.jonczyk@o2.pl/

--

Tested on both Linux 6.10 and 6.9.8.

Inside a VM, mdadm testsuite for RAID1 on 6.10 did not find any problems:
	./test --dev=loop --no-error --raidtype=raid1
(on 6.9.8 there was one failure, caused by external bitmap support not
compiled in).

Notes:
- I was reliably getting deadlocks when adding / removing devices
  on such an array - while the array was loaded with fsstress with 20
  concurrent processes. When the array was idle or loaded with fsstress
  with 8 processes, no such deadlocks happened in my tests.
  This occurred also on unpatched Linux 6.8.0 though, but not on
  6.1.97-rc1, so this is likely an independent regression (to be
  investigated).
- I was also getting deadlocks when adding / removing the bitmap on the
  array in similar conditions - this happened on Linux 6.1.97-rc1
  also though. fsstress with 8 concurrent processes did cause it only
  once during many tests.
- in my testing, there was once a problem with hot adding an
  internal bitmap to the array:
	mdadm: Cannot add bitmap while array is resyncing or reshaping etc.
	mdadm: failed to set internal bitmap.
  even though no such reshaping was happening according to /proc/mdstat.
  This seems unrelated, though.
---
 drivers/md/raid1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7b8a71ca66dd..82f70a4ce6ed 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -680,6 +680,7 @@ static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
 		len = r1_bio->sectors;
 		read_len = raid1_check_read_range(rdev, this_sector, &len);
 		if (read_len == r1_bio->sectors) {
+			*max_sectors = read_len;
 			update_read_sectors(conf, disk, this_sector, read_len);
 			return disk;
 		}

base-commit: 256abd8e550ce977b728be79a74e1729438b4948
-- 
2.25.1


