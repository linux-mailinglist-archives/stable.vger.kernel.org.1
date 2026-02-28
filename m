Return-Path: <stable+bounces-220757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COpRETBBo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B06471C6F86
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C909830F4351
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3394050AE;
	Sat, 28 Feb 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M87pk2b9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4184050A6;
	Sat, 28 Feb 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300638; cv=none; b=WU1/tOyCnjbr//h/kUe2sihmhiM3Yz7HWuskQ+z3F+n03CfOehyYy9fmTlWBfL/+Ixn1Vl+8w+sgJ0LEKyAU9KFWCouyrnw6Q+5tM3sLj/U3kzzcLHJLFO0Q6z6lMRRmWrUqjy0PVw92RVjI9kVQKAEAea0Wt+Eu3fvG3pyH5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300638; c=relaxed/simple;
	bh=HeF6ox1C67sqO9OwG7DXMP51pHye57oW7ISY2fNb60I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj5rwM1mZM5BQb6tLHVBFi1n9uW4hwrjlmtXPIbNTPpx570deeAZ3YgQZ0KTD2cr0vhyODdDD2JNZxGgvpxc67bwqq6Et2/oO6T/dI6/Nr+1m5v5KEm3iSt0zirnjWhDKXTpPI3tOinWHfFZ1/31MyDYnqyzXlPH9jHnYjlvAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M87pk2b9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327ABC19423;
	Sat, 28 Feb 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300637;
	bh=HeF6ox1C67sqO9OwG7DXMP51pHye57oW7ISY2fNb60I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M87pk2b9SobKaPYWIGliH1f5xTqhr8meeQ0L/hvqevZ1JsBvcW0/tMrKhU6dC5e3/
	 jYLjLKYqwST8ftjc3hx+bq7C7T57pDoPrT9KNVXbYWf+T/QyUOuVF3P4ZSpBFd3xHe
	 dl4d4deOvUX5GTodZ8y6p+Y7bhAetyjaS/0cRHAI1BK4Gmd9PV6doE5OMRa3USY6go
	 YQE5+nrbYwarZAMHXcVIxs7MhOTtNdsN06wlEj1zE8mAXXRIULZiL+YGJKNz/6tMnT
	 RlFNPcNQ/N+kZeir41aHH0KIJVBLfMIK0sbHT1CMWFVVdKoMwXnw5LTwhYvfp0GUgI
	 9BC4ZySZPE3WA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wayne Chang <waynec@nvidia.com>,
	Wei-Cheng Chen <weichengc@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 678/844] usb: host: tegra: Remove manual wake IRQ disposal
Date: Sat, 28 Feb 2026 12:29:51 -0500
Message-ID: <20260228173244.1509663-679-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220757-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,nvidia.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B06471C6F86
X-Rspamd-Action: no action

From: Wayne Chang <waynec@nvidia.com>

[ Upstream commit ef548189fd3f44786fb813af0018cc8b3bbed2b9 ]

We found that calling irq_dispose_mapping() caused a kernel warning
when removing the driver. The IRQs are obtained using
platform_get_irq(), which returns a Linux virtual IRQ number directly
managed by the device core, not by the OF subsystem. Therefore, the
driver should not call irq_dispose_mapping() for these IRQs.

Fixes: 5df186e2ef11 ("usb: xhci: tegra: Support USB wakeup function for Tegra234")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Wei-Cheng Chen <weichengc@nvidia.com>
Link: https://patch.msgid.link/20260115103621.587366-1-weichengc@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-tegra.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 8b492871d21d6..3f6aa2440b05b 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1570,7 +1570,6 @@ static int tegra_xusb_setup_wakeup(struct platform_device *pdev, struct tegra_xu
 		data = irq_get_irq_data(tegra->wake_irqs[i]);
 		if (!data) {
 			dev_warn(tegra->dev, "get wake event %d irq data fail\n", i);
-			irq_dispose_mapping(tegra->wake_irqs[i]);
 			break;
 		}
 
@@ -1583,16 +1582,6 @@ static int tegra_xusb_setup_wakeup(struct platform_device *pdev, struct tegra_xu
 	return 0;
 }
 
-static void tegra_xusb_dispose_wake(struct tegra_xusb *tegra)
-{
-	unsigned int i;
-
-	for (i = 0; i < tegra->num_wakes; i++)
-		irq_dispose_mapping(tegra->wake_irqs[i]);
-
-	tegra->num_wakes = 0;
-}
-
 static int tegra_xusb_probe(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra;
@@ -1648,10 +1637,8 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		return err;
 
 	tegra->padctl = tegra_xusb_padctl_get(&pdev->dev);
-	if (IS_ERR(tegra->padctl)) {
-		err = PTR_ERR(tegra->padctl);
-		goto dispose_wake;
-	}
+	if (IS_ERR(tegra->padctl))
+		return PTR_ERR(tegra->padctl);
 
 	np = of_parse_phandle(pdev->dev.of_node, "nvidia,xusb-padctl", 0);
 	if (!np) {
@@ -1975,8 +1962,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 put_padctl:
 	of_node_put(np);
 	tegra_xusb_padctl_put(tegra->padctl);
-dispose_wake:
-	tegra_xusb_dispose_wake(tegra);
 	return err;
 }
 
@@ -2009,8 +1994,6 @@ static void tegra_xusb_remove(struct platform_device *pdev)
 	if (tegra->padctl_irq)
 		pm_runtime_disable(&pdev->dev);
 
-	tegra_xusb_dispose_wake(tegra);
-
 	pm_runtime_put(&pdev->dev);
 
 	tegra_xusb_disable(tegra);
-- 
2.51.0


