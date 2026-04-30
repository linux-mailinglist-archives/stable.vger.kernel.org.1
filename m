Return-Path: <stable+bounces-242138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PJsICd082nQ2wEAu9opvQ
	(envelope-from <stable+bounces-242138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:24:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CD4A4A84
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAD3D30155F5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF632BF5D;
	Thu, 30 Apr 2026 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKCL925D"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF652D0617;
	Thu, 30 Apr 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561877; cv=none; b=r2PJAhD7x8GkfoA1+ZmSLSdkS3MRRc4YvYyuA0Z8tbPH9CgkQDHtSEyZ7WVvf5mzDYmRW4aer5DoX9cdM/UCDprykKust57GIMrtV3ovahqjkZEq2uvx8XeUheBKoK+QZaJcBqdlkdH49wv5/9XSnn+avJmrLMJjntMIGYazoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561877; c=relaxed/simple;
	bh=RpSxg8XS1qS2UN+yR2n8TCnuE1CcA6X3EuBwp033rjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko8PE087MgRkqoK90nLTCT/DQNrv6TXuMD2e0F7J+LLsNHAMA3ZzgZYMcb/fMYp4kcMqcwZ3lsV6xSXuAecoqrEkmvaB/Ll1E8AVEPEEu53FDxANVXNtjkd2LrI/dMWAVWdfb/ptcWUTeiWfccf8MY7sKeD0K8hlWKJ4Z1QpFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKCL925D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777561876; x=1809097876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RpSxg8XS1qS2UN+yR2n8TCnuE1CcA6X3EuBwp033rjs=;
  b=QKCL925DVl7CyXpBPmzEdBB/WLpgrSpbA9PYZmFMC+2ysLq3+GTJLmZZ
   U/UBAkquvdsApDIJqaxihxlYwmnS71MtLuCjdFFWgr01ovrFbChIOu8u5
   dfgf3RRqLONzPt4OhNSuTOCIsR9skQDyQSH4GQX1HpDqY7mm2WIuR3W3i
   FlwjjHuqEbpbm1e8tW4MhtRlELry0XlrDaN+9OCGB/U43aB0R/jAh74nS
   oOjjwGkyDeH6zdJJup7qe2llEjPUsVqxQv1/pAccHrbOFL/hbKaw00nIH
   zU7eRfNCcSh1FwSGOcnA8ZGo3f+Tp+mXgCpPtyM0QlPuNMSUYBwOUS83i
   A==;
X-CSE-ConnectionGUID: olRb7kFqQfeo+taPFzt60Q==
X-CSE-MsgGUID: gYb0hPSVQDm7dvbCVYl8aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="88828156"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="88828156"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 08:11:12 -0700
X-CSE-ConnectionGUID: ge4lzdaTRJOZA7oQpJ65dw==
X-CSE-MsgGUID: c/l6jQYZT/y00+55gch+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="258194279"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2026 08:11:12 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: intel: Add notifiers support
Date: Thu, 30 Apr 2026 08:11:02 -0700
Message-ID: <20260430151103.1549733-3-srinivas.pandruvada@linux.intel.com>
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
X-Rspamd-Queue-Id: 525CD4A4A84
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
	TAGGED_FROM(0.00)[bounces-242138-lists,stable=lfdr.de];
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

In some cases a driver using services of vsec_tpmi driver requires some
processing before vsec_tpmi exits. For example a children using debugfs
can't use debugfs as this will be deleted by the vsec_tpmi driver.

This is the case when unbind using PCI driver interface. In this case
the remove callback of vsec_tpmi driver is called first, then remove
callback of its children.

Add support of blocking chain notifiers support. Notify on successful probe
and before clean up in the remove callback.

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <Stable@vger.kernel.org>
---
v2:
	No change

 drivers/platform/x86/intel/vsec_tpmi.c | 19 +++++++++++++++++++
 include/linux/intel_tpmi.h             |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index a38014e81e85..16fd7aa41f20 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -56,6 +56,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/security.h>
 #include <linux/sizes.h>
@@ -188,6 +189,20 @@ struct tpmi_feature_state {
 /* Used during auxbus device creation */
 static DEFINE_IDA(intel_vsec_tpmi_ida);
 
+static BLOCKING_NOTIFIER_HEAD(tpmi_notify_list);
+
+int tpmi_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&tpmi_notify_list, nb);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_register_notifier, "INTEL_TPMI");
+
+int tpmi_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&tpmi_notify_list, nb);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_unregister_notifier, "INTEL_TPMI");
+
 struct oobmsm_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev)
 {
 	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
@@ -832,6 +847,8 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		return ret;
 	}
 
+	blocking_notifier_call_chain(&tpmi_notify_list, TPMI_CORE_INIT, auxdev);
+
 	return 0;
 }
 
@@ -845,6 +862,8 @@ static void tpmi_remove(struct auxiliary_device *auxdev)
 {
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(auxdev);
 
+	blocking_notifier_call_chain(&tpmi_notify_list, TPMI_CORE_EXIT, auxdev);
+
 	debugfs_remove_recursive(tpmi_info->dbgfs_dir);
 }
 
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 94c06bf214fb..15f02422e9ca 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -28,6 +28,12 @@ enum intel_tpmi_id {
 	TPMI_INFO_ID = 0x81,	/* Special ID for PCI BDF and Package ID information */
 };
 
+#define TPMI_CORE_INIT	0
+#define TPMI_CORE_EXIT	1
+
+int tpmi_register_notifier(struct notifier_block *nb);
+int tpmi_unregister_notifier(struct notifier_block *nb);
+
 struct oobmsm_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev);
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
-- 
2.52.0


