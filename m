Return-Path: <stable+bounces-247837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBDtEQ4/B2oCuwIAu9opvQ
	(envelope-from <stable+bounces-247837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:43:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53015552560
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF6EB3019A02
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBD04D990E;
	Fri, 15 May 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpFHQjxS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38434CA283
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859355; cv=none; b=BL2992CaMuEhmH03mKrOnv1ZKRoewwNIDvCMbNkI9P8F0H2LK0sBBbdkJBIRG8p3EM7Qea6uU1z0j+hsTKDb7hs9pyyerw5xu9tXfz5ZgPnR8jiXvXdpxp6SvOutjTIDpnyAs/p/qtfnP21KOU4c1F9+W84CNTVClp3ozX1JtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859355; c=relaxed/simple;
	bh=yjCyp8jHSEZOZMZQB6iT5govccfF7u1znvx3ccqw4Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoYdCTYmY+Z1kxbQTSPbQ6bxZeGTmnds025Iikl8FI3/7dDvCWJw1+5Ssb+20WwDNQLAowigcVHmEkfYwv1JWxE/ZHPDjvgFGPdOVmO3k9CWHe2/xcKJtNt743iSFweIKD167+vOc76X9VcKHMhh18LTeYvg8C1unRDZGDsolzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpFHQjxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73499C2BCB0;
	Fri, 15 May 2026 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859354;
	bh=yjCyp8jHSEZOZMZQB6iT5govccfF7u1znvx3ccqw4Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpFHQjxS1zzSuQh1VrSKqnFTjd+kD3vIJpB8Ezztw7HKP1auz2/84vdBeCkemOHWT
	 inZFjrDT967f9kzqm66d6uGE+Q84/F/fQYCEi2qjSzi5ZOZJd+khbswtNIcwAFhHvV
	 6eQyhSHGpNk5FlC7yXnXARdiCYrfOMjFZ/ZPbmqB9Fg9qdhO6DvIq1iCsFoqmr3v19
	 vblibJmaaIK1gTl30TAjFxNuug3La/Qwnaei2dVMnotfXkJ87gVVYEPXAS5irn3KIy
	 p52eXYP9VEtPmypGdX2Ho/9I/oQSynIEnlfn6LF2vvNoh3NmifqSDOenIQRYwcjUPx
	 gTi3rS8wTQ//w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Fri, 15 May 2026 11:35:51 -0400
Message-ID: <20260515153551.3299759-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051202-cadmium-hazy-b989@gregkh>
References: <2026051202-cadmium-hazy-b989@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53015552560
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247837-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Action: no action

From: Ulf Hansson <ulf.hansson@linaro.org>

[ Upstream commit 26735dfdd8930d9ef1fa92e590a9bf77726efdf6 ]

If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
genpd calls pm_runtime_enable() for the corresponding virtual device that
it registers. While this avoids boilerplate code in drivers, there is no
corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().

This means these virtual devices are typically detached from its genpd,
while runtime PM remains enabled for them, which is not how things are
designed to work. In worst cases it may lead to critical errors, like a
NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
reported. For another case, we may end up keeping an unnecessary vote for a
performance state for the device.

To fix these problems, let's add this missing call to pm_runtime_disable()
in genpd_dev_pm_detach().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
Cc: stable@vger.kernel.org
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a19a1f70adb2a..51fa0bb24936c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2667,6 +2667,7 @@ static struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -2676,6 +2677,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Check if the device was created by genpd at attach. */
+	is_virt_dev = dev->bus == &genpd_bus_type;
+
+	/* Disable runtime PM if we enabled it at attach. */
+	if (is_virt_dev)
+		pm_runtime_disable(dev);
+
 	/* Drop the default performance state */
 	if (dev_gpd_data(dev)->default_pstate) {
 		dev_pm_genpd_set_performance_state(dev, 0);
@@ -2701,7 +2709,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
-- 
2.53.0


