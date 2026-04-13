Return-Path: <stable+bounces-237100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CC2M04k3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E493F1084
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCF13119FB7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64661D5AD4;
	Mon, 13 Apr 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="deAwpOiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CE1A680C;
	Mon, 13 Apr 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098588; cv=none; b=Ir/iHw5yExDN/FdPVd5opiA10YAkyGcmtFAunoxvcJ0fQHoyWZ0Tb2nSuObyNGL8HcMQ2rQSGbFS8YNTivp6TD49gpGpqau3yVPp9xtMbLzsNyTvEx+NQR4hhM0j4LO5Id9SvOSW4CFcBpcLMSHDm/jKTbfxp/KssVOxc1DOLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098588; c=relaxed/simple;
	bh=3YhJMwzQWqYZOtGJlF8WHX8g3Lb4M89GZrA/goIZCMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTPhNpd7QxciTiGm+89/wemiEb9W0kLT74OllFRtfb0QEOmj105qI6y+td4PhnuQORIT2zeO3/l6MNPJDm411tuf5mL7OqqXqb7+8HhntKp8T8xlByLo3CmOeSyb3y+k0xd/qWV1BnJ260g4QMfh1oAFVcU4XQVgqFmihEb1VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=deAwpOiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F3C2BCAF;
	Mon, 13 Apr 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098588;
	bh=3YhJMwzQWqYZOtGJlF8WHX8g3Lb4M89GZrA/goIZCMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deAwpOiyl2duhKi5Cq9nsgQBAqvhg2ZNsPbzgtN5MKZQNaL7d/cngVLSSj5NryP3e
	 OfCs/uokXOs27Z0DHb/PK8IAeusXt8AePXRMpo/fwLV9kdRIFuJko2l2zgd8+htiMe
	 CR0w+L01Hz7wSWem0vvonVXIgabTxpLPL5O44dLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 012/491] bus: omap-ocp2scp: Convert to platform remove callback returning void
Date: Mon, 13 Apr 2026 17:54:17 +0200
Message-ID: <20260413155819.511284969@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237100-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 30E493F1084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 854f89a5b56354ba4135e0e1f0e57ab2caee59ee ]

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

Link: https://lore.kernel.org/r/20231109202830.4124591-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Stable-dep-of: 5eb63e9bb65d ("bus: omap-ocp2scp: fix OF populate on driver rebind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/omap-ocp2scp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e02d0656242b8..7d7479ba0a759 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -84,12 +84,10 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_ocp2scp_remove(struct platform_device *pdev)
+static void omap_ocp2scp_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -103,7 +101,7 @@ MODULE_DEVICE_TABLE(of, omap_ocp2scp_id_table);
 
 static struct platform_driver omap_ocp2scp_driver = {
 	.probe		= omap_ocp2scp_probe,
-	.remove		= omap_ocp2scp_remove,
+	.remove_new	= omap_ocp2scp_remove,
 	.driver		= {
 		.name	= "omap-ocp2scp",
 		.of_match_table = of_match_ptr(omap_ocp2scp_id_table),
-- 
2.51.0




