Return-Path: <stable+bounces-264267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SABEAnd1MWpnjwUAu9opvQ
	(envelope-from <stable+bounces-264267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:10:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A38691C37
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CDRGtg3d;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264267-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264267-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7605303E218
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2244BCB8;
	Tue, 16 Jun 2026 15:50:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46E449EB0;
	Tue, 16 Jun 2026 15:50:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625055; cv=none; b=kBbJla29x7rup+seYDuTsVDROazRTVjHx5KlDo7B1uGpAgrphiZbMUSZXxYwfuN4bh3mC1fpQIbk3I4ls766iZtDZOmEhvq8GlITVy3rwe3k4NC/Wfh4uOSlaeK51haLl1E/+iomOGlFhGv5xO5wQojE7avnWgz8MTG/ycuUuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625055; c=relaxed/simple;
	bh=pxmqYORY+I8GmPAeKK9V3UgyznlTk11ltAC4RKW55Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wydoip6oS9/yoQIi+G0h+bjspma4I+PPD4N0nFd/7atifqn8NZldTmQc2O6Zf0/2IN0d00Bped3YofGKrd4cfKZnCyjlzYlWXotv/1i9wjvG2tseK1uFGL4ONd6sy21IFvCSdW7kHl95kStxqeD/SZodkmuBUJZIuuMsdVoglJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CDRGtg3d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DD11F000E9;
	Tue, 16 Jun 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625054;
	bh=Oic3JAdvC9m4muvosgt3gCyCTkCdz3FYRVFLPGgrdzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDRGtg3dluVO14lNjhL9Qu2Y6Vhd1E3fblF+5QvZbCGPX9J3v8yHwsAyCWk32WuGG
	 F6Jnul1nczQ8llqWSRLFxUb4Jr4U3tPtm8AC+P3WN8A+MDZGiv2BnlEw6B1KIF2E8b
	 OWfzyVl+6ehHzcRNZdCKx+G53+vo6Ikfqgt/yB1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 070/325] drm/hyperv: During panic do VMBus unload after frame buffer is flushed
Date: Tue, 16 Jun 2026 20:27:46 +0530
Message-ID: <20260616145101.197973473@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264267-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhklinux@outlook.com,m:jfalempe@redhat.com,m:wei.liu@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06A38691C37

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 8b35874f56ded0cc1a90a25b87411249a86246cd ]

In a VM, Linux panic information (reason for the panic, stack trace,
etc.) may be written to a serial console and/or a virtual frame buffer
for a graphics console. The latter may need to be flushed back to the
host hypervisor for display.

The current Hyper-V DRM driver for the frame buffer does the flushing
*after* the VMBus connection has been unloaded, such that panic messages
are not displayed on the graphics console. A user with a Hyper-V graphics
console is left with just a hung empty screen after a panic. The enhanced
control that DRM provides over the panic display in the graphics console
is similarly non-functional.

Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added
the Hyper-V DRM driver support to flush the virtual frame buffer. It
provided necessary functionality but did not handle the sequencing
problem with VMBus unload.

Fix the full problem by using VMBus functions to suppress the VMBus
unload that is normally done by the VMBus driver in the panic path. Then
after the frame buffer has been flushed, do the VMBus unload so that a
kdump kernel can start cleanly. As expected, CONFIG_DRM_PANIC must be
selected for these changes to have effect. As a side benefit, the
enhanced features of the DRM panic path are also functional.

Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  5 +++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 0d49f168a919d5..dad8fd5cb1d3b6 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -149,6 +149,10 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 		goto err_free_mmio;
 	}
 
+	/* If DRM panic path is stubbed out VMBus code must do the unload */
+	if (IS_ENABLED(CONFIG_DRM_PANIC))
+		vmbus_set_skip_unload(true);
+
 	drm_client_setup(dev, NULL);
 
 	return 0;
@@ -168,6 +172,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
 	struct drm_device *dev = hv_get_drvdata(hdev);
 	struct hyperv_drm_device *hv = to_hv(dev);
 
+	vmbus_set_skip_unload(false);
 	drm_dev_unplug(dev);
 	drm_atomic_helper_shutdown(dev);
 	vmbus_close(hdev->channel);
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 945b9482bcb3a9..86696a9a32c559 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -204,15 +204,16 @@ static void hyperv_plane_panic_flush(struct drm_plane *plane)
 	struct hyperv_drm_device *hv = to_hv(plane->dev);
 	struct drm_rect rect;
 
-	if (!plane->state || !plane->state->fb)
-		return;
+	if (plane->state && plane->state->fb) {
+		rect.x1 = 0;
+		rect.y1 = 0;
+		rect.x2 = plane->state->fb->width;
+		rect.y2 = plane->state->fb->height;
 
-	rect.x1 = 0;
-	rect.y1 = 0;
-	rect.x2 = plane->state->fb->width;
-	rect.y2 = plane->state->fb->height;
+		hyperv_update_dirt(hv->hdev, &rect);
+	}
 
-	hyperv_update_dirt(hv->hdev, &rect);
+	vmbus_initiate_unload(true);
 }
 
 static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
-- 
2.53.0




