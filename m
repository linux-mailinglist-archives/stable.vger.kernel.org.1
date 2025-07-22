Return-Path: <stable+bounces-163965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EDB0DC75
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E1B18890F0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EC28B7EA;
	Tue, 22 Jul 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Er6kw7BL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E5288C01;
	Tue, 22 Jul 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192799; cv=none; b=oThiBk5Hppuem7XCH+mm0Bbpp0AlPOHROZqU7h7uV9YtZN1KgaWdnrAFi/I17t9GupFr0hppdxmGXolK7WeRx82hId1q0jw+S6Z3sUCQ28TmHIeASdPBPgVyffOMGlz3RHariZEj5L1qdQZQkUxA9mrrviPXZz+lz3n2hv8OADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192799; c=relaxed/simple;
	bh=5wMGWBf/TwTyJd5h772EluSdwbi6EPJgkPw6EEQlB54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmSKTC23eQw+XZ+p6UkNHnmJr1MCJPnB+Cuhv7suh6wWbpFEtR6UEMMmw3ZlP5Qph7ccMv2Yw6vOI/UoCBnsW1XbDS2LI5GYDgfmyXw77DeboAE7T0xbRDZHmNraRPBP6psB1dJ6N16oFFiN3NE3XaD5+h/QrJPaIrZSpzrxuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Er6kw7BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B99C4CEEB;
	Tue, 22 Jul 2025 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192799;
	bh=5wMGWBf/TwTyJd5h772EluSdwbi6EPJgkPw6EEQlB54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Er6kw7BLUhFCCbPoTAYruBsXPrulaSI0dRcPLzdmNWudbL8poJ0PmrkpPM8gNN4K8
	 mKJH5XRgBUurCJZf9hHR5YmgZyBMsGMNNJeVXzCnLiKf1dsmVp4ACSlVE6GOa694k5
	 6X265bgIMdjhd2eETFqvkBWmtEqkTU3o+qZe5w+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 059/158] net: libwx: remove duplicate page_pool_put_full_page()
Date: Tue, 22 Jul 2025 15:44:03 +0200
Message-ID: <20250722134342.951023883@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawen Wu <jiawenwu@trustnetic.com>

commit 1b7e585c04cd5f0731dd25ffd396277e55fae0e6 upstream.

page_pool_put_full_page() should only be invoked when freeing Rx buffers
or building a skb if the size is too short. At other times, the pages
need to be reused. So remove the redundant page put. In the original
code, double free pages cause kernel panic:

