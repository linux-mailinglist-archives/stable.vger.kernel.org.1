Return-Path: <stable+bounces-73986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595E9712C8
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD5284F2D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7F1B2507;
	Mon,  9 Sep 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jody/a+D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1F1AC88E
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872444; cv=none; b=hj0jhQi1t8bW+ZftusQcg7lCQuLXUqj/v1//QqPSr5d2GSD1quxcjxACdEt/sXxilzpDhMNNWNDuxFyUNu3g/S3oCVvUK0dpSNEVQU7y9AOzy+xeRf+nIoFip/KLAHGSj8NYwQwquJ5GSPI9g6jRcZBwImCR3qdTOgRp7cDuwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872444; c=relaxed/simple;
	bh=ZBysSm0TMnXXP7Pi/SuLB/ZYfahmgihwXzt3QgUSCY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VptqM3inkt1sbAbPYCDbgeu+kxf7XDA3InL5Aut1VBi1/2DDvoViodpq3n4/WDr0SRo6kB11wJlPHefbjqBcYo+gnKKAxG9JEDUv21RIYTcFcWdAfMjbThg2tGdbF49QxwBPkVcg2qoz5QxGN8B1cr1AlxK2c9ypwTYkytbJ5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jody/a+D; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725872443; x=1757408443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZBysSm0TMnXXP7Pi/SuLB/ZYfahmgihwXzt3QgUSCY8=;
  b=jody/a+DHSchlSCIh4ssGnUa2wMquoZmqlKz/ICprSax8Fh6HfWOelcj
   eqpIFBnc3OuqbgfcOjx43lBv13PzUOW7VK8f0LUjLSoDLWmK5E87HpydE
   EY15Tzdp3dyaoKxej6SAw2rJCemtKFZab5cFuOSbIClk2B25XMYGKspai
   BL3t1N41QcBY5YYQH9cGtms4bNu85k8ZwiSVxRM8vgP4T2Ekeseu0AUUg
   xQ3p4QBFVVkirSEkF9dzRjlS8rNHwQiySkD80JfOKPySr0J6YL1DxKE+I
   Bv6oromewR/b0KfTdryODIXdfvmFR298qr0kohbwKjN5/8JszjTePC4v/
   Q==;
X-CSE-ConnectionGUID: 81guk+RgRcmIHF0zkn+B0w==
X-CSE-MsgGUID: IuxzdlvcQnyH37mV+ZCj/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24702205"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24702205"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:00:42 -0700
X-CSE-ConnectionGUID: kgj9m8BgQhKZllaMcbvQuA==
X-CSE-MsgGUID: IrXcKsrfQiSVxcgwC0oP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66237333"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO jhogande-mobl1..) ([10.245.245.9])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:00:40 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.10.y 1/2] drm/i915/display: Add mechanism to use sink model when applying quirk
Date: Mon,  9 Sep 2024 11:59:17 +0300
Message-Id: <20240909085918.3239275-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024090806-marbles-stegosaur-6314@gregkh>
References: <2024090806-marbles-stegosaur-6314@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Currently there is no way to apply quirk on device only if certain panel
model is installed. This patch implements such mechanism by adding new
quirk type intel_dpcd_quirk which contains also sink_oui and sink_device_id
fields and using also them to figure out if applying quirk is needed.

New intel_init_dpcd_quirks is added and called after drm_dp_read_desc with
proper sink device identity read from dpcdc.

v3:
  - !mem_is_zero fixed to mem_is_zero
