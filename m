Return-Path: <stable+bounces-206296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4C1D038F2
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DE44301667A
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9436212B;
	Thu,  8 Jan 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYbLrce4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KvOkjyEn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82B3557F2
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866859; cv=none; b=HTQr8+EivDXOAFEH2jfnbkXvxefA7vGIzfrmee1ngb0gaCZEZztuN2PPsQQAsAY3wKHlp/a2OvUdMsXE34UIzhs7bK0uuOSO/KR6OpqSCcWOiJJ/40tekH7S1p1Dsb655fm7ip7gk2fF/usiNpz1aTtD07FP0dNYvR6OydoB/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866859; c=relaxed/simple;
	bh=yvqinyUzXQd7X5CCIhbDZyiZA88+JODgsd7PoFoUBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FbZDGmDh7JiNPqMV2f5eRk6yWWO6/UF0619BSwoNt9sBzsetnkuNLBUgabht5ebgw8M4ZU/LLpNbNVPoZ4FgnXmUpPmr8DLtg/iuF6N1wAfTLNeAlylLJcqjkHbPKE0Y3kxcBZ3pvxZjkwi13OBv2BzqDUEo4bzGDOW/0LIu3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYbLrce4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KvOkjyEn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6088w9YH1570538
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 10:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=39a62VzRdxF89ha6pJCS9vnseatLJUZxk3s
	8xV2rVgg=; b=AYbLrce4PzFvull3b5Hw8LKJioCqIfkeQyzB3b604n1vEikcbM9
	XJEoR2eIEyBlpPQ9QRdv8dWNpjm8BrxKr244FRagmv4pfc8NkPcjp2xV53XstyxJ
	URf8+hPD66HP/j7FUqfPICSgskX2dOSheR2+Wa8Sa1cymJ5Yo2v+aGLQQAiMLYql
	PbYkIUhLg09iihyG43wAUQeRZPd23hiC0d/XrCSeDxIb2KOCPywzCaPktmyGqT5M
	pBonyf5IEnkVv2AavnyBI6hkLe0hdbb4oVGVgWwX+RoHv/SXRL7Fv+T4eBaEMN1Y
	E/49E029UHmzP+KZul0aQZXXMjxGuyh1TiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqr88d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 10:07:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b51396f3efso575731085a.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767866851; x=1768471651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39a62VzRdxF89ha6pJCS9vnseatLJUZxk3s8xV2rVgg=;
        b=KvOkjyEnPcCpXhrb1vyq8gXtNFL6V5HNN6C24L3+ONA910jeuSTtA40fKDQajicgMB
         koMFXtUM5YdLm19EbSo1z1XVG1hZTSb4ChyGt9044w170zExckNHEojid1fY/qetHsCa
         1oLR1hMvg9T7DvkisIQFeLk9RnyA+ouBdqWJVySoJwYwbLzM3+z3wm+V0OzsZ/2AmIov
         Dd2FODp3XZOxtkSdhxxL9B8fvopEAquwMhkAwKTNHm34MG2WjF9AN2+Cs3Q2wUJkvENr
         BQyehVZnYvPnP8XnLUTqtWRM+7/1MOlgYXCcbzCdqYlDorAV3SdXhHeDRpZWwu5ApKxy
         iTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866851; x=1768471651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39a62VzRdxF89ha6pJCS9vnseatLJUZxk3s8xV2rVgg=;
        b=bXguoMhQiMaT+C3+uI3Q59UDpRg3MRCkgDfgiVVWAkk8fYwwoVNKcp5AEYWs0al7BH
         Mj5n8/WxIK3Sh+MM656UMIfuMFNHuJc2B2UGavyZ8hLnZfvezGsQdYaLz861euKWfmdf
         cRpJMi5I239yvW/tnwaMRerEDWQlp6nnbtBoQmH/SidKXyIFrL24Meb2ZUzUJEeR1ADk
         tWdWKkHgem76irF3czTUunklL1AIeqw3UgCxTipHCtljo4m7v+98iH/B9w/2oxy7dEaH
         42TaKaxuzD5eS3tLbzwcItGMbOLyFN0KVuVU2qlDGAyBragGN0ch9TXhFHaca0QDRU+t
         uazg==
