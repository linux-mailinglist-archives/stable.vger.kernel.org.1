Return-Path: <stable+bounces-227297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPq6ChD/u2mzqwIAu9opvQ
	(envelope-from <stable+bounces-227297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:50:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792812CC317
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8265931763C8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2B2848AA;
	Thu, 19 Mar 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqvGhAU7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF132D9EF4
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928093; cv=none; b=fac6c/iCA2j6AXIAfSM1B5E2qUP9MxHKQiYVobWEQkhSDUJpwl6ckRjwrSozp6/HKpTj1dwsk3kP7E93nRfv0CH5bYPHaiDnGi2lCq7bx8or7oukEtUR5t5IZDQo3xHo10ZRyGrSCQrvWMeh/PN80GJbWyVkPUt4XhaMWbnYiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928093; c=relaxed/simple;
	bh=kGTFrOZ5+qiICdHanLTlxhEF0967iiIJaOafLzr16IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eT6bKcJU8dRz6XWReOzlaosQcM9QARF8CA93zRWTWPhiv1Ccb/joteooe0Dd3IHK2u4yQBpmnKk4l57tuGXupqnAYJlm7UtNOeBfSh0/ch5Gq7y4zStMv8CdOKpf6l5TD8g3ecij4fo1SUl7NYVMflEFZz0VBbgQtXShzozMXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqvGhAU7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773928091; x=1805464091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGTFrOZ5+qiICdHanLTlxhEF0967iiIJaOafLzr16IM=;
  b=nqvGhAU7YFj0Ej8kGI+qnw/LuZrjKw8HNMD5BDtgtz/O/fpDHGG82jTw
   57zF+H9dMNlgqPCmlw6uXmMI1+i8L44wp0NBPbCGouv4PCb/5sUPdgBB8
   N5nw5Xv4wEtEvMwauElrkK8KraJ9QmO8/nVdx5q8zYcueko4b5Gw9xfzO
   A3ngmngvVxR/LAEDbunC0+p6OeNl1MWDGshBlCRl8kolhvhcpnptLOWp/
   T7pVhTnKFpwySdcOhQOp2BppR84Q89QAKykPdhUu6IboE46LbgjFXNJTM
   N5PpKIRNwuCuOzUSP3GgQ8fIS8NuKO0Mltna5oOdJ2shlLaGMkTGsM7kH
   w==;
X-CSE-ConnectionGUID: EyoH4ebVT0GfSzfy4ct8cQ==
X-CSE-MsgGUID: dYzANxyoRGyqTJpWBdADAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85625249"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85625249"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 06:48:10 -0700
X-CSE-ConnectionGUID: QWPQmoOVTC+/JYJTixpydg==
X-CSE-MsgGUID: lFszw83VSwipNof9o27+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227090078"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.244.180])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 06:48:07 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.19.y 1/3] drm/i915/dsc: Add Selective Update register definitions
Date: Thu, 19 Mar 2026 15:47:50 +0200
Message-ID: <20260319134752.1355010-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026031712-strep-autopilot-0999@gregkh>
References: <2026031712-strep-autopilot-0999@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227297-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 792812CC317
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit c2c79c6d5b939ae8a42ddb884f576bddae685672 upstream.

Add definitions for DSC_SU_PARAMETER_SET_0_DSC0 and
DSC_SU_PARAMETER_SET_0_DSC1 registers. These are for Selective Update Early
Transport configuration.

Bspec: 71709
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Link: https://patch.msgid.link/20260304113011.626542-3-jouni.hogander@intel.com
(cherry picked from commit 24f96d903daf3dcf8fafe84d3d22b80ef47ba493)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
(cherry picked from commit c2c79c6d5b939ae8a42ddb884f576bddae685672)
---
 drivers/gpu/drm/i915/display/intel_vdsc_regs.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_vdsc_regs.h b/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
index 2d478a84b07c..2b2e3c1b8138 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_vdsc_regs.h
@@ -196,6 +196,18 @@
 #define   DSC_PPS18_NSL_BPG_OFFSET(offset)	REG_FIELD_PREP(DSC_PPS18_NSL_BPG_OFFSET_MASK, offset)
 #define   DSC_PPS18_SL_OFFSET_ADJ(offset)	REG_FIELD_PREP(DSC_PPS18_SL_OFFSET_ADJ_MASK, offset)
 
+#define _LNL_DSC0_SU_PARAMETER_SET_0_PA		0x78064
+#define _LNL_DSC1_SU_PARAMETER_SET_0_PA		0x78164
+#define _LNL_DSC0_SU_PARAMETER_SET_0_PB		0x78264
+#define _LNL_DSC1_SU_PARAMETER_SET_0_PB		0x78364
+#define LNL_DSC0_SU_PARAMETER_SET_0(pipe)	_MMIO_PIPE((pipe), _LNL_DSC0_SU_PARAMETER_SET_0_PA, _LNL_DSC0_SU_PARAMETER_SET_0_PB)
+#define LNL_DSC1_SU_PARAMETER_SET_0(pipe)	_MMIO_PIPE((pipe), _LNL_DSC1_SU_PARAMETER_SET_0_PA, _LNL_DSC1_SU_PARAMETER_SET_0_PB)
+
+#define   DSC_SUPS0_SU_SLICE_ROW_PER_FRAME_MASK		REG_GENMASK(31, 20)
+#define   DSC_SUPS0_SU_SLICE_ROW_PER_FRAME(rows)	REG_FIELD_PREP(DSC_SUPS0_SU_SLICE_ROW_PER_FRAME_MASK, (rows))
+#define   DSC_SUPS0_SU_PIC_HEIGHT_MASK			REG_GENMASK(15, 0)
+#define   DSC_SUPS0_SU_PIC_HEIGHT(h)			REG_FIELD_PREP(DSC_SUPS0_SU_PIC_HEIGHT_MASK, (h))
+
 /* Icelake Rate Control Buffer Threshold Registers */
 #define DSCA_RC_BUF_THRESH_0			_MMIO(0x6B230)
 #define DSCA_RC_BUF_THRESH_0_UDW		_MMIO(0x6B230 + 4)
-- 
2.43.0


