Return-Path: <stable+bounces-221368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kb3EhuWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A801CAAB6
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A21A305C2A7
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B2B27FB3A;
	Sun,  1 Mar 2026 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS44EVlM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58E2749C1;
	Sun,  1 Mar 2026 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328088; cv=none; b=iuaExAK4nnPjYNRjzIj3p3Ze89PhnhjPbfic1wckbcvLKp5Qa6kvWOzbosQPCclstHFOM8sNBMzqdJwlCkPLUvOemLHaNuN/pHe6rlrwgVtM5VarJNOEhEQYCcqcIfuAPqsXjqeoygKqCwlQPHSXm/3TnLjP7Cf1eoKqicBOESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328088; c=relaxed/simple;
	bh=7jmpjCigquPdyWW4HUmzCGZIlkMhHpQ/ZZIdZBrCyiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhgaLQf9J+XZ+HGvJEXLyRYZvNUt9K4Q5q6NhCZVAum8Aw/PtVQrtLfxsW/W0HfIP3+ZE/6aU50B/fG1sp29DMkCVvsgma0hlbTU0NnW6DQY3SOtlhEpSkf3ccx+y0fGb/5l1FDcvne9sSwcDVe5mvEcZx6EYy3QKTpaT2HA+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS44EVlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B03EC19425;
	Sun,  1 Mar 2026 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328087;
	bh=7jmpjCigquPdyWW4HUmzCGZIlkMhHpQ/ZZIdZBrCyiY=;
	h=From:To:Cc:Subject:Date:From;
	b=QS44EVlMStg1rNkMbOoMOtwMw5bAJaiPRlv4ourn0EdngyOZg6lYissv+JMbmtv3r
	 R/AJc1w8eLWuaYlxmW1BV2oG6eKXyaxlj2bG7EBP2r983raZnEOTtOXpNdbWh9ARqN
	 2I5s5M02lPGXKPFA4mZkN2OC6qS0MyiFtG8QWMdHwCj4Rtcpth1TPFrVVghTe8HnF3
	 LcrGF0wf6ivXYlkMWCoUS6MnX8diEgTm2hGs1mzgG6o0do75khaXIRJk43KLaDc4co
	 1FO8TA13qaVTf0l2v4SBBrXScKoLGn+EPgjUsNPffh6n9G5gWzVHX5/XdDK4WDtDcv
	 STlc91ZCFPj8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "bus: omap-ocp2scp: fix OF populate on driver rebind" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:25 -0500
Message-ID: <20260301012126.1677346-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221368-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73A801CAAB6
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5eb63e9bb65d88abde647ced50fe6ad40c11de1a Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:01:19 +0100
Subject: [PATCH] bus: omap-ocp2scp: fix OF populate on driver rebind

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





