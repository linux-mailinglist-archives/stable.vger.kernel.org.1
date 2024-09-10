Return-Path: <stable+bounces-74909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE4B97322D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1A4B28CB5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A843194A42;
	Tue, 10 Sep 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0yhLkIzP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C41183CB0;
	Tue, 10 Sep 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963189; cv=none; b=A+aBwsQot8LRQjrzxPzU/YnxHGhRGeVtVunSMw/FhEYDsTZKJ4t+wrq5WijVcsxh56NXibmMxXZB3aOsOHxz/tkOoNWJArMGs49P6xS+7eaxyRSRsWPBu+saNiR61yp1A4NPUaKmPUK1NQ8bi5tx5BLf0cVTksRWrI4pz/Os37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963189; c=relaxed/simple;
	bh=pAZeCe6H0Qe43B63wH4zzOaMOzmHYPliw8jSGjRXFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlJuecjz1C0aUqyBIIdFWdtJQP2VlTcNF4GkfuldEw5ornOod6feIe/L1fr3mTRn4P8DMcYp1eQ7/YSm6FrXkrb/I7kBQA04lPo6wjSsl4CQ8wFmjJn5zR2v0Us3ndeE/cLZIoaT6QJ6Tn0xM/2jxo/2qS52smYgCEqovYDNMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0yhLkIzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E81C4CEC3;
	Tue, 10 Sep 2024 10:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963189;
	bh=pAZeCe6H0Qe43B63wH4zzOaMOzmHYPliw8jSGjRXFL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0yhLkIzPkbsiWxfBwBODBgiUrit75GF6FtLkRJ0mDZmLnMAcNMtFkurFBz3mQ21uV
	 xd2DTj+ZkaHc0u8+JW+tG4rkJzXoCGAVUkJ/AaEarPgLjb15aD+e+ua3NYYjoYfuGS
	 b8dJJRUeKx3b7GOH+lR7GvM1lBojJhQnqueLE4uo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 138/192] iio: fix scale application in iio_convert_raw_to_processed_unlocked
Date: Tue, 10 Sep 2024 11:32:42 +0200
Message-ID: <20240910092603.671402016@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matteo Martelli <matteomartelli3@gmail.com>

commit 8a3dcc970dc57b358c8db2702447bf0af4e0d83a upstream.

When the scale_type is IIO_VAL_INT_PLUS_MICRO or IIO_VAL_INT_PLUS_NANO
the scale passed as argument is only applied to the fractional part of
the value. Fix it by also multiplying the integer part by the scale
provided.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Link: https://patch.msgid.link/20240730-iio-fix-scale-v1-1-6246638c8daa@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/inkern.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -679,17 +679,17 @@ static int iio_convert_raw_to_processed_
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;



