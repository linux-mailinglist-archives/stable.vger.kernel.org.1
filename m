Return-Path: <stable+bounces-43738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D928C4771
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 21:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64150285CBA
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 19:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB92348CCC;
	Mon, 13 May 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeIvdOcl"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B94500D
	for <stable@vger.kernel.org>; Mon, 13 May 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628041; cv=none; b=jFJn44Aqtpqtx6MslFKS4UCweYSp2eE0yWalK//nTEsls/xDlVRlSXr0GnqQ8e4lQs7Fq8Wl7/fs9p89C7Mp5sgxpjdtnleDSXNDk9SBZmjkgCkpShS8iPGiFHw3NnPAZyp8oAI0tA0dmtEueWU/he4AdAtCcoAEgzpCKygJGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628041; c=relaxed/simple;
	bh=gsRGlU38aGC/i6vOs9IG/pVR8xMps9fz7PGl/PQ12Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XK7FDehruwWgfQLjwTPHMqXP5U9qEnQpknkS17syBzyniXdig9M4tV5x+SUrNe0gsG2PHASPorGCQHk1wf/Tyda72QtEZPqvaKd5JmIR74fYp7eE1JriV+m3PaXZZQUzc0etGT/RsOXnCne1w4RRnT4z5poQ4KreSNiztbI2Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeIvdOcl; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b2cc8c4b8aso610691eaf.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715628039; x=1716232839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPx8ubPL8r2qzVlha2yAdX7xGF2X7seqkeXADHLff58=;
        b=NeIvdOclqAeVjFVrgIW3H4AB5zu8EcbrJSM0NUNtI3K/NUku3b+oiUdgCt6O/t5yea
         Xv2Alv7+akKjJh4PBcJKKKlUbVI3AhZDHUMGJwXqT572BeFHCXsqf3nVpTE3zIZoB9W+
         pQ1dx9E1Yyzn98e3z0HtYZiCl/8A67z5lKjCqLZdNNU8CB8igid+f3+MRIVkgIsyaLR7
         KZ3bkInmc+0vdHVgW90PTNDmfFwBpj5o3odL2qlJ4OiQHEGdIyTPNOhhdKIOWC5iEcFa
         4YwLPjQVxvW4LDoT8/y55hXEbXQqieVOwyHMozhamogeO06mkEE3/k2E2TBoMp7BI+6s
         vlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715628039; x=1716232839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPx8ubPL8r2qzVlha2yAdX7xGF2X7seqkeXADHLff58=;
        b=m/zmsaCfcJFQSImvr2mOJNgG8xKrDSGvw6Z1sS3+7QKpJF03vk52AV/uGvLgWaBwaZ
         T4P6GrOsz92x4P1djlbPD15E7nOyZDfY/IQTwc+YXryjUWlWe6niZoZQObybjYHB+6Gm
         LE/WWMuDFiyrHUsZxM8z1Lyqm+JGNiQWWRIjiF6l6nEnpzeuMBdGIV3Yzg0/y5aVeWHd
         g4JfHe2huppFvijlhNGsZthK89i9I/U9PjDu8mGGjcbRysOHfBoPgHSOzwEq4iPcRQdM
         55JO3gUChCBzou/Q5JTF5bUGCL/Ukd8huKMG1Pq0fPLz1pue5B5pR9NFD+T4VTjhWqKV
         +ahA==
X-Gm-Message-State: AOJu0Yy12LOE7DQlcb0Pa6uvMfVbtPVR32Wg5Ifsng2Q/r4xoLXiu5hh
	TXvfRpo6Ny4Czu0iD11a/pISfK76+cEyXO0Uos1zPhKau6xoZx0XLGPn698d
X-Google-Smtp-Source: AGHT+IGhpUnTikyqAtEZB8KKKn1rephtCwZHG14VS72CnJUv0GWiW+o+/x1FJzeD+9+jq695LKRpXw==
X-Received: by 2002:a05:6358:470b:b0:193:f8ba:133d with SMTP id e5c5f4694b2df-193f8ba1359mr899395955d.4.1715628038738;
        Mon, 13 May 2024 12:20:38 -0700 (PDT)
Received: from jbongio9100214.lan (2606-6000-cfc0-0025-4c92-9b61-6920-c02c.res6.spectrum.com. [2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-634024a3eb4sm8220369a12.0.2024.05.13.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:20:38 -0700 (PDT)
From: Jeremy Bongio <bongiojp@gmail.com>
To: stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH] md: fix kmemleak of rdev->serial
Date: Mon, 13 May 2024 12:20:30 -0700
Message-ID: <20240513192030.568328-1-bongiojp@gmail.com>
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


