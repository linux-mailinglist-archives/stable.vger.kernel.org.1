Return-Path: <stable+bounces-127847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E7BA7AC68
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08963178DE0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343BC270ECF;
	Thu,  3 Apr 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6vKPdr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BC257AEC;
	Thu,  3 Apr 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707229; cv=none; b=PfN1RXEfa4EzbSopmFlIPpfTUSd9nsOxZuVqi9emKcv0LujYJfBDwkIFnQypPKPGvcFkDstFq3nhv4VbBW2FJ0xHy4+o5pt7C2LGZZzbFl534bgDtH711fjKc8JA9Tidi+YlmwTFDeE+622x2XVcfYRY8WVFQkdLOdtwVy3WXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707229; c=relaxed/simple;
	bh=xpuDVZlmkyrC9ceX0X/vqHwX01LDAuFrAKMUg4dH9+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HygXIUlv9yVxFMFR7okKrm1NcGf7Jb4zourDBTraa7Vb1cfO2HgcdwT/OqssgT8hzXJcK5LjFOO4r1E01AWsCDl/b6Jw325FVbrqoMdgxcaNfLD9bIuETjsogDKpmpy2K6phi0YmXkHg1zaSF3MTtHZkIhrp354weUOtUMCwbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6vKPdr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E383DC4CEE8;
	Thu,  3 Apr 2025 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707228;
	bh=xpuDVZlmkyrC9ceX0X/vqHwX01LDAuFrAKMUg4dH9+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6vKPdr+b9jeulfkfvG0LlMQ7SyL4/vW97Lf5JCQu6j2BuAp7t/rhl4Ozw8o5BXEu
	 oTlap2Nv9nM3E/rh15r+nV51f7FAp1WSOkRbieAeo8VNcVh1Uu1iMv0qySRr5a6bKf
	 0GXHjopnABv06REsG6kTi5WLlSqfO3wWuRBwApaK3UlWwinaY0fpJ8UPT4TNsm8eTW
	 MqBbjuJZO8zl4f5kYSySVVzvCgGot8j5ubI9OFKLDqYZfJJ1ViCU86HSocJJU3OtYs
	 K0qCQ8uuAbd5QxwkJSKmozOkbtQEjKty5R8FCDU4k9I8772QljBT/rBi9Pua3M/lo2
	 WB3uFa9kSDM5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 29/47] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:05:37 -0400
Message-Id: <20250403190555.2677001-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 45f63b09828a1..14dd1b432ac34 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -589,6 +589,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
-- 
2.39.5


