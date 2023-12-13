Return-Path: <stable+bounces-6074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A580D89D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA71F218FE
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284C51C33;
	Mon, 11 Dec 2023 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9KkzyuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C24437B;
	Mon, 11 Dec 2023 18:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043A9C433C7;
	Mon, 11 Dec 2023 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320441;
	bh=6TGL62GCt9PaGJyHeCkd4Yr/y0X2UUS+XdsxXyYxfk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9KkzyuLPnD+cQR10ptu3uN42lVimBf0y3qEVIScOqPmQ/VxdqwMWCdyPBb5v2Exh
	 FRO6XAopYCwkMv/AL+AqLjMhZJVpa9of8lQ8bJH6lC8UlCe7psyZAuB7EUQrVfnVLa
	 UiXsS0knsAcp5jNcp2Lu9CEObHT5li+R9rm6GfDM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/194] tee: optee: Fix supplicant based device enumeration
Date: Mon, 11 Dec 2023 19:20:53 +0100
Message-ID: <20231211182039.308927505@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Garg <sumit.garg@linaro.org>

[ Upstream commit 7269cba53d906cf257c139d3b3a53ad272176bca ]

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024

Fix this by adding an attribute for supplicant dependent devices so that
the user-space service can detect and detach supplicant devices before
closing the supplicant:

$ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
      then echo $(basename "$dev") > $dev/driver/unbind; fi done

Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Closes: https://github.com/OP-TEE/optee_os/issues/6094
Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
[jw: fixed up Date documentation]
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
 drivers/tee/optee/device.c                      | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
index 0f58701367b66..af31e5a22d89f 100644
--- a/Documentation/ABI/testing/sysfs-bus-optee-devices
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -6,3 +6,12 @@ Description:
 		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
 		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
 		are free to create needed API under optee-ta-<uuid> directory.
+
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
+Date:		November 2023
+KernelVersion:	6.7
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Allows to distinguish whether an OP-TEE based TA/device requires user-space
+		tee-supplicant to function properly or not. This attribute will be present for
+		devices which depend on tee-supplicant to be running.
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 64f0e047c23d2..4b10921276942 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
 
-static int optee_register_device(const uuid_t *device_uuid)
+static ssize_t need_supplicant_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return 0;
+}
+
+static DEVICE_ATTR_RO(need_supplicant);
+
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
 		put_device(&optee_device->dev);
 	}
 
+	if (func == PTA_CMD_GET_DEVICES_SUPP)
+		device_create_file(&optee_device->dev,
+				   &dev_attr_need_supplicant);
+
 	return rc;
 }
 
@@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx]);
+		rc = optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
-- 
2.42.0




