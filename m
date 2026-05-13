Return-Path: <stable+bounces-247016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC5ZIhTEBGoxNwIAu9opvQ
	(envelope-from <stable+bounces-247016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FEF53901D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3993F30098AC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0D3A785E;
	Wed, 13 May 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA+G65Xh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FF2D6E44
	for <stable@vger.kernel.org>; Wed, 13 May 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697234; cv=none; b=Qi93Nd7A3QBAqaXG3c7Z8j4tvo55PSF+pdTPIFmCzIkTo87S7TIaP43udtk5prjV5yXLA2LvQd016ps3kQRZG5h8Ur0guUpm3fmhWqEY6QPlhAXEb5c9YE+CVl/EqtTYz0SeasXhsaMlHctWx2UbYCN2KTr6jk4sFnQhgy7bX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697234; c=relaxed/simple;
	bh=MU20TOvr9sTBX6bUmd9qWSI/ecCxRjPKCFo+Kdr4A9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkSFLA6vtr4cT8TmvyNQaRXZobcx+RazrBfmZfYPs4LiieyE0bLhWnG6FdRSH5+ip76C0+oPXlBRfWzDwe8fGdJ/rjEIeL2Se8HtLSO6eMnygZbhDNdDpszIn9Ar/3Em/gr0I1niP/QbPTZhoiDm+aYIkp7nI9NuNHn4F6bvu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA+G65Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB031C19425;
	Wed, 13 May 2026 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697234;
	bh=MU20TOvr9sTBX6bUmd9qWSI/ecCxRjPKCFo+Kdr4A9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA+G65XhYZLCJA5q6TnH82kzDJPDRK1Kc0skQGDQw1pMmMdDGXEtJn5hh0qakNBYJ
	 oM5SaceHEfpslvoTMPFc7ByPs16ol+L+NwA+4B8qBaHKJcI5DJZqAURwHNV+8A23yG
	 6JFP85bJitwbAXd/M1m7NTLy4DdgJVxXNpl1ioAXpQK3XTJpdCd09PAWWo1ox+ShYG
	 vKkH9jsLS62QOtd0tZy9vwVcoUjDfZ2yeQOevv37DOjH+k6KnDzRUV0mLFJsaYVgWA
	 bbWsxHoVZhJtJcmFUEHeI+v+LaAkep+GGjXjUoj/R2o7S3t+7mjz71TJiT/bw1eDjI
	 /4zsYjf3NyWfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: syncuacer: fix controller deregistration
Date: Wed, 13 May 2026 14:33:51 -0400
Message-ID: <20260513183351.3927329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051242-fax-huddle-8d32@gregkh>
References: <2026051242-fax-huddle-8d32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53FEF53901D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247016-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 75d849c3452e9611de031db45b3149ba9a99035f ]

Make sure to deregister the controller before disabling underlying
resources like clocks during driver unbind.

Fixes: b0823ee35cf9 ("spi: Add spi driver for Socionext SynQuacer platform")
Cc: stable@vger.kernel.org	# 5.3
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-21-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
[ renamed spi_controller/host to spi_master/master and kept int return type with `return 0;` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-synquacer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index dc188f9202c97..4422fe9d92ff9 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -719,7 +719,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(sspi->dev);
 	pm_runtime_enable(sspi->dev);
 
-	ret = devm_spi_register_master(sspi->dev, master);
+	ret = spi_register_master(master);
 	if (ret)
 		goto disable_pm;
 
@@ -740,10 +740,16 @@ static int synquacer_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_master_get_devdata(master);
 
+	spi_master_get(master);
+
+	spi_unregister_master(master);
+
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.53.0


