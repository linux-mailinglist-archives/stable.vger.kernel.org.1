Return-Path: <stable+bounces-248099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIQwJ/xGB2r6wAIAu9opvQ
	(envelope-from <stable+bounces-248099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:17:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9217552EFE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDC5430189AD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619893B27EA;
	Fri, 15 May 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZFyP5sdv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250913A961B;
	Fri, 15 May 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860870; cv=none; b=C+N1aQ7w75mlzRDMt+uaNZ3LzX+mQbeYLPNvW0K0M8djLYTcDB9IsSqQbxELLXsHLnYJ2wq29rMjnsvGZsGMbyhHioBlbxo4dqliCSQAT0zpzj04QzPhfY7PxpeDipqmUPYlIzXpAHVO7QMr0452sXTOXhuJqGtJNLn6s732IAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860870; c=relaxed/simple;
	bh=1kq05aRQ4Af6uNckjwxXLzsZEl05NR1lOiL6PTCFlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvn3BSok/BstOui63crfGW/cJixl0G1RwSuoeyYHOdzT+qagLBFNyItuFavDiStEsjYDZBArdpx+ETANEHyCygrfTzBWGjlxU5hIMnDuEfxMabn4PXvBzO1pd8TD9Ev122y6lr28MO9YzEZwHi09Bpfl2mGhafjVNN7F09W+BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZFyP5sdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED1C2BCB0;
	Fri, 15 May 2026 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860869;
	bh=1kq05aRQ4Af6uNckjwxXLzsZEl05NR1lOiL6PTCFlis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFyP5sdvW/KOTer6DlV9HaVzMAASihCXO00U+MJJSpVIlRxwcovMn5I6A5lwssUMM
	 Ihfh6W4/1vl/+RrB2rblwer5qTnNBULTIPujtUzJl5tntcdHw9w2S0zET6XywCK7rn
	 yp6BDmMIvLa1DHFwf0UXf6A3ofFUEj1LuUC8MbYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 108/474] mtd: docg3: Convert to platform remove callback returning void
Date: Fri, 15 May 2026 17:43:37 +0200
Message-ID: <20260515154717.372239641@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C9217552EFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248099-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,pengutronix.de:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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




