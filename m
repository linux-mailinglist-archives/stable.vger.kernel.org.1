Return-Path: <stable+bounces-160205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF0AF9587
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CEC3A17AD
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF71A4F3C;
	Fri,  4 Jul 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MFE7PFuP"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480919F115
	for <Stable@vger.kernel.org>; Fri,  4 Jul 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639481; cv=none; b=Zl1Fv067biPT53QX2bcNeuQGjVSu6Xz0gSRwT7az2MZAJtQ4jyR5WATTiWC45vRkgr/FkGWqqZ7Lnwo5vo3aU3zdFJPxVMAglm9mvdnU6kGzi9g3bcWjl9cz1hNr/yMhi8MTAEuPTOCZnUYGa7X8b/W/3OJMgD2Fg/t3nnOQdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639481; c=relaxed/simple;
	bh=qdaqtqURyHNMppB9SWLM0VOmut5udll4t58+pZiOHeE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AJAo9iVv8LS8r9A5K0NNa7w0JO/DaImqY/Rripn+R7mZRDcAIHLKIjHBahjltSIrOK7gs7gAIM2B0ddgYhG+88e7HMduyiud4qvqqWUXQkoe5MyueX6pt/sMiy0mz3ZUuLeZfq7emtyBOhEUFJnOHiMasZWU3HL/XLQg/PCTklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFE7PFuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01CAC4CEE3;
	Fri,  4 Jul 2025 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639480;
	bh=qdaqtqURyHNMppB9SWLM0VOmut5udll4t58+pZiOHeE=;
	h=Subject:To:From:Date:From;
	b=MFE7PFuPsN2apKnkn/is639WF7FRGIMH0l7w+0b5MEKLmUOGBHkBA6BvLtFCXvC1E
	 ZsWTtnDJV+/4n5Z7tYTRBOOZLAtalkGtLRaj1EpZOzazHQqQ0ByWIfwjYv70sLmUkP
	 0KKbrnV9Md4BovZETp7LQMVVV40y5EW9g9pO6JfM=
Subject: patch "iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps" added to char-misc-linus
To: wens@csie.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Jul 2025 16:30:50 +0200
Message-ID: <2025070450-canopy-monorail-6d26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3281ddcea6429f7bc1fdb39d407752dd1371aba9 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 7 Jun 2025 21:56:27 +0800
Subject: iio: adc: axp20x_adc: Add missing sentinel to AXP717 ADC channel maps

The AXP717 ADC channel maps is missing a sentinel entry at the end. This
causes a KASAN warning.

Add the missing sentinel entry.

Fixes: 5ba0cb92584b ("iio: adc: axp20x_adc: add support for AXP717 ADC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Link: https://patch.msgid.link/20250607135627.2086850-1-wens@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/axp20x_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 71584ffd3632..1b49325ec1ce 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -187,6 +187,7 @@ static struct iio_map axp717_maps[] = {
 		.consumer_channel = "batt_chrg_i",
 		.adc_channel_label = "batt_chrg_i",
 	},
+	{ }
 };
 
 /*
-- 
2.50.0



