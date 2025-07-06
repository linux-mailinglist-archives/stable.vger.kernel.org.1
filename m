Return-Path: <stable+bounces-159418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BAAF785E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C886543316
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D0B1DC98B;
	Thu,  3 Jul 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VoXbbDqn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835472610;
	Thu,  3 Jul 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554171; cv=none; b=h+iaEApVe0F6R9a1hEo61wKEgcvyXddySIUPoRj/mHmbX10yjeCeu/kN1vN94AGx1jW/QJ7JDGQtDIqBYtoIdCHcqA1hN5QL0lNaCT1SS5/GJMfl422tMdqFgXwy1rweL+DZ3/9VGfKxTVViXJ452qZT8rQEH/GU6ePGtjRavEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554171; c=relaxed/simple;
	bh=DCilo0ClZ5nJ7v4aPWnLUPLo/G8cTdio4JfoqUZc4K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTw+9XBB69NhM8CofEJv/6eVKhpShT3f1NX+BdTJAWLF6sl1OTvRYRAyifaefuGcun058SPLoaZqw1YDUH2EVyGgXIF6ffWdF/+BqQs2yQNsiytWRyOjDtvW3cqYKONXvm/Dq910DFkIQZIOsH0rtp+xYSpT+4cRyPfUIuhUvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VoXbbDqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5646EC4CEE3;
	Thu,  3 Jul 2025 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554170;
	bh=DCilo0ClZ5nJ7v4aPWnLUPLo/G8cTdio4JfoqUZc4K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoXbbDqn2Q7kORanv2QKuwembVg/hPTDAo4ng0HlMc7H8cejrFejl49uBozpB/qGj
	 NkIUGTlyVKwPRmpPy8+xENYP753bXRZ3lRBQ2wHRAqxQjxels0EYQA1EJXjRfGv60S
	 u5XU1Wb6A7YAmKRK1P+r9my+g47aKx3NSW8k0+S0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Rzeznik <arzeznik@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 103/218] bnxt: properly flush XDP redirect lists
Date: Thu,  3 Jul 2025 16:40:51 +0200
Message-ID: <20250703144000.056650736@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit 9caca6ac0e26cd20efd490d8b3b2ffb1c7c00f6f ]

We encountered following crash when testing a XDP_REDIRECT feature
in production:

[56251.579676] list_add corruption. next->prev should be prev (ffff93120dd40f30), but was ffffb301ef3a6740. (next=ffff93120dd
40f30).
[56251.601413] ------------[ cut here ]------------
[56251.611357] kernel BUG at lib/list_debug.c:29!
[56251.621082] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[56251.632073] CPU: 111 UID: 0 PID: 0 Comm: swapper/111 Kdump: loaded Tainted: P           O       6.12.33-cloudflare-2025.6.
3 #1
[56251.653155] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
[56251.663877] Hardware name: MiTAC GC68B-B8032-G11P6-GPU/S8032GM-HE-CFR, BIOS V7.020.B10-sig 01/22/2025
[56251.682626] RIP: 0010:__list_add_valid_or_report+0x4b/0xa0
[56251.693203] Code: 0e 48 c7 c7 68 e7 d9 97 e8 42 16 fe ff 0f 0b 48 8b 52 08 48 39 c2 74 14 48 89 f1 48 c7 c7 90 e7 d9 97 48
 89 c6 e8 25 16 fe ff <0f> 0b 4c 8b 02 49 39 f0 74 14 48 89 d1 48 c7 c7 e8 e7 d9 97 4c 89
