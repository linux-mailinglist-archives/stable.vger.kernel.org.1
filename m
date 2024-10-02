Return-Path: <stable+bounces-78693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F898D47D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0734D1C217F4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12671D04B7;
	Wed,  2 Oct 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcT9kuNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C61D0424;
	Wed,  2 Oct 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875244; cv=none; b=d9XFXP6nOnJ1+w1aQ0pfvrXYY777TXCGRc/3qyEC1V0DWjcc1TJq3+iYhBwmDMySbbap02OCmimQLSfxjn/scOpF2CnTet3BFPq3YDTJs4a7Mbdcm9II8wQzKlesnT1sm7gEfAUQyHKycewWjJcuetDRfaM13fOobl1ycixtnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875244; c=relaxed/simple;
	bh=Ym82KCrNhUrZPEfZqIUkgSUhC+w3K5g2JGSKObuGPVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upkA2iqFkh7DFjo19FmUe2DjQ4j2zmC+bOs5mi2/t4/xQfLPG/38o4FSvIAKjSNG4N9uymrphrrqJHxJVxYEUfnlK/z3FYRoguliH4Cdthkh48VoMTi3AyjPdSKwF3I5Gl0OVRjeB+8UxyzVU/Xyu9FJepcJfHK3VTaL9gwwXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcT9kuNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FCFC4CECE;
	Wed,  2 Oct 2024 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875244;
	bh=Ym82KCrNhUrZPEfZqIUkgSUhC+w3K5g2JGSKObuGPVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcT9kuNrcGIq/xQ/cD21bX9OuO6gaSBM9/99MNqqvGZboMvoC4qxygcfJBylDy/de
	 sT5ZfKOKpHCLPiRmmlY+vXBdc57ygD42oq9xPDES3KTmOibGowsDza+Hw/h4g+Ok+/
	 fCitLu9/BXd7tIb3tjPi4j7Jmj8D8mSXNDxGcED0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 039/695] thermal: core: Fix rounding of delay jiffies
Date: Wed,  2 Oct 2024 14:50:37 +0200
Message-ID: <20241002125824.052630261@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 8144dbe68c493baa412d78f41a57e90a6461f6c3 ]

Using round_jiffies() in thermal_set_delay_jiffies() is invalid because
its argument should be time in the future in absolute jiffies and it
computes the result with respect to the current jiffies value at the
invocation time.  Fortunately, in the majority of cases it does not
make any difference due to the time_is_after_jiffies() check in
round_jiffies_common().

While using round_jiffies_relative() instead of round_jiffies() might
reflect the intent a bit better, it still would not be defensible
because that function should be called when the timer is about to be
set and it is not suitable for pre-computation of delay values.

Accordingly, drop thermal_set_delay_jiffies() altogether, simply
convert polling_delay and passive_delay to jiffies during thermal
zone initialization and make thermal_zone_device_set_polling() call
round_jiffies_relative() on the delay if it is greather than 1 second.

Fixes: 17d399cd9c89 ("thermal/core: Precompute the delays from msecs to jiffies")
Fixes: e5f2cda61d06 ("thermal/core: Move thermal_set_delay_jiffies to static")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/1994438.PYKUYFuaPT@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3ba8dd804026f..93c16aff0df20 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -323,11 +323,15 @@ static void thermal_zone_broken_disable(struct thermal_zone_device *tz)
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    unsigned long delay)
 {
-	if (delay)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue, delay);
-	else
+	if (!delay) {
 		cancel_delayed_work(&tz->poll_queue);
+		return;
+	}
+
+	if (delay > HZ)
+		delay = round_jiffies_relative(delay);
+
+	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -1330,13 +1334,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
 	const struct thermal_trip_desc *td;
@@ -1482,8 +1479,8 @@ thermal_zone_device_register_with_trips(const char *type,
 		td->threshold = INT_MAX;
 	}
 
-	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
-	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);
+	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
 	/* sys I/F */
-- 
2.43.0




