Return-Path: <stable+bounces-208113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26AD1259D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 12:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2973E304EBEC
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044A356A36;
	Mon, 12 Jan 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hr7s7myz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838A356A27
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218175; cv=none; b=ENpxCkHRdg8lqv/YxNHt3hMGM/ZwfGN0DqifyyKQuq/oo38kpJaUBIhJNuXpR44ifX5zUvx325/1JgJXojebfxbS6a+O1PeUhhHzj9944OCTMJuxFkc/EdOnqwzXyMkXFMDJtLpYRJgp8J6YC6gR/R5iSTefKwfrJAtUrfPj2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218175; c=relaxed/simple;
	bh=c95WO/l5Yh3ODJc5THKGAjEQryf6UWGtacSfjwHl9EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TFst8Np8WwS9sEIwb8FI1bIL6euwSIyH89t1SJrNuXZu/JZ3ImiktA6j/56ABa1Tr5VzitBHASmKpT8haab0ajXQR2QG+P4bA8HuDK5TDDn7EnwSvYYSCiNBEmXumMdwvE2Xn0+dui8KShorQU7rAS0DUzoQa2qF2n7xSiV0CHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hr7s7myz; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8be184d2fe8so120971285a.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 03:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768218173; x=1768822973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzFvHeJhDdP4ilFE2+bLWYgTIbgx2yUf1NNqPTKhjnU=;
        b=NV3GK2Nk0rKksnvFswvwvFlyWKePwc1V/iv+qMAjhnG7TNWZIegDDjf8d51gm7GZBu
         ZjDn2Vo+c/xMnMv+zfC8kJ4Ss/1GZG4eKfFjnRVu9D07AivmyE+fADV6YFqdJorcLkYS
         yZ5hPXSvIkknpprvXYNU+D1fagZtQmJCLyMCrFUY2xCVnMgISc2XXPFgwk0nX5p13pMt
         8XGJTOgIJ3/CQPN+7J1ZH8+h7vyeLvdguDoyK8LGxVZwdeDn9GUJdBXKBnPckSnaFtgi
         Wu1Pk2UbCCh/KsAUapQ9hU28QLYPqsEgD2WquZyIKRKIcKLpnEp5/Hrwmmk649QFMalW
         NQgQ==
X-Gm-Message-State: AOJu0YysKDVLsbxKRKmGiLh4xPLfqaj2khlPSFfPEUQ2uIcLrxR71iY4
	aKv+DBUgq6Rf59IKfPKfwetz3eZ+uffJXveVtzyNDdjSC9y3vhNrqfanGfurHYJIdXzjjJYQI9h
	8OOJzt/snn12893gUvvDT/yfzPTRRfLUrFfbuv4es5SGmdKbkH4VN0xVXRanqS1jPchKBo8xDXi
	VqQl2nvWnzxQn4JdC13vM7r4qjbVzJkKtQkMz50cftUDDlvg2qnEJfOcq/FBdBYJMs8lb8v5sNs
	nPwh3T58bGjYkEpVGakK4Wl27yD8sw=
X-Gm-Gg: AY/fxX5FE1oGrIQxVLwQP1fLVceAQ22PGdQhGp1HjFfyWz+E2hoMAmEQ6U1xTOsMq2w
	aCSyALZCLFK+FWqw1Jgs8rDiXZ/Kyb5oCQRDmdpqjXAS2pAvwmkof5cXfQGLhxZFZaY1ymc2qEn
	e7U4f5VNd751FILNevYu42sZj0Mf26DZb6EK6P/xLTOB1QRfUDad/PJLGpI20bEcNyLGqHcpVTQ
	W7H9ds99sCMfol1i2pGQWYMBWMhZlU9E7ZFw5ODuzKYQ9OO39Swo1l0+bbKZmBh5mdfbs3Nesk3
	Q+y8c1p24/Vt004Nv3/cZRZlAjXg2ytHvAb9Fw5bL7UDd2QmAX2JBL9Ia28AG02mRkgDpi8X10A
	mhMBMStChzrgc9fTLb8Q3/jxj9ibibKsMOSLBBpd7OEFJM6pr0/CaERmFzdEHUYYcDZBP32RDBP
	6ZA82d1IBF/eLsmLxG3gbQDIXCo9EBfER81ma6nfSSvTcAM7QEuCnjyLadjK8kBlIX
X-Google-Smtp-Source: AGHT+IG006quVcdxEg+Y62xJSirv1XnfiIxFJM+r6wWm4mb1BW5V8D7KLVjjnZrbUK9c1S5wuY9N9gEjXRxd
X-Received: by 2002:a05:620a:258e:b0:8b2:dbf7:5193 with SMTP id af79cd13be357-8c3893fbdbemr1606643185a.8.1768218172566;
        Mon, 12 Jan 2026 03:42:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c37f4d3918sm198314485a.6.2026.01.12.03.42.52
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jan 2026 03:42:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0891f819aso22119555ad.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 03:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768218169; x=1768822969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzFvHeJhDdP4ilFE2+bLWYgTIbgx2yUf1NNqPTKhjnU=;
        b=hr7s7myzXDppYeBDqEA5fUIGcoPByswxXfPxIojG06oZOGZ2UbehVKRzSLtnZiOxTh
         mNCQ82cn3Mi3UV+OXLwXEp2FEvaW23kPz2daPd7Z/A45s10k/chs9WzoX5xwpNhwOmk1
         jS4IC+P4pIuLBS3orwsEbQbRRsobQTC5q6z00=