X-Forwarded-Encrypted: i=1; AJvYcCWgrvESB4Ygq8kZaMc5gboTP/jP0+DHXguaELPoyxjMRsQ0rxeGT9Tz1Xmk/bveCRNyEi06Qpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCJ9iQdU31T8HgJD4H5iZUSgYrCs61xlTyjuf5HE49Nsbd6sY
	5TUT0/zjAzdV8BHnSr/kz5i6cZvbF/4dOt6OJubAHD9BUv0l3hWXdHN1tJ/F601YzzPSiCFzvVK
	SDWHSkgSzcmPRMwjyx30XsfLlGADBwZuqJ86Dy7zsXoPXnYKgerzjTWA6r3I=
X-Gm-Gg: AY/fxX4zMiIg26kqgfWwE4v07QZp4FfgUIp76DW6xdTFQedTGQCgDv2D5burkJRLrf0
	Uqv+pZdmQCKlhpzNFyJoOdE5V8VDarAXWzEDhPqLTm6H+mSMKiJxeYlHLIFZ9SdoMeZM1NtPq9W
	91AnyBmvLzVT4gEKURz+OWQQao9KjCxS1IcEZDgBWjYh9+0zA1k7WvteTCPimPw56YRmzD4V3Hh
	7ezh1UXbW37gYLQO/RMMLUp+CtqGtT2KDE+tEe4Hj0drqkPOaBKkZ1F5TIvaSOy34ElWUynvgsu
	FqGlCcc8ucKGA1vQd830E7dKX7H1MVmP0aQcxA/bDVs8we7l/5XrSgxNK2GlVES0MYeG2RCPOhL
	UiH2WAzqH0Im7rhZBuySQfnkCbQ==
X-Received: by 2002:a05:620a:414c:b0:8b2:76c6:a7ae with SMTP id af79cd13be357-8c3893dcad4mr738177585a.50.1767866851043;
        Thu, 08 Jan 2026 02:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFczhop98haNpUo61W3RNeVKOMLBsfQZ97cltaA6nrFBVodrsiJoR4GeKj9RTMu7Q4kw62smA==
X-Received: by 2002:a05:620a:414c:b0:8b2:76c6:a7ae with SMTP id af79cd13be357-8c3893dcad4mr738174185a.50.1767866850466;
        Thu, 08 Jan 2026 02:07:30 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm16170362f8f.13.2026.01.08.02.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:07:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: sm8350-lpass-lpi: Merge with SC7280 to fix I2S2 and SWR TX pins
