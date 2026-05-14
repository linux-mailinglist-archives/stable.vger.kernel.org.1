Return-Path: <stable+bounces-247283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHZ2BxgiBmodfgIAu9opvQ
	(envelope-from <stable+bounces-247283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED35465E3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286B6302BBBC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447035A39F;
	Thu, 14 May 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqwuOj1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48001336897
	for <stable@vger.kernel.org>; Thu, 14 May 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786772; cv=none; b=aMPlIfjMNxGkWXs99IW9EZwBKL12LoT93hOuPWQAvUhPp8XYpQ82dTZ49NWmtNG9TDkIWgRCdjWehF0/UAZk6GdfxoidMH/SxvtZYHJyxtYrSs91j5x5yeXN+6EnR7ccJBdRc74wWWldiyX7IMqj1eCh0c+fBV2HZcWcYBbVrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786772; c=relaxed/simple;
	bh=UYp9PNTwMcIuuZWqsRxLQ5FChIzfatqPrW383NOUHjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeH8+VSLTGA5fr/ZyPJMe5uMIXcXyW2eVJAvgJH/VFZhMX4K+ZXlssnvS0a/IBoVAV90dK++XbPpGTJumQ+vFliaQVZh4QKRD4iJZmb1CI+S08V+c06CnO54xdvv1atfNwgslHkmQlGdNdyNrExzKPB/shXcBA4wBKZqI1TtZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqwuOj1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81730C2BCB3;
	Thu, 14 May 2026 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778786771;
	bh=UYp9PNTwMcIuuZWqsRxLQ5FChIzfatqPrW383NOUHjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqwuOj1pEF9KEtKS4SGKGYN7mz5Ya1Rull+aHU9Oy79cxWeDrTlVneqqagHXNe57X
	 qmDkzyt3/bhu07hpPvE+6yYeyhAHrhkA8Aw2bkSmRqnp9jnd0OujF6sMcZQEfr+6Fz
	 mnEt/xr+y+gWV+n7UvtDXQbB7+IoK74yxcHDadgZtt5j2BQl7jcC0UvbQzwHqpurr0
	 8w6TB1KW5Skplwn9spaOYmCMFabAdys+JLTYgheIsmZdDVVLaQHkQagKWYc+VA60qi
	 XejfNIPj5ggO5kFxYiEqzF6Mg605NgWuy4cgZD+I8o9K2eQXX7nl6sQ+C++cdYAGW6
	 P5rCLY2Win6qA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] thermal: core: Free thermal zone ID later during removal
Date: Thu, 14 May 2026 15:26:09 -0400
Message-ID: <20260514192609.1258270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051204-dazzling-those-ecf3@gregkh>
References: <2026051204-dazzling-those-ecf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CED35465E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247283-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit daae9c18feec74566e023fc88cfb0ce26e39d868 ]

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
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 660a8d6f35673..f8f18c3ebdda4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -804,6 +804,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		ida_destroy(&tz->ida);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1481,8 +1482,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	ida_free(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 
 	device_del(&tz->device);
 	put_device(&tz->device);
@@ -1490,6 +1489,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_notify_tz_delete(tz_id);
 
 	wait_for_completion(&tz->removal);
+
+	ida_free(&thermal_tz_ida, tz->id);
+
 	kfree(tz->tzp);
 	kfree(tz);
 }
-- 
2.53.0


