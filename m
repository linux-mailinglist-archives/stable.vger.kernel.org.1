Return-Path: <stable+bounces-151554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B1ACF764
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B35E3AF7EF
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E096427B4FA;
	Thu,  5 Jun 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNheD5E4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8961F4CBB;
	Thu,  5 Jun 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149121; cv=none; b=EMaziuCigRW76O4qdkc+Kf0mPXsl81BmY3Y/LDiD4v3ol0vtkluTfDcNkko6DZlj33PNbs6sd2qS55kHd7DDM1Ys6Axkv1OpqDkt4pwJxI93sziTbbqX4ytdL7h+oNl6rwzwjmHXSU9kUJLmurz7izVCb2w3VJQr9Rl+nO43Axc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149121; c=relaxed/simple;
	bh=a0znDjK0vrqtdTEtFct70rKnS2uVxclp/BQ6WuIq69A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCxa/VlbAH6s/I+/QyRNZC7zBHBETB7xXKoWJoipRnoUVq9luQsH0JjTaZwSB6JsQft8cTngbg4Ckv2dmeJC2/LdzyvNFRE4Ovf8Pmjori5CkU+aopegYfIeIHTTz4yZhF2WmoU9MuYi8ytM5qKIupS1VLc+1qR4UlHghWJjKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNheD5E4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749149119; x=1780685119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0znDjK0vrqtdTEtFct70rKnS2uVxclp/BQ6WuIq69A=;
  b=HNheD5E4y9ih70dbrjR7EHjXpcgr8uZsw9/r5bR4ctLcHhPjvtZVrMQq
   QlXT3FsUm1pwufLTns307FnmRXdx7vLJ868noD6a5qAf9wi+arEtg4r8F
   6X3rXb8RLhSGHdlTUsoyTaFLvy3g9GGzaoKxAXLUUr9PIm7fvC4g2ALDV
   DEMOhkl1blEQ+thBO6SknXSzc91WXMXD69m6bx2DtaF9sEIXCWsn02YAZ
   EYjXn9X3/mNhwpedFOqubz0xQzWi8s8WjVZ8uMXSsKDKLYCPl3Rjt9mAe
   54jzbGvm7l3Kl6lwH8CuoH67F7vEpwf0SvpfQVMgHlBALUL5pndrZLVzF
   Q==;
X-CSE-ConnectionGUID: xjiwdzZSTM+cTqm57V6Ttw==
X-CSE-MsgGUID: fqjJfl1NQNu7xKYKqAcOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="38916591"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="38916591"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:45:17 -0700
X-CSE-ConnectionGUID: nuo3d6+zQTWVgWoVzK8Rjg==
X-CSE-MsgGUID: HiBv/d2yR/e8s5l1tPlm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="182782429"
Received: from mjruhl-desk.amr.corp.intel.com (HELO mjruhl-desk.intel.com) ([10.124.222.42])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 11:45:16 -0700
From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To: platform-driver-x86@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	david.e.box@linux.intel.com
Cc: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/11] platform/x86/intel: refactor endpoint usage
Date: Thu,  5 Jun 2025 14:44:34 -0400
Message-ID: <20250605184444.515556-2-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605184444.515556-1-michael.j.ruhl@intel.com>
References: <20250605184444.515556-1-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of an endpoint has introduced a dependency in all class/pmt
drivers to have an endpoint allocated.

The telemetry driver has this allocation, the crashlog does not.

The current usage is very telemetry focused, but should be common code.

With this in mind:
  rename the struct telemetry_endpoint to struct class_endpoint,
  refactor the common endpoint code to be in the class.c module

Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to read telemetry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 drivers/platform/x86/intel/pmc/core.c       |  3 +-
 drivers/platform/x86/intel/pmc/core.h       |  4 +-
 drivers/platform/x86/intel/pmc/core_ssram.c |  2 +-
 drivers/platform/x86/intel/pmt/class.c      | 45 ++++++++++++++++++
 drivers/platform/x86/intel/pmt/class.h      | 21 +++++++--
 drivers/platform/x86/intel/pmt/telemetry.c  | 51 ++++-----------------
 drivers/platform/x86/intel/pmt/telemetry.h  | 23 ++++------
 7 files changed, 84 insertions(+), 65 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7a1d11f2914f..805f56665d1d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -29,6 +29,7 @@
 #include <asm/tsc.h>
 
 #include "core.h"
