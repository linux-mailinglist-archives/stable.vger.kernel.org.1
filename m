Return-Path: <stable+bounces-223186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEhzO2ZSqWkj4wAAu9opvQ
	(envelope-from <stable+bounces-223186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 10:52:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54A20EFFF
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14691303CEE7
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D88137C0EC;
	Thu,  5 Mar 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE1at4dG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqTNxfno"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BE37A492
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704310; cv=none; b=NSY2cU0Z5SdZ7kcOdhdFexzQc+vNwhHPDiHlfMi2uZE2KPhd80gxKYW+RIHyE0Am3doVvi2KkqTG402idzjZA5M+5qrnCMzupTX6gQbOFmYm2b0RCIhgfY5XFHHk+LqYcM81nH8DyzUotjbDq5PQuKJT3P4Qw9OCiH8sawvBitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704310; c=relaxed/simple;
	bh=asFRYbS+mWsBdMTNaAjlr1kv9Sq3WYDbm6irXLJp2J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGD/xfJ9DNvAHnVSWE3DZBO2AvVRwLrxqSne8hgulpfj/K2GN32QOa6CjvYrL+8Y2r7U9YNwidQjdOnrRGcMYHbD4UvWMfnqqQzjBLUepI91L6C4rQxwzNyN/GhsGWVgacF3ZJHqPcXIjMstUtcU3IZq3NXCKhVi3FoPV/gT984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE1at4dG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqTNxfno; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259GgtN2665343
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=; b=DE1at4dGMoW0MPoj
	fkTM1XPnbaXH9aOtii8tMvhXZrHf0+cANP9OsxrvjZFRsMmqGtC6L8yRzmPBUjnB
	0bZb4g/2M4jJQPf2/9OAno2qDzeFI6D40wtuqXeqFs/IHqUl0i5EPWUHZKVVIY/O
	rwgpXcQDFhXpr3mW5UQY8n1mS8ePYv+Gzhbt4XN99Bn0ELm7TbaP71qoS6SCnV31
	jWY2dqSMvz6jnGnZycfawLKRE/xFmFMQSaRxb4BxnUxtBzgNCexoCgiQkrPD7Q4U
	YZmDIJIaJJ+BTsntuEuxDhA/rTQ/TZDX+SSJXFWtfdeo+ikncpU4dYalpZCl/deB
	6/3fJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb285p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 09:51:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso987126885a.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704307; x=1773309107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=;
        b=dqTNxfnolhchTXA7hTdZdD2yyQMMbHfy4UJG/6UWfolY1scPf4ttfhannRJiqPUR1s
         tuJtWa78J1voKdgkRFjE0t8rm+HJ7LqsIXtnslc0LDk15oo9ohRlH5IM+ODRfpTFUSPT
         hNUgS1VQUMuwEJoKkcs7wE2HPs7ch1sl1DQF59YXGuuw2C7OakWq9bWLxZXzhISdzSwO
         PYTYcE2SfBeoZQTpxeSrfTzqus7/aSEHHX42qsnX3kV2aWkcNIwezL92sNYiSJwkJq+Y
         GCZycB2bFe02UXDX+MdIVMm27ehRn/Qm9R6WRD0UUxSy1YnFyQCidhQrbFcy07NEwdIi
         KbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704307; x=1773309107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ExEz4/DFiPUvRA1okzAQrYU3w++SlZSrUbTH+yM/Ouo=;
        b=LVgZ8nGRBh/h+qtbYzgGuJ2iRMNgKFp+2bGcq0XOx1ckGZ29bnjhuQhPi4OtKTkWuc
         epaB7d31H7tu0kKOn2X7LcBzJO0t54paq41VjmEzcl1e5fJO1jhcNkSkCOcMtQp0pJsy
         Ekptdj7P4Om5odJsCQhkaM9/u63Yomr74Fk8zOX+ZAGPvVEd0Ozn///L9NYRGxLlp/2a
         gyXveef0jiePMLIuPJgPZ/iA41gno69vKqAMMj5tPKAs+zoozmGdZghxH5Y3dKmONKIe
         6aF2VHquKfJUXtrVTH+FFhrThv2gMe57S4zy4QlbZtiKQG5DGn9tfIN7bC4nQpU+J3lz
         DWwg==
X-Forwarded-Encrypted: i=1; AJvYcCVTlyPeJ7omuNgj1/Ew7ObcpMTtfxTtXXT/zLBT5nPw4HlM6Qi9urkJZwQssBsR4kRhnVBeC4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtmzVRucXeP8IeB7wrlvxjB72Q/YCyhX3CTvVvta9cAY9gEDiJ
	+io5VoqmADCBz+BwXRNUVHAdtYjJGvJL7efB9tjYro2nrarCNDiuVSELfxin1VgRazTp5/6/fYH
	VYPa0XwHlhzaYJX0UhPcuwmwHvyxymBPVVDP+obPjylIw/fpRbpL4PVAraHU=
X-Gm-Gg: ATEYQzytAeGZ2nFhY0YnGcKDreH7me8v4rHAUvpHq8szf5tqTe2AyKAWweEGpNizgsg
	ASEarx7VOjnLBx3dNEESuKvGfbfRzKg76whUs0p3nd4s8xevz2U918sKtIZdh10Jdz2866AogYz
	voOqfyazYYps842JDB2n4Cfb/I/5MCmxUG4JrKBsVIwutmmoEzRlMJmObT9SaA6maZMkJ7lFyBi
	wKQ7qow8HZiIeMG8V5+aXF1q6IhHOJiWJ+MXgL4pqqiJWRJRpSIBz9aBN4e+nBCcJYMfj9fkKyE
	zGvbUKhdoYOpysavy0vvAgz4iCy1XsM7SG20Uf6GaPUj2NWOT1L56xt8FC3NaxyHYb6tjL/fXsO
	xUoJQxTFT4gU1mdXa5sxDPKkVTAL1R2EEHOBg1UVrO5vQup2C/lZO
X-Received: by 2002:a05:620a:4405:b0:8c5:3067:903c with SMTP id af79cd13be357-8cd5aec446emr644637085a.11.1772704307399;
        Thu, 05 Mar 2026 01:51:47 -0800 (PST)
X-Received: by 2002:a05:620a:4405:b0:8c5:3067:903c with SMTP id af79cd13be357-8cd5aec446emr644634385a.11.1772704306918;
        Thu, 05 Mar 2026 01:51:46 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8314:9d33:34c1:88ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad1656bsm35598215e9.24.2026.03.05.01.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:51:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 10:51:26 +0100
Subject: [PATCH 1/6] gpio: of: clear OF_POPULATED on hog nodes in remove
 path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-gpio-hog-fwnode-v1-1-97d7df6bbd17@oss.qualcomm.com>
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-doc@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=asFRYbS+mWsBdMTNaAjlr1kv9Sq3WYDbm6irXLJp2J0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpqVIpxm8mmJ89njb6VW6uBXMeoNjLVFgEK4G/7
 o5qRQijDnGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaalSKQAKCRAFnS7L/zaE
 w2ZEEAC2PUZMyFEneqHPYBmxvm7P6SHUaTj09ZmnewmcmRX1Ifjnh5Owxce4J2PXBfO51XuviuQ
 3ws20+W2Dijv0XJmzoq1nvGp5TLupbdjCSbyQJUFx0ra4QKROzaeuiDk1zVjKxOdxN2Mq6mWsI+
 ZlPluD8qWKSXqyl7F51SOEf2A3g2mZlYMooA4yXeYXW1/BdB42IY+L01RH+Dj1rJUAXyHEOQG+P
 U8Kfj2/UF8LR5XXWT5p14hdLAjUoPPQgXGTWwGykCZAQ87fvt2xofkwnYQvg5AfnJOtN3Q1z4Rb
 tAhCKqWUmyuGnM1cxyrYcmUwGyHxKu/JbGD8sHTiyhcr5/fNv0usioIXka1DEZ3AOJTQw+d8wmI
 I7GLTtfU86WrlAGhUm29Wiuvs3M2eoJzdOPwtCsPo8h/a+p8hTczNCsCu36zMJ2P3zBdQG+qK18
 4gkv7hrrC9HfvUV0GM7w8dzGf4XIYnh+G4OlakqRfusunUJEHOP02Qul78UfSEcXCzLbLigiuSn
 6WmVCIKsJ7XGLKM5Gbx39Qo6WlVAjrF9PYKHeyz/Hl8XsWUjEO324tHHi/ZbZFIYFqUcJcE7nOU
 cmH1y7X03mA+ecUrM2+7VkLkOq8SSkSK6J/0CKFWpOvOfbE5jfo7RPTULOkoh78+xaYksHk8Ma0
 x9BWcpJG25QWsnA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OSBTYWx0ZWRfX4cp2xaM0HWbn
 C6mMmmsGUJur1rkGdKcfXWF8M/ZoMzqgXZZXJaZ/omWWSle5AykohEfVxyeqAJnoiaPi6Bx35i2
 LL1J6tXBcSeqalGrenLxYitI3dOBfuEMpFdEq6jhZa2cHPpVA3MfJFkrqjN+5mGKFLIQOeI+Lyp
 PzHP4mHWIlcKYard2fRxNSkBneqWlaIahP6zkhQtPQxHx4GurxYd3BYoiIzVKBj1GUOa3PMkpHF
 UB3qtIKWN+Q8mX4Ausd47jIM0kG2NSdTJLxH664PXoWQSF4wQ/ncjlVXyP/VB69vNOb7g11mvnm
 lrUDcJXops5OIbX9+9ApslqhCl6c+n+vx8KxGV3viDuaGaoQU1CHFCHMqPdMMk6gJjwuJ2mc5rT
 n96IiQ0dgYmKdt8Inlf9Uzl08G5zVMG6A6vlhu+H1XjneOezlylqfouBkIlefIt7XkhTK+jTP9D
 yv3hrYBIi9GmTBlKkJg==
X-Proofpoint-GUID: 9q2meFpYp_PoVHP0Or99KQsKZ3AE-HrW
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a95234 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wIkqWORfvUmHQsOhi0cA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 9q2meFpYp_PoVHP0Or99KQsKZ3AE-HrW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050079
X-Rspamd-Queue-Id: 9A54A20EFFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223186-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The previously set OF_POPULATED flag should be cleared on the hog nodes
when removing the chip.

Cc: stable@vger.kernel.org
Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib-of.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ef1ac68b94b78f09e768cc740e893632b8817505..08b7b662512b825086cd70440be98b59befc3ffe 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1210,7 +1210,14 @@ int of_gpiochip_add(struct gpio_chip *chip)
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(dev_of_node(&chip->gpiodev->dev));
+	struct device_node *np = dev_of_node(&chip->gpiodev->dev);
+
+	for_each_child_of_node_scoped(np, child) {
+		if (of_property_present(child, "gpio-hog"))
+			of_node_clear_flag(child, OF_POPULATED);
+	}
+
+	of_node_put(np);
 }
 
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index)

-- 
2.47.3


