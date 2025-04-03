Return-Path: <stable+bounces-127901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF43FA7AD12
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B6117C618
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB135293458;
	Thu,  3 Apr 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCCTIenQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D2293450;
	Thu,  3 Apr 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707349; cv=none; b=nXE89qcpPyAJdsBcoEiQlOxpCoLegiiCo2JbHyIsyRleEhHCZnyAY3K15RDZZ+o6vqUyGIvfvn9TEz1TVw+XRQhar8Ez/7DJfBxOIbyXhPUhkjjUnkQQdlfQD6YUwHXZ3WVr9Xu0YiBPqA2Ki9QYWIzx/Pu7saQ4+f7SobEk5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707349; c=relaxed/simple;
	bh=g8K87Fp9QKAQk9ScgzUSUuNvoNhHfGNLwNnOEAUkVKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUyYge6htpJ65uR3zdhFj//4k2+Vt1OmjEVtP1+DZETUxf8Z5kYf5qXgDWa3XPz73/vsFAaEGf5/32UHqqzRSDlAK8OuOerSJ75j0D0hsiefMFIcDkRQn5D886Od6UbR42FdUB/gpRHZiXiO1s0J1hyrdJWerHbbAPjywYw1UHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCCTIenQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AECAC4CEEA;
	Thu,  3 Apr 2025 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707349;
	bh=g8K87Fp9QKAQk9ScgzUSUuNvoNhHfGNLwNnOEAUkVKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCCTIenQ/bDT/O8W/uzJ76Tyo9Wasv/G7YHKTgrDbDHJyeIdI8t4JDXP/Q4ngdv6g
	 Q+k1kTp7rxUOMYC54aGa2XYZ3HEdVE70L815MEuvQaT9nuo0aWrK0i8ZFGZ0fiQsIh
	 40mhbFDdznsM98/BdOGk6K4+qYYL7QYP5iseuwMhwXrxIUJDxg1/FT9oMUj9DTakM/
	 Uu8HMs3ckaCGTD2dBWysn2SciN2eFRm2PEaLv4BZg7kgCe908um5v/Gp8/HSBy2HNv
	 KCo0+dL+uAbBwJze3MVjixX7dsyw2/XHVNhY+u831JwtOHCqi4aYjv+TOXgf3yuGeq
	 B+omw3tZ9/qnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Kral <d.kral@proxmox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/18] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Thu,  3 Apr 2025 15:08:36 -0400
Message-Id: <20250403190845.2678025-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 20f53ae4d204e..a4b0a499b67d4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -592,6 +592,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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


