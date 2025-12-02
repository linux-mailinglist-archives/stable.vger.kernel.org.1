Return-Path: <stable+bounces-198056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55753C9AAD8
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 09:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C3043464E2
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCC3093CA;
	Tue,  2 Dec 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMygjjZH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A53093C3
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663991; cv=none; b=t7Enqek/OrQy2+F3opvB3cYV+jc+7kvSHSiQrx1RlDs3UKE5kvJM9OVrUpRJskI5q8BC7loqIkvTahTSSn4JGUDuBwgKL+c51jdQtsyPmKNfMkSzdBJgVrZ8vODp4yVTqL8b7AXod1aSbcDyod1kVNTorMgH6RAU+oGSM37ykGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663991; c=relaxed/simple;
	bh=LT9B6KFU1tawj/GEAbgaQSm0hh1wSRLQ7Jo/3+1hIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwxIscRtj4O+e+8SIOs/GkKwUmaQpvIIxLrGH3gqdbN1b0IUc489o7XpNErcstOb2+SM0k47vPI2E1GNuv4J2pAvXF0EJTEfR1zjqnepyVfN1IWE85z6SzgunajlmSq9GcB++8eW66k7WLhf05BT2Kzdcmq45klG5LJaLypLMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMygjjZH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7baf61be569so6150885b3a.3
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 00:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764663989; x=1765268789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MYqn7PCKd9tNf2P3p4f1Uhidh+TUxYe1LwNSbY2PG4=;
        b=BMygjjZHGkMfw/cqvpdozG/yyIraIf1isgrdo7c9y5skMEbwQYtlSphc6Mzdgq4aYi
         L7b99oCqIEnzXsKnHBNbf4FfvOghL/OSp6c/ZeHEWEGehZEiOh+DIO5JzCTG0Af/AKxZ
         d9jGBSeV0ojcT66I5MRZqhkgR1jczGF+ukyBr9BJnKM31XNScQ0SGthjnBiU/wbcFDAQ
         1XUDw0ENYwMW1137gsD5B8ElDL0b2/lGJrBoxJcaV6gs5VUDlh5UcI8nny3+05WHpyVS
         zvKDiNBz+uLQGK+bVSbeuq3QmJX48B4d1SnkwUS5+iAP1eJ105QO+ueRhTAZLpn5T4Rs
         hxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764663989; x=1765268789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MYqn7PCKd9tNf2P3p4f1Uhidh+TUxYe1LwNSbY2PG4=;
        b=UfjrpVY4xTQdwkKLIrBZ103Yng5SLfW1VWuobkKKfT4iC2yGYpYcJoQn0iamkUP7RL
         i6CWS3B9xsMXiUPtSR7wipd3aHGiVxk20c3y7HRVlcjEtu/vFZuJRSoHDUSa81slQfX2
         lkhRXvvJlitqbL/F3KCsg8LPi1KF5jjQSIW9w0/3MGt6XzoNjmAUNB/6zZ+7sOrc1Etw
         n3F92MMJIALD4XkR9qITZTDYdvDDRi1dKz3724YLWHOAnhSVQB//+RtBa5wIoQuHFB3D
         v/0fJdgRu/2UM8d9sgh5WvJakeZ5G0Qu9Vt4eZ2J2BwDniltb7aCUq7cgGEpHeuXQCQU
         n40A==
X-Forwarded-Encrypted: i=1; AJvYcCWiFpAp67+fxPSjpwKLt+UtJWyODPYTazHzxv4Xlcob/9ElQ3DQ7TxSuD3gRSZfWD+6Cd++xbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyai+hpnlbgpN9N3nzuj+RwvkfiBcRKAEP/EEClgmZHBAhq7jes
	4Lcx7Sp0GgShq7TeWLAwPQv2eUndkhujwERtpO/2J0AgNX0fnjcKXETz
X-Gm-Gg: ASbGncsEhOsJH1jo6Jn1YwwrcOoJ1dT2N2ELJmHVlorg/W153v5R8r2Sozv0VYzbLsn
	2pyHXOXzGzJHGoe876a+2Y/YgRlZKPN7xTJhNCeYHYq4Vc3h8X89hFWSkOjUEklgLmtNIGu7PXE
	KRi7lbJLb6T5VyqOgCpSLBGOsVD8VYwSJFMz3FwfHa65WLhrFg63T3oWLnEsMUlKKPtcWMk2lbP
	5x7y1agnIhRK4qh0KnkpEQmxXFOHVNb3vVeRAmlduvSkQj4wfFRaVRWyBWCsxWxqfLbAkZqKNLx
	BQuR7kMeHgI4da+DOtnjUqccXIiBqysY38jMhTFb16UOKBYlo5yNmGbOYsVZsVVt9/qbil+Kc4x
	mv8kqZ1N/eZCTOBZUmzGZFRYzKzcgzyjgG7a8A2w65pnVV794x0FglOnw+S1fLRSi/vaIcS5Rg4
	H+ZHYPxykmP4GwAeE7gzkxzJqelJoqy1nMoNy1UPRhU1MBw2rnXyLEt8Tz8AmguwpixUnlZ8/UR
	GRxXsN6UV4BKZoYcKYZTf7w
X-Google-Smtp-Source: AGHT+IGkl5Lg3iWuR3s4QGJ/QIlgUH+jr7X7bepUoNA8wSggnBvRTX3k73OZCErR8tKPjfarQAd4fw==
X-Received: by 2002:a05:6a20:3d83:b0:347:6c59:c728 with SMTP id adf61e73a8af0-36150e2c726mr45457791637.8.1764663988785;
        Tue, 02 Dec 2025 00:26:28 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (14.250.194.35.bc.googleusercontent.com. [35.194.250.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b68367sm16268272b3a.12.2025.12.02.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:26:28 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	gregkh@linuxfoundation.org,
	mathieu.poirier@linaro.org,
	leo.yan@arm.com,
	Al.Grant@arm.com,
	jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	ericchancf@google.com,
	milesjiang@google.com,
	nickpan@google.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
Date: Tue,  2 Dec 2025 08:26:13 +0000
Message-ID: <20251202082613.3265761-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cntr_val_show() function was intended to print the values of all
counters using a loop. However, due to a buffer overwrite issue with
sprintf(), it effectively only displayed the value of the last counter.

The companion function, cntr_val_store(), allows users to modify a
specific counter selected by 'cntr_idx'. To maintain consistency
between read and write operations and to align with the ETM4x driver
behavior, modify cntr_val_show() to report only the value of the
currently selected counter.

This change removes the loop and the "counter %d:" prefix, printing
only the hexadecimal value. It also adopts sysfs_emit() for standard
sysfs output formatting.

Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build test only.

Changes in v3:
- Switch format specifier to %#x to include the 0x prefix.
- Add Cc stable

v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/

 .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 762109307b86..b3c67e96a82a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
 static ssize_t cntr_val_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int i, ret = 0;
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
 	if (!coresight_get_mode(drvdata->csdev)) {
 		spin_lock(&drvdata->spinlock);
-		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
-				       i, config->cntr_val[i]);
+		val = config->cntr_val[config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
-		return ret;
-	}
-
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
+	} else {
+		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
 	}
 
-	return ret;
+	return sysfs_emit(buf, "%#x\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,
-- 
2.52.0.158.g65b55ccf14-goog


