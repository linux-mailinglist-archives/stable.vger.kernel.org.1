Return-Path: <stable+bounces-255157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBg/CeudGGpRlggAu9opvQ
	(envelope-from <stable+bounces-255157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00C5F779A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8844303C297
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1078318EE1;
	Thu, 28 May 2026 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GAGcaED+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00A330B2D;
	Thu, 28 May 2026 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998125; cv=none; b=Nd7+6Q/J2Vpq2BvDzx9/EbZfaZOB4za3C08paJ2KzrvIillsQrr1iAGxzaN+xUFxE2BGBJkb05Czum9q3FGAnVVH7P49Rm4asivnPg93dEtEhke+03457CakxoV4aqQ+YE8pDpVNqr3vdJTBAGeKIyamUgnLxUhoQclk0sbi+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998125; c=relaxed/simple;
	bh=GncCrtrNwSKdjVOie3CjkljKns9b2Sk4RQwIfyh9XQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxRdtCXZqgyElETQytPeHtJAU8cFn2khB1+eEB+2CKX+u87qMVhxBy6nVk16xw6/Aup531Obc9DzXseBoOsTM5j/5p4pPsxa4vijMW07U86/2m17iOsibNgdQrC7oJemRFdOB9kWnRFPPxm1hnVF7LwfLYMlcYPsTAObepq+MZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GAGcaED+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB36B1F000E9;
	Thu, 28 May 2026 19:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998124;
	bh=RVlEKMjFx/nxwU5Y+zTUKPewxVwhej3qPBfKPVUkEL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAGcaED+LTYdXf5VixWpksMDQaa9GPiC1qQLizmzRbpNyPNENarrop5zKQFhnjiXu
	 244aj8RVNTqsliLZTQLpHjksLdX2B7dC29x2V7KYvEtFkcNu9EXrytJjBkn/VlxvHF
	 fzGMQg30Iph+75JsnV9qLbXd2pTQMDkgh4dlUNfg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 062/461] net: ethtool: phy: avoid NULL deref when PHY driver is unbound
Date: Thu, 28 May 2026 21:43:11 +0200
Message-ID: <20260528194648.710542907@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255157-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Queue-Id: BC00C5F779A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ethtool/phy.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -94,10 +94,12 @@ static int phy_prepare_data(const struct
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



