Return-Path: <stable+bounces-272146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jc5rELRYS2ooPwEAu9opvQ
	(envelope-from <stable+bounces-272146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:26:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4362070D840
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 09:26:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ltJQNxvt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272146-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272146-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26D8D308007C
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E34D2EC5;
	Mon,  6 Jul 2026 06:56:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B93DFC8D;
	Mon,  6 Jul 2026 06:56:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321000; cv=none; b=RnSIiDSqh9MJErvw9uYxrIN6TWkERzOIwGmlf4Qv4D6DjtduZVmE4fQmxOV+Rb6zBffVoMA8YtFWz2aYzIhyae+6nImTP5rdcawT714arokFno8EqqQi9wvdzyJDpqn7FeBfdLclDaeVBT3Dqorv09dQMfvEFRGoUc4DFv52eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321000; c=relaxed/simple;
	bh=NuH8cpCJLVF+IxX9TRFldDm8Gwg05+IpaMhRPmcfNiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBpT7KNyaEn2ZrAFoiabuKLd9Zz0gph54z8Vp0Iwgn3rdIJPDXebLw8yYar21cA5oyyttlZfR+OoVi0YZoGMf3Cgla7Rzi5Ch1rfm9ux30wxoNW2nV1EV6agHEY1dy/+xnwqqYxRXpPsXkZrhj2xeNBNJ84aacDvrsEhxj27MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltJQNxvt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E671F00A3D;
	Mon,  6 Jul 2026 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783320987;
	bh=2hQHBwjnlwqn6dPE3I0HghH4cOLWxdH4aGvpuK1BKR8=;
	h=From:To:Cc:Subject:Date;
	b=ltJQNxvtZQBcF3ikQATIetZQg6U+kzmKWAhm2jQXrLiArEMvh9MU6FDW770gd4aSL
	 1bR4GYUi7viobCEyvuK2bq4A+66F6rOUUCA3FLmDoggz8rUrIDql1t5nrwaWgyXEA9
	 mr7JM1v1wuGvVTEcuE3BrnNkFqnIwll/qJKdsbxXLbXPcvXv1QFasZDl2CvZfWESt+
	 4zzjGY83KUFRzBHahMmPcucXwjqKSen+Qt9ukjVxcQ4FDtQLRhkgv/Kd51sd9dowyu
	 7MpIeLF/8G31QkMHzoriRi5z7YBKfzaLK/VaKFKJfTNst9zyrs0a4UQdb+I29XQ905
	 Po0C/kRgStXOA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgdFg-00000001dJ7-37Da;
	Mon, 06 Jul 2026 08:56:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-remoteproc@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH] remoteproc: scp: fix device reference leak on failed lookup
Date: Mon,  6 Jul 2026 08:56:14 +0200
Message-ID: <20260706065614.389412-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,kernel.org,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:lgs201920130244@gmail.com,m:linux-remoteproc@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,m:erin.lo@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272146-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4362070D840

Make sure to drop the reference taken to the SCP device when attempting
to look up its driver data before the driver has been bound.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 63c13d61eafe ("remoteproc/mediatek: add SCP support for mt8183")
Cc: stable@vger.kernel.org	# 5.6
Cc: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/remoteproc/mtk_scp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 85a74c9ec521..436656bdfa8b 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -36,6 +36,7 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *scp_node;
 	struct platform_device *scp_pdev;
+	struct mtk_scp *scp;
 
 	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
 	if (!scp_node) {
@@ -51,7 +52,13 @@ struct mtk_scp *scp_get(struct platform_device *pdev)
 		return NULL;
 	}
 
-	return platform_get_drvdata(scp_pdev);
+	scp = platform_get_drvdata(scp_pdev);
+	if (!scp) {
+		put_device(&scp_pdev->dev);
+		return NULL;
+	}
+
+	return scp;
 }
 EXPORT_SYMBOL_GPL(scp_get);
 
-- 
2.54.0


