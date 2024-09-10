Return-Path: <stable+bounces-75613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFFA97359B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BE1B294EC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58018C021;
	Tue, 10 Sep 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBrMADbb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904F144D1A;
	Tue, 10 Sep 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965243; cv=none; b=jCMAoHBEEDNxU6ELhhfEwnCJiEFne4C6IKeSfH9nMa0Vh6fCFDQjSQtRtjViWX8b2Dw2waHCVPUJSktw9tOsgTXxCaQcS1mJOVa2ySAIsnj9Nt4nDRGldx/Ojr0OgTTOgIjs9aLVFPOLvT8dPpIPuFY9HdZ5QlekzSN8IG8BlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965243; c=relaxed/simple;
	bh=ADhbZ4h+/M9l1dUqsv1dwqapIdl5eUKV46vdEfAtUF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLEcWllj8dx+ix0dqt1kQwRrKm7ueH3fh9cSMX13nA/EPmkUkz17d8spUpo+RnKfwCVK8GdJhuc1YqgZgfKPxwBq9yi9ZRgItApoGtfu3Gtv3Fm5un/bneDVfCqB7BmSRy/mk+gJKQftnKqeRsD5X9oVxhxEiEY/Jz6fEU/ZA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBrMADbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7FC4CEC3;
	Tue, 10 Sep 2024 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965243;
	bh=ADhbZ4h+/M9l1dUqsv1dwqapIdl5eUKV46vdEfAtUF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBrMADbbqyx1cr53JZPpCvRdNsbo5Uu2Qq7bX80vTUhSHzpciUT1qzSTc0hcYw4y+
	 yri6gIajHBJam+cX6VD0suRMcuSvJ/V4xQZsjKyZ4TQjOjsbGBRSnDOtXGeIK9znPJ
	 8f74FHKdNWhtCxp/EBB3vbEXreLozvnxvnZfIaL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 158/186] staging: iio: frequency: ad9834: Validate frequency parameter value
Date: Tue, 10 Sep 2024 11:34:13 +0200
Message-ID: <20240910092601.121457375@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandr Mishin <amishin@t-argos.ru>

commit b48aa991758999d4e8f9296c5bbe388f293ef465 upstream.

In ad9834_write_frequency() clk_get_rate() can return 0. In such case
ad9834_calc_freqreg() call will lead to division by zero. Checking
'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
ad9834_write_frequency() is called from ad9834_write(), where fout is
taken from text buffer, which can contain any value.

Modify parameters checking.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20240703154506.25584-1-amishin@t-argos.ru
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/frequency/ad9834.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -115,7 +115,7 @@ static int ad9834_write_frequency(struct
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);



