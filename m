Return-Path: <stable+bounces-229522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ih2CLxmwWlESwQAu9opvQ
	(envelope-from <stable+bounces-229522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:13:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8B2F7C39
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D14D31C0EFF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC73B27F2;
	Mon, 23 Mar 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+hCZmS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CC3AE70F;
	Mon, 23 Mar 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279718; cv=none; b=P6Ultgnn99gsubyI256b0rMMHprk1vmsW6hSHvqY+DL1uXIBiIDFCybxnMSf1Uhx0DI/hjpv+1sLSoq8tEgnherA4/z1+U2DTB7QVQZZBhUnvqWZCoK4eeKEXkIDtlrt428ii504ggyfo+wfX2keGdi4UouQ/OyRM4x+oS+lujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279718; c=relaxed/simple;
	bh=iu86mPmzXon6/feiXFvJTBepSBSZdNsoGqMokFwK9to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1X9yOOq3EU4ewXhHV85hJOhOWI6Ae15me2Ua7CoN/qzARvKRvdN2HCtlf9EpTURfT6KRkrai3pEI40v7K0TBcaR149nHDzkXnLrBGdvUwBZDSbWFQyBYMocoJCoxKVDkXSdcoAZTs46X9h1noa5aRS+u13CqgQFhEvF2jpWn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+hCZmS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCF1C4CEF7;
	Mon, 23 Mar 2026 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279718;
	bh=iu86mPmzXon6/feiXFvJTBepSBSZdNsoGqMokFwK9to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+hCZmS4MVmAcB5RoDvGCEtPrurwxNyQP//nI1VhuZBm0D9A1bb1fGCyxI3abA97f
	 /a50tvoWDnM9xjxx9obLgCBkBDpqnQwH5K53Fk0xRjcZp7k2FXU6ifV/CZ0o0RGKbu
	 xywiYNluecfdfylg3rIEZrzhqZ8s6o2pqmHnJ5SE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/481] mfd: omap-usb-host: Convert to platform remove callback returning void
Date: Mon, 23 Mar 2026 14:40:38 +0100
Message-ID: <20260323134526.588843651@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B4B8B2F7C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 418d1e74f8597e0b2d5d0d6e1be8f1f47e68f0a4 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231123165627.492259-11-u.kleine-koenig@pengutronix.de
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 24804ba508a3 ("mfd: omap-usb-host: Fix OF populate on driver rebind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/omap-usb-host.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 787d2ae863752..b61fb9933aa85 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -818,13 +818,12 @@ static int usbhs_omap_remove_child(struct device *dev, void *data)
  *
  * Reverses the effect of usbhs_omap_probe().
  */
-static int usbhs_omap_remove(struct platform_device *pdev)
+static void usbhs_omap_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
 	/* remove children */
 	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
-	return 0;
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
@@ -847,7 +846,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.of_match_table = usbhs_omap_dt_ids,
 	},
 	.probe		= usbhs_omap_probe,
-	.remove		= usbhs_omap_remove,
+	.remove_new	= usbhs_omap_remove,
 };
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
-- 
2.51.0




