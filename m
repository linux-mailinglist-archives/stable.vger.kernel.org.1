Return-Path: <stable+bounces-87997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06449ADA95
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EE82832E4
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79C170A0B;
	Thu, 24 Oct 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8fBuLs6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32FC16EC19
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741146; cv=none; b=GRACWe6/J3bnOytN6uajj8ZJVuPSoC3DH0bTocIRvtSQ15qXwVjrGCILzwJuX6yom3YedSFKI5znL3rgAPWWMtOS0HFjiQRLOZ61kK2amUNK+6SUbFjjhT5RIcZWK6SoOIEHZzH4Hky7vq7v2WZrwvXUxQy6Faos1bmfBHgLxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741146; c=relaxed/simple;
	bh=m0X/CFqiZjfYdOpR1EEGTYr64I65rSP05ubZhF8Hhv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjVSoOpkIMEquNGFpS9g6JIm+h4oB4hW8QeYAe5PnfkqqUR6tlPUtvGQId/RuFnxPvY9vBHes2I5CR0gQ4m15CQysy1XJRzwiwRW9IxO8R/ALcnnY/UFpz9sEi1UkWn2GNw7IzXPL5CdqxrZfyNaFXEs+FpzXT7oRvYQ0+wfNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8fBuLs6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741144; x=1761277144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m0X/CFqiZjfYdOpR1EEGTYr64I65rSP05ubZhF8Hhv4=;
  b=W8fBuLs6VAumfzrBv/6fSZFY4Ro7JxcNb/3tIJKiZlFMTZ4iOKag+BHg
   LhkYD1N3+ISkWS2yR6dUnWFCCRUKlZEcJ5H92c/p33ld6uJmzT/wR+XTm
   9w2iMdX54emYr+711D9I++P9tsG2u1utrh7/tHU/ycAUYDP6o3pvFWH36
   l3GSfOZiXWAsha2nlpGGr1J7sYD92lsrjaJW4Z7kv/t/wC8eK15v4a+cc
   UjDRNxmWjJ6LmRrwmKN8x9htnhbtIwGZiXpfX2R4X9u23UGHKIcdtTDSR
   gq5okUKVKgd77xHnrXWQD+yFzhxoq2RQA+Z1mZRziX1pmRWgMcaocaEyL
   g==;
X-CSE-ConnectionGUID: OkcRcq8pSdunoKl7x3QyUg==
X-CSE-MsgGUID: 1yFrjl15RfCp5hZZC43uYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265004"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265004"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: XyvKsARMRJm7e5MVxRqJEQ==
X-CSE-MsgGUID: JxzqspUwSbeMGxORfN5e7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384989"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 18/22] drm/xe/xe2hpg: Introduce performance tuning changes for Xe2_HPG
Date: Wed, 23 Oct 2024 20:38:10 -0700
Message-ID: <20241024033815.3538736-18-lucas.demarchi@intel.com>
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

From: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>

commit e4ac526c440af8aa94d2bdfe6066339dd93b4db2 upstream.

Add performance tuning changes for Xe2_HPG

Bspec: 72161
Signed-off-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240724121521.2347524-1-sai.teja.pottumuttu@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/regs/xe_gt_regs.h | 1 +
 drivers/gpu/drm/xe/xe_tuning.c       | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/xe/regs/xe_gt_regs.h b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
index a4ee6b579f132..0168070d1b580 100644
--- a/drivers/gpu/drm/xe/regs/xe_gt_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_gt_regs.h
@@ -107,6 +107,7 @@
 
 #define FF_MODE					XE_REG_MCR(0x6210)
 #define   DIS_TE_AUTOSTRIP			REG_BIT(31)
+#define   VS_HIT_MAX_VALUE_MASK			REG_GENMASK(25, 20)
 #define   DIS_MESH_PARTIAL_AUTOSTRIP		REG_BIT(16)
 #define   DIS_MESH_AUTOSTRIP			REG_BIT(15)
 
diff --git a/drivers/gpu/drm/xe/xe_tuning.c b/drivers/gpu/drm/xe/xe_tuning.c
index d4e6fa918942b..77d4eec0118d4 100644
--- a/drivers/gpu/drm/xe/xe_tuning.c
+++ b/drivers/gpu/drm/xe/xe_tuning.c
@@ -93,6 +93,14 @@ static const struct xe_rtp_entry_sr lrc_tunings[] = {
 				   REG_FIELD_PREP(L3_PWM_TIMER_INIT_VAL_MASK, 0x7f)))
 	},
 
+	/* Xe2_HPG */
+
+	{ XE_RTP_NAME("Tuning: vs hit max value"),
+	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(FIELD_SET(FF_MODE, VS_HIT_MAX_VALUE_MASK,
+				   REG_FIELD_PREP(VS_HIT_MAX_VALUE_MASK, 0x3f)))
+	},
+
 	{}
 };
 
-- 
2.47.0


