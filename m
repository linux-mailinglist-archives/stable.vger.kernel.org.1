Return-Path: <stable+bounces-153860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6CADD6FF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2101D4A0468
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAAF2F2C63;
	Tue, 17 Jun 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KRpQ2fQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7122DFF28;
	Tue, 17 Jun 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177331; cv=none; b=rsdWbSk3dd3xSX5p3NqC02+n0Da1Q7uccoU0p9CTFQILxKckYvMaUPzzmGghX1G6/Vc64F0bvkJ9s8akrBsAC6JTHxBImiXV1VfGu5JICnptr1pKWlV0kDEFqMMgx92yRS2nkX7UrQ0WcF0ou9Y2Ji1uk4p3zKDu6L1aeUQzcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177331; c=relaxed/simple;
	bh=pc9YKe1Qe8BpFG53vEkhthLBrfasdOvscAAH+FCO2zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luNFbYhb3MQ4xGB92vSZorT41cPzqFYHWiOh9rMQKslMg1VmifJk/KONyfIwFbMPQEUoZ9zmT2k5MW9C4R7YXCx9QudcqJNoVDzUMV8WHlhBdDBodDHeXLy9sEoPzaeVgk//VG3eDIkcg4m5W+wkYFwf6om3FBJzx4Mx+1ezco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KRpQ2fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B5BC4CEE3;
	Tue, 17 Jun 2025 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177331;
	bh=pc9YKe1Qe8BpFG53vEkhthLBrfasdOvscAAH+FCO2zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1KRpQ2fQPK8fSGrJakzSiMBZYmHUZXYSCJ9kmchO7BZgPTGjIkGBNN42wxToLkYjm
	 1rrNRVrKe4o7iUqCZI+rJQWgidb8S/g6MqFqtEsYrWem18H10qeJA+DNmMpiIb3nqF
	 gBJyRLKSt7qYUVZhFEbfxKqsST4YQbcI3pePeCoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 328/512] iio: adc: ad7124: Fix 3dB filter frequency reading
Date: Tue, 17 Jun 2025 17:24:54 +0200
Message-ID: <20250617152432.892025096@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 8712e4986e7ce42a14c762c4c350f290989986a5 ]

The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
and for sinc3 the factor is 0.272 according to the data sheets for
ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).

Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Link: https://patch.msgid.link/20250317115247.3735016-6-u.kleine-koenig@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7124.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 30a7392c4f8b9..9c9e0c950b427 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -300,9 +300,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 
 	switch (st->channels[channel].cfg.filter_type) {
 	case AD7124_SINC3_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
 	case AD7124_SINC4_FILTER:
-		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
+		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	default:
 		return -EINVAL;
 	}
-- 
2.39.5




