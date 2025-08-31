Return-Path: <stable+bounces-176775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46308B3D525
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E90C7AAD5C
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6822CBC6;
	Sun, 31 Aug 2025 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZbnSCS5x"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB642153ED
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671708; cv=none; b=SgLx1W0QjdNlCJ+/3JSFBrsZp85TB+APT2mOzdRkqkmqaQOdyYKPGEl9UxfPAzvTBlNB7O1VIt9rY5szZlydpOZMDyXOg0yqB2mKW2JV5J02Cg8aJ0Uv3gl4OeVP3YSKVZ41o/5VPVNzw3ixEETWA+kMt6fHp97y7Wua6faBh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671708; c=relaxed/simple;
	bh=WqfT+RuOpoy2GNTNCGbwzBezOFmM1K9e9h+alWy6cGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g9kHk7e3Eb5e6RT5F72jDfEPF10O19DNI5Z+w9sDJZSfwYnyBzaRL/U9Enjf1a3ZLaqK7EPwLsmXxxE7GkaCSZXGhECfd0D66dMKx5iN0B+W7oL4yWNf5pISWhhX31hvBVwwO+AvtLwFnY9lF5f8/DQ8Jowb9CKb1z1fGjuqX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZbnSCS5x; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cFNh654wqz9tBL;
	Sun, 31 Aug 2025 22:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756671702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yfw+WMjGUF0hO/KZCoOHJUIvyWE1adn9OAswx+D5UuE=;
	b=ZbnSCS5xaUqzL3bHh+zB/WgB/duVnZeSRge7/O8d+5aPG+/bmTedreKa+5hQlgr+Tpe192
	PT0fH3OT81kLOoz/np0LuijSpaJ1wgkgIh2uUNYa+52TW+i9Y+tGSG8Di4y/i5Kd57m/Uo
	MRbU2Roj7o8CqDCoXBSWu+CMbswHsGJsD1SSgMfzBAF0tPU0PoDUl7YHhyph4Pccm0F6hZ
	6ad1gtnjUvfdKfVAbY8nRjqDjJOhKDjZkjymoUHKpQVJoHZZUBIIyDYGf5yb1i/LriS5t8
	NzoxE3wWx4ZaaCIvuFy/iBhbuLmSoW1tzTnaxqvfLVAQHlejft48W+0jYtivTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/2] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Sun, 31 Aug 2025 22:20:48 +0200
Message-ID: <20250831202100.443607-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ef131cd13b8f1a098e5
X-MBO-RS-META: yofux4sof5gw74gd6taawohj8u5bo7g5

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 817f989700fddefa56e5e443e7d138018ca6709d ]

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: <stable@vger.kernel.org> # 6.12.x
---
 drivers/pci/controller/plda/pcie-starfive.c | 2 +-
 drivers/pci/pci.h                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 0564fdce47c2a..0a0b5a7d84d7e 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -368,7 +368,7 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 	 * of 100ms following exit from a conventional reset before
 	 * sending a configuration request to the device.
 	 */
-	msleep(PCIE_RESET_CONFIG_DEVICE_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	if (starfive_pcie_host_wait_for_link(pcie))
 		dev_info(dev, "port link down\n");
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b65868e709517..c951f861a69b2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -57,7 +57,7 @@
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
 #define PCIE_MSG_TYPE_R_RC	0
-- 
2.50.1


