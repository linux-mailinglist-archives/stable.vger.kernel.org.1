Return-Path: <stable+bounces-235970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CSyL1+y3GmbVQkAu9opvQ
	(envelope-from <stable+bounces-235970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:07:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE43E9930
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23771302E3CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C153AEF4B;
	Mon, 13 Apr 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWYkF1tH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KH4XCXIy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AF3AE70A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071138; cv=none; b=uucY8oqs1+m2SY+i97NjnDbO8J2srxyXBNQlhqAfJuW4bVCw2CbytWCgpk9w/jdKqUKSU+xHTIA7Z+hbjHY+kDrmal5y8WdhBaxdAn/BYLe8mpOzWQhBcep9gi+h7wXifjhbrK1Zij+USKVcSe2IU/SK54k6RX8AoJFYlEATGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071138; c=relaxed/simple;
	bh=EoMB7UoiStbHSBMeq8ZVueYt4jkQJS1HZckwlVOvKm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPCHnfYWcMjVlbvyR64OpQ7Cfme9hA5SZcuKoOdq0zpxmI+cNhfimPGGOS4Sxp1J1kAz8x8vrnUlopSvzwobqDgUzuhZ+bOGCIEbjxJfztOkMn1d1+Be8gt38rcaSOrkxMHAR9X6O8EUUm65llCAapwjY9JU38l5T00WIbcgg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWYkF1tH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KH4XCXIy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D5HBq6531170
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/O1zcfGsTer4tXwGzbegxRSeRdL1qrj/XaG
	YJGnMpLU=; b=lWYkF1tH3ofkGXV4M5q0XmTmSNeQQ/3qDdFwfD5QCIfwk5Vkfrb
	Mrt88pErNAxVtZH1nGd/GCUjFeqSrc4ZnJlh+KtFQYpxg/w3a0XURsF7LleFYzYT
	Vg0BG5DL9VqsLAUGuirtlDPuKbXcbXb7xqgy24+JE6QEWh/y7ivn5BCJ2EQc73Rv
	25EEBImIo0TmFdEcs0OFdqx7WZeUFNBtcaJxYQrOjW4yCz5sUFic707I9MKo1P6r
	P8i3yzGbbZkxU9hL4LbTBsCh1UrsH6Ep9zr137n6pQQiWqAd6pUma7tl73j0Y7KQ
	hodcAePt1WDQpssxu6+AvL5mCWMSzsqO04g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff2bck3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:05:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8aca3b7b536so24376486d6.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776071135; x=1776675935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/O1zcfGsTer4tXwGzbegxRSeRdL1qrj/XaGYJGnMpLU=;
        b=KH4XCXIyLKH7muxmLBfmlIuBAAlN+eGCWp4sLCclnnPoyg2tLjUJwuWo3htQ2Q8blE
         KVMiE+CH5p3xQVra0K46h39ZTxfONDjXXx3rfsGejbKtp75J2VZuExjpfpP6T0qvCxXw
         4lPri1orzurDAv2WcAf8+ungwvtTvkMyfEAs/8j8f2X0Zcm6Dk+J5kg7P/JgsAfu7IKa
         5npct8+Kks5ax9cJ6WxrcIL3YK7xvrJUYmBl5ulIOaYABxbDAPMIjkMVhRYEpzk1xJGG
         SL2xaJiseA6TiaxYZN2nEZuMLJAdOSyLGv66qMzFUcfdBS4yqbKwHzlctERLbNABcw5P
         degg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071135; x=1776675935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O1zcfGsTer4tXwGzbegxRSeRdL1qrj/XaGYJGnMpLU=;
        b=pgDGZ7xmhUVLgu9StrgbUgHcxo4S17A9Ab3/uFoTNUfLAAMiYiJCkzVZe6/13LV11G
         TUN2MTrbi4Cg3AbZcXG3bKoO4SuKljTkoMteehA5r6ErN6GK99SLMKd2sox2oYGm4ecm
         CQTHod4adqR9tRdR3FvfUnlXAj7/0YQdgOQ+Djjgw5aBXAW2fgL77NxRg0RkY59KcS0+
         SmZdpuVEXjsVP2v9KS1/3duY8aJ6XpRgZ66bdL8smwDS+9rPYP3RMlL9/PJTYd31iUsn
         URqBgiQG/bK7+IrwNP11BZeW4Za7zDnbBW29PrrbHc/TQSQbegFtj8WbSZL5wFqt/BUZ
         DuLA==
X-Forwarded-Encrypted: i=1; AFNElJ+55pqFL9LSb4D5GNbNYXy7tiF6Fv6OBkebH0PnKpBQy/4A1pwt4cxeXQkfKL8G4jln38/Lk1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFVoWsRBiNJvILGdOzOBmWuIwth0hDHgHirqvWsEm8WUGiuTq
	YdM/VINnBqSdJX73AsO2ba3p6I2RogKB2NWkwdDzS7KTuXPfa7yV5yyQZeZ30VkTx/Fe1U+dHBj
	CbXErPYWpXwvJ2WLmgNhR95kXjCg8Er151b9aUuIRnUCLriUrDyuYnMRgFV4=
X-Gm-Gg: AeBDiesJYLMMW9wRVwm82Qgy8vca6ZQ+Osrcx+HCKrF/2Wh4v9NkCOHNBuFnJXnk1Cs
	k7HAz6lWB/33GfKQr7ZGa6qw4u7HJHMDumcE79RHx54ClRhw/jlRob+nU8Pwj6Z4rLhO7RinPjB
	oGhuv1YLdxebUisqJNVlSg0afDGO/op8K1IOpmpUzW2ZWFOm/OJrWdJTt4d+eVCj1B3AxwMQi/D
	ktYDwaclBZTjNJoxbhYxGOQo1xYe786mVpBSXdDXjJ+srFFJPEdGsoHR27oUiko0BFpWimivvVb
	oU9bJr6+8M6WDsdBdCQaimK8QhvHhwvM53vhsU6ujJE2NwWn6AOU2D/XUkDN8dw6yHhUsDDowCW
	sHQo9yOSIqdszIZrTdfa8D13ZZez9IwV7Xw2k
X-Received: by 2002:a05:622a:1b24:b0:50b:4eb9:a97c with SMTP id d75a77b69052e-50dd5b66409mr175432641cf.15.1776071134835;
        Mon, 13 Apr 2026 02:05:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1b24:b0:50b:4eb9:a97c with SMTP id d75a77b69052e-50dd5b66409mr175432121cf.15.1776071134241;
        Mon, 13 Apr 2026 02:05:34 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm270409685e9.15.2026.04.13.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:05:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Dang Huynh <danct12@riseup.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6115-pro1x: Correct touchscreen GPIO flags
Date: Mon, 13 Apr 2026 11:05:28 +0200
Message-ID: <20260413090527.53000-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EoMB7UoiStbHSBMeq8ZVueYt4jkQJS1HZckwlVOvKm4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp3LHXtew+/THa/ZW3QxIHoUVDNI8tVAHwriS+q
 I6ibfojmCCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadyx1wAKCRDBN2bmhouD
 16t2D/4z2IUrfD6nyxcywzUeAzl5yy8KHM2vUnjwR6EWL0dLrTp0N9rqnmSN9BYkrpGeVqI9R8M
 3QP0dgV/BzfrspQgawHEfuiOkUZEMN/6P8IjVLTyRcxiGETdcs5p9nbDpxFt/gwwoSTxqbj8uvI
 Fxb3yWKFvG17X5NQ2pWFSFUldyYbBCib1L5Rkpe97vnbWEOmAT8BujWosj3G14p4RWEKue4P1M8
 8RBmPXtZ4Zm9i1pitYYucoF3DLBtO3smeYT/swtYwAbWSgAvB2L7IBTEOIkcnStDUps7hWXW2C1
 Q7hEnOmcFq9Dw5zYaXsuX49tWQXZ1BYQfbM4of57CYs8KTMLKAyUk2ErcxqG4m7+XsuuIirhjSJ
 PAT55TrV+OMnGfI6FdMaHhwS0WVUbvJ/bc5fU40o6EEiyqlhFRK6yGUB5w6yv8chqtCdgFpW4z3
 lq/OEQLhll+5KKgJ004e0JG6CuNCKDZ4JwcPW6SgCZr273O7Tgrhnvtxib7xbtCEmqOSFUWpOBg
 eN53tCZGGPz27NRq5XhKIdrz/WSGDVArmNX0pvA7358+wVJvkRhdGvbuFrKhV5zYWrTNiRd+L9Y
 iNiCwGTmW3lS3YmEOnY2W8nwoPKuAJ7/6/v8BtzIhMWmM/Zi03aDkiIxNM+vUqTnAVfnDYPrRZw tOxXXiuD+iQRm+g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX74I0X/6d5Mbx
 CsuFUDjlcxCue94VShY1evjn9hbeulU4PfwHhA+k9gKr308sGw3O996d9V1Gf3eeWmiPVgHjjgh
 8ISQGng4e08ewX930EaZQzxbpG3KiK6MU7QCTsdKJyR+/j2RzDXpe1ab6Kqm2yr8GF5hEnOh17n
 i2HcP32Em3RhTOnF98AAJwaHtJe/vetcsvn8qlWIbd0MLE34DxE8NUQfULZW6kE4Z2ECcF53tlH
 Hy9MALmqpxbAiGrZ57L9VMaMPuepeA9Ro2EZmCMxwNsAE+xCT10GoB6ThlYDFzM82Aq9kFHtvup
 zxTbulnuXcIKyncJPDZjckLkV6dN2vV59zXAJsxcoopRG3DX7sHPPXu56krZ8/UZQXJfCh2zt67
 tgXDGqH6LgnGbv7RliRKNRJaw8gJAr49qjmJ3Tw5wCC7T6tOpXet99C0beuBCbVwyJIH548e+ZA
 bxI088FHoUNZUCJ/I8A==
X-Proofpoint-GUID: fX_6EwvQHypBWgIjC0f2WxbGJUC7Wlve
X-Proofpoint-ORIG-GUID: fX_6EwvQHypBWgIjC0f2WxbGJUC7Wlve
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=69dcb1df cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Fqtji0Tb7apkAwCtZtUA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130088
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-235970-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_PROHIBIT(0.00)[0.0.0.14:email];
	TAGGED_RCPT(0.00)[stable,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36BE43E9930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IRQ_TYPE_xxx flags are not correct in the context of GPIO flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: IRQ_TYPE_LEVEL_LOW = 8 = GPIO_TRANSITORY.

Correct the touchscreen irq-gpios to use proper flags, assuming the
author of the code wanted similar logical behavior:

  IRQ_TYPE_LEVEL_LOW => GPIO_ACTIVE_LOW

Fixes: e46b455e67f8 ("arm64: dts: qcom: sm6115-pro1x: Add Goodix Touchscreen")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index 466ad409e924..1095454716b1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -151,7 +151,7 @@ touchscreen@14 {
 
 		interrupts-extended = <&tlmm 80 IRQ_TYPE_LEVEL_LOW>;
 
-		irq-gpios = <&tlmm 80 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&tlmm 80 GPIO_ACTIVE_LOW>;
 		reset-gpios = <&tlmm 71 GPIO_ACTIVE_HIGH>;
 		AVDD28-supply = <&ts_vdd_supply>;
 		VDDIO-supply = <&ts_vddio_supply>;
-- 
2.51.0


