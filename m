Return-Path: <stable+bounces-247822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GjjEBY6B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:21:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D2455213D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A624301E80D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147E49252A;
	Fri, 15 May 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwT+Vfeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E64921B1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858437; cv=none; b=tdYLNJR3oEfnNhIyioUm94BHh01Fa/NxghdGxCUEZcum/UiJeTtidbAWPXf4COY0hrWObKGUJOf0bNfovhp77UObuFh59txuSwtrSOePhoIfWjf49p6f5wQlC3qw5xyQBxbdo1NC/Tu9ncE95ARimFmSho9yDXWZrKXiAsLmo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858437; c=relaxed/simple;
	bh=CHUfEvzXSkSamIz9pqGPDpnt5w4q7qfQssWK3gEiZLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFn36uog5sCXyMPxWYgbL69pYF7+2EBiIY7mXI3tVBqjWQNhGOxKzc2jHT22KJl2wXJsTYdozT8BdGfIoDjiiKYgKc2yv6tBt4Nn+a6h3cX1iQqlscaRkg5vJqn+QuQhtx32jd0HMJaGNJ0UNhv+QxxnfL96lzxKx4U/ZiBUi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwT+Vfeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1551C2BCB7;
	Fri, 15 May 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778858436;
	bh=CHUfEvzXSkSamIz9pqGPDpnt5w4q7qfQssWK3gEiZLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwT+Vfeh0FLyP/FEAtXznKtakm2fPk5960DhAWlPkDhecqZ9jKECXrhToDB77e2B7
	 GY8/iWllqXERb07MlWjQr48WZCjnrkix70tjh7W3d1RYrTRMgOCZrOWQzt9zN7qipF
	 Wt7+BCvvnFrZ5Gbg0kycVXPmi5bEaLMZM2wVFfDc0NNNjs2DZ4oViHz40vBxAhnVtQ
	 PPfbPJtobaKw4vJuJloxoP824RZhCY8VHxBN8LYQLsfBOD3X03b4PiOqwcOptxjTNg
	 5bLZDitusFD/cNwPG7N02ZCcqAKZ7Ys3BdI4rQTJdwycz7YMmg9usgVt1LN5xx6Rgk
	 vnBZc953iSKFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Fri, 15 May 2026 11:20:34 -0400
Message-ID: <20260515152034.3277396-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051202-enjoyably-emcee-b24b@gregkh>
References: <2026051202-enjoyably-emcee-b24b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8D2455213D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247822-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
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
index d1dae47f3534b..5bee0a8975003 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2676,6 +2676,7 @@ static struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -2685,6 +2686,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
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
@@ -2710,7 +2718,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
-- 
2.53.0


