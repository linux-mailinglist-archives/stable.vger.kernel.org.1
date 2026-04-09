Return-Path: <stable+bounces-235399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPa+L9qW12mGPwgAu9opvQ
	(envelope-from <stable+bounces-235399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117F3CA29E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 14:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2671A3071874
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F083C73E5;
	Thu,  9 Apr 2026 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbA7+h86"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5E3C062D;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=gP55dV53Q3l0NwG/zQPw4JLR9TDWFYXm4a8mhKRlmSWLQPqPCdKZb2te6A3uBr78VLHrv/bwBS8PEgsFPiuCg9p3rj2cVeMP5E/rbWBT4QSvFPsdSVjkJjZf7hfujryj0Vw/ve5Jcz3ntFhOq07g4CEsnQyxGI4Qf0TVIBwiNlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=tuNfjIQoyz+Ks6HZ8O/w3x28GoFwiQOi8TzTHCOHUPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Av+zLbTYLnlVeRBNg9jBGORTB75EodwGCVJjWJMdGldXP3O7Kcc/FqYntYyV7YnFcX5hw1j53zjFOfAbxakcVGExH5QW9N9RftUfHNez/SYxImxmc1NW2oOVZsaW023pnELih65nLk/YAUIlK+nZ21bpY2u+j/yL5luZfFmTtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbA7+h86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E511C4AF0F;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=tuNfjIQoyz+Ks6HZ8O/w3x28GoFwiQOi8TzTHCOHUPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbA7+h86tzlRsMowMUd7a6p2un35IUTKJNtVL+xixsaAPbqf/dFOWUelCsC3GpBhr
	 LUSG5hd1mG9MmjVUChaXZJFqRv2O/thI7wn9QQDKQ0REkr5+vwYKxprvckcMgXCZAS
	 iX/9PBsaoSQaLU1BPGsifs6uhy2L7rAVv9vjE61cKC0k/HNzPDwTC6omxEAjD51WLK
	 NIpz80WpDHcNSBmkIHn/5OAt+t40USwNIWfTv3fLY59Bi0wLHWNVnDY3LhJ2wrfy+7
	 HrM+oNi9e6pd/1qfVSaBKuLN6EfM+lYJv48KZofvlA1yjjSOa1iLTsDoGaMf8aoXHL
	 wsM8hQ91Qe1mw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d79-0OyI;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 15/20] spi: img-spfi: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:14 +0200
Message-ID: <20260409120419.388546-16-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org,kernel.org,chromium.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235399-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 3117F3CA29E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to deregister the controller before disabling and releasing
underlying resources like clocks and DMA during driver unbind.

Fixes: deba25800a12 ("spi: Add driver for IMG SPFI controller")
Cc: stable@vger.kernel.org	# 3.19
Cc: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-img-spfi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 902fb64815c9..57625a3ce2f2 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -643,7 +643,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(spfi->dev);
 	pm_runtime_enable(spfi->dev);
 
-	ret = devm_spi_register_controller(spfi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -669,6 +669,10 @@ static void img_spfi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
 	if (spfi->rx_ch)
@@ -679,6 +683,8 @@ static void img_spfi_remove(struct platform_device *pdev)
 		clk_disable_unprepare(spfi->spfi_clk);
 		clk_disable_unprepare(spfi->sys_clk);
 	}
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM
-- 
2.52.0


