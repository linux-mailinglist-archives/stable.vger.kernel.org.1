Return-Path: <stable+bounces-169435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D89B24F9E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DBF5C7E30
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B528C5D3;
	Wed, 13 Aug 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8N71Io9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA3F27AC3D
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101368; cv=none; b=So6MK4NxgeFANf9BMk/JuVfM9APVFsb0F0VvGQ4LDgS3mz4Oxwq4g5TwGjT/nqHEHEsFLsAacfGvBDTZPsgI0Bo9MBxBtoa8cuBbW+OJXYRqTvkFDZu5YMzI95VP76j6TTOcIxmJImdnqaq6OHYYfZDU/zvMRA/hkRpMLBEmjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101368; c=relaxed/simple;
	bh=Uy6A1KjToQeuPtCwKUZJZ4cLUf1rEWIY+Kkfeixj5H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rBSUoT4ZBdIo36UMgw1zx1A6UKEkJp4mOFM6jfzCKAksvivV9BJHqe0iHTsGfuYOVeDXwhq3JMxgha49ssUesJDr1fhldih4Pfyl6IYVdtyyN8IFhfWYyN1wOI2ze5J2lT1zUYgNYSvbrHD5MFW+SQjJuD0KvzlHd8nwKwUp2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8N71Io9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLc2I031866
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RJnHt2WOt8A8a4LkxzStewQR/E1AD06cu3+
	bt2NvKB4=; b=P8N71Io90SZtmCHdnWsKLsIswT+xf2vzlJOu1VQCCFGgxwE2x+a
	gCY1XGEBt0HvE6MOoXqwysnM2OZVuzs17NC7LXoLgYbCuDFRcJNWWVACU9h2S0z/
	P67z+oyatxBcFjTQAeHQ4EutFYFZYCM8LPVJQYJ1bgeXSY5Bhh3xMNiSWlJsBJKg
	M6CALiIRxkLypd22ixuwnVY4xj6mW3U3hhXFXQrGOBmmZgaKdrPUgqsYRz2kVOMQ
	ZS4QUvBStVA2rxxLKfxXNn3/hE38sV+bx5yZjCp3lGQba2L9xXOhNDwSM+6/5HLu
	6ulQgAuyliYdYUzACZEd+SDMfsHWfwFDPnQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4gd5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 16:09:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32326e6d8a9so61211a91.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 09:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101363; x=1755706163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJnHt2WOt8A8a4LkxzStewQR/E1AD06cu3+bt2NvKB4=;
        b=fXlbbo1M7odrXFgznVqq0sxRmqZx0lKR7vRvtdh6jC9Cpjo/5df4Lyba/nnJmBajUV
         6mgig3J6O4La+9UT84Ztonlk6T1fwWwTeL3s5eNK29w+x+ligexghHABuHsMucMcFKNY
         VvBoqh63s6ekhYLH8i0i722GWsCNhm4dK1QxhnAUYSP4WjkwVtdWGOU3lPk/9W5yKELw
         +veRGyWuxEJoywB8pjslm7sZKTSQ3QCt5JXEuR051ESiE23z5tnaBtTCm/r7L0YTTE+a
         wMrXla6jRcNzMqif+92abvj3K2NNUWAdI97aN4nbdGrnt9XPznuVt1ulbeZAjD/4lnrP
         X45Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyBBjsWLhY0+2wiwi/WvGqmD8Qd+nDmlrQSGdduflpfRzaXgZ247nFSob7espZEszMUzrZLuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykqrT3TS+mTRuqVZNIxUcSsdDy4wAlDUgVVCRYpYEDwLtPr+//
	O1BYveyzgLym1pxP43zQPR6Vte98xkSRgX7kzBLuUZZabDM3WgLCiuq5RKYalNi5KDmij/Magum
	7OWcAVHDHdVXrEZHT0jtsk+RKHdGMsUa30HXAOrM4XSzNKk6hDAroHj7KGg0=
