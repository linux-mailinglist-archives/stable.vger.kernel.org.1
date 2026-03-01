Return-Path: <stable+bounces-221407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFh5HomWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE77A1CACCA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021CC312B1E6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A727E1C5;
	Sun,  1 Mar 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7P0KNtS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C3430BA3;
	Sun,  1 Mar 2026 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328182; cv=none; b=jV4oq5E79S6IY3+Fc9f3hw8z7P0E9scGJbZTW22vK/Qq4UY64hmyjyQOMj+sCm2FwMI2ZMN+Z5Atj9TJV9x7hplO47EkdWeDCTDAt9IBP1+bdbN+e3OHOa4Nn6sHxszT0BKmJ/N8K7QC9ulabsdi7f5A7OA41sNjV05fuSOY3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328182; c=relaxed/simple;
	bh=kVpVpvUZ9kdW04Ew3EmWzKxP+hHdEJTTwPY30pey9MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGB879bqBHNMTPvXKGFCA/rJPyLcWZp15pss2fOcOEwRry6ZQw5Af1kJWMVJO/Astb57KkbWrtwjrGtiYJDH9WPRBVdc9meo0xPwzm8WaRH1fppVRn3RcctA1GgbV0qWs6wijxuyqkEaBtbWiQUTSICBPuvGLqJ5raD+clRfUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7P0KNtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C06C19421;
	Sun,  1 Mar 2026 01:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328182;
	bh=kVpVpvUZ9kdW04Ew3EmWzKxP+hHdEJTTwPY30pey9MY=;
	h=From:To:Cc:Subject:Date:From;
	b=l7P0KNtSmQGxHsmJAZWTCMo9rI80NsbYVBfFNYu9/7JSa6B8mP/djIS5TM7u+F42e
	 A3EfTEeg2Z2A/hrr8yZwsPU/Kv7USYgSoZ+vdO2SbvLNqTD1RFtdGHv+3sPZMeFk8m
	 S8xh1DZ3p1Tig57Bo1TNNsIC7FaKcwgt31FHZCFf9lH9tv4F2bDRQQirs+nN39wepd
	 XMKsYloNaFZhI+a0NbwdYz6JDioeh1mLOD5zOmpLdjOiqaz3W4uU277eOYiCjP0aCN
	 bR5yMoNEibCz+7/Uj1QaeZ0nfVJpCeLEpr6GG+1rylw21mQU1ynZAe4S0w6I+shlyJ
	 qll7qbwVhL5Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "mfd: omap-usb-host: Fix OF populate on driver rebind" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:23:00 -0500
Message-ID: <20260301012300.1679626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221407-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE77A1CACCA
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 24804ba508a3e240501c521685a1c4eb9f574f8e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:07:14 +0100
Subject: [PATCH] mfd: omap-usb-host: Fix OF populate on driver rebind

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251219110714.23919-1-johan@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/omap-usb-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index a77b6fc790f2e..4d29a6e2ed87a 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -819,8 +819,10 @@ static void usbhs_omap_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
-	/* remove children */
-	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+	if (pdev->dev.of_node)
+		of_platform_depopulate(&pdev->dev);
+	else
+		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
-- 
2.51.0





