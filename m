Return-Path: <stable+bounces-128744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2F4A7EB43
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B53F1887AFB
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030C277008;
	Mon,  7 Apr 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGvvQTTy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501727605F;
	Mon,  7 Apr 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049849; cv=none; b=D/wEh8D9iW302ErZueavgNnfG1mYpAoj5H6Tg0AUUbAuW8u0F+ggoS6+63uKih7o2ry8Y3hS8GV9fQnoszY0mhYC5LrKdLaYVTQX3FFdfXMlMYe/81ECKohbDBg+ynTxWEuGNuDkPorOPgg9xZiespS+qTuOFp8F0kQ5bx/wv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049849; c=relaxed/simple;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6h5BiKiq9MacedYBbzdnwV4CFZazPe1+RKEy9eY9LWPmkoc1dbkFHFae/2xdX80CsOafDhSBIDS4aFYYPGrc+zY42PLJ1A3nh1oVQ4wMs1+GLK5grHVS3ruvLqw1gmiKB0tjpWfpcrrFgmjGdJyz/Aq1kSuv+WrmBFsowwNCnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGvvQTTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7EFC4CEDD;
	Mon,  7 Apr 2025 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049848;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGvvQTTy7oab/JoHCBA8kVKT/Ufb0Bzal9hz8x+ndFMCbRybQ8WZ/0+3zao4Ot/tR
	 MZdqjDl8yAI9cEPxxJJDWsrPNrc2eTII8da5bf0LabVguazHmqp3xcAyodNKzaJQja
	 Hv83731x/jN9Sde5IR25aUYjBi/DqZZgZaGYEzf5MHqRO2AUT9Ylrpg9pm0ytCg5t6
	 mZc6uws0tB9va12VbsZsXZr6V4lfapvWJ9GSBJ3M0AY6SEKRGPl/OSvDDSN2hQMxzb
	 +TnWd+Xk96S93bq7DGQZt1+Wlp1Y27z+0/QDyFu9CUJjWMep5zOfyuf3UNwBCgA6as
	 CRUGLHpA1nMnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 3/7] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Mon,  7 Apr 2025 14:17:14 -0400
Message-Id: <20250407181718.3184348-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181718.3184348-1-sashal@kernel.org>
References: <20250407181718.3184348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bf8a7ce7e4c7267a6f5f2b2023cfc459b330b25e ]

Add NTB support for new generation of processor.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78d..63ceed89b62ef 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1318,6 +1318,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.39.5


