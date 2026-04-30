Return-Path: <stable+bounces-242163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GTfKJiI82mS4wEAu9opvQ
	(envelope-from <stable+bounces-242163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:51:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0B4A604B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3E7300B769
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FED3290DB;
	Thu, 30 Apr 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXDiLppD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA032DA768
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567517; cv=none; b=u+q548DA1UdjvsysrUUmTeh/O5j7bIA8tEEP/5f3UcSaUB07NmHRUL5dUIwT+01GC0nXX+/UU2NIU2Xa9P3rQvR1ikSVVfPLPBnMKHY6ufKJ5NOUp/4A5Fm5GU2p3H28HgqyctSwlHhoqw7xWDfMLkQ96mcztqbcdPKr/+I6fFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567517; c=relaxed/simple;
	bh=bjHNGNhe8R9yBKZvBde2OZ6sJrV5cEAz8DX84cUSgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy5x9Hpn/5C+DqOZKpDmYPR64PpMaP5+Md+GVG5aBXRjrgHWe+Z46W4OfKfxavIRwSiG2e5ONjCD8B+oRicEbhJoUMHyGWr/rCVCxaORxX4neZvgdYfC3AL++oyiwvtmMU+LgBdQt+qJWpoW5I/SpK3PwF+YUJkHzYHBV7Hj2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXDiLppD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12A4C2BCB3;
	Thu, 30 Apr 2026 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567517;
	bh=bjHNGNhe8R9yBKZvBde2OZ6sJrV5cEAz8DX84cUSgFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXDiLppDwSGTQn4XmxCAo+9ji5VMVlwUFcwimrYSCM8i8kByVb1D2KmQuh4MWJFG3
	 tqXgimGvCghR4qIh1jwSfa3N9KeCX4Zn+ckoW2eunk0Yc0PISTk7tENRKtDlf5ShBe
	 hmmyAfGPPhx5UNdH4gyjzJxlppvmg4bfKe2ohlmL83wtrBdK0PCmFjE2wKq+z42J09
	 +IPTPXKaihpkZkcvgEvIgMoItyqCpr6CGptWK/+jrM7OOHxiwKiIMbIY8Kfb8VCt7k
	 Y50IAHZ0mofc9181AJTCCjFHTr2yirwl/VsSl8Hf6JndTL7q0GUK4HbBbIGLZ3QaYu
	 rlP9IoTwRAy5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] thermal: core: Fix thermal zone governor cleanup issues
Date: Thu, 30 Apr 2026 12:45:15 -0400
Message-ID: <20260430164515.1851850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043038-magnetic-staple-59dd@gregkh>
References: <2026043038-magnetic-staple-59dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CE0B4A604B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242163-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8ce1134e15e56..1eaddce11aedd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -917,6 +917,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		mutex_destroy(&tz->lock);
 		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
@@ -1483,8 +1484,10 @@ thermal_zone_device_register_with_trips(const char *type,
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
-	if (result)
+	if (result) {
+		thermal_set_governor(tz, NULL);
 		goto remove_id;
+	}
 
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
@@ -1630,8 +1633,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.53.0


