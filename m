Return-Path: <stable+bounces-104957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CC9F53F6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B0716EB80
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E81F76BF;
	Tue, 17 Dec 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bt+Dkv5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223B1F7545;
	Tue, 17 Dec 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456637; cv=none; b=uqFFm3qIcOHoXZapA5dOQSHUP5DvJkjiyxny+MKN5ZHq9e1CaT5PROqhnR/Z1XPwGOc8QgbMw9EHaQ7n7iQ3W+BOJN9fP5NF1st157XBvu76WAJedFHHMq/b3sVURtKqVgCz+u59aEUSIbUACppAjmeGSdyCaP8XSwOM/fjRXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456637; c=relaxed/simple;
	bh=Hjpn9i1GIgixkFOyyv9mapnX4TZUy7FPn9wAH1QkeHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjspbVLxIjSLux5tcejV7s6/x5Sf2HC3llcaePAvzUOFXt1DLzHWqyZNYhBG9PguVz+qnUHaMpjfkTWfnOZxRxtbwSISxhH1scxJCbkEKuHt4cxFyz4ypi49xP5O1onwWS3pXJ6G6XoHiq1xZy51I9WZTIOfQViZKS6PaV0Jyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bt+Dkv5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB4C4CED3;
	Tue, 17 Dec 2024 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456636;
	bh=Hjpn9i1GIgixkFOyyv9mapnX4TZUy7FPn9wAH1QkeHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bt+Dkv5wQvy4eLmiQ4vcMYulv1iidVt0AjCkN7JbBZ3RO3QCQG5gEDVVv46pn6aRx
	 xIBeCMHLmEiUXBqL2nLpdMCOVmO12Leyq2Z809nw0e5bMgL1CdY77epDpUKK+lvHLs
	 ID7gUItEHeONI6hkiFwv+JYD630PZewwOharEyKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 120/172] bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips
Date: Tue, 17 Dec 2024 18:07:56 +0100
Message-ID: <20241217170551.306561468@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 24c6843b7393ebc80962b59d7ae71af91bf0dcc1 ]

The 5760X (P7) chip's HW GRO/LRO interface is very similar to that of
the previous generation (5750X or P5).  However, the aggregation ID
fields in the completion structures on P7 have been redefined from
16 bits to 12 bits.  The freed up 4 bits are redefined for part of the
metadata such as the VLAN ID.  The aggregation ID mask was not modified
when adding support for P7 chips.  Including the extra 4 bits for the
aggregation ID can potentially cause the driver to store or fetch the
packet header of GRO/LRO packets in the wrong TPA buffer.  It may hit
the BUG() condition in __skb_pull() because the SKB contains no valid
packet header:

kernel BUG at include/linux/skbuff.h:2766!
Oops: invalid opcode: 0000 1 PREEMPT SMP NOPTI
CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Kdump: loaded Tainted: G           OE      6.12.0-rc2+ #7
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: Dell Inc. PowerEdge R760/0VRV9X, BIOS 1.0.1 12/27/2022
RIP: 0010:eth_type_trans+0xda/0x140
Code: 80 00 00 00 eb c1 8b 47 70 2b 47 74 48 8b 97 d0 00 00 00 83 f8 01 7e 1b 48 85 d2 74 06 66 83 3a ff 74 09 b8 00 04 00 00 eb a5 <0f> 0b b8 00 01 00 00 eb 9c 48 85 ff 74 eb 31 f6 b9 02 00 00 00 48
RSP: 0018:ff615003803fcc28 EFLAGS: 00010283
RAX: 00000000000022d2 RBX: 0000000000000003 RCX: ff2e8c25da334040
RDX: 0000000000000040 RSI: ff2e8c25c1ce8000 RDI: ff2e8c25869f9000
RBP: ff2e8c258c31c000 R08: ff2e8c25da334000 R09: 0000000000000001
R10: ff2e8c25da3342c0 R11: ff2e8c25c1ce89c0 R12: ff2e8c258e0990b0
R13: ff2e8c25bb120000 R14: ff2e8c25c1ce89c0 R15: ff2e8c25869f9000
FS:  0000000000000000(0000) GS:ff2e8c34be300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f05317e4c8 CR3: 000000108bac6006 CR4: 0000000000773ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x33/0x90
 ? do_trap+0xd9/0x100
 ? eth_type_trans+0xda/0x140
 ? do_error_trap+0x65/0x80
 ? eth_type_trans+0xda/0x140
 ? exc_invalid_op+0x4e/0x70
 ? eth_type_trans+0xda/0x140
 ? asm_exc_invalid_op+0x16/0x20
 ? eth_type_trans+0xda/0x140
 bnxt_tpa_end+0x10b/0x6b0 [bnxt_en]
 ? bnxt_tpa_start+0x195/0x320 [bnxt_en]
 bnxt_rx_pkt+0x902/0xd90 [bnxt_en]
 ? __bnxt_tx_int.constprop.0+0x89/0x300 [bnxt_en]
 ? kmem_cache_free+0x343/0x440
 ? __bnxt_tx_int.constprop.0+0x24f/0x300 [bnxt_en]
 __bnxt_poll_work+0x193/0x370 [bnxt_en]
 bnxt_poll_p5+0x9a/0x300 [bnxt_en]
 ? try_to_wake_up+0x209/0x670
 __napi_poll+0x29/0x1b0

Fix it by redefining the aggregation ID mask for P5_PLUS chips to be
12 bits.  This will work because the maximum aggregation ID is less
than 4096 on all P5_PLUS chips.

Fixes: 13d2d3d381ee ("bnxt_en: Add new P7 hardware interface definitions")
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241209015448.1937766-1-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1d97219369c5..9e05704d9445 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -381,7 +381,7 @@ struct rx_agg_cmp {
 	u32 rx_agg_cmp_opaque;
 	__le32 rx_agg_cmp_v;
 	#define RX_AGG_CMP_V					(1 << 0)
-	#define RX_AGG_CMP_AGG_ID				(0xffff << 16)
+	#define RX_AGG_CMP_AGG_ID				(0x0fff << 16)
 	 #define RX_AGG_CMP_AGG_ID_SHIFT			 16
 	__le32 rx_agg_cmp_unused;
 };
@@ -419,7 +419,7 @@ struct rx_tpa_start_cmp {
 	 #define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT	 7
 	#define RX_TPA_START_CMP_AGG_ID				(0x7f << 25)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT			 25
-	#define RX_TPA_START_CMP_AGG_ID_P5			(0xffff << 16)
+	#define RX_TPA_START_CMP_AGG_ID_P5			(0x0fff << 16)
 	 #define RX_TPA_START_CMP_AGG_ID_SHIFT_P5		 16
 	#define RX_TPA_START_CMP_METADATA1			(0xf << 28)
 	 #define RX_TPA_START_CMP_METADATA1_SHIFT		 28
@@ -543,7 +543,7 @@ struct rx_tpa_end_cmp {
 	 #define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		 16
 	#define RX_TPA_END_CMP_AGG_ID				(0x7f << 25)
 	 #define RX_TPA_END_CMP_AGG_ID_SHIFT			 25
-	#define RX_TPA_END_CMP_AGG_ID_P5			(0xffff << 16)
+	#define RX_TPA_END_CMP_AGG_ID_P5			(0x0fff << 16)
 	 #define RX_TPA_END_CMP_AGG_ID_SHIFT_P5			 16
 
 	__le32 rx_tpa_end_cmp_tsdelta;
-- 
2.39.5




