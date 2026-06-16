Return-Path: <stable+bounces-264188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BM4nLotyMWpYjgUAu9opvQ
	(envelope-from <stable+bounces-264188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B166069191B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fsX1Bfga;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264188-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264188-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 209153040A97
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B247276B;
	Tue, 16 Jun 2026 15:43:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197744657CD;
	Tue, 16 Jun 2026 15:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624597; cv=none; b=gtXMVI8JLOkGuspO7eKgN6P1ACzzj/llgKVBQYezEhR6VEip9DGtI6RkSbbEm+aexX9/pPkxZ3BfKWOsKUjdLujD01U550RtpuUk0L4JJDuY3xamW0FMQBt7EYV+rtAZl0cm7qEPnEMMyjl/L4wFDx/ZXYKscvi7JMoOZwqq8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624597; c=relaxed/simple;
	bh=jyPG1sOb0OjFvDBIoG9JFQTGJTDGKdwgb6YaSKyOrFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+ukI3zfX6gm7k+WSbLTueKDrDS9pzBKVDtuass4xGI8PM3TNtO+8T5gZJ+G5kMhlu4etpZUpp6XyIPE+3TEuZcfWkkfde5JzCPTSNf/yh3o4v9JJVDSeem+yV7knFM0zyJDANzaV/8r3tYRNCEP3jvlz9camoqbXlJcQmOR1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fsX1Bfga; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B31F000E9;
	Tue, 16 Jun 2026 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624595;
	bh=/1bpUiurgqfmOKKo+4wLJsv0Kpc4kaat9FVchQv1gXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fsX1BfgaYas4Nd/evmY+lMI28Q2gDNPSyOXOUsG/oJ9QWSz4nxsXwDYcSoMSM4TLK
	 t5Qw5uOrkFR2JPkKmZFHNsQSLJqPbsIEmrUbeqsiWhuXFRjS7vqW7ACTSzkW82Cp4Z
	 hjnaZttjduErs7dMeITTf0oeML/9D3aOeKACuzU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH 7.0 337/378] drm/xe/display: fix oops in suspend/shutdown without display
Date: Tue, 16 Jun 2026 20:29:28 +0530
Message-ID: <20260616145127.946309641@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:suraj.kandpal@intel.com,m:jani.nikula@intel.com,m:matthew.brost@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,gitlab.freedesktop.org:url,vger.kernel.org:from_smtp,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B166069191B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit 68938cc08e23a94fd881e845837ff918de005ce7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/display/xe_display.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -119,6 +119,15 @@ int xe_display_init_early(struct xe_devi
 
 	intel_display_driver_early_probe(display);
 
+	intel_display_device_info_runtime_init(display);
+
+	/* Display may have been disabled at runtime init */
+	if (!intel_display_device_present(display)) {
+		xe->info.probe_display = false;
+		unset_display_features(xe);
+		return 0;
+	}
+
 	/* Early display init.. */
 	intel_opregion_setup(display);
 
@@ -132,8 +141,6 @@ int xe_display_init_early(struct xe_devi
 
 	intel_bw_init_hw(display);
 
-	intel_display_device_info_runtime_init(display);
-
 	err = intel_display_driver_probe_noirq(display);
 	if (err)
 		goto err_opregion;



