Return-Path: <stable+bounces-88002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C29ADA9B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B93B21ECD
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFE170A3A;
	Thu, 24 Oct 2024 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvXLUWLA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F1714A9
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741148; cv=none; b=Kh8UVHN9/apg6OZszzvkpjLRxUlH9kY85wBkysG5AE6rTXTIHpi80UZvbhQks3YgEvvvyJM+4+hA52PhlFmRwKolnU+U4PCmOh0nr8ZZjKLssB2ogT7zT44NE30BgbsPeXl/8JscXslDjsU+k4zRgW+ck9VN7DzaFUSZq+z1V5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741148; c=relaxed/simple;
	bh=btr/VNZllvPL4w7AgrlLYAqme/sdwbAPawnTi3HC3V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=begJCzvIfNd8HU4BucKUmOYx47U+6Qwa1sAI3G3z07jg7YAbJlKbwi4AQ3suem5Tjxx783Bs8JiTmixoQgxksT8bsw1EvFQoOc0WI2ZheHqLdpCiB4c0FaqbcsQhl3d7H/dDdys5jyFYRqAHX+CsECBPxDGGPa5gXPaCDNUvOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvXLUWLA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741147; x=1761277147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btr/VNZllvPL4w7AgrlLYAqme/sdwbAPawnTi3HC3V0=;
  b=GvXLUWLAQyqfZpg1nPTEuvdnpHkyaPRHZUcMb99nn+9ktLmm4yy1YSBb
   wH4qE6FS5poAXMhFYSZ8Md2V0FTVNxQLsqLQD2fQDlEleUZxxgm1yd5PO
   mXo6EAD2QVUk1YzS+m/eHmILnTQQg8btkvZwoFL11VEcTAX6mm58S/t0h
   v/vFGAEPgd+Vz5eIlebqXOdhuygs1Uu4nmY/In+JT5ovkbeLp5h4ScKMj
   K8H9L6//8pybbaTUbHdGrfv7eaWpu4/KGc5uXQQAUwj7SFxOIlJHZKW+2
   gE5mN1U0UbnQU51QdtJQ4hTLXxdfo/N1AAUE8UN0zJqxW3Zw7KJD9+UpE
   Q==;
X-CSE-ConnectionGUID: JEqnx/7qR6OJzZlmVmzZbg==
X-CSE-MsgGUID: ceYLrPvTS3a8DgRzIn2vjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265009"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265009"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:54 -0700
X-CSE-ConnectionGUID: csWfoVDHRP60OeiExDfChg==
X-CSE-MsgGUID: fcZGknPnQBifq21SjhC9hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384992"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 19/22] drm/xe/xe2: Introduce performance changes
Date: Wed, 23 Oct 2024 20:38:11 -0700
Message-ID: <20241024033815.3538736-19-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akshata Jahagirdar <akshata.jahagirdar@intel.com>

commit 2009e808bc3e0df6d4d83e2271bc25ae63a4ac05 upstream.

Add Compression Performance Improvement Changes in Xe2

v2: Rebase

v3: Rebase, updated as per latest changes on bspec,
    Removed unnecessary default actions (Matt)
    formatting nits (Tejas)

v4: Formatting nits, removed default set action for bit 14 (Matt)

Bspec: 72161
Signed-off-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/c2dd753fdc55df6a6432026f2df9c2684a0d25c1.1722607628.git.akshata.jahagirdar@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 3 +++
 drivers/gpu/drm/xe/xe_tuning.c       | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index 0168070d1b580..5155f2744fd3b 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -366,6 +366,9 @@
 #define XEHP_L3NODEARBCFG			XE_REG_MCR(0xb0b4)
 #define   XEHP_LNESPARE				REG_BIT(19)
 
+#define L3SQCREG2				XE_REG_MCR(0xb104)
+#define   COMPMEMRD256BOVRFETCHEN		REG_BIT(20)
+
 #define L3SQCREG3				XE_REG_MCR(0xb108)
 #define   COMPPWOVERFETCHEN			REG_BIT(28)
 
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index 77d4eec0118d4..3817b7743b0ca 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -45,6 +45,11 @@ static const struct xe_rtp_entry_sr gt_tunings[] = {
 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
 	  XE_RTP_ACTIONS(SET(L3SQCREG3, COMPPWOVERFETCHEN))
 	},
+	{ XE_RTP_NAME("Tuning: L2 Overfetch Compressible Only"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED)),
+	  XE_RTP_ACTIONS(SET(L3SQCREG2,
+			     COMPMEMRD256BOVRFETCHEN))
+	},
 	{}
 };
 
-- 
2.47.0


