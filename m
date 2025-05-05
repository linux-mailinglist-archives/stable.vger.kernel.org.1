Return-Path: <stable+bounces-139654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DBDAA906A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C0B18901C4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E12A1FBC92;
	Mon,  5 May 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+QW7ixq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BC249F9
	for <stable@vger.kernel.org>; Mon,  5 May 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439151; cv=none; b=l2+NCsMj7cd0dXfqH8Ktt+u6rm2aeBXBRpklL8vWgNHpFhKwHaQYtU7lty5q5ebaSp5n982OQqcQvZ6qCGstUCb9xNHDXe3G2SJnTXsty2qkMUW/Ty0xS0xtEEkKPQB+k0dhoPBPfd/9IJ16FzLsBIjC9GZJUc2U5iyqJVRCifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439151; c=relaxed/simple;
	bh=EpTgtXBx6RlAgy0dPCnR885Z0kSSu1ufdWaninmCbc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LW38Ybf9ML3fckxrFzAway9VryWulwPRzM9tQxJX82HUZxQN1xZLbksUhLFlu/EokLO1HEcyfvk+CBdv9ju0kO7EIUaq0TXo9m3VA7Q8Ja1Ljd2WyGKEPAW560ll3gvzF52Tqiu9hllVs46M1IYDYx9v73Ja/Ns+kBnB9cCD/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+QW7ixq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544NeNEZ008231
	for <stable@vger.kernel.org>; Mon, 5 May 2025 09:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eHT7qDsNgvG+6R4akd+due
	X/xA19TpqgzBOgKaZriFY=; b=k+QW7ixqvshVPaGVJhu4EZTmghmIthvptYdDw5
	IPMoV/3W3DV5uO7V62QK4QPsEGIAKunbGxdJ9wooFLbwA5gfoP2sRIuiosxlYspF
	He4PByLEcVyT7dwBc950MJbQXUipivcFJTaw9pf39xDkgcA+1FbWcHhC5wIWSBAs
	4YjD6NvsM8P8JcFIx50d0ImGg3wFgsE7I3Y4zoGRCdgyCKPwPTjk99SmPMyeO24X
	iFdw9IBqhjwIiqVsD+w3F7G/RjlWXHuyNKFxswlhuIkLkfjVwXUYaGbahjI5+kyi
	2SDreu9sdQX32SIlFTMwhji8yg0Zq2U7pQU0QwplrIwWr5FA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbwfkkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 May 2025 09:59:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b1415cba951so2247904a12.2
        for <stable@vger.kernel.org>; Mon, 05 May 2025 02:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439148; x=1747043948;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHT7qDsNgvG+6R4akd+dueX/xA19TpqgzBOgKaZriFY=;
        b=VYPPFqhnwfRzKPcZkLDJ9QQrtd/yxUWuWHI7FNCxnbXIP0pDGltswNfdIgd2Dkbwox
         9kQfnMrY/p2Kt+HC5MU3vIs5zsmNFq/kz8BrRupANHyZIWxjgYZnjkkz+RKK/hSJq1GD
         5AylqtHsY8aFq/Uu6uZOjzkNNcU4cLDGwBGs+bZcrYK6MhI87XVwP5NE60rpFhv2rZ22
         WRc0lM47RvCEcbYYwa2LjCp9Wd8Pyow3O6PFjqbAF0vGc81TBqLwpaqiYBedZD8lCAE5
         QCnuYJr+Bh9QUUA0l7CDqvptEzXI7na6jkDWUH1s87GRq+cfDqB+gDoODGgQVEhGOIpN
         icNg==
X-Forwarded-Encrypted: i=1; AJvYcCXlETdLznmxxH1Wu8YpMKQNGDpSr9W9LuXH9dckTiBZTwI9EbLxhWGc1UVMAvqHdKZ66EcpJyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdPnGMEwnkmRhLX0p2/I62BXbv47U+hmst2jI7Y9YVWcx3yAN
	n8WJ/NeOrEXpTn67Jz9u3kZyrSPBFaiXGqDcn7ssIV6nIsTX+qfdvzH1J6KQZeNk5fG/IjRVSj7
	XXkV3WXR1LNNe9/hsnbcI2kMeafLosqd7yQS/iY0ywmDjL/Mq2UGYXmc=
