Return-Path: <stable+bounces-90587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A179BE915
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D318B23B7A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25311DED4F;
	Wed,  6 Nov 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y69QIXO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8871DE3B8;
	Wed,  6 Nov 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896215; cv=none; b=rttRVawT5HzxgtUDr7pklg4McMUWMUwjn+EadSVYnYdo5t+lZNVfywdFRfRK/9c9+pYEQC0kHy1dYFXuVV5TLxAh08OCu2C2rzwKMXv/CriHQOooAUqeXlnDvEzMGDuqUgKXtUCFJ/ROM5VCFW3O0CqKhlYSHrLNGz9d5aCfXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896215; c=relaxed/simple;
	bh=PgIM+PbyQ0AFoUCgStVIhD7HCqVcwwYuqswLEacmbw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukQS5Sg5L9VdTMz2oIXAC/gHaf9ncMdOvdTiHgHj/maFr+3KrcPq/JRyBoyXoFabq4ZZnJCeMrH3f8jhnmbJKJjQXimgBYsCTOHo/Z8f/HjYFXYt7QtOgdoTm69TFTWR1qX2fQIdTZyKDc7gMUemSmRAsIx2zMInFAkxavrWDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y69QIXO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919A1C4CED4;
	Wed,  6 Nov 2024 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896215;
	bh=PgIM+PbyQ0AFoUCgStVIhD7HCqVcwwYuqswLEacmbw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y69QIXO46cXftNtCDPlgpKW7xbiqgtKGUKxdCumrt5asWgKrO94NNftU5eNfUw0ZR
	 8lWyayN9EnXN9Q9O1/HO5PsjeLUUPN/0C65XhG6Go8ElfTyjQGd6UY4VR9GIAORwwC
	 u4cBrM1wncoeFiL0Fv9Xjr66nsJbVEgb1QfSOrbg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.11 129/245] iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()
Date: Wed,  6 Nov 2024 13:03:02 +0100
Message-ID: <20241106120322.399328792@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zicheng Qu <quzicheng@huawei.com>

commit efa353ae1b0541981bc96dbf2e586387d0392baa upstream.

In the ad7124_write_raw() function, parameter val can potentially
be zero. This may lead to a division by zero when DIV_ROUND_CLOSEST()
is called within ad7124_set_channel_odr(). The ad7124_write_raw()
function is invoked through the sequence: iio_write_channel_raw() ->
iio_write_channel_attribute() -> iio_channel_write(), with no checks
in place to ensure val is non-zero.

Cc: stable@vger.kernel.org
Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20241022134330.574601-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7124.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -645,7 +645,7 @@ static int ad7124_write_raw(struct iio_d
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}



