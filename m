Return-Path: <stable+bounces-6419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657280E681
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB111C2139B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E636AF5;
	Tue, 12 Dec 2023 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G7TE4t9s"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4066199D1
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EDDC433C8;
	Tue, 12 Dec 2023 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370652;
	bh=vJ+je4buzgS9RaTcgnqJXr2ygzWhbB6STpfLVUL3dbg=;
	h=Subject:To:From:Date:From;
	b=G7TE4t9stIJSKUliSU94Dj8/QfgkcEcPv0WqOUKNtASR1W1IiBJ8o5GjHGe0yoEiy
	 qP/yU2yP7c0Pf8Nhrz7GUj6z68hrNNwupc43qk5aLlmLlothxOuj7pWcYbjO0D3CEO
	 vq0JA5+AE3BXYoPubcaEUaq0CfP8wtFlnV31QlGA=
Subject: patch "iio: adc: imx93: add four channels for imx93 adc" added to char-misc-linus
To: haibo.chen@nxp.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:47 +0100
Message-ID: <2023121247-provider-uncured-fcd2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: imx93: add four channels for imx93 adc

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 2475ecdb9b6e177b133cf26e64e8d441d37bebde Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 16 Nov 2023 15:10:26 +0800
Subject: iio: adc: imx93: add four channels for imx93 adc

According to the spec, this ADC totally support 8 channels.
i.MX93 contain this ADC with 4 channels connected to pins in
the package. i.MX95 contain this ADC with 8 channels connected
to pins in the package.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Fixes: 7d02296ac8b8 ("iio: adc: add imx93 adc support")
Link: https://lore.kernel.org/r/20231116071026.611269-1-haibo.chen@nxp.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/imx93_adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 9bb1e4ba1aee..4ccf4819f1f1 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -93,6 +93,10 @@ static const struct iio_chan_spec imx93_adc_iio_channels[] = {
 	IMX93_ADC_CHAN(1),
 	IMX93_ADC_CHAN(2),
 	IMX93_ADC_CHAN(3),
+	IMX93_ADC_CHAN(4),
+	IMX93_ADC_CHAN(5),
+	IMX93_ADC_CHAN(6),
+	IMX93_ADC_CHAN(7),
 };
 
 static void imx93_adc_power_down(struct imx93_adc *adc)
-- 
2.43.0



