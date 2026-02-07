Return-Path: <stable+bounces-214795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPXmG19Wh2kRWwQAu9opvQ
	(envelope-from <stable+bounces-214795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:12:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7A8106580
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 386903016821
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AA352FA4;
	Sat,  7 Feb 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWwQDSCH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13E352FA0
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477079; cv=none; b=PGtzbLgNGPi2oS+EG8tGFu98vuONc+Clx3oTEy5b/i9jhzo529Hhvh9fmm2CDwExbWhnBa9laZ15wBA+E86Y70ExGk9qV7oS/E0lykl99EXV/rTMzYRcnUhxw5H9L47oeROZ4GNMS5HHIucZxARVp5LFpzQhBjRzlN8WuTqBAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477079; c=relaxed/simple;
	bh=2qPqrW5PsS8Lo9RfUDYFxPaDfqg76il9NQi9IMiRkOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLTYZk9rM9QimmYx7vgnB9p/2IN7X3dgko0MMItdmMg0CrLPboBfBgGojuGK8SUK+ir+S3aZHxcGPcuwArO82+nTnJFhWo979Wxgp0/poVs7Z81BYhhD2/UwyT25Q5LFKAxQ5LDllsxzuGz5Eoe1yOD91QK4GrPkdw+AEz3q3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWwQDSCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7BC116D0;
	Sat,  7 Feb 2026 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770477079;
	bh=2qPqrW5PsS8Lo9RfUDYFxPaDfqg76il9NQi9IMiRkOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWwQDSCHLc/G4hi/Gi/rAo07/5WxOOuaPL6uhoUGNIKI7X/iIfxIVNor1e2zPSLdr
	 Me2g0gDyTRDH84ljNRibNbn2VkLRR3K/+bMt6Li24/DgBJIrk3YXy1XcunhZgsxLtA
	 P/qoBvfHfJUWyhO7TUFDuBBOYDwVddiRRQJ5x1k20L45lfqB/pzzLnhm4nJ6UjU3+i
	 vKI3btAH83UzUQKQ0//iGXESJdSBQoqQn74WBXk1n845RxSkB4b7au0tQBEce/61oA
	 7aLbRdD/KLusshu/2tdUr9v3PFKYYXlu9bKLXnkhlIuAoava63hstuJvCeHUjDVDE5
	 YvzztsKcIh01Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx8mp-blk-ctrl: Keep gpc power domain on for system wakeup
Date: Sat,  7 Feb 2026 10:11:16 -0500
Message-ID: <20260207151116.387280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020716-elaborate-unroll-e8cc@gregkh>
References: <2026020716-elaborate-unroll-e8cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214795-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
X-Rspamd-Queue-Id: EA7A8106580
X-Rspamd-Action: no action

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e9ab2b83893dd03cf04d98faded81190e635233f ]

Current design will power off all dependent GPC power domains in
imx8mp_blk_ctrl_suspend(), even though the user device has enabled
wakeup capability. The result is that wakeup function never works
for such device.

An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
is created to build connection with 'hsioblk-usb-phy2' and it depends on
GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
power domain 'usb-otg2' is off all the time. So the wakeup event can't
happen.

In order to further establish a connection between the power domains
related to GPC and block control during system suspend, register a genpd
power on/off notifier for the power_dev. This allows us to prevent the GPC
power domain from being powered off, in case the block control power
domain is kept on to serve system wakeup.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 9bc536ee1395f..e590e6653dba3 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -54,6 +54,7 @@ struct imx8mp_blk_ctrl_domain {
 	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8mp_blk_ctrl *bc;
+	struct notifier_block power_nb;
 	int num_paths;
 	int id;
 };
@@ -492,6 +493,20 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int imx8mp_blk_ctrl_gpc_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct imx8mp_blk_ctrl_domain *domain =
+			container_of(nb, struct imx8mp_blk_ctrl_domain, power_nb);
+
+	if (action == GENPD_NOTIFY_PRE_OFF) {
+		if (domain->genpd.status == GENPD_STATE_ON)
+			return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
 static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
@@ -593,6 +608,14 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		domain->power_nb.notifier_call = imx8mp_blk_ctrl_gpc_notifier;
+		ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to add power notifier\n");
+			dev_pm_domain_detach(domain->power_dev, true);
+			goto cleanup_pds;
+		}
+
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
@@ -602,6 +625,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		ret = pm_genpd_init(&domain->genpd, NULL, true);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to init power domain\n");
+			dev_pm_genpd_remove_notifier(domain->power_dev);
 			dev_pm_domain_detach(domain->power_dev, true);
 			goto cleanup_pds;
 		}
@@ -644,6 +668,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
+		dev_pm_genpd_remove_notifier(bc->domains[i].power_dev);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
 
@@ -663,6 +688,7 @@ static int imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 		struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
+		dev_pm_genpd_remove_notifier(domain->power_dev);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
 
-- 
2.51.0


