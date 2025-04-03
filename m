Return-Path: <stable+bounces-127946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1717A7AD49
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFB37A3E24
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C662E28BF44;
	Thu,  3 Apr 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qau9bcZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E41254AE3;
	Thu,  3 Apr 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707455; cv=none; b=UxaIoLXw3UMjQBr4N+6K16cB3z8gNc6bs7zI7n7hbO4zMOrZB6oxI2KlcwlQFoGi0FioYKrzMsCXWRyzeMEw0iqa7p3t5cWy1lina9nAvM2mqRU3hK2J1lix4tpzpRVE5wxGANBzbt9L5hZ5hdkVb2KEkPtUDOfD9gUZURTn67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707455; c=relaxed/simple;
	bh=f5YKTnamBjEsR/fBbDUCvgiVZj2WSeGqvwF5XaWCWx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQAG18oAH6NB/PNPcqH05GUj6Mxh8Qo9q0jCruWpCOLMJByzVbLSD55tCupnfureS0xAILjcKXkBc8hyfLD2fzeEhxUtNim8dwBcUXgQdk2w7RW2C7ITvnV4AM810TLsIcjJ68XpIHzvbKoqQEvycHEpt/BxHS82kcC0rxGsnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qau9bcZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6FCC4CEEB;
	Thu,  3 Apr 2025 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707455;
	bh=f5YKTnamBjEsR/fBbDUCvgiVZj2WSeGqvwF5XaWCWx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qau9bcZR8BsCaxCAoLshbVEAr6ZmV1MvLbbodiDPw5MYndu/By6Zso/38roLiZP1B
	 z7nlWiJQ0g4EPMZQMTfzCOxII2vixYzGlCUkylVoH3MW/sL/q/F+Y82sMNyxCU5Wb2
	 DuMOTDGVH+Y57Eo8QsADAkCQMNBTkNWqkhusDDALQjhb8ujO0ZJ1eTPKSeBIh6nDhi
	 bwhYTpLZDiEkIqh33xiOVgL5mhD4CP1D3S/5EiravAB1Jy7KfZVLeBjhE54ZgcTaQ1
	 4S87mjE/Zg94iIOa9FW68VpwnCsadsNpOFjRoZJFuf19p5IxHKQhjzAYbq8avqyw/C
	 YlF7vIpLn7XTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/14] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:10:29 -0400
Message-Id: <20250403191036.2678799-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Daniel Kral <d.kral@proxmox.com>

[ Upstream commit 885251dc35767b1c992f6909532ca366c830814a ]

Add support for Marvell Technology Group Ltd. 88SE9215 SATA 6 Gb/s
controller, which is e.g. used in the DAWICONTROL DC-614e RAID bus
controller and was not automatically recognized before.

Tested with a DAWICONTROL DC-614e RAID bus controller.

Signed-off-by: Daniel Kral <d.kral@proxmox.com>
Link: https://lore.kernel.org/r/20250304092030.37108-1-d.kral@proxmox.com
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2d2a070c1efcb..3c8fa08f5d970 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -558,6 +558,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
-- 
2.39.5


