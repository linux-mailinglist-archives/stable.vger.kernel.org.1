Return-Path: <stable+bounces-66003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC794B735
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 09:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9182815CC
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FD1891D9;
	Thu,  8 Aug 2024 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Yo9vHN7n"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9F18800D;
	Thu,  8 Aug 2024 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101110; cv=none; b=h54C0Bded2uQaFVeXw4Yzn60va57x1Jm2cmP7AjCo3JaEb9dknmfI5Hqydm3w+YDC7BCBdaGd5TFbeUebsO4GwW1jtR3hVPpJdB9QkPGKXfA9ZtYxUR2r/hngs7VIRbawiY2OzSOh30znqJvyDtSovABV2Te+VC7KEeRw7466F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101110; c=relaxed/simple;
	bh=o7cAGLslmZA+T1Zp4OWB10YqQV5FSDeXwMinAEvdo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xhurg9SEckc8fer6X4HwTcjUM0vf8+Kp0ta1VbiNDc0bcXoD3QImoFYgxW0CB4LLzSo3oXaD/OJ4zM9PesiuthzBrAGiEonwFTjl486s4HlEK1OE09mpgKWRuhVHV/hWA7q90sRVSRxTUZKTGlgzyBG7A0To067YRN+WMIC51t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yo9vHN7n; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2450BC000B;
	Thu,  8 Aug 2024 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECDVzrgNjvjBjKFw+cXG3YV6tgCkVLoJ7Bm/DlpwBr8=;
	b=Yo9vHN7nmd4VkeU6GeILhcMizkAzJN86kyOIXQK932ouZtwNLBmb6u+FupyEMVVQJO8bty
	y7pQ3AddojSxEDSDQ0HQCMIkuAkZ1RtdAYBHfPWtogtSU0B6fRZQcqnXay5kaUuJmIieKO
	/bXfz+a5xYzGs8eVBF95f7cdXhVzy6y14IZLPcGfFoCyaAvSArr2YZgubMjFsu6RFRsYOq
	yPWstOGv23O8XOHyoB4C0BGhwJdO4zANeq3yu0rzD3OG6B3r7aWAU+kS9PvG8RXQ6F05Ob
	lcAQZ9+Wyl1pzxutwznqWWacdG3ndxgd9EgpjL5zstaPMbTGkqosMHQpOYPx+A==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 03/36] soc: fsl: cpm1: tsa: Fix tsa_write8()
Date: Thu,  8 Aug 2024 09:10:56 +0200
Message-ID: <20240808071132.149251-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The tsa_write8() parameter is an u32 value. This is not consistent with
the function itself. Indeed, tsa_write8() writes an 8bits value.

Be consistent and use an u8 parameter value.

Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/tsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
index 6c5741cf5e9d..53968ea84c88 100644
--- a/drivers/soc/fsl/qe/tsa.c
+++ b/drivers/soc/fsl/qe/tsa.c
@@ -140,7 +140,7 @@ static inline void tsa_write32(void __iomem *addr, u32 val)
 	iowrite32be(val, addr);
 }
 
-static inline void tsa_write8(void __iomem *addr, u32 val)
+static inline void tsa_write8(void __iomem *addr, u8 val)
 {
 	iowrite8(val, addr);
 }
-- 
2.45.0


