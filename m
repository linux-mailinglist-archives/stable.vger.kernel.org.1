Return-Path: <stable+bounces-50385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E1906169
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A622830E8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EE168D0;
	Thu, 13 Jun 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ/hEauA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3358C8F77
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243503; cv=none; b=gSpP9R51bvZEgL05AGeza9GFLdLyMwTHJOvy/iaCIuGgRirDz6IojxrfI96d/rglr73wD9KWVRL7agTJsRE1qYALbofrJczQ1WRplu+XArBKRl/+k1+0760tixOJOuTXB3v8PhsGb+p67LBqqfdN37CcMuIVVqTeDWL6fw232vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243503; c=relaxed/simple;
	bh=qEubJKvXMLcwkrM7mimXyKK/CFDD8m5IpHuITAxK8iA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q0Z8WdbYFQNaeRuigp0z3Q3+FF2RprIHToyTH4Lcq7ZgKpK5WtnrRTeOaRqD2Hd7AB6Q1jyXo/7E435JtsdaJpg0H9VqP8F+jW7TGP+g/1PuMu7xdNINuyv3Is0p8M9K2+eMjfE82Aqf3/E0xcDj7GpzhfL/2Y3uUwlfRGpvy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ/hEauA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b08d661dbaso15010606d6.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718243500; x=1718848300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HptZDVuHPu/MRh/sktqVtDdJDkpI+3im6Bipv302Q0=;
        b=kZ/hEauAccq67XM/Wz2sw9/OcSzGeyDMGG/Nh2EB00On5LzNRwX6yujh40rZjgz1Co
         hFj+pI3L2TIwaJUfOYJ8lnY27JD8ZPAGHdTzfFbQG6Z2U2ZrEX4k8ZVObKCNi9Cxl9F4
         05tEpNv0rwuS5HQJenpCvzrt//CNMl9Jes1WgoFC9YmATXDUrZ1WJ6bHFZ7DK/AQHrqe
         hkb6iWm3uQ/h1HfW0sqg2agN7uOK1qo4N34PXwdra+xH8ZQ/CNc4c03TFkR13QOrxw7p
         bhzA/wFOq/0zPombknzUpeNvWKoLmcuO6s/QdlltlIg/Jy4S7k8qUh1aPJ9C1q2Hbw0J
         sAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243500; x=1718848300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HptZDVuHPu/MRh/sktqVtDdJDkpI+3im6Bipv302Q0=;
        b=v1yqY9gpMO8DRWfYKGO9Huy1yrFrAYCT0EYmm9IOE3eKjA2Lrsh5vXygxxum5mKwsi
         bLAk7plCGFoY95PjSP4iYEj7mFsJdIZjyBDIxj4FJIdzAkocOyLEXjeXoSqRm8gLCi7I
         nBSisqL2ychhs9aqlcxTSMxz1tC3yDgoPyRgRkw+jXU3Z3lHp5GoI6pQAAJgwtIU3lpQ
         +1CbMaiFkvwIfGT9d4cf2zmxAE8P3/EsURYZgEzzB+O0pnzYTNKwgOUZJPfhdTeUdHI8
         iL7igXStL9pvfepQ04GHioq/bSjru9CYhdsqr0u6zbCKn+lXZU1NnqI1QAk25k7Oc2DK
         55FQ==
X-Gm-Message-State: AOJu0YxWzW1c0kMbeTnm716cEuxmgWtVpzDcC4a/Yro9ttHV4zcwIvua
	R8JGbyhXT/eNWk5jPmHq2DJP2lhTH93Qr6mHN9U5WX6bnqrD5zHa0bZcJg==
X-Google-Smtp-Source: AGHT+IGZPOmQay5YerqSG6P3gDdtZRSMlgL0ItkhYp9FmuGIIRHGEbpwyTu5JGHHTvvB8U0NZRWcPA==
X-Received: by 2002:ad4:5941:0:b0:6ad:8167:ac48 with SMTP id 6a1803df08f44-6b2a343c205mr27766826d6.24.1718243499941;
        Wed, 12 Jun 2024 18:51:39 -0700 (PDT)
