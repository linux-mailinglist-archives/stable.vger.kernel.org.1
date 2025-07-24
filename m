Return-Path: <stable+bounces-164618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F38B10DCD
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF4F5467D1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CE2E543E;
	Thu, 24 Jul 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJNUZb2M"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0F2E1741
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367850; cv=none; b=CwAkSB4DlFQWOj+gWRWdCU8iFX4zn63CGgjZCcVFUmprn9e1XMvlCgpc7DDONjqUjMcAfd7IAxJi2FjEc9ijtsSXHUL8xZWtKS1BixPioZCv6cqn8iRigcKl/mrA1ExnFy8QR+CP8eKsHJxSvCI9yLEL0nqwM7vpOGLUyOF8A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367850; c=relaxed/simple;
	bh=i1slLS6fKL6k/lJjpB1zEBUCWviGCPU4GQH5Mw9K1LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgTouUv0rEcXDFpVloAWZv0hr16MlmjztsGuWz3c9xJbUT5fXE3OpxADceqMTjA7qNOWFW2AjiDRAjl3S/95rZgGfWLxajYMxFCZfKUmSEbDZNOQ+l74Daz23PvPuMwSbgC5sVHwaR6Lk3ia00fuo1E0M80Al4n5gYgKl0Ss73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJNUZb2M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9iJ2w018177
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1/ClJdrWPfw
	KRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=; b=nJNUZb2MHMlazo/lHBTTkx7RVqD
	mKkM1XLOTUjLVxHwwO6ntu5k5NMLGeu3GfWfeExSsH4CoG18PYbY2sRQZwk6GepE
	kKJnegj1qnrJ9987J981svWV6MRgM5b4e7lhl0k3JWRT/0Jsiq74Mt0sZCIoFjoz
	WzunazjjNXLOQyIBbthmKudOX/0HTUd3oKj7vZgQOiexnSKaqCApet/I4mW4AXh7
	sJOhS0RpouMRpufAsY8vfP1N+Jkfgmx2iVB3rwgPS+2EazMnGYACZFEdT+/nr0Cw
	TXwOKZIkQ1w9XlFcueMIDTmmQENAQ9g9sJ6PbIXm5simWPnD8+deTD6gRRA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6u6s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:37:27 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-531566c838cso279436e0c.2
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367847; x=1753972647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ClJdrWPfwKRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=;
        b=Hr1Q5J7zcfTRd633Hm4jhh6FgSpw08YvjrCcDJV5QEETjdeCC2g/NtMC0VE7g2goUY
         BzzDKgf6uWdt5i8Fc6cSxxrzxXTWXGXlrJoQunMguSj+cZrxm3V+Gn6eGdyoF7fHeZBS
         B/lvyOmU2ejmUQMF0Vk3n2+ktxn5Sux5ptxupT6d0KwhjtCwg1qkQ/tMexHgbxF1Yu1q
         YDf9y7mZW4bsE9N6I1C3jO+y0K+cHKsRNMStO88WSQ9ktI2U1kux925Jn7wmEmqv6+JY
         9UkqbrmuIPXR56yU9HyLfL+Zb3s92In3G4SXodiN/Fho2E6SponA8qnf1jVp1OHk7oHU
         MNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSaxSh19OTgDsW5deEZVOzhAq95iA82Ynb3TjG8H4EFLWrl3MSzQ9+It9XbV9rLS6gJgDTdcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2r4vMfgKo56EJuMOXJ5Y0rxAikpXTw4bIy9+QkR39KXrINY6n
	muSbgu5jGuwTkgMxulzKfzGFW0vbR2WxSEUXqJusycECyt4g8EBZg9tBS18sd7euVtwlanc252E
	9LDAZBNKvz/qAcB7z3q+/qwFr8RhomJmNBI/8PYi5Jm2JPptnFgZBqEdcAWE5V+K9+Sg=
