Return-Path: <stable+bounces-43747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 606F08C48F0
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E143DB21996
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB329D02;
	Mon, 13 May 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feKgciO9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C011C683
	for <stable@vger.kernel.org>; Mon, 13 May 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636394; cv=none; b=P1PMOGt/aztdqk82E4Fv/+nYqfWS+ClMLKiRIisa4iC4Ow5Zj8m3eRvl1k+E0yh2kkjKBZZeqP2jSPz0twz5kXN1gWOAJqWTDEqOXCq5GMfz+cFfadiloWFj1OMl/jDQF2Zh1YTPbrx+P8v8zTP3hskG+DeiuXcuwtzJapUjXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636394; c=relaxed/simple;
	bh=nrlZIzijaTAEw9zZNlCRqJzr7vpLy0At9EM7iqKSV6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqifA4MVgYWKECcYXkGHgr53LBgqS0q39pANYkPZQHGlSZPZajjyua+n95c4WHYmUd3T5GFAaLyYCH8/3s6v0/c9cicsA5rOhlndV72z8HasNwOiQeGmVGfB+OAOnx3B8tnjrqyI4U+eyFtJ1RCwgfNgi/CC0jy+5fG0DpyEyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feKgciO9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4178aec15so4187370b3a.0
        for <stable@vger.kernel.org>; Mon, 13 May 2024 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715636392; x=1716241192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtU63YNrPI/7u5Orp7cTa8wRIA9O07NcSaIA7SGyRjc=;
        b=feKgciO9+gEkJVrySjQruwXGvz3fkax4h+etJGFw5uApuQJaaNgEYAqQ0J3fvAxBa+
         OPnJQVKlQiuilwKTxJKauib+ecCGI+QWrhM95yOfljNQAmeJNdSWsg9oal5NYHvUuz92
         EpyzDD/536O1SK7K4ATl5/pEMu/L3dIJpohrHDYOcW060ocIOuIkhZfvnViwXUF5nocc
         GHV67a6dDlYhmq9mHArHFcukX02zFTNXyohugixi1pPGWSmOmlX+KM2aCcpYBMpJ2AjM
         NtEwNBVhoM6ta6Gw4GzLs02MmI7G84j15ELS2Ne+HUFxsYKOSrrOI48Y16u5NLGRNY1a
         Nt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715636392; x=1716241192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtU63YNrPI/7u5Orp7cTa8wRIA9O07NcSaIA7SGyRjc=;
        b=ZEZNgac1wpvghtqG3CvukorSbasehct3lG/K2iHtyuWe68VTXvYpWG6JzzuW4JTMjk
         CwTTpe9BGVGf2HxsZQX7uPn6GQ9krIbcelF7yeHC9hl6CnTieLPX1QzXGOOTTxcZ/G3Q
         /yjW2kSgSFMUCJ4DEd2O7YHo1NI28houLrlbrNo5vkw2hGrboMdq9ArIInhgOA/VWaiC
         5XJmDWmwflPxrMurMOq4lrJY+9B/1bsi+XVIxAmt1v8TUOjwG4ZHdSCqIu+k8t30gPt8
         uL1e6XrUopAXIeL7oR+0O985uLHfwKwy79F9qLBsslwzE9V95N+kz1n1zvyxC58tHB//
         1N9Q==
X-Gm-Message-State: AOJu0YypFpbHkSTtkEXfntkP+CFS5b547bpVvAUfaW3V/zRUibCmZueb
	3VfdNFzUfhL+TI9jVysm7wZ5JfHyfX/CQPlRDQ3/botNzSNFHZvZXucLDh+21rU=
X-Google-Smtp-Source: AGHT+IGCL46ScsIZ9A9PQdKNiBelOrn8k049OvykJNaXibF7d4KhYBc7okIrV3EnnLrruSpGNGkzaw==
X-Received: by 2002:a05:6a20:430e:b0:1af:dd77:86ab with SMTP id adf61e73a8af0-1afde1faeadmr10903929637.54.1715636392030;
        Mon, 13 May 2024 14:39:52 -0700 (PDT)
Received: from jbongio9100214.lan (2606-6000-cfc0-0025-4c92-9b61-6920-c02c.res6.spectrum.com. [2606:6000:cfc0:25:4c92:9b61:6920:c02c])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b5e02c1127sm8356055a91.1.2024.05.13.14.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:39:51 -0700 (PDT)
From: Jeremy Bongio <bongiojp@gmail.com>
To: stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>,
	Jeremy Bongio <jbongio@google.com>
Subject: [PATCH] md: fix kmemleak of rdev->serial
Date: Mon, 13 May 2024 14:39:38 -0700
Message-ID: <20240513213938.626201-1-bongiojp@gmail.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

commit 6cf350658736681b9d6b0b6e58c5c76b235bb4c4 upstream.

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

backport change:
mddev_destroy_serial_pool third parameter was removed in mainline,
where there is no need to suspend within this function anymore.

Fixes: 963c555e75b0 ("md: introduce mddev_create/destroy_wb_pool for the change of member device")
Signed-off-by: Li Nan <linan122@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240208085556.2412922-1-linan666@huaweicloud.com
Change-Id: Icc4960dcaffedc663797e2d8b18a24c23e201932
Signed-off-by: Jeremy Bongio <jbongio@google.com>
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


