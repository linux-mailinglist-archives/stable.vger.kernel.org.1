Return-Path: <stable+bounces-268930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /Nj/OWmGPmodHgkAu9opvQ
	(envelope-from <stable+bounces-268930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:02:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026D6CDC6E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AjFzeoGA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268930-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268930-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B1330091CE
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D272E7372;
	Fri, 26 Jun 2026 14:02:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8892E1EE0
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 14:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482530; cv=none; b=C0XolvuLHjs6KlpDtj7/8Ka9o8O4Dcmgg/2skXIRAzCRHJAvPaX3YYjYKBeYhiUa07jBGM6RRyOQwSR2Xb6lejhnlCeWHds7ea8Qh8LfBlJv9EpOKKvNTQR2kCe7sqLVGQADA8vO1PFgP+Wp3weJyvVRz1axDd95ZAOBzVPmjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482530; c=relaxed/simple;
	bh=t+344il5kS+1UwLrPedrEucQtxevDKH1A2BfGnBb1lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmrmNtqQSMu4DaXaQHg/CiboN8zuoORXUnYFgR9DyRFHE+DHpmbvbFEFzZkzIz6wRKF2i6O2+iUjH5IluF3iLUMxHhegyATOfrg/o+uQ2cgGeI8WGxG2bNOjdZW42QAe3dmUkZ+EGVyf2YVYx6dOIrzJF1fXtonfT0t+ba5GQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjFzeoGA; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782482529; x=1814018529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t+344il5kS+1UwLrPedrEucQtxevDKH1A2BfGnBb1lw=;
  b=AjFzeoGAM2ALF7fKvvZK1o498PwICmmgTS2bUWfUQuefwb64C/aYh2xr
   +xbRELCQTwPThcVqb8CEddkFPx7KHmr+8hxbUzJyE8Dm/9pwAYFJUo3KR
   LuKk5OhW6pAEHAdcFIu/Fuk5fvn8w5oHvBxM1KgmRKBf8sSe8vXOkdOym
   qBYb40NVQEgzH/AOrkngxdAAIMq/oI2vfGgA48V0Fk50mRfzBobhTk/z6
   8oo8iRi8BnLIDaxYQPTC6tnDpCvjIPN45+H+hHJkPfFRUuyZZxxJngYg2
   27mQBFOEU+kz1V2iHLWkA7h7FMKSyUiuVKh4wGyoRJI0JXz4IILRIwQ7H
   w==;
X-CSE-ConnectionGUID: 9PkAeMI5RGiXQKsLIxjpew==
X-CSE-MsgGUID: G642qIMWRfmTf7erCN1ypg==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="100823943"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="100823943"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:02:08 -0700
X-CSE-ConnectionGUID: LfcSOjl3Rm+NdrhZBErWOQ==
X-CSE-MsgGUID: 6cZ9xckeTgiQ7DWuFsBjRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="249666229"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 07:02:06 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Martin Hodo <martin.hodo@intel.com>,
	stable@vger.kernel.org,
	Animesh Manna <animesh.manna@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
Subject: [PATCH v2] drm/i915/bios: range check LFP Data Block panel_type2
Date: Fri, 26 Jun 2026 17:01:55 +0300
Message-ID: <20260626140155.1389655-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625135130.1067872-1-jani.nikula@intel.com>
References: <20260625135130.1067872-1-jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268930-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@intel.com,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:martin.hodo@intel.com,m:stable@vger.kernel.org,m:animesh.manna@intel.com,m:ville.syrjala@intel.com,m:michal.grzelak@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1026D6CDC6E

While the panel_type from LFP Data Block is range checked, panel_type2
is not. Add a few helpers for range checking, and use them to not only
check panel_type2, but also improve clarity and correctness in the panel
type selection.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

v2:
- Fix commit message typo (Michał)
- Add is_panel_type_pnp() (Ville)

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: 6434cf630086 ("drm/i915/bios: calculate panel type as per child device index in VBT")
Cc: <stable@vger.kernel.org> # v6.0+
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Ville Syrjälä <ville.syrjala@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com> # v1
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c | 36 ++++++++++++++++++-----
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 15ebadc72b88..97cbae2e547e 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -623,6 +623,21 @@ get_lfp_data_tail(const struct bdb_lfp_data *data,
 		return NULL;
 }
 
+static bool is_panel_type_valid(int panel_type)
+{
+	return panel_type >= 0 && panel_type < 16;
+}
+
+static bool is_panel_type_pnp(int panel_type)
+{
+	return panel_type == 0xff;
+}
+
+static bool is_panel_type_valid_or_pnp(int panel_type)
+{
+	return is_panel_type_valid(panel_type) || is_panel_type_pnp(panel_type);
+}
+
 static int opregion_get_panel_type(struct intel_display *display,
 				   const struct intel_bios_encoder_data *devdata,
 				   const struct drm_edid *drm_edid, bool use_fallback)
@@ -640,15 +655,21 @@ static int vbt_get_panel_type(struct intel_display *display,
 	if (!lfp_options)
 		return -1;
 
-	if (lfp_options->panel_type > 0xf &&
-	    lfp_options->panel_type != 0xff) {
+	if (!is_panel_type_valid_or_pnp(lfp_options->panel_type)) {
 		drm_dbg_kms(display->drm, "Invalid VBT panel type 0x%x\n",
 			    lfp_options->panel_type);
 		return -1;
 	}
 
-	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2)
+	if (devdata && devdata->child.handle == DEVICE_HANDLE_LFP2) {
+		if (!is_panel_type_valid_or_pnp(lfp_options->panel_type2)) {
+			drm_dbg_kms(display->drm, "Invalid VBT panel type 2 0x%x\n",
+				    lfp_options->panel_type2);
+			return -1;
+		}
+
 		return lfp_options->panel_type2;
+	}
 
 	drm_WARN_ON(display->drm,
 		    devdata && devdata->child.handle != DEVICE_HANDLE_LFP1);
@@ -762,13 +783,12 @@ static int get_panel_type(struct intel_display *display,
 				    panel_types[i].name, panel_types[i].panel_type);
 	}
 
-	if (panel_types[PANEL_TYPE_OPREGION].panel_type >= 0)
+	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
 		i = PANEL_TYPE_OPREGION;
-	else if (panel_types[PANEL_TYPE_VBT].panel_type == 0xff &&
-		 panel_types[PANEL_TYPE_PNPID].panel_type >= 0)
+	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
+		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
 		i = PANEL_TYPE_PNPID;
-	else if (panel_types[PANEL_TYPE_VBT].panel_type != 0xff &&
-		 panel_types[PANEL_TYPE_VBT].panel_type >= 0)
+	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
 		i = PANEL_TYPE_VBT;
 	else
 		i = PANEL_TYPE_FALLBACK;
-- 
2.47.3


