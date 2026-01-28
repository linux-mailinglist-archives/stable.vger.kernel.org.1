Return-Path: <stable+bounces-212018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCQjLv8semnd3gEAu9opvQ
	(envelope-from <stable+bounces-212018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:36:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB166A40F0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA78B301641D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5F036C5B5;
	Wed, 28 Jan 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1J8ZbNN2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEAD36C0D5;
	Wed, 28 Jan 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614124; cv=none; b=h2PvyRXbJOfO0RVnzN7qGJW95AlYKPhLZK3ohuDMKLW/jeezeXzqpOim4XKjWqhfHePassj0Q5xuYBK8HpBQAVu74+g6vzKfZJRBBiobvqVaevCmivwtPX+iKlEKAdhow5bKVwC9MWTo1+KFmKIKOG5BdtTOT8wkwf3zLbr1X1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614124; c=relaxed/simple;
	bh=55iESlkvDdy1DAlTHepAP+4HQYZu46rvubKwhQBBIJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB879x3lOu4EYih9BnfFAH3Clu3K6qA41Ugp4FwZxtEg2h/frkxl9nrOwlZkMdiQb5oqa1nUpFABP+QA6YVSd16jRVXTGbo+NUABxE8ztnqm5ACX4KwQrDJhFsU9lhPIsSRMCUhY/HZgsSNu8FYL24fBVDgQrSpkbzn77RW1wso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1J8ZbNN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A65C4CEF1;
	Wed, 28 Jan 2026 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614124;
	bh=55iESlkvDdy1DAlTHepAP+4HQYZu46rvubKwhQBBIJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1J8ZbNN2RrzypmNnrHKZSmDjTyDjw+e/hkA9gaHvGlFUyTm3wN8QmtpfNNrefxgCJ
	 0OYuZR6zYxp04vIkyBHidoCYrwxzlfRtqV00wBv/3k80tCfmX5OKuj9C2XaqF7uIaK
	 Xk9RoKsbS9+tgMWQGy5+qpFnHuZB0JtB+RkZjV+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leonid Segal <leonids@variscite.com>,
	Pierluigi Passaro <pierluigi.p@variscite.com>,
	Stefano Radaelli <stefano.r@variscite.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 035/254] phy: fsl-imx8mq-usb: Clear the PCS_TX_SWING_FULL field before using it
Date: Wed, 28 Jan 2026 16:20:11 +0100
Message-ID: <20260128145345.965751746@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212018-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,variscite.com,nxp.com,gmail.com,pengutronix.de,kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,pengutronix.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email]
X-Rspamd-Queue-Id: BB166A40F0
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Radaelli <stefano.radaelli21@gmail.com>

[ Upstream commit 8becf9179a4b45104a1701010ed666b55bf4b3a6 ]

Clear the PCS_TX_SWING_FULL field mask before setting the new value
in PHY_CTRL5 register. Without clearing the mask first, the OR operation
could leave previously set bits, resulting in incorrect register
configuration.

Fixes: 63c85ad0cd81 ("phy: fsl-imx8mp-usb: add support for phy tuning")
Suggested-by: Leonid Segal <leonids@variscite.com>
Acked-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Link: https://patch.msgid.link/20251219160912.561431-1-stefano.r@variscite.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index f914f016b3d2c..043063699e064 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -206,6 +206,7 @@ static void imx8m_phy_tune(struct imx8mq_usb_phy *imx_phy)
 
 	if (imx_phy->pcs_tx_swing_full != PHY_TUNE_DEFAULT) {
 		value = readl(imx_phy->base + PHY_CTRL5);
+		value &= ~PHY_CTRL5_PCS_TX_SWING_FULL_MASK;
 		value |= FIELD_PREP(PHY_CTRL5_PCS_TX_SWING_FULL_MASK,
 				   imx_phy->pcs_tx_swing_full);
 		writel(value, imx_phy->base + PHY_CTRL5);
-- 
2.51.0




