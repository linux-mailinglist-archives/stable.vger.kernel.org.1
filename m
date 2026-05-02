Return-Path: <stable+bounces-242570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIVXGHBd9Wm+KgIAu9opvQ
	(envelope-from <stable+bounces-242570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CE4B0A7F
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3638E300D93D
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6018E02A;
	Sat,  2 May 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVdrwM20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4C29CE1
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777687917; cv=none; b=CK/LOxLP9xjVl/HcDvUJ+diCfpaImMIr3qr6+lh58GMvp62FN4gXaH9TATtimHh696SHJ2NpQ77ea0mfb302Qe8l8mF/EZZweDsgsDjRL/QCdPRjizuN4CJMg1eSzHSNKrSPv9IrM6g/6612q3RSJXOviWumArYtyFBMMBduG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777687917; c=relaxed/simple;
	bh=tu2AH3OZrnfgWpKAbJZ/OdXqr/fZRXDNwpwshXYUIpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1iHSAmj+u9Qk49ApjjBSp8dNH2QxM2F7dVJWnvHxiayNMH/gxQj7egLlFg5XQu/gCyKDDCCdbWtNutCJAsucoW9LMr49q0ZUteuHBZzlAXAPNcvqlBB4qmy9gXwy/zI6HNjo5lW/LJcnAbUckLdy3A7Xll5uAmEu9QW+FeV3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVdrwM20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8D0C2BCB4;
	Sat,  2 May 2026 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777687916;
	bh=tu2AH3OZrnfgWpKAbJZ/OdXqr/fZRXDNwpwshXYUIpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVdrwM20yuC37RYFtWMTjYQN94jRR1MAH4HJGaaIWGs4wr45A8qDtFeO991VzZa3E
	 QzpOUemYzu20l4ec2+fiIK2VxcMBirBOQ4OGsUhqJmchvVXfSpCaEVOArdKQ9kYsFG
	 lS9+SKYTfu3tEM9NYjg5KRPHEuYzMZpqOBq1JvWJV5HNb1x7vqhboKpGKUHaeJmman
	 wONp4VtAvLjr0bNik1V15erBxxgKa9HsAw2GDTOCUiNOG8NkAGsgWs/MrRvQTLpX1l
	 dJZp9c61/1Je25mPWJ1HU2PCwFsFREaPyw9EDdk6KC/8O8gGnJyG+9KuIB7umg4olK
	 O7S0JPsr9VoDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] mtd: docg3: Convert to platform remove callback returning void
Date: Fri,  1 May 2026 22:11:53 -0400
Message-ID: <20260502021154.4166366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050109-regular-masculine-854d@gregkh>
References: <2026050109-regular-masculine-854d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BB7CE4B0A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242570-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

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
index 27c08f22dec8c..25a7df6448028 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -2038,7 +2038,7 @@ static int __init docg3_probe(struct platform_device *pdev)
  *
  * Returns 0
  */
-static int docg3_release(struct platform_device *pdev)
+static void docg3_release(struct platform_device *pdev)
 {
 	struct docg3_cascade *cascade = platform_get_drvdata(pdev);
 	struct docg3 *docg3 = cascade->floors[0]->priv;
@@ -2050,7 +2050,6 @@ static int docg3_release(struct platform_device *pdev)
 			doc_release_device(cascade->floors[floor]);
 
 	bch_free(docg3->cascade->bch);
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -2068,7 +2067,7 @@ static struct platform_driver g3_driver = {
 	},
 	.suspend	= docg3_suspend,
 	.resume		= docg3_resume,
-	.remove		= docg3_release,
+	.remove_new	= docg3_release,
 };
 
 module_platform_driver_probe(g3_driver, docg3_probe);
-- 
2.53.0


