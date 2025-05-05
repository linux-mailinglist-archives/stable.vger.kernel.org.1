Return-Path: <stable+bounces-139811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C6EAAA008
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BAE1A83372
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128A28D828;
	Mon,  5 May 2025 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg9m73fC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153328CF7E;
	Mon,  5 May 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483395; cv=none; b=VEzHvLxHfOaflosllJeHRGXEGNcmj0PdK8IwAhcAxfBB8QHz9ylC1664UAiInvw0eD1phO3Y+GDUM0L/hiHxoAGbUFJtmIWrtU549rqbXFPm+O7erpvpn+M6U7T/2BNlfmCjezlIw3yNOvP+3tntdy3SHp7cvLv1BebZo17Cd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483395; c=relaxed/simple;
	bh=CjL8LGPu4Bfyc0hVImZlWY5Ujss/SIQuzx4+7U/11jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyCi8wWROoS3l6NeiKk8m7qei4lvHrSWmzK3kguIn6tvDFXobXCkYmbp+q1Cu7EgJ0KHHw93ZWXRcx5v7pihYHdaZPe/gpQJHOYwyr5+400nUW3Gez+8R5Ptc4R+SY2j4HDH0h1BPRjRTAXHktJB/5C16nsqlbB7kG4WfZu9m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg9m73fC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC75C4CEED;
	Mon,  5 May 2025 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483394;
	bh=CjL8LGPu4Bfyc0hVImZlWY5Ujss/SIQuzx4+7U/11jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yg9m73fCFG2UQA3AXy4JoAElcp2Oc8PpK0bVsoZyIfZnpRSvLKvzBFAW+jQoEGlox
	 MdAhtBJgstWe9a+juPpDhJLmpYi3gCxdKgsFPObH5tF/33xiWAN6dCdCZxFKvVweg6
	 1eGWyK6RDPzFpS5bx1cdxZG1fm41GHbEPIroav0UYNgmqJuvac+wDnqCGRYFXjsuAq
	 s6j/z09nBGj9EkqvUKQ87NR4QiQBLoPCtOiHM7befVii8mksInUlBc2zQC/tqNRtTS
	 vZNR8/q8HgTgsSMVlfkHRxHIqwNuDlRUuOA2pdFDtkdhRuL8OKZZLSoz1uYZaYuNed
	 8dqFFDYy5zh6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.14 064/642] xen/pci: Do not register devices with segments >= 0x10000
Date: Mon,  5 May 2025 18:04:40 -0400
Message-Id: <20250505221419.2672473-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 5ccf1b8ae76ddf348e02a0d1564ff9baf8b6c415 ]

The current hypercall interface for doing PCI device operations always uses
a segment field that has a 16 bit width.  However on Linux there are buses
like VMD that hook up devices into the PCI hierarchy at segment >= 0x10000,
after the maximum possible segment enumerated in ACPI.

Attempting to register or manage those devices with Xen would result in
errors at best, or overlaps with existing devices living on the truncated
equivalent segment values.  Note also that the VMD segment numbers are
arbitrarily assigned by the OS, and hence there would need to be some
negotiation between Xen and the OS to agree on how to enumerate VMD
segments and devices behind them.

Skip notifying Xen about those devices.  Given how VMD bridges can
multiplex interrupts on behalf of devices behind them there's no need for
Xen to be aware of such devices for them to be usable by Linux.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250219092059.90850-2-roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 416f231809cb6..bfe07adb3e3a6 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -43,6 +43,18 @@ static int xen_add_device(struct device *dev)
 		pci_mcfg_reserved = true;
 	}
 #endif
+
+	if (pci_domain_nr(pci_dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values, do not attempt to register devices with Xen in
+		 * segments greater or equal than 0x10000.
+		 */
+		dev_info(dev,
+			 "not registering with Xen: invalid PCI segment\n");
+		return 0;
+	}
+
 	if (pci_seg_supported) {
 		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
 
@@ -149,6 +161,16 @@ static int xen_remove_device(struct device *dev)
 	int r;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
+	if (pci_domain_nr(pci_dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values.
+		 */
+		dev_info(dev,
+			 "not unregistering with Xen: invalid PCI segment\n");
+		return 0;
+	}
+
 	if (pci_seg_supported) {
 		struct physdev_pci_device device = {
 			.seg = pci_domain_nr(pci_dev->bus),
@@ -182,6 +204,16 @@ int xen_reset_device(const struct pci_dev *dev)
 		.flags = PCI_DEVICE_RESET_FLR,
 	};
 
+	if (pci_domain_nr(dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values.
+		 */
+		dev_info(&dev->dev,
+			 "unable to notify Xen of device reset: invalid PCI segment\n");
+		return 0;
+	}
+
 	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_reset, &device);
 }
 EXPORT_SYMBOL_GPL(xen_reset_device);
-- 
2.39.5


