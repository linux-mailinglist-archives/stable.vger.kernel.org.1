Return-Path: <stable+bounces-172735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCECB3302F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8008B1B264E5
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603A2DCBFD;
	Sun, 24 Aug 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OckVRbMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555C2D7382
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042749; cv=none; b=ndWDDQAiiGNpmjVVjh6nQ7qMWBexVE11wQ0iKS6ORn3RmsZKkf8Gb22VubtO5BOZLD7H+bEsZ8K4IJZ2pn+DEKMIOO2dFDB3svxBKhS0a5WUvTEhMnvxjBg4MeSboB+3z9h+fw3uc91u8mm/sJgq0nucoLY5iI6CU+gSfIccPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042749; c=relaxed/simple;
	bh=5O3KzdW+GnTFP7HR+gX14If95iyeRLIMjPiGvPamSKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lurocsYm4/y0iw2YmAIhSpNEdxf/D7sBclex628+KIkQJxwKrKtpsHu2lCzZaqwFcMYIY5Bt/tEWNGV2w3VCzyH23ti+8iUBcBM76agaoOYATtY6hh5QVWdzPnX2yk5wrdZ/Uo6L2IiyP9WAJOFZ9OVFLUV00MElnIZvzdH4HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OckVRbMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D9FC116B1;
	Sun, 24 Aug 2025 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756042749;
	bh=5O3KzdW+GnTFP7HR+gX14If95iyeRLIMjPiGvPamSKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OckVRbMJeivdDAXEKmZmOpbPUKIr0PhIsSe3c3SExQNqV7YVBe7vGdrmUhyTEPXbc
	 6RD/o38IJFRzdGcnRDQwN7plNl1OlGI3PZmsY3JEL9jKF2u+xBGLc4EJrNPbwWK0Jz
	 QKxYKs8yOWcXn13AENWnX9ki5sgUVTG4N5fVjHYn8GqE8NHiYRx+lN7ctkwPo3qjsH
	 jwQJVNXEY/1iBCAlXxS4s3I2sHliPjCSZWQ6HWQ2DAtrPQLy+zz7+nH8edEn/tj16g
	 9HwM71hmiv96+vnNIxpdVeEv4ETBd96JJaDPFtrC6xMugOJeW7+MqPagQJ+K5yenji
	 Nfy8KvX4bxCdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sun, 24 Aug 2025 09:39:06 -0400
Message-ID: <20250824133906.2897205-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082318-value-headless-fcab@gregkh>
References: <2025082318-value-headless-fcab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 433b99e922943efdfd62b9a8e3ad1604838181f2 ]

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/as73211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 76b334dc5fbf..dfeaa786b148 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -574,7 +574,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1