[  876.949834]  __irq_exit_rcu+0xc7/0x130
[  876.949836]  common_interrupt+0xb8/0xd0
[  876.949838]  </IRQ>
[  876.949838]  <TASK>
[  876.949840]  asm_common_interrupt+0x22/0x40
[  876.949841] RIP: 0010:cpuidle_enter_state+0xc2/0x420
[  876.949843] Code: 00 00 e8 d1 1d 5e ff e8 ac f0 ff ff 49 89 c5 0f 1f 44 =
00 00 31 ff e8 cd fc 5c ff 45 84 ff 0f 85 40 02 00 00 fb 0f 1f 44 00 00 <45=
> 85 f6 0f 88 84 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[  876.949844] RSP: 0018:ffffaa7340267e78 EFLAGS: 00000246
[  876.949845] RAX: ffff9e3f135be000 RBX: 0000000000000002 RCX: 00000000000=
00000
[  876.949846] RDX: 000000cc2dc4cb7c RSI: ffffffff89ee49ae RDI: ffffffff89e=
f9f9e
[  876.949847] RBP: ffff9e378f940800 R08: 0000000000000002 R09: 00000000000=
000ed
[  876.949848] R10: 000000000000afc8 R11: ffff9e3e9e5a9b6c R12: ffffffff8a6=
d8580
[  876.949849] R13: 000000cc2dc4cb7c R14: 0000000000000002 R15: 00000000000=
00000
[  876.949852]  ? cpuidle_enter_state+0xb3/0x420
[  876.949855]  cpuidle_enter+0x29/0x40
[  876.949857]  cpuidle_idle_call+0xfd/0x170
[  876.949859]  do_idle+0x7a/0xc0
[  876.949861]  cpu_startup_entry+0x25/0x30
[  876.949862]  start_secondary+0x117/0x140
[  876.949864]  common_startup_64+0x13e/0x148
[  876.949867]  </TASK>
[  876.949868] ---[ end trace 0000000000000000 ]---
[  876.949869] ------------[ cut here ]------------
[  876.949870] list_del corruption, ffffead40445a348->next is NULL
[  876.949873] WARNING: CPU: 14 PID: 0 at lib/list_debug.c:52 __list_del_en=
try_valid_or_report+0x67/0x120
[  876.949875] Modules linked in: snd_hrtimer(E) bnep(E) binfmt_misc(E) amd=
gpu(E) squashfs(E) vfat(E) loop(E) fat(E) amd_atl(E) snd_hda_codec_realtek(=
E) intel_rapl_msr(E) snd_hda_codec_generic(E) intel_rapl_common(E) snd_hda_=
scodec_component(E) snd_hda_codec_hdmi(E) snd_hda_intel(E) edac_mce_amd(E) =
snd_intel_dspcfg(E) snd_hda_codec(E) snd_hda_core(E) amdxcp(E) kvm_amd(E) s=
nd_hwdep(E) gpu_sched(E) drm_panel_backlight_quirks(E) cec(E) snd_pcm(E) dr=
m_buddy(E) snd_seq_dummy(E) drm_ttm_helper(E) btusb(E) kvm(E) snd_seq_oss(E=
) btrtl(E) ttm(E) btintel(E) snd_seq_midi(E) btbcm(E) drm_exec(E) snd_seq_m=
idi_event(E) i2c_algo_bit(E) snd_rawmidi(E) bluetooth(E) drm_suballoc_helpe=
r(E) irqbypass(E) snd_seq(E) ghash_clmulni_intel(E) sha512_ssse3(E) drm_dis=
play_helper(E) aesni_intel(E) snd_seq_device(E) rfkill(E) snd_timer(E) gf12=
8mul(E) drm_client_lib(E) drm_kms_helper(E) snd(E) i2c_piix4(E) joydev(E) s=
oundcore(E) wmi_bmof(E) ccp(E) k10temp(E) i2c_smbus(E) gpio_amdpt(E) i2c_de=
signware_platform(E) gpio_generic(E) sg(E)
[  876.949914]  i2c_designware_core(E) sch_fq_codel(E) parport_pc(E) drm(E)=
 ppdev(E) lp(E) parport(E) fuse(E) nfnetlink(E) ip_tables(E) ext4 crc16 mbc=
