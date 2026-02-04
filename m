Return-Path: <stable+bounces-213882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJC2AoZkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2DE86F4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E7930DCFD6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9635641C31C;
	Wed,  4 Feb 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yf/L8gwr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4C41C312;
	Wed,  4 Feb 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217828; cv=none; b=d4qx3D+ByYQnUSowED2HFSbGA4DdhW0JU6L/cp3uHX+x4eu9cAS/bLyv5o+nlxpridcQXWroyf2xL91Nao3nTAjWeI7kWYj680wMmP3ELXrEuv5ar6ehLxvoidxzTniFqiOBEf4UfLQuDZPkU2m6M5jx0c/+qJ8WypkxWdhzj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217828; c=relaxed/simple;
	bh=7uPCuriZgJJxJK2kFd/7RIN+2/yLaSt2QvWNzyMjMU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4EM947hchBpxXIs4hyVcbeUbx3hmwheqN8yrdQGuxivZ/H+jeiVTs/JGHZ4c3/PonD31eDq3jC4dLweg5iEvUR4S6Fix6cRj+7eZmD/jznb2fC3MVeIkEjd42AfWVC34Ph421vEUpiu1irVESM9LzTHJHK4YJBFtfIvJjCt66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yf/L8gwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD86C4CEF7;
	Wed,  4 Feb 2026 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217828;
	bh=7uPCuriZgJJxJK2kFd/7RIN+2/yLaSt2QvWNzyMjMU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yf/L8gwrp/frnxA2eTZ0UW4mbyNU+jVs40MtIgBzHbrbTi3KZD08D0QpXoep8Viwh
	 WpioI/ht6GOeYkR2B5awc1hlslQ0U5zs+0yCzrZbBAMOcTGBcwA5sa/UU/AwK2WGIX
	 jqOo+pkD7TtUJbST69z4Js7t+HSJRdh7d30DrTgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <gu_0233@qq.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/280] spi: spi-sprd-adi: Fix double free in probe error path
Date: Wed,  4 Feb 2026 15:38:26 +0100
Message-ID: <20260204143914.383367777@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qq.com,linux.alibaba.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-213882-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,alibaba.com:email]
X-Rspamd-Queue-Id: 0FE2DE86F4
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <gu_0233@qq.com>

[ Upstream commit 383d4f5cffcc8df930d95b06518a9d25a6d74aac ]

The driver currently uses spi_alloc_host() to allocate the controller
but registers it using devm_spi_register_controller().

If devm_register_restart_handler() fails, the code jumps to the
put_ctlr label and calls spi_controller_put(). However, since the
controller was registered via a devm function, the device core will
automatically call spi_controller_put() again when the probe fails.
This results in a double-free of the spi_controller structure.

Fix this by switching to devm_spi_alloc_host() and removing the
manual spi_controller_put() call.

Fixes: ac17750 ("spi: sprd: Add the support of restarting the system")
Signed-off-by: Felix Gu <gu_0233@qq.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/tencent_AC7D389CE7E24318445E226F7CDCCC2F0D07@qq.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 441cde971f7b8..3e546cd87157b 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -529,7 +529,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	pdev->id = of_alias_get_id(np, "spi");
 	num_chipselect = of_get_child_count(np);
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -537,10 +537,8 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi = spi_controller_get_devdata(ctlr);
 
 	sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(sadi->base)) {
-		ret = PTR_ERR(sadi->base);
-		goto put_ctlr;
-	}
+	if (IS_ERR(sadi->base))
+		return PTR_ERR(sadi->base);
 
 	sadi->slave_vbase = (unsigned long)sadi->base +
 			    data->slave_offset;
@@ -552,18 +550,15 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
 		sadi->hwlock =
 			devm_hwspin_lock_request_specific(&pdev->dev, ret);
-		if (!sadi->hwlock) {
-			ret = -ENXIO;
-			goto put_ctlr;
-		}
+		if (!sadi->hwlock)
+			return -ENXIO;
 	} else {
 		switch (ret) {
 		case -ENOENT:
 			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
 			break;
 		default:
-			dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
-			goto put_ctlr;
+			return dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
 		}
 	}
 
@@ -580,26 +575,18 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ctlr->transfer_one = sprd_adi_transfer_one;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register SPI controller\n");
-		goto put_ctlr;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register SPI controller\n");
 
 	if (sadi->data->restart) {
 		ret = devm_register_restart_handler(&pdev->dev,
 						    sadi->data->restart,
 						    sadi);
-		if (ret) {
-			dev_err(&pdev->dev, "can not register restart handler\n");
-			goto put_ctlr;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "can not register restart handler\n");
 	}
 
 	return 0;
-
-put_ctlr:
-	spi_controller_put(ctlr);
-	return ret;
 }
 
 static struct sprd_adi_data sc9860_data = {
-- 
2.51.0




