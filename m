Return-Path: <stable+bounces-197692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 785C1C95A86
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 04:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE65F342322
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 03:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1B1DEFF5;
	Mon,  1 Dec 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPUrpxgY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE82032D
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 03:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560480; cv=none; b=DUfkbPQ9qXCUTAlZ704KD34k6y/jKJN8dFZL1qDU0UFBhp7nSM/VsV2D6zZ4S5AHmAJvs5HT0KAM7Cuu1Qdojk6KX5V60LDL0Jb94bE5XktjwOkcxglvaBBzCnckQR0TNSjkdXTLzfhMADxqMEm5IS1OLXn0beTYo80g32Hzg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560480; c=relaxed/simple;
	bh=RavPoON2AtHEgnR4R9qerJUek3jo4iZpBSvZeJXyzvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfvQXUScwtk2297af/tnUHxtnD883VtTKL3f0MzPMGs3twWmKqiRB3Ru6xkEO5cB/oAU91ZsfmFSgcLD05wMpSSivmkMy12ZoCG+eA8ADNymTKU3HPKfMsMlF2tvIy2gyKqOgXIGQf3I6CFvJS151FUp2tGh/gKivLbrCOFmXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPUrpxgY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so3783534a91.1
        for <stable@vger.kernel.org>; Sun, 30 Nov 2025 19:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764560478; x=1765165278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlbI/qoSd0f2lsToeVKQSag9wuEwJhaMlP4r36cW0BM=;
        b=PPUrpxgYrpaX90LD48YuM6xotaZEmHqwXMMt1hwTLHFQ7x61brAaWHOzL11BzJnlb8
         N3+VbrmvqXKgdKlmJiyZavG92//rD0agmRySD8PD88LhoYJdFR+MEgH8u2QsN323/Q2q
         twuZXAT1NngguFy0ZBgwBlDIREwlybBW/GnSEahEscj2ZctidtOY997cVi8hbEpJTKSE
         3QEfVB7kl2/WjfRNAfJ0sWKtgBnnvmriAAARhxCPvCQ/MDl1JVwOM+LvBHZEm96YeVmI
         j2vXpfQdXjVXXWxDKW9tBe6RRklH3pKjq7c38d+BcutTXEjHCmQ9vOFvYfWQEyqhkdpN
         LLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764560478; x=1765165278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlbI/qoSd0f2lsToeVKQSag9wuEwJhaMlP4r36cW0BM=;
        b=un+n5ZjnJYsA8IUjGRcSaX43wmR6hB+shy5l4O0y/zxdFBwguC0cTCTKhffsDTFn7P
         m4PcNtm+wUGC2w5iVWtiYt1Tq2DW9uyzHTX6ykXWdxpVthDuC7z/L7q0alXuM78e9T1R
         mWn3MQxQePoh4ISqCYLNlOnj9789+my7GW3NGso2USZoZlI3p1husox6WELwQG0voq6K
         7EiYMn2uWkWC06FAbOryunnrzKzogJ+9YzHeLXqEjA9MyFL2eDFB5MhDd2IYUrDy5ZT0
         eHKBkaAgiXMDYwN5D5LWrds872p4Cobtg1Nt3PZPirnApfcqCO/+SHC0geFf+BBaKpX1
         pwJA==
X-Forwarded-Encrypted: i=1; AJvYcCWsYkmt980dZus8XSPBsZ6O6dUzMmvak/Vlr1hmDWdH+jmnHhxq2GwMgxb3o6vQoiR9ZmRM+3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qj7y+I+Y698CoLdzPhG5bIlLXYI801uy+16+bA+PAp22nS7o
	25DeCv4SEigdQaENXNJUXZQNViXLm5uMX19GwfTKvzSd0TO4FVvln30dUt2RWjwgddM=
X-Gm-Gg: ASbGncvBAakhZDEw8UNvLLXh3I+mRVTQrwz19wHjjvUIf90t2WXMuLxPvUoobLoPMGD
	+Un0joh1y7dgEHLXk6epHIDMR/eN4HDTVy6EICHsFrxEnLQoZ6sRDZANj2mz2Awv+5rWvsLCpml
	WwpUzeJd7nCLpR+dKSnZtptux6DLPi5qXaZVX7odJq6tDLvLn9+lYknllo7HHOLfqxnIPPGzXCV
	293TtCKJreQ0LKeu1Zhr7VLCO3hgpRb27MGEqkfxt3bBvedK+RA+TAYu++UBtfltxTCp+D9Qhyv
	+hQF3izjq5CMecdyVpk1qiy3UsZ6GiCkmH/Tz+r0Vie/lF7UES1jIbrSVseaUqfNk/wW13QBl84
	mHke2uQY2EBNedv2Y5CouOqDLBQOdDFpgh/gZK1s8KnQxX9CpBzeCJMsTsItB+GCBnSPDC4RqT1
	8vyZURwIJ46g==
X-Google-Smtp-Source: AGHT+IGjCSLiARwPj8LvgAmdlmw2aNw3T8jAZxFgCchMsS69HaOtffJUKXMOBrtZkx6OdtgHTwqqnw==
X-Received: by 2002:a17:90b:1f88:b0:343:5f43:9359 with SMTP id 98e67ed59e1d1-34733f4d280mr36959812a91.31.1764560478201;
        Sun, 30 Nov 2025 19:41:18 -0800 (PST)
Received: from lgs.. ([101.76.246.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm15065740a91.5.2025.11.30.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:41:17 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Tony Nguyen <tony.nguyen@intel.com>
Subject: [PATCH v2] e1000: fix OOB in e1000_tbi_should_accept()
Date: Mon,  1 Dec 2025 11:40:58 +0800
Message-ID: <20251201034058.263839-1-lgs201920130244@gmail.com>
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
Suggested-by: Tony Nguyen <tony.nguyen@intel.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v2:
- Keep declarations at the beginning of e1000_tbi_should_accept().
- Move the last_byte assignment after the length bounds checks (suggested by Tony Nguyen)
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f5feb55cfba..cb49ec49f836 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4091,7 +4091,14 @@ static bool e1000_tbi_should_accept(struct e1000_adapter *adapter,
 				    u32 length, const u8 *data)
 {
 	struct e1000_hw *hw = &adapter->hw;
-	u8 last_byte = *(data + length - 1);
+	u8 last_byte;
+	/* Guard against OOB on data[length - 1] */
+	if (unlikely(!length))
+		return false;
+	/* Upper bound: length must not exceed rx_buffer_len */
+	if (unlikely(length > adapter->rx_buffer_len))
+		return false;
+	last_byte = *(data + length - 1);
 
 	if (TBI_ACCEPT(hw, status, errors, length, last_byte)) {
 		unsigned long irq_flags;
-- 
2.43.0