Received: from shine.lan (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee1327sm1832076d6.118.2024.06.12.18.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:51:39 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jason Andryuk <jandryuk@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: [PATCH v2] Input: try trimming too long modalias strings
Date: Wed, 12 Jun 2024 21:50:58 -0400
Message-Id: <20240613015058.88646-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 0774d19038c496f0c3602fb505c43e1b2d8eed85 upstream.

If an input device declares too many capability bits then modalias
string for such device may become too long and not fit into uevent
buffer, resulting in failure of sending said uevent. This, in turn,
may prevent userspace from recognizing existence of such devices.

This is typically not a concern for real hardware devices as they have
limited number of keys, but happen with synthetic devices such as
ones created by xen-kbdfront driver, which creates devices as being
capable of delivering all possible keys, since it doesn't know what
keys the backend may produce.

To deal with such devices input core will attempt to trim key data,
in the hope that the rest of modalias string will fit in the given
buffer. When trimming key data it will indicate that it is not
complete by placing "+," sign, resulting in conversions like this:

old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
new: k71,72,73,74,78,7A,7B,7C,+,

This should allow existing udev rules continue to work with existing
devices, and will also allow writing more complex rules that would
recognize trimmed modalias and check input device characteristics by
other means (for example by parsing KEY= data in uevent or parsing
input device sysfs attributes).

Note that the driver core may try adding more uevent environment
variables once input core is done adding its own, so when forming
modalias we can not use the entire available buffer, so we reduce
it by somewhat an arbitrary amount (96 bytes).

Reported-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
Link: https://lore.kernel.org/r/ZjAWMQCJdrxZkvkB@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ Apply to linux-6.1.y ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
For 6.1 only.

Patch did not automatically apply to 6.1.y because
input_print_modalias_parts() does not have const on *id.

v2:
Remove const from input_print_modalias() and
input_print_modalias_parts()

Tested on 6.1.  5.15 and earlier need an additional fixup.

 drivers/input/input.c | 104 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 15 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8b6a922f8470..78be582b5766 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1374,19 +1374,19 @@ static int input_print_modalias_bits(char *buf, int size,
 				     char name, unsigned long *bm,
 				     unsigned int min_bit, unsigned int max_bit)
 {
-	int len = 0, i;
+	int bit = min_bit;
+	int len = 0;
 
 	len += snprintf(buf, max(size, 0), "%c", name);
-	for (i = min_bit; i < max_bit; i++)
-		if (bm[BIT_WORD(i)] & BIT_MASK(i))
-			len += snprintf(buf + len, max(size - len, 0), "%X,", i);
+	for_each_set_bit_from(bit, bm, max_bit)
+		len += snprintf(buf + len, max(size - len, 0), "%X,", bit);
 	return len;
 }
 
-static int input_print_modalias(char *buf, int size, struct input_dev *id,
-				int add_cr)
+static int input_print_modalias_parts(char *buf, int size, int full_len,
+				      struct input_dev *id)
 {
-	int len;
+	int len, klen, remainder, space;
 
 	len = snprintf(buf, max(size, 0),
 		       "input:b%04Xv%04Xp%04Xe%04X-",
@@ -1395,8 +1395,48 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 
 	len += input_print_modalias_bits(buf + len, size - len,
 				'e', id->evbit, 0, EV_MAX);
-	len += input_print_modalias_bits(buf + len, size - len,
+
+	/*
+	 * Calculate the remaining space in the buffer making sure we
+	 * have place for the terminating 0.
+	 */
+	space = max(size - (len + 1), 0);
+
+	klen = input_print_modalias_bits(buf + len, size - len,
 				'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	len += klen;
+
+	/*
+	 * If we have more data than we can fit in the buffer, check
+	 * if we can trim key data to fit in the rest. We will indicate
+	 * that key data is incomplete by adding "+" sign at the end, like
+	 * this: * "k1,2,3,45,+,".
+	 *
+	 * Note that we shortest key info (if present) is "k+," so we
+	 * can only try to trim if key data is longer than that.
+	 */
+	if (full_len && size < full_len + 1 && klen > 3) {
+		remainder = full_len - len;
+		/*
+		 * We can only trim if we have space for the remainder
+		 * and also for at least "k+," which is 3 more characters.
+		 */
+		if (remainder <= space - 3) {
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (int i = size - 1 - remainder - 3; i >= 0; i--) {
+				if (buf[i] == 'k' || buf[i] == ',') {
+					strcpy(buf + i + 1, "+,");
+					len = i + 3; /* Not counting '\0' */
+					break;
+				}
+			}
+		}
+	}
+
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1412,12 +1452,25 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'w', id->swbit, 0, SW_MAX);
 
-	if (add_cr)
-		len += snprintf(buf + len, max(size - len, 0), "\n");
-
 	return len;
 }
 
+static int input_print_modalias(char *buf, int size, struct input_dev *id)
+{
+	int full_len;
+
+	/*
+	 * Printing is done in 2 passes: first one figures out total length
+	 * needed for the modalias string, second one will try to trim key
+	 * data in case when buffer is too small for the entire modalias.
+	 * If the buffer is too small regardless, it will fill as much as it
+	 * can (without trimming key data) into the buffer and leave it to
+	 * the caller to figure out what to do with the result.
+	 */
+	full_len = input_print_modalias_parts(NULL, 0, 0, id);
+	return input_print_modalias_parts(buf, size, full_len, id);
+}
+
 static ssize_t input_dev_show_modalias(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -1425,7 +1478,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1637,6 +1692,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 	return 0;
 }
 
+/*
+ * This is a pretty gross hack. When building uevent data the driver core
+ * may try adding more environment variables to kobj_uevent_env without
+ * telling us, so we have no idea how much of the buffer we can use to
+ * avoid overflows/-ENOMEM elsewhere. To work around this let's artificially
+ * reduce amount of memory we will use for the modalias environment variable.
+ *
+ * The potential additions are:
+ *
+ * SEQNUM=18446744073709551615 - (%llu - 28 bytes)
+ * HOME=/ (6 bytes)
+ * PATH=/sbin:/bin:/usr/sbin:/usr/bin (34 bytes)
+ *
+ * 68 bytes total. Allow extra buffer - 96 bytes
+ */
+#define UEVENT_ENV_EXTRA_LEN	96
+
 static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 					 struct input_dev *dev)
 {
@@ -1646,9 +1718,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
 		return -ENOMEM;
 
 	len = input_print_modalias(&env->buf[env->buflen - 1],
-				   sizeof(env->buf) - env->buflen,
-				   dev, 0);
-	if (len >= (sizeof(env->buf) - env->buflen))
+				   (int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN,
+				   dev);
+	if (len >= ((int)sizeof(env->buf) - env->buflen -
+					UEVENT_ENV_EXTRA_LEN))
 		return -ENOMEM;
 
 	env->buflen += len;
-- 
2.40.1


