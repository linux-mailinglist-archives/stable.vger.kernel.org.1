Return-Path: <stable+bounces-104423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A99F4163
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 04:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB158168BFA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A69F14AD3F;
	Tue, 17 Dec 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VMcJfvN+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF81482F3;
	Tue, 17 Dec 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407831; cv=none; b=NVjDRI/Lr3F9131EOinzE/GGG/47bpTb/2NjbawIDsAP+mkrpZvAyehiXVEjaJ/8KJ6ZQxuIEzcNMi6uKSYXKIh/p10HNggYncqS22bpbDyYm5HGPnN/3Qn+h3UzhdEtx6BdsRSxo+2yrE+zfcWr4uQxi2bSq6tfFg0f2bvbDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407831; c=relaxed/simple;
	bh=f+Svd6jBysHO6iNXHrodqjCvsSrQ/rAVoJwrhzCuv2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dY30/Smb4/UbDMXlahSxlmgbicHPp06VRMfmFKyEsFon3fuFeGjh6nigDeZKkbaetJx50qQXAZr/dVRvyNqyf/EG9zVd4II19Y42WBL8FWE2fMRRA7lSLN0w3XGvgGa/8o8rDByMfPg57Rem47NKIEPxf97fVV3urOjmudajd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VMcJfvN+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3asV1
	gEby70A4HZ5pgr0BDGKo3u3M3GYTYfa9i4j+50=; b=VMcJfvN+i9OSzQLnTIp39
	0jOSYgXKRxzAMabzJR2aIHJf1G1KN67Ws8V/u5W8UlHgY5xh24Z7WOl8DdyH1P9w
	7acgRvq7GECa5nhshsSug34HQPnZ3NBgcRpHYtjgGvH5HjdJ6Qj004zrl11eafcB
	IoqrIXcJlxa6YPUrOyxmj4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnrwLS9WBnp_BEBA--.43704S4;
	Tue, 17 Dec 2024 11:54:02 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	mka@chromium.org,
	christophe.jaillet@wanadoo.fr,
	quic_ugoswami@quicinc.com,
	oneukum@suse.com,
	stanley_chang@realtek.com,
	javier.carrasco@wolfvision.net
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: fix reference leak in usb_new_device()
Date: Tue, 17 Dec 2024 11:53:52 +0800
Message-Id: <20241217035353.2891942-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrwLS9WBnp_BEBA--.43704S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rJry5Gw4xJw1DCFyxuFg_yoWkAFc_XF
	4j934DWF18KF97tr13G3yYvrWIkrnFvrW8ZF9YgFn3Xa4YgrWxXr17XrZYqr4UW3y2kw1q
	vF10krZ5Xr1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizQW4C2dg7-GcPgAAsA

When device_add(&udev->dev) failed, calling put_device() to explicitly
release udev->dev. Otherwise, it could cause double free problem.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 9f8b17e643fe ("USB: make usbdevices export their device nodes instead of using a separate class")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/usb/core/hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..05b778d2ad63 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2651,6 +2651,7 @@ int usb_new_device(struct usb_device *udev)
 	err = device_add(&udev->dev);
 	if (err) {
 		dev_err(&udev->dev, "can't device_add, error %d\n", err);
+		put_device(&udev->dev);
 		goto fail;
 	}
 
@@ -2683,6 +2684,9 @@ int usb_new_device(struct usb_device *udev)
 	pm_runtime_put_sync_autosuspend(&udev->dev);
 	return err;
 
+out_del_dev:
+	device_del(&udev->dev);
+	put_device(&udev->dev);
 fail:
 	usb_set_device_state(udev, USB_STATE_NOTATTACHED);
 	pm_runtime_disable(&udev->dev);
-- 
2.25.1


