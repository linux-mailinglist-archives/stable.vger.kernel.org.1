Return-Path: <stable+bounces-255791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBW/GByoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:39:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AB75F943A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D202C3234C9B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDB2D9787;
	Thu, 28 May 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQ5FLVo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1302E7379;
	Thu, 28 May 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999893; cv=none; b=EAyDAEqvJrUeBS3phgK5micB0SIfUgcXKIpgJZXPL3yvzx3Ujn2ZsRmDNT3HKkCBJhk7ewjOZjnQ7xNzzxFsBwa2n0RipVEV2SHZQ9XlJKBF6UKz1/5oeB4ctSuJfiywS0HRpcK1/uVBPofAMT+nstZjEF7f4Tn5yUn8pwj1b7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999893; c=relaxed/simple;
	bh=XG0nYRwncicTSQGNLlzdXqMyBZQvR+kTxk4qRHN3rGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCV9ysjC9QLRh0JRJdjnOTPFaawn1JyfBJurgVPHpU5H3/bkGHShMYw684vP1VQcU05I44KW/u90gUrUUeDp5UyHfxggGG7jTTpanIqBERubmL9HSb+A7nNvW5SsYlfsQ6pnfPlMdTv2bQIUC12pkCaUHRfstoLYt+hRgq+pRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQ5FLVo3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812DD1F00A3E;
	Thu, 28 May 2026 20:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999892;
	bh=wyd561eXmvrTrzdzWkt2x3Zyybg4Re+IJkB6Q/Y7+8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQ5FLVo39coMYlw4hsteTAEvfmrWGU5FrgDdFEQLHP0zxR49FzXbcPY23VAXqCdYF
	 34KoekedfclGCdAz162wztFhWyQ6qvDpJ5OzDJYvU08lD7JlkuoErTShPT/4ZhImO8
	 ybqnHdzpWEH++xWVjG2J7etx2mduNc9BovQUD0Y8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 227/377] nvme-pci: fix use-after-free in nvme_free_host_mem()
Date: Thu, 28 May 2026 21:47:45 +0200
Message-ID: <20260528194644.965238381@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255791-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,canonical.com:email]
X-Rspamd-Queue-Id: D7AB75F943A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

[ Upstream commit b35a13036755c5803168a7cb93bc66035c3e65b8 ]

nvme_free_host_mem() frees dev->hmb_sgt via dma_free_noncontiguous()
but never clears the pointer afterward.  This leads to a use-after-free
if nvme_free_host_mem() is called twice in the same error path.

This can happen during nvme_probe() when nvme_setup_host_mem() succeeds
in allocating the HMB (setting dev->hmb_sgt) but nvme_set_host_mem()
fails with an I/O error:

  nvme_setup_host_mem()
    nvme_alloc_host_mem_single()   -> sets dev->hmb_sgt
    nvme_set_host_mem()            -> fails with -EIO
    nvme_free_host_mem()           -> frees hmb_sgt, but does NOT NULL it
    return error

  nvme_probe() error path:
    nvme_free_host_mem()           -> dev->hmb_sgt is stale, use-after-free

The second call dereferences the freed sgt, causing a NULL pointer
dereference in iommu_dma_free_noncontiguous() when it accesses
sgt->sgl->dma_address (the backing memory has been freed and zeroed).

This is reproducible on Thunderbolt-attached NVMe devices (e.g., OWC
Envoy Express behind a Dell WD22TB4 dock) where the device intermittently
returns I/O errors during HMB setup due to PCIe link instability.

 BUG: kernel NULL pointer dereference, address: 0000000000000010
 RIP: 0010:iommu_dma_free_noncontiguous+0x22/0x80
 Call Trace:
  <TASK>
  dma_free_noncontiguous+0x3b/0x130
  nvme_free_host_mem+0x30/0xf0 [nvme]
  nvme_probe.cold+0xcc/0x275 [nvme]
  local_pci_probe+0x43/0xa0
  pci_device_probe+0xeea/0x290
  really_probe+0xf9/0x3b0
  __driver_probe_device+0x8b/0x170
  driver_probe_device+0x24/0xd0
  __driver_attach_async_helper+0x6b/0x110
  async_run_entry_fn+0x37/0x170
  process_one_work+0x1ac/0x3d0
  worker_thread+0x1b8/0x360
  kthread+0xf7/0x130
  ret_from_fork+0x2d8/0x3a0
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fix this by setting dev->hmb_sgt to NULL after freeing it, so the
second call takes the multi-descriptor path which safely handles the
already-cleaned-up state.

Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e32242bed67c..5e36a5926fe03 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2320,11 +2320,13 @@ static void nvme_free_host_mem_multi(struct nvme_dev *dev)
 
 static void nvme_free_host_mem(struct nvme_dev *dev)
 {
-	if (dev->hmb_sgt)
+	if (dev->hmb_sgt) {
 		dma_free_noncontiguous(dev->dev, dev->host_mem_size,
 				dev->hmb_sgt, DMA_BIDIRECTIONAL);
-	else
+		dev->hmb_sgt = NULL;
+	} else {
 		nvme_free_host_mem_multi(dev);
+	}
 
 	dma_free_coherent(dev->dev, dev->host_mem_descs_size,
 			dev->host_mem_descs, dev->host_mem_descs_dma);
-- 
2.53.0




