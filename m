Return-Path: <stable+bounces-249514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFQFMgExDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC9F57B855
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E00A305D5A2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E169405869;
	Tue, 19 May 2026 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuF83M4w"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EC13F5BFA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183465; cv=none; b=Qr0eOBi3AKY7eHnjZvIapQGyFG1TBwR4vFkCPVWivVT7eMmlipB3dIPnE1y3Njeis6lskmPw+Yefg2gujNR8C10m/CzqJ37Hppw2Qn4cOxATdqAYNxMAPEk85LVhnBWJDvnXHQuqn34osh3LGHEWnoF3KbAtMiIRsWFhpceOeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183465; c=relaxed/simple;
	bh=3mWINcI07wW/lf49lcQikU2XATZfcIWzIasgtFYFm8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJRfvqMKKRCl4n9seu/x8hn2qNln9KWgcKdGThTMF5l+TN0BGRCLjIF2dF/P8E/5OXX3ubx3eJj95ylg1Y+0g0T/Z2qFMuV19ilE2eKvDA+H/ZbHwRLLJhGIWfqSh6vd6aU1zqNgqdP0/LyDQ3W0s662pmHjQ0i/plY/GNXw72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuF83M4w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183465; x=1810719465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3mWINcI07wW/lf49lcQikU2XATZfcIWzIasgtFYFm8A=;
  b=MuF83M4wkhiCu5nSgviptWXkTO42UCtjfzLXhLwFC1+4UJksAauZfv0m
   1UON8LyACBxPAuh/pokRb/NSeOeIVnMPerWQySqOagVGlQvM2aUB89G8N
   Z3Ye8jnvXg6EWtpVL6Qk7Fv6G2x1yaEKp6jpvErlAs6B26MGWaTcLmUR+
   6mO0K8YPHzDOifOahALG/IGq476uV6wpBIOxoyjTzzYIKF82tgJC6Acg6
   W+3MhDDaEu8OyPcOesCNZ4LPvpJ2L1iiZLl9DX7G4aAW+1i5S4NhU2y9w
   QIx18GzK1tvyAKG5CMz2YGw3DC0u7SwA+b4JHLFgfMaXJQFQ6GS0DePL9
   w==;
X-CSE-ConnectionGUID: gITHLop8QKe7PCbxKQdbng==
X-CSE-MsgGUID: hFnWf8EbTJCCpnaFzf4CRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="102730378"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="102730378"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:44 -0700
X-CSE-ConnectionGUID: QhjHdDZmSI6t4+YAfksq+A==
X-CSE-MsgGUID: F7ANs2zcSzK1p0/3EYYZ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="277826712"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 08/10] PCI: Rename window_alignment() to pci_min_window_alignment()
Date: Tue, 19 May 2026 12:36:31 +0300
Message-ID: <20260519093633.16395-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
References: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249514-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 5DC9F57B855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 8bbe8cec891f88dd3de8cae44812a884e10f1446 upstream.

window_alignment() lacks prefix. Rename it to pci_min_window_alignment() in
order to include the prefix and also add min to indicate the returned
window alignment is the minimum PCI spec and arch allows.

Also make it available in drivers/pci/pci.h as upcoming changes will need
to call it from outside of setup-bus.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Link: https://patch.msgid.link/20260324165633.4583-9-ilpo.jarvinen@linux.intel.com
---
 drivers/pci/pci.h       | 3 +++
 drivers/pci/setup-bus.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..2edb03c1c6b9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1053,6 +1053,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
+resource_size_t pci_min_window_alignment(struct pci_bus *bus,
+					 unsigned long type);
+
 void pci_acs_init(struct pci_dev *dev);
 void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..edc0d682dcad 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1035,7 +1035,7 @@ resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
 #define PCI_P2P_DEFAULT_IO_ALIGN	SZ_4K
 #define PCI_P2P_DEFAULT_IO_ALIGN_1K	SZ_1K
 
-static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
+resource_size_t pci_min_window_alignment(struct pci_bus *bus, unsigned long type)
 {
 	resource_size_t align = 1, arch_align;
 
@@ -1084,7 +1084,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	if (resource_assigned(b_res))
 		return;
 
-	min_align = window_alignment(bus, IORESOURCE_IO);
+	min_align = pci_min_window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct resource *r;
 
@@ -1339,7 +1339,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		}
 	}
 
-	win_align = window_alignment(bus, b_res->flags);
+	win_align = pci_min_window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
 	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
-- 
2.47.3


