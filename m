Return-Path: <stable+bounces-253361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKRIFBoIDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:14:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB210598016
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C1C31DFD8E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7B43FE362;
	Wed, 20 May 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esvmMSit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13C3EAC82;
	Wed, 20 May 2026 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303081; cv=none; b=CDNPwproC0//2GJHqy3qcNWYDfU/at1jjaraLK1YLEnd4iBoBO+LSrT14eFUFjU8pWmBK8Eqtna2+YAmh9yNJ3H0eHSQ0x+KkF8m3hqPZnNnstN3b/9Kks937blOdnx+0csj5f/Ly4jvQUYv7Jd6LRU7cjiYVPw7YyvOHU8HPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303081; c=relaxed/simple;
	bh=lNub2ggBlQXkunL2L4czlJgZHOtUJsuvSaeKLp5fJ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5U3WETP6+ahGR3BtmF/wqEzf2lsTO5lO15Ia7TLBCzkNBA8h3diyx+AMtkeMn38oGyk79IyCwiJphyyHLdQ298q0cjq/LtZ01rU5nVWK0YPsmSAvl3rXV1h2HF2fdIp+1rX1a0tmXnH8zJGnFziU4O5D/TDFThY3B/qtpAiSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esvmMSit; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0F1F000E9;
	Wed, 20 May 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779303077;
	bh=j+JWgUdKTvZwCvBC2hngINbVwZmpoiP+HbJEOscNrUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=esvmMSitHbktN1UQBQ69Eo4LyMKHMh5MxULJmI5w5zLI0RTK2+GWnW/gg36ILssf0
	 TQYluL72ZQClM1JagJzpgW8I4xYhIflY8jmXAHpJ9GC6VvnXyVyR8axVSG0SweSmqQ
	 Pyc6FBBnkxD4XYOFENrSNrr/zFLeCWT5xire45t8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 484/508] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Wed, 20 May 2026 18:25:07 +0200
Message-ID: <20260520162109.081111646@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253361-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux-m68k.org:email]
X-Rspamd-Queue-Id: EB210598016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2676,6 +2676,7 @@ static struct bus_type genpd_bus_type =
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -2685,6 +2686,13 @@ static void genpd_dev_pm_detach(struct d
 
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
@@ -2710,7 +2718,7 @@ static void genpd_dev_pm_detach(struct d
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 



