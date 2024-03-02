Return-Path: <stable+bounces-25781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD4986F1FD
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258A81F21C1F
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1693FBA6;
	Sat,  2 Mar 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ed6CzlBh"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD83FB96
	for <Stable@vger.kernel.org>; Sat,  2 Mar 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406302; cv=none; b=tXMPmrBisYDgdCEQJ7GNhhJbeF/CKzTYbGAhhHcpuHYJ8RiYDkcHZtAn9unVQjgsoYiBWBEN/6y12LUk2vRXUTIDeha9XYdA2w94lgnqHGgx6MIaKebk0cHBSZtynrFaGjhBAWM5cp6T0RBzCrl2yKwdCBE80zYfXt2EMma1rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406302; c=relaxed/simple;
	bh=3JHsx8FW3HOuP/diEh96oe8D8KOA9SgjpoVqREqCF4k=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Yi8nkiKs3U8fCY10unD/2kBBaG9ZgKpVGRXZ1F0lE8llRsJxT17sw82bLU+ytCYWmV3Ou8fd3dktaz4M95Ah8Zdr5ERN2qeZ+RC7yatRvyOlTYPnl5Vgk5v5dj3iJxdT2lbBuGbUC+2/pBF8Z9gQrTeh0d8iujroJWjMk1yXujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ed6CzlBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BDDC433F1;
	Sat,  2 Mar 2024 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709406302;
	bh=3JHsx8FW3HOuP/diEh96oe8D8KOA9SgjpoVqREqCF4k=;
	h=Subject:To:From:Date:From;
	b=ed6CzlBhZPhMUPTe6BDvXUBEc8D0QwUF2D6+xZs29r9lP7l8r2AIaW6/QbhmdutIm
	 JvP75nkOqJPzgPuo7JqM0qNWFSvd5ZDk5A51orlgrJsUXwWJJVOMsISkf90BgI3Lue
	 nYNhXWNnYqppeD3FULJ+hq+/FsCPItrjB1DiuuZM=
Subject: patch "iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2" added to char-misc-testing
To: quentin.schulz@theobroma-systems.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy.shevchenko@gmail.com,heiko@sntech.de
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Mar 2024 20:03:47 +0100
Message-ID: <2024030247-matching-customer-61d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From b0a4546df24a4f8c59b2d05ae141bd70ceccc386 Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Date: Fri, 23 Feb 2024 13:45:21 +0100
Subject: iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2

The SARADCv2 on RK3588 (the only SoC currently supported that has an
SARADCv2) selects the channel through the channel_sel bitfield which is
the 4 lowest bits, therefore the mask should be GENMASK(3, 0) and not
GENMASK(15, 0).

Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240223-saradcv2-chan-mask-v1-1-84b06a0f623a@theobroma-systems.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index dd94667a623b..2da8d6f3241a 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -52,7 +52,7 @@
 #define SARADC2_START			BIT(4)
 #define SARADC2_SINGLE_MODE		BIT(5)
 
-#define SARADC2_CONV_CHANNELS GENMASK(15, 0)
+#define SARADC2_CONV_CHANNELS GENMASK(3, 0)
 
 struct rockchip_saradc;
 
-- 
2.44.0



