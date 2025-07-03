Return-Path: <stable+bounces-160089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C9AF7D01
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD591C26786
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619C231825;
	Thu,  3 Jul 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="gr9PokIw"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2320EB;
	Thu,  3 Jul 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558231; cv=none; b=sr8xRmOVCg4s85uy14Ni3XCpKOtG+BImFjN/ymUOvBrJBplFvluINy6JxsvPg29Bm8m8QwrDpzUyiLmZIRcUvGWmfljlTazduPvACaRu9Kri05MBk6JdYz7QFlVxUiEKxg5PFGkElkX0BQXDHIdiN3YRXXuEpj7LtHzC6Zr+Jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558231; c=relaxed/simple;
	bh=/5x31bYLbnmAB83D37kcWKmGopV4qwGGMcLgHfFnwYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+XRXib5p6BOhiZcla4Mpo6AhNMf8A8gNuFvenAyVghqi84mH+CHR5zXTbVZk6U2cO1lkto68r6XFvD9bXoR161iCWQ5cgnTPk757gX33izfsYJnvQQhZHQIxIimSesmmTwLgTZyT+2dzwI8DzBCkpePpQiunxT7mOt1WqbpcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=gr9PokIw; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1751558223;
	bh=/5x31bYLbnmAB83D37kcWKmGopV4qwGGMcLgHfFnwYY=;
	h=From:To:Cc:Subject:Date:From;
	b=gr9PokIw4mIydopjmsjlW9V00fNc/aOuSYdYpsM6iLdWO/JXrAyvB97mwUZP+1Uoq
	 +a6gELptkbQ4K0U3gYkSJaYHnNc2KGpf4CIrhTDoDPiBSfMhl6kTMgrJI2OO6h98vr
	 xB58gK0sZSTYYH+obolVodBju+V5feyUlj2AJz0ZcAuJttgTt9d6ofYSeAT1WU3YdD
	 6dFX4DHqYhwVMNBz9KC8BNoQZlQR/1ieoMyyPmjNfdV6lNZlbUHduV1pmrzvQczTjd
	 62C8sdytROg9EIuwQxsYteCbrFNDydAmjDWh2JUBKs4GseXbYjfNuruQ/fcp5Z4eY5
	 pHkPfc0EyM1Ug==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 5C9D21FA52;
	Thu,  3 Jul 2025 18:57:03 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 18:57:02 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.198.59.101])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bY1bv6HP3z16Hnq;
	Thu,  3 Jul 2025 18:56:59 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Yake Yang <yake.yang@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10] Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
Date: Thu,  3 Jul 2025 18:56:56 +0300
Message-ID: <20250703155657.32865-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194547 [Jul 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/03 14:34:00 #27614855
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit 0fab6361c4ba17d1b43a991bef4238a3c1754d35 ]

We should not access skb buffer data anymore after hci_recv_frame was
called.

[   39.634809] BUG: KASAN: use-after-free in btmtksdio_recv_event+0x1b0
[   39.634855] Read of size 1 at addr ffffff80cf28a60d by task kworker
[   39.634962] Call trace:
[   39.634974]  dump_backtrace+0x0/0x3b8
[   39.634999]  show_stack+0x20/0x2c
[   39.635016]  dump_stack_lvl+0x60/0x78
[   39.635040]  print_address_description+0x70/0x2f0
[   39.635062]  kasan_report+0x154/0x194
[   39.635079]  __asan_report_load1_noabort+0x44/0x50
[   39.635099]  btmtksdio_recv_event+0x1b0/0x1c4
[   39.635129]  btmtksdio_txrx_work+0x6cc/0xac4
[   39.635157]  process_one_work+0x560/0xc5c
[   39.635177]  worker_thread+0x7ec/0xcc0
[   39.635195]  kthread+0x2d0/0x3d0
[   39.635215]  ret_from_fork+0x10/0x20
[   39.635247] Allocated by task 0:
[   39.635260] (stack is not available)
[   39.635281] Freed by task 2392:
[   39.635295]  kasan_save_stack+0x38/0x68
[   39.635319]  kasan_set_track+0x28/0x3c
[   39.635338]  kasan_set_free_info+0x28/0x4c
[   39.635357]  ____kasan_slab_free+0x104/0x150
[   39.635374]  __kasan_slab_free+0x18/0x28
[   39.635391]  slab_free_freelist_hook+0x114/0x248
[   39.635410]  kfree+0xf8/0x2b4
[   39.635427]  skb_free_head+0x58/0x98
[   39.635447]  skb_release_data+0x2f4/0x410
[   39.635464]  skb_release_all+0x50/0x60
[   39.635481]  kfree_skb+0xc8/0x25c
[   39.635498]  hci_event_packet+0x894/0xca4 [bluetooth]
[   39.635721]  hci_rx_work+0x1c8/0x68c [bluetooth]
[   39.635925]  process_one_work+0x560/0xc5c
[   39.635951]  worker_thread+0x7ec/0xcc0
[   39.635970]  kthread+0x2d0/0x3d0
[   39.635990]  ret_from_fork+0x10/0x20
[   39.636021] The buggy address belongs to the object at ffffff80cf28a600
                which belongs to the cache kmalloc-512 of size 512
[   39.636039] The buggy address is located 13 bytes inside of
                512-byte region [ffffff80cf28a600, ffffff80cf28a800)

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
Backport fix for CVE-2022-49470
 drivers/bluetooth/btmtksdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c41560be39fb..6b31ee1a1dd9 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -331,6 +331,7 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct hci_event_hdr *hdr = (void *)skb->data;
+	u8 evt = hdr->evt;
 	int err;
 
 	/* Fix up the vendor event id with 0xff for vendor specific instead
@@ -355,7 +356,7 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	if (err < 0)
 		goto err_free_skb;
 
-	if (hdr->evt == HCI_EV_VENDOR) {
+	if (evt == HCI_EV_VENDOR) {
 		if (test_and_clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
 				       &bdev->tx_state)) {
 			/* Barrier to sync with other CPUs */
-- 
2.43.0


