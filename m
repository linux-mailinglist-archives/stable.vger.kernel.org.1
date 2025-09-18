Return-Path: <stable+bounces-169112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C857B2383B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427C83AEBC2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650D27703A;
	Tue, 12 Aug 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ROCQJVjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF83D994;
	Tue, 12 Aug 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026420; cv=none; b=Z/MAxAcaBxLjOgRGpua4TgL1HlRkEvacKQ8pHbvyB0QNWZrVSRvYPPIlu7wTP5USqXF1W1gsHXLSJtyHwq59hntal1he2J/+8LFnrxqvjgF5EjTxzWjT4LZ1yJ+/dv5UyiUPs0DL5ow4ZHkUQdpC64qDUsG7snI+xMbVtXFrecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026420; c=relaxed/simple;
	bh=KBTmPLIuJ7dY8/PViloqb0Xp1YE4vZLlZXmqrz3y8Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt7ukkrFTW/AJJHWu3RPfA/mK4cWyFpSZRK1d8IzaBGI1TQ1KWVYOWS6XcYegckGVx7o/YXDOpcMf5i7NivK+dmnTzX2bIiV4dr2Dx4qBG4gW7YlljWWJATmr8V3BvXQBlTkhWW/ncCK1LvsJTBUrig/IOzx8zUBbxy3QggzZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ROCQJVjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C62C4CEF0;
	Tue, 12 Aug 2025 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026418;
	bh=KBTmPLIuJ7dY8/PViloqb0Xp1YE4vZLlZXmqrz3y8Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROCQJVjY4PLzNuPemxf3PpEMY3JlVnxPP6qYgz0sx5K5tKNEjzHwjZ2mWv5PwtExF
	 pqKKir+mTUMsOFeZzTGjHtLkNyDz7Y00FnMUF2+QhOcOO60IiFqTdHjpniS3Y/3zAn
	 Ct6p8W9GFZ9ELm9G+hovqgBLC0RjCtYDNTAWTGbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 298/480] PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute
Date: Tue, 12 Aug 2025 19:48:26 +0200
Message-ID: <20250812174409.721246546@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <mani@kernel.org>

[ Upstream commit 61ae7f8694fb4b57a8c02a1a8d2b601806afc999 ]

__iomem attribute is supposed to be used only with variables holding the
MMIO pointer. But here, 'mw_addr' variable is just holding a 'void *'
returned by pci_epf_alloc_space(). So annotating it with __iomem is clearly
wrong. Hence, drop the attribute.

This also fixes the below sparse warning:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    expected void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:524:17:    got void *
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21: warning: incorrect type in assignment (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    expected unsigned int [usertype] *epf_db
  drivers/pci/endpoint/functions/pci-epf-vntb.c:530:21:    got void [noderef] __iomem *mw_addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    expected void *addr
  drivers/pci/endpoint/functions/pci-epf-vntb.c:542:38:    got void [noderef] __iomem *mw_addr

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250709125022.22524-1-mani@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3cddfdd04029..62d09a528e68 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -530,7 +530,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	struct device *dev = &ntb->epf->dev;
 	int ret;
 	struct pci_epf_bar *epf_bar;
-	void __iomem *mw_addr;
+	void *mw_addr;
 	enum pci_barno barno;
 	size_t size = sizeof(u32) * ntb->db_count;
 
-- 
2.39.5