[56251.725811] RSP: 0018:ffff93120dd40b80 EFLAGS: 00010246
[56251.736094] RAX: 0000000000000075 RBX: ffffb301e6bba9d8 RCX: 0000000000000000
[56251.748260] RDX: 0000000000000000 RSI: ffff9149afda0b80 RDI: ffff9149afda0b80
[56251.760349] RBP: ffff9131e49c8000 R08: 0000000000000000 R09: ffff93120dd40a18
[56251.772382] R10: ffff9159cf2ce1a8 R11: 0000000000000003 R12: ffff911a80850000
[56251.784364] R13: ffff93120fbc7000 R14: 0000000000000010 R15: ffff9139e7510e40
[56251.796278] FS:  0000000000000000(0000) GS:ffff9149afd80000(0000) knlGS:0000000000000000
[56251.809133] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[56251.819561] CR2: 00007f5e85e6f300 CR3: 00000038b85e2006 CR4: 0000000000770ef0
[56251.831365] PKRU: 55555554
[56251.838653] Call Trace:
[56251.845560]  <IRQ>
[56251.851943]  cpu_map_enqueue.cold+0x5/0xa
[56251.860243]  xdp_do_redirect+0x2d9/0x480
[56251.868388]  bnxt_rx_xdp+0x1d8/0x4c0 [bnxt_en]
[56251.877028]  bnxt_rx_pkt+0x5f7/0x19b0 [bnxt_en]
[56251.885665]  ? cpu_max_write+0x1e/0x100
[56251.893510]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.902276]  __bnxt_poll_work+0x190/0x340 [bnxt_en]
[56251.911058]  bnxt_poll+0xab/0x1b0 [bnxt_en]
[56251.919041]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.927568]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.935958]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.944250]  __napi_poll+0x2b/0x160
[56251.951155]  bpf_trampoline_6442548651+0x79/0x123
[56251.959262]  __napi_poll+0x5/0x160
[56251.966037]  net_rx_action+0x3d2/0x880
[56251.973133]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.981265]  ? srso_alias_return_thunk+0x5/0xfbef5
[56251.989262]  ? __hrtimer_run_queues+0x162/0x2a0
[56251.996967]  ? srso_alias_return_thunk+0x5/0xfbef5
[56252.004875]  ? srso_alias_return_thunk+0x5/0xfbef5
[56252.012673]  ? bnxt_msix+0x62/0x70 [bnxt_en]
[56252.019903]  handle_softirqs+0xcf/0x270
[56252.026650]  irq_exit_rcu+0x67/0x90
[56252.032933]  common_interrupt+0x85/0xa0
[56252.039498]  </IRQ>
[56252.044246]  <TASK>
[56252.048935]  asm_common_interrupt+0x26/0x40
[56252.055727] RIP: 0010:cpuidle_enter_state+0xb8/0x420
[56252.063305] Code: dc 01 00 00 e8 f9 79 3b ff e8 64 f7 ff ff 49 89 c5 0f 1f 44 00 00 31 ff e8 a5 32 3a ff 45 84 ff 0f 85 ae
 01 00 00 fb 45 85 f6 <0f> 88 88 01 00 00 48 8b 04 24 49 63 ce 4c 89 ea 48 6b f1 68 48 29
[56252.088911] RSP: 0018:ffff93120c97fe98 EFLAGS: 00000202
[56252.096912] RAX: ffff9149afd80000 RBX: ffff9141d3a72800 RCX: 0000000000000000
[56252.106844] RDX: 00003329176c6b98 RSI: ffffffe36db3fdc7 RDI: 0000000000000000
[56252.116733] RBP: 0000000000000002 R08: 0000000000000002 R09: 000000000000004e
[56252.126652] R10: ffff9149afdb30c4 R11: 071c71c71c71c71c R12: ffffffff985ff860
[56252.136637] R13: 00003329176c6b98 R14: 0000000000000002 R15: 0000000000000000
[56252.146667]  ? cpuidle_enter_state+0xab/0x420
[56252.153909]  cpuidle_enter+0x2d/0x40
[56252.160360]  do_idle+0x176/0x1c0
[56252.166456]  cpu_startup_entry+0x29/0x30
[56252.173248]  start_secondary+0xf7/0x100
[56252.179941]  common_startup_64+0x13e/0x141
[56252.186886]  </TASK>

>From the crash dump, we found that the cpu_map_flush_list inside
redirect info is partially corrupted: its list_head->next points to
itself, but list_head->prev points to a valid list of unflushed bq
entries.

This turned out to be a result of missed XDP flush on redirect lists. By
digging in the actual source code, we found that
commit 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX
ring structures") incorrectly overwrites the event mask for XDP_REDIRECT
in bnxt_rx_xdp. We can stably reproduce this crash by returning XDP_TX
and XDP_REDIRECT randomly for incoming packets in a naive XDP program.
Properly propagate the XDP_REDIRECT events back fixes the crash.

Fixes: a7559bc8c17c ("bnxt: support transmit and free of aggregation buffers")
Tested-by: Andrew Rzeznik <arzeznik@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Link: https://patch.msgid.link/aFl7jpCNzscumuN2@debian.debian
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 154f73f121eca..ad4aec522f4f8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2871,6 +2871,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 cons;
 	int rx_pkts = 0;
 	u8 event = 0;
@@ -2924,6 +2925,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			else
 				rc = bnxt_force_rx_discard(bp, cpr, &raw_cons,
 							   &event);
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 			if (likely(rc >= 0))
 				rx_pkts += rc;
 			/* Increment rx_pkts when rc is -ENOMEM to count towards
@@ -2948,7 +2951,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (event & BNXT_REDIRECT_EVENT) {
+	if (flush_xdp) {
 		xdp_do_flush();
 		event &= ~BNXT_REDIRECT_EVENT;
 	}
-- 
2.39.5




