Return-Path: <stable+bounces-8716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD003820464
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932B52821C4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4F20EA;
	Sat, 30 Dec 2023 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ii+euy+l"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC7A23A5
	for <Stable@vger.kernel.org>; Sat, 30 Dec 2023 10:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A491C433C8;
	Sat, 30 Dec 2023 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933820;
	bh=cMgj+doG/rXEhb/EgkMCWIQMP4XVPWvWduzNjWPRUso=;
	h=Subject:To:Cc:From:Date:From;
	b=Ii+euy+lwQNnLff8fk42KPsuvZd+zDlryl8CHWtDkP8duyHuYEJV8yWuWV2PuNivp
	 PaQFgVzLI/C3fTZ9AKklW0eYaxYnbtmuY2kGCci6akZdlkV4gFdfF1aPgDppIlvg40
	 MAuKN2wgm9fu8vT+Zuwr3M3NH5LYLb2BFik0xdNM=
Subject: FAILED: patch "[PATCH] iio: imu: adis16475: use bit numbers in assign_bit()" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,error27@gmail.com,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:56:53 +0000
Message-ID: <2023123053-stimulant-zealous-f9eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1cd2fe4fd63e54b799a68c0856bda18f2e40caa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123053-stimulant-zealous-f9eb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1cd2fe4fd63e ("iio: imu: adis16475: use bit numbers in assign_bit()")
8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta velocity channels")
c1f10bff1619 ("iio: imu: adis16475.c: Add has_burst32 flag to adis16477 devices")
a216d411b547 ("iio: imu: adis16475.c: Remove unused enum elements")

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
 