ache jbd2 sd_mod sfp mdio_i2c i2c_core txgbe ahci ngbe pcs_xpcs libahci lib=
wx r8169 phylink libata realtek ptp pps_core video wmi
[  876.949933] CPU: 14 UID: 0 PID: 0 Comm: swapper/14 Kdump: loaded Tainted=
: G        W   E       6.16.0-rc2+ #20 PREEMPT(voluntary)
[  876.949935] Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE
[  876.949936] Hardware name: Micro-Star International Co., Ltd. MS-7E16/X6=
70E GAMING PLUS WIFI (MS-7E16), BIOS 1.90 12/31/2024
[  876.949936] RIP: 0010:__list_del_entry_valid_or_report+0x67/0x120
[  876.949938] Code: 00 00 00 48 39 7d 08 0f 85 a6 00 00 00 5b b8 01 00 00 =
00 5d 41 5c e9 73 0d 93 ff 48 89 fe 48 c7 c7 a0 31 e8 89 e8 59 7c b3 ff <0f=
> 0b 31 c0 5b 5d 41 5c e9 57 0d 93 ff 48 89 fe 48 c7 c7 c8 31 e8
[  876.949940] RSP: 0018:ffffaa73405d0c60 EFLAGS: 00010282
[  876.949941] RAX: 0000000000000000 RBX: ffffead40445a348 RCX: 00000000000=
00000
[  876.949942] RDX: 0000000000000105 RSI: 0000000000000001 RDI: 00000000fff=
fffff
[  876.949943] RBP: 0000000000000000 R08: 000000010006dfde R09: ffffffff8a4=
7d150
[  876.949944] R10: ffffffff8a47d150 R11: 0000000000000003 R12: dead0000000=
00122
[  876.949945] R13: ffff9e3e9e5af700 R14: ffffead40445a348 R15: ffff9e3e9e5=
af720
[  876.949946] FS:  0000000000000000(0000) GS:ffff9e3f135be000(0000) knlGS:=
0000000000000000
[  876.949947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  876.949948] CR2: 00007fa58b480048 CR3: 0000000156724000 CR4: 00000000007=
50ef0
[  876.949949] PKRU: 55555554
[  876.949950] Call Trace:
[  876.949951]  <IRQ>
[  876.949952]  __rmqueue_pcplist+0x53/0x2c0
[  876.949955]  alloc_pages_bulk_noprof+0x2e0/0x660
[  876.949958]  __page_pool_alloc_pages_slow+0xa9/0x400
[  876.949961]  page_pool_alloc_pages+0xa/0x20
[  876.949963]  wx_alloc_rx_buffers+0xd7/0x110 [libwx]
[  876.949967]  wx_clean_rx_irq+0x262/0x430 [libwx]
[  876.949971]  wx_poll+0x92/0x130 [libwx]
[  876.949975]  __napi_poll+0x28/0x190
[  876.949977]  net_rx_action+0x301/0x3f0
[  876.949980]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949981]  ? profile_tick+0x30/0x70
[  876.949983]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949984]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949986]  ? timerqueue_add+0xa3/0xc0
[  876.949988]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949989]  ? __raise_softirq_irqoff+0x16/0x70
[  876.949991]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949993]  ? srso_alias_return_thunk+0x5/0xfbef5
[  876.949994]  ? wx_msix_clean_rings+0x41/0x50 [libwx]
[  876.949998]  handle_softirqs+0xf9/0x2c0

Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250714024755.17512-2-jiawenwu@trustnetic.c=
om
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  |   11 -----------
 drivers/net/ethernet/wangxun/libwx/wx_type.h |    1 -
 2 files changed, 12 deletions(-)

--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -172,10 +172,6 @@ static void wx_dma_sync_frag(struct wx_r
 				      skb_frag_off(frag),
 				      skb_frag_size(frag),
 				      DMA_FROM_DEVICE);
-
-	/* If the page was released, just unmap it. */
-	if (unlikely(WX_CB(skb)->page_released))
-		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
 }
=20
 static struct wx_rx_buffer *wx_get_rx_buffer(struct wx_ring *rx_ring,
@@ -225,10 +221,6 @@ static void wx_put_rx_buffer(struct wx_r
 			     struct sk_buff *skb,
 			     int rx_buffer_pgcnt)
 {
-	if (!IS_ERR(skb) && WX_CB(skb)->dma =3D=3D rx_buffer->dma)
-		/* the page has been released from the ring */
-		WX_CB(skb)->page_released =3D true;
-
 	/* clear contents of rx_buffer */
 	rx_buffer->page =3D NULL;
 	rx_buffer->skb =3D NULL;
@@ -2219,9 +2211,6 @@ static void wx_clean_rx_ring(struct wx_r
 		if (rx_buffer->skb) {
 			struct sk_buff *skb =3D rx_buffer->skb;
=20
-			if (WX_CB(skb)->page_released)
-				page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
-
 			dev_kfree_skb(skb);
 		}
=20
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -787,7 +787,6 @@ enum wx_reset_type {
 struct wx_cb {
 	dma_addr_t dma;
 	u16     append_cnt;      /* number of skb's appended */
-	bool    page_released;
 	bool    dma_released;
 };
=20



