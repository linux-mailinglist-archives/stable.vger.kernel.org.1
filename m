Return-Path: <stable+bounces-89859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DD9BD215
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD39287AA5
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FB3BBC5;
	Tue,  5 Nov 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D5VkxxLe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255414A4DC
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823374; cv=none; b=XgV8H2wxz5AHnfMA2TIERqKZB87DAHusdLjWCD5ghKUV8w1GpFfWbN4GNuBjWzO8YtSZCsZWcCygOXMXEou3NkL6KtVSbZezd1LEQgP4gR93pF+iW3CWVj48Rv86qzjyPe/bapkoYuRJYFCpjjtgAz8hKAo8CZjC2gMN56FaLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823374; c=relaxed/simple;
	bh=tFGMUGgRvGxVWo5Vw7wARgiN1Vz/WhBlJSBte7nyLBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UkuQiyLh92RYEOQx7K+6jwfZqxvDamX7158ZIJF5Cj+GdaK95xA+3rZRXQI+gAQGCfKr46pvx8Cn35HKj3Cgx/Ftnx7KzaLvK5qxHxbxMJxGmMm2g+Y4ya/MS7vCw4XtxOyuXf+p+9LJiT2znIYvy9kIV/CeaE2+Fli2mrwPsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D5VkxxLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E236C4CED3;
	Tue,  5 Nov 2024 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823374;
	bh=tFGMUGgRvGxVWo5Vw7wARgiN1Vz/WhBlJSBte7nyLBY=;
	h=Subject:To:Cc:From:Date:From;
	b=D5VkxxLeAVM3j9rQYpGTiaUY0rU9ICntbZutUK9Jk7cSow5xnvYOm4aVNsYykhJ8N
	 txIPNJxE0ORD+BWds5n1wq83u+bqF7uJPxBM7K56TrbyYPmOQFGX8eDWuIL9D5uzV4
	 LM0LTMjuDqRN5T7HBEuDTzA+ndXxRTQ3ysNq7XI0=
Subject: FAILED: patch "[PATCH] staging: iio: frequency: ad9832: fix division by zero in" failed to apply to 4.19-stable tree
To: quzicheng@huawei.com,Jonathan.Cameron@huawei.com,dan.carpenter@linaro.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:15:56 +0100
Message-ID: <2024110556-record-unscrew-f7e1@gregkh>
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
git cherry-pick -x 6bd301819f8f69331a55ae2336c8b111fc933f3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110556-record-unscrew-f7e1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bd301819f8f69331a55ae2336c8b111fc933f3d Mon Sep 17 00:00:00 2001
From: Zicheng Qu <quzicheng@huawei.com>
Date: Tue, 22 Oct 2024 13:43:54 +0000
Subject: [PATCH] staging: iio: frequency: ad9832: fix division by zero in
 ad9832_calc_freqreg()

In the ad9832_write_frequency() function, clk_get_rate() might return 0.
This can lead to a division by zero when calling ad9832_calc_freqreg().
The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
against the case when fout is 0. The ad9832_write_frequency() function
is called from ad9832_write(), and fout is derived from a text buffer,
which can contain any value.

Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20241022134354.574614-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6c390c4eb26d..492612e8f8ba 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |


