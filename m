Return-Path: <stable+bounces-8713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029E820461
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719561C20D3D
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6501C0F;
	Sat, 30 Dec 2023 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjPxLfO7"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A11123A5
	for <Stable@vger.kernel.org>; Sat, 30 Dec 2023 10:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE57FC433C7;
	Sat, 30 Dec 2023 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933813;
	bh=mV7N/5qty24PSC48TDNNyfvFoxWQMP6JcG76H3/OEJU=;
	h=Subject:To:Cc:From:Date:From;
	b=EjPxLfO7mMtm4DeXK/Gzwh4GZ8T8NqljHpTvYIidJbnpNnwgHLEPynFy4EdSH+Alw
	 vHKvxNI5jbFM08T/PzImXCSxKfWTXljoKxniJO1gyx1GE5drVhWQp64ZkojHqHn2gh
	 kYCYO3W3mOoF5mYbAIlvDV5BlDvoTZprdLpWIzp4=
Subject: FAILED: patch "[PATCH] iio: imu: adis16475: use bit numbers in assign_bit()" failed to apply to 6.6-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,error27@gmail.com,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:56:50 +0000
Message-ID: <2023123050-margarita-embargo-94bc@gregkh>
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
git cherry-pick -x 1cd2fe4fd63e54b799a68c0856bda18f2e40caa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123050-margarita-embargo-94bc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1cd2fe4fd63e ("iio: imu: adis16475: use bit numbers in assign_bit()")
8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta velocity channels")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cd2fe4fd63e54b799a68c0856bda18f2e40caa8 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Mon, 6 Nov 2023 16:07:30 +0100
Subject: [PATCH] iio: imu: adis16475: use bit numbers in assign_bit()

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
 


