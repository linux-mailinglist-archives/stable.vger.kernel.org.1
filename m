Return-Path: <stable+bounces-227069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNKKJpOnumlpaQIAu9opvQ
	(envelope-from <stable+bounces-227069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:24:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F35362BC157
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BE3430107BA
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5753D3480;
	Wed, 18 Mar 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtYdVIIq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43023A7F6C
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840272; cv=none; b=fjxxIlOmaBb0NEmPA798DQ8zSsVrKsDS7ZkhgFYTZruvKwI6vDBL7wVZJ3MTTMguxoHjjLETLzmwH3aqN5LRomY5RGKbIh/ilXIpH0o+eRCzFCn/TM9i30l4cYN3VbDO8IGhxLBBbWK0ksxKSlWN3OMVmYtFGMTEEEmnnmd5A64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840272; c=relaxed/simple;
	bh=kGTFrOZ5+qiICdHanLTlxhEF0967iiIJaOafLzr16IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbo7rp6AeVFLX51eB1e8S7EI/vQTOcUrA/n67Dng8uzD5vBiTmbVFHOTgqs+LVleE+cQ2XbwseehNVtNInkIaPpBNIOshq4MIKsO5g1EAuWFd/gHfdRIYG89yM0l8Ata+Y5+nZfcTRNbs/Z9GAiBNCetQvFye+FN7fr3XYKrV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtYdVIIq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773840271; x=1805376271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGTFrOZ5+qiICdHanLTlxhEF0967iiIJaOafLzr16IM=;
  b=KtYdVIIqOFvlUMme5NgzXczc/FHR6JsmuA9Yv94xM6cKXGhWhBOdgy2O
   c2Hu5f9bf8jM1jFpC6NmcrtJJXOcpeVC9QNJ/G7rUyd1RF6/a8qI/2adp
   Dh7Ep6nRkBQSfJ26niO84TksrY/i2iXePOuKKwad0OB1h4um2P9hxBWcv
   kluyQ7HqmGoVuTZ6xdy8rl9BLXGFZae/0yYETBXZRCw2jCDQHHJK4v8wu
   2DjP5ejKEZtCcpLeFLGPEeL+khaJCoTEot8LH8gu2osVEl6S3uwdrnayc
   5k3QLJyuYBI/AoQaSOGREBzs1yuwRVK6uZhqFcT7gK2kwEg0JjKt3nzIM
   Q==;
X-CSE-ConnectionGUID: TbzxkRC0RiG/vU1XNxA+6w==
X-CSE-MsgGUID: LO3BwkCwSbmeLw8SUCqh5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73910855"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="73910855"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:24:30 -0700
X-CSE-ConnectionGUID: xrPGTcFMQBishZIqryaaVA==
X-CSE-MsgGUID: culWRSVLScmbZsDNC6ploA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221850373"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.220])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 06:24:29 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.18.y 1/3] drm/i915/dsc: Add Selective Update register definitions
Date: Wed, 18 Mar 2026 15:24:10 +0200
Message-ID: <20260318132412.1117060-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026031759-ravine-derived-5582@gregkh>
References: <2026031759-ravine-derived-5582@gregkh>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227069-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,ursulin.net:email]
X-Rspamd-Queue-Id: F35362BC157
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


