Return-Path: <stable+bounces-192341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03563C2FEBF
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96CF1941291
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBEF31280A;
	Tue,  4 Nov 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI27BKKo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5B311972
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244894; cv=none; b=r/Nn7L3mUaHi0k+V96feAS01Pm9QlCXk+7rZF+BzGSOvc+mBkw65L7cMeX8zNLyexkyJyAJQtamaC0T/1q40SeA80DJ/AnPaeGda2pBis2FF2TdqGMcrau1tzYaqEwQVUou03G/d+nI9nfKzJ8sAssHxtYnw9nLrXU0lRmDYGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244894; c=relaxed/simple;
	bh=LqIk0BpxBLI5IJn6XweWFJYr1RRUDL4M/FAHdXfNl+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZkUX9TeJFceDtsrFiSrQnN7dJaMpD1/RgULZuVfpJidJN5AA68ivqPGELT8pqo2+6npuTqu+1weMR5p5xkkZTFcRSi4TTZ3h4dntiOi1aHEAwwIu+O+LzZYcB/ACVoTMRkMUsqeqFMjm+5Dsy36WgPdxvLuE0nXAJzZFlLzm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI27BKKo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3410c86070dso1508646a91.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762244891; x=1762849691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFICcE+Vtbf0TwZWSrWoxdS8zOuWh2Ntsa14GnmIyDk=;
        b=UI27BKKoSEV1WJsjVDILbG6caTpFTU2mXKtb++LnEQo17B55L4apOche09aW38MhfR
         7RYjAUSICeIQ7nH/7ZULt6uHNfgnf9+APlqAr0cKchyRb1aWpk4+r1YSM3kUNXjYCgab
         aOFVLCsciYWuo8U5Pt/djQlJ1igvP2UXP5TiD47HtvStMoYFWfE6+8UTYInIm8rfqJ2y
         PFBf6ikwJ3Sx0vtCPAzmYXRoXt+c3Hhk7G4Lw+NuUiOQmZnbOOKkyibMtRR7Ahib52ta
         XMu/YXRioCx26W3Rr+25ixo6yosaA9m2zNARFzoQYijcbY1NmyDht5roIEdA9WWmtKIE
         zdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244891; x=1762849691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFICcE+Vtbf0TwZWSrWoxdS8zOuWh2Ntsa14GnmIyDk=;
        b=tGXUz60Qw40fsWGXNWVMu7bkgV6Y96aFvrqk19YaE48N+XHA+Pw2cxGO5ZAH2xfa/X
         GJJcSMa2gb3CJkxH4sTKqYQS2gUp2CIiFp3xk6W/XfLDSARM6dGiMMbvbNIODVSTB1F7
         qmYRS4JYMr+6YWfNbGoN+6hcZ7gT84CZ044yM6R55adgoHSdbw2S5J6Nc8BRl4IzOGAX
         nxdhWHCI1LefxcR3vsacvted8UefLIo8EoDdCO/cCecNMZ/699Cdajx7t1zL8U7KpAhw
         9Y0+NxRTvuJ4LZ9u04HFj6/BzcadbagFpNwOZ/qEortndzMFvcKM6Lz3ItxCRNEsBx/o
         BpyA==
X-Forwarded-Encrypted: i=1; AJvYcCX5FKC3lcDspQVe6zyWx5AngYOpWcRgHwwRDJODh/yn3SPt8AQIzmnJjrZkWj5qAE9c6ULQZOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQLdV1Gts/2Lgiwv0KZLyoliRbwAcVAyIU4YCWLQrH37oobhO
	90AOp7mRq77wne/jZcDP5NiopNPS5ASv7rhER7rVkr7CmVRInLEUu5ZZ
X-Gm-Gg: ASbGncvokU+TQM+Ezr58ue6SuT0G6pCUlsrs6B4evMa9D2ZCiqQPNkqrUOc/eRVYrun
	tJXiYL1lT+OTTg/hVpXWjt1uGmQ9YE+7s8AofeYVdX3DFE8Xs7o5WFUo5c7GcQ2R0C4NXnvHT2U
	swk3J0cyzCKG09v2aojOvRLU7Q5hXIfb25XieHTJRVRb/Xlx6tr9k/3hb5cIN/QkmteDpKl1b5J
	IxDDhuLuQyLQyl8+nkj2tszmBwcjiUFwDP4HEoCLGOT3aZi1FPwYiWsHO60TJhUMnYRBX9DP09C
	GaT1/pbNv4npy2e/BQhulH8N2ph1cnHaNpU7bWFWZB93fK/tITW/u4b737RatsNtU9jBhZSAM5/
	lxDvPsc48S/A0rN1X20wuBNSos0TBL1ksakecZ97Kk+AkW466BSEwjnqaGAEoOE12czQz
