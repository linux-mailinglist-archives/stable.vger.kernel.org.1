Return-Path: <stable+bounces-242192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA+ZJbqf82ly5QEAu9opvQ
	(envelope-from <stable+bounces-242192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:30:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DD4A6F9E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86962300B638
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE93FADF6;
	Thu, 30 Apr 2026 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoLbSb3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E939D6DE
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573676; cv=none; b=Ve2zb/Z9mn3PT7L8ZSIZ/IrPM5yzFw8F2kSkArEQ73DMTceme6Rp8kc9ploSprvVN9HjAOwzaKFbnREpDX7x/JoU36jPvOZTjkCTtS5N8ivyKOL/85oYqeysAg7O8QJaLuHkxdr6ne/JH4Qn1Ka0c6oVU7aiR91RZ4wXg2aRZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573676; c=relaxed/simple;
	bh=MUPN8s67a3GkrD29oe04tMb5g23fatKrChL628BYVKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZBLk0uga+hX+lSOrzIRf908TMylu8uJ/yPPchAQil0zyknqXcV9wKkA3D4AZCt0lTnqYZH/O/KcB1x8UQ9++CcMdHQX+QhaxmyhZJGVVa6mpuYr4DL8x7ZCjRx1QUXojn9BHKicq3TpQOdrb0HLLPYHhUmw7QHz0xKTs/cktq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoLbSb3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09A5C2BCB9;
	Thu, 30 Apr 2026 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777573675;
	bh=MUPN8s67a3GkrD29oe04tMb5g23fatKrChL628BYVKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoLbSb3OA7/twvBU6vZkKsk5kU0cf511BIoIF8Ctn/hlxgdJkh2/fTVAYJZMq2E4M
	 5tabR2aL73HvEVSUTux9fuTHdGcSipvA+QQ3iA0tG7aocoMlluDZ6HYtA019fi+bQs
	 6vSWrL/EbqgIkbvyijgO7XU68zeL9iW6qf5+KBOFmwPm1IpVPb23jia9ELSyPGmwBz
	 7kIGcp47IDKmiLod5pYfnfQrwe7KKJkMmasSx9gjA0AhfNFhI+hwSwQA9ahblrgwRC
	 gjZMJovJVRk1G4Bsxo4l5IoNXpi6POWQShK0dL6OW5Qu2YJPeS9GftIMKurK3qDJJJ
	 wi1KUEnXfCFjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] thermal: core: Fix thermal zone governor cleanup issues
Date: Thu, 30 Apr 2026 14:27:52 -0400
Message-ID: <20260430182752.1934906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043039-shallow-fanning-e2d0@gregkh>
References: <2026043039-shallow-fanning-e2d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F37DD4A6F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242192-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 41ff66baf81c6541f4f985dd7eac4494d03d9440 ]

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
[ adapted context for missing mutex_destroy/complete ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ba6f44f8b2623..4fef439716dc4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -756,6 +756,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1260,8 +1261,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz, mask);
-	if (result)
+	if (result) {
+		thermal_set_governor(tz, NULL);
 		goto remove_id;
+	}
 
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
@@ -1396,8 +1399,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.53.0


