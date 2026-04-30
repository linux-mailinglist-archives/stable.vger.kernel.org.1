Return-Path: <stable+bounces-242197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLK4EbWx82mD6AEAu9opvQ
	(envelope-from <stable+bounces-242197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:47:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEB4A775B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49DD6300D1EB
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8011F33EB01;
	Thu, 30 Apr 2026 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s366sgNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D75335564
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578418; cv=none; b=pJsoj1Y8ZfXce0FV2rNjCK9OVfVAdUhyQXBSOwzjb75dVlu2uEoXpJUVPWNxL6La08W00tekEPtz2OTfihc713z+3Fag+DdrS539ZjHDY/eGBvFeOStZN2LwNwnrbXXUUu8z5EBdwu+1JKhk+JkL0PcjgTHbu7KJ2nTmB/M98Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578418; c=relaxed/simple;
	bh=kuBJ/JniM6OAZwVMglkKU13Mf57aQ7AmaRhJGheajx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEp1w+nBHC21F29cD/NVqQT404LvZCmSXTi38SLXo1HDv7MeLuAbrmTriEatHvKhMrMo7wvLF5PWdvClyzk92kfzhW3PodlRQTeTqQnx2tRM0tUrUVYyxkXOSIH4IHrupmD4M4XlhRAtfL5Ikf89Ufn11FsucX015Rzdf/Ts6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s366sgNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DC9C2BCB3;
	Thu, 30 Apr 2026 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777578417;
	bh=kuBJ/JniM6OAZwVMglkKU13Mf57aQ7AmaRhJGheajx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s366sgNMO8pnt9wsO3Te2yDDYz/WFiilS4Ko6jciHrvWnS+f17yguIBf9vVcW/I9t
	 /F+2Ewy5wqFl/hdJkrkHvUOQ5tCJnGPx2dgINHdazS66RIZ3ldVTgU8A6nw/GexP7E
	 558y9qSgq6oRXqaXURdlei7P3Lq9qdnTdHgpFfNyOlabd91c/AjvKsvdWe4yboplvD
	 y0DXA9QdhlJ4BsSbBKL6xiGIDqlBoe2s2vSMxtgtyzTDS/wMg843SeSh5A77NSK+A7
	 fKlFpwBxa6UuLw2iU0zSJBvfRRrTVzOSFRuJWrbGwJD+NoXrj9eeSDCC0x7RbQLwxw
	 XaRd8FM771tcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] thermal: core: Fix thermal zone governor cleanup issues
Date: Thu, 30 Apr 2026 15:46:54 -0400
Message-ID: <20260430194654.1996047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026043040-shorts-dimly-d534@gregkh>
References: <2026043040-shorts-dimly-d534@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DEFEB4A775B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242197-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]

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
index 1cf49912dc96c..7b4d31df0e0de 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -986,6 +986,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		thermal_set_governor(tz, NULL);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1447,8 +1448,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
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
@@ -1571,8 +1574,6 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 
-	thermal_set_governor(tz, NULL);
-
 	thermal_remove_hwmon_sysfs(tz);
 	ida_simple_remove(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.53.0


