Return-Path: <stable+bounces-199598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD284CA072E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BA7F3000B5B
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB2836654C;
	Wed,  3 Dec 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJmqTDA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47B3659F8;
	Wed,  3 Dec 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780320; cv=none; b=DkspgfFZerNGcBYL/G9QFUMTO1g+T8q+cV9xFIpfUkFNdFtfBHej0NcdnR3WNUGwh3TLfynpABVK6FVaHS4CtY6XmDzBeAh5mzHb1PttE0ScZBjzfWFWx6dCPOAKvevh4bpRveTLpk8lAEgtJwQbX0PyOAUPbfWPqhS97nQnZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780320; c=relaxed/simple;
	bh=iiUzfJ8b2VTDhJ/ViAHUPbufGFynfX3pzFV55rdpjl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw73Mj7hwrmLXZSuWBxfJ9tIeXOmwx75tyWwo96NrtjjigliwyTTbxgdDlpqvTGt+ww5o3T0ctqiVC8fmSrXbzmYCArYaKzUoP2plQbCLuzaLUv8lqgUX/gtpOQe5VGdhlrHtNiC2cRYBR0FyejJWepc+nWNTbAkmJWv7OSzC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJmqTDA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C0C4CEF5;
	Wed,  3 Dec 2025 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780320;
	bh=iiUzfJ8b2VTDhJ/ViAHUPbufGFynfX3pzFV55rdpjl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJmqTDA0xljM9tkGZOGAQSnHWuB7zV4WhaLocGfEcOgyrau2fnKSl9T2g+QBixwzX
	 a4qj3TS1va2f9966h7p3x9YABFXos2eaSN2DkH9/52WoRHeXfVKuy+RkHYCgZQhiJT
	 0NHf6E16n+zoh69JfRzeNZyMnaHagHnj7k3f41mc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 521/568] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Date: Wed,  3 Dec 2025 16:28:43 +0100
Message-ID: <20251203152459.794011949@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

commit bd886cdcbf9e746f61c74035a3acd42e9108e115 upstream.

Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.

iio_str_to_fixpoint() has a bit of an unintuitive API where the
fract_mult parameter is the multiplier of the first decimal place as if
it was already an integer.  So to get 3 decimal places, fract_mult must
be 100 rather than 1000.

Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI naming")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7280a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -540,7 +540,7 @@ static ssize_t ad7280_store_balance_time
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 



