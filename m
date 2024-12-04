Return-Path: <stable+bounces-98492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA469E460F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB00B87F3F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADBC1F4973;
	Wed,  4 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjC4avRH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457C1F496D;
	Wed,  4 Dec 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332332; cv=none; b=NN06XLbj5vlYjx6YBHMHcLZB2pleQjr09Vn/Dh1iQtTKyxm7dzDnegMI8zX/TUyZnT4fajLiLCiyd63zMd9aXVqCdmMYK4UOit2jTLSWRbcjgmfMP8AcSTm5C1F1bg+gsJY/ufUIAEX+5HdADq15nUJy0Bj/v5ivNGX0coQo0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332332; c=relaxed/simple;
	bh=LwKBW2PNt4O54PgpeomZsFObp2g62nnnrZO2ev9ZYzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nweqhL1rO6foP4jQax7vh4sYkjr/P83DHyskJDdw5wN7fffzNDtf4a8zdCkT75dokt8empkQfUFlfB2AxCEIiEbfwfTvA6ER5fWD2resw4W9qy54v7areS7usKcQInDGDRit1JgVZzNpc77PolRsOn8jraWqqgudSg1+FJgxLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjC4avRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4B1C4CECD;
	Wed,  4 Dec 2024 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332332;
	bh=LwKBW2PNt4O54PgpeomZsFObp2g62nnnrZO2ev9ZYzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjC4avRHun/qNm6z1V7pw+ZfMVRzcOH706sVucJxDcGglsR76C3I45zEt90B8OD3i
	 WZeRUvOI1ssYJ1awvXzCFA1+Y5q/ENuwsgoscxjGQyNgl/ir20xmbLMbZTOzc/sBZw
	 EAbfSCQuw8ZuDzxl8QjO3uUgXuSdDUHgU8u/LpMec3xPzNUrkqCGTWDmNzJiakK7j+
	 XowoujloN4af8qniEZDhReaZRoQHHduQUIhWsaRoD4QE1IqpoiD/3gapVTiH0L41lj
	 /YuTN4eIqiAzdhdFKTT/K84vrzFTfNZqCi3q7YMGTcxSW5ayBn1wqW9jmwwdejRhfx
	 5JDTKBf0wzehg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nirmal Patel <nirmal.patel@linux.ntel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 05/13] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
Date: Wed,  4 Dec 2024 11:00:30 -0500
Message-ID: <20241204160044.2216380-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Nirmal Patel <nirmal.patel@linux.ntel.com>

[ Upstream commit b727484cace4be22be9321cc0bc9487648ba447b ]

Add support for this VMD device which supports the bus restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Link: https://lore.kernel.org/r/20241011175657.249948-1-nirmal.patel@linux.intel.com
Signed-off-by: Nirmal Patel <nirmal.patel@linux.ntel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011f..4429a3ca1de17 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1111,6 +1111,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb60b),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb06f),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.43.0


