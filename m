Return-Path: <stable+bounces-147750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997FAC5904
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B56188D230
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C1280036;
	Tue, 27 May 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VIg5Qhx3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AE27D766;
	Tue, 27 May 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368313; cv=none; b=g4o8lxvRCoLemPdDLLol10Tx3D/z5ibRqa82IS/C/gMg3kO7uyiPifr0140PWs43rzIJ3bZ0h6SgZ9hkTFIhPY1Fo3sA6WzuVDPbGYDs/s5mEcbdvT1c7P9ugeJgL2vye7mNSCeYzC3xU/0Ik/Sspj0nCWqUEMdTzFNVRcMtmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368313; c=relaxed/simple;
	bh=UyVVhuuPU9BrQG/2ZU5+jsp9DRFAC3d/9vHxwld/BO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVe/GWk/gplrAqZjqZqugfmLNyXJRnI4uDJ1Yh3jt63HNfo0lNQIgb4v2k1z64GhmkRGrjeJ9Rtvl2Q6w2oTV7gi72x2ElDIDLIiEWo0aeP07TNjsp5KjX7TxEpbGKsX2B5E/W5eK6chuD7NJKhiiRbAJsv3dY06g+UMp/dMqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VIg5Qhx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBAEC4CEE9;
	Tue, 27 May 2025 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368313;
	bh=UyVVhuuPU9BrQG/2ZU5+jsp9DRFAC3d/9vHxwld/BO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIg5Qhx3kQINWJPLqLDCgdocJYnA6fReU0d4yaoPISUYGVCHCCAzhk1/EU+LtSnmt
	 EkAcBJd7ZcbRK+utKk368M8k6kZkvRvWpwlqobZAuvTwRmWEchBOUYQsE3TMHBRZMB
	 LaB4ffDtFBZvaPsO4Ji++zRmSrgDNwIADoSfWsIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 667/783] iio: accel: fxls8962af: Fix wakeup source leaks on device unbind
Date: Tue, 27 May 2025 18:27:44 +0200
Message-ID: <20250527162540.286840307@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 0cd34d98dfd4f2b596415b8f12faf7b946613458 ]

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250406-b4-device-wakeup-leak-iio-v1-1-2d7d322a4a93@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 987212a7c038e..a0ae30c86687a 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1229,8 +1229,11 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(dev, "wakeup-source"))
-		device_init_wakeup(dev, true);
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to init wakeup\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.5




