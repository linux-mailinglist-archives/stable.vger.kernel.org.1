Return-Path: <stable+bounces-215960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF0+DRnXjWng7wAAu9opvQ
	(envelope-from <stable+bounces-215960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:35:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B12712DD6E
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECCDB3012B73
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E4935B63D;
	Thu, 12 Feb 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EUPMhkJP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4eE6hNx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47B29B777
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903317; cv=none; b=NdvgJ7+IDc2vZrluDkfwCQ40yOrPDLvKY5PHX+WD11aJowPJxPFAHJWDlv2Yzja6lBFOVExJcxK8G4Xc23lIU4ACyB+W528YSsY0Xay6XUPRYZZpabSYY0Zj2jMaPel0ofGD2PjZaeizB2vSRowqIg1pGQahvrfgVWyLtIUb024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903317; c=relaxed/simple;
	bh=sOHPdiJV+WLttVq0TcWdwDT9t1CZym6vgPjhtivZVu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CyLs6O29Lh81DZ6vgadJqgIiF+X3Ok3CJqCQEVXRo7040O3EZxDVh0dIskLOAuyHRADNig6vehcV2hmYayXp4CXOv0bbR7PfjkhS/lAYs9LpGaDdCH4lJfSuVjYsnODqTOfAKeJoE47gIpA6XBWKGdsj1PEA9Y08vzbmCVhKewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EUPMhkJP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4eE6hNx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRguw3943708
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 13:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Qc2iAQ+caoPq5hxORFy3jvGkJgIpRAmga3z
	vPX/0hw0=; b=EUPMhkJPds9LD5o0sDkNpcwGNoHtEplWSL7Be1W6vLaHwRXyGgR
	vwgpdvdSPPell5j100AYvXGnc8G2+cLQfye5WIDSlLjKGUAjatGnWM+ya7pJ+0Z1
	wLlbc3ovIkitatTqeMurCFWH6huFmIdZJDkk3IL9k2di0kIFnfbs9DkhGSLWYfcW
	krJY/og3PygaCPrxNUFR75vukhwRDUzr+P+BxaBAVj3oXssNc2oGfCDGn7ZG63H5
	lbrsCow/089epv/Eqw9JcF5hsVdGxk5rs00KoS6GrsADMVfUSP1em5yoOfQh4+X5
	wPNZG0T8g9nZQD/qPkg3sZh9t12qlT5vgAA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c90d6ttdm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 13:35:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ca3e7722f1so632164285a.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 05:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770903313; x=1771508113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc2iAQ+caoPq5hxORFy3jvGkJgIpRAmga3zvPX/0hw0=;
        b=e4eE6hNxDhrdDyPwVEkkkkLBe+G8iw2IjPrKY8PEAOEgLjrLy/7LG1zNetHnH5voSw
         dcFd0gp7vNhyMkTfKsQXPu8d04KzWAdsvT2IxAfJoH0OWRm/GC7ZIMZhemRaeZfp/RAZ
         BY5+PtzfUbUHJbfXxrVRsApLgjjdaJSzGegBbhOCrLgXLLNcDCadh2l3/RFU9fj05+tu
         3WBZIejtUNrMEMHhdnHkXYDzeiqe1kU2ZfLd62TT8tA7ou+yl/rKzYZjMorjDNb16r6+
         MqNoLuykE73TAMz3SzBq5MoW/g1Qa1oGg31u73MYkw/dAwjwYoMM3Fq9nQpa6uSDI6RM
         O2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903313; x=1771508113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc2iAQ+caoPq5hxORFy3jvGkJgIpRAmga3zvPX/0hw0=;
        b=oMLKZLl8X7AqeV44n+glKoxr9GC0nTy82NylZom6k4Yz/+DBPMoaSEbpnIg1FUlg4E
         rlZ9LK38Z25+NcQpDq5ljXFH3esOuSrGDBNYaVDSAWhUM/cY2X6dPY+vC3V3EHbyDzvU
         7flCZOiRNvGD5faLsgLjPZD8oVwoBRhkWEH9MFWZOmirHeadeGvhYaD6y9DY0hV417C0
         BTXIiBXevfX34SGONaqdQsBNyKkViLHEJOuxYqoj9F4nkMfs/R+a254RBM0YqReqrjlr
         16rcxftVZ6875JL84RRzcCERdAqRreSDMV9u7kIeMZDYpAfL8MpoNByUONWBvquCxjpm
         C41w==
X-Forwarded-Encrypted: i=1; AJvYcCXDXaXnnl51OkdQST/f/1M30thkig5B7UNeyQc2Quc8pV0e/3yXhGL8rFYHz9YvoE6N9UJEUbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxYM9n0X20LKkNWN91sYKmONexwl0hiXDCzmUmQb2+QHI7X0M
	lCSEfEfpWGCkI+iExp50nGDSnrfUnK1qAivOUFRQCM/aY62hUjU1kEVS4yrxSOB9mhwQ5h7LTGg
	TSvEB/S0JSleuxg+Ph39cJ2kwtv1lE8OLDHN3V8+3s4BtdcLlWngj3vuth00=
X-Gm-Gg: AZuq6aIfkTctqCKScihiFTsZKonOKhAqO+lFFgewBNwIPwnpNWDyXxoPALLMm3XyQKi
	ZLamvkRrlTWTluQHveygiYVtLOl4BxtD2rc8dL3OkUB3PvxuvhnARqjEhlXciAA6fIki5iA5n7B
	LHzKjx+q1//DjqyqRkBxzfKssg1drBz61U4g/eOl+2Up5Aqwp32Hb2tUprBqidZShUpWoEKLveo
	G333dcc8NvPMUTMS8twQAOQnf40y8O6OyZD75VG8TnUesOgDQzdeYbzn2ShU2L3t3vOS+Ot3/Pf
	gSBbSE20zzZ3f1Of5LKihohRswkK0R/50PHrHnTM4ljQ7BrLb56VUVl3E2cuvQ0ywZZDi+5CptJ
	uoeZwyVCzS89DA/cdxYlDph3ub7sM/sS2NT4KyoY/V9mWVMCWxFo=
X-Received: by 2002:a05:620a:4588:b0:8a0:7561:93c7 with SMTP id af79cd13be357-8cb33b957e0mr305571785a.17.1770903313264;
        Thu, 12 Feb 2026 05:35:13 -0800 (PST)
X-Received: by 2002:a05:620a:4588:b0:8a0:7561:93c7 with SMTP id af79cd13be357-8cb33b957e0mr305567085a.17.1770903312749;
        Thu, 12 Feb 2026 05:35:12 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:ed37:7547:7b8b:6eb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65a3ceb1d6esm1805043a12.2.2026.02.12.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:35:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] gpio: sysfs: fix chip removal with GPIOs exported over sysfs