Date: Thu,  8 Jan 2026 11:07:22 +0100
Message-ID: <20260108100721.43777-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10371; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=yvqinyUzXQd7X5CCIhbDZyiZA88+JODgsd7PoFoUBMI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpX4HaHTVNl0JgyERX+Z/UXuphZtBcGqg8SA7mn
 mKuYXk0jU2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaV+B2gAKCRDBN2bmhouD
 11rMD/wP898T8qxcQKWOozXG+kkrcZZX3WOPwmDj6/GXkGV7TbjqX4ZSwxKbMj6vYyz9WdRbleu
 yfhnC+wGUI7AteXcz/QMVX5basV4Es17upd5sMX2qr/990+yGTSgU8zxctShtx18AIuI5xDnPF7
 obvxZ3d/V4PqOmPXsgMD805DSPyIYLxVOmcfONflUyMv3Zjud4bi8YChyMj8bEmHsslqDE9g8Z+
 wCG4/LxQAXFoGz/8mMeJxnpfsFcxGCRzKEaT/bxV6qQjjBPCAPcE3c1wmSbtsA5o6QibmPCH9ml
 UJk++C3tXbT+stryH6265fgrzf9TOXMLUV+ggckkqaKcK4pNIlRCohpnBxq7a7OY8P4Mv39wV7J
 sCVYdcRdbraGWziSS65UrxdsVGM4lpiztphDEb82DZQ2T/00fSzllHSaytQCuSMdMWQtTkiaXbW
 ayp9owHiH6ljzOKxNUSoj2mXw9XunhSNgk0srqReNm8Vj6cQGft0NhM13cavmeFh+DI2P4qwQsS
 ykxTX5P45/5RXGw+0L09JaLcHUc47JQKTCV+8zSJfAfXEhTAVpAIkVUuHz8KCykvQDGAXYGjHzi
 /9knDlNmlV1BDbapbAvUeSeblUFbjrzdxVxmsal3xzAXFcfsn+CGekRrJpe+tRjW4n1Sg1IJX7o 1Ef3WZG4LrhAauA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=695f81e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=KFTTux-ZETee2Mjt2O4A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wyqvZO16-SdbwQLLwVsAwffff2FtoJ1E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2NyBTYWx0ZWRfX2pM/FjD27GQx
 0cjW66TFgtsLLuLP5h9CRVuK1Vsb0RWH7bn8AH7ZfNO7CK3xjSHdbDkcCYg0LkicXa0aHo/7aNn
 sAWJgZ3pxlt0w5LNChUzj23XNfF2X0zw9oIUcecvpXxhob0/pe1uVRyu2PXvfWYjcQOJY9IwS3T
 HsjQ/xN1AGqoCeyN8FiZRWCNO6TEobZJHGgGU6LJlq2Vr5/TJ2pBNJn0ReSUs1xBvX7ZdUaH+ev
 7lh+Uy/JTdlvb5rHyT8U3fuPzM1hdkERXgEKDoAl+Nuh6dAVDhjv3YGbTPhpKKgT4ykCv4hACK7
 czy+Z1UgqEhJWz6++9hx4z0K9+90A5qL68nhBUfyXv2j92j9+baSHG/XerSO/1jlwmdwKXHiiyl
 tLAvG0kbsdgE4ka/xmJf3OVVgRONCDet47EEQHzpAr2SNF6hIkad8Skt1U4lY4HMVULhWG68AkA
 m8p5HFh+KUcDyz2GIcA==
X-Proofpoint-ORIG-GUID: wyqvZO16-SdbwQLLwVsAwffff2FtoJ1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080067

Qualcomm SC7280 and SM8350 SoCs have slightly different LPASS audio
blocks (v9.4.5 and v9.2), however the LPASS LPI pin controllers are
exactly the same.  The driver for SM8350 has two issues, which can be
fixed by simply moving over to SC7280 driver which has them correct:

1. "i2s2_data_groups" listed twice GPIO12, but should have both GPIO12
   and GPIO13,

2. "swr_tx_data_groups" contained GPIO5 for "swr_tx_data2" function, but
   that function is also available on GPIO14, thus listing it twice is
   not necessary.  OTOH, GPIO5 has also "swr_rx_data1", so selecting
   swr_rx_data function should not block  the TX one.

Fixes: be9f6d56381d ("pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS TLMM")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig                  |   1 -
 drivers/pinctrl/qcom/Kconfig                  |  15 +-
 drivers/pinctrl/qcom/Makefile                 |   1 -
 .../pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   |   3 +
 .../pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 151 ------------------
 5 files changed, 6 insertions(+), 165 deletions(-)
 delete mode 100644 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e43ee9735e98..40a29616180f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -685,7 +685,6 @@ CONFIG_PINCTRL_LPASS_LPI=m
 CONFIG_PINCTRL_SC7280_LPASS_LPI=m
 CONFIG_PINCTRL_SM6115_LPASS_LPI=m
 CONFIG_PINCTRL_SM8250_LPASS_LPI=m
