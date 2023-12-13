Return-Path: <stable+bounces-5824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D180D742
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11672B21274
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678DE51C44;
	Mon, 11 Dec 2023 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w66afcOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FF5102A;
	Mon, 11 Dec 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B3AC433C8;
	Mon, 11 Dec 2023 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319762;
	bh=cq7HESuhJBZ8QK1BlpKWzA08etBrXqzw3knVkyzanSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w66afcOgP6xvFUBTsxQSpa8wUSnDNn+TUZbNDlS07KjGT+d0Ffl024jnmpL33HB9a
	 WbKdNQAXVwOG4shZaukiNo03uVwsgbn8aButZW5uRVSlXNhLfRMvZv9i2LkNh6Nwr+
	 oxqvbkhsjpWv75iZ4YuaRzPmHYl8ljmn24wjJyXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 6.6 224/244] devcoredump: Send uevent once devcd is ready
Date: Mon, 11 Dec 2023 19:21:57 +0100
Message-ID: <20231211182056.051326237@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mukesh Ojha <quic_mojha@quicinc.com>

commit af54d778a03853801d681c98c0c2a6c316ef9ca7 upstream.

dev_coredumpm() creates a devcoredump device and adds it
to the core kernel framework which eventually end up
sending uevent to the user space and later creates a
symbolic link to the failed device. An application
running in userspace may be interested in this symbolic
link to get the name of the failed device.

In a issue scenario, once uevent sent to the user space
it start reading '/sys/class/devcoredump/devcdX/failing_device'
to get the actual name of the device which might not been
created and it is in its path of creation.

To fix this, suppress sending uevent till the failing device
symbolic link gets created and send uevent once symbolic
link is created successfully.

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1700232572-25823-1-git-send-email-quic_mojha@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/devcoredump.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -362,6 +362,7 @@ void dev_coredumpm(struct device *dev, s
 	devcd->devcd_dev.class = &devcd_class;
 
 	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -376,6 +377,8 @@ void dev_coredumpm(struct device *dev, s
 		              "devcoredump"))
 		dev_warn(dev, "devcoredump create_link failed\n");
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	mutex_unlock(&devcd->mutex);



