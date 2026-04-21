Return-Path: <stable+bounces-240078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACWRDVQ052mO5QEAu9opvQ
	(envelope-from <stable+bounces-240078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F229F438186
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CECD3058DF3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A14399345;
	Tue, 21 Apr 2026 08:21:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F788392C2E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759662; cv=none; b=m5ZU5s12X3N7OpZN3FlxKkwXKXKbox1oZM0QOT2wKxGbGmY18goQtZR3zrmJTS9n/06oR9XPhjMN4IJBYE4pZomBmo1dpgQxoLAuxpCqFegPFiTqglv7MmJ4AGDy8lbRTTJ/ht2rlWBvEVLNaX5xZiEmOUE6lxfDvdPM8oaaypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759662; c=relaxed/simple;
	bh=JMnXHB7mKXVqc2ojkQK+/CLOa6afqFn2b36u+UCMXdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H74FIQs1sn575oEzwEOInwwPWZ+XDfaPOXkNJKPc2lXEP59Fu7lqM+FsgKevLc2Y2yIQlFivY1+w4BxgPHTZSCXGfdS1YasuSumzh1GyP0xP/pf2iGECaNlvglqgbmBj1ea5yK1ejCOZkr2D9utQk4mTuiBxSsgXzyfKBC59dwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:0.1606439819
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-223.104.44.125 (unknown [10.158.243.18])
	by mail.189.cn (HERMES) with SMTP id 5537B40029D;
	Tue, 21 Apr 2026 16:20:55 +0800 (CST)
Received: from  ([223.104.44.125])
	by gateway-153622-dep-76cc7bc9cd-8dbpn with ESMTP id 1a09f3312aad4edf82643683fa43cebd for yukuai3@huawei.com;
	Tue, 21 Apr 2026 16:20:56 CST
X-Transaction-ID: 1a09f3312aad4edf82643683fa43cebd
X-Real-From: charles_xu@189.cn
X-Receive-IP: 223.104.44.125
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: charles_xu@189.cn
To: yukuai3@huawei.com,
	harshit.m.mogalapalli@oracle.com,
	stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 6.6.y] md/raid1,raid10: don't ignore IO flags
Date: Tue, 21 Apr 2026 16:20:53 +0800
Message-Id: <20260421082053.5330-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240078-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TO_DN_NONE(0.00)[];
	FROM_NO_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[189.cn:mid,189.cn:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: F229F438186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yu Kuai <yukuai3@huawei.com>

commit e879a0d9cb086c8e52ce6c04e5bfa63825a6213c upstream.

If blk-wbt is enabled by default, it's found that raid write performance
is quite bad because all IO are throttled by wbt of underlying disks,
due to flag REQ_IDLE is ignored. And turns out this behaviour exist since
blk-wbt is introduced.

Other than REQ_IDLE, other flags should not be ignored as well, for
example REQ_META can be set for filesystems, clearing it can cause priority
reverse problems; And REQ_NOWAIT should not be cleared as well, because
io will wait instead of failing directly in underlying disks.

Fix those problems by keep IO flags from master bio.

Fises: f51d46d0e7cb ("md: add support for REQ_NOWAIT")
Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
Fixes: 5404bc7a87b9 ("[PATCH] Allow file systems to differentiate between data and meta reads")
Link: https://lore.kernel.org/linux-raid/20250227121657.832356-1-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
[ Harshit: Resolve conflicts due to missing commit: f2a38abf5f1c
  ("md/raid1: Atomic write support") and  commit: a1d9b4fd42d9
  ("md/raid10: Atomic write support") in 6.12.y, we don't have Atomic
  writes feature in 6.12.y ]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Based on Harshit's backport for 6.12, fixed minor conflicts for 6.6. ]
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/md/raid1.c  | 4 ----
 drivers/md/raid10.c | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4c1f86ca5520..d313e9834d44 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1214,8 +1214,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	struct raid1_info *mirror;
 	struct bio *read_bio;
 	struct bitmap *bitmap = mddev->bitmap;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	int rdisk;
 	bool r1bio_existed = !!r1_bio;
@@ -1315,7 +1313,6 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_iter.bi_sector = r1_bio->sector +
 		mirror->rdev->data_offset;
 	read_bio->bi_end_io = raid1_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &mirror->rdev->flags) &&
 	    test_bit(R1BIO_FailFast, &r1_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1537,7 +1534,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 		mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
 		mbio->bi_end_io	= raid1_end_write_request;
-		mbio->bi_opf = bio_op(bio) | (bio->bi_opf & (REQ_SYNC | REQ_FUA));
 		if (test_bit(FailFast, &rdev->flags) &&
 		    !test_bit(WriteMostly, &rdev->flags) &&
 		    conf->raid_disks - mddev->degraded > 1)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 8546ef98bfa7..6bcf6852c200 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1168,8 +1168,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 {
 	struct r10conf *conf = mddev->private;
 	struct bio *read_bio;
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	int max_sectors;
 	struct md_rdev *rdev;
 	char b[BDEVNAME_SIZE];
@@ -1250,7 +1248,6 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 	read_bio->bi_iter.bi_sector = r10_bio->devs[slot].addr +
 		choose_data_offset(r10_bio, rdev);
 	read_bio->bi_end_io = raid10_end_read_request;
-	read_bio->bi_opf = op | do_sync;
 	if (test_bit(FailFast, &rdev->flags) &&
 	    test_bit(R10BIO_FailFast, &r10_bio->state))
 	        read_bio->bi_opf |= MD_FAILFAST;
@@ -1267,9 +1264,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 				  struct bio *bio, bool replacement,
 				  int n_copy)
 {
-	const enum req_op op = bio_op(bio);
-	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
-	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
@@ -1295,7 +1289,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	mbio->bi_iter.bi_sector	= (r10_bio->devs[n_copy].addr +
 				   choose_data_offset(r10_bio, rdev));
 	mbio->bi_end_io	= raid10_end_write_request;
-	mbio->bi_opf = op | do_sync | do_fua;
 	if (!replacement && test_bit(FailFast,
 				     &conf->mirrors[devnum].rdev->flags)
 			 && enough(conf, devnum))
-- 
2.35.3


