Return-Path: <stable+bounces-242189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAk+MOGb82kx5QEAu9opvQ
	(envelope-from <stable+bounces-242189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:13:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303334A6BE3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37B29302AF13
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87547AF6A;
	Thu, 30 Apr 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC7CZjax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927247A0B4
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572828; cv=none; b=oCZAZKU0ku19X0CSXGS6LbHEplanMvAUPa/Xgw3HCrgVzGTa31URyO4AWWphjlVIJVREaGhp3PmSrAgNty8RZ7l+Utb6m3Ftegc4BmUilVp/Omy251x5TrFCLZJRvDj/VVqV7t4nl+snAb0UBiHd8uyK3NkxbMgiSFRJT99n6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572828; c=relaxed/simple;
	bh=fRV9JG7plhG+aD7zKpl7SRQg+hhJkjF316a/dKv0yyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpTnH7c6T98ZxgDgXGSd1sxtiDYyUDUwHluVgMYFK/qGgad77zfucRUQd9xxC27K1bi6krrQZs7K+6/8vXMQyapwpkUIU4PbCkPZsi6gPPhfE52IEbR0OOytNUUndmp2CJ+92SXW6s4+hcD26koMu4fEkM6xbN+MQV/iew/VwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC7CZjax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F5C2BCB3;
	Thu, 30 Apr 2026 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777572828;
	bh=fRV9JG7plhG+aD7zKpl7SRQg+hhJkjF316a/dKv0yyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HC7CZjaxdokr34UlU5AYeC5tKlqYf+8uWQICTav0H0R5aUBbxvTefZdYnAD7gZMcJ
	 bU1FHRa6eRBsfb5zzuT7OQAKlJsEJy4iRxrd6MGpv1hrsBfj4zV1FJUIPBB33nL36V
	 SFQxTQWyl5JKwnAROFtS0lo2tcvYEwL/5bIfTQ2HzW4cKZs2eYjp8Ixt5hYgKhh18P
	 vVonfO5TnsN4Cn79BzxOyWivFedmOTHdP9ilX1kydIIcItkQvGcxzJrNjNx4gNEzM/
	 v6vxtXKkd1W2HAFBJVgveMoylYLDZKlDoJqr2yY8IDIH92p9tyIsUiXDy6JAMBsGXt
	 570d7HrtFzbUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] spi: imx: fix use-after-free on unbind
Date: Thu, 30 Apr 2026 14:13:44 -0400
Message-ID: <20260430181344.1923600-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430181344.1923600-1-sashal@kernel.org>
References: <2026043052-amplify-gag-dbbc@gregkh>
 <20260430181344.1923600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 303334A6BE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242189-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 1c78c2002380a1fe31bfb01a3d5f29809e55a096 ]

The SPI subsystem frees the controller and any subsystem allocated
driver data as part of deregistration (unless the allocation is device
managed).

Take another reference before deregistering the controller so that the
driver data is not freed until the driver is done with it.

Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by pointer to struct spi_controller")
Cc: stable@vger.kernel.org	# 5.19
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260324082326.901043-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9bf9ded1de1ea..f37fcca4e2e94 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1884,6 +1884,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
+	spi_controller_get(controller);
+
 	spi_unregister_controller(controller);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
@@ -1897,6 +1899,8 @@ static void spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
+
+	spi_controller_put(controller);
 }
 
 static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
-- 
2.53.0


