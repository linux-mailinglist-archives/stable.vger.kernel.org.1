Return-Path: <stable+bounces-194746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22045C5A567
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDDD04EF76C
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FC2E0926;
	Thu, 13 Nov 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c36WI+8S"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DC2E427C
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073296; cv=none; b=X4NzzSnhiNGGVJPeUpX3R02PfPTuT2evFje3+sjSMh4CGm42x2XkURu7/HHEWFpTpXABcSNOHCWBn7rr7En/RLHirQCzZHKZxwSrGFskVBZ9QIYE3Bx0q3pralFdqBbFhH7AsM+rGo2sXuIU9oppBmoV7XeLPxzeYMb4OWBmYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073296; c=relaxed/simple;
	bh=2F3kWPaeVKjvs0xpjenmmLhijBgQcvK+sStMGxua8lQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=oTZl1Cmgqu4pQa2qz39ILZyQAUKq/6LJjcwJTK3nQupcl4bD/wmJrqNopMxvcP/TLkeGU8jgeAXGpUpzDx8/X29e3EexZVZi6uxAR7R0bqivzDjkSdSxtC+AV/ORguxQ/iiJM0Ds5CIusBGRi+SnRKNVKczg1riCOSsx5H29dFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c36WI+8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A167C4CEFB;
	Thu, 13 Nov 2025 22:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073295;
	bh=2F3kWPaeVKjvs0xpjenmmLhijBgQcvK+sStMGxua8lQ=;
	h=Subject:To:From:Date:From;
	b=c36WI+8SSm8JpxCxOdbGFEzrzdXjamEOG7fZMmW20RF6mZEd4FXcEqm4EPNq9Uidw
	 pLjSZQgKNSe7QYrsl34JX4jAiJcIru32sRKEdXHoVPN/1OJmps2c/JO4gF/kWVNTRh
	 J7mwR3VbGlaWCY1SPTitJERFs7vPlY0ZJXOHuN3w=
Subject: patch "iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling" added to char-misc-linus
To: olivier.moysan@foss.st.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:50 -0500
Message-ID: <2025111350-dial-quarry-31ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8a6b7989ff0cd0a95c93be1927f2af7ad10f28de Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 2 Oct 2025 13:22:49 +0200
Subject: iio: adc: stm32-dfsdm: fix st,adc-alt-channel property handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Initially st,adc-alt-channel property was defined as an enum in the DFSDM
binding. The DFSDM binding has been changed to use the new IIO backend
framework, along with the adoption of IIO generic channels.
In this new binding st,adc-alt-channel is defined as a boolean property,
but it is still handled has an enum in DFSDM driver.
Fix st,adc-alt-channel property handling in DFSDM driver.

Fixes: 3208fa0cd919 ("iio: adc: stm32-dfsdm: adopt generic channels bindings")
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 74b1b4dc6e81..9664b9bd75d4 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -725,9 +725,8 @@ static int stm32_dfsdm_generic_channel_parse_of(struct stm32_dfsdm *dfsdm,
 	}
 	df_ch->src = val;
 
-	ret = fwnode_property_read_u32(node, "st,adc-alt-channel", &df_ch->alt_si);
-	if (ret != -EINVAL)
-		df_ch->alt_si = 0;
+	if (fwnode_property_present(node, "st,adc-alt-channel"))
+		df_ch->alt_si = 1;
 
 	if (adc->dev_data->type == DFSDM_IIO) {
 		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
-- 
2.51.2



