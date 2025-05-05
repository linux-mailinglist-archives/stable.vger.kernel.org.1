Return-Path: <stable+bounces-139737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E55AA9C63
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C9E1A80BBF
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217626FD86;
	Mon,  5 May 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ZM4MTXdw"
X-Original-To: stable@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4926FD8A
	for <stable@vger.kernel.org>; Mon,  5 May 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472829; cv=none; b=OUZIwV42NZiCilWxpZJ3//yMzUAN+5P00GqVLsd62gCM5dZ0nEwrGddKQ23veBN9V8a6G0hGOhY2E+ZcL9I5x0buBfuI6yiPziAjTXqkYqRy90Ho36OYx2uC8v3utTL4LYKCvJHcNzDHAI32+/MhqToEQa6jjewBIGEbskLwQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472829; c=relaxed/simple;
	bh=P4BKDhR3DdDMdemAbFzh0XhwRO1dWe2CIYGMmPNh9GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFVjVKPK+LeIT/iivxf3ro2SoIFgOIVqdui73AZN/2dK78WXvRv8TotOb6O823vZMRTQP1hcktd3AtNb7ouhwkqZSb6U/2VFmbAs9KK1SeaTDoNLZIIupggAZTXgKFaBXw4DHRdXCiLAPbk7RAKW+RyPQIC7A6+HeSxjcTlQM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ZM4MTXdw; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746472824; x=1746732024;
	bh=FD8Y5WNbDcIAG7xoVC3TJJjkFZkawA3inBTE5n3G/mM=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=ZM4MTXdwD2pqH/UKkjuZOUmvQ1gxEWQM48329ivPvHeCZeqXWnDxc2KOPlugSJ/wi
	 9BekW0j4FB8Mf2gs1n62ccLNcyES1qAtO+ElaaaJQVzNttyAbRufgHqC/7lC4rt5tV
	 RQrBPNCYLZ0doWIZo8XHkyfjv9yZkNzoljS8GQTlOmD5r3J+vw2tVYHDE/gvStZPUP
	 gysPdVU+75OTvPjtOlMuassaQsywON4HC7pxJHwfysSLnT4TBmTIG7vyz7phdgqskm
	 Q8S1OGHyvnLWD+vsALvr8PZZe+EyCYvbjIcU0ENfEigG8aGXxuMru5EbZRwiZJlN9z
	 fYsBsqgmiFGQQ==
X-Pm-Submission-Id: 4Zrrvk4Jdyz44y
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 05 May 2025 21:20:08 +0200
Subject: [PATCH v4 2/2] iio: accel: fxls8962af: Fix temperature scan
 element sign
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-fxls-v4-2-a38652e21738@geanix.com>
References: <20250505-fxls-v4-0-a38652e21738@geanix.com>
In-Reply-To: <20250505-fxls-v4-0-a38652e21738@geanix.com>
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
index 5f5e917f7aa53912448ba078027183c63bc0cd7d..ae965a8f560d3b9872a7197c3b540fe4f7f655df 100644
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


