Return-Path: <stable+bounces-50386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF12090616C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA21F21498
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B43ECC;
	Thu, 13 Jun 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liRWR080"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E14DDB1
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243580; cv=none; b=qxJ78Yh30tfYo6gKBWAwWQGQwQReDQ6AKSWKtvc29Q0U0LD6QpX4IMy3+iDpAE9kLu/ProbTgvSAkpwnBdZvkHEPvg8lNteEIW/WZOtsMps3BH5Dl7oiWl7aEg2j5I8VTAhqA0aZeyTuidNHlkIAtlZMJK2ysYMf7hn6sVCEOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243580; c=relaxed/simple;
	bh=lFKIBuNPAWyP9QpvcbMLfmJjA2umK3O2efbF9HC4t30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PGs1wL0UnCW+PT83/1kXbC7Vm0Qa/htGc/aLLVDrzGUPrxECh1Kr8uXnOdAQN4NWRBxvlvHNEeQMIpp9wPnXbIaZUj8ow/wbuR9Qn1/FJMwHgiyIBGZLVBsV69yz1iHmNfZzPhdRl9k+FS+0QIZbJ6DNs6hSNOfuXMGf9gBaL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liRWR080; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955ddc6516so30677485a.1
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718243577; x=1718848377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFMKGSvdsYtTlGRrYzhuhU5sW41WOS2IWDklr5KqOts=;
        b=liRWR080M5JLBJFFHCoX+9KV0KXI6f1af6e8Ctrby1EVYoz5eH5CdKKbpx9s4g6uvL
         0AJRo5CVLAgTyebuhJgJ35Etql/JafLUP0/SsnQ/AU7AYKhaobLzsB6RwePUyKrDkYMs
         buReUaJRk4hROdmCOiJa7GKqOXtuydXMRq0NN1cyiMndl7jxdmYvtH7ONo2AtNfMDM9f
         jNgxeBs2uYlvjobqJAXeLxuFmdynsf2dSLtgbrc9jNSYoONkiC1ltPpMwLiz4cAH+LxV
         2rIpD7E0VmNQuLowxUVSoJSjuoKs/Yk2yrriVpXnZ5SPYAnY856tGiWJTY1YMbI5fmZ+
         QWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243577; x=1718848377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFMKGSvdsYtTlGRrYzhuhU5sW41WOS2IWDklr5KqOts=;
        b=CftgPS3VwmWH0RQAxe6yjEihNaVFLTy65tladl8uV/B5M99DAqxpaSpcS9HjkEcUAa
         xzVB+vzB/Z2mm2NSnJMct2PUq2ZpH/z0yOuOnwIRnRRGud0PD0Z7FJhsM7PRoPreXCAH
         p/a51e/9V35ecvTvo0kcR0US0Nr0dbSnKo+F2ckKNLKpnXtWs3z3Y2X9ySdlbsDxquls
         xwkJart6rZx8ysQGhnLGQTtYlF2FqQfWPG4UMzLSPQ0481Fm4DfrX0EKvQ/hAj/cmd1C
         q78CvnCRG2e3WoNXIj9GXxfh/fITAuDABPIms+qtYFR9pJ87mgHagNqf21cSescieN4A
         B7Ow==
X-Gm-Message-State: AOJu0YycbIARTvPftSXRS9VY7MguNjOOIVLB6hK3uBjRa+TAppVLxQhq
	IhCWbjeDSxfx9CiemBXMcfCFO4viIuOlJPgu8sU5LHH/G7Q1k9X7jtHiUA==
X-Google-Smtp-Source: AGHT+IHoczToslYXwZrzlMFWHWpdTnfeGsAtXCuYV8wiQNxX5VugFdWIj9ubx15OqhH/kS9S0CkgnQ==
X-Received: by 2002:a05:620a:2586:b0:795:1eda:7f08 with SMTP id af79cd13be357-797f5dafda0mr383648985a.0.1718243577238;
        Wed, 12 Jun 2024 18:52:57 -0700 (PDT)
Received: from shine.lan (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacae6eesm12738985a.16.2024.06.12.18.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:52:56 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jason Andryuk <jandryuk@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: [PATCH v2] Input: try trimming too long modalias strings
Date: Wed, 12 Jun 2024 21:52:51 -0400
Message-Id: <20240613015251.88897-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ Apply to linux-5.15.y ]
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Built with 5.15 and 4.19.  Tested on 5.15.

Drop const from struct input_dev *id
Declare i outside loop:

drivers/input/input.c: In function ‘input_print_modalias_parts’:
drivers/input/input.c:1393:25: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
 1393 |                         for (int i = size - 1 - remainder - 3; i >= 0; i--) {
      |                         ^~~
---
 drivers/input/input.c | 105 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 5ca3f11d2d75..171f71bd4c2a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1360,19 +1360,19 @@ static int input_print_modalias_bits(char *buf, int size,
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
@@ -1381,8 +1381,49 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 
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
+			int i;
+			/*
+			 * We are guaranteed to have 'k' in the buffer, so
+			 * we need at least 3 additional bytes for storing
+			 * "+," in addition to the remainder.
+			 */
+			for (i = size - 1 - remainder - 3; i >= 0; i--) {
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
@@ -1398,12 +1439,25 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
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
@@ -1411,7 +1465,9 @@ static ssize_t input_dev_show_modalias(struct device *dev,
 	struct input_dev *id = to_input_dev(dev);
 	ssize_t len;
 
-	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
+	len = input_print_modalias(buf, PAGE_SIZE, id);
+	if (len < PAGE_SIZE - 2)
+		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	return min_t(int, len, PAGE_SIZE);
 }
@@ -1623,6 +1679,23 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
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
@@ -1632,9 +1705,11 @@ static int input_add_uevent_modalias_var(struct kobj_uevent_env *env,
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


