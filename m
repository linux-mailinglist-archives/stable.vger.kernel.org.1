Return-Path: <stable+bounces-206252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84ABD01517
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 07:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CF43029EA3
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 06:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A50325714;
	Thu,  8 Jan 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AcNgBLns"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626242D6401
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855244; cv=none; b=FQADoj0niVgBknK/0buZrOAepaMoISD6FD4lz+s/8cKuX0Jsdtr0V6XM/jNHF8bT0+wf9zyUWvTIJr9Ba4YmCzDTXPPdbcblffLXnwkNjnbS5qHqeqTA34jFsIKfSJpMkQivcfWC9MERFCYDQ4LtaHneXNGUj9BStebPHVJY07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855244; c=relaxed/simple;
	bh=QTCHsVNO16iQZrixVaQuQTrLrmA3Roxcubh4/31nZXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZyaMcfe7VW4I9Yk+Qz8F289LB7PrfDXKuBmCh4VaJ9hxHh2Ib8LTwdKcqGoP0a0W5G68tP35pgWki4EfehpN6jJtV57XhGZOwsEQq3+ZDk67a459GSEMzZlos+7tGoqLp1UOXinEF3AG36gdiXRQ0ob8u+GziCUv+wLu7VolVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AcNgBLns; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c7533dbd87so2085124a34.2
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855241; x=1768460041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzc6jMotlPlOBqmj2BzruiYM6jJIxp4NUV9AgKZ5VJ8=;
        b=i32vZWTim7THkmTX692EYGxU2DRaqIu7elNKZL52ruA/IGCfLoCDpNJhfwlWAVr55/
         gOavwPa7SGXunD4rcT+SKSiEQ5mBPuVNpMk3ksFPlarOdK6ObEY4qBSqGdJB9ZdcrX+3
         V0SbZK6vqwP4TlqHgcMPg3EMujPD09fgUdatl00n7Ki+Ml99P7omFLc2pfVGiRdEMyhM
         qnAgDbB2oU4QadEl7Uhz440l/iywildm4qrK72DkP8EwhZrMrRu+Bwxcm/q80Uon84sx
         OVfe7cXVDEo95X+kIfZbs9Pofg1DF2oHR02mLs6dc1/Tk3ywFBO1HGXyxSwWvxACySb+
         MhRA==
X-Gm-Message-State: AOJu0YzV1maLPQUR+qcgRoET/78+Ln9p5ur/Q+quIHXa4HmdzhHD8Wmx
	d1Q4YwJTxri36JhFAWV9JliuC0FzmdAuccjN3osjLvF02huoSe2ILT5ew9iRMLFwDfjdMFMikIz
	6Ud9r+GaWAXCS0EK4bCVS18MqTx1bEAwfSqGr5gqxmROG76M+h5S/p0Lkze6n05BxulAVibxTJi
	8XmZOgB7qv8D1dEofsIyJV/KG61mITzs2+j68lMWcyG331H8aps5BUMk58u6UF9VMknnsj4Ht6O
	sts3m7FbPSw8DaGQA==
X-Gm-Gg: AY/fxX7mWUOtVguj4ILtKw9zPGRBWe6eYBq+764FjSwXuV3BAeR/fN+/KHXcJa/W0c/
	dbNo+M1+h7Mrx6guU01Qpx7SNLFQ4r6z1VhXp+ldrlCBEwG2/tQdm/zLicoLXEGnZSfe4zk4xKw
	UDMYYsPOSiOb7zc3GXujz/sbIn8MctmUuNwUmDrKqCNJMbTLa6FQ7+UUcQH6W+lSTXG7izvc7cQ
	PGEUwrVp2VQJ6J/XTsGQ0dU9bouSzbWaIL2UVl5++rULf8lFnnIR/a3htMvlFI8lJLPx3onf8e2
	ux865IHOUTI05cPegLKULXp7J+cpvRXAz/XlrikBMq2ibWZDi4F7WvssnX4xXfa6ZEoWLaf/0iq
	pc17gTggggLigfhuQphCwUXNRx1XUy7ij/XGITXcv3VFyvVfeP8UP8MuWbIPiSWWEw0MmTQwD4z
	CMlGvhvtxPjW76gaaKuSPxvLsHb+DYs5SLmVX6dCFXnuvHx+jTMIM=
X-Google-Smtp-Source: AGHT+IHc8/G8XH7UDskD74xwHXrjYRmPbJnWA6Blbv3FZop4ZE610ZRn0B7Q77Z3ZR/VQHQmc82pmCN5ZztQ
X-Received: by 2002:a05:6830:469b:b0:7c7:6043:dd8f with SMTP id 46e09a7af769-7ce50a98a3fmr1927658a34.15.1767855241068;
        Wed, 07 Jan 2026 22:54:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce4789e847sm1133595a34.6.2026.01.07.22.54.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 22:54:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-11f44c1b352so11109303c88.0
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 22:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767855239; x=1768460039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzc6jMotlPlOBqmj2BzruiYM6jJIxp4NUV9AgKZ5VJ8=;
        b=AcNgBLnsXF8blkFI+S3hVadeuJ4TOCpqx71LQuYX4o9n/O/l15uwb3GYdRDfVic1o9
         7Y27q6BpYx9+T2RfDh+MLn15g1/z56sVk1SX0nQEF2yf7vYaxQ2sMJ4TJYnJILS1AVAE
         DIJnIBwsAvLtcBqskeMKY9NLMiQDd4wWLI48c=
X-Received: by 2002:a05:7022:79b:b0:11d:f44c:afbc with SMTP id a92af1059eb24-121f8b5fb5cmr4806120c88.37.1767855239182;
        Wed, 07 Jan 2026 22:53:59 -0800 (PST)
X-Received: by 2002:a05:7022:79b:b0:11d:f44c:afbc with SMTP id a92af1059eb24-121f8b5fb5cmr4806050c88.37.1767855238207;
        Wed, 07 Jan 2026 22:53:58 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm12592287c88.12.2026.01.07.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:53:57 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mbloch@nvidia.com,
	parav@nvidia.com,
	roman.gushchin@linux.dev,
	markzhang@nvidia.com,
	zhao.xichao@vivo.com,
	wangliang74@huawei.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	jackm@dev.mellanox.co.il,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v6.6] RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem
Date: Wed,  7 Jan 2026 22:33:00 -0800
Message-Id: <20260108063300.670981-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit d0706bfd3ee40923c001c6827b786a309e2a8713 ]

Call Trace:

 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 strlen+0x93/0xa0 lib/string.c:420
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 get_kobj_path_length lib/kobject.c:118 [inline]
 kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
 kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
 ib_register_device drivers/infiniband/core/device.c:1472 [inline]
 ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This problem is similar to the problem that the
commit 1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
fixes.

The root cause is: the function ib_device_rename() renames the name with
lock. But in the function kobject_uevent(), this name is accessed without
lock protection at the same time.

The solution is to add the lock protection when this name is accessed in
the function kobject_uevent().

Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
Link: https://patch.msgid.link/r/20250506151008.75701-1-yanjun.zhu@linux.dev
Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Ajay: Modified to apply on v5.10.y-v6.6.y
        ib_device_notify_register() not present in v5.10.y-v6.6.y,
        so directly added lock for kobject_uevent() ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/core/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 26f1d2f29..ea9b48108 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1396,8 +1396,13 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 	dev_set_uevent_suppress(&device->dev, false);
+
+	down_read(&devices_rwsem);
+
 	/* Mark for userspace that device is ready */
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+
+	up_read(&devices_rwsem);
 	ib_device_put(device);
 
 	return 0;
-- 
2.40.4


