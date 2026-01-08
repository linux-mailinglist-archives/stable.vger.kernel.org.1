Return-Path: <stable+bounces-206356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3CD03BC3
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61DDE301645B
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B53FB6A3;
	Thu,  8 Jan 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="KgKpB/Pf"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978BE38B64A;
	Thu,  8 Jan 2026 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881513; cv=none; b=kr1fYf1rJ+mdBzTzcMFWKQg/fk7ZBfrfRWNyDPxknOj6k0l+QVE81eVbi66PBDzdkGYi0sB1CjgnbkjdsrOUgW7MbXeA84KquMGZcGESAlADFLzV/s+cH6wqdlFyUdQay1wuYANOgnTFLx4gwYPlHqNAuOZEjj4WbaaAoWyE1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881513; c=relaxed/simple;
	bh=63BLbX4Plq2/EoFvz8zb+tWo03NKo44kWXDptCA17gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WUD+HeCqUMpbCIGB00dKGgCbV0Zdu2dS6Kqd5fW3+oIYcd+L2ZcPoiwYH8DWCPhJIn4CVZ6/rVHAbI3R57Ssyjt5vpTrNE7bEPPCKsnFBEYHYRVKJtIwKH4Ob2x7VOBS8VsPEyvB2Ih5C47rhE1AvektYaOX9rKSAkOXIaNXGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=KgKpB/Pf; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ff7b45d9;
	Thu, 8 Jan 2026 22:11:43 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: xhci: Fix memory leak in xhci_disable_slot()
Date: Thu,  8 Jan 2026 14:11:08 +0000
Message-Id: <20260108141108.993684-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b9df2f1a703a1kunm81227c6d52c34
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQk1PVk9KShkZSkoYGUJNT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=KgKpB/Pf7S9fd9+WOIE4BnsgJSgYzEsE8a5PRbMyuV+rYoMLfO/DbUhoYxYRyaxGl044t24ouS06eE90sOJG9HPg3w3FUc0ZouxWWJpw7+e6+QotVKzaamSFuGeXwhlYE1Hzt0+8r4yHrmI3l991RSva+ghEdaYj6tVjoq+lSww=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ixRZVjyZrDEhNBUX5yAM8i5b7jaDl0sh3mEew4zg5b4=;
	h=date:mime-version:subject:message-id:from;

xhci_alloc_command() allocates a command structure and, when the
second argument is true, also allocates a completion structure.
Currently, the error handling path in xhci_disable_slot() only frees
the command structure using kfree(), causing the completion structure
to leak.

Use xhci_free_command() instead of kfree(). xhci_free_command() correctly
frees both the command structure and the associated completion structure.
Since the command structure is allocated with zero-initialization,
command->in_ctx is NULL and will not be erroneously freed by
xhci_free_command().

This bug was found using an experimental static analysis tool we are
developing. The tool is based on the LLVM framework and is specifically
designed to detect memory management issues. It is currently under
active development and not yet publicly available, but we plan to
open-source it after our research is published.

The analysis was performed on Linux kernel v6.13-rc1.

We performed build testing on x86_64 with allyesconfig using GCC=11.4.0.
Since triggering these error paths in xhci_disable_slot() requires specific
hardware conditions or abnormal state, we were unable to construct a test
case to reliably trigger these specific error paths at runtime.

Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
CC: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Add detailed information required by researcher guidelines.
- Clarify the safety of using xhci_free_command() in this context.
- Correct the Fixes tag to point to the commit that introduced this issue.

 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 02c9bfe21ae2..f0beed054954 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4137,7 +4137,7 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	if (state == 0xffffffff || (xhci->xhc_state & XHCI_STATE_DYING) ||
 			(xhci->xhc_state & XHCI_STATE_HALTED)) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
-		kfree(command);
+		xhci_free_command(xhci, command);
 		return -ENODEV;
 	}
 
@@ -4145,7 +4145,7 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 				slot_id);
 	if (ret) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
-		kfree(command);
+		xhci_free_command(xhci, command);
 		return ret;
 	}
 	xhci_ring_cmd_db(xhci);
-- 
2.34.1


