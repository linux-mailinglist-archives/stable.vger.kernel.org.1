Return-Path: <stable+bounces-247969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGKJOU1nB2rG1wIAu9opvQ
	(envelope-from <stable+bounces-247969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:34:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159C5564E7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B2C323AB52
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E2305674;
	Fri, 15 May 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDZ4LCpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D83FF1DA
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860539; cv=none; b=DH5s/8suGacQ8IBn5exziw53T/8PceOaf2FEf+sh/LfFyIMyBRuIOhQ9gL5xsAuGwvJnH+8BzD1juxSgOe4lhf0Y7mEEBB0bvfqNZv4GIuX3jJL8N0OnOo8AqfEjnO5CBYfLGfCgsxkn2LIAKA1z07Qk9h8NPGWcl+M+SoAvjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860539; c=relaxed/simple;
	bh=SdcESA1KBthKZBy6Q0fyf/mtjp0vX/agNlCC+h6rogs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FP8eb8D6qAO6GOTePIvVKkbHmMqaPKIMfVfRDMTg+EvaHoY3pEnydWpkrzkQJOMAn/2+yTJJx17gEzxhWA4ex0Lw3HiZqQ6pt+YIZLFlFnqpbnV36oX3VoJTOlji0cfaRqnCwjxQcYYAoYzvGPEa9Qgb/yu24lkJWTSJP7EpKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDZ4LCpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F1C2BCB0;
	Fri, 15 May 2026 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860539;
	bh=SdcESA1KBthKZBy6Q0fyf/mtjp0vX/agNlCC+h6rogs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDZ4LCpAeeDNeAMTJMIUTU+AiY6mWV6LNx5yelKaqrKcnPbGg4laKE75Kf5BAtNaV
	 S9JquWlZyvVDFFJitZBX1OXRV10ckRwltBi2OAqjM9vNGgly4IUMaTGfTIJLeBrHca
	 1Se6ICqYHXXeg72Zr7tdYYTA8wTrkXWPMxpnR2LU48Bu/YQUcAiUJxg0httVeN5SLW
	 ps+5zmyripM7fdA9NwiGlabRuVaNSg6HHZgz92NMfbNIxnBwjb1nvVfyFsuDgk0dp0
	 Us4F+DiFhOR2MczBt2uBcWEyiVHML8GQ1fCmM208swnN8//W+OzapozgwlfOyByETw
	 swHB2+XETfeZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Fri, 15 May 2026 11:55:36 -0400
Message-ID: <20260515155536.3359591-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-thirsty-mossy-0961@gregkh>
References: <2026051203-thirsty-mossy-0961@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5159C5564E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247969-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email,glider.be:email]
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
index 005ece1a658e5..b284f9284b88e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2596,6 +2596,7 @@ static struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -2605,6 +2606,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
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
@@ -2630,7 +2638,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
-- 
2.53.0


