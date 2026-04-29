Return-Path: <stable+bounces-241936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIyREo1h8mlNqgEAu9opvQ
	(envelope-from <stable+bounces-241936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8C499E4E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF5CB303CC00
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40C38837C;
	Wed, 29 Apr 2026 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DumGdNFP"
X-Original-To: Stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDD194A6C;
	Wed, 29 Apr 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492342; cv=none; b=lSUceaTqMUm46wdoowcs2kLskFP2kN5+fjslKwGckv56G3sjyLmsjWtKmAcg8KA9UHSQ3dLONMslVH4UlxuJhf5ppOzjf8M+HliGDLTbhNYnjx5nqBB+ajmBjO7Jl8bajkHEPN6irUD2i+6iYGVtq1EclOVZrVAgHT84i7drXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492342; c=relaxed/simple;
	bh=eV+8wjJgFvWbZ6S1ykU0YqF/7yuRj+RxujDHHfqxLaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LebSUcOmGM+6xbvZB2B1CA54k4eb6UVfhq2GkgJFJobp1UPFCz6OsXvotdrlQjJ5m35ECj7V2Lme5Xm/LUXE7LbSaTjZty2RyEjC/zKnDE2wgI6zX/9aYmVcmRsFRmOtX+h5CrjofFDEVtSDW8rw/hcVlmRYRla+kK3IL04bY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DumGdNFP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492341; x=1809028341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eV+8wjJgFvWbZ6S1ykU0YqF/7yuRj+RxujDHHfqxLaE=;
  b=DumGdNFPYkm2UohwWdgTXlbOCiAi+I3vrtjKkbI35f3ir7Bu1GisRldH
   DSZkVZMJlwiyiDrVohVukaoRdvxWK8yC3LqeXhfj7c/2aUC1TUoSvNWvZ
   dFLfow3PTqirJJKQXQodxQapGRiuvHcTZdhpxrYSi95D2kITXFvPfddgl
   v4SF1wzPVSP9IoNYJQp36DEQp8+scILUe0hc3HNc+1akj7ZQ+J0S+OeDM
   zADAb/zHKDiaGF4Cdx0S5kX+1CE5Zn6P+LqNpawQwmlZsVZnjZr/naTuh
   2Esh0ARWSL6WSOnP1qpDqt05ExFN1dZJ6ntYBLU0GLJuXvHLdPgCPzfAb
   g==;
X-CSE-ConnectionGUID: RuQaPQgOQD+Fm16VUo12uA==
X-CSE-MsgGUID: Tg0ZU0J/S5+Lx4FR1xlbTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78326736"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78326736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:52:16 -0700
X-CSE-ConnectionGUID: sN7IZ9dTR2Okdqwx1muxDA==
X-CSE-MsgGUID: Ul6VFZ6kRFidScAlhtr00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239385675"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2026 12:52:17 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: intel: Add notifiers support
Date: Wed, 29 Apr 2026 12:52:13 -0700
Message-ID: <20260429195214.1532711-3-srinivas.pandruvada@linux.intel.com>
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
X-Rspamd-Queue-Id: 56F8C499E4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241936-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]

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


