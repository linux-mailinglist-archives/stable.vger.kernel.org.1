Return-Path: <stable+bounces-200806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BFCCB67A4
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F4130141F6
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139E2D23B9;
	Thu, 11 Dec 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+NwtgGw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XrrYMaf7"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277926FA50
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471055; cv=none; b=GhmSjiPVvJgoZCWxRNxewgkvq1/zRte98ylMCdFIr6n9oUbfgAXtxNEI3V9RGhMxsMI5jDFPwsMmAMhdTtshv7u/msz+rCUouIv5nOOiFb6wobk9jLxGUnfv83N9ASkzRpFeDSSjROd8Vj1Lole23/A3UeZwHvRxdOn0WVzbTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471055; c=relaxed/simple;
	bh=1KKCNWalvP4XERNjZqQGDlfxLtbCqfhyXNgD5+uHboU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQhZlRoAtF469rPshXQvGhY/ymsSdnfKazvWj0zi1hBJGdnbpb8WejgmZxzNovuEryWgrty8wLJlRz+eeznK8o7lm3D302jRMlpFk1GMy51iZ1Umwf3zcMB69jL7r2FUlmtgNv+SmH+gAYxYclpea6cblBdmVrRPs3qXa2h0keQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+NwtgGw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XrrYMaf7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBEPArR1531675
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 16:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oj/4VBhEnuyy+rxbF2Z9gRHv86wmVq1FW4d
	SlNKTFCw=; b=f+NwtgGwgCRSnEGV1JTwYEux2qumiKWLMUpxAgPm5o6H49wvcd3
	sp3dXzUDfN6jxMn73i39purBp2Vg2uMvoyMaV6V3q7sH4DVuicVi1Xu3v0zVYfwZ
	X6Key46ODHD1k3Fz6MAGEhddbZZ36t0CcQX6B0BGiZVp8w+N6wdD20vkI0T5s0cH
	m3ERX+gyZQ9046Hsky1jL0WYv7KbRRO9Ot4lSwaEe8/fBm56CnCtDyWOvZ4aGY5S
	RLR//iWr26G/nt4J7hVrsraSkTldsNK6FyG8yXixD2x5/SE0XqTvz3upShtDeWcW
	ONnWWw+5cKQ+HYL+O0oR6foEdeU3LgokMpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aygtfk5kc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 16:37:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edad69b4e8so4768351cf.1
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 08:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765471051; x=1766075851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oj/4VBhEnuyy+rxbF2Z9gRHv86wmVq1FW4dSlNKTFCw=;
        b=XrrYMaf7F8PRuCNL8JVuz8Md0tAk+la16ouiwEP5TWnKKgmakkP2aKw1TJ5dp8LfaA
         5E6A1t4X+eF1E7+5N1i+7FWvaxq3+s83eA5vL9Rv2MlWfBjfOuARI8eoM53Cq4dvaf4X
         +VVIq1ivFnpYHN6GaBGQkneDXMFwUyLlbxFsbWLonr3/PYzQYwERYBGYkmE3uHUxxdyW
         mrUCi/gYb0NZWvEmCotk4BU1Xb+2vTpWOjEfwiqXzz3hlW5euvR8NakFA6q+GlJhX7Lc
         ZXWAJ6LCNO3C7fHOuLJkZ4ZQ8HSrzXL2niNft0FmLKMI2j0UD29pTRDHcSFND/u5oKXb
         QyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765471051; x=1766075851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj/4VBhEnuyy+rxbF2Z9gRHv86wmVq1FW4dSlNKTFCw=;
        b=dMHhieS7DG+vXiTMujwcWT0QrucfLYyfwIK/oUViEH95wzAQ6zmghmAdBOs9MEzgvM
         vSn6o8unLAcR8JLJxrWK2n7ma8/ZrxwL+G5J+MtAO6sBawD2nrAv9qIT7+o980sUs09l
         H/ndT6Gd7REJk8hJ4KBenKDMQNrv0KwXDHynshQRd+kb5bPsCWANwVTivADv8ZKGcZZd
         tMs0lX7KLLzdNZ9Oqw3LuG27hkobGj/rEmeBxE4bbmG+yQmckVtaNG2IKMdXKVcU9QM3
         iLwYGuh3WZkELZrv2UzqJTTb+1Dy+K4Cnjf2BsmphAx2hO/yE19Bf9cwXKlxyJBX5Eu9
         +okg==
X-Forwarded-Encrypted: i=1; AJvYcCXt44SN/m1c4MHfQ9zmUyNy0bMDCNwEv89kk4dBF2adh9EO674OKi9Jtr0YdC4T7MkkeP/YKE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0+2paQrRruSHBvoGUIlqgS53731KY35xFiakV+MYSO3VaAqE
	YjI+RcJVVn04FEN6zon+9/F1u4QZLjhCDZMQt96Akg7SM92ZoNkaLbT/2VRkyuy9NqJujS6snZJ
	Ph8qe0ohfirFPvI6FCxi+lh8zGybXjS3O0nTeTn7HCyay9+g6dsttVapmg8AW8TNxKqc=