X-Gm-Gg: ASbGncuWqUxYbtygKqIbcvXy4xhBznTTF2cd/Gs5UgwKzvwx5hrKM3kt/MCV0cNMrSW
	S8bjAxxb7x4LigOVzn1BmI+B7yZCrbcxQ7DT2gi8Xbw3D+H3JgHUeNZXUKPSCE9vLIyCvE2bvvz
	6aMRSYb7TlP4WGiyidnEiHO8kNv1JwQyvEIHi6kkwdq4mZthx3a0AzwLjV/JeAYZc54dMuE/yW/
	bSx9LWAU82xNhUac9dZAVM+MfaC/GVqRq22JCtvoD2tpPezraThqdEBd3VnA7AOcejxcIcT7dyj
	S45b3Ijng9gNRKdYR48xUdpC3K5tbw2fY2ypM8mdS2ca7cLg3CEEPn9t/dY+214mc8aQtjPhbco
	nFNXKHOFY5xEZEWa0mXDLNXR8ouuUXBhDkI3+oviTMzyT4vc=
X-Received: by 2002:a17:903:2013:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22e18c390a4mr94964885ad.41.1746439147973;
        Mon, 05 May 2025 02:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkTKHq7ayRsAFVb77jjAyGhEnyopmqWN4059dMKSLYS6kyiwKuLUniLbs+PgPx3MUf41umOg==
X-Received: by 2002:a17:903:2013:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22e18c390a4mr94964655ad.41.1746439147609;
        Mon, 05 May 2025 02:59:07 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059064ba3sm6524625b3a.130.2025.05.05.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:59:06 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 05 May 2025 15:29:02 +0530
Subject: [PATCH] arm64: dts: qcom: ipq5424: fix MSI base vector interrupt
 number
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-msi-vector-v1-1-559b0e224b2d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOWLGGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDINTNLc7ULUtNLskv0k0zSElOMTIyMjZOsVQCaigoSk3LrAAbFh1bWws
 ABv/EIFwAAAA=
X-Change-ID: 20250505-msi-vector-f0dcd22233d9
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        stable@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746439143; l=1189;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=OWgPLrSOsLj7bhXbTza3TATvz2EeFkP8y/S6sglo7cA=;
 b=C4RMvaIVPbc1OR76Rkn4sDLgXVDzfHP/yrG/GHN1eovfjvP+3za3gxZ14R5hJo6Ev96Gqpp2w
 wyL1GwwcMNwByot5mL8wrT9ixrg7nESV3CYlS5fjoXOp1NG+E7HmcJc
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-ORIG-GUID: CXgz1P6WzNLsApw0_SFf7NdnHTarVkD-
X-Proofpoint-GUID: CXgz1P6WzNLsApw0_SFf7NdnHTarVkD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA5NCBTYWx0ZWRfX3cMKC4pXJpUC
 eV0jiMQjlI/jPzCHSh46dP0S1AVFtGGShvCbo2xKo68JSGQXRInRH4/mwdyJfMUbaWhjFTQptNm
 2sD+S12EMXXlIBwi9qOg0n0cCotOlkAA1rJ5umHuAOxR/38MmF5kHkbpCmgNXStf+s5ewcg+X89
 heNEwn1W5POwBin5eDQ5OfHEhKY43Ny/J7uVKnfN1BcQjabeccf7Z6Za/f+Msm6ibt34PooRSVa
 7FGgDuqchDxVEnMDKgfkEWyVLh48cRIjk8QRoHKh9uVp7A/lRQsQ1SVHfcIqIpvNQaO+QXOBn1c
 58Y+CgGrSV3v3mbhlzNZbxltEHiE1Odpp7PRiF9HvgND85mthGpsw4ENH3LIR4jL4GJRZo2BY/Y
 VNY6lb46aLVXHF/R8LuHwEmBv7iPqoyW9bYv5pA+L3l2xdTUYVxOEjBKk14hjz/N7gT+Ze8e
X-Authority-Analysis: v=2.4 cv=AfqxH2XG c=1 sm=1 tr=0 ts=68188bec cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wQDUD7ZtUzV8iaVDUq4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=613
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050094

From: Vignesh Viswanathan <quic_viswanat@quicinc.com>

As per the hardware design, MSI interrupt starts from 704. Fix the same.

Cc: stable@vger.kernel.org
Fixes: 1a91d2a6021e ("arm64: dts: qcom: add IPQ5424 SoC and rdp466 board support")
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 5d6ed2172b1bb0a57c593f121f387ec917f42419..7a2e5c89b26ad8010f158be6f052b307e8a32fb5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -371,7 +371,7 @@ intc: interrupt-controller@f200000 {
 			#redistributor-regions = <1>;
 			redistributor-stride = <0x0 0x20000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			mbi-ranges = <672 128>;
+			mbi-ranges = <704 128>;
 			msi-controller;
 		};
 

---
base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
change-id: 20250505-msi-vector-f0dcd22233d9

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


