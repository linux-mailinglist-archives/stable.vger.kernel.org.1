Return-Path: <stable+bounces-62093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155193E2F1
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B98B247B8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11019DFAB;
	Sun, 28 Jul 2024 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AevYz4gX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4F19DFA4;
	Sun, 28 Jul 2024 00:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128115; cv=none; b=ah9XHlVlhGjTcMOvJpYZBJ5zqSFmuiDAYaaON3qe/lWBCTlTZghCT1eKTwuF62ZqtZvDAgVASZHw8vor6w6rt5tEuHjg7mnwj8txjfBV1VOIWIRM5ghiqdVs/G0qAfGXdNoSI9A3VmRi0JguGogLLV1vBCNZTQc6k8mrDZNDGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128115; c=relaxed/simple;
	bh=F9bd3n+CVGUqmtHiWncOEfIoNG+/RsW9OoAZJVIZ5KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHctd27ewqYI/o/MbcVaivCB+wlsWNRT5EN1YSnBKd7LG7816fJ6XWiUKSzEyr7zb9iK5YFS5GfKNXf1pUk1uBjbD4/aPxVhuvVvY8yN/rlbZD3ZRRuPrtzbTFAqEz6sLWIjOWI3yR+9noPIhMLjyRP2wCNOiIrlCbm9+/bDQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AevYz4gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C985C32781;
	Sun, 28 Jul 2024 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128115;
	bh=F9bd3n+CVGUqmtHiWncOEfIoNG+/RsW9OoAZJVIZ5KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AevYz4gXoLNYga9EXWJO2MH2JrN7M6cGKO+8QLagVC3hOkNQdWT+uy1M/qOsXMrUX
	 G9Xjp+qy4dEtu/Wok2C1WAUA2Yv9Ihz05GjzFoLg3ilXgxqSLgZ4nv/P7xTIa0CFi8
	 x4pyHKvEHb0uzsg2vgwKhrXLUCLuDSXSSn6PCUPdDIbcR59Qkk3pX5KVTRYODBaxXU
	 TqZxAkxzx2jZQSDEThCiSaPD61aERKdX4bVwcT4+P6Mgad+XTF1Qm4O7yHa5yy3jvy
	 +S/dVE2qYgHDaPt+f9k2VDMLCtYqZc/37Zy8Tp+98Vl8PKaeT++R1vfdzociZUGL8H
	 NQ0xDkYYTc1Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luke Wang <ziniu.wang_1@nxp.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/15] Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading
Date: Sat, 27 Jul 2024 20:54:36 -0400
Message-ID: <20240728005442.1729384-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005442.1729384-1-sashal@kernel.org>
References: <20240728005442.1729384-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Luke Wang <ziniu.wang_1@nxp.com>

[ Upstream commit 0d0df1e750bac0fdaa77940e711c1625cff08d33 ]

When unload the btnxpuart driver, its associated timer will be deleted.
If the timer happens to be modified at this moment, it leads to the
kernel call this timer even after the driver unloaded, resulting in
kernel panic.
Use timer_shutdown_sync() instead of del_timer_sync() to prevent rearming.

panic log:
  Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
  Modules linked in: algif_hash algif_skcipher af_alg moal(O) mlan(O) crct10dif_ce polyval_ce polyval_generic   snd_soc_imx_card snd_soc_fsl_asoc_card snd_soc_imx_audmux mxc_jpeg_encdec v4l2_jpeg snd_soc_wm8962 snd_soc_fsl_micfil   snd_soc_fsl_sai flexcan snd_soc_fsl_utils ap130x rpmsg_ctrl imx_pcm_dma can_dev rpmsg_char pwm_fan fuse [last unloaded:   btnxpuart]
  CPU: 5 PID: 723 Comm: memtester Tainted: G           O       6.6.23-lts-next-06207-g4aef2658ac28 #1
  Hardware name: NXP i.MX95 19X19 board (DT)
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : 0xffff80007a2cf464
  lr : call_timer_fn.isra.0+0x24/0x80
...
  Call trace:
   0xffff80007a2cf464
   __run_timers+0x234/0x280
   run_timer_softirq+0x20/0x40
   __do_softirq+0x100/0x26c
   ____do_softirq+0x10/0x1c
   call_on_irq_stack+0x24/0x4c
   do_softirq_own_stack+0x1c/0x2c
   irq_exit_rcu+0xc0/0xdc
   el0_interrupt+0x54/0xd8
   __el0_irq_handler_common+0x18/0x24
   el0t_64_irq_handler+0x10/0x1c
   el0t_64_irq+0x190/0x194
  Code: ???????? ???????? ???????? ???????? (????????)
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Oops: Fatal exception in interrupt
  SMP: stopping secondary CPUs
  Kernel Offset: disabled
  CPU features: 0x0,c0000000,40028143,1000721b
  Memory Limit: none
  ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index abccd571cf3ee..45a06c94a8606 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -324,7 +324,7 @@ static void ps_cancel_timer(struct btnxpuart_dev *nxpdev)
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	flush_work(&psdata->work);
-	del_timer_sync(&psdata->ps_timer);
+	timer_shutdown_sync(&psdata->ps_timer);
 }
 
 static void ps_control(struct hci_dev *hdev, u8 ps_state)
-- 
2.43.0