+#include "../pmt/class.h"
 #include "../pmt/telemetry.h"
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
@@ -1198,7 +1199,7 @@ int get_primary_reg_base(struct pmc *pmc)
 
 void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
 {
-	struct telem_endpoint *ep;
+	struct class_endpoint *ep;
 	struct pci_dev *pcidev;
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 945a1c440cca..1c12ea7c3ce3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -16,7 +16,7 @@
 #include <linux/bits.h>
 #include <linux/platform_device.h>
 
-struct telem_endpoint;
+struct class_endpoint;
 
 #define SLP_S0_RES_COUNTER_MASK			GENMASK(31, 0)
 
@@ -432,7 +432,7 @@ struct pmc_dev {
 
 	bool has_die_c6;
 	u32 die_c6_offset;
-	struct telem_endpoint *punit_ep;
+	struct class_endpoint *punit_ep;
 	struct pmc_info *regmap_list;
 };
 
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 739569803017..3e670fc380a5 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -42,7 +42,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
 
 static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 {
-	struct telem_endpoint *ep;
+	struct class_endpoint *ep;
 	const u8 *lpm_indices;
 	int num_maps, mode_offset = 0;
 	int ret, mode;
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 7233b654bbad..bba552131bc2 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -76,6 +76,47 @@ int pmt_telem_read_mmio(struct pci_dev *pdev, struct pmt_callbacks *cb, u32 guid
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_read_mmio, "INTEL_PMT");
 
+/* Called when all users unregister and the device is removed */
+static void pmt_class_ep_release(struct kref *kref)
+{
+	struct class_endpoint *ep;
+
+	ep = container_of(kref, struct class_endpoint, kref);
+	kfree(ep);
+}
+
+void intel_pmt_release_endpoint(struct class_endpoint *ep)
+{
+	kref_put(&ep->kref, pmt_class_ep_release);
+}
+EXPORT_SYMBOL_NS_GPL(intel_pmt_release_endpoint, "INTEL_PMT");
+
+int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
+			   struct intel_pmt_entry *entry)
+{
+	struct class_endpoint *ep;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	ep->pcidev = ivdev->pcidev;
+	ep->header.access_type = entry->header.access_type;
+	ep->header.guid = entry->header.guid;
+	ep->header.base_offset = entry->header.base_offset;
+	ep->header.size = entry->header.size;
+	ep->base = entry->base;
+	ep->present = true;
+	ep->cb = ivdev->priv_data;
+
+	/* Endpoint lifetimes are managed by kref, not devres */
+	kref_init(&ep->kref);
+
+	entry->ep = ep;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(intel_pmt_add_endpoint, "INTEL_PMT");
 /*
  * sysfs
  */
@@ -97,6 +138,10 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
 	if (count > entry->size - off)
 		count = entry->size - off;
 
+	/* verify endpoint is available */
+	if (!entry->ep)
+		return -ENODEV;
+
 	count = pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry->header.guid, buf,
 				    entry->base, off, count);
 
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index b2006d57779d..d2d8f9e31c9d 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -9,8 +9,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "telemetry.h"
-
 /* PMT access types */
 #define ACCESS_BARID		2
 #define ACCESS_LOCAL		3
@@ -19,11 +17,19 @@
 #define GET_BIR(v)		((v) & GENMASK(2, 0))
 #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
 
+struct kref;
 struct pci_dev;
 
-struct telem_endpoint {
+struct class_header {
+	u8	access_type;
+	u16	size;
+	u32	guid;
+	u32	base_offset;
+};
+
+struct class_endpoint {
 	struct pci_dev		*pcidev;
-	struct telem_header	header;
+	struct class_header	header;
 	struct pmt_callbacks	*cb;
 	void __iomem		*base;
 	bool			present;
@@ -38,7 +44,7 @@ struct intel_pmt_header {
 };
 
 struct intel_pmt_entry {
-	struct telem_endpoint	*ep;
+	struct class_endpoint	*ep;
 	struct intel_pmt_header	header;
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
@@ -69,4 +75,9 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry,
 			 struct intel_vsec_device *dev, int idx);
 void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
 			   struct intel_pmt_namespace *ns);
+
+int intel_pmt_add_endpoint(struct intel_vsec_device *ivdev,
+			   struct intel_pmt_entry *entry);
+void intel_pmt_release_endpoint(struct class_endpoint *ep);
+
 #endif
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index ac3a9bdf5601..27d09867e6a3 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -18,6 +18,7 @@
 #include <linux/overflow.h>
 
 #include "class.h"
+#include "telemetry.h"
 
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
@@ -93,48 +94,14 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
 	return 0;
 }
 
-static int pmt_telem_add_endpoint(struct intel_vsec_device *ivdev,
-				  struct intel_pmt_entry *entry)
-{
-	struct telem_endpoint *ep;
-
-	/* Endpoint lifetimes are managed by kref, not devres */
-	entry->ep = kzalloc(sizeof(*(entry->ep)), GFP_KERNEL);
-	if (!entry->ep)
-		return -ENOMEM;
-
-	ep = entry->ep;
-	ep->pcidev = ivdev->pcidev;
-	ep->header.access_type = entry->header.access_type;
-	ep->header.guid = entry->header.guid;
-	ep->header.base_offset = entry->header.base_offset;
-	ep->header.size = entry->header.size;
-	ep->base = entry->base;
-	ep->present = true;
-	ep->cb = ivdev->priv_data;
-
-	kref_init(&ep->kref);
-
-	return 0;
-}
-
 static DEFINE_XARRAY_ALLOC(telem_array);
 static struct intel_pmt_namespace pmt_telem_ns = {
 	.name = "telem",
 	.xa = &telem_array,
 	.pmt_header_decode = pmt_telem_header_decode,
-	.pmt_add_endpoint = pmt_telem_add_endpoint,
+	.pmt_add_endpoint = intel_pmt_add_endpoint,
 };
 
-/* Called when all users unregister and the device is removed */
-static void pmt_telem_ep_release(struct kref *kref)
-{
-	struct telem_endpoint *ep;
-
-	ep = container_of(kref, struct telem_endpoint, kref);
-	kfree(ep);
-}
-
 unsigned long pmt_telem_get_next_endpoint(unsigned long start)
 {
 	struct intel_pmt_entry *entry;
@@ -155,7 +122,7 @@ unsigned long pmt_telem_get_next_endpoint(unsigned long start)
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_get_next_endpoint, "INTEL_PMT_TELEMETRY");
 
-struct telem_endpoint *pmt_telem_register_endpoint(int devid)
+struct class_endpoint *pmt_telem_register_endpoint(int devid)
 {
 	struct intel_pmt_entry *entry;
 	unsigned long index = devid;
@@ -174,9 +141,9 @@ struct telem_endpoint *pmt_telem_register_endpoint(int devid)
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_register_endpoint, "INTEL_PMT_TELEMETRY");
 
-void pmt_telem_unregister_endpoint(struct telem_endpoint *ep)
+void pmt_telem_unregister_endpoint(struct class_endpoint *ep)
 {
-	kref_put(&ep->kref, pmt_telem_ep_release);
+	intel_pmt_release_endpoint(ep);
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_unregister_endpoint, "INTEL_PMT_TELEMETRY");
 
@@ -206,7 +173,7 @@ int pmt_telem_get_endpoint_info(int devid, struct telem_endpoint_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_get_endpoint_info, "INTEL_PMT_TELEMETRY");
 
-int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count)
+int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32 count)
 {
 	u32 offset, size;
 
@@ -226,7 +193,7 @@ int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count)
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_read, "INTEL_PMT_TELEMETRY");
 
