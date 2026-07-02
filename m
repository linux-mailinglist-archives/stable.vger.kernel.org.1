Return-Path: <stable+bounces-270924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B0S2Df6TRmrAYwsAu9opvQ
	(envelope-from <stable+bounces-270924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:38:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 707286FA507
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:38:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="l/GAOHyK";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270924-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270924-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 768D73022DD8
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB533A9DB;
	Thu,  2 Jul 2026 16:36:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B12D8DC4;
	Thu,  2 Jul 2026 16:36:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010207; cv=none; b=FFjHO/h+4Fcve43pKiYdt9Fh0yz3yRBQZ1zoTE9FQ0jqy+4CGpKCCp/+gCJaE5n2RYE8AknAXr2a81Q1l3fSCpdW5qz9Q/ybKo7zC+JvrrYQr80W+uI9ymRmXc85D/BeCkWxl81GzoGwyDjrYJFg++zW9kjWagPuhhj36hjb0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010207; c=relaxed/simple;
	bh=doVSSwEjTxwaNB08KcFVBTqe7iaQ8GiJiIJRYduLMGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAxxXik9P5JW6nUiXgE8w4WTjjhlYtfxehKJcTshX9C7UEVJ791AQc+gXPFzGj79yDKRJiCXGEGL2lDyzNvAt7o2lFLWVIsHdekHwA2yZjdIVCSM3F+ZS7SvorB50RU52mnkiwuYqEGmljtonYfZmG57+ldkNBqqW0zPDDYQb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/GAOHyK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05AA1F000E9;
	Thu,  2 Jul 2026 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010206;
	bh=q0CWFkEJJ1W0JS6tFcRsCZ7zq1COv3p/utzFsNpvmpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/GAOHyKFouPMKZXIVls715MZDXhf5YdCcrQfJWBsXH/imEnlf2HKRilc4OMIbI/R
	 5LXRg8EqunMV6Uxwn1AqCy2R9SSP//ko7x7qJVOGTUTqCxviZF+ycQ7vMfJ2+3XT2y
	 AxVhOI3A1TbTLa2nCVPKALCxC/tL/4i9RztM/44s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 009/204] drm/xe/display: fix oops in suspend/shutdown without display
Date: Thu,  2 Jul 2026 18:17:46 +0200
Message-ID: <20260702155118.865170211@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270924-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:suraj.kandpal@intel.com,m:jani.nikula@intel.com,m:matthew.brost@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,gitlab.freedesktop.org:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 707286FA507

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 68938cc08e23a94fd881e845837ff918de005ce7 ]

The xe driver keeps track of whether to probe display, and whether
display hardware is there, using xe->info.probe_display. It gets set to
false if there's no display after intel_display_device_probe(). However,
the display may also be disabled via fuses, detected at a later time in
intel_display_device_info_runtime_init().

In this case, the xe driver does for_each_intel_crtc() on uninitialized
mode config in xe_display_flush_cleanup_work(), leading to a NULL
pointer dereference, and generally calls display code with display info
cleared.

Check for intel_display_device_present() after
intel_display_device_info_runtime_init(), and reset
xe->info.probe_display as necessary. Also do unset_display_features()
for completeness, although display runtime init has already done
that. This will need to be unified across all cases later.

Move intel_display_device_info_runtime_init() call slightly earlier,
similar to i915, to avoid a bunch of unnecessary setup for no display
cases.

Note #1: The xe driver has no business doing low level display plumbing
like for_each_intel_crtc() to begin with. It all needs to happen in
display code.

Note #2: The actual bug is present already in commit 44e694958b95
("drm/xe/display: Implement display support"), but the oops was likely
introduced later at commit ddf6492e0e50 ("drm/xe/display: Make display
suspend/resume work on discrete").

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7904
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/6150
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515160920.1082842-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 7c3eb9f47533220888a67266448185fd0775d4da)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_display.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index e164e2d71e1157..de1fd4dff0e869 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -148,6 +148,15 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_display_driver_early_probe(xe);
 
+	intel_display_device_info_runtime_init(xe);
+
+	/* Display may have been disabled at runtime init */
+	if (!has_display(xe)) {
+		xe->info.probe_display = false;
+		unset_display_features(xe);
+		return 0;
+	}
+
 	/* Early display init.. */
 	intel_opregion_setup(display);
 
@@ -159,8 +168,6 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_bw_init_hw(xe);
 
-	intel_display_device_info_runtime_init(xe);
-
 	err = intel_display_driver_probe_noirq(xe);
 	if (err) {
 		intel_opregion_cleanup(display);
-- 
2.53.0




