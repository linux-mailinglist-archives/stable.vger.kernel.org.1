Return-Path: <stable+bounces-137831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196DCAA151B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0848173946
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C5245007;
	Tue, 29 Apr 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK9Tkuys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448882C60;
	Tue, 29 Apr 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947264; cv=none; b=aD7LK+mPt+Z9Pd7B4hR2qZY7D+0LjZZs7hXW6Bu4Dk0N3vleznEU79Ro7WX9YBVrwCq3GupYn2aGrNmRd53LOv9joGKByaVFiUsEKn24veHY+AhDHAwwRXJlrs+3b8l8cINkpWwXMsYrsPAUyXotVTk6R0NfAJwCIKxjYP9cQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947264; c=relaxed/simple;
	bh=ixyYSAJAgnhgsPD4/L22k9Xu1iKXJpmYy6zDMCONMYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk2h8srWnp2Lp/0HvSkSASkBuiZT69X1PMqTY4FwCNcSPFtXpWkvMbULvQ/+UNYz43FPx+49YP5yWkhZKkA+OkyNBfJykg6YTQZ5VRIWSKEUB2G/+T6wAFUF3moU8GrE19frSztAmzUyPKNLs7uRTSQUbRUfnlFd+IAu7lemfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK9Tkuys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28DBC4CEEE;
	Tue, 29 Apr 2025 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947264;
	bh=ixyYSAJAgnhgsPD4/L22k9Xu1iKXJpmYy6zDMCONMYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK9TkuysdZEyp4PhgOuPufVt4UHm3ylgvsHkkN6xP5uxkeI2Gle8LT9vVVNFaZLv9
	 F6wkmSUbdQv/5ElcqnxpoIHd8+Q/jfTDtqyv+xxPbQBrcraWwz2alJ5LE22NwFZpcF
	 OiLuJCOzbrgiNGpnD1WZrt2Xsw+ciqIQKgX/AEGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 223/286] PCI: Coalesce host bridge contiguous apertures
Date: Tue, 29 Apr 2025 18:42:07 +0200
Message-ID: <20250429161117.115356093@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 65db04053efea3f3e412a7e0cc599962999c96b4 ]

Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
can't get the BAR it needs:

  pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
  pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]

  pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
  pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
  pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
  pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
  pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
  pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
  pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window

However, the root bus has two contiguous apertures that can contain the
child resource requested.

Coalesce contiguous apertures so we can allocate from the entire contiguous
region.

[bhelgaas: fold in https://lore.kernel.org/r/20210528170242.1564038-1-kai.heng.feng@canonical.com]
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20210401131252.531935-1-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 804443c1f278 ("PCI: Fix reference leak in pci_register_host_bridge()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index be7973e249cd7..a2c53f6d1848a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -878,11 +878,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
 static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 {
 	struct device *parent = bridge->dev.parent;
-	struct resource_entry *window, *n;
+	struct resource_entry *window, *next, *n;
 	struct pci_bus *bus, *b;
-	resource_size_t offset;
+	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
-	struct resource *res;
+	struct resource *res, *next_res;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -962,11 +962,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
 		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
 
+	/* Coalesce contiguous windows */
+	resource_list_for_each_entry_safe(window, n, &resources) {
+		if (list_is_last(&window->node, &resources))
+			break;
+
+		next = list_next_entry(window, node);
+		offset = window->offset;
+		res = window->res;
+		next_offset = next->offset;
+		next_res = next->res;
+
+		if (res->flags != next_res->flags || offset != next_offset)
+			continue;
+
+		if (res->end + 1 == next_res->start) {
+			next_res->start = res->start;
+			res->flags = res->start = res->end = 0;
+		}
+	}
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
-		list_move_tail(&window->node, &bridge->windows);
 		offset = window->offset;
 		res = window->res;
+		if (!res->end)
+			continue;
+
+		list_move_tail(&window->node, &bridge->windows);
 
 		if (res->flags & IORESOURCE_BUS)
 			pci_bus_insert_busn_res(bus, bus->number, res->end);
-- 
2.39.5




