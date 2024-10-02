Return-Path: <stable+bounces-79416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0350798D823
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A131A1F2123A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A21D095E;
	Wed,  2 Oct 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NIgRA0OR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121261D07B0;
	Wed,  2 Oct 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877385; cv=none; b=LU6Jo6grZVzSUTsCgNqdBACxHRwSLG1AfAp7OuBDQdKIjFc1sdo40RTYegIhZWv4exIs8azBXzzkzKYZQNRfonqIcS0DJdYzRAg9BInhiy+BxZR54NncRelI0Ao2Nm/U4gNL/GXBaA7r/sNo/lCyKSudDHMPb7Cbwl38koKi4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877385; c=relaxed/simple;
	bh=+gQSXLazsn4A++/j+Ajp90w98wZ/5nDM2HQ4OkaIfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp+ObkMmm0PZdPSUj2qHSaF9hRnHY8UCK+3y7sTsaXM9Zfpn8L6UWCbulII9ofX/2CQ1bmQm9FH7ZMUIJUWocjv8GzWNqHS30jSRBKt0HbylxP+HzoNgCQxbUrMBnAWhyTI+MkF+lwqkb6dG04EkGgDlRvPKYIvWKIc9z3SCkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIgRA0OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA39C4CEC2;
	Wed,  2 Oct 2024 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877384;
	bh=+gQSXLazsn4A++/j+Ajp90w98wZ/5nDM2HQ4OkaIfGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIgRA0ORg0O822jBs0Fd4sCnhsfkLjhDL9UBwcF15zKDtj4jIohHSK/d9Whmjxh1c
	 xbCImheYSYB+lY+otpozZfsXdTICxQeoN5SftXa0icJWsOxhfLtvxU3WzU2V84RhaF
	 LMWj78P2LTvoa9qWGTbfK0vN1iN00H8y/SHEzxNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 062/634] thermal: gov_bang_bang: Adjust states of all uninitialized instances
Date: Wed,  2 Oct 2024 14:52:42 +0200
Message-ID: <20241002125813.554968494@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 15cb56bd529868d9242b22812fc69bd144bfdc94 ]

If a cooling device is registered after a thermal zone it should be
bound to and the trip point it should be bound to has already been
crossed by the zone temperature on the way up, the cooling device's
state may need to be adjusted, but the Bang-bang governor will not
do that because its .manage() callback only looks at thermal instances
for trip points whose thresholds are below or at the zone temperature.

Address this by updating bang_bang_manage() to look at all of the
uninitialized thermal instances and setting their target states in
accordance with the position of the zone temperature with respect to
the threshold of the given trip point.

Fixes: 5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/6103874.lOV4Wx5bFT@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/gov_bang_bang.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index daed67d19efb8..863e7a4272e66 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -92,23 +92,21 @@ static void bang_bang_manage(struct thermal_zone_device *tz)
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
+		bool turn_on;
 
-		if (tz->temperature >= td->threshold ||
-		    trip->temperature == THERMAL_TEMP_INVALID ||
+		if (trip->temperature == THERMAL_TEMP_INVALID ||
 		    trip->type == THERMAL_TRIP_CRITICAL ||
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
 		/*
-		 * If the initial cooling device state is "on", but the zone
-		 * temperature is not above the trip point, the core will not
-		 * call bang_bang_control() until the zone temperature reaches
-		 * the trip point temperature which may be never.  In those
-		 * cases, set the initial state of the cooling device to 0.
+		 * Adjust the target states for uninitialized thermal instances
+		 * to the thermal zone temperature and the trip point threshold.
 		 */
+		turn_on = tz->temperature >= td->threshold;
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 			if (!instance->initialized && instance->trip == trip)
-				bang_bang_set_instance_target(instance, 0);
+				bang_bang_set_instance_target(instance, turn_on);
 		}
 	}
 
-- 
2.43.0




