Return-Path: <stable+bounces-245945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AgGOq5oA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C67D5263AC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A7730570C7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F73D25D2;
	Tue, 12 May 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h3Z4NiLA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5D21FF21;
	Tue, 12 May 2026 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607959; cv=none; b=WXNRcRnMWACfgx1TfbSh5HMwlHSLveKfY4MPPZKld5MAewNAZdVFrVWfjUtHY8AwHdw2bi9UhiArVePdBovKzN4rg5PsiUxXxATQy8xCMn/TJHtqWCZPK8jDt6DuYeJfvvqw0tW+Yl+Iaru7DiSqJJ3fBiLUxayD6ZZwjV7hEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607959; c=relaxed/simple;
	bh=DSPWz+I/BN8tK6MUhFp7RpbgIwirmz/erfHBwQhbjPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfI1IbIhgJ2fWvp/Ez6wgBwP1qb4DpGXF0TX9O5fwN70uYnsVvxPjutJjpXY/rF7V+e5zrGMaVCCkO9bvMw/7Htw9XK9Ke4Bpi76Ir6CpVG0ONVtDoAqHbX/6it/ke4B5g22vG+SG6hKUCEKnnXECfjbRv73GTmg+FFIM22O2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h3Z4NiLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6FBC2BCB0;
	Tue, 12 May 2026 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607959;
	bh=DSPWz+I/BN8tK6MUhFp7RpbgIwirmz/erfHBwQhbjPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3Z4NiLAuTJQ+So0UYU0+8eiNZOHuuZxwbH6xdVENA+rD7L4RTpuzysiCiXvF+nBh
	 Xqp7KbggNQrwUb/lbg6NPxUgaFfVBUsrOifQIKM1P5SNBu7MqAp8mtut3Vjf0rqf47
	 fZTlt5vYzoY/0Zod1KZSwB+6zj1lUyNN0HsINOzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.12 100/206] thermal: core: Free thermal zone ID later during removal
Date: Tue, 12 May 2026 19:39:12 +0200
Message-ID: <20260512173934.976493213@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8C67D5263AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245945-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit daae9c18feec74566e023fc88cfb0ce26e39d868 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/thermal_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -918,6 +918,7 @@ static void thermal_release(struct devic
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
 		thermal_set_governor(tz, NULL);
+		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1634,8 +1635,6 @@ void thermal_zone_device_unregister(stru
 	cancel_delayed_work_sync(&tz->poll_queue);
 
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1643,6 +1642,9 @@ void thermal_zone_device_unregister(stru
 	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
+
+	ida_free(&thermal_tz_ida, tz->id);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }



