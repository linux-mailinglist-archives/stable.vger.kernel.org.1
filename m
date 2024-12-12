Return-Path: <stable+bounces-102023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641209EF08B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E375189B69E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94892235C2C;
	Thu, 12 Dec 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NG2yKMGY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037B223E81;
	Thu, 12 Dec 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019673; cv=none; b=DVudqXfvNDNUZquyqHi6ONJmhcMH2CpUcWd9nHNo+hSYTQk7hVK6lfp7NedB6kylUZIcSPPg2HYqFzC2J75BfTRndsvjo1k/XpuoBpsmg7Jw5Muce7Q2Gb/nLuox4WERRYgZNAL0wgA2subFBLB/wRDmEXo1WVSH+priiilj3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019673; c=relaxed/simple;
	bh=UsGrNSRhRcNU5tUzgr2HzcRJifroJj4KH3lGSb9TCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlBki7/eA0EOWQooaHyAS+qbKhyFrV/83sH04KTZQUTCWB0SSNCK3VcX4Ijhf665vQBzDVnrjCB7XfSrVnoDc72D01219RhsUOLQiOwINVqRQsKULNagGbY2uIZGvtTq6G5dhatDo1uU2qfUTlg5GNEFaUUdFVl+cCj+zauasok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NG2yKMGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4183C4CECE;
	Thu, 12 Dec 2024 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019673;
	bh=UsGrNSRhRcNU5tUzgr2HzcRJifroJj4KH3lGSb9TCVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NG2yKMGYFzNgaBtfwOyBFpWwvjAPZzcnrjx18mrUVKeDGS/mGxSeBW6Jp5miGE2uE
	 geLNIpMbh1mjyiHpZFjDz6GunOBMyTwasg87gIKNpEg5Z6mh9hS1pPJRfZ9YN0Rb73
	 OCbq8rDB4tIRzfB7pIs8OBFvu6XOIsCuHBEXqHvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	weiyufeng <weiyufeng@kylinos.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 269/772] PCI: cpqphp: Use PCI_POSSIBLE_ERROR() to check config reads
Date: Thu, 12 Dec 2024 15:53:34 +0100
Message-ID: <20241212144401.034221163@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: weiyufeng <weiyufeng@kylinos.cn>

[ Upstream commit 87d5403378cccc557af9e02a8a2c8587ad8b7e9a ]

Use PCI_POSSIBLE_ERROR() to check the response we get when we read data
from hardware.  This unifies PCI error response checking and makes error
checks consistent and easier to find.

Link: https://lore.kernel.org/r/20240806065050.28725-1-412574090@163.com
Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: e2226dbc4a49 ("PCI: cpqphp: Fix PCIBIOS_* return value confusion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/cpqphp_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 3b248426a9f42..ae95307e6ece3 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -138,7 +138,7 @@ static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 o
 
 	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
 		return -1;
-	if (vendID == 0xffffffff)
+	if (PCI_POSSIBLE_ERROR(vendID))
 		return -1;
 	return pci_bus_read_config_dword(bus, devfn, offset, value);
 }
@@ -253,7 +253,7 @@ static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num
 			*dev_num = tdevice;
 			ctrl->pci_bus->number = tbus;
 			pci_bus_read_config_dword(ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
-			if (!nobridge || (work == 0xffffffff))
+			if (!nobridge || PCI_POSSIBLE_ERROR(work))
 				return 0;
 
 			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
-- 
2.43.0