-int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count)
+int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u32 count)
 {
 	u32 offset, size;
 
@@ -245,7 +212,7 @@ int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count)
 }
 EXPORT_SYMBOL_NS_GPL(pmt_telem_read32, "INTEL_PMT_TELEMETRY");
 
-struct telem_endpoint *
+struct class_endpoint *
 pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev, u32 guid, u16 pos)
 {
 	int devid = 0;
@@ -279,7 +246,7 @@ static void pmt_telem_remove(struct auxiliary_device *auxdev)
 	for (i = 0; i < priv->num_entries; i++) {
 		struct intel_pmt_entry *entry = &priv->entry[i];
 
-		kref_put(&entry->ep->kref, pmt_telem_ep_release);
+		pmt_telem_unregister_endpoint(entry->ep);
 		intel_pmt_dev_destroy(entry, &pmt_telem_ns);
 	}
 	mutex_unlock(&ep_lock);
diff --git a/drivers/platform/x86/intel/pmt/telemetry.h b/drivers/platform/x86/intel/pmt/telemetry.h
index d45af5512b4e..e987dd32a58a 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.h
+++ b/drivers/platform/x86/intel/pmt/telemetry.h
@@ -2,6 +2,8 @@
 #ifndef _TELEMETRY_H
 #define _TELEMETRY_H
 
+#include "class.h"
+
 /* Telemetry types */
 #define PMT_TELEM_TELEMETRY	0
 #define PMT_TELEM_CRASHLOG	1
@@ -9,16 +11,9 @@
 struct telem_endpoint;
 struct pci_dev;
 
-struct telem_header {
-	u8	access_type;
-	u16	size;
-	u32	guid;
-	u32	base_offset;
-};
-
 struct telem_endpoint_info {
 	struct pci_dev		*pdev;
-	struct telem_header	header;
+	struct class_header	header;
 };
 
 /**
@@ -47,7 +42,7 @@ unsigned long pmt_telem_get_next_endpoint(unsigned long start);
  * * endpoint    - On success returns pointer to the telemetry endpoint
  * * -ENXIO      - telemetry endpoint not found
  */
-struct telem_endpoint *pmt_telem_register_endpoint(int devid);
+struct class_endpoint *pmt_telem_register_endpoint(int devid);
 
 /**
  * pmt_telem_unregister_endpoint() - Unregister a telemetry endpoint
@@ -55,7 +50,7 @@ struct telem_endpoint *pmt_telem_register_endpoint(int devid);
  *
  * Decrements the kref usage counter for the endpoint.
  */
-void pmt_telem_unregister_endpoint(struct telem_endpoint *ep);
+void pmt_telem_unregister_endpoint(struct class_endpoint *ep);
 
 /**
  * pmt_telem_get_endpoint_info() - Get info for an endpoint from its devid
@@ -80,8 +75,8 @@ int pmt_telem_get_endpoint_info(int devid, struct telem_endpoint_info *info);
  * * endpoint    - On success returns pointer to the telemetry endpoint
  * * -ENXIO      - telemetry endpoint not found
  */
-struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev,
-				u32 guid, u16 pos);
+struct class_endpoint *pmt_telem_find_and_register_endpoint(struct pci_dev *pcidev,
+							    u32 guid, u16 pos);
 
 /**
  * pmt_telem_read() - Read qwords from counter sram using sample id
@@ -101,7 +96,7 @@ struct telem_endpoint *pmt_telem_find_and_register_endpoint(struct pci_dev *pcid
  * * -EPIPE      - The device was removed during the read. Data written
  *                 but should be considered invalid.
  */
-int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count);
+int pmt_telem_read(struct class_endpoint *ep, u32 id, u64 *data, u32 count);
 
 /**
  * pmt_telem_read32() - Read qwords from counter sram using sample id
@@ -121,6 +116,6 @@ int pmt_telem_read(struct telem_endpoint *ep, u32 id, u64 *data, u32 count);
  * * -EPIPE      - The device was removed during the read. Data written
  *                 but should be considered invalid.
  */
-int pmt_telem_read32(struct telem_endpoint *ep, u32 id, u32 *data, u32 count);
+int pmt_telem_read32(struct class_endpoint *ep, u32 id, u32 *data, u32 count);
 
 #endif
-- 
2.49.0


