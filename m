Return-Path: <stable+bounces-247305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKH9DqF2BmoUkAIAu9opvQ
	(envelope-from <stable+bounces-247305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF60548675
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D81483005302
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46E036922D;
	Fri, 15 May 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbveOFRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DE368291
	for <stable@vger.kernel.org>; Fri, 15 May 2026 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808398; cv=none; b=nYmxU5Q6ju0k8eVNtVd5XvkXG2PIADI20qegZ75yGdpZvxzmi4Jg71Qs0VwmLqpta5uCZFgLdBH00xPiyHGrP++OaTFOf5BxS/UtYe06pRTrrZgl5F66pEhO6ZFprqckzjoTs9C5vpjgJawFbioM/12d1Y6Z5oDqvlaDkjU4UK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808398; c=relaxed/simple;
	bh=OOnh8H7x9J8xIK+MA50VoBdwp1ZnLlFSZArIPdZ3Ivk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEGR4lvWV67hpdlJLXFa7RfDO8KfddfWTcAnLu4xLrf88KFgsALmI/HCni8FRmcmd/fWm8XcJurBelpjqVtl7ddosU/ClpEk7XSHLwDaNcUANjSVolNO0XoyswZ4rxDHIu06DdT1wB3vVRyRFBe2sGuGQMr+rP8uFEONdVeBlB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbveOFRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F7AC2BCB3;
	Fri, 15 May 2026 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808398;
	bh=OOnh8H7x9J8xIK+MA50VoBdwp1ZnLlFSZArIPdZ3Ivk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbveOFRZYtrtn51uHObgJ9RKYUyP5SKdlmh1c7h5rEwlxh3RWBGb4JWR3mdx0lZc1
	 FkvouAM7UMYmO/0oevUAckn9w8x0nEk+RCq1UiE/eee3RC/1v5WTZgOWV0iRS45cQ+
	 q8E0SYoabNtcZUu8uYPljs8GIC/IcYgpX49YZ++gfOrrPW3vgz0PTxGKGyk1Ow9kpq
	 K14BiNX9cLMZUsc2IEyMDyV8/dBmV1fzkns8hj21KBkKLttmOZGzzu8V4haEfSAMQD
	 wxIFkFH2XkoegezvxISD8zoa3fA9Jx1zPtALpaZBOYcFlb60UIkx0Fww2Bxy2aWqTz
	 yPFzf1rkDdNVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] thermal: core: Free thermal zone ID later during removal
Date: Thu, 14 May 2026 21:26:35 -0400
Message-ID: <20260515012636.2653186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051205-varnish-neurology-baf9@gregkh>
References: <2026051205-varnish-neurology-baf9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EF60548675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247305-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
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
[ moved ida_simple_remove(&thermal_tz_ida) to after device_unregister() and relocated ida_destroy(&tz->ida) into thermal_release() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bb3a4b6720362..fcc1837b83843 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -778,6 +778,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		ida_destroy(&tz->ida);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1388,11 +1389,11 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	ida_simple_remove(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
+	ida_simple_remove(&thermal_tz_ida, tz_id);
+
 	thermal_notify_tz_delete(tz_id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
-- 
2.53.0


