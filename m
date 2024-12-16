Return-Path: <stable+bounces-104374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA59F3495
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9223C161637
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A2149DF7;
	Mon, 16 Dec 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znAIUpuf"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998841428E7
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363184; cv=none; b=ZGwS4H7JRaDtkMTkZxwAplGnMK3/7X7pz7/mkVHN+ez7zk14zt9kjDoq1tUU3RpCoALJkDkZIJhOc+Mpq30JLpQ0PoFLZdd4JzUeUUAE7Eh/fjFeE81jWTYPUh02/WLgv74MbiPt7pGOV+BFpyf9QhApILLwFrtQRAox54SwxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363184; c=relaxed/simple;
	bh=ul4Nct4o17HeM9LozmQAEVcn0XRhVjW/JsI1cK/yW38=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=tPjFjYZOeQdOt4W/zQY7EHewwd14DqvVCWHAJKYuEhhGxPlXaKj8MDDnQhVZJ/CaqlEMiQF5fDXNKLDXRXwoysyGj8aFFeh9snJG7JEqKrZyAdYuA7ozbDOIaZknM5q+GzGQ073M1LU4ldFtqjEQ400t4NNv5qsQpACJmVYrt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znAIUpuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6578C4CEDD;
	Mon, 16 Dec 2024 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363184;
	bh=ul4Nct4o17HeM9LozmQAEVcn0XRhVjW/JsI1cK/yW38=;
	h=Subject:To:From:Date:From;
	b=znAIUpuf3WG2y+ZlCTOCAPiJfs6onfZXsR/LD0F5DPB/wgrGdrsQYxLJdWEVucZ+F
	 5Tgvtr5GPoJqfsXq4b/IVAgbAYtiEzlZOcDxuzKFWKXBWMuAXGO5lmhtyWyPkIscU5
	 8SzjSf/U8ErdIuZySGcmo3jhFR7dgiKBspX73/do=
Subject: patch "iio: adc: ti-ads1119: fix sample size in scan struct for triggered" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,francesco.dolcini@toradex.com
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:46 +0100
Message-ID: <2024121646-lyrically-derail-c898@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1119: fix sample size in scan struct for triggered

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 54d394905c92b9ecc65c1f9b2692c8e10716d8e1 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 2 Dec 2024 20:18:44 +0100
Subject: iio: adc: ti-ads1119: fix sample size in scan struct for triggered
 buffer

This device returns signed, 16-bit samples as stated in its datasheet
(see 8.5.2 Data Format). That is in line with the scan_type definition
for the IIO_VOLTAGE channel, but 'unsigned int' is being used to read
and push the data to userspace.

Given that the size of that type depends on the architecture (at least
2 bytes to store values up to 65535, but its actual size is often 4
bytes), use the 's16' type to provide the same structure in all cases.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20241202-ti-ads1119_s16_chan-v1-1-fafe3136dc90@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 2615a275acb3..c268e27eec12 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -500,7 +500,7 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads1119_state *st = iio_priv(indio_dev);
 	struct {
-		unsigned int sample;
+		s16 sample;
 		s64 timestamp __aligned(8);
 	} scan;
 	unsigned int index;
-- 
2.47.1



