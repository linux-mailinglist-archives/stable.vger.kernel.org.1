Return-Path: <stable+bounces-74512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D072E972FAE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA801C246ED
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5418BC3F;
	Tue, 10 Sep 2024 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpxEMPZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83518B46D;
	Tue, 10 Sep 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962023; cv=none; b=lnUI61g9spy4O0QKqU4So2A/LVFz+pzviGh6vx8CBSWtBuvshTS29C9Y8E3XPt/LjkPOA4gQsIH2+j9+ZuV32ZOZdDCuDTnNp1cSf/ALlJyQe7oZ12cfbQqxycWHoGPhZMvfhiu+rVtm/eLJgnQnVJ6OT7Pn3RtNeXQZJ0sDwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962023; c=relaxed/simple;
	bh=JmY4NCmeEBMsUifR+3PsK1dWawM82Cu40+c+wjl6VPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGA57lInqV+RLgWOS1dsVD6tqzNwJkODfQ1q0Z8vL1NP3UFZGV4afvqJW8L0MyOjekhbZMPaT/Z01Rp/J/qcVarNryAmlPzstQiBeBTMc0n0hpKnm5YMJFi7ypG94WosEUD8eg5bSXNiw8vk3N4xI3s1anlK71PGyt0kUgEWcAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpxEMPZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C74C4CEC6;
	Tue, 10 Sep 2024 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962022;
	bh=JmY4NCmeEBMsUifR+3PsK1dWawM82Cu40+c+wjl6VPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpxEMPZDJs5Ew8NDschVQcvq9lYBzEILsXEVyUVnmP/5zHe6thYcRxRCDU5jdKS/I
	 fsNUPKonqY0MJXRs06ZH7iKf12zkWv2zp7KPPWE8g08kdsvC9nG+Qc1RT94xiPBVv0
	 M5SZBK/yav0Bk7Ak9uncl1zMLhZgW7CoGtUsrspI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	Guillaume Legoupil <guillaume.legoupil@nxp.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 251/375] Bluetooth: btnxpuart: Fix Null pointer dereference in btnxpuart_flush()
Date: Tue, 10 Sep 2024 11:30:48 +0200
Message-ID: <20240910092630.977502574@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

[ Upstream commit c68bbf5e334b35b36ac5b9f0419f1f93f796bad1 ]

This adds a check before freeing the rx->skb in flush and close
functions to handle the kernel crash seen while removing driver after FW
download fails or before FW download completes.

dmesg log:
[   54.634586] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
[   54.643398] Mem abort info:
[   54.646204]   ESR = 0x0000000096000004
[   54.649964]   EC = 0x25: DABT (current EL), IL = 32 bits
[   54.655286]   SET = 0, FnV = 0
[   54.658348]   EA = 0, S1PTW = 0
[   54.661498]   FSC = 0x04: level 0 translation fault
[   54.666391] Data abort info:
[   54.669273]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   54.674768]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   54.674771]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   54.674775] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000048860000
[   54.674780] [0000000000000080] pgd=0000000000000000, p4d=0000000000000000
[   54.703880] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   54.710152] Modules linked in: btnxpuart(-) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce polyval_generic snd_soc_imx_spdif snd_soc_imx_card snd_soc_ak5558 snd_soc_ak4458 caam secvio error snd_soc_fsl_micfil snd_soc_fsl_spdif snd_soc_fsl_sai snd_soc_fsl_utils imx_pcm_dma gpio_ir_recv rc_core sch_fq_codel fuse
[   54.744357] CPU: 3 PID: 72 Comm: kworker/u9:0 Not tainted 6.6.3-otbr-g128004619037 #2
[   54.744364] Hardware name: FSL i.MX8MM EVK board (DT)
[   54.744368] Workqueue: hci0 hci_power_on
[   54.757244] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   54.757249] pc : kfree_skb_reason+0x18/0xb0
[   54.772299] lr : btnxpuart_flush+0x40/0x58 [btnxpuart]
[   54.782921] sp : ffff8000805ebca0
[   54.782923] x29: ffff8000805ebca0 x28: ffffa5c6cf1869c0 x27: ffffa5c6cf186000
[   54.782931] x26: ffff377b84852400 x25: ffff377b848523c0 x24: ffff377b845e7230
[   54.782938] x23: ffffa5c6ce8dbe08 x22: ffffa5c6ceb65410 x21: 00000000ffffff92
[   54.782945] x20: ffffa5c6ce8dbe98 x19: ffffffffffffffac x18: ffffffffffffffff
[   54.807651] x17: 0000000000000000 x16: ffffa5c6ce2824ec x15: ffff8001005eb857
[   54.821917] x14: 0000000000000000 x13: ffffa5c6cf1a02e0 x12: 0000000000000642
[   54.821924] x11: 0000000000000040 x10: ffffa5c6cf19d690 x9 : ffffa5c6cf19d688
[   54.821931] x8 : ffff377b86000028 x7 : 0000000000000000 x6 : 0000000000000000
[   54.821938] x5 : ffff377b86000000 x4 : 0000000000000000 x3 : 0000000000000000
[   54.843331] x2 : 0000000000000000 x1 : 0000000000000002 x0 : ffffffffffffffac
[   54.857599] Call trace:
[   54.857601]  kfree_skb_reason+0x18/0xb0
[   54.863878]  btnxpuart_flush+0x40/0x58 [btnxpuart]
[   54.863888]  hci_dev_open_sync+0x3a8/0xa04
[   54.872773]  hci_power_on+0x54/0x2e4
[   54.881832]  process_one_work+0x138/0x260
[   54.881842]  worker_thread+0x32c/0x438
[   54.881847]  kthread+0x118/0x11c
[   54.881853]  ret_from_fork+0x10/0x20
[   54.896406] Code: a9be7bfd 910003fd f9000bf3 aa0003f3 (b940d400)
[   54.896410] ---[ end trace 0000000000000000 ]---

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btnxpuart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index eeba2d26d1cb..5890ecd8e948 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1326,8 +1326,10 @@ static int btnxpuart_close(struct hci_dev *hdev)
 
 	serdev_device_close(nxpdev->serdev);
 	skb_queue_purge(&nxpdev->txq);
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
@@ -1342,8 +1344,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
 
 	cancel_work_sync(&nxpdev->tx_work);
 
-	kfree_skb(nxpdev->rx_skb);
-	nxpdev->rx_skb = NULL;
+	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
+		kfree_skb(nxpdev->rx_skb);
+		nxpdev->rx_skb = NULL;
+	}
 
 	return 0;
 }
-- 
2.43.0




