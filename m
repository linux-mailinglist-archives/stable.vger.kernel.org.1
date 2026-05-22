Return-Path: <stable+bounces-253785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBsxA85bEGqDWgYAu9opvQ
	(envelope-from <stable+bounces-253785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F45B5433
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8DF230A0261
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEE395AE6;
	Fri, 22 May 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUr4ED8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D94390C9F
	for <stable@vger.kernel.org>; Fri, 22 May 2026 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454984; cv=none; b=lTTKDSFKjP418Z5qegWyNLRUcC8KpDH/ehKdHiQHLSjhBc+TFovNmzkic+Yo8fctE1mNUmSK1iXLoRZy/1/xLQBfpnv5SdUW1jpxLPap6NfKW/W0djCY/c7g9hQrb7Go7Uu3VTk73bB8pyA/t08OX/o2YwmV5VZVuQvOJVH5qZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454984; c=relaxed/simple;
	bh=d8fNWU/LLkxUNGy4nQZyqFOht7UE1o1eO1HCkTcsQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3cHX0pXsbRUAi2eISGMDinBjHvHb7GO8wV6aAGbircCkvZH3TaI2SYyB7pAXvNCvCkNlNHwmKECMXHRprkbH9RpqAEyy2dJJmttoLNygIXXzTgn+zGm0N+//YRSNMLsjI0lWAlU5VzZgseL93XthqkZNJeMz5pnNyEO9LFQ7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUr4ED8i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB21F00ADE;
	Fri, 22 May 2026 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454983;
	bh=KmGrhJh7D+SVkuQw1UciJG9VTMyjSC4gRhlARXlqOWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lUr4ED8iWO1sGz41IO+V3UBydkwGeonqMm4wAny4v98YahvqdvnlUJAM5m0LU0t9d
	 5IuCYs6kcOKY9YZZFTWKpahPOlGC/fdPMsCnsieUusEGIfa1FN4OtT0oz6s/abj4HF
	 KbQjpjHrncrf0VH2z+B/UMMUc910g+aUJPXFdoyLgrYZYfZo5Qu+rffA/QvARUokNH
	 xOuC2bAyQuMWMTp4c9qlvST6Q5ie/0o0JLali0FEBT0IpZaOlo3Q1nJ2g+ZFXl6bi0
	 NkA4Ex0TSw97xGPyc1hpH1ZHorAR76spXT/9yJmhPvkiToTo+x1SBmRaoVFpAcjCVo
	 1pMKYDzQDczzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net: ethtool: phy: avoid NULL deref when PHY driver is unbound
Date: Fri, 22 May 2026 09:03:00 -0400
Message-ID: <20260522130300.3869084-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522130300.3869084-1-sashal@kernel.org>
References: <2026051922-hardness-swizzle-86b5@gregkh>
 <20260522130300.3869084-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 053F45B5433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Carlier <devnexen@gmail.com>

[ Upstream commit e3adf69f8eb121a9128c2b0029efd050d3649153 ]

phydev->drv can become NULL while the phy_device is still attached to
its net_device, namely after the PHY driver is unbound via sysfs:

	echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind

phy_remove() clears phydev->drv but doesn't call phy_detach(), so the
phy_device stays in the link topology xarray and ethnl_req_get_phydev()
still hands it back. ETHTOOL_MSG_PHY_GET then oopses on:

	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);

drvname is already treated as optional by phy_reply_size(),
phy_fill_reply() and phy_cleanup_data(), so just skip the allocation
when there is no driver bound.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Cc: stable@vger.kernel.org # 6.13.x
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260509215046.107157-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/phy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index cb1e0aea450f9..98392a3c34b5b 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -94,10 +94,12 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	if (!rep_data->name)
 		return -ENOMEM;
 
-	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
-	if (!rep_data->drvname) {
-		ret = -ENOMEM;
-		goto err_free_name;
+	if (phydev->drv) {
+		rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+		if (!rep_data->drvname) {
+			ret = -ENOMEM;
+			goto err_free_name;
+		}
 	}
 
 	rep_data->upstream_type = pdn->upstream_type;
-- 
2.53.0


