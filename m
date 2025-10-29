Return-Path: <stable+bounces-191607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C5C1A882
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A8351F17
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166B265632;
	Wed, 29 Oct 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="no2fmUgY"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FF25F98E
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742948; cv=none; b=bdHr0necdn8fWjM0RcCE9JuxxmLXE1UhrF9wRDZrBMLupruOtJf98KzVGHOmwOJOXK1BykzzZexTHzzOjHbB4TMFIiAIMEB+NrbQlcKo8WbOs1P15cUA+m0u+oQlklqrcbJXise63Fk8K3aMYt3RlkWgSSqgJ5QKVN9yyV5j+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742948; c=relaxed/simple;
	bh=HRdO7MdJRobaZKmUsL//qKJQTht4NErHFXPuLq0qGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AA4TUQn07PWFXVS2EuwgEBO6Lo+G5mhJlUQG+ztvMhWbF5DetapcESfRUTfl/PIDP+8E6vJWVwyIO+lL4Zy1IHydtwc9nmboYCcAqRN3nUHbgKeYr12+gYuR52o4Z629PwLdQkA6Gn0uNl7B3ixcMvAzb548gwUplu8tzT19PL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=no2fmUgY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761742941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YAq3INe12Qw+gzRxHTWU4Dgdppult/h5wygimdsq9m4=;
	b=no2fmUgYfYs7Duxc5wHzfq/KX/lEwAlZbtmN0fLiZ8MkomeJAQEf6XoEgYr8r+X2+DchcI
	Db2dxHWsyl9XY/VtPTuEjylfx/GzMyW1l9dS5o3fSGrmW3J1wHiENXk67TIqPb4RXGUFPu
	yBQOk5Q5bpILNrhRC39opMq5gaXKN5w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Akira Shimahara <akira215corp@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Wed, 29 Oct 2025 14:00:42 +0100
Message-ID: <20251029130045.70127-2-thorsten.blum@linux.dev>
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

Changes in v2:
- Fix buffer overflow instead of truncating the copy using strscpy()
- Parse buffer directly using simple_strtol() as suggested by David
- Update patch subject and description
- Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
---
 drivers/w1/slaves/w1_therm.c | 98 ++++++++++++------------------------
 1 file changed, 33 insertions(+), 65 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..046fa682d57d 100644
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
+	if (p == endp || *endp != ' ') {
+		dev_info(device, "%s: error parsing args %d\n",
+			 __func__, -EINVAL);
+		goto err;
 	}
-	strcpy(p_args, buf);
-
-	/* Split string using space char */
-	token = strsep(&p_args, " ");
-
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
+	/* Cast to short to eliminate out of range values */
 	tl = int_to_short(temp);
 
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
+	if (p == endp) {
+		dev_info(device, "%s: error parsing args %d\n",
+			 __func__, -EINVAL);
+		goto err;
 	}
-
-	/* Prepare to cast to short by eliminating out of range values */
+	/* Cast to short to eliminate out of range values */
 	th = int_to_short(temp);
 
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


