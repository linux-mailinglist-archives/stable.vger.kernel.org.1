Return-Path: <stable+bounces-197987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02BC9928D
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 22:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 577504E212E
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA493233140;
	Mon,  1 Dec 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDfvkd3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BD184524
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764624193; cv=none; b=FErDoslUQW98pfig/mtvpuoTQnSbVR7KTFqPCN0PMJ32AnPATYqCbphGuR1K3LyG1SwQo+lRDhupSAU8A4EwrSxkbJNCtHrE9pP6T3eiem101DC4EPXBusetsBCEfe0Dl4UmabRkpIQzK3sATpPtvWq6iAf2RQegW5+4BV9EQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764624193; c=relaxed/simple;
	bh=QfOd2eJNn3Q481Y9KPLNwRSQyR+vOESQMd6aMbSAruI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhiS2M5oamcIA8vFg2RcmTsqlL9Pdw/6KA69yOBSzM1A/w6aC44HMoyGxYWY6nJ7ezLC4+auqZiRB8+Nqq+W0hObNvBlkFmLg0Ptu7hkor0f7i0XWSrvMWQyM4VzH1ThnlCanDTChsM8AoxEXckKbwj6Uue31fgnLd5AgDJt0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDfvkd3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069EFC4CEF1;
	Mon,  1 Dec 2025 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764624193;
	bh=QfOd2eJNn3Q481Y9KPLNwRSQyR+vOESQMd6aMbSAruI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDfvkd3M8DzVFfx+4y+e3T4vAg5yZolBJYz/6pctaqiuVGvTcg4w3ROdEjukb5Ef9
	 73+5ddLToWCKr4RYvfDfWcUf8i/LLntWfJ1bj2WG4WY3w1VXzw057VFycv/XWJXbaW
	 tUs5e4q7J0HChEnOxNa0VfDWt7f+ODQPdFp+NtRSZnow5K8gyeR/yQJ6ff8lC5X2nX
	 uxRxjcSDK6/fDvelQ/d0+eT+ptf+bm1QKYL4VsW8M7bcTPFxAXiOk3AhvXh6UXPO3O
	 vrxAYJlh75lvOxHJwQfT/uf4wCD7VqT6UDkd93y0uAipbhipTOIR/77Ur6KbpKCHlN
	 BVmQENogbMV3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChiYuan Huang <cy_huang@richtek.com>,
	Andy Hsu <andy_ya_hsu@wiwynn.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: adc: rtq6056: Correct the sign bit index
Date: Mon,  1 Dec 2025 16:23:04 -0500
Message-ID: <20251201212304.1261553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120113-employed-paddle-1a20@gregkh>
References: <2025120113-employed-paddle-1a20@gregkh>
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
index c1b2e8dc9a266..04ce542f8ab3f 100644
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


