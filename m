Return-Path: <stable+bounces-144328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DFCAB636B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF76A7B3ED8
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9151C861E;
	Wed, 14 May 2025 06:45:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA31FBCA7
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205106; cv=none; b=U3znpTbZqadktlm8hMX220yLoB25baElDcT3jaf9urQBIO8fPnqFS+aBMwdkKvQEh/pd/DloYItEoLln+0upQ4J0YTlBGUORh68KzcSJ2IVU+77Gmykn7PGNHMGEGLnllPjrBqeUXg//9lHJZDh+ofTulYzKpxerMCfIRFBMXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205106; c=relaxed/simple;
	bh=q/yGq3nCDDF0CSkEwlQmhElqgZjaSe7w65A1Rc8T/o8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+0hiBp+ws4CK39pjNDINujGiRskvlbrf9MCnLJ84e/WUyNj2VbtSiTvfC5tuNkoYnYflJx/cFSV8qqUL1LESSf1SZxTnodXGQDh90kt97j3XzmA9EZ8QLnPhBnoXMTFW5gdgt08UBHqegmz7FUi3qJUSBva1SlpSgxyzMWDYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrACHjXXbOyRo+kBNAQ--.10314S2;
	Wed, 14 May 2025 14:44:43 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wDXN8TaOyRoEexUAA--.19998S4;
	Wed, 14 May 2025 14:44:42 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Shravya KN <shravya.k-n@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] bnxt_en: Fix receive ring space parameters when XDP is active
Date: Wed, 14 May 2025 14:44:38 +0800
Message-Id: <20250514064438.395697-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrACHjXXbOyRo+kBNAQ--.10314S2
Authentication-Results: app2; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4kWw47Kr1UtFW7ZF45GFg_yoWrXrWrpr
	45uryDCr4kJr15Ja1UJFW8Ar15Kr1vy3W8Wr47JrnYv3W5K3Wjyry8KwnFyFyDtr48Wr17
	tr4Yvw4SqFyDWaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3-eODUUUU
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgCB2gkEmEHgwACs1

From: Shravya KN <shravya.k-n@broadcom.com>

[ Upstream commit 3051a77a09dfe3022aa012071346937fdf059033 ]

The MTU setting at the time an XDP multi-buffer is attached
determines whether the aggregation ring will be used and the
rx_skb_func handler.  This is done in bnxt_set_rx_skb_mode().

If the MTU is later changed, the aggregation ring setting may need
to be changed and it may become out-of-sync with the settings
initially done in bnxt_set_rx_skb_mode().  This may result in
random memory corruption and crashes as the HW may DMA data larger
than the allocated buffer size, such as:

BUG: kernel NULL pointer dereference, address: 00000000000003c0
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 17 PID: 0 Comm: swapper/17 Kdump: loaded Tainted: G S         OE      6.1.0-226bf9805506 #1
Hardware name: Wiwynn Delta Lake PVT BZA.02601.0150/Delta Lake-Class1, BIOS F0E_3A12 08/26/2021
RIP: 0010:bnxt_rx_pkt+0xe97/0x1ae0 [bnxt_en]
Code: 8b 95 70 ff ff ff 4c 8b 9d 48 ff ff ff 66 41 89 87 b4 00 00 00 e9 0b f7 ff ff 0f b7 43 0a 49 8b 95 a8 04 00 00 25 ff 0f 00 00 <0f> b7 14 42 48 c1 e2 06 49 03 95 a0 04 00 00 0f b6 42 33f
RSP: 0018:ffffa19f40cc0d18 EFLAGS: 00010202
RAX: 00000000000001e0 RBX: ffff8e2c805c6100 RCX: 00000000000007ff
RDX: 0000000000000000 RSI: ffff8e2c271ab990 RDI: ffff8e2c84f12380
RBP: ffffa19f40cc0e48 R08: 000000000001000d R09: 974ea2fcddfa4cbf
R10: 0000000000000000 R11: ffffa19f40cc0ff8 R12: ffff8e2c94b58980
R13: ffff8e2c952d6600 R14: 0000000000000016 R15: ffff8e2c271ab990
FS:  0000000000000000(0000) GS:ffff8e3b3f840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000003c0 CR3: 0000000e8580a004 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 __bnxt_poll_work+0x1c2/0x3e0 [bnxt_en]

To address the issue, we now call bnxt_set_rx_skb_mode() within
bnxt_change_mtu() to properly set the AGG rings configuration and
update rx_skb_func based on the new MTU value.
Additionally, BNXT_FLAG_NO_AGG_RINGS is cleared at the beginning of
bnxt_set_rx_skb_mode() to make sure it gets set or cleared based on
the current MTU.

Fixes: 08450ea98ae9 ("bnxt_en: Fix max_mtu setting for multi-buf XDP")
Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 393a983f6d69..6b1245a3ab4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4041,7 +4041,7 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 	struct net_device *dev = bp->dev;
 
 	if (page_mode) {
-		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
+		bp->flags &= ~(BNXT_FLAG_AGG_RINGS | BNXT_FLAG_NO_AGG_RINGS);
 		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
 
 		if (bp->xdp_prog->aux->xdp_has_frags)
@@ -12799,6 +12799,14 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 		bnxt_close_nic(bp, true, false);
 
 	dev->mtu = new_mtu;
+
+	/* MTU change may change the AGG ring settings if an XDP multi-buffer
+	 * program is attached.  We need to set the AGG rings settings and
+	 * rx_skb_func accordingly.
+	 */
+	if (READ_ONCE(bp->xdp_prog))
+		bnxt_set_rx_skb_mode(bp, true);
+
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-- 
2.25.1


