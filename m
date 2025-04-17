Return-Path: <stable+bounces-133154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EDBA91E88
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA828A1747
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551E84D2B;
	Thu, 17 Apr 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQfyl8PT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599F4206B
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897557; cv=none; b=LmYi+8gPIaQjs2XBbFrLHZUCmEa0mj6twDS3pB1FFVNVZZaFZ0jX2NuPD9W6bp9O4Y1MV711zPWqQsdGrbACmoj+R3IxHYDwF5VWzktb0ri8N4PeevLCOa/XywXa7BO8D2iaGOLnQNESS66X8PkobhB79RhNyk2AZ4BmCQDMmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897557; c=relaxed/simple;
	bh=Ad3IXshUrscq0a16XbaFXDSCelEvSTXw1DfXtnIL06w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pKhZ7SnLrOq6GiXuLJnuYDzcl1lHZWEXkOG7ITDFOBh+hfku8t7w6taqDRACkzBYgF51ATLabsMC33NR052Y+SsQXjS7vPtUQbcTkY59y8tPvN+G9f4pmOl9knpthuJgEmDqADotPSgK5SosDsss9rlTccuscw7lAtoltJazxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQfyl8PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B09C4CEEA;
	Thu, 17 Apr 2025 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897557;
	bh=Ad3IXshUrscq0a16XbaFXDSCelEvSTXw1DfXtnIL06w=;
	h=Subject:To:Cc:From:Date:From;
	b=lQfyl8PTgaFBLdlW/oAvVVuhph1HW79iuTCN+HoRg2l0rO3VGoYcSfWhVrHFxKjpD
	 aA2D7xctlg8qRa7uThbUrVe4pQ8iUd6SzH2TsryNUPSfnROpxa+9sHrbm09z4rq7BH
	 Aym2AcbZw1UTaDZaMrSKEFienYoU6p8X2QWkGilU=
Subject: FAILED: patch "[PATCH] PCI: Fix reference leak in pci_register_host_bridge()" failed to apply to 5.10-stable tree
To: make24@iscas.ac.cn,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:44:11 +0200
Message-ID: <2025041711-zoom-wheat-a870@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 804443c1f27883926de94c849d91f5b7d7d696e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041711-zoom-wheat-a870@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 804443c1f27883926de94c849d91f5b7d7d696e9 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 25 Feb 2025 10:14:40 +0800
Subject: [PATCH] PCI: Fix reference leak in pci_register_host_bridge()

If device_register() fails, call put_device() to give up the reference to
avoid a memory leak, per the comment at device_register().

Found by code review.

Link: https://lore.kernel.org/r/20250225021440.3130264-1-make24@iscas.ac.cn
Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
[bhelgaas: squash Dan Carpenter's double free fix from
https://lore.kernel.org/r/db806a6c-a91b-4e5a-a84b-6b7e01bdac85@stanley.mountain]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5f04b8d9c736..dc37a3c0a977 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -953,6 +953,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -1017,6 +1018,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -1103,12 +1105,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
-	kfree(bus);
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 


