Return-Path: <stable+bounces-213781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIG0Gaxjg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:20:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52BE84F7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5ED7308B01E
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59141B359;
	Wed,  4 Feb 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUklQ1NL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300892D879A;
	Wed,  4 Feb 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217490; cv=none; b=AWyKj5t6FbW1XUlKXornZDGCL5FCGWoask5yfsGeMu+fewKynelUFq83GOyNtMbZ4ewmHknFzffwXEU+k1rQ3vjsqxys+di45XmMbqcRDINaOISYGfBIxAXjrAawS6awFbxWZQ+KoohBGMvG46Lyuqimnxqal8jOXntGcDaur50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217490; c=relaxed/simple;
	bh=B5RCoeEsaNQWy1tDlVz8AwecQwhjjk9ReDDXO6Th+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjB/CZ71MDQSRvva01YBdVU7hEVRM7iHZN9ECSaQ43fiwBSRkbaNoJ0GSWjrbBgGuvcyykf25ykSsIzbticS85ybD/cHvxz2Fxwj1725YeYFiX93mRNyVzSTEgBgqwbR+cHsuAoEnA0QObdrJoJ0shyPmwY4b4orbbFob9mGnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QUklQ1NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF710C4CEF7;
	Wed,  4 Feb 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217490;
	bh=B5RCoeEsaNQWy1tDlVz8AwecQwhjjk9ReDDXO6Th+tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUklQ1NL6BGwfckMyerLIprCNfAiEisfNstKV+WXAul8nECiPBMr09+dj9As46S7D
	 yETA1Oy/o0in8vBzqe5V+OMxcJ0J+cBZhQ+3hDwSOZL178jGhDI2nXXI/xbDjx7dZU
	 cQpSdc8OK1l1PMiCIrM4xehanAp//yXFKqu0EvvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sheetal <sheetal@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/280] dmaengine: tegra-adma: Fix use-after-free
Date: Wed,  4 Feb 2026 15:36:45 +0100
Message-ID: <20260204143910.758947765@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213781-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CF52BE84F7
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 79da93cc77b64..db79e92f5e611 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -341,10 +341,17 @@ static void tegra_adma_stop(struct tegra_adma_chan *tdc)
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
@@ -910,6 +917,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_config = tegra_adma_slave_config;
 	tdma->dma_dev.device_tx_status = tegra_adma_tx_status;
 	tdma->dma_dev.device_terminate_all = tegra_adma_terminate_all;
+	tdma->dma_dev.device_synchronize = tegra_adma_synchronize;
 	tdma->dma_dev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
-- 
2.51.0




