Return-Path: <stable+bounces-74897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D58973200
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B961C21239
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662A194137;
	Tue, 10 Sep 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJAog+ii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661418C025;
	Tue, 10 Sep 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963153; cv=none; b=W+iFrU6zSYJ+u1WA0UnwoJetevFtFI0J2rNWEauDz6+RhslDg4gctgRGfu8qJWboOLGBSV4csy5/bTcUIqVUG47DQeI3ya5EpUCD6Q2inAGTykkFchsrJ//+nyPLC5i0rkPTMSmaW+CHMIMP/spjt+Ny1r1mFRVxxh61dDjfcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963153; c=relaxed/simple;
	bh=jWm/J9IKNt/ASNnDfDM70qj4bJ1uvuPy2ut+LlVfGrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOI7aGvfSujSq7Dr+Jefovjse3RHJO5np05XExxzpTawjIXHKV+Y/z6KHQfN1B23YIQaZ18zGvO3hthcytU4vreoPOjDpkaO2NxQt1uNvh0Xa6iWExVXkGLVEkG7+2h0+jE4epLJp6AtmttSLr1GM9JbeBLrnWObSq+z7k1JvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJAog+ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D76FC4CECD;
	Tue, 10 Sep 2024 10:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963153;
	bh=jWm/J9IKNt/ASNnDfDM70qj4bJ1uvuPy2ut+LlVfGrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJAog+iiZ8hgVe9ECX5HGnpq6lyfUoRoMJJe7Ct7NHiyR/jipTQZnFkSyhDyeFa+/
	 fWrF9tuphI6js/8gE9X3LGKY027Ydr9IB37eFp7ar6OxUQmmRlhFqWJ0G7+tthSyKa
	 rJyinVF7WPn/bJcZBuhYzBB16V2u83xerVpN01Os=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 136/192] staging: iio: frequency: ad9834: Validate frequency parameter value
Date: Tue, 10 Sep 2024 11:32:40 +0200
Message-ID: <20240910092603.605994354@linuxfoundation.org>
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
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);