-CONFIG_PINCTRL_SM8350_LPASS_LPI=m
 CONFIG_PINCTRL_SM8450_LPASS_LPI=m
 CONFIG_PINCTRL_SC8280XP_LPASS_LPI=m
 CONFIG_PINCTRL_SM8550_LPASS_LPI=m
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index c480e8b78503..f56592411cf6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -61,13 +61,14 @@ config PINCTRL_LPASS_LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
 
 config PINCTRL_SC7280_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
+	tristate "Qualcomm Technologies Inc SC7280 and SM8350 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
-	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
+	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280
+	  and SM8350 platforms.
 
 config PINCTRL_SDM660_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SDM660 LPASS LPI pin controller driver"
@@ -106,16 +107,6 @@ config PINCTRL_SM8250_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
 
-config PINCTRL_SM8350_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SM8350 LPASS LPI pin controller driver"
-	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_LPASS_LPI
-	help
-	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
-	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
-	  (Low Power Island) found on the Qualcomm Technologies Inc SM8350
-	  platform.
-
 config PINCTRL_SM8450_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8450 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 748b17a77b2c..4269d1781015 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -64,7 +64,6 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
-obj-$(CONFIG_PINCTRL_SM8350_LPASS_LPI) += pinctrl-sm8350-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8550) += pinctrl-sm8550.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index 1161f0a91a00..750f410311a8 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -131,6 +131,9 @@ static const struct of_device_id lpi_pinctrl_of_match[] = {
 	{
 	       .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
 	       .data = &sc7280_lpi_data,
+	}, {
+	       .compatible = "qcom,sm8350-lpass-lpi-pinctrl",
+	       .data = &sc7280_lpi_data,
 	},
 	{ }
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
deleted file mode 100644
index 7b146b4acfdf..000000000000
--- a/drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c
+++ /dev/null
@@ -1,151 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2020-2023 Linaro Ltd.
- */
-
-#include <linux/gpio/driver.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include "pinctrl-lpass-lpi.h"
-
-enum lpass_lpi_functions {
-	LPI_MUX_dmic1_clk,
-	LPI_MUX_dmic1_data,
-	LPI_MUX_dmic2_clk,
-	LPI_MUX_dmic2_data,
-	LPI_MUX_dmic3_clk,
-	LPI_MUX_dmic3_data,
-	LPI_MUX_i2s1_clk,
-	LPI_MUX_i2s1_data,
-	LPI_MUX_i2s1_ws,
-	LPI_MUX_i2s2_clk,
-	LPI_MUX_i2s2_data,
-	LPI_MUX_i2s2_ws,
-	LPI_MUX_qua_mi2s_data,
-	LPI_MUX_qua_mi2s_sclk,
-	LPI_MUX_qua_mi2s_ws,
-	LPI_MUX_swr_rx_clk,
-	LPI_MUX_swr_rx_data,
-	LPI_MUX_swr_tx_clk,
-	LPI_MUX_swr_tx_data,
-	LPI_MUX_wsa_swr_clk,
-	LPI_MUX_wsa_swr_data,
-	LPI_MUX_gpio,
-	LPI_MUX__,
-};
-
-static const struct pinctrl_pin_desc sm8350_lpi_pins[] = {
-	PINCTRL_PIN(0, "gpio0"),
-	PINCTRL_PIN(1, "gpio1"),
-	PINCTRL_PIN(2, "gpio2"),
-	PINCTRL_PIN(3, "gpio3"),
-	PINCTRL_PIN(4, "gpio4"),
-	PINCTRL_PIN(5, "gpio5"),
-	PINCTRL_PIN(6, "gpio6"),
-	PINCTRL_PIN(7, "gpio7"),
-	PINCTRL_PIN(8, "gpio8"),
-	PINCTRL_PIN(9, "gpio9"),
-	PINCTRL_PIN(10, "gpio10"),
-	PINCTRL_PIN(11, "gpio11"),
-	PINCTRL_PIN(12, "gpio12"),
-	PINCTRL_PIN(13, "gpio13"),
-	PINCTRL_PIN(14, "gpio14"),
-};
-
-static const char * const swr_tx_clk_groups[] = { "gpio0" };
-static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5", "gpio14" };
-static const char * const swr_rx_clk_groups[] = { "gpio3" };
-static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
-static const char * const dmic1_clk_groups[] = { "gpio6" };
-static const char * const dmic1_data_groups[] = { "gpio7" };
-static const char * const dmic2_clk_groups[] = { "gpio8" };
-static const char * const dmic2_data_groups[] = { "gpio9" };
-static const char * const i2s2_clk_groups[] = { "gpio10" };
-static const char * const i2s2_ws_groups[] = { "gpio11" };
-static const char * const dmic3_clk_groups[] = { "gpio12" };
-static const char * const dmic3_data_groups[] = { "gpio13" };
-static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
-static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
-static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
-static const char * const i2s1_clk_groups[] = { "gpio6" };
-static const char * const i2s1_ws_groups[] = { "gpio7" };
-static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
-static const char * const wsa_swr_clk_groups[] = { "gpio10" };
-static const char * const wsa_swr_data_groups[] = { "gpio11" };
-static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
-
-static const struct lpi_pingroup sm8350_groups[] = {
-	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
-	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
-	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
-	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
-	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
-	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
-	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
-	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
-	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
-	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
-	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
-	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
-	LPI_PINGROUP(14, 6, swr_tx_data, _, _, _),
-};
-
-static const struct lpi_function sm8350_functions[] = {
-	LPI_FUNCTION(dmic1_clk),
-	LPI_FUNCTION(dmic1_data),
-	LPI_FUNCTION(dmic2_clk),
-	LPI_FUNCTION(dmic2_data),
-	LPI_FUNCTION(dmic3_clk),
-	LPI_FUNCTION(dmic3_data),
-	LPI_FUNCTION(i2s1_clk),
-	LPI_FUNCTION(i2s1_data),
-	LPI_FUNCTION(i2s1_ws),
-	LPI_FUNCTION(i2s2_clk),
-	LPI_FUNCTION(i2s2_data),
-	LPI_FUNCTION(i2s2_ws),
-	LPI_FUNCTION(qua_mi2s_data),
-	LPI_FUNCTION(qua_mi2s_sclk),
-	LPI_FUNCTION(qua_mi2s_ws),
-	LPI_FUNCTION(swr_rx_clk),
-	LPI_FUNCTION(swr_rx_data),
-	LPI_FUNCTION(swr_tx_clk),
-	LPI_FUNCTION(swr_tx_data),
-	LPI_FUNCTION(wsa_swr_clk),
-	LPI_FUNCTION(wsa_swr_data),
-};
-
-static const struct lpi_pinctrl_variant_data sm8350_lpi_data = {
-	.pins = sm8350_lpi_pins,
-	.npins = ARRAY_SIZE(sm8350_lpi_pins),
-	.groups = sm8350_groups,
-	.ngroups = ARRAY_SIZE(sm8350_groups),
-	.functions = sm8350_functions,
-	.nfunctions = ARRAY_SIZE(sm8350_functions),
-};
-
-static const struct of_device_id lpi_pinctrl_of_match[] = {
-	{
-	       .compatible = "qcom,sm8350-lpass-lpi-pinctrl",
-	       .data = &sm8350_lpi_data,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
-
-static struct platform_driver lpi_pinctrl_driver = {
-	.driver = {
-		   .name = "qcom-sm8350-lpass-lpi-pinctrl",
-		   .of_match_table = lpi_pinctrl_of_match,
-	},
-	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
-};
-module_platform_driver(lpi_pinctrl_driver);
-
-MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
-MODULE_DESCRIPTION("QTI SM8350 LPI GPIO pin control driver");
-MODULE_LICENSE("GPL");
-- 
2.51.0


