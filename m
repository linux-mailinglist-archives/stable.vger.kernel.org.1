Return-Path: <stable+bounces-66430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE8494EA14
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9931C21717
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232016DC12;
	Mon, 12 Aug 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COiSiuRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103616DEAD
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455607; cv=none; b=NCJpphP0IQ0mqyRivSODGOFLoHBsBwMgR6LgQ1cMue/j/ctTyOGU4Q3bTolJMlgicFfNV5mMeLqXU4RVYyA2owcabzbxymeCYebGiGz/T/l/xQTX26+9rsBdz5lRRHuLZ3SIMFJgSk2/dK2JV3MSMB8PD3CLaMT4S9k/v5ew96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455607; c=relaxed/simple;
	bh=ciWY8QFvrjDAVoH4nTpdV4DEuUnxSie7eJIozJvAqT0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ik2T0sR6hhJQi32nth5O2ZI+xh4gxDhjVMY11wBWOqXL94m1FCBxzW25MJvO4p6uaX2+UIsosRahThCazN8ClX2fADoHlGKnb/6Sd1uNBV9551KX/ngDf+01jLI12KW4j0LeaxIrbd5/nsxR9xnHJFiZV5rRYyiLnaqilt7O8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COiSiuRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827EFC4AF0F;
	Mon, 12 Aug 2024 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723455607;
	bh=ciWY8QFvrjDAVoH4nTpdV4DEuUnxSie7eJIozJvAqT0=;
	h=Subject:To:Cc:From:Date:From;
	b=COiSiuRq7kk26qv+pWKyCIe+0GE2mO/oum7fTyiNIe7EwrcRotrDFABakUBtG2A9H
	 KFiMWXMavq17BsxVkfWXylZkLe8EtlB5JHYdmtU4zzO+WBA9PUUIEM6BL6GG/1K5Nh
	 YRWH6F0mLBPpeH0r+ejFapvuU9sTN/7A2cwZwn+Y=
Subject: FAILED: patch "[PATCH] usb: typec: fsa4480: Check if the chip is really there" failed to apply to 6.6-stable tree
To: konrad.dybcio@linaro.org,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:40:03 +0200
Message-ID: <2024081202-author-suspense-c645@gregkh>
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
git cherry-pick -x e885f5f1f2b43575aa8e4e31404132d77d6663d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081202-author-suspense-c645@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

e885f5f1f2b4 ("usb: typec: fsa4480: Check if the chip is really there")
cf07c55f9922 ("usb: typec: fsa4480: Add support to swap SBU orientation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e885f5f1f2b43575aa8e4e31404132d77d6663d1 Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 29 Jul 2024 10:42:58 +0200
Subject: [PATCH] usb: typec: fsa4480: Check if the chip is really there

Currently, the driver will happily register the switch/mux devices, and
so long as the i2c master doesn't complain, the user would never know
there's something wrong.

Add a device id check (based on [1]) and return -ENODEV if the read
fails or returns nonsense.

Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
the ID mentioned in the datasheet does indeed show up:
 fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)

[1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf

Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240729-topic-fs4480_check-v3-1-f5bf732d3424@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index cb7cdf90cb0a..cd235339834b 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -13,6 +13,10 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
+#define FSA4480_DEVICE_ID	0x00
+ #define FSA4480_DEVICE_ID_VENDOR_ID	GENMASK(7, 6)
+ #define FSA4480_DEVICE_ID_VERSION_ID	GENMASK(5, 3)
+ #define FSA4480_DEVICE_ID_REV_ID	GENMASK(2, 0)
 #define FSA4480_SWITCH_ENABLE	0x04
 #define FSA4480_SWITCH_SELECT	0x05
 #define FSA4480_SWITCH_STATUS1	0x07
@@ -251,6 +255,7 @@ static int fsa4480_probe(struct i2c_client *client)
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
 	struct fsa4480 *fsa;
+	int val = 0;
 	int ret;
 
 	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
@@ -268,6 +273,15 @@ static int fsa4480_probe(struct i2c_client *client)
 	if (IS_ERR(fsa->regmap))
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
 
+	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
+	if (ret || !val)
+		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
+
+	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",
+		FIELD_GET(FSA4480_DEVICE_ID_VERSION_ID, val),
+		FIELD_GET(FSA4480_DEVICE_ID_REV_ID, val),
+		FIELD_GET(FSA4480_DEVICE_ID_VENDOR_ID, val));
+
 	/* Safe mode */
 	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
 	fsa->mode = TYPEC_STATE_SAFE;


