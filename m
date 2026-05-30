Return-Path: <stable+bounces-259185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBHOKuQxG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D8612AAC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D187A30A4EAA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E22233943;
	Sat, 30 May 2026 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fw9NN1x4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63581137750;
	Sat, 30 May 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166891; cv=none; b=H2zvbMO1aNDlQ3F8EmArSOGfaQL3PQMJz+SdwfdVEN7PbVNlc7fQZTs7Z6TkNrMIlOGNlCQahVTuHkCiesMJVjQAAMqBW5sb+LE45YCCojWjeNpXaBBAmw7EB6oY/B4OYyeMWLeoFChb99UsTYr5uUHHcNC93y8NHTEIyZvDKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166891; c=relaxed/simple;
	bh=itqMjwH9jYiiEo3QEjYWioKn0mUaC3BBAFSYabVh9yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWRRQ07xSwjdcY4LandA0ii9m1h8HVgnQnKq1gAYan4kQyYg7P4Rskb9MYkwdwaWTEHRpKEGQSKWsx2ixh47ioi87mwOFyimRmLUeJeGYKggq+WLUUGFVZ2+JBI8CKV73570LRlexnL/s2BykeCb3tWG/Uqe4hqm0J16LjivGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fw9NN1x4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94931F00893;
	Sat, 30 May 2026 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166890;
	bh=PAWkkhIBRiBipuke4HJcw7S2XCa4UFa8RZxM78E9+PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fw9NN1x4ybys4bMLelV/ZI6WbDSNS+7tu/b1pLOQ8oNV/9LnMPZ6d+Q5SIwnshv9t
	 tMFWw/njeThbnSwMbtbDOXqtAx0SgGoof09tNvoNbnhqVPKxtcFc1vooA82Q9THB3P
	 4ipvHGcShLEto5hAqtChf1sazibdjNPaeAwxOYd4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 502/589] alarmtimer: Check RTC features instead of ops
Date: Sat, 30 May 2026 18:06:23 +0200
Message-ID: <20260530160237.803519870@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259185-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email,bootlin.com:email]
X-Rspamd-Queue-Id: 3E1D8612AAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit e09784a8a751e539dffc94d43bc917b0ac1e934a ]

RTC drivers used to leave .set_alarm() NULL in order to signal the RTC
device doesn't support alarms. The drivers are now clearing the
RTC_FEATURE_ALARM bit for that purpose in order to keep the rtc_class_ops
structure const. So now, .set_alarm() is set unconditionally and this
possibly causes the alarmtimer code to select an RTC device that doesn't
support alarms.

Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to determine
whether alarms are available.

Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20210511014516.563031-1-alexandre.belloni@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 771b31018517a..976974edb355d 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -92,7 +92,7 @@ static int alarmtimer_rtc_add_device(struct device *dev,
 	if (rtcdev)
 		return -EBUSY;
 
-	if (!rtc->ops->set_alarm)
+	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -1;
 	if (!device_may_wakeup(rtc->dev.parent))
 		return -1;
-- 
2.53.0




