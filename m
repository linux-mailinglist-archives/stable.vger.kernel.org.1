Return-Path: <stable+bounces-212224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NPQK0gwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214CA487B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8980315A8C1
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E222F5A36;
	Wed, 28 Jan 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSJ5edJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF72F5485;
	Wed, 28 Jan 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614800; cv=none; b=t27GwcnGoabSCeffFrjvOmQa34mkUqG/fuNy0RCPZyizEicXlzZPdMl95+S5ZJ2jEqTfIXOISshIW50NXNU4OThvDPs4HMlgNLQ5Tvf1elGtqhjHoxcDufM59Gm0JZQbg2OXSkfI9VbOyBp9A0Z3ZwyTgcm69YbIvs+99i+qppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614800; c=relaxed/simple;
	bh=yRgPrNQqh9U/KtIfr9Q5oJA9OMdTJFgw/Jln1fWU1p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbWMvttKd63mJF09C/olaPAevK8fsbegcKW7coHCszdZLr9fXbe1A4xbhrG/EuR6NKxiXIQLBpoCGvA/fCI5X+XTIJGjd9nWIBwAjBQhMx7253IKiVTxH2LpUqXJBenR2VmxZyCLnyXshSXWjbA07TrIhKGpotfkNqLg1J4zULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSJ5edJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB92C4CEF1;
	Wed, 28 Jan 2026 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614800;
	bh=yRgPrNQqh9U/KtIfr9Q5oJA9OMdTJFgw/Jln1fWU1p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSJ5edJz+IhIyMZBIX9hEcaZzWOb9j2y/c/gpng2/wcC3LC7Z88Ae02kTTNlHfmL+
	 l5J+Zi9MMKtlUFTK2uzIv3gsWbzTdF5DbzMWsU5+4OpRZoJBNq1jakcSsHuHmWEFrg
	 9jUcnm+/QZBc1hi9kC0hmlJwdTJ1hzD7/cMhtQVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Qian <ming.qian@oss.nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 213/254] pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
Date: Wed, 28 Jan 2026 16:23:09 +0100
Message-ID: <20260128145352.456226162@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212224-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,collabora.com:email]
X-Rspamd-Queue-Id: 3214CA487B
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Qian <ming.qian@oss.nxp.com>

commit 3de49966499634454fd59e0e6fecd50baab7febd upstream.

For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
and clock enable bits, but is ungated and reset together with the VPUs.
So we can't reset G1 or G2 separately, it may led to the system hang.
Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
Let imx8mq_vpu_power_notifier() do really vpu reset.

Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -845,22 +845,25 @@ static int imx8mq_vpu_power_notifier(str
 	return NOTIFY_OK;
 }
 
+/*
+ * For i.MX8MQ, the ADB in the VPUMIX domain has no separate reset and clock
+ * enable bits, but is ungated and reset together with the VPUs.
+ * Resetting G1 or G2 separately may led to system hang.
+ * Remove the rst_mask and clk_mask from the domain data of G1 and G2,
+ * Let imx8mq_vpu_power_notifier() do really vpu reset.
+ */
 static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[] = {
 	[IMX8MQ_VPUBLK_PD_G1] = {
 		.name = "vpublk-g1",
 		.clk_names = (const char *[]){ "g1", },
 		.num_clks = 1,
 		.gpc_name = "g1",
-		.rst_mask = BIT(1),
-		.clk_mask = BIT(1),
 	},
 	[IMX8MQ_VPUBLK_PD_G2] = {
 		.name = "vpublk-g2",
 		.clk_names = (const char *[]){ "g2", },
 		.num_clks = 1,
 		.gpc_name = "g2",
-		.rst_mask = BIT(0),
-		.clk_mask = BIT(0),
 	},
 };
 



