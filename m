Return-Path: <stable+bounces-256123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHQKO2KrGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:53:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E45F9CE2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67B6C30E990F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA632F764;
	Thu, 28 May 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvkFbbqC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F72139C9;
	Thu, 28 May 2026 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000821; cv=none; b=a00SnTywVRsrw4lYmNw22i8yFHqhTXOxYbPx6iDA45oagIbCTVJFOX2s3sVOD9y2KIC5AFUe4P3cIEwznVeSSO98UybeZYRBrjeMINdet/Pm2T2UcoZecQoIpSTdUdE8fRplpZtGys/tfdYnWs6tEJzMhbZqN6p+u6e5DOpKxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000821; c=relaxed/simple;
	bh=psZfcHyO28FPAyrkAYknl75+suMkVtiPQCGkXwgAcy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOjEdHTSON+S4x+RFW1WU8a+a67fXlXXIj8zoTvgDf03UKQNC3KUDyfiMi3wJa6QGFvQwtOndQaohFt5yuH18nHNac7FtT9bMGJnqvNrxjetSLn3n1JZ6w4P5V6u1uK4vfCsugj4slqXZC1w0JLve2BWl2DLdV1J+MWS7KzUMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvkFbbqC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DF1F000E9;
	Thu, 28 May 2026 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000819;
	bh=CxvuEMILMBltFk4XKxhqpR5SoJshK1GoK5sT8uHg0mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvkFbbqCEYmG19mmvYnh81UQFKOaMt28yOFIuQuLT3OCxGsWdymWj9TJv7/1+WV6t
	 zbewALIYOWvguqTKnPSw97BhWZHeqeM2CSx+MNOY1wjGGbg204kg6jNqYh1WxFhg6v
	 lu/aryXm1vQWyrpNlYaeUx3J0/DFssOQN6ctmjHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 181/272] phy: marvell: mvebu-a3700-utmi: fix incorrect USB2_PHY_CTRL register access
Date: Thu, 28 May 2026 21:49:15 +0200
Message-ID: <20260528194634.364667837@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256123-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,bootlin.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1B7E45F9CE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 91ddf6f722084383fb05be731c0107814b055c0c ]

The mvebu_a3700_utmi_phy_power_off() function tries to modify the
USB2_PHY_CTRL register by using the IO address of the PHY IP block along
with the readl/writel IO accessors. However, the register exist in the
USB miscellaneous register space, and as such it must be accessed via
regmap like it is done in the mvebu_a3700_utmi_phy_power_on() function.

Change the code to use regmap_update_bits() for modífying the register
to fix this.

Fixes: cc8b7a0ae866 ("phy: add A3700 UTMI PHY driver")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260321-a3700-utmi-fix-usb2_phy_ctrl-access-v1-1-6005ff4b5058@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
index 04f4fb4bed702..f882bc57649c7 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-utmi.c
@@ -168,9 +168,8 @@ static int mvebu_a3700_utmi_phy_power_off(struct phy *phy)
 	u32 reg;
 
 	/* Disable PHY pull-up and enable USB2 suspend */
-	reg = readl(utmi->regs + USB2_PHY_CTRL(usb32));
-	reg &= ~(RB_USB2PHY_PU | RB_USB2PHY_SUSPM(usb32));
-	writel(reg, utmi->regs + USB2_PHY_CTRL(usb32));
+	regmap_update_bits(utmi->usb_misc, USB2_PHY_CTRL(usb32),
+			   RB_USB2PHY_PU | RB_USB2PHY_SUSPM(usb32), 0);
 
 	/* Power down OTG module */
 	if (usb32) {
-- 
2.53.0




