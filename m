Return-Path: <stable+bounces-70216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828C95F13F
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC894B22701
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4E13BACE;
	Mon, 26 Aug 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GK0bZZsd"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0342AAA
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675019; cv=none; b=Z3ROuVOfuNv43NHy7DduHTtWluekSf0RCWnV+zxX1dpLOGmIpRhIJF7rDm1K8iTKBGl4U4uJCob4B9HwphCH8uIrcwxzWaZWhb7RjH/ANIxjub1emG0soe7Nm7r3waZkx8qlv1LXuYv6WGJHhXj8bOVUD/b3tddh61cWVhWgtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675019; c=relaxed/simple;
	bh=NGNuO7b6HqvQMZTRpQYtKXImvZv18AhKyVxbRvncbOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F70TyC/qCxoTLCnMeDWw6YOQXAGII56Tkz7FUb2Lb6bzhwU4ynJI6lnXB2yMIiHp/pRgtF8jY5Gm5mSGg0u8Wqi/1xtTBr2CANkRIDhtzTNzxJ9iwr4YHM95yw/wbesKDLHG1dudZ6JZYmq/pwZ8VFka3evYGilUU3ZDB8MoqBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GK0bZZsd; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724675017;
	bh=arCgGz+KTYXJ008/MuCBxOBSjDGOop8UkjnG9nPczys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=GK0bZZsd4XuPRGuSBXnziHY4wAlZDb7oOrv1UoG/1NquysNjr4oHTSPull/scooUM
	 80CMge0F1+7uyl1WTECovjShNiFzwt3vyQr9aQc3z/KpqhG7D8bzkgh0JCTZDlG7WN
	 IDuByJymHgqTXmEZisF6XWZPN+TdyJZGWP1keZFNjT8BmV3OiZJX59RL/bwuBQ80gX
	 ODs3yHTyNUlssiTx5KhAdqQuTZvLSffht05lka3KHwxsGdAcwBGcG1zHiqvCB3/Czk
	 uoqFmkvw+cdTzCMJOfzCTQEBE1m86C1uNcv5oCtigQ9r5ZGzsqlwEICY5MuDmWE/fQ
	 SKzP/35wXZPhQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 992392C0322;
	Mon, 26 Aug 2024 12:23:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 26 Aug 2024 20:23:06 +0800
Subject: [PATCH RFC] driver core: bus: Correct return value for storing bus
 attribute drivers_probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-fix_drivers_probe-v1-1-be511b0d54c5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKlzzGYC/x2MQQqAIBAAvxJ7TlAJsa5BD+gaEWZb7cVkBQmiv
 ycdB2bmgYRMmKCrHmDMlOgKBVRdgT9dOFDQVhi01I202oid7mVjyshpiXytKKz1xmnvlW1bKF1
 kLNL/nGAcepjf9wNI0UB+aAAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: uAseHAhC_F9xXK6xPYQ1OG0a5f_uGONT
X-Proofpoint-GUID: uAseHAhC_F9xXK6xPYQ1OG0a5f_uGONT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408260097
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

drivers_probe_store() regards bus_rescan_devices_helper()'s returned
value 0 as success when find driver for a single device user specify
that is wrong since the following 3 failed cases also return 0:

(1) the device is dead
(2) bus fails to match() the device with any its driver
(3) bus fails to probe() the device with any its driver

Fixed by only regarding successfully attaching the device to a driver
as success.

Fixes: b8c5cec23d5c ("Driver core: udev triggered device-<>driver binding")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index abf090ace833..0a994e63785c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -40,6 +40,20 @@ static struct kset *bus_kset;
 	struct driver_attribute driver_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
 
+/* Bus rescans drivers for a single device */
+static int __must_check bus_rescan_single_device(struct device *dev)
+{
+	int ret;
+
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_lock(dev->parent);
+	ret = device_attach(dev);
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_unlock(dev->parent);
+
+	return ret;
+}
+
 static int __must_check bus_rescan_devices_helper(struct device *dev,
 						void *data);
 
@@ -311,12 +325,19 @@ static ssize_t drivers_probe_store(const struct bus_type *bus,
 {
 	struct device *dev;
 	int err = -EINVAL;
+	int res;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (!dev)
 		return -ENODEV;
-	if (bus_rescan_devices_helper(dev, NULL) == 0)
+
+	res = bus_rescan_single_device(dev);
+	/* Propagate error code upwards as far as possible */
+	if (res < 0)
+		err = res;
+	else if (res == 1)
 		err = count;
+
 	put_device(dev);
 	return err;
 }

---
base-commit: 888f67e621dda5c2804a696524e28d0ca4cf0a80
change-id: 20240826-fix_drivers_probe-88c6a2cc1899

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


