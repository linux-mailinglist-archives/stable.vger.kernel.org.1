Return-Path: <stable+bounces-211056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPnbLSsqcWniewAAu9opvQ
	(envelope-from <stable+bounces-211056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:34:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFE65C40E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 662A178A4D3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B33433507B;
	Wed, 21 Jan 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2svtZlM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC2316193;
	Wed, 21 Jan 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020290; cv=none; b=mYPAP78LKoB0bCscT/6UcJMlvJFqoflYMP+xdyT7IMuKkc/+98+3Pm7mKE2lWZN5mVQgm0iaW7hYEsP8odOa8sdVrnyJ+CfpqOhNnYlI4I2shjsPm4JE0YApv1MiT87VQdsF/gSoKEwKXsjM7oABmMpMuJEYSUF+3Xbr7u6fkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020290; c=relaxed/simple;
	bh=wwWMJW1mnc+4SnVwSAOA7GQzVXn27OS2mXoFOy2awlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvrsG74Ozf5sUiUj6v7XqNnteVUMWi7NbIM1C6wIvRfPxC++ZZP3Pmz+CPlnyf+Je9Te0wX2FkOyvbYYYS9g2pdEofffJUWBFt6vrhKof2yB9/jyBhoGtqeOXccLgZcBILkvcCUUSQFOMrhb6B9OVIKxVoihfGXPexSt9WfXD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2svtZlM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0058AC4CEF1;
	Wed, 21 Jan 2026 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020289;
	bh=wwWMJW1mnc+4SnVwSAOA7GQzVXn27OS2mXoFOy2awlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2svtZlM65ZJ9jMyTvVW6D8MSP/k0xdv44mcvXxP5CSq4WBfpJYNv/7m1T58pSJICc
	 wp1Vx8RBHph9+W9PQh/tKc6senCNvfmu9sMC0YqUXAYPAH3s1UYVKYKoTpWiTHhLkw
	 NsSHKYdz1NxijJqD/dPmUzfhrA6WV7OlZ17tzPUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Yang <xu.yang_2@nxp.com>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 115/198] phy: fsl-imx8mq-usb: fix typec orientation switch when built as module
Date: Wed, 21 Jan 2026 19:15:43 +0100
Message-ID: <20260121181422.692989535@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211056-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:email,msgid.link:url,toradex.com:email]
X-Rspamd-Queue-Id: 2EFE65C40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Franz Schnyder <franz.schnyder@toradex.com>

commit 49ccab4bedd4779899246107dc19fb01c5b6fea3 upstream.

Currently, the PHY only registers the typec orientation switch when it
is built in. If the typec driver is built as a module, the switch
registration is skipped due to the preprocessor condition, causing
orientation detection to fail.

With commit
45fe729be9a6 ("usb: typec: Stub out typec_switch APIs when CONFIG_TYPEC=n")
the preprocessor condition is not needed anymore and the orientation
switch is correctly registered for both built-in and module builds.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Suggested-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20251126140136.1202241-1-fra.schnyder@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -124,8 +124,6 @@ struct imx8mq_usb_phy {
 static void tca_blk_orientation_set(struct tca_blk *tca,
 				enum typec_orientation orientation);
 
-#ifdef CONFIG_TYPEC
-
 static int tca_blk_typec_switch_set(struct typec_switch_dev *sw,
 				enum typec_orientation orientation)
 {
@@ -173,18 +171,6 @@ static void tca_blk_put_typec_switch(str
 	typec_switch_unregister(sw);
 }
 
-#else
-
-static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device *pdev,
-			struct imx8mq_usb_phy *imx_phy)
-{
-	return NULL;
-}
-
-static void tca_blk_put_typec_switch(struct typec_switch_dev *sw) {}
-
-#endif /* CONFIG_TYPEC */
-
 static void tca_blk_orientation_set(struct tca_blk *tca,
 				enum typec_orientation orientation)
 {



