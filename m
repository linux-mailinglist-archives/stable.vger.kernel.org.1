Return-Path: <stable+bounces-43752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4E8C4A0E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 01:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551021F21AAC
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4A85284;
	Mon, 13 May 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNQ24EZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50296446BD
	for <stable@vger.kernel.org>; Mon, 13 May 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643063; cv=none; b=HB6jWHJ4f8GQ+S27/mPDjWRYyxUpTTvGx7psc16oLlup4+bY4ld4SB0yLcOORDYVnsOp5OBMAR1AZh3Nd2P+NR6/PRUe3G6CQGkOkSc54b+96dK6/1Hu0Hdlrz5lOfw/vz0HZkXMpWxFHw/m7NpPwBrWTebn3pXnhY4cwsbED4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643063; c=relaxed/simple;
	bh=QUSk2PE035PMUfItgdSu60ZAlqjFlA426+oswFdBl20=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XrAMpMQBww/f0mzxu76Um3U8CAxOn9IhbOJcxe2pXhYP3lDRoqgWokIdspBtkSMIGgOAtG8gLedT/ETbcurpiN20BpB4WEJw6QaznSYICJ5G6ohVIFM09mmIp0PuYsxovXgXq9nIUWl4uLL8m9KzPzL8P1cSmGku4aDojaWDxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNQ24EZZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-618a2b1a441so4362666a12.0
        for <stable@vger.kernel.org>; Mon, 13 May 2024 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715643061; x=1716247861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaxvBH4y+VWBXQmGsD8ebjpfQuiCbD/cpXxCcmwWLSw=;
        b=tNQ24EZZ7LF3E+WTHFHH9i+UEzXKCbHsY3GHGaxZPUPd2NL6slEbRq+cLvuP9XYOqq
         dL/gVZgYB+2knsADJ4E/SOQRR47OMJBU9wtZQJa1WjGAk0Vf+iKvFMM5vfrD5WJ2XNwk
         MEgTLrXGNPXYQVZNc3GNKVrpfGtJQNBLYcweyie1BW7rVIZRIAT0RQWGvbawABJIKzan
         oCj1nlrwMuNjJNE7th4o0s9Sbg8Je0xZBAbhjnr9ZzBC4L6VGew7Qf2GA9y/ESj0FP5H
         P97IOgGzLjWrsUPGp+bXuvsszA0dHR58cU7vM/OtdMXtJrVYHNBeq0C6F1QMjwoKUsiw
         Wghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715643061; x=1716247861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaxvBH4y+VWBXQmGsD8ebjpfQuiCbD/cpXxCcmwWLSw=;
        b=AXEcvEI0NzRtzZQo5h2NoqwYMxeC6s6m1ysgFiXJSigjksXveU5Y8BQIpX61oigxyN
         RNFVmIbx4mUPyTQhrvarZBoOrazYGf2+dAaJrafDRfUAZhgIy34ECa9XcDnwhzJUBEar
         k4NKFL2nybh2A2mnNVv8QQdfCwrdciBBb6iXGh2NdYE6SvMSgnySsxH6w3UQYsqBAbTY
         gYiOQaB8CMYrlw/85JFrQRCPRn0kKEPyKpEQV/QH5D0bq2deoq5jT+LAFFBB6K5H7x23
         G4JfgTLCqEOLYsCK7cj4fcS4hyejvNAMZkrxDK/RlihQrauydXBrAYyWAbRNOVUDokEy
         W3gg==
X-Gm-Message-State: AOJu0YyaCPMoQDEVYccYNI49UwMulQQVL/2PLYcFK5tmRZlucavKUH/d
	5A4sCLcaaeR4GhctIL9KzQ1R5ZX+sYKmQ5fC8OnJA60MMESi244IDT0bzfEFnl9sA7vV/rlaPYO
	2WCdpyFYA+zqdmkANl/LXOQO7nyJ/nfhWENGhqVP54Rf2PX122TuZVBddFk3gTO6/zyuFl4h/W+
	TRSNPK1qycUZW+I2ITFJn6FfXKPbQJVJ1ysuqJKg==
X-Google-Smtp-Source: AGHT+IEICmRWN+gEp8rmz5+w3ePcOs/aQEGHlsju/hyzyWBgldT0yaV8ov8o0hy8nW8tj+QtHXSOMMDEmoH1
X-Received: from jbongio-kernel-in-cloud.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3309])
 (user=jbongio job=sendgmr) by 2002:a17:90a:d48c:b0:2af:b21b:6432 with SMTP id
 98e67ed59e1d1-2b6c733c523mr62029a91.2.1715643061280; Mon, 13 May 2024
 16:31:01 -0700 (PDT)
Date: Mon, 13 May 2024 23:30:58 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240513233058.885052-1-jbongio@google.com>
Subject: [PATCH] md: fix kmemleak of rdev->serial
From: Jeremy Bongio <jbongio@google.com>
To: stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>, Song Liu <song@kernel.org>, 
	Jeremy Bongio <jbongio@google.com>
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Jeremy Bongio <jbongio@google.com>
---

This backport is tested on LTS 5.10, 6.1, 6.6

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