X-Received: by 2002:a17:902:ea01:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a3ee4917d2mr129653795ad.4.1768218169419;
        Mon, 12 Jan 2026 03:42:49 -0800 (PST)
X-Received: by 2002:a17:902:ea01:b0:2a0:9424:7dc7 with SMTP id d9443c01a7336-2a3ee4917d2mr129653635ad.4.1768218168930;
        Mon, 12 Jan 2026 03:42:48 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c0asm175905495ad.31.2026.01.12.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:42:47 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tj@kernel.org,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Laibin Qiu <qiulaibin@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v5.15] blk-throttle: Set BIO_THROTTLED when bio has been throttled
Date: Mon, 12 Jan 2026 11:39:36 +0000
Message-ID: <20260112113936.3291786-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Laibin Qiu <qiulaibin@huawei.com>

[ Upstream commit 5a011f889b4832aa80c2a872a5aade5c48d2756f ]

1.In current process, all bio will set the BIO_THROTTLED flag
after __blk_throtl_bio().

2.If bio needs to be throttled, it will start the timer and
stop submit bio directly. Bio will submit in
blk_throtl_dispatch_work_fn() when the timer expires.But in
the current process, if bio is throttled. The BIO_THROTTLED
will be set to bio after timer start. If the bio has been
completed, it may cause use-after-free blow.

BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70
Read of size 2 at addr ffff88801b8902d4 by task fio/26380

 dump_stack+0x9b/0xce
 print_address_description.constprop.6+0x3e/0x60
 kasan_report.cold.9+0x22/0x3a
 blk_throtl_bio+0x12f0/0x2c70
 submit_bio_checks+0x701/0x1550
 submit_bio_noacct+0x83/0xc80
 submit_bio+0xa7/0x330
 mpage_readahead+0x380/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Allocated by task 26380:
 kasan_save_stack+0x19/0x40
 __kasan_kmalloc.constprop.2+0xc1/0xd0
 kmem_cache_alloc+0x146/0x440
 mempool_alloc+0x125/0x2f0
 bio_alloc_bioset+0x353/0x590
 mpage_alloc+0x3b/0x240
 do_mpage_readpage+0xddf/0x1ef0
 mpage_readahead+0x264/0x500
 read_pages+0x1c1/0xbf0
 page_cache_ra_unbounded+0x471/0x6f0
 do_page_cache_ra+0xda/0x110
 ondemand_readahead+0x442/0xae0
 page_cache_async_ra+0x210/0x300
 generic_file_buffered_read+0x4d9/0x2130
 generic_file_read_iter+0x315/0x490
 blkdev_read_iter+0x113/0x1b0
 aio_read+0x2ad/0x450
 io_submit_one+0xc8e/0x1d60
 __se_sys_io_submit+0x125/0x350
 do_syscall_64+0x2d/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 0:
 kasan_save_stack+0x19/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x1b/0x30
 __kasan_slab_free+0x111/0x160
 kmem_cache_free+0x94/0x460
 mempool_free+0xd6/0x320
 bio_free+0xe0/0x130
 bio_put+0xab/0xe0
 bio_endio+0x3a6/0x5d0
 blk_update_request+0x590/0x1370
 scsi_end_request+0x7d/0x400
 scsi_io_completion+0x1aa/0xe50
 scsi_softirq_done+0x11b/0x240
 blk_mq_complete_request+0xd4/0x120
 scsi_mq_done+0xf0/0x200
 virtscsi_vq_done+0xbc/0x150
 vring_interrupt+0x179/0x390
 __handle_irq_event_percpu+0xf7/0x490
 handle_irq_event_percpu+0x7b/0x160
 handle_irq_event+0xcc/0x170
 handle_edge_irq+0x215/0xb20
 common_interrupt+0x60/0x120
 asm_common_interrupt+0x1e/0x40

Fix this by move BIO_THROTTLED set into the queue_lock.

Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220301123919.2381579-1-qiulaibin@huawei.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Remove 'out' and handle return with reference to commit 81c7a63 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 block/blk-throttle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4bf514a7b..4d3436cd6 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2216,8 +2216,10 @@ bool blk_throtl_bio(struct bio *bio)
 	rcu_read_lock();
 
 	/* see throtl_charge_bio() */
-	if (bio_flagged(bio, BIO_THROTTLED))
-		goto out;
+	if (bio_flagged(bio, BIO_THROTTLED)) {
+		rcu_read_unlock();
+		return false;
+	}
 
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
 		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
@@ -2225,8 +2227,10 @@ bool blk_throtl_bio(struct bio *bio)
 		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 	}
 
-	if (!tg->has_rules[rw])
-		goto out;
+	if (!tg->has_rules[rw]) {
+		rcu_read_unlock();
+		return false;
+	}
 
 	spin_lock_irq(&q->queue_lock);
 
@@ -2310,14 +2314,14 @@ bool blk_throtl_bio(struct bio *bio)
 	}
 
 out_unlock:
-	spin_unlock_irq(&q->queue_lock);
-out:
 	bio_set_flag(bio, BIO_THROTTLED);
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
 		bio->bi_issue.value |= BIO_ISSUE_THROTL_SKIP_LATENCY;
 #endif
+	spin_unlock_irq(&q->queue_lock);
+
 	rcu_read_unlock();
 	return throttled;
 }
-- 
2.40.4


