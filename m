Return-Path: <stable+bounces-212010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEgnNnkremnd3gEAu9opvQ
	(envelope-from <stable+bounces-212010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:30:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F57A3DD5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4D50300D9A4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C52361644;
	Wed, 28 Jan 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmeS2QYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470C36D506;
	Wed, 28 Jan 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614095; cv=none; b=Z+JqbxhfJAIRPwlCpYL0m/jFOLRn4Nyx0DKROgeUDrqomRcM9eV4OZQDCvCvfgDd0QwOR4zgh2eAaPdffnBpL8KgpkHyNqZL47497cZRLqrQv4W+vPayTR2rDrLaQhy0T8sLsjs/KAlVdQXxWCWuQzFJipj4++18G/0MNfI3MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614095; c=relaxed/simple;
	bh=XtZ9/3sqSdv/wvTMhbDHrust9SccAmj5ODJlzW9DlUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9XDouyCfy105UdT+eM/nQTvWeFqYXAxbqQKSnwNol+N3OZA1kx+OHwWEayOVuun4oX8jiQFiWYKcaJ/YBH/ej4b810NoiN2SHoOXOeWaME2ETX6UplxN6DkUN1s3jKiADtak6/dvaaQh2XO1vbVMUA9hLkvGnEU2J7DNzrWoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmeS2QYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2985C4CEF1;
	Wed, 28 Jan 2026 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614095;
	bh=XtZ9/3sqSdv/wvTMhbDHrust9SccAmj5ODJlzW9DlUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmeS2QYd09xiFCevUaxNWTxJjityW593g5SIjOfAcXOSsLuzYKOulv6LYjmu7HvWb
	 Aj5rRBSTba4FRFrTaOZC3ktZ31Z2La66R+6zoO0x54oS/5tDQVi5SPR1khBFmrqnDX
	 TNJnxibQu9TDPaOoAVIoZd7sFw5Evh1BhyvF3MCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sheetal <sheetal@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 033/254] dmaengine: tegra-adma: Fix use-after-free
Date: Wed, 28 Jan 2026 16:20:09 +0100
Message-ID: <20260128145345.893658335@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212010-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[sheetal.nvidia.com:server fail,vkoul.kernel.org:server fail];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7F57A3DD5
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheetal <sheetal@nvidia.com>

[ Upstream commit 2efd07a7c36949e6fa36a69183df24d368bf9e96 ]

A use-after-free bug exists in the Tegra ADMA driver when audio streams
are terminated, particularly during XRUN conditions. The issue occurs
when the DMA buffer is freed by tegra_adma_terminate_all() before the
vchan completion tasklet finishes accessing it.

The race condition follows this sequence:

  1. DMA transfer completes, triggering an interrupt that schedules the
     completion tasklet (tasklet has not executed yet)
  2. Audio playback stops, calling tegra_adma_terminate_all() which
     frees the DMA buffer memory via kfree()
  3. The scheduled tasklet finally executes, calling vchan_complete()
     which attempts to access the already-freed memory

Since tasklets can execute at any time after being scheduled, there is
no guarantee that the buffer will remain valid when vchan_complete()
runs.

Fix this by properly synchronizing the virtual channel completion:
 - Calling vchan_terminate_vdesc() in tegra_adma_stop() to mark the
   descriptors as terminated instead of freeing the descriptor.
 - Add the callback tegra_adma_synchronize() that calls
   vchan_synchronize() which kills any pending tasklets and frees any
   terminated descriptors.

Crash logs:
[  337.427523] BUG: KASAN: use-after-free in vchan_complete+0x124/0x3b0
[  337.427544] Read of size 8 at addr ffff000132055428 by task swapper/0/0

[  337.427562] Call trace:
[  337.427564]  dump_backtrace+0x0/0x320
[  337.427571]  show_stack+0x20/0x30
[  337.427575]  dump_stack_lvl+0x68/0x84
[  337.427584]  print_address_description.constprop.0+0x74/0x2b8
[  337.427590]  kasan_report+0x1f4/0x210
[  337.427598]  __asan_load8+0xa0/0xd0
[  337.427603]  vchan_complete+0x124/0x3b0
[  337.427609]  tasklet_action_common.constprop.0+0x190/0x1d0
[  337.427617]  tasklet_action+0x30/0x40
[  337.427623]  __do_softirq+0x1a0/0x5c4
[  337.427628]  irq_exit+0x110/0x140
[  337.427633]  handle_domain_irq+0xa4/0xe0
[  337.427640]  gic_handle_irq+0x64/0x160
[  337.427644]  call_on_irq_stack+0x20/0x4c
[  337.427649]  do_interrupt_handler+0x7c/0x90
[  337.427654]  el1_interrupt+0x30/0x80
[  337.427659]  el1h_64_irq_handler+0x18/0x30
[  337.427663]  el1h_64_irq+0x7c/0x80
[  337.427667]  cpuidle_enter_state+0xe4/0x540
[  337.427674]  cpuidle_enter+0x54/0x80
[  337.427679]  do_idle+0x2e0/0x380
[  337.427685]  cpu_startup_entry+0x2c/0x70
[  337.427690]  rest_init+0x114/0x130
[  337.427695]  arch_call_rest_init+0x18/0x24
[  337.427702]  start_kernel+0x380/0x3b4
[  337.427706]  __primary_switched+0xc0/0xc8

Fixes: f46b195799b5 ("dmaengine: tegra-adma: Add support for Tegra210 ADMA")
Signed-off-by: Sheetal <sheetal@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251110142445.3842036-1-sheetal@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/tegra210-adma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index e557bada15107..37848d558ae49 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -342,10 +342,17 @@ static void tegra_adma_stop(struct tegra_adma_chan *tdc)
 		return;
 	}
 
-	kfree(tdc->desc);
+	vchan_terminate_vdesc(&tdc->desc->vd);
 	tdc->desc = NULL;
 }
 
+static void tegra_adma_synchronize(struct dma_chan *dc)
+{
+	struct tegra_adma_chan *tdc = to_tegra_adma_chan(dc);
+
+	vchan_synchronize(&tdc->vc);
+}
+
 static void tegra_adma_start(struct tegra_adma_chan *tdc)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&tdc->vc);
@@ -909,6 +916,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_config = tegra_adma_slave_config;
 	tdma->dma_dev.device_tx_status = tegra_adma_tx_status;
 	tdma->dma_dev.device_terminate_all = tegra_adma_terminate_all;
+	tdma->dma_dev.device_synchronize = tegra_adma_synchronize;
 	tdma->dma_dev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-- 
2.51.0




