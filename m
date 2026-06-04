Return-Path: <stable+bounces-260400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6ueDFS9XIWoGEQEAu9opvQ
	(envelope-from <stable+bounces-260400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D3963F26D
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:45:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="g/eJcuiz";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260400-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260400-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 919FE3019505
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF5405C28;
	Thu,  4 Jun 2026 10:44:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1B405852
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569881; cv=none; b=YrAnsmqyBdmQ35x1PASOh5hQWeznPAOt2qNM9kvnI+RTZPkGbgDx7A3keCw9QJni3rrdFbgv5EPX3nzA+nTgaZNA9jvzEESNckkZcWGIZcGWDJ4hkUKKoGzpadA7orBg3CQik9oaBUDMhkj+tB6nWgiuy8R4Sj3W6pX4po9FYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569881; c=relaxed/simple;
	bh=ONoQZrClqda3hO3vpldTvIhU1xFYN4Q/EbsIT37rYmI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uKNKgX3aZFhgLYTgtojBB3LAj/YXPmQlYsl6Al5qgFMjAKk76pSgPorDpzgLKof7oKgeP7zLLC/kzMyKtvTXVmE0lWY8fdUooyr2ZS2gbnJ6kTPjuq+atPX5f6zhdC6ue8af5+wSuHz/tjMRBGBpiryagDCTMcZS3zVso+hKhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/eJcuiz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C59C1F00893;
	Thu,  4 Jun 2026 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569880;
	bh=HLmuXJlsg/YqM96191vTlagA0uKBim/0oQNzdIqtWt4=;
	h=Subject:To:Cc:From:Date;
	b=g/eJcuizbc9R4HOw+G3kdHsXuN4PTYyI0JIWDzKHCqMqB6VUL0iQB/qpo+3YCmGGo
	 1PGa/xEAymtXkR/hWOm3pvjgSunSmAMMahQwbI6SwrUhFojAsWUfld7n46Mor8hmGp
	 lV3yDDcNp5fDyPLajowx82mrxJBp2Wr2ontA6+mg=
Subject: FAILED: patch "[PATCH] usb: dwc3: xilinx: fix error handling in zynqmp init error" failed to apply to 6.6-stable tree
To: radhey.shyam.pandey@amd.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:42:16 +0200
Message-ID: <2026060416-utility-unlucky-a9e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260400-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:radhey.shyam.pandey@amd.com,m:Thinh.Nguyen@synopsys.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1D3963F26D


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c1a0ecbf32c4b397353204e2ec94c5bb9f3300ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060416-utility-unlucky-a9e7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1a0ecbf32c4b397353204e2ec94c5bb9f3300ed Mon Sep 17 00:00:00 2001
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Tue, 19 May 2026 17:25:29 +0530
Subject: [PATCH] usb: dwc3: xilinx: fix error handling in zynqmp init error
 paths

Fix error handling and resource cleanup i.e remove invalid
phy_exit() after failed phy_init(), route failures through
proper cleanup paths and return 0 explicitly on success.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://patch.msgid.link/20260519115529.2980421-1-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index f41b0da5e89d..9b9525592a85 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -184,15 +184,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	if (priv_data->usb3_phy) {
@@ -208,26 +206,24 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
-				     "Failed to request reset GPIO\n");
+		ret = PTR_ERR(reset_gpio);
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -237,6 +233,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }


