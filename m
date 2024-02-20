Return-Path: <stable+bounces-21004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336A85C6BC
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B74F282193
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454CA151CFC;
	Tue, 20 Feb 2024 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIMyRTZb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC7151CEF;
	Tue, 20 Feb 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463051; cv=none; b=kab9UVNqwT95VuBnr3L7OOrIdk8IPVxDj39qZnc2LeO8lu2lX7dN4ZOrTz8eP/P3d+fHrB11j2FuYUomaX6j3c0jWsMam1q/JYkTIdBINdDec5b/0SdmSX/lTpvvWILm4F+i1fBNFvpj2XgPytCLHh5eAfUFdgStOiZG1R/RCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463051; c=relaxed/simple;
	bh=DXmbxhXqlxitjQTEyHrLl6DqKofKCQLw2T4BCsansic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Plu+3+INpz9LDZUtdGJd9/7usSLZpBSv5o3VSNDhp+U//cg+Qd+AeDgbpu4IWWH8kLpuQrVpIJb29FIq0DpEOqtUq+Igz6FhqZbO/1gQAw4NLvMHdveyioV1bKfNT7gEn+iCSor0PHTsIBpkvEkHaw9ladylcvjDXuxcwdRlJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIMyRTZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E6AC433F1;
	Tue, 20 Feb 2024 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708463050;
	bh=DXmbxhXqlxitjQTEyHrLl6DqKofKCQLw2T4BCsansic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIMyRTZb206WGZjtduvs89pEmz+9910qDbiZjoIQY2XFZN4K3hc3Ox32U+ppaij7M
	 2mB24DSq+xPWHp5COkAu814Cun7ckRqlFRgjVVDgt+pbYEj+EMM21bX1kEYx35WAlD
	 Z3ZEIqOnjsKSw2owgMn+tSGg2njj7QikeQqQeI+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	"zhili.liu" <zhili.liu@ucas.com.cn>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 102/197] iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC
Date: Tue, 20 Feb 2024 21:51:01 +0100
Message-ID: <20240220204844.136307756@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

From: zhili.liu <zhili.liu@ucas.com.cn>

commit 792595bab4925aa06532a14dd256db523eb4fa5e upstream.

Recently, we encounter kernel crash in function rm3100_common_probe
caused by out of bound access of array rm3100_samp_rates (because of
underlying hardware failures). Add boundary check to prevent out of
bound access.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
Link: https://lore.kernel.org/r/1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/magnetometer/rm3100-core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -530,6 +530,7 @@ int rm3100_common_probe(struct device *d
 	struct rm3100_data *data;
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -586,9 +587,14 @@ int rm3100_common_probe(struct device *d
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
 	/* Initializing max wait time, which is double conversion time. */
-	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
-				* 2;
+	data->conversion_time = rm3100_samp_rates[samp_rate_index][2] * 2;
 
 	/* Cycle count values may not be what we want. */
 	if ((tmp - RM3100_TMRC_OFFSET) == 0)



