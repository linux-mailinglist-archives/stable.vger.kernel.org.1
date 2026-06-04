Return-Path: <stable+bounces-260588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ma/FJwEPImoFSAEAu9opvQ
	(envelope-from <stable+bounces-260588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 01:49:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C886644004
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 01:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b9Ha3BmM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260588-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260588-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F0C3020124
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 23:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78033B6EA;
	Thu,  4 Jun 2026 23:49:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB927732
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 23:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616957; cv=none; b=omG5ylASCILIDBb06wGhitlMJnpLZBPnEEu1AbuQi6tp+olWR0qnI72Bbml3wOP9Wf6OBs9zzaoIQRcP+gRdXUTzyNlhi1TFzTw/cZhtVSJXPBHEHS/CGm9bLvDYTg4NOcPDM/UQYPmlgfCuke1ctzOTRvZdQ3vNHfz9PE8CRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616957; c=relaxed/simple;
	bh=GervpOhcbLovYdvxl3GYecXfGAyIrfZDzldMrZhfZKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juBMKebXURuDCcikS7dAgl7RfJs2FEohj1Rbx7xzT9eSfgDCbvF87/lYNpEme5iGu0U4Z48v2ijWQX3TuZdXb5lqHy018HXdZecxphORdYvEiJgxVde/DyxS36BJRMcRHLOcuiomTLkodDbL/Ackg62JepLtECqrBJQaoVPn3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9Ha3BmM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E7B1F00893;
	Thu,  4 Jun 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616955;
	bh=8hu6HD585vgoYLshOhKyTpb+F4upu5kJBiaPENpojdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9Ha3BmMI391rc+/bcBMDOIzFbIP/Kski4WO+GNk8DJmCqR/cpi+H8zogCqi6F9E/
	 ie0iLxuY+XATthK6cbVLmxO2qiHzjt2R/QP0Xr/lC4g8gEYaCpIz1wcofFbBDNBjKt
	 OAmfnJ68PBtIfWJZx4NRKaMguvgi8MXcuPvhl2TDt0t9LBWtG/XkIv5b3qfQObWeBN
	 ab6tTVa60Pz7toGutaVa53YqSGaeOeEPlYxzkRK/UIYcD1iy6/HCiFKPxU0hfIsrki
	 jX1MbrcpW2TneIg0M3raqgWiUBq+dndCOM9EEvq0Q4ci6S/Kc7whZYF/7Rs1d2qUie
	 40AtfHCS5fcww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Chen <peter.chen@cixtech.com>,
	stable <stable@kernel.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
Date: Thu,  4 Jun 2026 19:49:13 -0400
Message-ID: <20260604234913.2468901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060428-tackle-screen-6157@gregkh>
References: <2026060428-tackle-screen-6157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260588-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:peter.chen@cixtech.com,m:stable@kernel.org,m:sashiko-bot@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C886644004

From: Peter Chen <peter.chen@cixtech.com>

[ Upstream commit e6970cda63fd4b4546aeed9d0e2f53a7c95cd09c ]

Move usb2_phy initialization after usb3_phy acquisition.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: stable <stable@kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Link: https://patch.msgid.link/20260513085310.2217547-2-peter.chen@cixtech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-plat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 2c1aca84f2264d..bad619d25987bd 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -121,14 +121,14 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns->usb2_phy))
 		return PTR_ERR(cdns->usb2_phy);
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return PTR_ERR(cdns->usb3_phy);
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
-- 
2.53.0


