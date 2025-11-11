Return-Path: <stable+bounces-194535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19AC4FBCA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 21:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2108234D323
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8F22DFB8;
	Tue, 11 Nov 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BvKDE/yg"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09233D6FE
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893934; cv=none; b=CO+AmB/aiU43IBEzBxKW4nEXUXxaS98fYyijGldFMzAib7oEQftWH0+TXIfvqcqsX+VCTjfsAMBtJmU2koOwoD/5bxVgaSwbC12s46jPA2kYBjuBdzRIuh8vJFaTik3H6EqAayBCci2baXaiR5BAPgivL3HcQqVcnk6h6B+aQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893934; c=relaxed/simple;
	bh=KOxvBf3xtKRfyDsHFKclQyBpBw5vaD5V/kUzc5jV4pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTEdxc52k0qaiy+wBwCaW4/paN0FFi56OwYZJKUyAn1psIopiH5YwMSodPDBXB6U6YJFbdjWJS4zyP5inz/OkTx4rQLFEcb/XDpiAlvx93F504advzrmaBcJTi+moTlhjKIpl14uIvkQuM4t6gVWXP761beb3kVrM1sHpIqvKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BvKDE/yg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762893920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GcDNxbMQFbHzyEo8vijDERUnbmPZ0QtGgqSGoFrXLA=;
	b=BvKDE/ygr+P7Xc5P5wUjAOFuPVKS6Zg2Dv70U77SYUefGEwosf9hoqN/HqQo3FpruemLjo
	pTiq/c6gDpR/8TbeQHfAIH6dcZmP6vnJiYiF73ME+g2xISwEHyG6P8j10pOJKymTJ4ZaeK
	vUfMq0WcAORWtxekTVCOF+budWCH+44=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Laight <david.laight.linux@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>,
	Akira Shimahara <akira215corp@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] w1: therm: Fix off-by-one buffer overflow in alarms_store
Date: Tue, 11 Nov 2025 21:44:18 +0100
Message-ID: <20251111204422.41993-2-thorsten.blum@linux.dev>
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

Fix this by parsing the 'buf' parameter directly using simple_strtoll()
without allocating any intermediate memory or string copying. This
removes the overflow while simplifying the code.

Cc: stable@vger.kernel.org
Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.

Changes in v4:
- Use simple_strtoll because kstrtoint also parses long long internally
- Return -ERANGE in addition to -EINVAL to match kstrtoint's behavior
- Remove any changes unrelated to fixing the buffer overflow (Krzysztof)
  while maintaining the same behavior and return values as before
- Link to v3: https://lore.kernel.org/lkml/20251030155614.447905-1-thorsten.blum@linux.dev/

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
 drivers/w1/slaves/w1_therm.c | 64 ++++++++++++------------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..5707fa34e804 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1836,55 +1836,36 @@ static ssize_t alarms_store(struct device *device,
 	struct w1_slave *sl = dev_to_w1_slave(device);
 	struct therm_info info;
 	u8 new_config_register[3];	/* array of data to be written */
-	int temp, ret;
-	char *token = NULL;
+	long long temp;
+	int ret = 0;
 	s8 tl, th;	/* 1 byte per value + temp ring order */
-	char *p_args, *orig;
-
-	p_args = orig = kmalloc(size, GFP_KERNEL);
-	/* Safe string copys as buf is const */
-	if (!p_args) {
-		dev_warn(device,
-			"%s: error unable to allocate memory %d\n",
-			__func__, -ENOMEM);
-		return size;
-	}
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
+	const char *p = buf;
+	char *endp;
+
+	temp = simple_strtoll(p, &endp, 10);
+	if (p == endp || *endp != ' ')
+		ret = -EINVAL;
+	else if (temp < INT_MIN || temp > INT_MAX)
+		ret = -ERANGE;
 	if (ret) {
 		dev_info(device,
 			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
+		goto err;
 	}
 
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
+	p = endp + 1;
+	temp = simple_strtoll(p, &endp, 10);
+	if (p == endp)
+		ret = -EINVAL;
+	else if (temp < INT_MIN || temp > INT_MAX)
+		ret = -ERANGE;
 	if (ret) {
 		dev_info(device,
 			"%s: error parsing args %d\n", __func__, ret);
-		goto free_m;
+		goto err;
 	}
-
 	/* Prepare to cast to short by eliminating out of range values */
 	th = int_to_short(temp);
 
@@ -1905,7 +1886,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: error reading from the slave device %d\n",
 			__func__, ret);
-		goto free_m;
+		goto err;
 	}
 
 	/* Write data in the device RAM */
@@ -1913,7 +1894,7 @@ static ssize_t alarms_store(struct device *device,
 		dev_info(device,
 			"%s: Device not supported by the driver %d\n",
 			__func__, -ENODEV);
-		goto free_m;
+		goto err;
 	}
 
 	ret = SLAVE_SPECIFIC_FUNC(sl)->write_data(sl, new_config_register);
@@ -1922,10 +1903,7 @@ static ssize_t alarms_store(struct device *device,
 			"%s: error writing to the slave device %d\n",
 			__func__, ret);
 
-free_m:
-	/* free allocated memory */
-	kfree(orig);
-
+err:
 	return size;
 }
 
-- 
2.51.1


