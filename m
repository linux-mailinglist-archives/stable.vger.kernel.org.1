Return-Path: <stable+bounces-248512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP2mKvhWB2p7zAIAu9opvQ
	(envelope-from <stable+bounces-248512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:25:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82A554FB7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D82F334C768
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001603FBB55;
	Fri, 15 May 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2o3Sr+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B043F9295;
	Fri, 15 May 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861918; cv=none; b=Uhp9yksXU+xqzz2yhZVwZEO2Sww0i4prgmIk7C9/ytkeVXfQ3mkesbuU7KCkNN1QmRpWDvq9Q8ZD3ylELUEmKokxWRJfMDKMDUbwPiODyzMJjMSSn/kax2xKQkidcr2ep2MvPizfXW17oL8y9/8mAh+CYtBJkqPfSuhTs6Q/uZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861918; c=relaxed/simple;
	bh=0t7CvUlohKO91UwjGwwHRGXU5jWx7yBqLZhKcjUqSK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2+diEiJxK5ZRNU6D4auX/k3mqze5N/Wr81ZpjmyxnRhON70laqbbQ4gPQwWyNQVRA8SrKNsjE3wVMJDh+Ry2OFDSkUVxKcnZQL+AuioQ0c6JoP/hgSXUd1ND/payYTHJ/M/9CbTCPD2Ac7t2LaUlqhG8IElPN9vV1fP+8j98CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2o3Sr+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497B2C2BCB0;
	Fri, 15 May 2026 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861918;
	bh=0t7CvUlohKO91UwjGwwHRGXU5jWx7yBqLZhKcjUqSK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2o3Sr+9YicQlzrCoDVaLGeg+aG0SS7HaMPcFsrLkKSXm2M4ZtL4HcEvd+qQL4Riw
	 cX3ZnnoXY39Zxnp1VVvCCQdjw6gqm6fAI9rge2gp13PYQqw9dXvKMOAASn+T17ZCk5
	 EMwjH1bAHrfGRAcvrCKxcJYyQriHlHD1QQhI7r54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 038/188] spi: meson-spicc: fix controller deregistration
Date: Fri, 15 May 2026 17:47:35 +0200
Message-ID: <20260515154658.136484523@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5E82A554FB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248512-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 77953c76bec9af4191f8692a10225dd816208718 upstream.

Make sure to deregister the controller before disabling it to allow SPI
device drivers to do I/O during deregistration.

Fixes: 454fa271bc4e ("spi: Add Meson SPICC driver")
Cc: stable@vger.kernel.org	# 4.13
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-18-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-meson-spicc.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -1082,7 +1082,7 @@ static int meson_spicc_probe(struct plat
 		}
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "spi registration failed\n");
 		goto out_host;
@@ -1100,8 +1100,14 @@ static void meson_spicc_remove(struct pl
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
+	spi_controller_get(spicc->host);
+
+	spi_unregister_controller(spicc->host);
+
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
+
+	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {



