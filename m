Return-Path: <stable+bounces-74557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87F972FEB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8601C249D5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4E18B487;
	Tue, 10 Sep 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cV73rnQY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D034171671;
	Tue, 10 Sep 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962154; cv=none; b=pWa2KV+SxzJsRzyvFO0w87DPKJ/Ah9SuYi/3zsu1rgUQzvKgCKZVpUECJBocrhLWUWFHRgUqEccXg5dlHvMxmvmDbecgrcWDFtjc/Wc9FMVo2vqe+5DkXaHh0qUWzZy9477Ez/hh8vh5Au1g6hENYWZzZVRH7MH++tMRSLGqIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962154; c=relaxed/simple;
	bh=t+Mhe9RMw6QCVLyRtue7iKNcsUUlhsZMX3ogTzQY6Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it2oKXTWCPO5aQM8bVLBX00kD9JHQpE+k3tEG6aqfqBPK1sKPQo0WATe0YVIPfzDrjSYUbVxOCBZNf6VFgBByus1ji9iqOeXogErspJR4e0PGLjtSpLhlI6i0SG8rg2L1A8XFqzU04aOCB4BnTpTVZ5QUpFQeDxZWswxhpp2+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cV73rnQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223BBC4CEC3;
	Tue, 10 Sep 2024 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962154;
	bh=t+Mhe9RMw6QCVLyRtue7iKNcsUUlhsZMX3ogTzQY6Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cV73rnQYvY91HFF+BSGh10n7xsBffTrjieA8szxgpK9aF8qnvpQzPP8IC+7Zx4iom
	 C7871su4hY+kXywfTw3uJ6yzqHaXFJ1nB1WqcHHxwI5TUyftF+Xjg8Fd5365JLhZeJ
	 b3bW4b3nOd01iqxqEN5hpq341CDlzFLWchJ7OajQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.10 286/375] iio: fix scale application in iio_convert_raw_to_processed_unlocked
Date: Tue, 10 Sep 2024 11:31:23 +0200
Message-ID: <20240910092632.173916971@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -647,17 +647,17 @@ static int iio_convert_raw_to_processed_
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



