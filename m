Return-Path: <stable+bounces-191748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DECC21132
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36EF04EDF32
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C031197A;
	Thu, 30 Oct 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lSrIlkXH"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA637A3B4
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839860; cv=none; b=Zh8OUvN4edDt9lC6NmsVVup3Z8PmOk+TzgXfE4Oj6BQHbNpQFSYmyUi3j4XtXYGkth2/0XSNF5GllN0v5RkTc9bF94dGb/SMp5vy9EbcKYggsF4x8ETo8VbAeF/F36Z+VuymVJxtarqpWwnsV7+ITAOzavPUA+mezTgPuqDgCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839860; c=relaxed/simple;
	bh=CqHVL/7IGlF0WvT59Ow1FueZZshevCmqg7NJscpg0FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enA2UIhkVDGdtRGytCLE03rSf+/azD4GYR+mqwrhaQfFAmSTUkK0IMUIWyAJ8IbDYH/9wy0ot+LvBtMW+7yBj/WOaUn9SIaoCaiqLymu+o/7pob+LGIJKiTuyu5fZ0kyLW8DxFGkeuBaDhOUSAIr5ZUqBakbx0l8WqOq4zVufCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lSrIlkXH; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761839846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dUc6kDMZkh5UFTC0pQiBgy/WoZ2J6ZZZehWYWEHqOy8=;
	b=lSrIlkXHfQnM1a4L7ioHWk/ZBrPSFUp8/99cnhs4EDYIR2/4Z3AEn628JOuR+PS5OGa90/
	0NAAoPwN7fXANjujQcLjdl8OeYjb3Zd+Zye8hwOfUXSlNwKDeld+5l6Ydb8Q/fZJ7RidL6
	pchLAmLXlba71QKjLgsIisToOdjmdxo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Akira Shimahara <akira215corp@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Thu, 30 Oct 2025 16:56:09 +0100
Message-ID: <20251030155614.447905-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
bytes and a NUL terminator is appended. However, the 'size' argument
does not account for this extra byte. The original code then allocated
'size' bytes and used strcpy() to copy 'buf', which always writes one
byte past the allocated buffer since strcpy() copies until the NUL
terminator at index 'size'.

Fix this by parsing the 'buf' parameter directly using simple_strtol()
without allocating any intermediate memory or string copying. This
removes the overflow while simplifying the code.

Cc: stable@vger.kernel.org
Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.

Changes in v3:
- Add integer range check for 'temp' to match kstrtoint() behavior
- Explicitly cast 'temp' to int when calling int_to_short()
- Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/

Changes in v2:
- Fix buffer overflow instead of truncating the copy using strscpy()
- Parse buffer directly using simple_strtol() as suggested by David
- Update patch subject and description
- Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
---
 drivers/w1/slaves/w1_therm.c | 102 ++++++++++++-----------------------
 1 file changed, 35 insertions(+), 67 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..1dad9fa1ec4a 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1836,59 +1836,32 @@ static ssize_t alarms_store(struct device *device,
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	struct therm_info info;
 	u8 new_config_register[3];	/* array of data to be written */
-	int temp, ret;
-	char *token = NULL;
+	long temp;
+	int ret;
 	s8 tl, th;	/* 1 byte per value + temp ring order */
-	char *p_args, *orig;
+	const char *p = buf;
+	char *endp;
 
-	p_args = orig = kmalloc(size, GFP_KERNEL);
-	/* Safe string copys as buf is const */
-	if (!p_args) {
-		dev_warn(device,
-			"%s: error unable to allocate memory %d\n",
-			__func__, -ENOMEM);
-		return size;
+	temp = simple_strtol(p, &endp, 10);
+	if (temp < INT_MIN || temp > INT_MAX || p == endp || *endp != ' ') {
+		dev_info(device, "%s: error parsing args %d\n",
+			 __func__, -EINVAL);
+		goto err;
 	}
-	strcpy(p_args, buf);
-
-	/* Split string using space char */
-	token = strsep(&p_args, " ");
+	/* Cast to short to eliminate out of range values */
+	tl = int_to_short((int)temp);
 
-	if (!token)	{
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, -EINVAL);
-		goto free_m;
-	}
-
-	/* Convert 1st entry to int */
-	ret = kstrtoint (token, 10, &temp);
-	if (ret) {
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
-	}
-
-	tl = int_to_short(temp);
-
-	/* Split string using space char */
-	token = strsep(&p_args, " ");
-	if (!token)	{
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, -EINVAL);
-		goto free_m;
-	}
-	/* Convert 2nd entry to int */
-	ret = kstrtoint (token, 10, &temp);
-	if (ret) {
-		dev_info(device,
-			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
+	p = endp + 1;
+	temp = simple_strtol(p, &endp, 10);
+	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
+		dev_info(device, "%s: error parsing args %d\n",
+			 __func__, -EINVAL);
+		goto err;
 	}
+	/* Cast to short to eliminate out of range values */
+	th = int_to_short((int)temp);
 
-	/* Prepare to cast to short by eliminating out of range values */
-	th = int_to_short(temp);
-
-	/* Reorder if required th and tl */
+	/* Reorder if required */
 	if (tl > th)
 		swap(tl, th);
 
@@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
 	 * (th : byte 2 - tl: byte 3)
 	 */
 	ret = read_scratchpad(sl, &info);
-	if (!ret) {
-		new_config_register[0] = th;	/* Byte 2 */
-		new_config_register[1] = tl;	/* Byte 3 */
-		new_config_register[2] = info.rom[4];/* Byte 4 */
-	} else {
-		dev_info(device,
-			"%s: error reading from the slave device %d\n",
-			__func__, ret);
-		goto free_m;
+	if (ret) {
+		dev_info(device, "%s: error reading from the slave device %d\n",
+			 __func__, ret);
+		goto err;
 	}
+	new_config_register[0] = th;		/* Byte 2 */
+	new_config_register[1] = tl;		/* Byte 3 */
+	new_config_register[2] = info.rom[4];	/* Byte 4 */
 
 	/* Write data in the device RAM */
 	if (!SLAVE_SPECIFIC_FUNC(sl)) {
-		dev_info(device,
-			"%s: Device not supported by the driver %d\n",
-			__func__, -ENODEV);
-		goto free_m;
+		dev_info(device, "%s: Device not supported by the driver %d\n",
+			 __func__, -ENODEV);
+		goto err;
 	}
 
 	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
-	if (ret)
-		dev_info(device,
-			"%s: error writing to the slave device %d\n",
+	if (ret) {
+		dev_info(device, "%s: error writing to the slave device %d\n",
 			__func__, ret);
+		goto err;
+	}
 
-free_m:
-	/* free allocated memory */
-	kfree(orig);
-
+err:
 	return size;
 }
 
-- 
2.51.0


