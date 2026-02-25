Return-Path: <stable+bounces-218082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAFQH3dQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A218EBFE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 349CA3053905
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8852505B2;
	Wed, 25 Feb 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AKy4/fY3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF211D5ABA;
	Wed, 25 Feb 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982855; cv=none; b=OGKBjiVtGaUWhes3rBJSpBWY0xTNv24K8lEHEazvKwUT4MKw5P6siv/EDCE1SQBcirhnhc1c6mjyZd80GodEyblVVIWy4uXVO6207m3kNOJpcMu/rmgAvnfVNJH3e4eSgEoJ/dLB/Uidvj9Jw3hLauCgis32b/+BT3uNgcmHPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982855; c=relaxed/simple;
	bh=qYmYx3ThGgOrqC46M5T38gKFdO/hDF1apNi8To2jf64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d41WIW+PraJDQ/QVVNscCgqI3m6Vz5D90C9jGj5eiL6l1Z3FQMNm211110RiwCaweI81jYj1t4kE2uLvGjWVdDBnUDpFTbDr/VzVAeSSBLEDHItOk6CI6lxk6Yca+i1jAJs/+9mBbDOKQBpYvkrGcWWKl7WUFPdeSY3QaDysi70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AKy4/fY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5083BC116D0;
	Wed, 25 Feb 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982855;
	bh=qYmYx3ThGgOrqC46M5T38gKFdO/hDF1apNi8To2jf64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKy4/fY313lVmqLrRDIs15bPHPhYu3fwXoVKW10YDiKXG/dHgeDPcx2KjTMz8woRy
	 3qkPpDSbi5c+hGrAcksWGQ2ZsE0JqPGb/w/tgBs+iUjB8RJoejlHL9R5eVenU/ah1d
	 SIMykJioMaQTjlT54hC2q3aFlO1OdaFcw+6vswkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 044/781] cpuidle: governors: menu: Always check timers with tick stopped
Date: Tue, 24 Feb 2026 17:12:33 -0800
Message-ID: <20260225012400.784226486@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218082-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D67A218EBFE
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 80606f4eb8d7484ab7f7d6f0fd30d71e6fbcf328 ]

After commit 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length()
call in some cases"), if the return value of get_typical_interval()
multiplied by NSEC_PER_USEC is not greater than RESIDENCY_THRESHOLD_NS,
the menu governor will skip computing the time till the closest timer.
If that happens when the tick has been stopped already, the selected
idle state may be too deep due to the subsequent check comparing
predicted_ns with TICK_NSEC and causing its value to be replaced with
the expected time till the closest timer, which is KTIME_MAX in that
case.  That will cause the deepest enabled idle state to be selected,
but the time till the closest timer very well may be shorter than the
target residency of that state, in which case a shallower state should
be used.

Address this by making menu_select() always compute the time till the
closest timer when the tick has been stopped.

Also move the predicted_ns check mentioned above into the branch in
which the time till the closest timer is determined because it only
needs to be done in that case.

Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/5959091.DvuYhMxLoT@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/governors/menu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c7766..ca863ba03d454 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -239,7 +239,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	/* Find the shortest expected idle interval. */
 	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
-	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
+	if (predicted_ns > RESIDENCY_THRESHOLD_NS || tick_nohz_tick_stopped()) {
 		unsigned int timer_us;
 
 		/* Determine the time till the closest timer. */
@@ -259,6 +259,16 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 				   RESOLUTION * DECAY * NSEC_PER_USEC);
 		/* Use the lowest expected idle interval to pick the idle state. */
 		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
+		/*
+		 * If the tick is already stopped, the cost of possible short
+		 * idle duration misprediction is much higher, because the CPU
+		 * may be stuck in a shallow idle state for a long time as a
+		 * result of it.  In that case, say we might mispredict and use
+		 * the known time till the closest timer event for the idle
+		 * state selection.
+		 */
+		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+			predicted_ns = data->next_timer_ns;
 	} else {
 		/*
 		 * Because the next timer event is not going to be determined
@@ -284,16 +294,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		return 0;
 	}
 
-	/*
-	 * If the tick is already stopped, the cost of possible short idle
-	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
-	 */
-	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
-
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
-- 
2.51.0




