Return-Path: <stable+bounces-221071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOKhDY9No2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C015D1C82E0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CC2633A0360
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35F301F0F;
	Sat, 28 Feb 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGLAS1xh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AD301EFF;
	Sat, 28 Feb 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301416; cv=none; b=kh/of59fh9UKi4LKqIx70+7o/53qB0+egAow0cAyoO3EvSXeGRuld+CfjkoR919EJss/JqRN6vhBpve2tpWzVFYGS+HtqUups382Sajx0lVYvB0frsDxjTXXeMK2Ss9K0qo5SQSa0qXubQl0ZHpOErtX/v0H4x9iqSuHp01ps0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301416; c=relaxed/simple;
	bh=IcG3cP6JJLO1/DitGza6K3eA3tb3RpXbCRBy+tjJ8v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMtch1iSteYK0oLWHL4mbIAIzyuYjHtx3rn8L0SfrZyeaiMDgyJ/1yLM31LbfaCUTMqyUjWHvpKyvFz2CwvHKfOrBZO9Vlz+EEWfoja7yMPG2IyUa1m4C9vkaL5lVKmGk875k3X9ZjPFC8ppYidigbEAfKTIN58qWWOJ8JkFW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGLAS1xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EC4C19423;
	Sat, 28 Feb 2026 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301416;
	bh=IcG3cP6JJLO1/DitGza6K3eA3tb3RpXbCRBy+tjJ8v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGLAS1xh34W3QCv0PBfpGlP1LY3sps0yp9nGDZEeNfetc9C9PwbI1vyjE86DTv5K5
	 iaqVaMsYxChEHaIF9Nw4iqrxGjzHI1ltigdbE9RMTmPRqANIf7ffMJy4gZExM/7RmR
	 5+EoHQ+Yuqtm4GyNHABtHe/5dJbtAxx1BVIzdWxBU6e8pqOsDxrw0BXsZvhE/EeZYu
	 P1qDKYtSYO7xWpLDQHLAPtQ28l+Zzw7MqYvQe6eww4ERDABT2kSJpOfvC7+BhW0kQF
	 ATFIoODv/D8UKvY9mFnCBUW+jB1YOTuI+Pn7KuZ3GmNL+ixA9UpxY65a2qXrOxXX7q
	 mAusXtb4yuNyw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Wayne Chang <waynec@nvidia.com>,
	stable@vger.kernel.org,
	Wei-Cheng Chen <weichengc@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 605/752] usb: host: tegra: Remove manual wake IRQ disposal
Date: Sat, 28 Feb 2026 12:45:16 -0500
Message-ID: <20260228174750.1542406-605-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221071-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: C015D1C82E0
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
index c78bed0aa844e..83b1766ff1521 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1571,7 +1571,6 @@ static int tegra_xusb_setup_wakeup(struct platform_device *pdev, struct tegra_xu
 		data = irq_get_irq_data(tegra->wake_irqs[i]);
 		if (!data) {
 			dev_warn(tegra->dev, "get wake event %d irq data fail\n", i);
-			irq_dispose_mapping(tegra->wake_irqs[i]);
 			break;
 		}
 
@@ -1584,16 +1583,6 @@ static int tegra_xusb_setup_wakeup(struct platform_device *pdev, struct tegra_xu
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
@@ -1649,10 +1638,8 @@ static int tegra_xusb_probe(struct platform_device *pdev)
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
@@ -1976,8 +1963,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 put_padctl:
 	of_node_put(np);
 	tegra_xusb_padctl_put(tegra->padctl);
-dispose_wake:
-	tegra_xusb_dispose_wake(tegra);
 	return err;
 }
 
@@ -2010,8 +1995,6 @@ static void tegra_xusb_remove(struct platform_device *pdev)
 	if (tegra->padctl_irq)
 		pm_runtime_disable(&pdev->dev);
 
-	tegra_xusb_dispose_wake(tegra);
-
 	pm_runtime_put(&pdev->dev);
 
 	tegra_xusb_disable(tegra);
-- 
2.51.0


