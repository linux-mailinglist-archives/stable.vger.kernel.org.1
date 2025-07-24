Return-Path: <stable+bounces-164617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845EDB10DBE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B39617B4CC
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB42C15B4;
	Thu, 24 Jul 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKwvXGi2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD32E543A
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367764; cv=none; b=Z8nfYTBBXxsjuQA7WNXhBoEq3XkQLGuqmRFFoXAzx5qR97L2n5Lkv4Ga00M5BnBoQ7ot4CWKoU6wuSKbmbO7bcqjKtz8p1KF074SHAH9ETD89u6yDnxpj+X+kVDpVQ4PKCAvsbI6d0JZh1Mvk4EmadUGKk8j2LyyihiD88mg/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367764; c=relaxed/simple;
	bh=i1slLS6fKL6k/lJjpB1zEBUCWviGCPU4GQH5Mw9K1LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUfdD5wsmZ6qVJ8pYIick7QEiHPWBak5QBWy7V/C//WbNdQlR/KFLH+Hr+WxtBzVbBsV6CE7de30wi1dttwKDDEUjZWHLn0p3CkrWoKUU5UzcBCAWKzNJTSV7nS5unGgDkJfaXBbUwzGluMU/uePwZ+yodhls6sZiNGbph6NyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKwvXGi2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9swNu018153
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=1/ClJdrWPfw
	KRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=; b=ZKwvXGi2aiShTAHqMmAmlRid4JA
	ne4FCtwYPfxKza6gCZFAqbLS0tu1kGkBKndvSkCx+oUm29wBpNSWvjn1Gx7tWBIE
	icA+iHbbM+2V73n7jsnLwHNQQIOkcT2FYHZYoLXJeXNYi8wImwlOamPcErNtdTSc
	CGcWW8HxGW5P0OALQWlvJoOxX6TCfRm/U45ppSXjofsPRqzOKYI3YPSOg86yQsRB
	2sf7zJiJZU3V5thvXowI8Jza4grXLIre5rtRsl/GsKeVeMahW9IdLjpVsdQvWwPA
	Iejqc3K+Y9W2mv5p4tuhKr/4dxxK5jIY6+lDvrxEo3Z2d919IhGGK+f13Ow==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3euvt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:36:01 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5331c1d1692so294505e0c.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 07:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367760; x=1753972560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/ClJdrWPfwKRkRpbRRXkAMnaqMIpW6RqyjsVq8yU5M=;
        b=DOHeA2ILgTM4bct85htDYJgfv0h1KuVkuHvRHBuIPt5WUARqbBquz6H0afcKdjPpY+
         yu/AjlQt9jJJYCoFh4GxYpDcv1lRRJIhiOW9Xpip8pMa16yF7kaGwXuDZN2h36ekO8H5
         kd1fGVOUKgWzcWHfr3M/JZVe8e5F5U27aPzBcd4lHsKa0OutDrUmtuJ5g8/IgxmqQmdY
         oJOpwQgoFTb8AEr1jQA+skf0ylryR69fd7FuSoggSfMMZggeJHawIFwikmFYqN0Fsecr
         hdCu0bEPQRlDENMeP36GaqrWm4YuP8qxijmM0NHN8AmpkpxG3OLmr4UxyLifj1K2qJ6S
         6ylw==
X-Gm-Message-State: AOJu0YxXmw55enV9IulRxwA4YR+O+1L7AcE3ItqGBb/g/uDnzCXw5+za
	Dw+4mp3r5Yi8HQHZlVLLFoVll2wBySzLPUb+VpCQDs3TtA2PKRw/8bKmSvehawSDyAsNkbj51+e
	SZDgKK6yaNWPCeUhXq6nb7EHtLvcyBlsWLn5Q9G4ZZspSyMoqBqI0n+rDUQE=
X-Gm-Gg: ASbGncvshZ0WFZoSBog4GTOfPpuys2o7gs7UjqZsrRf4hciyKvxoz4adToJs4hx13Ru
	9jQN/hgGNlEuEHveynSrQuQbw7WFYFhjP8sDde6FgF0vanIRj/l1MNXMJIdgXCsFudhyzuN2he3
	nW8PT72Pq6tuMt3tQYM5DScVZmS2yqNyyAKvrmJO+wSZU7PjaXeFTMaQzH2CAk8ZaC+5VfJ7EBX
	uoHD8rHKlkpFq75bWRU8ppchyiTzq6fDQ/w9FBFcWiO/wHAR0q0ZkGc1RLuM4zVzUnd41HoVvKR
	rHbHqrZm0v3pMNJ2PPqLAhFdvIH2LS/Bj92pqxcoCbFJtx/NIL/AA5xqPZl0nhCk6w==
X-Received: by 2002:a05:6122:6b01:b0:537:b0ed:8880 with SMTP id 71dfb90a1353d-537b0ed88a5mr3085212e0c.0.1753367760390;
        Thu, 24 Jul 2025 07:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV7/4xTbCwqcV4MMHokj20TcECLL4PLxvjwMzyiIpFYCs4G6HF8VmgXAUs3OM8Wh+qWkoFfA==
X-Received: by 2002:a05:6122:6b01:b0:537:b0ed:8880 with SMTP id 71dfb90a1353d-537b0ed88a5mr3085164e0c.0.1753367759881;
        Thu, 24 Jul 2025 07:35:59 -0700 (PDT)
Received: from HMOMMER.na.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0d8232sm922113a12.13.2025.07.24.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:35:59 -0700 (PDT)
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
To: Harald Mommer <hmommer@qti.qualcomm.com>
Cc: stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/1] gpio: virtio: Fix config space reading.
Date: Thu, 24 Jul 2025 16:35:22 +0200
Message-ID: <20250724143554.5418-2-harald.mommer@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143554.5418-1-harald.mommer@oss.qualcomm.com>
References: <20250724143554.5418-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xURLY4F8jlAkcScnpBaO2R8qCxrIR7DM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfXyjLCPdRWtsGd
 elwrVLN+Ft6xKyrRqZDdIPBiJb93tVgtG6/iuxRuQssbslpZZYKk0vGlrcwjzsFyEV2ENS8VvjW
 ZtGA9+0d9PLBFqTDy13owdfZH+3DtT5XBAb77+nnwvS2DouOpoV8SwyJnTBVwY58Ty/W46x7idl
 Tgpmw4V+b8f8DYlnuU8/vLKdL9MJ0CJXy9pwAInOF0tC1gy10MVN7bTSj7t+aZ8IsS8Q+5vXw3V
 5gOtjLqRB691v7d0QL4CSnB3jWv0gE0UUUdE9ab64YTycnc8esBOhtj5Ite0nkRUEJPJzqE2ySL
 G2G/mcE3ewE+UCf/6c6vHke9vJYlGF7R/MarJlcMMGz8rmkNtbDQfe9oIcBLn0fNYHDbz41+U+I
 UKhFh+YcaX8rJUyzIVos5o6M0XoCU65nxKs4RgJ/mI5MtUhLevFSApwlJQSqM45mSKU484Je
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=688244d1 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=x8YHxakxDffKOoiCecoA:9 a=hhpmQAJR8DioWGSBphRh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xURLY4F8jlAkcScnpBaO2R8qCxrIR7DM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111

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


