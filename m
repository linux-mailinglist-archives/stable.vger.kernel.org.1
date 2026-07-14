Return-Path: <stable+bounces-274578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iqr6CKGyVmpFAQEAu9opvQ
	(envelope-from <stable+bounces-274578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9275920E
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dOPQWGKG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274578-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274578-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F75301BB0B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A32B108;
	Tue, 14 Jul 2026 22:04:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E9642BC4F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066665; cv=none; b=utR5431xh5W/1zPsDwsL3J42PIW53fBh3RP+QTPU+9NEONEpk5t5rtNC13SPVzxtFMnqeJ3rTLEYO7C9W/HNPCEiOq+NTn9VEvSd1Yre/4cQexhTAo7taaMkg4O4TMsWHAlHYDZ90gkVcUuy2J8SqQXiCihHMA5Ku8tAf5oudlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066665; c=relaxed/simple;
	bh=FhJTwoBf2lkFjvhowJqNY5L/1xcaQNKAvBl72l2DZ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI1jdXC7mbF+2TZ6/Ob6cqGC7i+tjfVLImeHEovYEnn+SIwERx84IykYLzRarK69ZhIh/xmvXG7l1GLwSMjTZsGtkJ1CXCf8J+guGM+dCAwsR06K8JjB1THkLFQS1TJwC45e9MTcz92Y5hHNWIq4bg42hXq502FuMSUcyyn60VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOPQWGKG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236B01F000E9;
	Tue, 14 Jul 2026 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066663;
	bh=LIHENYiA865q9J1bX/h4oHbavmr0ZDhGqKU/MmkhRB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOPQWGKGgoKBtGzco9BMVk1YQu3f4Lmfcv2i4BcKoRpdZjifNoNNxGvMbnYCT97xT
	 txjGDTfIOVjrUWIOB9Du+FfrEVjbBCskqG/g1bgxp5PFIUcpGY2O1prCNzLqFFaDQl
	 Xw+UQXq0zs8Z+4L24K4lorBrVaTTCESbacdrMLhoFs485HW9aZ4YidiZxuw6u1YUGN
	 Sy4oWFRI0vR5jMD3Uf1gvwtlpBGuTR++oYnhztsTv5p1iLBMPpzL/7h3AHeoVRGWCA
	 ZiQiAPFEYiCjIsPMvWiULoy4oH2UtCQ6BomgMKAyIRqydOh4bdvCAICE89q6i2Zl19
	 xQwKsVwzSErNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] PCI: Use pbus_select_window() during BAR resize
Date: Tue, 14 Jul 2026 18:04:16 -0400
Message-ID: <20260714220421.3334071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071358-dominoes-employee-70eb@gregkh>
References: <2026071358-dominoes-employee-70eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274578-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:ilpo.jarvinen@linux.intel.com,m:bhelgaas@google.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15C9275920E

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 7dc58aa7f1b32a215fb0b7c6ca30ddf4663dedf4 ]

Prior to a BAR resize, __resource_resize_store() loops through the normal
resources of the PCI device and releases those that match to the flags of
the BAR to be resized. This is necessary to allow resizing also the
upstream bridge window as only childless bridge windows can be resized.

While the flags check (mostly) works (if corner cases are ignored), the
more straightforward way is to check if the resources share the bridge
window. Change __resource_resize_store() to do the check using
pbus_select_window().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250829131113.36754-16-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-sysfs.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 122c182229b33d..a67de23a2cf94c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1426,13 +1426,19 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 				       const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long size, flags;
+	struct pci_bus *bus = pdev->bus;
+	struct resource *b_win, *res;
+	unsigned long size;
 	int ret, i;
 	u16 cmd;
 
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
+	b_win = pbus_select_window(bus, pci_resource_n(pdev, n));
+	if (!b_win)
+		return -EINVAL;
+
 	device_lock(dev);
 	if (dev->driver || pci_num_vf(pdev)) {
 		ret = -EBUSY;
@@ -1452,19 +1458,19 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	pci_write_config_word(pdev, PCI_COMMAND,
 			      cmd & ~PCI_COMMAND_MEMORY);
 
-	flags = pci_resource_flags(pdev, n);
-
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
-		if (pci_resource_len(pdev, i) &&
-		    pci_resource_flags(pdev, i) == flags)
+	pci_dev_for_each_resource(pdev, res, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
+
+		if (b_win == pbus_select_window(bus, res))
 			pci_release_resource(pdev, i);
 	}
 
 	ret = pci_resize_resource(pdev, n, size);
 
-	pci_assign_unassigned_bus_resources(pdev->bus);
+	pci_assign_unassigned_bus_resources(bus);
 
 	if (pci_create_resource_files(pdev))
 		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
-- 
2.53.0