X-Gm-Gg: ASbGncucbP7E1/ErJM/eyDIQkPw5KXTUvg12TnJd060pug/qPgtyWpJRSw/cnaGazm9
	U7dYcoZ+q52+3LW8RT/qh3gTQ0akeahGmRND0jGAUwFTPI14V22LmzMYOA/vnwam+R+dLMIMgum
	jjBHFuoCVNjQZa4VSqsjAVrvY/8N1FaVqAhyUV+Nokpj5XwkR63giBaKZEC3KRg00GzlBOr9QOf
	xgwcOOdBkLZgXybhMLIWaGBtT4fYUsmEb7NUNYGruatUzTL7epmKlwnRxcFhygvOMe95vuYFGLl
	i0x7vRV+sdZUmwG+sQ56Q1Tm44TYFaEy0Wz2yndKyuLxlM90dzd1lowUFHQGLA55Fg1zDxy8+su
	Ybg==
X-Received: by 2002:a17:90b:1a85:b0:321:c27f:32c with SMTP id 98e67ed59e1d1-321d0d7aa41mr4832995a91.13.1755101363293;
        Wed, 13 Aug 2025 09:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUhAHu45JXTTza9oZ9jQJjuAHePnoX7/+XsDAfE0WLyU3zlaWDR2Rp//MhJ0Zzde0tPKs/Sg==
X-Received: by 2002:a17:90b:1a85:b0:321:c27f:32c with SMTP id 98e67ed59e1d1-321d0d7aa41mr4832918a91.13.1755101362717;
        Wed, 13 Aug 2025 09:09:22 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257a85c4sm529456a91.22.2025.08.13.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:09:22 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8450: Fix address for usb controller node
Date: Wed, 13 Aug 2025 21:39:14 +0530
Message-Id: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dFNWHaGYO_UvL7zCZLC2iYAjSEsRru3t
X-Proofpoint-ORIG-GUID: dFNWHaGYO_UvL7zCZLC2iYAjSEsRru3t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXwo4uCqPIi56W
 CcArTtNOXHBLKydcXtl0BVX7GIbd3A071eZRZl0de8fU2TmSvqJXh4bDLlj/f5xxl5jLCH0gFti
 AzufQLUx7cPgTG7Ad5F8tJVpRBmPVYwgVqpkCGgAZQao2C6eiFv/xKGFsS/pw1nCsg0WQiUn82o
 qoGyorc2gzmAVX4xutEimVTsd/QJ7+/UtBxi743UWqHEFFXEtpARNXFJwFrtAYaV2tTaAERax9q
 nIjM2+aD8UYRtHPEMXeHTNq34NWE0nkGxFn2vP4c8N2bRgiUCPadiSS/c53QzvS9ABf4QIMk7Xe
 OeQAl3eSljAkixXBDFCKNeKs3h6UsPm/4s1nXOpjCGH1A/QS6n6CZutlGfwAX69lQqOLIGZ5SNj
 KirThqSw
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689cb8b4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=6BaAAJH1LYH1urCC52kA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

Correct the address in usb controller node to fix the following warning:

Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
format error, expected "a600000"

Fixes: c5a87e3a6b3e ("arm64: dts: qcom: sm8450: Flatten usb controller node")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
This change was tested with W=1 and the reported issue is not seen.
Also didn't add RB Tag received from Neil Armstrong since there is a
change in commit text. This change is based on top of latest linux next.

Changes in v2:
Fixed the fixes tag.

Link to v1:
https://lore.kernel.org/all/20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com/

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2baef6869ed7..38c91c3ec787 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5417,7 +5417,7 @@ opp-202000000 {
 			};
 		};
 
-		usb_1: usb@a6f8800 {
+		usb_1: usb@a600000 {
 			compatible = "qcom,sm8450-dwc3", "qcom,snps-dwc3";
 			reg = <0 0x0a600000 0 0xfc100>;
 			status = "disabled";
-- 
2.34.1


