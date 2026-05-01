Return-Path: <stable+bounces-242554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJyJNe829WkeJgIAu9opvQ
	(envelope-from <stable+bounces-242554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6004B0475
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAAFC3015895
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38337E30D;
	Fri,  1 May 2026 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIwB+cVj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7D1A8F7B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678059; cv=none; b=Ad4/R47WiRUrfW3+Ss4QWBDi4AD9XgH6H0HDUS6KlzccZIGurkAHWcfvTdaLEzemVCO0Afu+3b3kQ0xavDipp7B0BSSNAoPneqac1cL1hfAtRsY5eom/Wzv4eHbKVPqxIo3b4ZQXGEMxWIaoTXmrKPYOROOvTkqxv65ZXwcEDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678059; c=relaxed/simple;
	bh=k+51q4ArfX0BGc0CHN6NFFHC5lv0dboW5ODm8ja6qpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP9UL11sY64SDlTpNYMhtDM3BNlFsyV2yY5kyyT7gvrZj007X8qFukG9ySqNzb6+ustF2DJAL7sBI+wfXBcm7SmwsBz0MJuuIlmIe/QkHGSDgwOCX1VnOrTViEqcjZGeDTH1Nupp/G4D9cgCt6NUAyFgIHJAfsj7FUTIEQKuCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIwB+cVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3582BC2BCB4;
	Fri,  1 May 2026 23:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777678058;
	bh=k+51q4ArfX0BGc0CHN6NFFHC5lv0dboW5ODm8ja6qpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIwB+cVjzjG8glAGRAg4a3J34aqwlsiAWRAkg44MhzPm7EM6/V6QhfYlcE3AsXfQ5
	 p8c+PVy/e/1UoQpOAm4SvM0bm0w6nUx7a7YjsKmRI8odLIXmuSHgbD03I6NMPVtTae
	 vb9bMG9AgRch3MR6vYyDFDVnsElMDO5acCmh3VS3d29H7KWKYbQBOuRsxTdiLmnFkV
	 oSazYCCGcmaddcpqh9svUQ8Dx/tBp6mTlTVepYy7G7/od6BLhwJZfBEHxDuASfb/V0
	 hk+BN9mdCF7pkJXSXFpEwi4SilEXs/NUIKSjWwB/EZvMoturyd4d8WS6rudEyT0d7b
	 3Bd4JA/lF8q1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mtd: docg3: Convert to platform remove callback returning void
Date: Fri,  1 May 2026 19:27:35 -0400
Message-ID: <20260501232736.4099049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050108-ozone-wiry-64b4@gregkh>
References: <2026050108-ozone-wiry-64b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F6004B0475
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242554-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email]

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit eb0cec77d534413a800ec20944a2b1e37cfecdcf ]

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
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/linux-mtd/20231008200143.196369-5-u.kleine-koenig@pengutronix.de
Stable-dep-of: ca19808bc6fa ("mtd: docg3: fix use-after-free in docg3_release()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/docg3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 22e73dd6118b9..a2b643af70194 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2046,7 +2046,7 @@ static int __init docg3_probe(struct platform_device *pdev)
  *
  * Returns 0
  */
-static int docg3_release(struct platform_device *pdev)
+static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
 	struct docg3 *docg3 = cascade->floors[0]->priv;
@@ -2058,7 +2058,6 @@ static int docg3_release(struct platform_device *pdev)
 			doc_release_device(cascade->floors[floor]);
 
 	bch_free(docg3->cascade->bch);
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -2076,7 +2075,7 @@ static struct platform_driver g3_driver = {
 	},
 	.suspend	= docg3_suspend,
 	.resume		= docg3_resume,
-	.remove		= docg3_release,
+	.remove_new	= docg3_release,
 };
 
 module_platform_driver_probe(g3_driver, docg3_probe);
-- 
2.53.0


