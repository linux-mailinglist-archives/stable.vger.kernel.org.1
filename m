Return-Path: <stable+bounces-260771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fV46I2QiI2oejQEAu9opvQ
	(envelope-from <stable+bounces-260771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:24:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765964AEB6
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:24:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XiUnOpqw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260771-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260771-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 773C930CE887
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419B3B7757;
	Fri,  5 Jun 2026 19:17:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327143CEFC
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:17:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687029; cv=none; b=l+/kxUFRk4eU4EQoIKW2Xdd+sbJjUURIuHmvthOiyRvwxiRQ7OwGMSMfVufOcY0/crxgSCO8uRzJqOaYoCmG8HSaFd0XO20DkqOs3kSpRWCIW6WPTZu3K6gQxr/OSXZ3KkJhv2EZZ9vNpMXaMGYOK7u+t+zoGzIuT3jzcVBPnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687029; c=relaxed/simple;
	bh=hkCWmtnGAT7erofThntZGIlEDi7D3j1cjCg/zjkJAss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0kY5WkGErzNUiVbX01FoCZF+3rL+0n8Bq7h5cmpKceRpnwPHm8RlYDK0a/HCAF833TSVYgjk2vX+V+eUJl4trEw4a+iunsn2hzNSTjBQxx+33sCyytgSgzeeA8oA923QS9iB7Dz6zHAtUEMIZ4Nm6w/uAUfMm7CqOYrn/6sG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiUnOpqw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14531F00893;
	Fri,  5 Jun 2026 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687023;
	bh=ObShUSJAlx77VIkx2ff8VKm7jTNDfjoF7ZWPuqwzBJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XiUnOpqw7ZM+ifaZFkXI+vC4WZdW/T0poG8l3e+tYRtujcKPCTouL/aQ+YPsRV0gM
	 PVw/QeOjZZZEwQGMVzqFkBE9BCBKbKZVommVf8O/JQPdYt4DfNbTwwSAim7yt8uJSJ
	 twhganCRzlEh9Q6JzBygruNfdii+s+SskZL4JMBUeaLJ4NeO8syMSB0zZOaW0e0Q3H
	 x5WL7zPimh9EQHhPfbvKSnaosF8cvgIYqzylu5P4nzUWIqYoXBDqq3RvgYnawaCB9/
	 9uluIFnzZz01KPfIndRHrDGyelo6slYAPX2r3TWVS8QOoubOma9o/mOQvOqqKb9ZX7
	 KbuHqtTInHecw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: xilinx: fix error handling in zynqmp init error paths
Date: Fri,  5 Jun 2026 15:17:01 -0400
Message-ID: <20260605191701.2128791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060417-omit-definite-cb3f@gregkh>
References: <2026060417-omit-definite-cb3f@gregkh>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260771-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:radhey.shyam.pandey@amd.com,m:Thinh.Nguyen@synopsys.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,synopsys.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0765964AEB6

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit c1a0ecbf32c4b397353204e2ec94c5bb9f3300ed ]

Fix error handling and resource cleanup i.e remove invalid
phy_exit() after failed phy_init(), route failures through
proper cleanup paths and return 0 explicitly on success.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://patch.msgid.link/20260519115529.2980421-1-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a6f3a9b38789e0..df545763a591d1 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -165,15 +165,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(usb3_phy);
-	if (ret < 0) {
-		phy_exit(usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	/* Set PIPE Power Present signal in FPD Power Present Register*/
@@ -185,20 +183,18 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
 
 	ret = phy_power_on(usb3_phy);
-	if (ret < 0) {
-		phy_exit(usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 skip_usb3_phy:
 	/*
@@ -212,6 +208,10 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 	}
 
+	return 0;
+
+err_phy_exit:
+	phy_exit(usb3_phy);
 err:
 	return ret;
 }
-- 
2.53.0