X-Gm-Gg: AY/fxX7tXnUdn1Eo8bePJI7hqHRMbcQrCUrqoM5t9PnkDFqDJsxhisj159doXXiOGk7
	6ymPeKEe8QtilQDZSJTRtkx8iRsI+LUTWp8Scx4rMHj1mpzz1Jz1yBh99JFZ9893+xM0D1/g1ix
	EoWkyOnqAdyBXFPcZchMF0q9Q0fxwyuwFYYpde4lLY1kV5YQ0q8JkqCYk/QNQBOE82kXm8Tu9Ry
	gxWUEnM1Ctr2VChbLihAdewHaBzkRuBC/XQwIoqPZ4Hr9nfMp3ex9hBHBcyS88LzooGhGtdbevx
	sqizLpa/jAuSQbAYw1fbLQ+jEKZ+/0+jOvzhldSr7QM+/3QrDCvn6kv+O3OTQo/eNNC5tRsBWZh
	g/sUF8Y6fiZB5y2RKScWtI8GNSmLaI86Z2eEwkaoLptHd+IyPVz/DXsiJJCgoewfTCFEhXTpJtP
	tmQfyhMys+9UZojapSXBUn+dSV
X-Received: by 2002:ac8:5fcd:0:b0:4ed:a2dc:9e51 with SMTP id d75a77b69052e-4f1bfc359d0mr34664991cf.21.1765471050948;
        Thu, 11 Dec 2025 08:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENr4Swyxte5JX8Dsfr/N4PeCSOX9s1g8MZ+We5bhkOH6HvJgBK0aXo1Yi/w+V5E86bl9HRjw==
X-Received: by 2002:ac8:5fcd:0:b0:4ed:a2dc:9e51 with SMTP id d75a77b69052e-4f1bfc359d0mr34664501cf.21.1765471050471;
        Thu, 11 Dec 2025 08:37:30 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820516e9sm2877065a12.10.2025.12.11.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 08:37:28 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH] leds: led-class: Only Add LED to leds_list when it is fully ready
Date: Thu, 11 Dec 2025 17:37:27 +0100
Message-ID: <20251211163727.366441-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=At7jHe9P c=1 sm=1 tr=0 ts=693af34c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=zz-1Wuj_SYMfJuCV:21 a=xqWC_Br6kY4A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Jy_3jkUqb48WmY1pi68A:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: W0HZAfiifi_qDMuD1tM0AHj5qpy_I7l1
X-Proofpoint-GUID: W0HZAfiifi_qDMuD1tM0AHj5qpy_I7l1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzMCBTYWx0ZWRfX6LELjIedU8xJ
 wdvO9bQ6pdSQL0cLoBtwp0LuT+jtkbSPUtLSZaW0NXkTxg88q6w7G9Xs6bBDVqwsz8ncGM9ChXi
 ifM9YN5es6qW6GV7lWh9YfOQa1pXwRBhlfvELc8jb9lhQKnc3/zCRJq7dtoxuoool7tenf3+0aJ
 jVNU3jWPcKLkbKVkJVdS5UVkxygWvFwkhUht5n0H8ARAiVZz6WKr9Y4OgNYG3l6czFlVbdspm0y
 qT9Why49WLBQggEoy/pzq+WXT0gKEIHMsv1dATKe1uyespNPeym4IiSCogc04Z8+OXLH/Pn1kTP
 7nkIPASKm3gEruLNtX+u1FGR9OMlQCVUI6xo3xKFNZlkJ925ryrbBkVuDMNEF5Y1bAL+khhVy8G
 herzI5ZrLczTh9G31x03EyNKsVh4aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110130

Before this change the LED was added to leds_list before led_init_core()
gets called adding it the list before led_classdev.set_brightness_work gets
initialized.

This leaves a window where led_trigger_register() of a LED's default
trigger will call led_trigger_set() which calls led_set_brightness()
which in turn will end up queueing the *uninitialized*
led_classdev.set_brightness_work.

This race gets hit by the lenovo-thinkpad-t14s EC driver which registers
2 LEDs with a default trigger provided by snd_ctl_led.ko in quick
succession. The first led_classdev_register() causes an async modprobe of
snd_ctl_led to run and that async modprobe manages to exactly hit
the window where the second LED is on the leds_list without led_init_core()
being called for it, resulting in:

 ------------[ cut here ]------------
 WARNING: CPU: 11 PID: 5608 at kernel/workqueue.c:4234 __flush_work+0x344/0x390
 Hardware name: LENOVO 21N2S01F0B/21N2S01F0B, BIOS N42ET93W (2.23 ) 09/01/2025
 ...
 Call trace:
  __flush_work+0x344/0x390 (P)
  flush_work+0x2c/0x50
  led_trigger_set+0x1c8/0x340
  led_trigger_register+0x17c/0x1c0
  led_trigger_register_simple+0x84/0xe8
  snd_ctl_led_init+0x40/0xf88 [snd_ctl_led]
  do_one_initcall+0x5c/0x318
  do_init_module+0x9c/0x2b8
  load_module+0x7e0/0x998

Close the race window by moving the adding of the LED to leds_list to
after the led_init_core() call.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Note no Fixes tag as this problem has been around for a long long time,
so I could not really find a good commit for the Fixes tag.
---
 drivers/leds/led-class.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index f3faf37f9a08..6b9fa060c3a1 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -560,11 +560,6 @@ int led_classdev_register_ext(struct device *parent,
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
 	led_cdev->brightness_hw_changed = -1;
 #endif
-	/* add to the list of leds */
-	down_write(&leds_list_lock);
-	list_add_tail(&led_cdev->node, &leds_list);
-	up_write(&leds_list_lock);
-
 	if (!led_cdev->max_brightness)
 		led_cdev->max_brightness = LED_FULL;
 
@@ -574,6 +569,11 @@ int led_classdev_register_ext(struct device *parent,
 
 	led_init_core(led_cdev);
 
+	/* add to the list of leds */
+	down_write(&leds_list_lock);
+	list_add_tail(&led_cdev->node, &leds_list);
+	up_write(&leds_list_lock);
+
 #ifdef CONFIG_LEDS_TRIGGERS
 	led_trigger_set_default(led_cdev);
 #endif
-- 
2.52.0