Date: Thu, 12 Feb 2026 14:35:05 +0100
Message-ID: <20260212133505.81516-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W-wSpObAaFNL1AehJcurCZDp64rE-RfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwMSBTYWx0ZWRfX4mj7hg19BKxd
 hr4sUyNq+/3zQNSnYsggKpo6qFympiyxuiK40AFzs0160ZriKJYfuzuecshwZWkGI0lEZ5j3tcW
 NEQGTGU423gri1anPvzBMKisZoVY961mAxqQjIz7DixTPiQccLuzelgeGhaoeIgkUU9DvYJRSkK
 G6E/RGepQ28UBgVh8ALHAyWbG/Yd7BN1C4V+5pKD+YvUYCf8ECmBzeyBdSjTAX9Wi53MrhjgM+P
 UXJgQ+2omDrdHTo0KhXzP6ThTJckNw5IQAJZe0Ghr42x5sGBKb7cwVrF3y+6VFgDe0Lx8wNzPfc
 WvuO/lcWI8rHXN0J5f4tuLI1+Gbz65SWug7Kum+QoC31eMy3ut4Aq2ARvFZ5BHbqEu+HQF7dQqQ
 HXP/d0DJ6oPq5qrL4netXsxfSyM3YqOdJqOdAQWgMMfg6Vw2P3r8LSTDHK4gJXpAMLPfy7JZm0M
 gbMSh6hiuskGqAkcpew==
X-Authority-Analysis: v=2.4 cv=ZaMQ98VA c=1 sm=1 tr=0 ts=698dd711 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CjzyuubHxb_HZ2d6ovcA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: W-wSpObAaFNL1AehJcurCZDp64rE-RfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B12712DD6E
X-Rspamd-Action: no action

Currently if we export a GPIO over sysfs and unbind the parent GPIO
controller, the exported attribute will remain under /sys/class/gpio
because once we remove the parent device, we can no longer associate the
descriptor with it in gpiod_unexport() and never drop the final
reference.

