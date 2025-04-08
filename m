Return-Path: <stable+bounces-129873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B924A8019A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FCE18887E5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319C22424C;
	Tue,  8 Apr 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U9V/79j/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379A216E30;
	Tue,  8 Apr 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112208; cv=none; b=oW8BLF73bWkM/mJ6tNNyRyWxAnJi6LONlP/v8zdMIi/qwz8T4npMEnzk2gA4aJiDuqA0QBvH75RI36jzcvUh/kokNj3lORqChiwcrsNgc2ynnpx2OYeSYFuVs8Pt9rr8UDqeRHLH5bLxDgl25136BtMfWK1fYGaKmw4YDhMXuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112208; c=relaxed/simple;
	bh=0WV5NxAKUkXdVjMpzSeBzGlJJ1l+ivv1BJ7rQSAOZ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNcnJ3qtqvzNmLNVjy1A0tne+HcQmh9AwA7w4rEJeNBR2y1hTWHlRHWe87FS734TSnHylUWJkbCRYbn0Ufzh/5CUpkvQfjiYroHz93ONmZMBNNv3RFHQCzzs8QfCqzRfGPwpPSR4+UT/RSvGgC3D/0hcATlPu9rrMN/iJulYHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U9V/79j/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96C4C4CEE5;
	Tue,  8 Apr 2025 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112208;
	bh=0WV5NxAKUkXdVjMpzSeBzGlJJ1l+ivv1BJ7rQSAOZ0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9V/79j/9kGsZUHlF61FYx4v0Y4jrCvpI5myGTx7c2JrbS9PhnLdNiBZ0WJNxWR1E
	 bEB7lnj5dzECHYsM3SS2jWjWMBuu8QaWE+dLbv6D/19S0/YRZzaXlEKZJkMAxuhgEe
	 QZXIzzgVQ+vZAq9H2Wq2z1XgKjTDzDBAoqjyD2H8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Morrow <usbwifi2024@gmail.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Salah Coronya <salah.coronya@gmail.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.14 714/731] wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
Date: Tue,  8 Apr 2025 12:50:11 +0200
Message-ID: <20250408104930.883289181@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

commit adc3fd2a2277b7cc0b61692463771bf9bd298036 upstream.

Address a kernel panic caused by a null pointer dereference in the
`mt792x_rx_get_wcid` function. The issue arises because the `deflink` structure
is not properly initialized with the `sta` context. This patch ensures that the
`deflink` structure is correctly linked to the `sta` context, preventing the
null pointer dereference.

 BUG: kernel NULL pointer dereference, address: 0000000000000400
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 0 UID: 0 PID: 470 Comm: mt76-usb-rx phy Not tainted 6.12.13-gentoo-dist #1
 Hardware name:  /AMD HUDSON-M1, BIOS 4.6.4 11/15/2011
 RIP: 0010:mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
 RSP: 0018:ffffa147c055fd98 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff8e9ecb652000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8e9ecb652000
 RBP: 0000000000000685 R08: ffff8e9ec6570000 R09: 0000000000000000
 R10: ffff8e9ecd2ca000 R11: ffff8e9f22a217c0 R12: 0000000038010119
 R13: 0000000080843801 R14: ffff8e9ec6570000 R15: ffff8e9ecb652000
 FS:  0000000000000000(0000) GS:ffff8e9f22a00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000400 CR3: 000000000d2ea000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  ? __die_body.cold+0x19/0x27
  ? page_fault_oops+0x15a/0x2f0
  ? search_module_extables+0x19/0x60
  ? search_bpf_extables+0x5f/0x80
  ? exc_page_fault+0x7e/0x180
  ? asm_exc_page_fault+0x26/0x30
  ? mt792x_rx_get_wcid+0x48/0x140 [mt792x_lib]
  mt7921_queue_rx_skb+0x1c6/0xaa0 [mt7921_common]
  mt76u_alloc_queues+0x784/0x810 [mt76_usb]
  ? __pfx___mt76_worker_fn+0x10/0x10 [mt76]
  __mt76_worker_fn+0x4f/0x80 [mt76]
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

Reported-by: Nick Morrow <usbwifi2024@gmail.com>
Closes: https://github.com/morrownr/USB-WiFi/issues/577
Cc: stable@vger.kernel.org
Fixes: 90c10286b176 ("wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Salah Coronya <salah.coronya@gmail.com>
Link: https://patch.msgid.link/20250218033343.1999648-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -811,6 +811,7 @@ int mt7921_mac_sta_add(struct mt76_dev *
 	msta->deflink.wcid.phy_idx = mvif->bss_conf.mt76.band_idx;
 	msta->deflink.wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	msta->deflink.last_txs = jiffies;
+	msta->deflink.sta = msta;
 
 	ret = mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 	if (ret)



