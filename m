Return-Path: <stable+bounces-83387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D967998EE0
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECE11C21F70
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7D1D0432;
	Thu, 10 Oct 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xqa6crvg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187191CFEC6
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582701; cv=none; b=aPCNcUiM5bTytCgxOAu4XjtVnhZbMGp0WoJmMxqATMCfbKtlagWfhY/UKP0F+zmC6BYSCWcO7g7TTdAzewIsfwqDxkBhWdfG/S9CHCcvy5jVyQiv0yHmQrjYDACSvS/J79Mw42SH8AonW5JvLF8QWaUxjL48i0UgN04PEqk1gI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582701; c=relaxed/simple;
	bh=IywaZWF+g2PbDc1VwQqvpFLC3+ytyFGpwFePV11UE3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZZ9M0OvKgtASwuzLH7aPtSVveJsFd1fFGq5zd/+9GHSd7WrGFUMfeisqDV5i2FfSaJGvB+6whfV479yCoKodOCfsyl6k3f8eI4IduDH9E1cFr29J6xePsPVKye02EUXzi7uclEFxsTg/KvVLzQ/KLZd2mIUJqSs7IDL7zLyvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xqa6crvg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728582699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUwkPzApTD7NhHibkGSsv7YC+83MOmdVz2KjAeVYO1o=;
	b=Xqa6crvgvcIdHDYgL3g1k5kAJhccGCZVeMQvKVV50KlI9OKBM55Z3CTp11Qrv1wuFRIgWu
	IEx9V4GhwRXs4oLISLIGurb6MGzpPHM5ZjXzGsfL/lCJhwKREC4iMW1R0s5lUkY6pGRKJr
	rxljMvVb2+rcmMwMgNx/HV+Fk/6evmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-OWOItd8oNAiTynnGMLP7ow-1; Thu,
 10 Oct 2024 13:51:34 -0400
X-MC-Unique: OWOItd8oNAiTynnGMLP7ow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3581955BE1;
	Thu, 10 Oct 2024 17:51:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.239])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E65E519560A2;
	Thu, 10 Oct 2024 17:51:29 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath12k: fix warning when unbinding
Date: Thu, 10 Oct 2024 19:48:59 +0200
Message-ID: <20241010175102.207324-3-jtornosm@redhat.com>
In-Reply-To: <20241010175102.207324-1-jtornosm@redhat.com>
References: <20241010175102.207324-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If there is an error during some initialization realated to firmware,
the buffers dp->tx_ring[i].tx_status are released.
However this is released again when the device is unbinded (ath12k_pci),
and we get:
[   41.271233] WARNING: CPU: 0 PID: 2098 at mm/slub.c:4689 free_large_kmalloc+0x4d/0x80
[   41.271246] Modules linked in: uinput snd_seq_dummy snd_hrtimer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc qrtr_mhi intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvm_intel kvm rapl qrtr snd_hda_codec_generic ath12k qmi_helpers snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi iTCO_wdt intel_pmc_bxt mac80211 snd_hda_codec iTCO_vendor_support libarc4 snd_hda_core snd_hwdep snd_seq snd_seq_device cfg80211 snd_pcm pcspkr i2c_i801 snd_timer i2c_smbus snd rfkill soundcore lpc_ich mhi virtio_balloon joydev xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_net virtio_blk virtio_console virtio_gpu net_failover failover virtio_dma_buf serio_raw fuse qemu_fw_cfg
[   41.271284] CPU: 0 UID: 0 PID: 2098 Comm: bash Kdump: loaded Not tainted 6.12.0-rc1+ #29
[   41.271286] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[   41.271287] RIP: 0010:free_large_kmalloc+0x4d/0x80
[   41.271289] Code: 00 10 00 00 48 d3 e0 f7 d8 81 e2 c0 00 00 00 75 2f 89 c6 48 89 df e8 82 ff ff ff f0 ff 4b 34 0f 85 59 0e ce 00 e9 5b 0e ce 00 <0f> 0b 80 3d c8 29 3c 02 00 0f 84 2d 0e ce 00 b8 00 f0 ff ff eb d1
[   41.271290] RSP: 0018:ffffa40881a33c50 EFLAGS: 00010246
[   41.271292] RAX: 000fffffc0000000 RBX: ffffe697c0278000 RCX: 0000000000000000
[   41.271293] RDX: ffffe697c0b60008 RSI: ffff8d00c9e00000 RDI: ffffe697c0278000
[   41.271294] RBP: ffff8d00c3af0000 R08: ffff8d00f215d0c0 R09: 0000000080400038
[   41.271294] R10: 0000000080400038 R11: 0000000000000000 R12: 0000000000000001
[   41.271295] R13: ffffffffc0ef8948 R14: ffffffffc0ef8948 R15: ffff8d00c1277560
[   41.271296] FS:  00007fd31e556740(0000) GS:ffff8d011e400000(0000) knlGS:0000000000000000
[   41.271297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.271298] CR2: 00007f778d3ffb38 CR3: 00000000065dc000 CR4: 0000000000752ef0
[   41.271301] PKRU: 55555554
[   41.271302] Call Trace:
[   41.271304]  <TASK>
[   41.271304]  ? free_large_kmalloc+0x4d/0x80
[   41.271306]  ? __warn.cold+0x93/0xfa
[   41.271308]  ? free_large_kmalloc+0x4d/0x80
[   41.271311]  ? report_bug+0xff/0x140
[   41.271314]  ? handle_bug+0x58/0x90
[   41.271316]  ? exc_invalid_op+0x17/0x70
[   41.271317]  ? asm_exc_invalid_op+0x1a/0x20
[   41.271321]  ? free_large_kmalloc+0x4d/0x80
[   41.271323]  ath12k_dp_free+0xdc/0x110 [ath12k]
[   41.271337]  ath12k_core_deinit+0x8d/0xb0 [ath12k]
[   41.271345]  ath12k_pci_remove+0x50/0xf0 [ath12k]
[   41.271354]  pci_device_remove+0x3f/0xb0
[   41.271356]  device_release_driver_internal+0x19c/0x200
[   41.271359]  unbind_store+0xa1/0xb0
...

The issue is always reproducible from a VM because the MSI addressing
initialization is failing.

In order to fix the issue, just check if the buffers were already released
and if they need to be released, in addition set to NULL for the checking.

cc: stable@vger.kernel.org
Fixes: d889913205cf7 ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 789d430e4455..9d878d815f3c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1277,8 +1277,12 @@ void ath12k_dp_free(struct ath12k_base *ab)
 
 	ath12k_dp_rx_reo_cmd_list_cleanup(ab);
 
-	for (i = 0; i < ab->hw_params->max_tx_ring; i++)
-		kfree(dp->tx_ring[i].tx_status);
+	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
+		if (dp->tx_ring[i].tx_status) {
+			kfree(dp->tx_ring[i].tx_status);
+			dp->tx_ring[i].tx_status = NULL;
+		}
+	}
 
 	ath12k_dp_rx_free(ab);
 	/* Deinit any SOC level resource */
-- 
2.46.2


