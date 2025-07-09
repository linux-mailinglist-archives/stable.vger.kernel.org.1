Return-Path: <stable+bounces-161389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3CAAFE01C
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2431E1BC7AB7
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761FF26C38D;
	Wed,  9 Jul 2025 06:42:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0926B770;
	Wed,  9 Jul 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043326; cv=none; b=q8mB0KsRmB5a9CpqYKEXdptTaPJCQeYgEq9N9z8Kz/oe78nOZtTRNprwbWAmOIixZDvCUUHVuTN6acZ7hxvhwmwgFHCV9PrQ91uolKA8jzf/T/oQcm6fsTBtx17dufTYuAZGL7vlEwIOXNkl0LYei8QpDwNX5GnBACsoCj456qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043326; c=relaxed/simple;
	bh=MRZaQ4Gw8ovX9UchifDQuOh9cofOAXUEs8f+MdXYERE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJWKLJXvesy8MHTP/tBVw8kKECuwTbXgXSEh4mXpsntDrPMTS4hUHzUBVtyVjYEx7z4ulXz6GNHqofJ8y1z4jhrR7mjgHQ7iU7nUNI886e/FS71uuvzqEjmVkI9GSZzwvNsKb8PZ8lHKGc9Y7ovJPQSaeNxS+k+UABp929jlbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz10t1752043249t8b0dbf15
X-QQ-Originating-IP: rhYcQKOgk3YXWMaj8lARU+abCXoQp07J9ehE47I2Pio=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.45.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Jul 2025 14:40:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8563157085836005021
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.kubiak@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] net: libwx: properly reset Rx ring descriptor
Date: Wed,  9 Jul 2025 14:40:25 +0800
Message-Id: <20250709064025.19436-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250709064025.19436-1-jiawenwu@trustnetic.com>
References: <20250709064025.19436-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OL+UICmSdRy+oaNUfKwpEDfAzTNtwYr5mefVBM31y1kIBXU1rbrvp0Av
	RoUc6zjkPR3wxxQsNQgsDd1E4UsIos9obTmKgYEqbmmS1xJFmDbVoEAN7hEiGK1I8qEesLo
	Mri92Ua2G61EdBei+0c3ThpDPHPJhQUE1ElXEL+JPzIiyolsC3oghd1qYUyBNOH7HvVNK4O
	GFBnunv/T7uSCpOA5YtveJM9t5J/Us8S0uf3ZXaXYWQrNTzKbJ6msR68b7tfnTmcOVJUPeb
	Q8e4C/Fi+9zWtznLvD3wVfW+2Gp7F0bXZphpMrm1yXDvYYGSkjR/BfWw4n1/qP6n/tmO6Jk
	YVM40Jk+pk91VEQQB01PJjn/87jEPhv2qiQCi79KHhTJL3yYlEcrqPrBzHs4Wzt7S9d78X9
	2ztt2Q1S3Zf4L5CoPX4vDgRoZs6wQ1dELETEKJJ/gCLyqiw7ZTR6QJUwHNhk0eH6Xq3++rG
	Q0tJuIWDp6o+pbOeUCuw8QwIMtFYTmj4IltBrhNg5V765Mh07MXWJH+yMjB0Gs/tLjYAu9r
	u1zQpXGCPuBmFF+50piWMe2jz9SLNO9zOvDjb1FBVVCfCZ4Ljt1e/rrF6S0HZv72cKGnwfE
	6pThwfFEoCRKPS86QV3G4A7ug4CzGZ2J6qXzjgz8vLA8odK8qfCZCzbSLuI2XvK4NyCDHuJ
	4Al/tbumIXeJrWYdWN7S6MLXQVXWw16+m+VKNAmsAblcOCsKxN+KaFaue1XQv3QlUw/EZdg
	kZg0GGH0SdmWsv0ykeKZyTWvJwnRxe02nDaV5F76TGSZnPIkjuSZp16J33023eH5lJPNcfz
	MUmETPo8Q7Rw2vg+Px/PgSq9jP1rJXImg4xdnaWtHWKHZt4I7LrCng9ATsrVOo5lVQsXeLG
	wSFG4QjO2RyjMFUfY2SWQo9ry4nguJwlT44t/VtyHDKRY3Fw15NI0viA9hj5pfRkCW+oJQj
	gNmCpzjej+1WeqXUAP4kLrXOfWijTf4NFTxdOLNMRhI1+R9nlc59u9msmeMuf3dgO2zd+24
	uvA0FVV88gvKoxbqGxJUFwhIY7UsrWEH682Yuaytv9eEvB8ZWF
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