Rework the teardown code: provide an unlocked variant of
gpiod_unexport() and remove all exported GPIOs with the sysfs_lock taken
before unregistering the parent device itself. This is done to prevent
any new exports happening before we unregister the device completely.

Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-sysfs.c | 106 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index cd553acf3055e..d4a46a0a37d8f 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -919,63 +919,68 @@ int gpiod_export_link(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(gpiod_export_link);
 
-/**
- * gpiod_unexport - reverse effect of gpiod_export()
- * @desc: GPIO to make unavailable
- *
- * This is implicit on gpiod_free().
- */
-void gpiod_unexport(struct gpio_desc *desc)
+static void gpiod_unexport_unlocked(struct gpio_desc *desc)
 {
 	struct gpiod_data *tmp, *desc_data = NULL;
 	struct gpiodev_data *gdev_data;
 	struct gpio_device *gdev;
 
-	if (!desc) {
-		pr_warn("%s: invalid GPIO\n", __func__);
+	if (!test_bit(GPIOD_FLAG_EXPORT, &desc->flags))
 		return;
-	}
 
-	scoped_guard(mutex, &sysfs_lock) {
-		if (!test_bit(GPIOD_FLAG_EXPORT, &desc->flags))
-			return;
-
-		gdev = gpiod_to_gpio_device(desc);
-		gdev_data = gdev_get_data(gdev);
-		if (!gdev_data)
-			return;
+	gdev = gpiod_to_gpio_device(desc);
+	gdev_data = gdev_get_data(gdev);
+	if (!gdev_data)
+		return;
 
-		list_for_each_entry(tmp, &gdev_data->exported_lines, list) {
-			if (gpiod_is_equal(desc, tmp->desc)) {
-				desc_data = tmp;
-				break;
-			}
+	list_for_each_entry(tmp, &gdev_data->exported_lines, list) {
+		if (gpiod_is_equal(desc, tmp->desc)) {
+			desc_data = tmp;
+			break;
 		}
+	}
 
-		if (!desc_data)
-			return;
+	if (!desc_data)
+		return;
 
-		list_del(&desc_data->list);
-		clear_bit(GPIOD_FLAG_EXPORT, &desc->flags);
+	list_del(&desc_data->list);
+	clear_bit(GPIOD_FLAG_EXPORT, &desc->flags);
 #if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
-		sysfs_put(desc_data->value_kn);
-		device_unregister(desc_data->dev);
-
-		/*
-		 * Release irq after deregistration to prevent race with
-		 * edge_store.
-		 */
-		if (desc_data->irq_flags)
-			gpio_sysfs_free_irq(desc_data);
+	sysfs_put(desc_data->value_kn);
+	device_unregister(desc_data->dev);
+
+	/*
+	 * Release irq after deregistration to prevent race with
+	 * edge_store.
+	 */
+	if (desc_data->irq_flags)
+		gpio_sysfs_free_irq(desc_data);
 #endif /* CONFIG_GPIO_SYSFS_LEGACY */
 
-		sysfs_remove_groups(desc_data->parent,
-				    desc_data->chip_attr_groups);
-	}
+	sysfs_remove_groups(desc_data->parent,
+			    desc_data->chip_attr_groups);
 
 	mutex_destroy(&desc_data->mutex);
 	kfree(desc_data);
 }
+
+/**
+ * gpiod_unexport - reverse effect of gpiod_export()
+ * @desc: GPIO to make unavailable
+ *
+ * This is implicit on gpiod_free().
+ */
+void gpiod_unexport(struct gpio_desc *desc)
+{
+	if (!desc) {
+		pr_warn("%s: invalid GPIO\n", __func__);
+		return;
+	}
+
+	guard(mutex)(&sysfs_lock);
+
+	gpiod_unexport_unlocked(desc);
+}
 EXPORT_SYMBOL_GPL(gpiod_unexport);
 
 int gpiochip_sysfs_register(struct gpio_device *gdev)
@@ -1054,29 +1059,28 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	struct gpio_desc *desc;
 	struct gpio_chip *chip;
 
-	scoped_guard(mutex, &sysfs_lock) {
-		data = gdev_get_data(gdev);
-		if (!data)
-			return;
+	guard(mutex)(&sysfs_lock);
 
-#if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
-		device_unregister(data->cdev_base);
-#endif /* CONFIG_GPIO_SYSFS_LEGACY */
-		device_unregister(data->cdev_id);
-		kfree(data);
-	}
+	data = gdev_get_data(gdev);
+	if (!data)
+		return;
 
 	guard(srcu)(&gdev->srcu);
-
 	chip = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!chip)
 		return;
 
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, GPIOD_FLAG_SYSFS) {
-		gpiod_unexport(desc);
+		gpiod_unexport_unlocked(desc);
 		gpiod_free(desc);
 	}
+
+#if IS_ENABLED(CONFIG_GPIO_SYSFS_LEGACY)
+	device_unregister(data->cdev_base);
+#endif /* CONFIG_GPIO_SYSFS_LEGACY */
+	device_unregister(data->cdev_id);
+	kfree(data);
 }
 
 /*
-- 
2.47.3


