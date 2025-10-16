Return-Path: <stable+bounces-186014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF12BE338A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA38D4F3D2F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCB31CA47;
	Thu, 16 Oct 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XasR9Pki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C331B105
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616284; cv=none; b=J3RX0jILV3pRaI5MqVDyy3DgMEfWqsy4vIYwYSTN4JNmhbav1488oxz0bmrQx+Sa7Nm5jK+XQXsYfNFMahx12GoY0zZSni+i0d5fKJszB1WM5EOLSgjQkac418PYN7S1ibP7eyHKPxANa9u4nMlfKqUL3SDoF1cFBEA+/O0GMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616284; c=relaxed/simple;
	bh=trbVTJ5XKeNS2CzGFwoR/xKy1oOcd2rQ2mBVFc+01FI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N+7VFofD1TjM2tkqqshRNV5MxVTIOdJO06gU1m4sacoaOPU7hh+cDnCczyUYZi9ptH5O0hlxU8Hu3RNgEG++pc4eP5W4rwn99OT2LWUna3zZmQnvqkeL1I/dnS93CT/Cm+Cv2oLuF8CKhGxKVv8v3Ra8j97JI+0gC4rny5qaxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XasR9Pki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F106FC4CEF1;
	Thu, 16 Oct 2025 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760616284;
	bh=trbVTJ5XKeNS2CzGFwoR/xKy1oOcd2rQ2mBVFc+01FI=;
	h=Subject:To:Cc:From:Date:From;
	b=XasR9PkiyAaVPMKyKv3Kg4++PQAwp74hLFkT7Lh42hfMXmmWudAjGBJccwkXOAclQ
	 l6PrMACaDhFfpXntdLW22DFB1QT5D7crxRY+6Nv4QU5Khf495uLhVe8K1ibjiTn9Vy
	 +f5mLEl2XOUS3K6nRke/dZ8+X04oj3N9e1uvdJwY=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Do not use uninitialized 'dev' pointer in" failed to apply to 5.10-stable tree
To: zxue@semtech.com,krishna.chundru@oss.qualcomm.com,manivannan.sadhasivam@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:04:41 +0200
Message-ID: <2025101641-blooming-stiffness-1ee0@gregkh>
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
git cherry-pick -x d0856a6dff57f95cc5d2d74e50880f01697d0cc4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101641-blooming-stiffness-1ee0@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0856a6dff57f95cc5d2d74e50880f01697d0cc4 Mon Sep 17 00:00:00 2001
From: Adam Xue <zxue@semtech.com>
Date: Fri, 5 Sep 2025 10:41:18 -0700
Subject: [PATCH] bus: mhi: host: Do not use uninitialized 'dev' pointer in
 mhi_init_irq_setup()

In mhi_init_irq_setup, the device pointer used for dev_err() was not
initialized. Use the pointer from mhi_cntrl instead.

Fixes: b0fc0167f254 ("bus: mhi: core: Allow shared IRQ for event rings")
Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
Signed-off-by: Adam Xue <zxue@semtech.com>
[mani: reworded subject/description and CCed stable]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250905174118.38512-1-zxue@semtech.com

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 7f72aab38ce9..099be8dd1900 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -194,7 +194,6 @@ static void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl)
 static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 {
 	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
-	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
 	int i, ret;
 
@@ -221,7 +220,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 			continue;
 
 		if (mhi_event->irq >= mhi_cntrl->nr_irqs) {
-			dev_err(dev, "irq %d not available for event ring\n",
+			dev_err(mhi_cntrl->cntrl_dev, "irq %d not available for event ring\n",
 				mhi_event->irq);
 			ret = -EINVAL;
 			goto error_request;
@@ -232,7 +231,7 @@ static int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				  irq_flags,
 				  "mhi", mhi_event);
 		if (ret) {
-			dev_err(dev, "Error requesting irq:%d for ev:%d\n",
+			dev_err(mhi_cntrl->cntrl_dev, "Error requesting irq:%d for ev:%d\n",
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}


