Return-Path: <stable+bounces-105660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B675F9FB118
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE37016223D
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC91B3931;
	Mon, 23 Dec 2024 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qv07NtwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25121B21BD;
	Mon, 23 Dec 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969701; cv=none; b=MGL8qznfVugXcapasKInEqNSSJIjCtox4slLGLINf87JQczQsStBxzkdfjfeX9Wi3RtRdJe6DWgPPPkNevxVAaGcsUrI8DtCG9KjDD+sYyISV9CVerVbhNEhpJRpnTPcNxsI1QZadRI2OWc9JdOiG3tEVkALQV5+bKrUNz7VzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969701; c=relaxed/simple;
	bh=Z1lWGHXNFGadE22k3t0Iyj2iq852xu8KNp3x44/pWOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6d+jlby2qbUgSpEeYrOc3Dw0QxG35v5mZTLeclQJiXJF+i+9OoKXTGMAizcAI+Qq/WxQJVa/8vulSfTNUyYPNoNMa+EDZvmqWhgDo4aXP7qXUhSVIGR7MAwVdKzzzQfKfDaLRzj7/kfwuNNfSc6XGdajXmgJUT9kGsnf1srPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qv07NtwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF51C4CED4;
	Mon, 23 Dec 2024 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969700;
	bh=Z1lWGHXNFGadE22k3t0Iyj2iq852xu8KNp3x44/pWOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qv07NtwDeO6RRncVVEUI6VHu3J64ajcikRop8lRlIdM0uNFlq8QmFkXZXgYm1D8oS
	 R06iHWR0jv4Uid8I5Ea6TnrrDf+rjJfFIJIZQtBceNwRC05SN7ZqwFW6fKZ/in3jw+
	 WjSff/lSiXZexiulpGvnChKvPI8chjcPWCdqLtIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Ni <fan.ni@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/160] cxl/pci: Fix potential bogus return value upon successful probing
Date: Mon, 23 Dec 2024 16:57:20 +0100
Message-ID: <20241223155409.788180368@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit da4d8c83358163df9a4addaeba0ef8bcb03b22e8 ]

If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
returning that value, instead of zero.

Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/20241115170032.108445-1-dave@stgolabs.net
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..6e553b5752b1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -942,8 +942,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_pci_ras_unmask(pdev);
-	if (rc)
+	if (cxl_pci_ras_unmask(pdev))
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
 	pci_save_state(pdev);
-- 
2.39.5




