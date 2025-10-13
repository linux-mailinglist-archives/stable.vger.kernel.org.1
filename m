Return-Path: <stable+bounces-184770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01FBD4841
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275DE501D8D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57B78F54;
	Mon, 13 Oct 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tk4a36u9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A13064B7;
	Mon, 13 Oct 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368383; cv=none; b=Nzl+K/A/UUoPSl2augM/u9kG0duQwm1dfnADiod3YeSkr5PQn4RV0zwuGnJJyxG6+QscCW81x7j1WzpcSA1YUaa6P4zwb7U2xO3tzCWmVuYiRYvWQwOkCrZJVP9UZXvnb8pPwg/w5NIoH07iBW9J9JW3bBNmYlZA+eti7T4L5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368383; c=relaxed/simple;
	bh=a2MpA/MNafW3j1LBqrd0ygkoBHZ/L1qjMiBU30B/jFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CENlQqnF6Xmfz/3lr7Buqh7yGj+M9qwdM/EWTqmQvHgO1i4UvAkABX17UfjOdx2vO8wHla4UihIZyBOW2gcS0CTqKRNVe0s+t0GGtifgeOr38KYzExe8Q4eujZIS6hjlkZY4sIBlC19qQsbNQ4WkBop9BqYpgizaUcxf++f/qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tk4a36u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8EDC4CEFE;
	Mon, 13 Oct 2025 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368383;
	bh=a2MpA/MNafW3j1LBqrd0ygkoBHZ/L1qjMiBU30B/jFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tk4a36u9Wpq4+LSryIefrVLbFzPuNWJ45WyESzQih0TZ9fucAkrtGQwBczAMZlAHQ
	 3obQxn62VhPONj3YjqxBX9yNRA7YHER57rEcpM1IJR0/ZrM/cxkmSnoDDjNnzLvYd7
	 gA6fZsQ3MDCgL8v6a2pFDfpc3HYJdD1LnPIFoVGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nirmoy Das <nirmoyd@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 108/262] PCI/ACPI: Fix pci_acpi_preserve_config() memory leak
Date: Mon, 13 Oct 2025 16:44:10 +0200
Message-ID: <20251013144330.017141996@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Nirmoy Das <nirmoyd@nvidia.com>

[ Upstream commit fac679df7580979174c90303f004b09cdc6f086f ]

pci_acpi_preserve_config() leaks memory by returning early without freeing
the ACPI object on success. Fix that by always freeing the obj, which is
not needed by the caller.

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to pci_register_host_bridge()")
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250825214642.142135-1-nirmoyd@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 99c58ee09fbb0..0cd8a75e22580 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -122,6 +122,8 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
+	bool ret = false;
+
 	if (ACPI_HANDLE(&host_bridge->dev)) {
 		union acpi_object *obj;
 
@@ -135,11 +137,11 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
 					      NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
-			return true;
+			ret = true;
 		ACPI_FREE(obj);
 	}
 
-	return false;
+	return ret;
 }
 
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
-- 
2.51.0