X-Google-Smtp-Source: AGHT+IGVUulaM8PgxdpqWXbaXLvoTSxC4FBTiFBtCJmYm4R/u5Kqq0KGBrKf+VchkH7vBPb6AjB/0w==
X-Received: by 2002:a17:90b:1a8b:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-34082fc2ca5mr19922869a91.13.1762244890765;
        Tue, 04 Nov 2025 00:28:10 -0800 (PST)
Received: from lgs.. ([172.81.120.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b78f8sm3661514a91.20.2025.11.04.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:28:10 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Florian Westphal <fw@strlen.de>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] e1000: fix OOB in e1000_tbi_should_accept()
Date: Tue,  4 Nov 2025 16:28:01 +0800
Message-ID: <20251104082801.994195-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In e1000_tbi_should_accept() we read the last byte of the frame via
'data[length - 1]' to evaluate the TBI workaround. If the descriptor-
reported length is zero or larger than the actual RX buffer size, this
read goes out of bounds and can hit unrelated slab objects. The issue
is observed from the NAPI receive path (e1000_clean_rx_irq):

==================================================================
BUG: KASAN: slab-out-of-bounds in e1000_tbi_should_accept+0x610/0x790
Read of size 1 at addr ffff888014114e54 by task sshd/363

CPU: 0 PID: 363 Comm: sshd Not tainted 5.18.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x5a/0x74
 print_address_description+0x7b/0x440
 print_report+0x101/0x200
 kasan_report+0xc1/0xf0
 e1000_tbi_should_accept+0x610/0x790
 e1000_clean_rx_irq+0xa8c/0x1110
 e1000_clean+0xde2/0x3c10
 __napi_poll+0x98/0x380
 net_rx_action+0x491/0xa20
 __do_softirq+0x2c9/0x61d
 do_softirq+0xd1/0x120
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xfe/0x130
 ip_finish_output2+0x7d5/0xb00
 __ip_queue_xmit+0xe24/0x1ab0
 __tcp_transmit_skb+0x1bcb/0x3340
 tcp_write_xmit+0x175d/0x6bd0
 __tcp_push_pending_frames+0x7b/0x280
 tcp_sendmsg_locked+0x2e4f/0x32d0
 tcp_sendmsg+0x24/0x40
 sock_write_iter+0x322/0x430
 vfs_write+0x56c/0xa60
 ksys_write+0xd1/0x190
 do_syscall_64+0x43/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f511b476b10
Code: 73 01 c3 48 8b 0d 88 d3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d f9 2b 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 8e 9b 01 00 48 89 04 24
RSP: 002b:00007ffc9211d4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000004024 RCX: 00007f511b476b10
RDX: 0000000000004024 RSI: 0000559a9385962c RDI: 0000000000000003
RBP: 0000559a9383a400 R08: fffffffffffffff0 R09: 0000000000004f00
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc9211d57f R14: 0000559a9347bde7 R15: 0000000000000003
 </TASK>
Allocated by task 1:
 __kasan_krealloc+0x131/0x1c0
 krealloc+0x90/0xc0
 add_sysfs_param+0xcb/0x8a0
 kernel_add_sysfs_param+0x81/0xd4
 param_sysfs_builtin+0x138/0x1a6
 param_sysfs_init+0x57/0x5b
 do_one_initcall+0x104/0x250
 do_initcall_level+0x102/0x132
 do_initcalls+0x46/0x74
 kernel_init_freeable+0x28f/0x393
 kernel_init+0x14/0x1a0
 ret_from_fork+0x22/0x30
The buggy address belongs to the object at ffff888014114000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1620 bytes to the right of
 2048-byte region [ffff888014114000, ffff888014114800]
The buggy address belongs to the physical page:
page:ffffea0000504400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14110
head:ffffea0000504400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x100000000010200(slab|head|node=0|zone=1)
raw: 0100000000010200 0000000000000000 dead000000000001 ffff888013442000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
==================================================================

This happens because the TBI check unconditionally dereferences the last
byte without validating the reported length first:

	u8 last_byte = *(data + length - 1);

Fix by rejecting the frame early if the length is zero, or if it exceeds
adapter->rx_buffer_len. This preserves the TBI workaround semantics for
valid frames and prevents touching memory beyond the RX buffer.

Fixes: 2037110c96d5 ("e1000: move tbi workaround code into helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f5feb55cfba..2d2ed5e2c3c8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4090,6 +4090,12 @@ static bool e1000_tbi_should_accept(struct e1000_adapter *adapter,
 				    u8 status, u8 errors,
 				    u32 length, const u8 *data)
 {
+	/* Guard against OOB on data[length - 1] */
+	if (unlikely(!length))
+		return false;
+	/* Upper bound: length must not exceed rx_buffer_len */
+	if (unlikely(length > adapter->rx_buffer_len))
+		return false;
 	struct e1000_hw *hw = &adapter->hw;
 	u8 last_byte = *(data + length - 1);
 
-- 
2.43.0


