Return-Path: <stable+bounces-66431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6E94EA15
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE696281316
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E216D9CC;
	Mon, 12 Aug 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fmQ5Adhj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F916D9AB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455618; cv=none; b=qk1r+RnGQLe3s0Amg76DYy8CgdfzGCKeIJ1jdaYGdqk4bE+jZppsvXRuoUrPQmGxGdaAlBosx4MOO4kM3wPFns8CVl9oGP0+QXFWkNSmNcfrhY1p/Sj3JDQI3ooN4lbKRWEP+LKGeE95/w2TyyoEkefUyxPnkBq5ubXWsvxIFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455618; c=relaxed/simple;
	bh=sz+N1O+WavzBT3VyEdKYXt7bcQYk809dLQRqlqkBgiM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ceWIl0hJ3+FY1GHifz30HgJnVEn5Dx48x9tr25Rm0Dylulp1lndcUKEDSFHC5K8mKWD2v9uCCbdoKGtF2hYdlfbxKulh6ElvSH3RAU/5MebROvMLT1diXXTj7xHDsrGFfXj9ygMGItD4qL9NU2+sqVulLJIu0TiL4aOA0Anh7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fmQ5Adhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF48C32782;
	Mon, 12 Aug 2024 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723455618;
	bh=sz+N1O+WavzBT3VyEdKYXt7bcQYk809dLQRqlqkBgiM=;
	h=Subject:To:Cc:From:Date:From;
	b=fmQ5AdhjwXiCZi5lUGvPUS1/dXA3HjTQNcVHHuLKUkDeZ2BrM3UKN82xidPfzh/B6
	 AxiuYL/LGViP2INQbKzGrbip5WsorOmv6kYBGvHjSVFengrFuufmUd0wBWKZ95D0IN
	 aes4rENqHewCZPB5eX+sFByl/UYQWwuuKOBLHaeo=
Subject: FAILED: patch "[PATCH] usb: typec: fsa4480: Check if the chip is really there" failed to apply to 6.1-stable tree
To: konrad.dybcio@linaro.org,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:40:07 +0200
Message-ID: <2024081206-aqua-obscure-d702@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e885f5f1f2b43575aa8e4e31404132d77d6663d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081206-aqua-obscure-d702@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e885f5f1f2b4 ("usb: typec: fsa4480: Check if the chip is really there")
cf07c55f9922 ("usb: typec: fsa4480: Add support to swap SBU orientation")
c7054c31c1c9 ("usb: typec: fsa4480: rework mux & switch setup to handle more states")

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