X-Gm-Gg: ASbGncvbjljuWomh3a5TzdPwRUNh3eJneN+nTbDu9Y7YbXQqPPxpsNWH6CAWUHhBBJf
	a4OFucO2JbdM2f0AgXQXzy5uhrRh8EXjBf+sZAbtGidO89DiO8bQu+q6x+RwGSy8JQfdqpjBtCH
	sPTNYXczwSnv6u+zeGSb1w3Hxflu+jDU5/2taGBgamk12hfidY00rh2ABFYLsZTx3P456mWKUNF
	nOD95QGmM0LZQv2k22ljxwys+BZnpZ49d21kBrn/pyBOdZHZsGijq0bGp6uCWy6Li8UY0X8I3SW
	PY60hi9qXc91e6ubQjMQsaxtViRvIFy7XdmLkHThRfkrkJ3OcgtZznVs6e2GE5fBXQ==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835504e0c.9.1753367846766;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFC9QgriQyVRZksDj1oB9q4RdVIKez8rc+GtzAgwBhWM1KCgo2TsHI0fM64ZXC1O2Pn7YiEg==
X-Received: by 2002:a05:6122:509:b0:531:2f51:7676 with SMTP id 71dfb90a1353d-537af565921mr3835474e0c.9.1753367846304;
        Thu, 24 Jul 2025 07:37:26 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c495f02sm122856266b.2.2025.07.24.07.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:37:25 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Enrico Weigelt <info@metux.net>, Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:36:53 +0200
Message-ID: <20250724143718.5442-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
References: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68824528 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=x8YHxakxDffKOoiCecoA:9 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PHYhL8sYSn_KTpEP3oWgWhbkCIWpQccS
X-Proofpoint-GUID: PHYhL8sYSn_KTpEP3oWgWhbkCIWpQccS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfX0X27A4qnaVKX
 jlS7r1oFuLSq+ecenAmGrUFj2dV50hEQPRFvTkqA1Z718rquthjsNb029u0HWkFeTQDiTVGzkmD
 b1xQluj0CnSo3ZcFQJwOxyaI+EyXS+1/aUPmd/qbnCDkM5nGYz/vMbpAfnB28HsmqZQsdPWfd5G
 +3c0g9JPVP/n7lzzWjY3ugUWd4FQQvik77EYzohV/arxl586mM41WMb/h/UHHxnifJyk3qt/o1H
 0EjMoKgKy1MEdDNSV0v1/FKn/gyRoFYZtK9/7NC3ArJCa6FeT+nz+nVHy6j6zMb/ITP4T4P0whq
 KS2i2wAANbqJkLGA/SWPPsOhn+zBQdP4XoQQwAV1ycanY7k6sIP8o2arb/hW6pm0AxuWZB9i+/c
 Gy9WufjtvW8Eq0go4RbVeQMwUtIAlyKgTRaD0Ck7qPmfHVDbJaZnZcBPEHGLcv4BCqcneqMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240111

Quote from the virtio specification chapter 4.2.2.2:

"For the device-specific configuration space, the driver MUST use 8 bit
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and
64 bit wide fields."

Signed-off-by: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpio/gpio-virtio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 92b456475d89..07552611da98 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -527,7 +527,6 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
 
 static int virtio_gpio_probe(struct virtio_device *vdev)
 {
-	struct virtio_gpio_config config;
 	struct device *dev = &vdev->dev;
 	struct virtio_gpio *vgpio;
 	struct irq_chip *gpio_irq_chip;
@@ -540,9 +539,11 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
 		return -ENOMEM;
 
 	/* Read configuration */
-	virtio_cread_bytes(vdev, 0, &config, sizeof(config));
-	gpio_names_size = le32_to_cpu(config.gpio_names_size);
-	ngpio = le16_to_cpu(config.ngpio);
+	gpio_names_size =
+		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
+					      gpio_names_size));
+	ngpio =  virtio_cread16(vdev, offsetof(struct virtio_gpio_config,
+					       ngpio));
 	if (!ngpio) {
 		dev_err(dev, "Number of GPIOs can't be zero\n");
 		return -EINVAL;
-- 
2.43.0


