Return-Path: <stable+bounces-222874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HfONwjapmmfXwAAu9opvQ
	(envelope-from <stable+bounces-222874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:54:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A791EFC29
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C478302330C
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7035DA71;
	Tue,  3 Mar 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaRZj+J6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32334CFCD
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542470; cv=none; b=QedvbfVpscfwNrtXCGsJGh2HcZVAJCcxn4zKaF3wLuvqPF3IMYCN1y7bj3qZePfM1YTINgX/cETug5gO06AHJ1pttNdnlkyaVpPlm33StZVEPx4jRXY7176SJjmP05j/haWgJVqG0J9zLmrNnVwaLuoyoVqSwJFagim55j5cpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542470; c=relaxed/simple;
	bh=3b3P1T/Y4vDyVuyNHgJGmaERiDYq0CEjgJ+mNM5MDCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OghfuVxUBBLSEfg9fykyMzSWKSduldSQCIp9HYrnxQBCCEELOKolmlQqyGk6j2tGwshIP0AsqQRI1+08qTm6jFCgf/xZdFU1qTbLAZsPBxvnN9gYQcz6dCGFOT+2v8W9P2XVWHXqyplIKxij/BGlaDG3KfJUmvo/5XZfd4VLsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaRZj+J6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772542469; x=1804078469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3b3P1T/Y4vDyVuyNHgJGmaERiDYq0CEjgJ+mNM5MDCY=;
  b=XaRZj+J6g7GVPUCintc/wX8E/iJAxc3AJDK6Ir2zQT4QbkhlxvPcbB7y
   7L3vQLMuNQKLWcrqNrgWKqWC5N9aAAiskRxFFAgu3NcPRP64AOhGoGi4G
   hHlDsAlX8ypo0tZHolQRUv3m8QVcFJ1GQcIKUKnqha8uNqtxz164jgPi1
   B1LY7PcZVNG1bxnLFadvBa/Gd4L8cKm5VDRUaB7Et/27G2HaB1FzSygv+
   o4UncAUmYngaQeHQQ04It04JWpoMVVMWNujEd5038w+Bg33vfHuGRW+sA
   SCP13O8VaZlw81wnKkBCKmTXFahSkMyhp+Xw4q/9b4V0CKY22h/DiM9Mv
   Q==;
X-CSE-ConnectionGUID: 2Yl7r9inSJSlk2yeHCPr6w==
X-CSE-MsgGUID: LwfxyRNuRPOoK79Guq455Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77421871"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77421871"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:54:29 -0800
X-CSE-ConnectionGUID: LA/16VF6S5yH4VnsP3fXZw==
X-CSE-MsgGUID: deMKW2pMSJmIOph7YTUjnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="222651984"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.245.74])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:54:26 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] drm/i915/psr: Write DSC parameters on Selective Update in ET mode
Date: Tue,  3 Mar 2026 14:54:09 +0200
Message-ID: <20260303125409.503148-5-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303125409.503148-1-jouni.hogander@intel.com>
References: <20260303125409.503148-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50A791EFC29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222874-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jouni.hogander@intel.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

There are slice row per frame and pic height parameters in DSC that needs
to be configured on every Selective Update in Early Transport mode. Use
helper provided by DSC code to configure these on Selective Update when in
Early Transport mode. Also fill crtc_state->psr2_su_area with full frame
area on full frame update for DSC calculation.

Bspec: 68927, 71709
Fixes: 467e4e061c44 ("drm/i915/psr: Enable psr2 early transport as possible")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 7b197e84e77d..adcfd3dd8f20 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2618,6 +2618,12 @@ void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
 
 	intel_de_write_dsb(display, dsb, PIPE_SRCSZ_ERLY_TPT(crtc->pipe),
 			   crtc_state->pipe_srcsz_early_tpt);
+
+	if (!crtc_state->dsc.compression_enable)
+		return;
+
+	intel_dsc_su_et_parameters_configure(dsb, encoder, crtc_state,
+					     drm_rect_height(&crtc_state->psr2_su_area));
 }
 
 static void psr2_man_trk_ctl_calc(struct intel_crtc_state *crtc_state,
@@ -2945,8 +2951,11 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		full_update = true;
 	}
 
-	if (full_update)
+	if (full_update) {
+		clip_area_update(&crtc_state->psr2_su_area, &crtc_state->pipe_src,
+				 &crtc_state->pipe_src);
 		goto skip_sel_fetch_set_loop;
+	}
 
 	intel_psr_apply_su_area_workarounds(crtc_state);
 
-- 
2.43.0


