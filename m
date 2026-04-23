Return-Path: <stable+bounces-240516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAPZN41D6mnqxQIAu9opvQ
	(envelope-from <stable+bounces-240516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:06:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB0E454A3E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00890303E8E6
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BFF36E488;
	Thu, 23 Apr 2026 16:06:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9B36E47A;
	Thu, 23 Apr 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960389; cv=none; b=L13tHw5JgFs+H7TiPxPR8LEsyWNZkoLo8AW9I8Ph3o6m5RMKfu5er6P6Rzhh0o1bZ8tsFtBBOWXYrkYSTMshbkQO0WnDL6RK33ImoOPvRPEDsh8yCoz37FskqAlXRYOGDPLwCQ74fO4PwDH/vKiCGaQI7JxZWis13ckAFrKnSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960389; c=relaxed/simple;
	bh=1JrHli4SssiBkayVs215LdfbzOlofYgSJbx/Op1ZIIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt415/c7wpGemLguDOsoe4bZ4o0jQGT/3RV5w524nfOsKQlAqI9838zBgduoJ9TnVzXOz/sOSOA6sfAQJsMJEUnj/3eWo1rLVEPg01KbAA4i4W6OAGcMw18fDGST2ZxM+74p+vGVgUX863xeyA8sz5TEq92CFhPfdttTjibU3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com; spf=pass smtp.mailfrom=autochips.com; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=autochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=autochips.com
Received: from H20F120008.autochips.inc (unknown [223.244.89.246])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3be7c0b5a;
	Fri, 24 Apr 2026 00:06:12 +0800 (GMT+08:00)
From: Yongchao Wu <yongchao.wu@autochips.com>
To: peter.chen@kernel.org,
	pawell@cadence.com
Cc: rogerq@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	Yongchao Wu <yongchao.wu@autochips.com>
Subject: [PATCH] usb: cdns3: gadget: fix request skipping after clearing halt
Date: Fri, 24 Apr 2026 00:06:01 +0800
Message-ID: <20260423160601.2949010-1-yongchao.wu@autochips.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dbb177f6f03ackunm83a281af13c76d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU9PVk5OSUoaQx1IGUNMTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSU9PVUNCVUlPTVlXWRYaDxIVHRRZQVlPS0hVSk
	tJT09PSFVKS0tVSkJLS1kG
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[autochips.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240516-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[yongchao.wu@autochips.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[autochips.com:mid,autochips.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFB0E454A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
causes the DMA engine to reposition its internal pointer to the next
Transfer Descriptor (TD) if it was already processing one.

This issue is consistently observed during the ADB identification
process on macOS hosts, where the host issues a Clear_Halt. Although
commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before reset
endpoint") attempted to avoid DMA advance by toggling the cycle bit,
trace logs show that on certain hosts like macOS, the DMA pointer
(EP_TRADDR) still shifts after EPRST:

  cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
  cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <-- Should be f9c04000
  cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384

As shown above, the DMA pointer jumped to index 3 (offset 0x30), causing
the controller to skip the initial TRBs of the request. This leads to
data misalignment and ADB protocol hangs on macOS.

Fix this by manually restoring the EP_TRADDR register to the starting
physical address of the current request after the EPRST operation is
complete.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Cc: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index d59a60a16ec77..96653c7d18f20 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2814,9 +2814,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
 
 	if (request) {
-		if (trb)
+		if (trb) {
 			*trb = trb_tmp;
 
+			/*
+			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
+			 * Manually reset EP_TRADDR to the current TRB to prevent
+			 * the hardware from skipping the interrupted request.
+			 */
+			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
+						priv_req->start_trb * TRB_SIZE),
+						&priv_dev->regs->ep_traddr);
+		}
+
 		cdns3_rearm_transfer(priv_ep, 1);
 	}
 

base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
-- 
2.43.0


