Return-Path: <stable+bounces-242139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GALJCDJ082nQ2wEAu9opvQ
	(envelope-from <stable+bounces-242139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:24:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB934A4A9A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A45103045B50
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD23FA5EB;
	Thu, 30 Apr 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPrldHTt"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56721324B1F;
	Thu, 30 Apr 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561878; cv=none; b=htmt5/2pP6Txpz199QRVpGivmLz09eHkKLXJsJO0K9kSbLAaiTqKhitcG1GEj3R4hviHv7fi8sFas1J7hUzIFr34cTDaCEtv+4IKBLvcouFOE0U7oNLmiCuna+tFFZSVvHam20P1AGAJbHrtXczPSPeCfdRlEPxAZ1Abw5s+xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561878; c=relaxed/simple;
	bh=/jT3UsAf2htYJdjwVD6d9uXLNHV3tNM4nopKh9VVdD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4IPoyhZZuk8diFKVo5WdeyzY5ih/t8A81Ox0FR0Lg/fnp/PpcoACdcpcVsZSl6q5tGzLHT2B/xMtgyjFXcGo3fOd8VRgMr6B14AY+SzTDzBBa1msfSUzCUZSZ7SIbOfmi/YYsp2QAjneoyQiXpsGFgN6eeZ5fVlioKQEXl/FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPrldHTt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777561877; x=1809097877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/jT3UsAf2htYJdjwVD6d9uXLNHV3tNM4nopKh9VVdD8=;
  b=PPrldHTtD/Lw40zeXdO/Y22850tEg+lbp2z1YwWHT8myzycPYQS5vqug
   kZByaRKUQUWyyNtqumCROuFV2nsD3jkLb7KmhuouV4scvNzngmT6f5vP4
   IMK02ysYvWU/k3sULUvKwR7RogiJuRtIX0SjGOskucE9sAhqCZ0miMDrK
   gC3gsWm3aKsYbZHyNp1/hC1VZwowA0ubxFhD1mrukOKfOwgVSytI243sC
   O/8gFmqNsEBfn+xOz9VgmzQY6UxcwNg6ZkbczkL6rMSWMAGC5g2g7Thbn
   P53D2CSJ+MPzObDOiIm+2RrEQSeNOxO6N7rPab1dLlXul7bYa7FW/5X6b
   w==;
X-CSE-ConnectionGUID: gLNmTwSOTzu6ZagwvkYJKw==
X-CSE-MsgGUID: u81kZPpIS+y/9V3EwEAD6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="88828158"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="88828158"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:11:12 -0700
X-CSE-ConnectionGUID: /9pW+huzRZ27zhItRzS4YA==
X-CSE-MsgGUID: wtaBE7FPQ8KpFsF9WB95tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="258194280"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2026 08:11:12 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86/intel/tpmi/plr: Prevent fault during unbind
Date: Thu, 30 Apr 2026 08:11:03 -0700
Message-ID: <20260430151103.1549733-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430151103.1549733-1-srinivas.pandruvada@linux.intel.com>
References: <20260430151103.1549733-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAB934A4A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242139-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]

This driver faults when intel vsec driver unbound from PCI driver
interface. For example:

echo 0000:00:03.1 > /sys/bus/pci/drivers/intel_vsec/unbind

This is caused by accessing plr->dbgfs_dir after vsec_tpmi driver is
removed. Here vsec_tpmi driver is the parent. On unbind, the parent
device remove callback is called first which here will remove debugfs
interface. Hence plr->dbgfs_dir is no longer valid.

Register notifier for TPMI_CORE_EXIT and make this pointer to NULL,
so that debugfs_remove_recursive() is not called with bad plr->dbgfs_dir
pointer.

After notifier is returned the vsec_tpmi driver will call remove debugfs
by calling debugfs_remove_recursive().

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <Stable@vger.kernel.org>
---
v2:
	Replace mutex_init to devm_mutex_init
	Space in the comment for new mutex

 drivers/platform/x86/intel/plr_tpmi.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 05727169f49c..8faecc311038 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/seq_file.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
@@ -60,6 +61,8 @@ struct tpmi_plr {
 	struct tpmi_plr_die *die_info;
 	int num_dies;
 	struct auxiliary_device *auxdev;
+	struct notifier_block nb;
+	struct mutex lock;	/* Protect access to dbgfs_dir */
 };
 
 static const char * const plr_coarse_reasons[] = {
@@ -255,6 +258,30 @@ static ssize_t plr_status_write(struct file *filp, const char __user *ubuf,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
 
+static int intel_plr_notify(struct notifier_block *self, unsigned long action, void *data)
+{
+	struct tpmi_plr *plr = container_of(self, struct tpmi_plr, nb);
+
+	if (action == TPMI_CORE_EXIT) {
+		guard(mutex)(&plr->lock);
+		plr->dbgfs_dir = NULL;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int intel_plr_register_notifier(struct notifier_block *nb)
+{
+	nb->notifier_call = intel_plr_notify;
+	nb->priority = 0;
+	return tpmi_register_notifier(nb);
+}
+
+static void intel_plr_unregister_notifier(struct notifier_block *nb)
+{
+	tpmi_unregister_notifier(nb);
+}
+
 static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
 	struct oobmsm_plat_info *plat_info;
@@ -282,10 +309,18 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	if (!plr)
 		return -ENOMEM;
 
+	err = devm_mutex_init(&auxdev->dev, &plr->lock);
+	if (err)
+		return err;
+
+	intel_plr_register_notifier(&plr->nb);
+
 	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
 				     GFP_KERNEL);
-	if (!plr->die_info)
-		return -ENOMEM;
+	if (!plr->die_info) {
+		err = -ENOMEM;
+		goto err_notify;
+	}
 
 	plr->num_dies = num_resources;
 	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
@@ -326,6 +361,9 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 err:
 	debugfs_remove_recursive(plr->dbgfs_dir);
+err_notify:
+	intel_plr_unregister_notifier(&plr->nb);
+
 	return err;
 }
 
@@ -333,6 +371,9 @@ static void intel_plr_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_plr *plr = auxiliary_get_drvdata(auxdev);
 
+	intel_plr_unregister_notifier(&plr->nb);
+
+	guard(mutex)(&plr->lock);
 	debugfs_remove_recursive(plr->dbgfs_dir);
 }
 
-- 
2.52.0


