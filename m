Return-Path: <stable+bounces-245623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL44Co8xA2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E466521C58
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5F4A307CC6D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BD306745;
	Tue, 12 May 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ikOfw0oB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9DC395AF5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593751; cv=none; b=O+vyrUCRztklGKNMo/phwSlA+tZWvL5pwQBd3Y82ffPr0k2gFh8BYse+JiqTHt5nPyipwPEI0Tq5hA/DjtKk4EaXBDDtM1EdEk8Za+xbpsUYTO4l9YiBhPHUNTkyc7WrdjcMlqHlcciB7fD8WW1Eoxy8vpB+GQUoDp3TVzkJNdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593751; c=relaxed/simple;
	bh=rqXg/XvCiz1D6ggb8ikaIVCZZOYg3eypo/qrMHaoVl4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kBNCzVBJJuG0qXzO+AAfBqYzOGHihNOX2HySwHaCVhPhyYJ2zeyUxQGrMOO/j2fjYd6QYTZNa2IzIu+9n6b6ShxmXiCHVmkSPL0Ro3saMccSqUiJGzY2oSpMRJ2/hKf9dJDFm2AUbbZ5eh1LUybJmxRZSY+Ei6ZO8Sa76N7hSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ikOfw0oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CA5C2BCB0;
	Tue, 12 May 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778593751;
	bh=rqXg/XvCiz1D6ggb8ikaIVCZZOYg3eypo/qrMHaoVl4=;
	h=Subject:To:Cc:From:Date:From;
	b=ikOfw0oB4mGwX/R2c27SCzQha2J1TrcjfIiFByqQoM7Fa3677UYLF/90Kmton3eZn
	 Mn/XYyTme7sOW2wOcwEOkt+lnuwddqNyIaIE07HhgXGzUbNpNtgVeDbFqp+58Tii5U
	 pUfj5ug01F3D+Z2VPKujzHYcM5KDCxQ7pyaqekAo=
Subject: FAILED: patch "[PATCH] thermal: core: Free thermal zone ID later during removal" failed to apply to 5.15-stable tree
To: rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:49:05 +0200
Message-ID: <2026051205-varnish-neurology-baf9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E466521C58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245623-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gregkh:email,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x daae9c18feec74566e023fc88cfb0ce26e39d868
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051205-varnish-neurology-baf9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From daae9c18feec74566e023fc88cfb0ce26e39d868 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 7 Apr 2026 15:58:34 +0200
Subject: [PATCH] thermal: core: Free thermal zone ID later during removal

The thermal zone removal ordering is different from the thermal zone
registration rollback path ordering and the former is arguably
problematic because freeing a thermal zone ID prematurely may cause
it to be used during the registration of another thermal zone which
may fail as a result.

Prevent that from occurring by changing the thermal zone removal
ordering to reflect the thermal zone registration rollback path
ordering.

Also more the ida_destroy() call from thermal_zone_device_unregister()
to thermal_release() for consistency.

Fixes: b31ef8285b19 ("thermal core: convert ID allocation to IDA")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/5063934.GXAFRqVoOG@rafael.j.wysocki

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6e10b2fe2972..c1ec98591703 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -965,6 +965,7 @@ static void thermal_release(struct device *dev)
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
 		thermal_set_governor(tz, NULL);
+		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1729,8 +1730,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1738,6 +1737,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+
+	ida_free(&thermal_tz_ida, tz->id);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }


