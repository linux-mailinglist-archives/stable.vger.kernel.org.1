Return-Path: <stable+bounces-43737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2868C4770
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 21:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9282D1F240F7
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A748CCC;
	Mon, 13 May 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzQgg0+b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D814500D
	for <stable@vger.kernel.org>; Mon, 13 May 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628032; cv=none; b=U5k1kxAfcV5EKiYD41H2AwQWMrOWjtum517qF1x3Nwj1s20zy4VP/BWb2amF+fJCRDhXwuua2orKLXELZ8T/I3eJBUyiA2lJMxMu8nK9lC+Bd5l5e1jgxRlnlVzbppU5ZJiMlrxQCqUMVwXxMNuzG6QVDudcB2sMymmROQpv60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628032; c=relaxed/simple;
	bh=gsRGlU38aGC/i6vOs9IG/pVR8xMps9fz7PGl/PQ12Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRq4g92ADS40y4OmCy/iRSAULjIf3Rhmzj8GXDcd1ra5w+MjPQgNIOCx2QIqLem8IHUSZjIZ69nJTNwbQj27ySdSAo4ymgxQ20jYdao1PpO8Irl2cxoxTz5NRWcPneZDFEQcIn91c6+nDh8/hVnpGsBwnmDVzJed/Ek9KYJ2NkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzQgg0+b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee0132a6f3so34227905ad.0
        for <stable@vger.kernel.org>; Mon, 13 May 2024 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715628030; x=1716232830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPx8ubPL8r2qzVlha2yAdX7xGF2X7seqkeXADHLff58=;
        b=fzQgg0+bOpR3sDud8SAeBjCZDOSvCn0D08+k8TXLq6W9cn5SMTzN7RtgY4jvKPMQpf
         C0ZWbxAXVivs4hsomJMzHsCPC264HFSAFGblhyla+8Zzow8NZ4936CsSK7pSQxdhrrzi
         EpZC72xoU/bldmE+P8Dh52ahAA1JaXjAisn3aKV766M+MPiH18YJBsI47mvz9tp9q9Py
         2sp9D6ql0PP1RdRNGLzl9fXJnJr6jdUtiswdJ1ZpVIRdi7KB27UfvSrnEhqVy7mxI5/r
         esVJj3ufSenE4kwCzZxRNtwGheQ5L2CNeS0ToqieuJjB3/P8oYotI1jTVvtz8m310Z/Z
         r1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715628030; x=1716232830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPx8ubPL8r2qzVlha2yAdX7xGF2X7seqkeXADHLff58=;
        b=iXzOhLAr7c8tXOfWnCRyFyOV02eXx1+Thuk46p8erRnVJu3IahvDb18FQyWbCHbsEO
         8fpJc3j9ox7wYGJNLPzE8Ibdm0bPyjPyu9abCwaLwkbTFIsOYiixAiMm7VwmnuyhQ2/p
         CQsMBMNjuqTADUdYUB6w6ySUDZAyX/8uRnmWzeWrlqiuykrsuuh2GscEC9u2u7XiM45I
         +WggDyRkvQrKCx/6y7ugue7133uDpX8474Sj5N9erBUL9CC4gBDpRx5XH3At9kNSI2LV
         EfP2txVXYRERib/UB3oHs/xd3SUhYFqhYH7qCkhr6zIQRyN4ZR4jjnLAyRnWCqGg1/Yt
         Il3A==
X-Gm-Message-State: AOJu0YwJs/+686XhETSrGGaQZYLeLQng5LIlIbHHk/EuO2n4FCTk/PP3
	MRI8Pzxz3eJMzNsS73VPfMwZRAsBBdlwnuWreo2ZnTpJUj2Vs5HKVjrKP7Ea
X-Google-Smtp-Source: AGHT+IGtaFf2yzHQgsdoP9/SMQv5qNpLFMABggEvBs4mQv0UI6H/9jpTA/b/ij+xX1BvV3V/E/PwlA==
X-Received: by 2002:a17:902:ec85:b0:1e4:b1eb:7dee with SMTP id d9443c01a7336-1ef43f4d05amr130391585ad.47.1715628029617;
        Mon, 13 May 2024 12:20:29 -0700 (PDT)
Received: from jbongio9100214.lan (2606-6000-cfc0-0025-4c92-9b61-6920-c02c.res6.spectrum.com. [2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0badcbacsm83087895ad.97.2024.05.13.12.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:20:29 -0700 (PDT)
From: Jeremy Bongio <bongiojp@gmail.com>
To: stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH] md: fix kmemleak of rdev->serial
Date: Mon, 13 May 2024 12:20:24 -0700
Message-ID: <20240513192024.568296-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

If kobject_add() is fail in bind_rdev_to_array(), 'rdev->serial' will be
alloc not be freed, and kmemleak occurs.

unreferenced object 0xffff88815a350000 (size 49152):
  comm "mdadm", pid 789, jiffies 4294716910
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f773277a):
    [<0000000058b0a453>] kmemleak_alloc+0x61/0xe0
    [<00000000366adf14>] __kmalloc_large_node+0x15e/0x270
    [<000000002e82961b>] __kmalloc_node.cold+0x11/0x7f
    [<00000000f206d60a>] kvmalloc_node+0x74/0x150
    [<0000000034bf3363>] rdev_init_serial+0x67/0x170
    [<0000000010e08fe9>] mddev_create_serial_pool+0x62/0x220
    [<00000000c3837bf0>] bind_rdev_to_array+0x2af/0x630
    [<0000000073c28560>] md_add_new_disk+0x400/0x9f0
    [<00000000770e30ff>] md_ioctl+0x15bf/0x1c10
    [<000000006cfab718>] blkdev_ioctl+0x191/0x3f0
    [<0000000085086a11>] vfs_ioctl+0x22/0x60
    [<0000000018b656fe>] __x64_sys_ioctl+0xba/0xe0
    [<00000000e54e675e>] do_syscall_64+0x71/0x150
    [<000000008b0ad622>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the change of member device")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huaweicloud.com
Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 09c7f52156f3f..67ceab4573be4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2532,6 +2532,7 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
  fail:
 	pr_warn("md: failed to register dev-%s for %s\n",
 		b, mdname(mddev));
+	mddev_destroy_serial_pool(mddev, rdev, false);
 	return err;
 }
 
-- 
2.45.0.118.g7fe29c98d7-goog


