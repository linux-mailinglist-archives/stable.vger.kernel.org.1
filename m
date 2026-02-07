Return-Path: <stable+bounces-214796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hdTAGfVXh2k7XAQAu9opvQ
	(envelope-from <stable+bounces-214796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:19:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C510658F
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C0023013715
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DEB353EE3;
	Sat,  7 Feb 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny/qrsut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B331ACEDF
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477554; cv=none; b=G+acuYYIpZdi6Gc4bdg98bhHVp21aEvKRCTIRY9hERKjOs3UrpGhT8ZI7Co6RaN6AHR3+9yXnazKBsTZlyV0MLqeNPHcWTzfxfgjxHhzOcYfebRt7L7JBcLiCfdGNkSqYad7S+2fmSC1wKAp/AQ7VWumZZ9EWfOQaNtViIp9E3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477554; c=relaxed/simple;
	bh=i1Md6ceInSaSJmDnkKq499az3VRfcThBlf/r2bdrdZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeX6XwrVS9xK0XL+jZ2cTg7fwnzdXH/to2nSh8ALsun7MJYAKkfysTnpDB0hnSynTJBHaYsMUVzzMvDrcA6fgzziC6qyoRVtz81BhujYCY9hgeFXX9qszqMIjOcLBWlM+gtqx5984gtR+ly2QwQAB4ZEXZv56ubAseUTUH3r8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny/qrsut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE5FC116D0;
	Sat,  7 Feb 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770477553;
	bh=i1Md6ceInSaSJmDnkKq499az3VRfcThBlf/r2bdrdZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ny/qrsut7Y5rngvJSoDaz9fuskFWbhA3LB1ol3XHvaXh8GPHDJd7ze141NB0F9M1P
	 d2WEk+ND1uhxDhh5VnB5ufRHRE5p++a4WcScI7d8/XSy6NuWla8WL/FuhADA57GNo/
	 kUWY3Ve8B95YpO6iKciU6NyL+L6p/9DVIcloTFGbJZSr3n/Rj2Bwp5l1TaX6xsBS8I
	 vNI+HPOQvOEG8GgeqMlkDcMWdS5gZhWyxTPdVR74pNi05zYEy4AVDO3UnS4r6FP5NW
	 mQ2mjFwMz5VqNFFWDdLadBHB9vcllcB0hoOOGfC/4xohW4DqANHYEau1zs7Eq/BQqh
	 JITMVWk3pp/JQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup
Date: Sat,  7 Feb 2026 10:19:11 -0500
Message-ID: <20260207151911.391123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020740-jubilant-willed-0be6@gregkh>
References: <2026020740-jubilant-willed-0be6@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214796-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,nxp.com:email]
X-Rspamd-Queue-Id: 722C510658F
X-Rspamd-Action: no action

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e2c4c5b2bbd4f688a0f9f6da26cdf6d723c53478 ]

USB system wakeup need its PHY on, so add the GENPD_FLAG_ACTIVE_WAKEUP
flags to USB PHY genpd configuration.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 9bc536ee1395f..104b39b7194f5 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -42,6 +42,7 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char * const *path_names;
 	int num_paths;
 	const char *gpc_name;
+	const unsigned int flags;
 };
 
 #define DOMAIN_MAX_CLKS 2
@@ -166,10 +167,12 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
 		.gpc_name = "usb-phy1",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY2] = {
 		.name = "hsioblk-usb-phy2",
 		.gpc_name = "usb-phy2",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE] = {
 		.name = "hsioblk-pcie",
@@ -596,6 +599,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
+		domain->genpd.flags = data->flags;
 		domain->bc = bc;
 		domain->id = i;
 
-- 
2.51.0


