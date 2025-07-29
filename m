Return-Path: <stable+bounces-165105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FFCB151E0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699B47B0A54
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C1D298998;
	Tue, 29 Jul 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="WlW9OZrG"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70737149C6F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809089; cv=none; b=GHzTiZ8wTHHUsfSpz4S+VUwS8eGuIjOgO33QVwIXxUD4j65DKy850Cl/u57bT4S4D16zIjf6O+FR7t2So91vZgPVEBnBKwFfpYggtZRNaWrPeWbtnjOe/80nV5YkxWiK+s4FGE7bkmi4NH7SzBzhfaQMTIkli5bZ528j+RmBSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809089; c=relaxed/simple;
	bh=Fv94lyV6pZ3MxhoZ7ZTipP9OdP/zIXUpCbcOytncaTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfm756E1TAnOXrZbQ9Z8oKQ799lJhyWDrln1Xb1iMvT1+xztxmI8xUg96vyNX4M+QBsgANMX7XqdxZzihX+k9pZmTRyL4RpGFSGJFmjtgyCglGi+IyajKRPyOgh+qSSw/lMX0R0YREXUE48oI6zvDjPhnSRpWVqnALTekHYVzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=WlW9OZrG; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753809083; x=1754413883; i=rwahl@gmx.de;
	bh=gVNHV56Lp+CKce+8MdaSfkY34798ViexzsYJTJS7AJM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WlW9OZrGqM0yEIhRt7lQ8oikd4hboU3cv2Janc0fXmmDtHtef4mHRMrGTb99w6sO
	 pRRnY5TsJYcx6wU+HHa2sQIQ41X4UMq9aZ2O/dE++0m1Qa/jmhjkg8JBDwo39lr60
	 dxGvBsNuQer3yrnRdwguIN8IW6oOKbid7hJc6mKAniIS766DEzUlCbhN5/85jtEGS
	 AmKxpDoCTvd4cRCy+IifaAfMymAI8nP0S9cUTAtrr+GySiDO2OJt+Mx6Dyh2dvhfj
	 gpskFNd59rxZUe2GRskxzW3y5sJqYQ0CsF6WcEfVludZ+Fy8LIrXv3OLcfsjJ6MVh
	 F2MHyiSDGEABzhieVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.152.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1v7IxH1iFM-00YXz4; Tue, 29
 Jul 2025 19:11:23 +0200
From: Ronald Wahl <rwahl@gmx.de>
To: stable@vger.kernel.org
Cc: ronald.wahl@legrand.com,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6.y] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
Date: Tue, 29 Jul 2025 19:11:14 +0200
Message-ID: <20250729171114.3982809-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025072953-fondling-cupping-d67e@gregkh>
References: <2025072953-fondling-cupping-d67e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NgJcNDtQjErvgkKBj533VEHDvEYRslymfOZ576qVy7+rHi9Tyt1
 L3v9YOglqcv7cfSFsXlPVYRo/DF2xgI1OnvkjKjALQiMqXlSNJ8PFSG49s8pWUiS3vUY3jr
 b+bB4V+bSWVuW4X45Yqs+Ychgba3Bful98HJlL+e/hmNcja65KrgbbWqTNTO8VYUlrunrB9
 OVmBWu4N2MQXMMhLPGJtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dr6xoZ3RMJc=;fpjpjApvgRAXk3t4xkaCQcmOAru
 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

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

commit 04a8ff1bc3514808481ddebd454342ad902a3f60 upstream.

Remove incorrect checks on cqspi->rx_chan that cause driver breakage
during failure cleanup. Ensure proper resource freeing on the success
path when operating in cqspi->use_direct_mode, preventing leaks and
improving stability.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/89765a2b94f047ded4f14babaefb7ef92ba07cb2.17=
51274389.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[Minor conflict resolved due to code context change.]
Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
=2D--
 drivers/spi/spi-cadence-quadspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-q=
uadspi.c
index 9285a683324f..7c17b8c0425e 100644
=2D-- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1870,11 +1870,6 @@ static int cqspi_probe(struct platform_device *pdev=
)
=20
 	pm_runtime_enable(dev);
=20
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	ret =3D spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
=2D-=20
2.50.1


