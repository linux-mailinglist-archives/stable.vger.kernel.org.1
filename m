Return-Path: <stable+bounces-168769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D14B236AB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF531B66657
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F40C2FE588;
	Tue, 12 Aug 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AE/WzrX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D01C1AAA;
	Tue, 12 Aug 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025270; cv=none; b=oBIE7ty1gMIL/ywebrK7Akqa/scy1Nwli0yv4ufHTf3LfLPXx16qUjf4DzQ0pAAnFR/p82YwsdrF3hLbcflfWtPenUwVu+8pokPoOkhod84suE+xNyi+az7h02C8xn0HQ0eG8+BYU1k+89yT2+nkYKc1XoHVx+9CvWHRBE2SP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025270; c=relaxed/simple;
	bh=34nuTdTCswzBFmvYhIsb9o5SEspHbYT+LeV2yOOd/Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc7BzEmrNXym/3qXVqVCzYHrGxfS0I1snyyCoApTRd8TNmX/IsrJYQJjE7XbPy6yf/LDEnThxM7NAaArkAjexEd20d9//qkox32aPop/H/huAjx8gWEOYstyv9bvl989uXDry0WEVK2q8ck2VtAHZKGJtWfO7Srs/bhw28KVXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AE/WzrX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A664C4CEF6;
	Tue, 12 Aug 2025 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025269;
	bh=34nuTdTCswzBFmvYhIsb9o5SEspHbYT+LeV2yOOd/Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE/WzrX4fWU9QVVeOuycVFbQ3hgdBkYC4uNmHjxkI8m2sYoJmx5fwfAzJaIobHNew
	 1hbwKpOK2W0pGXA46mH4tPjfgSk4OjVYWLYfRGNVjO9s77yYYdSzQrcSm5OP3bc29W
	 eGWPUS9WBpqdMXzWJtt5odIsI00sWIF4c6crsOyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sjoerd Simons <sjoerd@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Jai Luthra <jai.luthra@linux.dev>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.16 619/627] media: ti: j721e-csi2rx: fix list_del corruption
Date: Tue, 12 Aug 2025 19:35:14 +0200
Message-ID: <20250812173455.427097860@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Massot <julien.massot@collabora.com>

commit ae42c6fe531425ef2f47e82f96851427d24bbf6b upstream.

If ti_csi2rx_start_dma() fails in ti_csi2rx_dma_callback(), the buffer is
marked done with VB2_BUF_STATE_ERROR but is not removed from the DMA queue.
This causes the same buffer to be retried in the next iteration, resulting
in a double list_del() and eventual list corruption.

Fix this by removing the buffer from the queue before calling
vb2_buffer_done() on error.

This resolves a crash due to list_del corruption:
[   37.811243] j721e-csi2rx 30102000.ticsi2rx: Failed to queue the next buffer for DMA
[   37.832187]  slab kmalloc-2k start ffff00000255b000 pointer offset 1064 size 2048
[   37.839761] list_del corruption. next->prev should be ffff00000255bc28, but was ffff00000255d428. (next=ffff00000255b428)
[   37.850799] ------------[ cut here ]------------
[   37.855424] kernel BUG at lib/list_debug.c:65!
[   37.859876] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[   37.866061] Modules linked in: i2c_dev usb_f_rndis u_ether libcomposite dwc3 udc_core usb_common aes_ce_blk aes_ce_cipher ghash_ce gf128mul sha1_ce cpufreq_dt dwc3_am62 phy_gmii_sel sa2ul
[   37.882830] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3+ #28 VOLUNTARY
[   37.890851] Hardware name: Bosch STLA-GSRV2-B0 (DT)
[   37.895737] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   37.902703] pc : __list_del_entry_valid_or_report+0xdc/0x114
[   37.908390] lr : __list_del_entry_valid_or_report+0xdc/0x114
[   37.914059] sp : ffff800080003db0
[   37.917375] x29: ffff800080003db0 x28: 0000000000000007 x27: ffff800080e50000
[   37.924521] x26: 0000000000000000 x25: ffff0000016abb50 x24: dead000000000122
[   37.931666] x23: ffff0000016abb78 x22: ffff0000016ab080 x21: ffff800080003de0
[   37.938810] x20: ffff00000255bc00 x19: ffff00000255b800 x18: 000000000000000a
[   37.945956] x17: 20747562202c3832 x16: 6362353532303030 x15: 0720072007200720
[   37.953101] x14: 0720072007200720 x13: 0720072007200720 x12: 00000000ffffffea
[   37.960248] x11: ffff800080003b18 x10: 00000000ffffefff x9 : ffff800080f5b568
[   37.967396] x8 : ffff800080f5b5c0 x7 : 0000000000017fe8 x6 : c0000000ffffefff
[   37.974542] x5 : ffff00000fea6688 x4 : 0000000000000000 x3 : 0000000000000000
[   37.981686] x2 : 0000000000000000 x1 : ffff800080ef2b40 x0 : 000000000000006d
[   37.988832] Call trace:
[   37.991281]  __list_del_entry_valid_or_report+0xdc/0x114 (P)
[   37.996959]  ti_csi2rx_dma_callback+0x84/0x1c4
[   38.001419]  udma_vchan_complete+0x1e0/0x344
[   38.005705]  tasklet_action_common+0x118/0x310
[   38.010163]  tasklet_action+0x30/0x3c
[   38.013832]  handle_softirqs+0x10c/0x2e0
[   38.017761]  __do_softirq+0x14/0x20
[   38.021256]  ____do_softirq+0x10/0x20
[   38.024931]  call_on_irq_stack+0x24/0x60
[   38.028873]  do_softirq_own_stack+0x1c/0x40
[   38.033064]  __irq_exit_rcu+0x130/0x15c
[   38.036909]  irq_exit_rcu+0x10/0x20
[   38.040403]  el1_interrupt+0x38/0x60
[   38.043987]  el1h_64_irq_handler+0x18/0x24
[   38.048091]  el1h_64_irq+0x6c/0x70
[   38.051501]  default_idle_call+0x34/0xe0 (P)
[   38.055783]  do_idle+0x1f8/0x250
[   38.059021]  cpu_startup_entry+0x34/0x3c
[   38.062951]  rest_init+0xb4/0xc0
[   38.066186]  console_on_rootfs+0x0/0x6c
[   38.070031]  __primary_switched+0x88/0x90
[   38.074059] Code: b00037e0 91378000 f9400462 97e9bf49 (d4210000)
[   38.080168] ---[ end trace 0000000000000000 ]---
[   38.084795] Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt
[   38.092197] SMP: stopping secondary CPUs
[   38.096139] Kernel Offset: disabled
[   38.099631] CPU features: 0x0000,00002000,02000801,0400420b
[   38.105202] Memory Limit: none
[   38.108260] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt ]---

Fixes: b4a3d877dc92 ("media: ti: Add CSI2RX support for J721E")
Cc: stable@vger.kernel.org
Suggested-by: Sjoerd Simons <sjoerd@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Jai Luthra <jai.luthra@linux.dev>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -619,6 +619,7 @@ static void ti_csi2rx_dma_callback(void
 
 		if (ti_csi2rx_start_dma(csi, buf)) {
 			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
+			list_del(&buf->list);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 		} else {
 			list_move_tail(&buf->list, &dma->submitted);



