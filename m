Return-Path: <stable+bounces-73959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B79970EA6
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82071C21EB0
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7051AC45F;
	Mon,  9 Sep 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwSl4iXT"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747421F95E
	for <Stable@vger.kernel.org>; Mon,  9 Sep 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864918; cv=none; b=KdKW9sGEY41dtbEGWDq5aUtgQbKL4vQg4PVX6TE/G9bki2qREkZeU5WYPo36t/nWqgb3RSLcMLqSDzzK0TnBkFnw4/zSr91fu1ESZOOjQtzNeVYDCBzsfKKmasTQC3upIaj+945keVhw8uH+Y4scb1k44aTiT2Bvy+EVvPbdRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864918; c=relaxed/simple;
	bh=2GXgKK6eLGD7QhiE9xgr5a5jbZSjqnwScwHE5uleOj8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PKPXcmF+iOErsrePTYzXUo83qctooWciOYxCslcT7e+HXe2otTE8FTe72nuyaZurR93zXCLfDMLH8yAj1BwYqLLTggGS9Jxjki08jGb30ToDmPgI0r0uup5W9i6nfLNa6RoEbtspiGGrIV6x40yC4M9fVdxJFvdF2noXm5Ds5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwSl4iXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A84C4CEC5;
	Mon,  9 Sep 2024 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725864918;
	bh=2GXgKK6eLGD7QhiE9xgr5a5jbZSjqnwScwHE5uleOj8=;
	h=Subject:To:Cc:From:Date:From;
	b=fwSl4iXTmrJvpMzPB3z1p0r7OQjDfSe7jT1Q2v8HVGpWVtclxIq5I5xw5tk0msqur
	 IXBnx5SUhwVC34EQQInOgu3BFpJNVFFttoLw2mXurooyrMgjUGNsAcmXY4Lvwi1og2
	 viWshuxwhVJVDSRYkUmf9povq2ivzJKtldpi+B2w=
Subject: FAILED: patch "[PATCH] iio: adc: ad7124: fix DT configuration parsing" failed to apply to 6.6-stable tree
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:55:14 +0200
Message-ID: <2024090914-province-underdone-1eea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 61cbfb5368dd50ed0d65ce21d305aa923581db2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090914-province-underdone-1eea@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

61cbfb5368dd ("iio: adc: ad7124: fix DT configuration parsing")
a6eaf02b8274 ("iio: adc: ad7124: Switch from of specific to fwnode based property handling")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61cbfb5368dd50ed0d65ce21d305aa923581db2b Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Tue, 6 Aug 2024 11:51:33 +0300
Subject: [PATCH] iio: adc: ad7124: fix DT configuration parsing

The cfg pointer is set before reading the channel number that the
configuration should point to. This causes configurations to be shifted
by one channel.
For example setting bipolar to the first channel defined in the DT will
cause bipolar mode to be active on the second defined channel.

Fix by moving the cfg pointer setting after reading the channel number.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240806085133.114547-1-dumitru.ceclan@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index afb5f4d741e6..108e9ccab1ef 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -844,8 +844,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	device_for_each_child_node_scoped(dev, child) {
-		cfg = &st->channels[channel].cfg;
-
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			return ret;
@@ -863,6 +861,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
+		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
 		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);


