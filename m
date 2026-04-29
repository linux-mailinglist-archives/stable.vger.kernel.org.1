Return-Path: <stable+bounces-241938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE6JJ6Jh8mk0qgEAu9opvQ
	(envelope-from <stable+bounces-241938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA397499E7E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73FB3071847
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F3390212;
	Wed, 29 Apr 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dk7n4FXD"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B8388E5A;
	Wed, 29 Apr 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492344; cv=none; b=hUiij/xPA/fC7ckHRhytZ37HQwwHnJISQ6MT6D6Oj1XDgb5QBdzcxcwvSd/fg1njHeGopNE4Ts4pBUzd52pVdn7P92MHCUrTr0qp4tpZrww0Pq6jEBb+Ld+0cSdXw42J6w31g1Gp5MEyyevg9ZA7o2lfaZuGmLrNuZsO1ReIUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492344; c=relaxed/simple;
	bh=COwCRWMpR2QUZTYUePCcQS4dOqrwI8PSME3538UB0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5gRVoZ/RH1I2tdUTIvNk0zjzUKj/FKI+gVmDZ7Uzx9JIrFVKY2bUVYKPpjCBhOMCojXcgD5cyyVyqefx1jmSQeohPMHmPffJyD2mrbF/vG+W+nQjHEePIvsEzQyh365LEJz5mnoyOEQAjn65fBjK9uz/eX1XVtwLggY0x1KJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dk7n4FXD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492343; x=1809028343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COwCRWMpR2QUZTYUePCcQS4dOqrwI8PSME3538UB0N4=;
  b=Dk7n4FXDzzeq/Dpxiq+A623YUtx27XQnVxVaqh/5C8+wWmN6LCGi2a46
   xaVzQtJXzpAFX6f4Kwr4i/3OW+UcGCPJxZe1GjWj7Xv1DpYFqE6WvOhd8
   kLqWNwEvVIaGVoaBmkczjKQHHdtqvdyTrhymOkar1Nh936tUkslkb93ng
   wky2MAai3cf8xW/2jra+XAJ9CsNiD8lc5OjQ5N2pNrlH98m9YLoExWI9u
   AXEYJ7MwobPegnQISQ4bzrHCh4uufu3ZrRnZV/OE3nrynqXD/3j2l52eS
   WuJz54q7SKLok7tE8rJ25RgVuSyTclq53XQByTWeZ6HwjAnrpdScIHPa3
   g==;
X-CSE-ConnectionGUID: qhozSwZ6T5S8sH3S9/DFtg==
X-CSE-MsgGUID: QLDuSlhYRPe5pTrZT6awNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78326738"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78326738"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:52:16 -0700
X-CSE-ConnectionGUID: gDRlO9WlSX2WlQNlrKdqTg==
X-CSE-MsgGUID: Dl+1UrJnSXCRKoHcbj/7bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239385676"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2026 12:52:17 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH 3/3] platform/x86/intel/tpmi/plr: Prevent fault during unbind
Date: Wed, 29 Apr 2026 12:52:14 -0700
Message-ID: <20260429195214.1532711-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429195214.1532711-1-srinivas.pandruvada@linux.intel.com>
References: <20260429195214.1532711-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA397499E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241938-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]

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
 drivers/platform/x86/intel/plr_tpmi.c | 43 +++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 05727169f49c..644df673896b 100644
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
+	struct mutex lock; /* Protect access to dbgfs_dir  */
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
@@ -282,10 +309,16 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	if (!plr)
 		return -ENOMEM;
 
+	mutex_init(&plr->lock);
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
@@ -326,6 +359,9 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 err:
 	debugfs_remove_recursive(plr->dbgfs_dir);
+err_notify:
+	intel_plr_unregister_notifier(&plr->nb);
+
 	return err;
 }
 
@@ -333,6 +369,9 @@ static void intel_plr_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_plr *plr = auxiliary_get_drvdata(auxdev);
 
+	intel_plr_unregister_notifier(&plr->nb);
+
+	guard(mutex)(&plr->lock);
 	debugfs_remove_recursive(plr->dbgfs_dir);
 }
 
-- 
2.52.0