When device reset is triggered by feature changes such as toggling Rx
VLAN offload, wx->do_reset() is called to reinitialize Rx rings. The
hardware descriptor ring may retain stale values from previous sessions.
And only set the length to 0 in rx_desc[0] would result in building
malformed SKBs. Fix it to ensure a clean slate after device reset.

[  549.186435] [     C16] ------------[ cut here ]------------
[  549.186457] [     C16] kernel BUG at net/core/skbuff.c:2814!
[  549.186468] [     C16] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  549.186472] [     C16] CPU: 16 UID: 0 PID: 0 Comm: swapper/16 Kdump: loaded Not tainted 6.16.0-rc4+ #23 PREEMPT(voluntary)
[  549.186476] [     C16] Hardware name: Micro-Star International Co., Ltd. MS-7E16/X670E GAMING PLUS WIFI (MS-7E16), BIOS 1.90 12/31/2024
[  549.186478] [     C16] RIP: 0010:__pskb_pull_tail+0x3ff/0x510
[  549.186484] [     C16] Code: 06 f0 ff 4f 34 74 7b 4d 8b 8c 24 c8 00 00 00 45 8b 84 24 c0 00 00 00 e9 c8 fd ff ff 48 c7 44 24 08 00 00 00 00 e9 5e fe ff ff <0f> 0b 31 c0 e9 23 90 5b ff 41 f7 c6 ff 0f 00 00 75 bf 49 8b 06 a8
[  549.186487] [     C16] RSP: 0018:ffffb391c0640d70 EFLAGS: 00010282
[  549.186490] [     C16] RAX: 00000000fffffff2 RBX: ffff8fe7e4d40200 RCX: 00000000fffffff2
[  549.186492] [     C16] RDX: ffff8fe7c3a4bf8e RSI: 0000000000000180 RDI: ffff8fe7c3a4bf40
[  549.186494] [     C16] RBP: ffffb391c0640da8 R08: ffff8fe7c3a4c0c0 R09: 000000000000000e
[  549.186496] [     C16] R10: ffffb391c0640d88 R11: 000000000000000e R12: ffff8fe7e4d40200
[  549.186497] [     C16] R13: 00000000fffffff2 R14: ffff8fe7fa01a000 R15: 00000000fffffff2
[  549.186499] [     C16] FS:  0000000000000000(0000) GS:ffff8fef5ae40000(0000) knlGS:0000000000000000
[  549.186502] [     C16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  549.186503] [     C16] CR2: 00007f77d81d6000 CR3: 000000051a032000 CR4: 0000000000750ef0
[  549.186505] [     C16] PKRU: 55555554
[  549.186507] [     C16] Call Trace:
[  549.186510] [     C16]  <IRQ>
[  549.186513] [     C16]  ? srso_alias_return_thunk+0x5/0xfbef5
[  549.186517] [     C16]  __skb_pad+0xc7/0xf0
[  549.186523] [     C16]  wx_clean_rx_irq+0x355/0x3b0 [libwx]
[  549.186533] [     C16]  wx_poll+0x92/0x120 [libwx]
[  549.186540] [     C16]  __napi_poll+0x28/0x190
[  549.186544] [     C16]  net_rx_action+0x301/0x3f0
[  549.186548] [     C16]  ? srso_alias_return_thunk+0x5/0xfbef5
[  549.186551] [     C16]  ? __raw_spin_lock_irqsave+0x1e/0x50
[  549.186554] [     C16]  ? srso_alias_return_thunk+0x5/0xfbef5
[  549.186557] [     C16]  ? wake_up_nohz_cpu+0x35/0x160
[  549.186559] [     C16]  ? srso_alias_return_thunk+0x5/0xfbef5
[  549.186563] [     C16]  handle_softirqs+0xf9/0x2c0
[  549.186568] [     C16]  __irq_exit_rcu+0xc7/0x130
[  549.186572] [     C16]  common_interrupt+0xb8/0xd0
[  549.186576] [     C16]  </IRQ>
[  549.186577] [     C16]  <TASK>
[  549.186579] [     C16]  asm_common_interrupt+0x22/0x40
[  549.186582] [     C16] RIP: 0010:cpuidle_enter_state+0xc2/0x420
[  549.186585] [     C16] Code: 00 00 e8 11 0e 5e ff e8 ac f0 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 0d ed 5c ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45> 85 f6 0f 88 84 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  549.186587] [     C16] RSP: 0018:ffffb391c0277e78 EFLAGS: 00000246
[  549.186590] [     C16] RAX: ffff8fef5ae40000 RBX: 0000000000000003 RCX: 0000000000000000
[  549.186591] [     C16] RDX: 0000007fde0faac5 RSI: ffffffff826e53f6 RDI: ffffffff826fa9b3
[  549.186593] [     C16] RBP: ffff8fe7c3a20800 R08: 0000000000000002 R09: 0000000000000000
[  549.186595] [     C16] R10: 0000000000000000 R11: 000000000000ffff R12: ffffffff82ed7a40
[  549.186596] [     C16] R13: 0000007fde0faac5 R14: 0000000000000003 R15: 0000000000000000
[  549.186601] [     C16]  ? cpuidle_enter_state+0xb3/0x420
[  549.186605] [     C16]  cpuidle_enter+0x29/0x40
[  549.186609] [     C16]  cpuidle_idle_call+0xfd/0x170
[  549.186613] [     C16]  do_idle+0x7a/0xc0
[  549.186616] [     C16]  cpu_startup_entry+0x25/0x30
[  549.186618] [     C16]  start_secondary+0x117/0x140
[  549.186623] [     C16]  common_startup_64+0x13e/0x148
[  549.186628] [     C16]  </TASK>

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c  | 7 +++----
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index a9519997286b..9002b97e148e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1912,7 +1912,6 @@ static void wx_configure_rx_ring(struct wx *wx,
 				 struct wx_ring *ring)
 {
 	u16 reg_idx = ring->reg_idx;
-	union wx_rx_desc *rx_desc;
 	u64 rdba = ring->dma;
 	u32 rxdctl;
 
@@ -1942,9 +1941,9 @@ static void wx_configure_rx_ring(struct wx *wx,
 	memset(ring->rx_buffer_info, 0,
 	       sizeof(struct wx_rx_buffer) * ring->count);
 
-	/* initialize Rx descriptor 0 */
-	rx_desc = WX_RX_DESC(ring, 0);
-	rx_desc->wb.upper.length = 0;
+	/* reset ntu and ntc to place SW in sync with hardwdare */
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
 
 	/* enable receive descriptor ring */
 	wr32m(wx, WX_PX_RR_CFG(reg_idx),
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index c91487909811..0213ad5a6ceb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -357,6 +357,8 @@ void wx_alloc_rx_buffers(struct wx_ring *rx_ring, u16 cleaned_count)
 
 		/* clear the status bits for the next_to_use descriptor */
 		rx_desc->wb.upper.status_error = 0;
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
 
 		cleaned_count--;
 	} while (cleaned_count);
@@ -2438,6 +2440,9 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
 		}
 	}
 
+	/* Zero out the descriptor ring */
+	memset(rx_ring->desc, 0, rx_ring->size);
+
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
-- 
2.48.1


