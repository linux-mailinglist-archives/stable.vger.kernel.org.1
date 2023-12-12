Return-Path: <stable+bounces-6416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED6E80E67B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4741C213AD
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CF39AD5;
	Tue, 12 Dec 2023 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l7uilA44"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5849B1B271
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCD5C433C7;
	Tue, 12 Dec 2023 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370635;
	bh=NtZ9nU+D3Kp0uVRGRuR7g5D8dtJ62t92sWXlZoGdTTM=;
	h=Subject:To:From:Date:From;
	b=l7uilA44CvDFGW7jLOZQWtXLyQvE3yceJC5UCSGrw4QSSKsfjwt5dEssQDEUv/fLA
	 N2hHhdfD7p6uNYTc6N8jegcbdPGKkf6mrT1hnUeZ6T7cw61HPdxE3yS0VlCNNHL1tL
	 zzJhgLsHWpBmHyiFIUTst8zIPICtL9kH1ePgan6w=
Subject: patch "iio: imu: adis16475: use bit numbers in assign_bit()" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,error27@gmail.com,lkp@intel.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:43 +0100
Message-ID: <2023121243-regime-scraggly-2fb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: adis16475: use bit numbers in assign_bit()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1cd2fe4fd63e54b799a68c0856bda18f2e40caa8 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Mon, 6 Nov 2023 16:07:30 +0100
Subject: iio: imu: adis16475: use bit numbers in assign_bit()

assign_bit() expects a bit number and not a mask like BIT(x). Hence,
just remove the BIT() macro from the #defines.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com/
Fixes: fff7352bf7a3ce ("iio: imu: Add support for adis16475")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20231106150730.945-1-nuno.sa@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16475.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 04153a2725d5..64be656f0b80 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -70,8 +70,8 @@
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
 #define ADIS16475_BURST_MAX_SPEED	1000000
-#define ADIS16475_LSB_DEC_MASK		BIT(0)
-#define ADIS16475_LSB_FIR_MASK		BIT(1)
+#define ADIS16475_LSB_DEC_MASK		0
+#define ADIS16475_LSB_FIR_MASK		1
 #define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
 #define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
 
-- 
2.43.0



