Return-Path: <stable+bounces-235591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOX+OIWy2Gk8hAgAu9opvQ
	(envelope-from <stable+bounces-235591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1423D3EA2
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8556300D373
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5E3AE712;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAsk765v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D33ACA7C;
	Fri, 10 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809137; cv=none; b=fq6fwTpsBnk1MR5zdncgp8gFXek1bbpzt/gM8BeGSgXwrpqLKxaA9BiGqUBfrAKjhtnGhaiiXlZjXw6F/HitzxYx3MXD8LPeBwdkelg0DcFyuf5hbimEc8jA5a/tYEmkC5oPYdKe8v2BvN1vTqe0gtgTpVY4Z+NYHzVhhhxtmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809137; c=relaxed/simple;
	bh=TLi4qGfgMZZZlhmiRkUzE5zMj3I0oiDgiz+990HwJYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQQ8QjIA3/AayNDeretKiBeY5agW/UA8dX8Sz86esh65i4LSKiA+WldVeF5Q088AlRkYoIWnHHluILkjOLfvvo5FD8Eu8z2Q0FoGViiLER9cd2kVCpLzJ6bVVzoe5UrAgFcLxe+ndrg95gXhB2C4mPG8Ba7FkKTwNdgoqU9ppqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAsk765v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8944FC2BCB6;
	Fri, 10 Apr 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775809136;
	bh=TLi4qGfgMZZZlhmiRkUzE5zMj3I0oiDgiz+990HwJYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAsk765vzVHY8UDHN1nUmD/kOHfpwzLWfEaXKtWIHXnckN9YzfzM3BRJ8FTY5/3Q4
	 aQ9eger7yB0HxceXvHVkCjflbHxnhTnsSnRIeMbmGZOnHYrRml7ObjgRwKUINuIIph
	 Lc+qT/5xcffgF8u1AyAzi2KW/Ed3MFS8vXAawTPkSRJAD8w+7yORjLovuS83CrEJ0w
	 uzVvPk+V1zvINc0hTrcK8i9cvA6+oSkuJWzCWGJvta7vtAmSarhBXjA4jw3kVMqUy6
	 +CMEQrvOqAa7X2MWjoiOFM2U9A9GPaCfJ+F6RdPEeyg1HpeLULSAG1dBEYfWAv36RE
	 8ITc7tNwusHmg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB74n-000000026uc-3slJ;
	Fri, 10 Apr 2026 10:18:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 11/26] spi: s3c64xx: fix controller deregistration
Date: Fri, 10 Apr 2026 10:17:41 +0200
Message-ID: <20260410081757.503099-12-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410081757.503099-1-johan@kernel.org>
References: <20260410081757.503099-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nxp.com,pengutronix.de,codeconstruct.com.au,kernel.org,linaro.org,sifive.com,linux.alibaba.com,socionext.com,nvidia.com,amd.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235591-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA1423D3EA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 91800f0e9005 ("spi/s3c64xx: Use managed registration")
Cc: stable@vger.kernel.org	# 3.13: 76fbad410c0f
Cc: stable@vger.kernel.org	# 3.13
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ba85243d6d89..95b61264b679 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1369,7 +1369,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot register SPI host: %d\n", ret);
 		goto err_pm_put;
@@ -1399,6 +1399,8 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(host);
+
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
 	if (!is_polling(sdd)) {
-- 
2.52.0


