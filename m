Return-Path: <stable+bounces-232035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEsO7b9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:00:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4836DA2B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F78831314AC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAE423A99;
	Tue, 31 Mar 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8yQqUgt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FF4218AF;
	Tue, 31 Mar 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975707; cv=none; b=NaxjfZo+CSv7VU+heSzL2RPiHRTh42N3fiIr7MiKSDmrXfnFxtlMrlPXCzMzY5zyn70j/gnp3juBEjGSHiMsWiIwYtfewN0mZ1laKKJJRlvHMesQNgbxY80RLR8s7SDNMSz2YuE95Z6xgm4wGyBQdUik6AkFu14uowcos3wBmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975707; c=relaxed/simple;
	bh=eU5dUlagvH6Y+Q/NPbM7xblN7GVCLdhW7imvJ178EVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfH8znhyJbZHpVYXtKHwWLqOiCJ2rNTsmm2NIAAQ3TjRpKjdyciRNbvhiY2X8aMM52R/Y+gmNciR3fvsZadMLuobwDZXC3rX5kSo5IDTpHWCdvk9MAvmTUrO8wd2zoRG+Bi/8p7bpLOj/tTZDmE1NMrhr8R8Vz92P+bQpjzJJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8yQqUgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC843C19423;
	Tue, 31 Mar 2026 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975707;
	bh=eU5dUlagvH6Y+Q/NPbM7xblN7GVCLdhW7imvJ178EVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8yQqUgtSOZ/xZUo0xqM8rVsZtqk8PuYUSIeJ56goLxHRLEH68rAeUDfujf68z7xo
	 iCpRDcbKR5wckrgoGDzE2tF7D5uaUyguq5oMRpa9NJV2niNTsxHYUxIz7T8Y9ot+QP
	 aDGqHoUJ4BKtiPK/tVpS0jtqcWJ4U03V0fUT221c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Potapenko <glider@google.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 055/244] dma: swiotlb: add KMSAN annotations to swiotlb_bounce()
Date: Tue, 31 Mar 2026 18:20:05 +0200
Message-ID: <20260331161743.725894896@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232035-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 93E4836DA2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 6f770b73d0311a5b099277653199bb6421c4fed2 ]

When a device performs DMA to a bounce buffer, KMSAN is unaware of
the write and does not mark the data as initialized.  When
swiotlb_bounce() later copies the bounce buffer back to the original
buffer, memcpy propagates the uninitialized shadow to the original
buffer, causing false positive uninit-value reports.

Fix this by calling kmsan_unpoison_memory() on the bounce buffer
before copying it back in the DMA_FROM_DEVICE path, so that memcpy
naturally propagates initialized shadow to the destination.

Suggested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com/
Fixes: 7ade4f10779c ("dma: kmsan: unpoison DMA mappings")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260315082750.2375581-1-syoshida@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a569..e2445b3af7468 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/kmsan-checks.h>
 #include <linux/iommu-helper.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -903,10 +904,19 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 
 			local_irq_save(flags);
 			page = pfn_to_page(pfn);
-			if (dir == DMA_TO_DEVICE)
+			if (dir == DMA_TO_DEVICE) {
+				/*
+				 * Ideally, kmsan_check_highmem_page()
+				 * could be used here to detect infoleaks,
+				 * but callers may map uninitialized buffers
+				 * that will be written by the device,
+				 * causing false positives.
+				 */
 				memcpy_from_page(vaddr, page, offset, sz);
-			else
+			} else {
+				kmsan_unpoison_memory(vaddr, sz);
 				memcpy_to_page(page, offset, vaddr, sz);
+			}
 			local_irq_restore(flags);
 
 			size -= sz;
@@ -915,8 +925,15 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 			offset = 0;
 		}
 	} else if (dir == DMA_TO_DEVICE) {
+		/*
+		 * Ideally, kmsan_check_memory() could be used here to detect
+		 * infoleaks (uninitialized data being sent to device), but
+		 * callers may map uninitialized buffers that will be written
+		 * by the device, causing false positives.
+		 */
 		memcpy(vaddr, phys_to_virt(orig_addr), size);
 	} else {
+		kmsan_unpoison_memory(vaddr, size);
 		memcpy(phys_to_virt(orig_addr), vaddr, size);
 	}
 }
-- 
2.51.0




