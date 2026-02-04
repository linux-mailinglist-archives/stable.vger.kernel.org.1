Return-Path: <stable+bounces-213603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIIdOH1ig2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:15:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B093BE830F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2856631123F1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843527F749;
	Wed,  4 Feb 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvk+bWjT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D088721FF4C;
	Wed,  4 Feb 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216885; cv=none; b=VwO5KkRkQ52u8Y//jhobRYutEi0Z3Q9/d/Q8JKxendEEEhLqLbiiWb54nRwtw6+PIKyP3me/W3+/mg2Vtn7HFPVx3UiuqHXCEpFm8nhK1OnwkzgrYCOBrE8hWTz/qGTmaUcKAB8KtG0Afkq5+u1roSPHJwNqu6dJWm8NBTFS4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216885; c=relaxed/simple;
	bh=dMlBaAbysXFJ28tHFp9ADScaYypTP6OCTyUvv2b94O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqFd+Dtu37WS5OI792llIKMwvc1vbqr6ZsqblQe9jQsW0JWJiS214ADQ6aqsUbP3GUc1dRLHhCCcGnsqpVzx2N2o70hWrfCsDfzCxFGTZB7qBqUutg3HMLhjGS2AWzRSKd+iXL+KgLewewIeqLc6tIa1DZgWaxE1Ti/zQeAsyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvk+bWjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B8C4CEF7;
	Wed,  4 Feb 2026 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216885;
	bh=dMlBaAbysXFJ28tHFp9ADScaYypTP6OCTyUvv2b94O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvk+bWjTFQmDBtSLliHgVPJ5/v29Nm5CWAg7iz3T6THmkD7m8D78I0Pg0JzyLLgEn
	 G8jBqHWfCveSZY1NPpa/mZFuQYTDGJeDlH9sUYoziHzIEKfXBFfpt1gDqi5Mnyea+t
	 SWPAiMTAxk+XkbTMqEFMI5tPS8/kQmETjpqRBUoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 027/206] phy: rockchip: inno-usb2: fix disconnection in gadget mode
Date: Wed,  4 Feb 2026 15:37:38 +0100
Message-ID: <20260204143859.182014964@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213603-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,chg_work.work:url,bootlin.com:email]
X-Rspamd-Queue-Id: B093BE830F
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Louis Chauvet <louis.chauvet@bootlin.com>

commit 028e8ca7b20fb7324f3e5db34ba8bd366d9d3acc upstream.

When the OTG USB port is used to power the SoC, configured as peripheral
and used in gadget mode, there is a disconnection about 6 seconds after the
gadget is configured and enumerated.

The problem was observed on a Radxa Rock Pi S board, which can only be
powered by the only USB-C connector. That connector is the only one usable
in gadget mode. This implies the USB cable is connected from before boot
and never disconnects while the kernel runs.

The problem happens because of the PHY driver code flow, summarized as:

 * UDC start code (triggered via configfs at any time after boot)
   -> phy_init
       -> rockchip_usb2phy_init
           -> schedule_delayed_work(otg_sm_work [A], 6 sec)
   -> phy_power_on
       -> rockchip_usb2phy_power_on
           -> enable clock
           -> rockchip_usb2phy_reset

 * Now the gadget interface is up and running.

 * 6 seconds later otg_sm_work starts [A]
   -> rockchip_usb2phy_otg_sm_work():
       if (B_IDLE state && VBUS present && ...):
           schedule_delayed_work(&rport->chg_work [B], 0);

 * immediately the chg_detect_work starts [B]
   -> rockchip_chg_detect_work():
       if chg_state is UNDEFINED:
           if (!rport->suspended):
               rockchip_usb2phy_power_off() <--- [X]

At [X], the PHY is powered off, causing a disconnection. This quickly
triggers a new connection and following re-enumeration, but any connection
that had been established during the 6 seconds is broken.

The code already checks for !rport->suspended (which, somewhat
counter-intuitively, means the PHY is powered on), so add a guard for VBUS
as well to avoid a disconnection when a cable is connected.

Fixes: 98898f3bc83c ("phy: rockchip-inno-usb2: support otg-port for rk3399")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Co-developed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20251127-rk3308-fix-usb-gadget-phy-disconnect-v2-1-dac8a02cd2ca@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -689,14 +689,16 @@ static void rockchip_chg_detect_work(str
 		container_of(work, struct rockchip_usb2phy_port, chg_work.work);
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 	struct regmap *base = get_reg_base(rphy);
-	bool is_dcd, tmout, vout;
+	bool is_dcd, tmout, vout, vbus_attach;
 	unsigned long delay;
 
+	vbus_attach = property_enabled(rphy->grf, &rport->port_cfg->utmi_bvalid);
+
 	dev_dbg(&rport->phy->dev, "chg detection work state = %d\n",
 		rphy->chg_state);
 	switch (rphy->chg_state) {
 	case USB_CHG_STATE_UNDEFINED:
-		if (!rport->suspended)
+		if (!rport->suspended && !vbus_attach)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* put the controller in non-driving mode */
 		if (!vbus_attach)



