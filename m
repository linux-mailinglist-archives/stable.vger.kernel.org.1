Return-Path: <stable+bounces-227766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EICIFPaSvmnkTQMAu9opvQ
	(envelope-from <stable+bounces-227766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 13:45:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA32E5555
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8493011844
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646DD63CB;
	Sat, 21 Mar 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDENaXxl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280AE10F1
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097138; cv=none; b=hCa8OBBwvynBzhbOxulzl3m59TLUWlD5BHZGhBJE5+m561TC3Op8zd0viN5iAGBRg0aQ5ml/vD9vV+nYtYNEHa3pkc5FZ0hc09cXFSFSdeQYIz1SGPR/TpSoBpLSj87y5iaolw2rlcjsYEAdg9DnHzkq3e+RhHf6mjfmdXtyC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097138; c=relaxed/simple;
	bh=x4OJRCluuyUS6eySOrZTCxqkR+tSwFaY3ATrG2yLEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJLJB11pGJYXcYVxurH5aK/eQNjKGVzyQByWSx+IQjzYSwTKp7c+1YoxKnFd3fq9zQA0FhY6DePzlb3yYivWfmIMGSt7e1j/+rVtKd34v91ruL/V8DWGEQZQ53S/LNfvxDOBSmEb+lUy+Ho72x1YggOZbKDIEbLz8/lZ3CCtJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDENaXxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E810C19421;
	Sat, 21 Mar 2026 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774097137;
	bh=x4OJRCluuyUS6eySOrZTCxqkR+tSwFaY3ATrG2yLEoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDENaXxlTa98GC2DET9KNKgmoLZQ/n9UeE1Mjueirac/lRb/1siin43CLcNFg2lco
	 hW028i5skZ+K2CV2OTpdZKzdEaWgFPUOmMCppC0ocgbvFlEE8KmEG4QjE8GP9d1gV6
	 9Xrn0Pl7Z+mORQRXru6T4zQhjHAXszt9waCnEfItHld3muYFz1k/k7q5uRfMpKtshB
	 a2Ue1GrmiNT0INWk4LwoxwQqYilI1Ml1rg696mkbP7TXGGYemxyb5m6/wxyH0OHjaA
	 fPx3APOGqnImVO47u03Xuah/ZLhQwV3/QhulZsE2k8VHysZfRVQ+07M0L8biPTarDU
	 17Sj1kQ8tNoew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: bcm: bcm2835-power: Increase ASB control timeout
Date: Sat, 21 Mar 2026 08:45:35 -0400
Message-ID: <20260321124535.271540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032026-crested-overjoyed-eaaf@gregkh>
References: <2026032026-crested-overjoyed-eaaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,gmx.net,linaro.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-227766-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,igalia.com:email]
X-Rspamd-Queue-Id: A2AA32E5555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit b826d2c0b0ecb844c84431ba6b502e744f5d919a ]

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
[ adapted unified bcm2835_asb_control() function changes to separate bcm2835_asb_enable() and bcm2835_asb_disable() functions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/bcm2835-power.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1e0041ec81323..6a82c66c6674a 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/bcm2835-pm.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -150,40 +151,34 @@ struct bcm2835_power {
 
 static int bcm2835_asb_enable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start;
+	u32 val;
 
 	if (!reg)
 		return 0;
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) & ~ASB_REQ_STOP);
-	while (ASB_READ(reg) & ASB_ACK) {
-		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
-			return -ETIMEDOUT;
-	}
+
+	if (readl_poll_timeout_atomic(power->asb + reg, val,
+				      !(val & ASB_ACK), 0, 5))
+		return -ETIMEDOUT;
 
 	return 0;
 }
 
 static int bcm2835_asb_disable(struct bcm2835_power *power, u32 reg)
 {
-	u64 start;
+	u32 val;
 
 	if (!reg)
 		return 0;
 
-	start = ktime_get_ns();
-
 	/* Enable the module's async AXI bridges. */
 	ASB_WRITE(reg, ASB_READ(reg) | ASB_REQ_STOP);
-	while (!(ASB_READ(reg) & ASB_ACK)) {
-		cpu_relax();
-		if (ktime_get_ns() - start >= 1000)
-			return -ETIMEDOUT;
-	}
+
+	if (readl_poll_timeout_atomic(power->asb + reg, val,
+				      !!(val & ASB_ACK), 0, 5))
+		return -ETIMEDOUT;
 
 	return 0;
 }
-- 
2.51.0


