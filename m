Return-Path: <stable+bounces-249545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KfUGdA7DGp8aQUAu9opvQ
	(envelope-from <stable+bounces-249545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:30:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAE57C41A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 718CB30A7463
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8A3A9D90;
	Tue, 19 May 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tudkCepf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373733A963C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186078; cv=none; b=eEe5HULNbGgIwAfFbE68ZzXXAcfZx3Ad1IgP2Wixo+2+bmwpOvpK19RL7YbK4xG8XEnHzrafRF7tJ8w/FetfP3R5kBWrdH4ZETg9vXOO2ls8025Eopu/0M5iGlOhMV76L1XK8YvouyqVhX05YLt2TZjpCtGnthA12Ku6P+WEnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186078; c=relaxed/simple;
	bh=SWn3dtbIZWVflGe7rzLNkQhKcs5xwLyGZCdCZlC55jM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=scjmCUx4gq4e+gCZimcMlqgckSVBuN1Igrsj1MdCl/wgNVeA8r42USLTuWwVtkSrWtrMpgHY098I8UcplFRMO3gX5E0uc2GRcxyKAXZejuRgUHEM0Qi3CQDFfzel728Y3JAQTAmK+RMqo9DYKhBGIXP8ikio3hyT/EKEkzRtkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tudkCepf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B613C2BCB3;
	Tue, 19 May 2026 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779186077;
	bh=SWn3dtbIZWVflGe7rzLNkQhKcs5xwLyGZCdCZlC55jM=;
	h=Subject:To:Cc:From:Date:From;
	b=tudkCepfiqBB33mpkqS60+VA82evtWJjvAZAGgbOdMCfFDQC7G1BufiV+8bfBlqdI
	 gVEp6YT6L/K7JqPm4g2rmy9K9q4CN2q1+YY9CISEAydHdXoZ8K8/OycZS79d5yVIfq
	 7mVQzT+mEF3P86GK4CSYSS/4aU8ZzlqrZV6PBTtk=
Subject: FAILED: patch "[PATCH] net: ethtool: phy: avoid NULL deref when PHY driver is" failed to apply to 6.18-stable tree
To: devnexen@gmail.com,kuba@kernel.org,maxime.chevallier@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2026 12:20:22 +0200
Message-ID: <2026051922-hardness-swizzle-86b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249545-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,bootlin.com:email]
X-Rspamd-Queue-Id: 0BFAE57C41A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e3adf69f8eb121a9128c2b0029efd050d3649153
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051922-hardness-swizzle-86b5@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e3adf69f8eb121a9128c2b0029efd050d3649153 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 9 May 2026 22:50:46 +0100
Subject: [PATCH] net: ethtool: phy: avoid NULL deref when PHY driver is
 unbound

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

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index f76d94d848d6..ddc6eab701ed 100644
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


