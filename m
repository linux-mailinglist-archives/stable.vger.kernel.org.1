Return-Path: <stable+bounces-221014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBBHGwVIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF5F1C7864
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF7FE32DCCA7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0454BCAA2;
	Sat, 28 Feb 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaWQOssZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFF29E114;
	Sat, 28 Feb 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301357; cv=none; b=HnvDUSvbImFBqc3k6l3GjpTO0XTsw0A7s7dV/qsF0n9IEWopZXRVUPA1JPl3gWByySq1HAa5EuRlbmZpgdwUTNA7vctKUPkxVG7tU7NOxQ4tStiGpC7pA9dx8sHw4+Eejr4NHQQIL1hCagNg8xEQ1tM4IhrIsDSQKOw91wR3STk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301357; c=relaxed/simple;
	bh=yvWh03IwtFbL8rT7WKyGQQg09oQ6Fd3KWDBq24Cp3PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSQ5PhM9cmCWA63LSbicc4GHBcmpI7Y6DLHoiV35kzuLClF7fqBTh6H94ReCdE8McAOdvyhgeOfSmHYg7cG7nBgFlL/SVTN4raOGTw4bLjG8yFGcYv5orR1ns0P7dbrwanfahT2+D4RHOCZL8IpHrrkVsi20C3I086r4xKkgV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaWQOssZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0E5C19425;
	Sat, 28 Feb 2026 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301357;
	bh=yvWh03IwtFbL8rT7WKyGQQg09oQ6Fd3KWDBq24Cp3PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaWQOssZPC/XNwOl8WQEPnFX0xJdXOVee4Gecy6I4fkKjFBv3e4mXXspMRTrCXNYj
	 iapLP/MChRyNls4EyHhpFTsFeuOxKouwzHjkLKwro6rjAg6x6Yhpq/tB7R+AaCpl3F
	 QlGEaJ17qQKE3FQZvM4bNpGJNXV6Gj35F3PE+ZlfF7os2fxiQ1cStgcnvo/cS0MhBd
	 A+cVTTa47cfk1KyJ5hT/krNaAk8bw0alYETmFRLw1vD8qJ7mXUxTg0Qq/9YgWXSUS4
	 tQx8rJRHbJPgZXNbILTMN/Z6lKc2T1xVZbKQnzQCBpeX8LxpJhY0bNGuTjnoGPvU/w
	 3GgpyBIjpbpbA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 545/752] bus: omap-ocp2scp: fix OF populate on driver rebind
Date: Sat, 28 Feb 2026 12:44:16 -0500
Message-ID: <20260228174750.1542406-545-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221014-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: DBF5F1C7864
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 5eb63e9bb65d88abde647ced50fe6ad40c11de1a ]

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org      # 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251219110119.23507-1-johan@kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/omap-ocp2scp.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e4dfda7b3b102..eee5ad191ea9c 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -17,15 +17,6 @@
 #define OCP2SCP_TIMING 0x18
 #define SYNC2_MASK 0xf
 
-static int ocp2scp_remove_devices(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-
-	return 0;
-}
-
 static int omap_ocp2scp_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -79,7 +70,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 err0:
-	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
+	of_platform_depopulate(&pdev->dev);
 
 	return ret;
 }
@@ -87,7 +78,7 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 static void omap_ocp2scp_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-	device_for_each_child(&pdev->dev, NULL, ocp2scp_remove_devices);
+	of_platform_depopulate(&pdev->dev);
 }
 
 #ifdef CONFIG_OF
-- 
2.51.0


