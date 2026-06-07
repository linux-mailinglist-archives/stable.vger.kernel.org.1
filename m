Return-Path: <stable+bounces-260987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wezQE7VDJWprFQIAu9opvQ
	(envelope-from <stable+bounces-260987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF664F610
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:11:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fnyAprKj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260987-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260987-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67580303FDC6
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF262E1EFC;
	Sun,  7 Jun 2026 10:07:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61D1DE8AE;
	Sun,  7 Jun 2026 10:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826877; cv=none; b=PV8X7lW0HKOfIUSoilpzRtSKbp20siY92TMO0VPX2t0/HvFX7eFtEFqkYx139YWXEUi9C/IOZlK9JiwhpTPVhIoffNoA+SZWvVukh0YzYR1YyAqgQ3fuinmVCdarCRTtRWpNVhi7QkBbP44F/6hEw8X5QkTiYCYJRi1YhNcnkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826877; c=relaxed/simple;
	bh=CEfQIfB4iyFNVofTlm3HxkxrXBgI/AVyftcKEDNlVJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBpMiz2BcENv3TMbzQ0ZRiuSISEWcfyNDGe1ONsmxYWroU8tL6a+EcgJlaRBj9r91Kuo70/E0xn//ZkUIqQmljB0oTiCSfy7WUcRQrC8hccN481nZNCnIpGokPkf157K6LXEN9PNQ+9phpuMPmXWOpIt+FRvVE29yAMy2XXxZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnyAprKj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD93C1F00893;
	Sun,  7 Jun 2026 10:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826876;
	bh=GMsTytIjE82+TTChcMTiWnwgLQKDGKoEIJI+eox1Vzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fnyAprKjZOHhtDUnX6YqD3fMXzHI7SWg3DoEoRD5eGgqCk2UCGWuba6bL4IuGw2ij
	 hwoG7Bx5a4lfHTvkZIurRVj7GQ2EPGkg4ZGVcYllZy3Kg89kVdzatdVChh1WuQt6YO
	 lyFvXDwpoArtq2qYBC1X3rmvoQUoW7H1DE2ygJDQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 039/332] drm/i915/aux: use polling when irqs are unavailable
Date: Sun,  7 Jun 2026 11:56:48 +0200
Message-ID: <20260607095729.548600140@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260987-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ville.syrjala@linux.intel.com,m:michal.grzelak@intel.com,m:tursulin@ursulin.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ursulin.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DFF664F610

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Grzelak <michal.grzelak@intel.com>

[ Upstream commit 202e77cf2e839e1adc804433322dc5c9ee511c9f ]

PTL with physically disconnected display was observed to have 40s longer
execution time when testing xe_fault_injection@xe_guc_mmio_send_recv.
The issue has not been seen when reverting commit 40a9f77a28fa ("Revert
"drm/i915/dp: change aux_ctl reg read to polling read"").

Apparently the configuration suffers from not having AUX enabled when
using interrupts. One probable cause can be xe enabling interrupts too
late: interrupts need memory allocations which currently can't be done
before the display FB takeover is done.

As for now, use polling for AUX in case interrupts are unavailable.

Fixes: 40a9f77a28fa ("Revert "drm/i915/dp: change aux_ctl reg read to polling read"")
Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260416163744.288107-1-michal.grzelak@intel.com
(cherry picked from commit 05e0550b65cd1604bd515fbc65f522bce4c10a87)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp_aux.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index b20ec3e589fadc..9c9b6410366d5c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -12,6 +12,7 @@
 #include "intel_dp.h"
 #include "intel_dp_aux.h"
 #include "intel_dp_aux_regs.h"
+#include "intel_parent.h"
 #include "intel_pps.h"
 #include "intel_quirks.h"
 #include "intel_tc.h"
@@ -60,18 +61,29 @@ intel_dp_aux_wait_done(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	i915_reg_t ch_ctl = intel_dp->aux_ch_ctl_reg(intel_dp);
 	const unsigned int timeout_ms = 10;
+	bool done = true;
 	u32 status;
-	bool done;
+	int ret;
 
+	if (intel_parent_irq_enabled(display)) {
 #define C (((status = intel_de_read_notrace(display, ch_ctl)) & DP_AUX_CH_CTL_SEND_BUSY) == 0)
-	done = wait_event_timeout(display->gmbus.wait_queue, C,
-				  msecs_to_jiffies_timeout(timeout_ms));
+		done = wait_event_timeout(display->gmbus.wait_queue, C,
+					  msecs_to_jiffies_timeout(timeout_ms));
+
+#undef C
+	} else {
+		ret = intel_de_wait_ms(display, ch_ctl,
+				       DP_AUX_CH_CTL_SEND_BUSY, 0,
+				       timeout_ms, &status);
+
+		if (ret == -ETIMEDOUT)
+			done = false;
+	}
 
 	if (!done)
 		drm_err(display->drm,
 			"%s: did not complete or timeout within %ums (status 0x%08x)\n",
 			intel_dp->aux.name, timeout_ms, status);
-#undef C
 
 	return status;
 }
-- 
2.53.0




