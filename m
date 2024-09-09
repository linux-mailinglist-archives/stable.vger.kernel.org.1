Return-Path: <stable+bounces-73956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CF970EA1
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2258A1F22976
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D47D177999;
	Mon,  9 Sep 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZY7LLEP+"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F711F95E
	for <Stable@vger.kernel.org>; Mon,  9 Sep 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864824; cv=none; b=b2/eaatDGqNP/SwLwkvjWBxyU1WgvDBkXqhl/GdXxyaXVXZ6OS1zrL9l/TRIatCyyo+tjNZa62jl0BV87fR/5DztskqgB7LlvRANuX66uFHhvX6dLElPRCwyUMjTBuGgLdTxndLPhSMhIGxuccm0qG/QH39YVaf2OOu3FR4bkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864824; c=relaxed/simple;
	bh=ETaEuqtK5QQQo9yCDOY0JQv795K0z+mXPm+cp3IiOcI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JvMbPG1GZfmRNnHx1/0a8l8EOqlWrhuyyKkCJtGgbTTx1IVg3QFXOtGN4rgCVsegoxBU+9mG+jplpQa5NtxayCAb57EW3859xnBb76ABY7/WwAECM6iMJzucaOt5NIKlfzfTrX7WlL7J9f1Z4rMfhA5YjGerYWQuS7FeQUHBXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZY7LLEP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE50FC4CEC5;
	Mon,  9 Sep 2024 06:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725864824;
	bh=ETaEuqtK5QQQo9yCDOY0JQv795K0z+mXPm+cp3IiOcI=;
	h=Subject:To:Cc:From:Date:From;
	b=ZY7LLEP+Q2/vCyCF48G92wn9XuWPNZVw6TJqO0G61Vce4ceTsaa4MFNXSnEfCatkK
	 6Re6miO+G9Wdf5CFcc+QCZVEYwTb7nuw1aza7GZ4BZqPYjwAdDZzB1kZnfp8ajaO9n
	 VQa74UPluBs+DEYsJut9LCwqc8vcw1qgHq9+9hC0=
Subject: FAILED: patch "[PATCH] staging: iio: frequency: ad9834: Validate frequency parameter" failed to apply to 4.19-stable tree
To: amishin@t-argos.ru,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dan.carpenter@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:53:40 +0200
Message-ID: <2024090940-shale-handcart-eb5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b48aa991758999d4e8f9296c5bbe388f293ef465
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090940-shale-handcart-eb5d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b48aa9917589 ("staging: iio: frequency: ad9834: Validate frequency parameter value")
8e8040c52e63 ("staging: iio: frequency: ad9833: Load clock using clock framework")
80109c32348d ("staging: iio: frequency: ad9833: Get frequency value statically")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b48aa991758999d4e8f9296c5bbe388f293ef465 Mon Sep 17 00:00:00 2001
From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Wed, 3 Jul 2024 18:45:06 +0300
Subject: [PATCH] staging: iio: frequency: ad9834: Validate frequency parameter
 value

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

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index a7a5cdcc6590..47e7d7e6d920 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);


