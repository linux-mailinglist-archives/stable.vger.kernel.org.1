Return-Path: <stable+bounces-159596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF356AF7967
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8130167F33
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F52EAB95;
	Thu,  3 Jul 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsFTj5z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C12EA49E;
	Thu,  3 Jul 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554730; cv=none; b=fivZMNELym/rcJ/cBER2Qr96sEJdZXnHV4AZOqnubzml+uhdW+08pNI8cGWC8T5UYRJYB1lHPHNCjNPpHHumw0cFVkPqQB7NZi4S+NtM+XEiq5v8qvYAFyJ3lDQ97BVmWSZiP4teS2V1v+KDxfViX4AtfpWgW0RCUS/lqxc7eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554730; c=relaxed/simple;
	bh=CxnY0dmZaIwRaRQZ/EYl3OFkasYW1GNG60sBBgvVX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShAXVGDVa+HofmwQolB5RsdWX7iyHMtU+CXVZzKHQDgD8pp1HIAKLwhejm/MYaKyNG1EmByjdO+P3c1zqCUkmSEVh8rZw5WkjM/x8MDNSHdwg7NHbPznmtcW5WeMJmqUyu/+SeSwKCvyVJbw0U1yzCM02pfPbXbGyrOBmTWw6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsFTj5z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB09C4CEE3;
	Thu,  3 Jul 2025 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554730;
	bh=CxnY0dmZaIwRaRQZ/EYl3OFkasYW1GNG60sBBgvVX10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsFTj5z5riPvU6A6za2vGbqmTXZNpQT8+Z76D4EJUNN9krYrH6KpXEabGoCV/gmom
	 2Up3a6ASiTUv8op0oIbWBnAxPVbeavDb4Yg89T04G2eBMBHfBcaPFMSv9KGmljdgMt
	 JBG4PT9D0r921kVprhLv99Z+KS9nokMJAgAtnKAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Janne Grunau <j@jannau.net>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 030/263] PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
Date: Thu,  3 Jul 2025 16:39:10 +0200
Message-ID: <20250703144005.506411511@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 7fa9fbf39116b061f8a41cd84f1884c545f322c4 ]

In the success path, we hang onto a reference to the node, so make sure
to grab one. The caller iterator puts our borrowed reference when we
return.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Link: https://patch.msgid.link/20250401091713.2765724-9-maz@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 32f57b8a6ecbd..8f7fc9161760c 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -584,6 +584,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
+	/* In the success path, we keep a reference to np around */
+	of_node_get(np);
+
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 
-- 
2.39.5




