Return-Path: <stable+bounces-210749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAYQKW/YcGkOaAAAu9opvQ
	(envelope-from <stable+bounces-210749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:45:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 691FD57BCC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2848D6A8C28
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B5481FDD;
	Wed, 21 Jan 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlEAcctx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BD34CFD6;
	Wed, 21 Jan 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001288; cv=none; b=q5Dpx0TW7do6n84QGvx6HflUWI+IGa9opqu05qaVJpaCmcXu7c1tLB920w3XDV2zMMsSGUFiACYeMAmoIv7714eZLs5X7mVfCjhrcKf8Ri+MxB48YYqLp7F5JX7LPAILcC032VgMUSQskhbpfS+NbKtpZQ3HEf4hhnJVIzfFaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001288; c=relaxed/simple;
	bh=THu1p62oDLh5lSnTH6yRQeplhg8j3JbMrtWLPiiP1as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZ38MYE9mJ9/7W2D54RSTN33M3Slu8UTWNqBmXnsw0PCqgrMW16WohhZwSMqiLaslqBxDr297v4mxAWxZv63Ag0T7cxqouihb7vPJgcjKrtv7OjCc5Ne5Hpscd6AHehOSl+NjInDN1GeioiPaR3+fyWuIWnRkMIItp3rGh4wc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlEAcctx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001287; x=1800537287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THu1p62oDLh5lSnTH6yRQeplhg8j3JbMrtWLPiiP1as=;
  b=FlEAcctxzzSHdpOlMfXDmcVYzOM2zAUw43EcxHjZl/purejmzWXNupWZ
   PQp0KnMpXoNZFKYyb+GAu/sYoCRv9aKEfonbqtjgFBaaYrPkGwcSFOJmT
   q7i2KgSJHPVvn3broKo60dOjUSaFaSCvh1ysb6Cu9llquVNgXONR0jkSn
   KKbDtBIsicMqaqlECZ5KbowmLcPqJWu7zxmdio0ZN7VkcqAlN/1Ewtzjl
   WYYHNj2RN2mror9y05kLJDTNIouz5d7IpVThPi9Rp4uAyM95G9Bjsjg4S
   AEnrztCkMypHs3U2ykwJ1IctQEMuqETj/y932HnlW/DW8GCO0isvqN7cJ
   Q==;
X-CSE-ConnectionGUID: 2UJLlb0ATzWpnlTM/tpufw==
X-CSE-MsgGUID: Wb5I76JkRUyLBuhFKLSkWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69424288"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69424288"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:46 -0800
X-CSE-ConnectionGUID: 8GOrohWkQNqslEk3wyz4vA==
X-CSE-MsgGUID: MYOrumjqSsOc+J/5kJ7eMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206872432"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: Fix Resizable BAR restore order
Date: Wed, 21 Jan 2026 15:14:17 +0200
Message-Id: <20260121131417.9582-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
References: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-210749-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 691FD57BCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize
rollback path") changed BAR resize to layer rebar code and resource
setup/restore code cleanly. Unfortunately, it did not consider how the
value of the BAR Size field impacts the read-only bits in the Base
Address Register (PCIe7 spec, sec. 7.8.6.3). That is, it very much
matters in which order the BAR Size and Base Address Register are
restored.

Post-337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback
path") during BAR resize rollback, pci_do_resource_release_and_resize()
attempts to restore the old address to the BAR that was resized, but it
can fail to setup the address correctly if the address has too low bits
set that collide with the bits that are still read-only. As a result,
kernel's resource and BAR will be out-of-sync.

Fix this by restoring BAR Size before rolling back the resource
changes and restoring the BAR.

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Link: https://lore.kernel.org/linux-pci/aW_w1oFQCzUxGYtu@intel.com/
Cc: stable@vger.kernel.org
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/rebar.c     | 18 +-----------------
 drivers/pci/setup-bus.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index ecdebdeb2dff..39f8cf3b70d5 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -295,7 +295,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 			int exclude_bars)
 {
 	struct pci_host_bridge *host;
-	int old, ret;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -308,21 +307,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 	if (!pci_rebar_size_supported(dev, resno, size))
 		return -EINVAL;
 
-	old = pci_rebar_get_current_size(dev, resno);
-	if (old < 0)
-		return old;
-
-	ret = pci_rebar_set_size(dev, resno, size);
-	if (ret)
-		return ret;
-
-	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
-	if (ret)
-		goto error_resize;
-	return 0;
-
-error_resize:
-	pci_rebar_set_size(dev, resno, old);
-	return ret;
+	return pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9c374feafc77..a61d38777cdc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2504,12 +2504,20 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	struct resource *b_win, *r;
 	LIST_HEAD(saved);
 	unsigned int i;
-	int ret = 0;
+	int old, ret;
 
 	b_win = pbus_select_window(bus, res);
 	if (!b_win)
 		return -EINVAL;
 
+	old = pci_rebar_get_current_size(pdev, resno);
+	if (old < 0)
+		return old;
+
+	ret = pci_rebar_set_size(pdev, resno, size);
+	if (ret)
+		return ret;
+
 	pci_dev_for_each_resource(pdev, r, i) {
 		if (i >= PCI_BRIDGE_RESOURCES)
 			break;
@@ -2542,7 +2550,15 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 	return ret;
 
 restore:
-	/* Revert to the old configuration */
+	/*
+	 * Revert to the old configuration.
+	 *
+	 * BAR Size must be restored first because it affects the read-only
+	 * bits in BAR (the old address might not be restorable otherwise
+	 * due to low address bits).
+	 */
+	pci_rebar_set_size(pdev, resno, old);
+
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
 		struct pci_dev *dev = dev_res->dev;
-- 
2.39.5


