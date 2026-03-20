Return-Path: <stable+bounces-227588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Dw7DVqGvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:39:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97E2DECB1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D9C7308C771
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFD3D16EE;
	Fri, 20 Mar 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zXMh245G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A2399353
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027950; cv=none; b=cn0cCq9CWovgRlSAX1tA0+1Vpl5cAM1/V8SuiFnghcgZwRy73Y6tIHhbYEoXBa9rE/pCAa50tchf56hMB/XC/XTr9LV3pRiGPX7Yg7EvW3B4BnIlC6TaMo/0jDDjiYAD8CYTH3wkJYR5ZxcPnA9kEcyt/WjW5+WOW51basx2kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027950; c=relaxed/simple;
	bh=HaPs92QzjIxieQj++kxZK83O5bmhXOFfcy1YBIs8a6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ovrbSoqyLego+6wzR9CmJzRBMJgnemSdlygETSrmCufDA/sXmGaN5d0BOhUaD9xR400r8ceJ1H5PI7aW9Wp8YKun3Uw/ntbf9J4XPLxY13iWlV1tvgl87XoqBUb+JUo0pZXJOyU3v2Jq6KBjRXh5GUv1Z1kSPJDRYjTpUUadpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zXMh245G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAA7C4CEF7;
	Fri, 20 Mar 2026 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774027950;
	bh=HaPs92QzjIxieQj++kxZK83O5bmhXOFfcy1YBIs8a6M=;
	h=Subject:To:Cc:From:Date:From;
	b=zXMh245GWc4ILloTj77tXuv8jc0llfywUX9fSMePMgPfeELvxz2lfyE8IvOIuTG3i
	 kGZsowRKmrGGWp+GEkDYw8w1Hk6Zuqoqg19OriLoQilX9LR88XH2vOd9t67tH0oTOE
	 EDuNcIjcOxWiffRB9+FCEiU1KL1uCsBhISk/VZII=
Subject: FAILED: patch "[PATCH] pmdomain: bcm: bcm2835-power: Increase ASB control timeout" failed to apply to 6.1-stable tree
To: mcanal@igalia.com,ulf.hansson@linaro.org,wahrenst@gmx.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 18:32:25 +0100
Message-ID: <2026032025-rift-subsiding-e2e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227588-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[igalia.com,linaro.org,gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,gregkh:email]
X-Rspamd-Queue-Id: AC97E2DECB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b826d2c0b0ecb844c84431ba6b502e744f5d919a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032025-rift-subsiding-e2e9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b826d2c0b0ecb844c84431ba6b502e744f5d919a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Tue, 17 Mar 2026 19:41:49 -0300
Subject: [PATCH] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bcm2835_asb_control() function uses a tight polling loop to wait
for the ASB bridge to acknowledge a request. During intensive workloads,
this handshake intermittently fails for V3D's master ASB on BCM2711,
resulting in "Failed to disable ASB master for v3d" errors during
runtime PM suspend. As a consequence, the failed power-off leaves V3D in
a broken state, leading to bus faults or system hangs on later accesses.

As the timeout is insufficient in some scenarios, increase the polling
timeout from 1us to 5us, which is still negligible in the context of a
power domain transition. Also, replace the open-coded ktime_get_ns()/
cpu_relax() polling loop with readl_poll_timeout_atomic().

Cc: stable@vger.kernel.org
Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
index 0450202bbee2..eee87a300532 100644
--- a/drivers/pmdomain/bcm/bcm2835-power.c
+++ b/drivers/pmdomain/bcm/bcm2835-power.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/bcm2835-pm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -153,7 +154,6 @@ struct bcm2835_power {
 static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable)
 {
 	void __iomem *base = power->asb;
-	u64 start;
 	u32 val;
 
 	switch (reg) {
@@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 		break;
 	}
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	if (enable) {
 		val = readl(base + reg) & ~ASB_REQ_STOP;
@@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);
 
-	while (!!(readl(base + reg) & ASB_ACK) == enable) {
-		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
-			return -ETIMEDOUT;
-	}
+	if (readl_poll_timeout_atomic(base + reg, val,
+				      !!(val & ASB_ACK) != enable, 0, 5))
+		return -ETIMEDOUT;
 
 	return 0;
 }