v2:
  - instead of using struct intel_quirk add new struct intel_dpcd_quirk

Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240902064241.1020965-2-jouni.hogander@intel.com
(cherry picked from commit b3b91369908ac63be6f64905448b8ba5cd151875)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit 43cf50eb1408ccb99cab01521263e8cb4cfdc023)
---
 .../drm/i915/display/intel_display_types.h    |  4 ++
 drivers/gpu/drm/i915/display/intel_dp.c       |  4 ++
 drivers/gpu/drm/i915/display/intel_quirks.c   | 51 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_quirks.h   |  5 ++
 4 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 6747c10da298e..48c5809e01b57 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1840,6 +1840,10 @@ struct intel_dp {
 	unsigned long last_oui_write;
 
 	bool colorimetry_support;
+
+	struct {
+		unsigned long mask;
+	} quirks;
 };
 
 enum lspcon_vendor {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 8ea00c8ee74a3..a7d91ca1d8baf 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -79,6 +79,7 @@
 #include "intel_pch_display.h"
 #include "intel_pps.h"
 #include "intel_psr.h"
+#include "intel_quirks.h"
 #include "intel_tc.h"
 #include "intel_vdsc.h"
 #include "intel_vrr.h"
@@ -3941,6 +3942,7 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector
 
 	drm_dp_read_desc(&intel_dp->aux, &intel_dp->desc,
 			 drm_dp_is_branch(intel_dp->dpcd));
+	intel_init_dpcd_quirks(intel_dp, &intel_dp->desc.ident);
 
 	/*
 	 * Read the eDP display control registers.
@@ -4053,6 +4055,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 		drm_dp_read_desc(&intel_dp->aux, &intel_dp->desc,
 				 drm_dp_is_branch(intel_dp->dpcd));
 
+		intel_init_dpcd_quirks(intel_dp, &intel_dp->desc.ident);
+
 		intel_dp_update_sink_caps(intel_dp);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 14d5fefc9c5b2..bce1f67c918bb 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -14,6 +14,11 @@ static void intel_set_quirk(struct intel_display *display, enum intel_quirk_id q
 	display->quirks.mask |= BIT(quirk);
 }
 
+static void intel_set_dpcd_quirk(struct intel_dp *intel_dp, enum intel_quirk_id quirk)
+{
+	intel_dp->quirks.mask |= BIT(quirk);
+}
+
 /*
  * Some machines (Lenovo U160) do not work with SSC on LVDS for some reason
  */
@@ -72,6 +77,21 @@ struct intel_quirk {
 	void (*hook)(struct intel_display *display);
 };
 
+struct intel_dpcd_quirk {
+	int device;
+	int subsystem_vendor;
+	int subsystem_device;
+	u8 sink_oui[3];
+	u8 sink_device_id[6];
+	void (*hook)(struct intel_dp *intel_dp);
+};
+
+#define SINK_OUI(first, second, third) { (first), (second), (third) }
+#define SINK_DEVICE_ID(first, second, third, fourth, fifth, sixth) \
+	{ (first), (second), (third), (fourth), (fifth), (sixth) }
+
+#define SINK_DEVICE_ID_ANY	SINK_DEVICE_ID(0, 0, 0, 0, 0, 0)
+
 /* For systems that don't have a meaningful PCI subdevice/subvendor ID */
 struct intel_dmi_quirk {
 	void (*hook)(struct intel_display *display);
@@ -203,6 +223,9 @@ static struct intel_quirk intel_quirks[] = {
 	{ 0x0f31, 0x103c, 0x220f, quirk_invert_brightness },
 };
 
+static struct intel_dpcd_quirk intel_dpcd_quirks[] = {
+};
+
 void intel_init_quirks(struct intel_display *display)
 {
 	struct pci_dev *d = to_pci_dev(display->drm->dev);
@@ -224,7 +247,35 @@ void intel_init_quirks(struct intel_display *display)
 	}
 }
 
+void intel_init_dpcd_quirks(struct intel_dp *intel_dp,
+			    const struct drm_dp_dpcd_ident *ident)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct pci_dev *d = to_pci_dev(display->drm->dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(intel_dpcd_quirks); i++) {
+		struct intel_dpcd_quirk *q = &intel_dpcd_quirks[i];
+
+		if (d->device == q->device &&
+		    (d->subsystem_vendor == q->subsystem_vendor ||
+		     q->subsystem_vendor == PCI_ANY_ID) &&
+		    (d->subsystem_device == q->subsystem_device ||
+		     q->subsystem_device == PCI_ANY_ID) &&
+		    !memcmp(q->sink_oui, ident->oui, sizeof(ident->oui)) &&
+		    (!memcmp(q->sink_device_id, ident->device_id,
+			    sizeof(ident->device_id)) ||
+		     mem_is_zero(q->sink_device_id, sizeof(q->sink_device_id))))
+			q->hook(intel_dp);
+	}
+}
+
 bool intel_has_quirk(struct intel_display *display, enum intel_quirk_id quirk)
 {
 	return display->quirks.mask & BIT(quirk);
 }
+
+bool intel_has_dpcd_quirk(struct intel_dp *intel_dp, enum intel_quirk_id quirk)
+{
+	return intel_dp->quirks.mask & BIT(quirk);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
index 151c8f4ae5760..c8db50b9ab74d 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.h
+++ b/drivers/gpu/drm/i915/display/intel_quirks.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 
 struct intel_display;
+struct intel_dp;
+struct drm_dp_dpcd_ident;
 
 enum intel_quirk_id {
 	QUIRK_BACKLIGHT_PRESENT,
@@ -20,6 +22,9 @@ enum intel_quirk_id {
 };
 
 void intel_init_quirks(struct intel_display *display);
+void intel_init_dpcd_quirks(struct intel_dp *intel_dp,
+			    const struct drm_dp_dpcd_ident *ident);
 bool intel_has_quirk(struct intel_display *display, enum intel_quirk_id quirk);
+bool intel_has_dpcd_quirk(struct intel_dp *intel_dp, enum intel_quirk_id quirk);
 
 #endif /* __INTEL_QUIRKS_H__ */
-- 
2.34.1


