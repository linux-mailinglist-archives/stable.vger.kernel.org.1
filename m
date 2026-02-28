Return-Path: <stable+bounces-220433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMYHEHdJo2nx/AQAu9opvQ
	(envelope-from <stable+bounces-220433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9581C7BEE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFC2F309434E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDE3B4475;
	Sat, 28 Feb 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExDCBBPk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8063B446D;
	Sat, 28 Feb 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300323; cv=none; b=ZkcR5HHBP6R6K8aWpMT8b75oTxQH/DiM6+6RUUSXNlQEzHJCm1BNbUnu9ynw/mguLbvmizcZSKZgn3JFJ1DnossJ/xrdqHW+5spgzIKwtcAt9ZqNl+tq1JfNb2W9+WGbyH7WHrEExK4ppQw++OavhQ94UPZ6DKjKDxg3+6DG9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300323; c=relaxed/simple;
	bh=zewmezckcapVIGLR/SEXo0DCkA/JWHsz4NUGR/Ja8jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjQbpLJ5114PaCPS2a2cqRkuVxNTd/UzFbPrPxyrqU9hGVr/cYO2iCXraxGssTOSqBWNj/zKkJdBzOUkHrTw+O/9LczmZVOkek3OgYTq4KY2tStJZ22Dh7i6ZxJ/cxqMXLB91cVNu3JLWPmtlgws4lRl/gPKlOxR63/unB8cNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExDCBBPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B9C116D0;
	Sat, 28 Feb 2026 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300322;
	bh=zewmezckcapVIGLR/SEXo0DCkA/JWHsz4NUGR/Ja8jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExDCBBPk5VpTveT8Y6pqBlPviUCufbkZoTRHMsYXZrQ4nRP3J1SbEhzrY0JxrGlHb
	 sImfazxeT8dI8yTK3hP3zGH8QbuLWJNgeSHni9IuVVnlguAZHY2wUc2sEpWuZ9ejkt
	 WqZNyqet8Segc0ruX4QIOs1W3OpIl4riKeTehsurZGqV5bi08HtHvszgenN2O9M1sw
	 PoC57gh5qLq+QM0MFKCJ3eXjts9P2do6/SyhYwHyjYRsGU8oP9UrL+6fj5f0g7boE/
	 d+4a2ufmQh+MHOj7NTAIt4Vise0eYwak9g2Jg1f/KXHPLMWSP4yNiIBCp4j0C5ewbD
	 w5ehH0YXs8+Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 354/844] mailbox: imx: Skip the suspend flag for i.MX7ULP
Date: Sat, 28 Feb 2026 12:24:27 -0500
Message-ID: <20260228173244.1509663-355-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220433-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 7B9581C7BEE
X-Rspamd-Action: no action

From: Jacky Bai <ping.bai@nxp.com>

[ Upstream commit 673b570825ace0dcb2ac0c676080559d505c6f40 ]

In current imx-mailbox driver, the MU IRQ is configured with
'IRQF_NO_SUSPEND' flag set. So during linux suspend/resume flow,
the MU IRQ is always enabled. With commit 892cb524ae8a ("mailbox: imx:
fix wakeup failure from freeze mode"), if the MU IRQ is triggered after
the priv->suspended flag has been set, the system suspend will be
aborted.

On i.MX7ULP platform, certain drivers that depend on rpmsg may need
to send rpmsg request and receive an acknowledgment from the remote
core during the late_suspend stage. Early suspend abort is not
expected, and the i.MX7ULP already has additional hardware and
software to make sure the system can be wakeup from freeze mode
correctly when MU IRQ is trigger.

Skip the 'suspend' flag handling logic on i.MX7ULP to avoid the
early abort when doing suspend.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/imx-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 6778afc64a048..003f9236c35e0 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -122,6 +122,7 @@ struct imx_mu_dcfg {
 	u32	xRR;		/* Receive Register0 */
 	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
 	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+	bool	skip_suspend_flag;
 };
 
 #define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
@@ -988,6 +989,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xRR	= 0x40,
 	.xSR	= {0x60, 0x60, 0x60, 0x60},
 	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
+	.skip_suspend_flag = true,
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
@@ -1071,7 +1073,8 @@ static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 			priv->xcr[i] = imx_mu_read(priv, priv->dcfg->xCR[i]);
 	}
 
-	priv->suspend = true;
+	if (!priv->dcfg->skip_suspend_flag)
+		priv->suspend = true;
 
 	return 0;
 }
@@ -1094,7 +1097,8 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
 	}
 
-	priv->suspend = false;
+	if (!priv->dcfg->skip_suspend_flag)
+		priv->suspend = false;
 
 	return 0;
 }
-- 
2.51.0


