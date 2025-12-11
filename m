Return-Path: <stable+bounces-200797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82975CB5E51
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 13:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 999BF3001C04
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 12:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589230FF20;
	Thu, 11 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O0MKPHDg"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B430FC37
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456690; cv=none; b=ocduMABl7blLJn2F1OH6OIk0e1lFGxkcrjhyQ00JaOXkuDswAfAjqm+yTtTqe3m5+kH78LrdbbCw3U1N9+Os7ioaQtWdK+v7sHmCOZLcXU+vRh15xGptBwsTcZwtLFgZ52dISVHqu/nrjU6g9+G2m6VWbXqhSnGAUMKchlww7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456690; c=relaxed/simple;
	bh=TwavrvwCpUkrQKPWik/OjaMSy6o5WMohj1hJc6u3FYE=;
	h=Cc:Message-Id:Mime-Version:Content-Type:To:Subject:Date:From; b=lsNUp9gQ+1crMBkAiAjW4yesTLDgBxgSotdRgzCAc1/F5E9OjS2veAOh8gt5R9e/3Lu4tTBJIY3rVCpX8WuS/rlXp5LGqXfHzkls4JXi6QL2JRMDnpQ9jAp4mMH40DUfhXaGyzcft3VMFrPApd1Dr0QMHCK3sEXWE+mr5gxBDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O0MKPHDg; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765456679; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=U0kmftBYFXHIoReqJuzrYqBPPEvLTkdwDn62vqNYTec=;
 b=O0MKPHDgObtIrkuotASmpgmmTkstStG9Qg0ZEc+Jztsp72bSO3q+NDlbJrTkTgpSNzqSEo
 0meBQFstLyd5fVuw+cKvIw1L3+PITyPDqWGBakuB8osu31ebEeHBlxgPew6H9ld1wok6/4
 9IY3sj89F4ixAjHuDbXSgO6kWiGWMtLvTA2iuJANzWP2kgWu+UljWlQL2QKxrOo6zFcw2r
 MR0DKJ3jAYQcfLOFw3SJR4yiRwex9tvyOXp3Mm3W3BQOq4uNl4K3ZneXk1hV90zqHB8HP8
 kIg9uetATt1rHgTXETBO71qHvjfTcqHU8ceXw1tvg/GU3LgqXCHkotSEiXGSTA==
Cc: <guojinhui.liam@bytedance.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Message-Id: <20251211123635.2215-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2693abb25+f15074+vger.kernel.org+guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
To: <bhelgaas@google.com>, <kbusch@kernel.org>, <dave.jiang@intel.com>, 
	<dan.j.williams@intel.com>
Subject: [PATCH] PCI: Remove redundant pci_dev_unlock() in pci_slot_trylock()
Date: Thu, 11 Dec 2025 20:36:35 +0800
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock()
in pci_slot_trylock(), but it leaves a redundant pci_dev_unlock() when
pci_bus_trylock() fails.

Remove the redundant bridge-device pci_dev_unlock() in pci_slot_trylock(),
since that lock is no longer taken there.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..75a98819db6f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5347,7 +5347,6 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
 				goto unlock;
 			}
 		} else if (!pci_dev_trylock(dev))
-- 
2.20.1

