Return-Path: <stable+bounces-91042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3B9BEC2C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2252855FB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE21FB3D2;
	Wed,  6 Nov 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fkeRkZR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE871FB3D0;
	Wed,  6 Nov 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897568; cv=none; b=O7U7Udi8fB6NsCQmc1XwtkxnicNu/T1EMkQuzv7FHwHcTig1OrgbHSB8Wu1spBqPqp82nOFReM0rV8Ly/d/c8Q5cIxxxJqcLWI1Px9VANIHqmeAVpUSdvPm92zJZk4AwgwL+lfgyWqIddVhapP4S35gRnHMJLZGnt89cpny8Xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897568; c=relaxed/simple;
	bh=rTnGRDLtCOlmF4T5KqOQTASWchZVX/3umQVBruEhec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLQJyi/oerxRZgrXBQiR21VUognrkDU8ri6sCfyjGhE1l1V6sXn3Elj+cJemxH08AGJGJ1qg5HgyZAtQXT/5YMaaV2LXxfaR1aZNA0X/sLp6615F/qBKdIrQxzGzoFEY+8LPhkbMT0FnX6rr3lVhdV+6e2Eob7ep6I4gukQ+dFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fkeRkZR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7EDC4CECD;
	Wed,  6 Nov 2024 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897568;
	bh=rTnGRDLtCOlmF4T5KqOQTASWchZVX/3umQVBruEhec4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkeRkZR2VjgGJE/r6MqWP0tYNLx9JoyWYgGZPfgBYEFi6PML65ON3gR5jUDpIyxIs
	 I13SdwZVHBWexhV4OYu6x5L6Qz1OyevAtjWucurK9va6LPevJiugQnIETmyX3cI7l5
	 B/gQK+BsBBT7OL/3GpR4QxMJvG1+6KzZ7s2Fjw4Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 097/151] iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()
Date: Wed,  6 Nov 2024 13:04:45 +0100
Message-ID: <20241106120311.541961478@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -643,7 +643,7 @@ static int ad7124_write_raw(struct iio_d
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}



