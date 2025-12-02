Return-Path: <stable+bounces-198122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27173C9C778
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 18:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54E13A40B2
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE32C21D4;
	Tue,  2 Dec 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8YYLq0C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE02C11DF
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697812; cv=none; b=bJQ0U75w+wlIivzUBSLOS12B74hNCKwidr9mn303gWSDpSxru3qLn6e+HOpfrkdWDjIW7BMlhpvTc15hU3hmnZhlcASAEX1PmwbyjORqM6sVrxBf0VCGEPPsl/dipBlm3gz9EmGtWQd9u6GMrt6kHt/tURIR+yxs71Nl9Yqxx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697812; c=relaxed/simple;
	bh=fGgGupyGdkiAbJJxOHlB00nj3L0BF35EE8H1fBe8JsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASJzRJGChw6VvS5LGz9Wo/0iDfB6YhMpqThDx7px2k/0EvwLp/Ci8kCZ1s2VuOOgtfyVqwIU7rjNHjcSdYE0BfkwwjYXwEkx4AFxOoUX13kvPPBojKN3XFp0MdeUUP5EPWFiSWa2b+Wad2cXycSWvenrtB+XUIUsoNb+OLwRQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8YYLq0C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so6212616b3a.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764697810; x=1765302610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgAz6fNpn7JpYrJAea4NdVMHK+GyJh0YTa0tvhxNdVs=;
        b=Z8YYLq0CLoc+6wduod4C7NbVvGiCzB919WYxQTVmYkqDdPJrA7pLhhk00TDOSDLSFW
         8Woq/EimnsFFhFhaIYw7xDAiTkwij0UhBF1oQd3oSe4jdFf5ceNBUTCxEyinAwhSzI2d
         NqaDUgxWJUPLuKo8BZOrMQx0GH7pi3hE4lgzoRrnfn2jDZd8jtG+r99vtteVusoGQRJV
         5wysOoID2D2Brv2Y9zTjE+AvMFHQWAsPhhot6RR/TX4RMJTGAr5wG9sn4XeYaew2a++o
         BW1ns1aQHsMKzmxafrKGzAa8ogP3ysm5v4lYmJ6D3gHVaKY1rCdo76/TlDQ+VhipfYF2
         nkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697810; x=1765302610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgAz6fNpn7JpYrJAea4NdVMHK+GyJh0YTa0tvhxNdVs=;
        b=NCPXf184te162wdq27vVHdEmqDVqGN8kGbvfOOAgPEJ/ZVDUaDZz2Z7mBJ06UPzwj6
         aRx2yFmxvZutzUQEEonXAy54GSR8gyVYrUHr4mp/7wg9DXWlz/rsQzUVaMFLu+NZgwVN
         6fR0x+fkN53YoCRwcs+L2t5RqPe9MyDQNYd3oVxYoq8dE0R9FPpmlOUtc++FU+Sp5Fho
         zPdrCcCsXzjw7w6O2FJ+UcSkDBQzVh04RcKIelrTFyGN6ZPh7SESm5sgiKhCJF8pLdnK
         k5PRDzZbMMOuPn2hNnJ0gexWoGVHjHPqdRfeXBa7g3j372TZFP+zo1gUFHveK+Rd87M8
         khsg==
X-Forwarded-Encrypted: i=1; AJvYcCWLOWTUk+v9F3QF/7P7KsY9xt1cIjgjyLTp8Yaqd8fin0HfNxnutDZkw6Ofwc9uAWzfKiJxI7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7bRfb5mBphAS7G/r0l2l92shAMfW+2q1nrDHGlW+tF0eLQNT
	DYcaBhXsrPSuWue+MoFVmr4wXCgqsXUAu5oYX7g2iLwPIss8lfbC+l4vFPc4iSR3
