Return-Path: <stable+bounces-127933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7412A7AD66
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8F716614A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8F2D1F4C;
	Thu,  3 Apr 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhNoXJEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA625B667;
	Thu,  3 Apr 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707423; cv=none; b=FJbA0UbdQsxOJoFigG+KR8MaUHXInZV7+zoXn91r4AZlKiNVm3qBrkIa1cpc48VSNUmh15SSVC0qCFbEc7nihIvsxdQI4x3bV5lq1DrOvoSCam/1DayXroRCHlM1fnCC/egDmENH+JYzj+WF2/qpYETHDJ04KXTCyfMshfRwkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707423; c=relaxed/simple;
	bh=RUBENIm4M0MvzpfYcHmhKWMqynuLVFxIfTfAb3u7xvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeYsd56JzlLqUQNS8E1GNzG9xH7DgsV7lU98CgLswVii618DAzTyMo3PsM94JFYHbTIr59v8OYZAAGE7XsN4L60tjp5HidyHlxoFdCVUXx4W0rFZo91lY36YYjv5YAJyp0wMKUTcV2gMdI26CBv0DbsZs+S6EckDQu1KG+zgfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhNoXJEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63CDC4CEE8;
	Thu,  3 Apr 2025 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707422;
	bh=RUBENIm4M0MvzpfYcHmhKWMqynuLVFxIfTfAb3u7xvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhNoXJEHFepYetqzadWHBtoZZfEl1PMwXYXNWj7s/zpM4DNPY4EX/C8IjDatDRpOi
	 OddXAo49q3VrjPXluMVDnIxJKZZ/bQqDw2jyAFXINwiuOmcfXF1+3Ld3JnxuEIHT4J
	 4km7mnv+NDbJLFKJnDlWVsZCRVa2BbvEwpPZO3YOiK55w0hfFfdYdIpcDZKc3YujNF
	 Q58rc7AneZJoMdzwl43w3LaLymppCnXjSdUhl/ZSw4pl9FoyYHOC/jmUHOj91iCCIM
	 RMZsn5+CPISxHrSGhbTbilsq/ahH4iKHsNIKFnZt5Dsrn42nX/op+D7+iGnbbEJeA+
	 fItZHS73zywRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/15] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:09:55 -0400
Message-Id: <20250403191002.2678588-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191002.2678588-1-sashal@kernel.org>
References: <20250403191002.2678588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index 04b53bb7a692d..2bb9555663e75 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -591,6 +591,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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


