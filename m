Return-Path: <stable+bounces-187296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51713BEAAAA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27F67C4E12
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB44330B0A;
	Fri, 17 Oct 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAMBlteo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B630330B0F;
	Fri, 17 Oct 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715675; cv=none; b=q+1qilMb2njv65SoJ/g66VYIj4DEWxRofUhgjJyCS8k1R4eYB9frWrAO+5KPwfe7llKh+/DhYm+mqFYhYAFrbwJcUvLD4jMK6hEhf2c7XGh/5qR1ufyKmgQ5KkUGWPNIbvuv+KpvUVhc+UJdSa10Mybj708wlR3pSv+kSoVmb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715675; c=relaxed/simple;
	bh=sOEWN7onPNQwrblPCuq0FCZ0eL4EeNlt5y3nu8Q+6cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F14Hm1WgcEj9fzoKIe3R2OK7hZenx8S4jmZu4k4KFDkrAWWPYjaSVpdUtM8SeKUyt7KgE0B43WfNCIiKm5gOivj1odg7By8fkXfdLB2di5i/cnXHWCoLdcZMomq7cwYbFEtu+BF33bsXMPkKE9QN2MG4M5MiOSuA2L1G+zkqMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAMBlteo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AB7C4CEE7;
	Fri, 17 Oct 2025 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715675;
	bh=sOEWN7onPNQwrblPCuq0FCZ0eL4EeNlt5y3nu8Q+6cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAMBlteophL1PPlIpE4qJOUTe4zDNVQxVmraaKGNC80rIpnk5izn5e9VEbhkzMMQg
	 56BbrPjPgIYghhC90e1Bk7eA/TyoU99hc+K4z8uHOQd/XAAo5Afq5rWdaI+79a3vZe
	 JEubvox3pmPWlJq8cRD6tW5+KU948QTM/tD/n2vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Esben Haabendal <esben@geanix.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.17 271/371] rtc: interface: Fix long-standing race when setting alarm
Date: Fri, 17 Oct 2025 16:54:06 +0200
Message-ID: <20251017145211.880030361@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Esben Haabendal <esben@geanix.com>

commit 795cda8338eab036013314dbc0b04aae728880ab upstream.

As described in the old comment dating back to
commit 6610e0893b8b ("RTC: Rework RTC code to use timerqueue for events")
from 2010, we have been living with a race window when setting alarm
with an expiry in the near future (i.e. next second).
With 1 second resolution, it can happen that the second ticks after the
check for the timer having expired, but before the alarm is actually set.
When this happen, no alarm IRQ is generated, at least not with some RTC
chips (isl12022 is an example of this).

With UIE RTC timer being implemented on top of alarm irq, being re-armed
every second, UIE will occasionally fail to work, as an alarm irq lost
due to this race will stop the re-arming loop.

For now, I have limited the additional expiry check to only be done for
alarms set to next seconds. I expect it should be good enough, although I
don't know if we can now for sure that systems with loads could end up
causing the same problems for alarms set 2 seconds or even longer in the
future.

I haven't been able to reproduce the problem with this check in place.

Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
Link: https://lore.kernel.org/r/20250516-rtc-uie-irq-fixes-v2-1-3de8e530a39e@geanix.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -443,6 +443,29 @@ static int __rtc_set_alarm(struct rtc_de
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
 
+	/*
+	 * Check for potential race described above. If the waiting for next
+	 * second, and the second just ticked since the check above, either
+	 *
+	 * 1) It ticked after the alarm was set, and an alarm irq should be
+	 *    generated.
+	 *
+	 * 2) It ticked before the alarm was set, and alarm irq most likely will
+	 * not be generated.
+	 *
+	 * While we cannot easily check for which of these two scenarios we
+	 * are in, we can return -ETIME to signal that the timer has already
+	 * expired, which is true in both cases.
+	 */
+	if ((scheduled - now) <= 1) {
+		err = __rtc_read_time(rtc, &tm);
+		if (err)
+			return err;
+		now = rtc_tm_to_time64(&tm);
+		if (scheduled <= now)
+			return -ETIME;
+	}
+
 	trace_rtc_set_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }



