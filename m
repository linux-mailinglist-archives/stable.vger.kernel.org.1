Return-Path: <stable+bounces-206426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F402D072DC
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 05:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD29F3040F3F
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 04:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED051DA628;
	Fri,  9 Jan 2026 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="UhljJ8fl"
X-Original-To: stable@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E719309C;
	Fri,  9 Jan 2026 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767934779; cv=none; b=DpvKtUy4PHWcZPsHaO7c1vSS4Ik5kMDvWF6pJ+VAyiUQxYpKr6B6tgjA3axKog/u58oQ39SAfdKDrPjN1PB9H+XTRZKht9FqPWgpKBoD43GYDVlHCbSyPEIZtqiyyK2kTbuDD/lT4wvpWnrC+OieRM8v1S4vxr8sCkOggwkiEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767934779; c=relaxed/simple;
	bh=TJOb7KEcOt+3t1rVfUqPdvOHd4fNrR1Y+D/CiqkkKyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=deNCoYmgIZ6ft7qWZhyfKWWOqEgLnpSl+u3YyGzFjzzp7rVx+FotsygcQK22mfI+HUJarHHSZJjSwyMkotiBGzYWIo+weFIWii44aZHwqZ6vcjtMJImA46gYJ/4oIdE2RfspV7wrg8U8sgSXtm0bPcKhU7wCdPfNCkTJWhY4QR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=UhljJ8fl; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 300925f8f;
	Fri, 9 Jan 2026 12:54:12 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: xhci: Fix memory leak in xhci_disable_slot()
Date: Fri,  9 Jan 2026 04:54:10 +0000
Message-Id: <20260109045410.1532614-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ba11ae37303a1kunm8cf0fa377ade2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx1LVh5PQhlNShlCS00eS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UhljJ8flJiVXlbk2uSPPed2pUXmWlHoVrBvcwM5HvahUd4pHkp0rj8a8x99JbUIflaR05uZzsENwPGy3DH7R6HuI8A4sZ5D71xCM2FubzLyvK+pqjHahi684A6iLXpGgPKO8nWeC2rbUAEFavIZH9W4mOk3YrH2zG2KN6YUi5Mc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Cs1CY+zAzDKhEhBICahC7weJ16C5vCiADWr9j9neVh4=;
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

The bug was originally detected on v6.13-rc1 using our static analysis
tool, and we have verified that the issue persists in the latest mainline
kernel.

We performed build testing on x86_64 with allyesconfig using GCC=11.4.0.
Since triggering these error paths in xhci_disable_slot() requires specific
hardware conditions or abnormal state, we were unable to construct a test
case to reliably trigger these specific error paths at runtime.

Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
CC: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v3:
- Update the commit message to reflect that the analysis applies to the mainline kernel.

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


