Return-Path: <stable+bounces-223371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOiJL0oPq2n1ZgEAu9opvQ
	(envelope-from <stable+bounces-223371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:30:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F94122633F
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 143C7322FE79
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17822347513;
	Fri,  6 Mar 2026 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxZhJMEp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDD3431FD
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817540; cv=none; b=IboweRp+kJt7edtbelwM5Sh/cTJgskJvvk29L24q4+QXlO6VnKOsItQT6i610ReYiTVqYIu49i2PX8NXzBg5ZvVTn0QwAgKw9mq8oOK+k7fH1RCi9IG9/mi0ufCABagQjgYLUXRoX2298cpoMJGZf8zhKOAyRHCtvC5h32s7SD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817540; c=relaxed/simple;
	bh=7d8ZsppGrUYbiMTl1HbrFV4tmhaJ1EWMYXz0WpUC3Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8gtWifxWgMvRZQ0Xp8iwrFnSygvSnX7ajLdpgBE9tHAsZ8QXbqtoQbOTA3Q/XiLfg3einB+n83r4Q9XDFzoZKS/9TW/OQrxR8CHJA+hT/QZpy7NWPY8Llf+4GXJxPNgJbRP+icDt31c+b++3R0AOz1bJF01uxxF4pOMN8BeLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxZhJMEp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772817539; x=1804353539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7d8ZsppGrUYbiMTl1HbrFV4tmhaJ1EWMYXz0WpUC3Ps=;
  b=GxZhJMEpoavbWqH2qwXxbsBr9/AV99F85ugVACKZHp0nWBrVs2Tx23Pm
   A2KbIAVgZgSeEcXQnPB63dOKV+SGDbfR8P6osHX2hnwblOkZS0vYdkrP1
   lTwnxOC8k7zwavaSU1hGeSq6v1Jhch50aMOcT5WRvIf8mqDv7UGxDZwfg
   FGQMy4Fe0Vy7JjjeagGBCGgS6tQ2oh/AS+l3SxyrrCusa+3DrhOdiYuoG
   lJXqDRP9oSa482Su8ne1827mrH+XJ9rXOWRcKu19A2zl+wSKvExEZuJpH
   stLxV4P6utOLFb0euGAEsufq+9PY3ycrzrAsphx+xxv2h789nSik+K2N8
   Q==;
X-CSE-ConnectionGUID: 0gb61NbzQ9Kf5x0AtBJMzQ==
X-CSE-MsgGUID: RXX5YAgARNmy9IT96AgFMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="77530853"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="77530853"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 09:18:59 -0800
X-CSE-ConnectionGUID: Qb16sJnCSnilhro0Ahw4lg==
X-CSE-MsgGUID: APgppG4uRQOhPL6dslL4rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="216175186"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa010.fm.intel.com with ESMTP; 06 Mar 2026 09:18:54 -0800
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	louis.chauvet@bootlin.com,
	mwen@igalia.com,
	contact@emersion.fr,
	alex.hung@amd.com,
	daniels@collabora.com,
	uma.shankar@intel.com,
	maarten.lankhorst@intel.com,
	pekka.paalanen@collabora.com,
	pranay.samala@intel.com,
	swati2.sharma@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 05/10] drm/i915/color: Fix HDR pre-CSC LUT programming loop
Date: Fri,  6 Mar 2026 22:23:02 +0530
Message-Id: <20260306165307.3233194-6-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260306165307.3233194-1-chaitanya.kumar.borah@intel.com>
References: <20260306165307.3233194-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F94122633F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223371-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[chaitanya.kumar.borah@intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.986];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Pranay Samala <pranay.samala@intel.com>

The integer lut programming loop never executes completely due to
incorrect condition (i++ > 130).

Fix to properly program 129th+ entries for values > 1.0.

Cc: <stable@vger.kernel.org> #v6.19
Fixes: 82caa1c8813f ("drm/i915/color: Program Pre-CSC registers")
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index e7950655434b..6d1cffc6d2be 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3976,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
 						   (1 << 24));
-			} while (i++ > 130);
+			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
 				u32 v = (i * ((1 << 24) - 1)) / (lut_size - 1);
-- 
2.25.1


