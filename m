Return-Path: <stable+bounces-145487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65939ABDC90
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7436E4C5D6A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3AB24BD03;
	Tue, 20 May 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xSuKWru9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86D247DE1;
	Tue, 20 May 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750319; cv=none; b=UxJjQAqZhqFTRbc8E01MEu4/UiUGHccOoJt3rxYVf2JSz0/lEdUtwtcErevH3ForL1LHQUzFdOYhlYD8xcs80j2sA6Pkhn2mvPPRuGHajiYbLSuVQxNPoEsmmGHUj96ichI/RWeX5QOXAyGpKaLVMuDXgZ5FA70yC/2EcSr2qRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750319; c=relaxed/simple;
	bh=Gi+mVUIoE+MMDxyM+xPeYrmr2XQUBCZnRVEF7takZzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds2bXkFc86dufcfMNrCfTiBdQFA+KLsAy7UCOwACae1OSUvLL8XR8/At8rYjWN16wXXL4DWIQJ8rb57tCwRqRvyEIFOvgVc2+zaAo0lOr1CUaHVrJbZNlEmFfwhbV2RyaXEe4VG9kGZjU10ngbKz6jx3ZnkOJYsz8IafiW/yxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xSuKWru9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9033AC4CEEB;
	Tue, 20 May 2025 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750319;
	bh=Gi+mVUIoE+MMDxyM+xPeYrmr2XQUBCZnRVEF7takZzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xSuKWru958Pd2oGOFok+NA92vgvfJ+XEEJ4o482xW26eEGTLyC5S4Tkj0J/3E2LwT
	 DJ8AC6KVgaVeyCqyJvnyRk6ZG+Rbdj1/79kqmg4i2xJg651OkajNxktXFpgW8UdBXO
	 ZHr3X8yLhJIzlBqAu+K/qTAwVbhKosXt6b1X9PRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.12 114/143] wifi: mt76: disable napi on driver removal
Date: Tue, 20 May 2025 15:51:09 +0200
Message-ID: <20250520125814.520747146@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 78ab4be549533432d97ea8989d2f00b508fa68d8 upstream.

A warning on driver removal started occurring after commit 9dd05df8403b
("net: warn if NAPI instance wasn't shut down"). Disable tx napi before
deleting it in mt76_dma_cleanup().

 WARNING: CPU: 4 PID: 18828 at net/core/dev.c:7288 __netif_napi_del_locked+0xf0/0x100
 CPU: 4 UID: 0 PID: 18828 Comm: modprobe Not tainted 6.15.0-rc4 #4 PREEMPT(lazy)
 Hardware name: ASUS System Product Name/PRIME X670E-PRO WIFI, BIOS 3035 09/05/2024
 RIP: 0010:__netif_napi_del_locked+0xf0/0x100
 Call Trace:
 <TASK>
 mt76_dma_cleanup+0x54/0x2f0 [mt76]
 mt7921_pci_remove+0xd5/0x190 [mt7921e]
 pci_device_remove+0x47/0xc0
 device_release_driver_internal+0x19e/0x200
 driver_detach+0x48/0x90
 bus_remove_driver+0x6d/0xf0
 pci_unregister_driver+0x2e/0xb0
 __do_sys_delete_module.isra.0+0x197/0x2e0
 do_syscall_64+0x7b/0x160
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Tested with mt7921e but the same pattern can be actually applied to other
mt76 drivers calling mt76_dma_cleanup() during removal. Tx napi is enabled
in their *_dma_init() functions and only toggled off and on again inside
their suspend/resume/reset paths. So it should be okay to disable tx
napi in such a generic way.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2ac515a5d74f ("mt76: mt76x02: use napi polling for tx cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Tested-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250506115540.19045-1-pchelkin@ispras.ru
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -999,6 +999,7 @@ void mt76_dma_cleanup(struct mt76_dev *d
 	int i;
 
 	mt76_worker_disable(&dev->tx_worker);
+	napi_disable(&dev->tx_napi);
 	netif_napi_del(&dev->tx_napi);
 
 	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {



