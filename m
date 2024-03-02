Return-Path: <stable+bounces-25784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A5286F204
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313141C20B1E
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5D2BB1E;
	Sat,  2 Mar 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPgQMPgS"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015561DA22
	for <Stable@vger.kernel.org>; Sat,  2 Mar 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406626; cv=none; b=A7CJTAbmP9EBV4Tf0DPZOyE/Cq6AGyHzi4D8BiWKyItzRCI/SZNPzDzqX7vHFPa19OYkGvu76vwbP1/ZV+dF69ZZN2tlxyhePHQucKw+F99hsMwGXmU5rhDCgpZ7uS00/O9gxzcj/eYSOXif5BDBeyHi3hGUjs3W9jYlEpzLOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406626; c=relaxed/simple;
	bh=5ZD8JSVee1nLKNQp+yg8vFfhEfJWTPWzCvGAx6u5GoA=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=cGWNcFYZLu99lQiDIx/AvJZdPnS/aOycluwzdil4s2N6C08dEoO0V9Hjj2PZmj/8aMvkQOpKowjbhvJMnuvsFLBygrOC3t95MAmtZgBv2EEs7MtB3u7z3syJaMyHqOPzGFeut63oEZtTRrQmauIO0/B5EF3/KBFisw3RqWL7EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPgQMPgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FB3C433F1;
	Sat,  2 Mar 2024 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709406625;
	bh=5ZD8JSVee1nLKNQp+yg8vFfhEfJWTPWzCvGAx6u5GoA=;
	h=Subject:To:From:Date:From;
	b=tPgQMPgSB1ONYQUTahFBfYBloUeQybtnqlZg6FcETRdxFHTKlaoEoCdTxL2Csd3FR
	 GAGkS0USPV/qffaZK1FGA26+gT8qM5F6viK84kUDwjRZX7w1PsWxjgPd5MWvbJHBQD
	 3D4ci+IVoy80NCB1ZOASrL5+SbQ+Au3s220S1tOs=
Subject: patch "iio: adc: rockchip_saradc: use mask for write_enable bitfield" added to char-misc-next
To: quentin.schulz@theobroma-systems.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,heiko@sntech.de
From: <gregkh@linuxfoundation.org>
Date: Sat, 02 Mar 2024 20:08:25 +0100
Message-ID: <2024030225-preppy-cocoa-140d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rockchip_saradc: use mask for write_enable bitfield

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 5b4e4b72034f85f7a0cdd147d3d729c5a22c8764 Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Date: Fri, 23 Feb 2024 13:45:22 +0100
Subject: iio: adc: rockchip_saradc: use mask for write_enable bitfield

Some of the registers on the SARADCv2 have bits write protected except
if another bit is set. This is usually done by having the lowest 16 bits
store the data to write and the highest 16 bits specify which of the 16
lowest bits should have their value written to the hardware block.

The write_enable mask for the channel selection was incorrect because it
was just the value shifted by 16 bits, which means it would only ever
write bits and never clear them. So e.g. if someone starts a conversion
on channel 5, the lowest 4 bits would be 0x5, then starts a conversion
on channel 0, it would still be 5.

Instead of shifting the value by 16 as the mask, let's use the OR'ing of
the appropriate masks shifted by 16.

Note that this is not an issue currently because the only SARADCv2
currently supported has a reset defined in its Device Tree, that reset
resets the SARADC controller before starting a conversion on a channel.
However, this reset is handled as optional by the probe function and
thus proper masking should be used in the event an SARADCv2 without a
reset ever makes it upstream.

Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20240223-saradcv2-chan-mask-v1-2-84b06a0f623a@theobroma-systems.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rockchip_saradc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 2da8d6f3241a..1c0042fbbb54 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -102,12 +102,12 @@ static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
 	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
 	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
 	val = FIELD_PREP(SARADC2_EN_END_INT, 1);
-	val |= val << 16;
+	val |= SARADC2_EN_END_INT << 16;
 	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
 	val = FIELD_PREP(SARADC2_START, 1) |
 	      FIELD_PREP(SARADC2_SINGLE_MODE, 1) |
 	      FIELD_PREP(SARADC2_CONV_CHANNELS, chn);
-	val |= val << 16;
+	val |= (SARADC2_START | SARADC2_SINGLE_MODE | SARADC2_CONV_CHANNELS) << 16;
 	writel(val, info->regs + SARADC2_CONV_CON);
 }
 
-- 
2.44.0



