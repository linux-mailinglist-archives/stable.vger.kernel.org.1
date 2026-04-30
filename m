Return-Path: <stable+bounces-242125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBVaHbpe82lT1wEAu9opvQ
	(envelope-from <stable+bounces-242125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:52:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE04A3B4B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 729F53006445
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA673A4F32;
	Thu, 30 Apr 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z9vO57tq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5F1E25F9
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557174; cv=none; b=H3Inqrpauotgf0kmelV+lj3qshF6wfP87lBju1rK70ILrgdIm/eOLO7wAhppTuQ2tnmSxy/WogeBef94E55+aTzIy6Q2khlM4aDNK1YhlFghWNEq0e/A1s8mB0MXf5xSNBVTznjHPPG1vM9dmZX/DheYYdAeiUm1sLTO88ERPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557174; c=relaxed/simple;
	bh=MGilRh5TXLvFox9rrGhCgEK6UAWXiipAkrAIYlqXr34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YNjBx5xmsmWK55ZOWDzPVNy00LoMk3hagie3n+e+jvFJL+le9dpSKE4SGpn71pOVnzfNO4AAR8uHA/augFP94jviUqO/Soe/s3uyJ/swzqseESybVKz13U7wjJ075Nf1d5gva5PLFlwK9ZsB+4AywFSwhrXYfGp9TkPoyj8OWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z9vO57tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6805FC2BCB3;
	Thu, 30 Apr 2026 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777557174;
	bh=MGilRh5TXLvFox9rrGhCgEK6UAWXiipAkrAIYlqXr34=;
	h=Subject:To:Cc:From:Date:From;
	b=z9vO57tqX09BWENfc66fvQugO3hfAfolzKPa7fwDpOJIMZr1DpYyv3nPhlYYxMftb
	 nUZDqUXZRnP75d+IjkPH0Zxa8uGNej2GYPIcMCR8c0J50D0Jhx9BAmvyOorc1h/nOl
	 82UZzDaOVlxqJFf/lry46bn9dR+pevVVMLvwqbUo=
Subject: FAILED: patch "[PATCH] thermal: core: Fix thermal zone governor cleanup issues" failed to apply to 6.1-stable tree
To: rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Apr 2026 15:52:39 +0200
Message-ID: <2026043039-shallow-fanning-e2d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 19BE04A3B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242125-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 41ff66baf81c6541f4f985dd7eac4494d03d9440
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026043039-shallow-fanning-e2d0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41ff66baf81c6541f4f985dd7eac4494d03d9440 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 7 Apr 2026 15:55:19 +0200
Subject: [PATCH] thermal: core: Fix thermal zone governor cleanup issues

If thermal_zone_device_register_with_trips() fails after adding
a thermal governor to the thermal zone being registered, the
governor is not removed from it as appropriate which may lead to
a memory leak.

In turn, thermal_zone_device_unregister() calls thermal_set_governor()
without acquiring the thermal zone lock beforehand which may race with
a governor update via sysfs and may lead to a use-after-free in that
case.

Address these issues by adding two thermal_set_governor() calls, one to
thermal_release() to remove the governor from the given thermal zone,
and one to the thermal zone registration error path to cover failures
preceding the thermal zone device registration.

Fixes: e33df1d2f3a0 ("thermal: let governors have private data for each thermal zone")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/5092923.31r3eYUQgx@rafael.j.wysocki

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b6b651cb2331..6e10b2fe2972 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -964,6 +964,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1610,8 +1611,10 @@ thermal_zone_device_register_with_trips(const char *type,
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
-	if (result)
+	if (result) {
+		thermal_set_governor(tz, NULL);
 		goto remove_id;
+	}
 
 	result = device_register(&tz->device);
 	if (result)
@@ -1724,8 +1727,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);


