Return-Path: <stable+bounces-220412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHrVGRE6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F96A1C6681
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F645317A643
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D43AFCA8;
	Sat, 28 Feb 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjsbxKv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6EC3AFCA0;
	Sat, 28 Feb 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300303; cv=none; b=K0zEI1GpAxqL23xDrZpfIf3Cf6bIsjCxBC7w367WngQWzwnb4jKgrnnOQxSqPh6ZVc3o1KA5JSmfAFM42t9Op4WLR+zjJ/v/P5CmtelwSGd2cYV4++B85XMFVULswUQ26vTZMeLDhG/P8e2w6ijgxAxLos7xBVwf4iSF1MC3XCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300303; c=relaxed/simple;
	bh=v1LRChWIMI4mPhTCvMHCwHNjuYm7ObE7BiiAy/dqxkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPwHp9KIGE3x/th3USouaVzv7TYD3bRJuPQY6TLqgrH+tU25fQfesMbLJ+h09RyYxLSC8OjtF31p+RHojWkPBId0cSlYY95cBblJYHvI7gbkI6LMRiddbfWq9NbZjluqeNv/mxUQqsQsyYck9hVdG+MtLQTwf3zpn2KwSDE+usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjsbxKv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC0FC116D0;
	Sat, 28 Feb 2026 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300303;
	bh=v1LRChWIMI4mPhTCvMHCwHNjuYm7ObE7BiiAy/dqxkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjsbxKv+X+s4y2ePrm77HSR3Xz+eVE2DaANQIvOhGmc0NCru3ZjZ5MDk20zEMJO+P
	 p0Y2FPyskSPzhzk5PByYei7BUn2TUcyvAqYbnCoLpYcc2bf2fM5KXe1jtefN3gQxnR
	 pFYrFS+I24wMAlcMigQQBs7eTZmuNkT9a4Ak3P7XBFh0OIZdvuUQehxrLNFuisNNk7
	 ejNBGQ6+rxwFpp35NtQZiiSis1C1aoCMcdv6n8xsuYlOmaYiC2qN4hg2jyYrJh6jbb
	 lAWK0XtpGKFjBrUn++KzMnZPdbmDuYqAwHGEmGE7c7aFV1S9prU+PHsU2Qz7DDt+0e
	 L9oYYeatabhgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 333/844] PCI: Fix pci_slot_lock () device locking
Date: Sat, 28 Feb 2026 12:24:06 -0500
Message-ID: <20260228173244.1509663-334-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220412-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0F96A1C6681
X-Rspamd-Action: no action

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 1f5e57c622b4dc9b8e7d291d560138d92cfbe5bf ]

Like pci_bus_lock(), pci_slot_lock() needs to lock the bridge device to
prevent warnings like:

  pcieport 0000:e2:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0x55/0xa0

Take and release the lock for the bridge providing the slot for the
lock/trylock and unlock routines.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260130165953.751063-3-kbusch@meta.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a05978f5cf2c7..41596bc72f1dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5293,10 +5293,9 @@ static int pci_bus_trylock(struct pci_bus *bus)
 /* Do any devices on or below this slot prevent a bus reset? */
 static bool pci_slot_resettable(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = slot->bus->self;
 
-	if (slot->bus->self &&
-	    (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
+	if (bridge && (bridge->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
 		return false;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
@@ -5313,7 +5312,10 @@ static bool pci_slot_resettable(struct pci_slot *slot)
 /* Lock devices from the top of the tree down */
 static void pci_slot_lock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = slot->bus->self;
+
+	if (bridge)
+		pci_dev_lock(bridge);
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
@@ -5328,7 +5330,7 @@ static void pci_slot_lock(struct pci_slot *slot)
 /* Unlock devices from the bottom of the tree up */
 static void pci_slot_unlock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = slot->bus->self;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
@@ -5338,12 +5340,18 @@ static void pci_slot_unlock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
+	struct pci_dev *dev, *bridge = slot->bus->self;
+
+	if (bridge && !pci_dev_trylock(bridge))
+		return 0;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
@@ -5368,6 +5376,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		else
 			pci_dev_unlock(dev);
 	}
+
+	if (bridge)
+		pci_dev_unlock(bridge);
 	return 0;
 }
 
-- 
2.51.0


