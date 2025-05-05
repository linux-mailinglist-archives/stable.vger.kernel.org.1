Return-Path: <stable+bounces-139590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D28AA8C36
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E0118939AD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2B1C5490;
	Mon,  5 May 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ekB07B4u"
X-Original-To: stable@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E11B3955
	for <stable@vger.kernel.org>; Mon,  5 May 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426036; cv=none; b=eNRpx44epp/ymN/7LqJwuwb8/CWLrHHVQ0wVnjxBLOU80V8qGcO44wRqUTa/7MMNjzqL9mBy/yEitXLhwF8OfotintEXgkfM0PW4RF2wTX+B61uPSOeprMua9I6bJH94K6sOJ7veJG4NhzLMjHKGhcWnw9hSW2AzIoYb3g/nt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426036; c=relaxed/simple;
	bh=L8JRM8fgT0pnaZxPiz2MjGtKudbMN+kOblVkTPanaQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLI9EAgIhlCf9LOiQnvEj+tPH/tQh2R30+v3ba0TXlJjTgEZsz92FRldVL4rDrg2lxoGYHi4caqEXkzHax5nFjhAOwbKIxgbO47tAddTdTX187wKUoGCOl5njcGERQBPTOHFlNl/dDCNFOcqgwLGL4cos6joyVTHESJq1v/4Go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ekB07B4u; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746426026; x=1746685226;
	bh=58dvsD4z/gzLr45OPknIfhl+rpdDoktiL6xkabr5Tt8=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ekB07B4u7Nd+0EtRE6m5hfbHzKNohVHmU8t04ByxP7h24x/hM7XzjM5aWcLAAROUa
	 snTSmLYlMUNFP/iHsLOK97+46tNVAZDW0eGqCPWO4ktsNMUjAO5v6psZklOHb46dMQ
	 7bAfInzBm0KP1pK9AfCImGkKw75OJhxIlcN8oa4m9CHRYD2KA866Im+vrOSgz/fAI1
	 GLL0SdslpKdC1Tl/UsE1yELAdByBS9wW0NNgBNu8fkLRAixrwdFoyW0zp4wWWvXcoL
	 soVjh5sn0LnZTKhdEw9HqiDVEzNbBH5KcPiq0OFuKhUc21r9ZHwjq4Rsp9J85UomTt
	 eNqbKyHWEdcwQ==
X-Pm-Submission-Id: 4ZrWbr3S3czLT
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 05 May 2025 08:20:20 +0200
Subject: [PATCH v3 2/2] iio: accel: fxls8962af: Fix temperature scan
 element sign
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fxls-v3-2-8c541bf0205c@geanix.com>
References: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
In-Reply-To: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Mark the temperature element signed, data read from the TEMP_OUT register
is in two's complement format.
This will avoid the temperature being mishandled and miss displayed.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 27165a14a4802bdecd9a89c38c6cda294088c5c8..00dfe962f4913f876fc461f3fa03dfce4e443218 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -749,6 +749,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \
+		.sign = 's', \
 		.realbits = 8, \
 		.storagebits = 8, \
 	}, \

-- 
2.47.1