X-Gm-Gg: ASbGncvlYmuZ2QJ7eXZX4Wkka17IeFeXdGmGTfkpbLELHH3xNKs0BNgTk3cmQd2F8EC
	7Fy7fqb/8kqaj3tgIJwP2oCEsmjZPlHHfz8I1cQGRmoGtce597mE6mZo9eG35H5pCaMkEFmAuDB
	2Hhq7CuWWeQ0U4VJMCCsO2C2I1lzqlFJJaBCrCCO+8HWu+SyVFGleYew7QEwFhVjCXZD26urDbN
	m9txPdpIsMN1S+8LPt0LZj4zN7IC+92lMl0rlnc3MrGEnaDXS35fnDKET4zOQgdA8BdH1czdLlE
	HPjDmw50D759k1IqPvATemUYnFKQs0APuuUoOBeTCpXAJ45Rbu1lV3krzn9aZyuUnsdxMMkdSad
	N20rsqkaLYCH+U4z5/R1QMyobsYkrvIsGMlsRHzoggZvOzWhyV/Y6mPYCVJA2p2pOl5vSiVcXt2
	fjkTBhJC+FlwiWdpt9kAmGBHp79yZ7b8jHkXtz5oRgejOCIKQVC3b9Rn0esOi6+c+JIFWVtz6Xm
	Px5qZY0OMrjUDoQAFnS0Optzn4ZKymMYrDHxl1i4qF72yI+ZFFLHdmYcq7C
X-Google-Smtp-Source: AGHT+IGa8ZrBi4DESVwwOj/HbcYUlgQEUuY0LmUJKkeDLld+M3KAFoKpoFTN+IjT7Ot0d0aynbO53g==
X-Received: by 2002:a05:6a00:2309:b0:7ab:21ca:a3be with SMTP id d2e1a72fcca58-7df918bba97mr91507b3a.12.1764697809906;
        Tue, 02 Dec 2025 09:50:09 -0800 (PST)
Received: from 2045D.localdomain (191.sub-75-229-198.myvzw.com. [75.229.198.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm17487023b3a.50.2025.12.02.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:50:09 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rpmsg: core: fix race in driver_override_show() and use core helper
Date: Wed,  3 Dec 2025 01:49:48 +0800
Message-ID: <20251202174948.12693-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_override_show function reads the driver_override string
without holding the device_lock. However, the store function modifies
and frees the string while holding the device_lock. This creates a race
condition where the string can be freed by the store function while
being read by the show function, leading to a use-after-free.

To fix this, replace the rpmsg_string_attr macro with explicit show and
store functions. The new driver_override_store uses the standard
driver_set_override helper. Since the introduction of
driver_set_override, the comments in include/linux/rpmsg.h have stated
that this helper must be used to set or clear driver_override, but the
implementation was not updated until now.

Because driver_set_override modifies and frees the string while holding
the device_lock, the new driver_override_show now correctly holds the
device_lock during the read operation to prevent the race.

Additionally, since rpmsg_string_attr has only ever been used for
driver_override, removing the macro simplifies the code.

Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
I verified this with a stress test that continuously writes/reads the
attribute. It triggered KASAN and leaked bytes like a0 f4 81 9f a3 ff ff
(likely kernel pointers). Since driver_override is world-readable (0644),
this allows unprivileged users to leak kernel pointers and bypass KASLR.
Similar races were fixed in other buses (e.g., commits 9561475db680 and
91d44c1afc61). Currently, 9 of 11 buses handle this correctly; this patch
fixes one of the remaining two.
---
 drivers/rpmsg/rpmsg_core.c | 66 ++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5d661681a9b6..96964745065b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -352,50 +352,38 @@ field##_show(struct device *dev,					\
 }									\
 static DEVICE_ATTR_RO(field);
 
-#define rpmsg_string_attr(field, member)				\
-static ssize_t								\
-field##_store(struct device *dev, struct device_attribute *attr,	\
-	      const char *buf, size_t sz)				\
-{									\
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	const char *old;						\
-	char *new;							\
-									\
-	new = kstrndup(buf, sz, GFP_KERNEL);				\
-	if (!new)							\
-		return -ENOMEM;						\
-	new[strcspn(new, "\n")] = '\0';					\
-									\
-	device_lock(dev);						\
-	old = rpdev->member;						\
-	if (strlen(new)) {						\
-		rpdev->member = new;					\
-	} else {							\
-		kfree(new);						\
-		rpdev->member = NULL;					\
-	}								\
-	device_unlock(dev);						\
-									\
-	kfree(old);							\
-									\
-	return sz;							\
-}									\
-static ssize_t								\
-field##_show(struct device *dev,					\
-	     struct device_attribute *attr, char *buf)			\
-{									\
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-									\
-	return sprintf(buf, "%s\n", rpdev->member);			\
-}									\
-static DEVICE_ATTR_RW(field)
-
 /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
 rpmsg_show_attr(name, id.name, "%s\n");
 rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
-rpmsg_string_attr(driver_override, driver_override);
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	int ret;
+
+	ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
+	device_unlock(dev);
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
-- 
2.43.0


