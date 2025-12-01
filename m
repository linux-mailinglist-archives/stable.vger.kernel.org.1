Return-Path: <stable+bounces-197986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62BC99274
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 22:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768473A39A6
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F122080C8;
	Mon,  1 Dec 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBJuw90h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559578F4A
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623675; cv=none; b=H8Nfuu++kMHYffK+WTWJvaHK/w0ZnrlsfCdcmYg3qvnc1baA0hcGSjwk0l09hyKQTs3pQfJCCgyLptajh4KBhQo/YMMj6+nJp1sT0BEf77OoZVK/RhBeA0xHM0c+rjl3dX1clrS3C0fFxf2U5wETJD7kAuvZKm76+PXNbm05Jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623675; c=relaxed/simple;
	bh=/qm6BJYu+dnKlM9NA0aCaHnapg5kjcaM+WGbo3ZM35s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYDMUqJWkjiohPB+LcuVDb53BccbLPRSyVuv9yt/eW0+rbLQmJcY7D3w6D2vy77Gx7geOHo799dTcWbKrfdUAx5AkjwFK8KEW5r3na6EybhZcSIkELOwyGJSxGbp28fbH7yTV6wE4cQC8+pzC0T5GlfT/GyQKrKMDQftb33vLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBJuw90h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F776C4CEF1;
	Mon,  1 Dec 2025 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764623675;
	bh=/qm6BJYu+dnKlM9NA0aCaHnapg5kjcaM+WGbo3ZM35s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBJuw90h5oPNpbUYuS+P4sRS+Vo7L25OuX0F3SyNgONBNdT7fysaH6GIHPyoAv/0Q
	 zK9FoFX1wzOX0jjYkT3lZRw1GO3xX7qAmLiouFOATEPRdbiFkCW1jkCNLTutxi5YzP
	 4JWNNkInxdaIcVIOYj+ec3Vh85oRH+VECqOOZ68LFE11doubVUAsZAejXUe8MFRH4M
	 HuSStUhhVzLI3kzLTvqLjBAiTqR+Ny6w94Wr1F/SQowOMC1Qzicw68lZKCEjT1PrXH
	 LNBccCnYWsurLzvzSayz/Z7s9UM1xurbMomIRRudYkcVsZ7I+GCWDjOGujPGs0082S
	 eUzHZuuSBD+kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChiYuan Huang <cy_huang@richtek.com>,
	Andy Hsu <andy_ya_hsu@wiwynn.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: rtq6056: Correct the sign bit index
Date: Mon,  1 Dec 2025 16:14:31 -0500
Message-ID: <20251201211431.1259882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120113-voltage-chamber-e0d4@gregkh>
References: <2025120113-voltage-chamber-e0d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChiYuan Huang <cy_huang@richtek.com>

[ Upstream commit 9b45744bf09fc2a3287e05287141d6e123c125a7 ]

The vshunt/current reported register is a signed 16bit integer. The
sign bit index should be '15', not '16'.

Fixes: 4396f45d211b ("iio: adc: Add rtq6056 support")
Reported-by: Andy Hsu <andy_ya_hsu@wiwynn.com>
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adapted switch statement to existing if-else structure for sign_extend32() fix ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/rtq6056.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index ad4cea6839b27..3ffdcb9f88336 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -171,7 +171,7 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
 	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
 		*val = regval;
 	else
-		*val = sign_extend32(regval, 16);
+		*val = sign_extend32(regval, 15);
 
 	return IIO_VAL_INT;
 }
-- 
2.51.0


