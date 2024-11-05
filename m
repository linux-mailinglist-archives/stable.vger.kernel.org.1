Return-Path: <stable+bounces-89846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A589BCFDB
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFDF1F235D4
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0A1DAC97;
	Tue,  5 Nov 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KWaTZyu3"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D931D9588;
	Tue,  5 Nov 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818613; cv=none; b=LQO6jQ6z5j+8lsZKBlT0BTqwTtfyFiXuCBBBHN/yLOU412uUT2tpf+Inl6H6HWsV+c0n64bBFLsFUm4at20YCYtgK1VHUIkzlZdOiFASkxi4gffuakv9sdfFS9c5CJrLrqkysrNv06Usaa9s01BZt9ysozKZvcpXZMRK6UmcnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818613; c=relaxed/simple;
	bh=NzjCVKdAFx7+QxSlsS/mIp9dss8BCH7ZZF7zgDUxFDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu34oi3cukStqWUKzx+aR+C7jsEArNwM98j6CM07EDgR0yZ7wrWKZysGO4A4JeVj/P11dd/NGeICZELq4KQ8eQBmaRp0i7KUY/i0oe+Bjez34Hsym2CSFZe8eAnHCdy7OPXzO8XOk0ve3zNhDImZRcHahciwzCHj+LDkrAuiao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KWaTZyu3; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 200CE40010;
	Tue,  5 Nov 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730818609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QA9Z6DlABQAh/zHFAwCMIMgA9gtG670bOQgehg6enAk=;
	b=KWaTZyu3vLcDyz9FWyowSmBHC3XiZrmKJULGPtt9hzaqj0+xJODq0QR1ihReN61VqnwxCk
	cyoakzjNknp34vXM3mBZCHBYo0gmRejGd4PWdqrQoDSwYqgeQGazh5ofxOpKDGc6x7zm8X
	kSgyKuZ0UDNSmVFqo+CFEGNa+MY+IsX8tKInCVCBVJh6Y73IoUTL2hHCZUv5yZeg+3gDmY
	CP5ktynlkskg3ruNt8nCELLrlhibV7PF6UGal945LwEqulLbG5vGsWom8qQx5vINJf/c9s
	QAXF8i1kCKMsokbKbWKwXiIEQqqY6emQ3dSvWkcVoiJ0juZ/S7e689/sACCY+g==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mark Brown <broonie@kernel.org>,
	Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soc: fsl: cpm1: qmc: Set the ret error code on platform_get_irq() failure
Date: Tue,  5 Nov 2024 15:56:23 +0100
Message-ID: <20241105145623.401528-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

A kernel test robot detected a missing error code:
   qmc.c:1942 qmc_probe() warn: missing error code 'ret'

Indeed, the error returned by platform_get_irq() is checked and the
operation is aborted in case of failure but the ret error code is
not set in that case.

Set the ret error code.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/
Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 19cc581b06d0..b3f773e135fd 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -2004,8 +2004,10 @@ static int qmc_probe(struct platform_device *pdev)
 
 	/* Set the irq handler */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	if (irq < 0) {
+		ret = irq;
 		goto err_exit_xcc;
+	}
 	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
 	if (ret < 0)
 		goto err_exit_xcc;
-- 
2.46.2


