Return-Path: <stable+bounces-172729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3381B33007
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63894201B9B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085D2594B7;
	Sun, 24 Aug 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8w7qhm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18763CF
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756041298; cv=none; b=kjHW4LY9xBan6KlL9pbNCvrpiWtjhyZA1Rm/auAA60WlaNFBMjfoeXxqV6GRNc9f8rWcTNdiabEkqdn4Eb7DJJHM2e33LQLuFoxkIurnRF91qeYriHKFkwLZZLknNKSe5u1KAlKLvWKnkSILMNlpDjvTlwLdf6CnJyfsvS3eE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756041298; c=relaxed/simple;
	bh=fLFNd1Cae5hVxxwit6hIaEB1wgnN+OKXpXcsve9So1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJvWqO4LBS1M2q8KRIXgw/rhQGvUfRLV7VhouMVKOlXD3Y2t4D/57L6rQKbC6g6utKliOoQRxD957EDK8mJ+An0c+RdwWHFKvCkCqKWvD0j5SHou7YjGlqGYmOFXObyRjI4rKw7D21hr0+8INSG191dqLMrifzhxTEm7A3dLEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8w7qhm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E35C4CEEB;
	Sun, 24 Aug 2025 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756041297;
	bh=fLFNd1Cae5hVxxwit6hIaEB1wgnN+OKXpXcsve9So1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8w7qhm0cHU5d4cYohV4lnRhe7tZpcgOqwt8ol62C8e+bMU8Lb2qSXy8C3cvSjmu/
	 gksGSMC89DO7fQlHwRrixncpw/5l31Fx6BinfhxL0wICZmJAIpFtWHSfNzH1y4+Ldh
	 83MOcgnS08CmpmqImYvU1mgXpjiavCQFfvJsnwpcdTSjRWVtctM48VdD4BlD6VgGxE
	 7ROR1pBDoWKMN12VcZI8heZaBDaYagatTeZnjzk25gVqjeBP9u8TUHRXgsJl0Oy3r/
	 dpQD6JQxFZzW68GpKiY7Gwknu9153xXcfGqc5nv/5eq5Zlheb5WGVouJKC9mTYOSLS
	 8lGn4mLmdQ0nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sun, 24 Aug 2025 09:14:55 -0400
Message-ID: <20250824131455.2815441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082317-tattling-pending-3706@gregkh>
References: <2025082317-tattling-pending-3706@gregkh>
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
index 895b0c9c6d1d..5f943705ce8d 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -573,7 +573,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1


