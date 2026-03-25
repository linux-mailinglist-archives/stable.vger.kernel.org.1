Return-Path: <stable+bounces-230340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHDBGzDkw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:33:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E16325D87
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E72A33C0CC0
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962538D00F;
	Wed, 25 Mar 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nP4LXN+x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJGeply1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0341EE00A
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443659; cv=none; b=jeYxN9V2mo/3Czb7ZavQrlTVMSQ2M4XpBFSw9rhUNxbsaGBMQ8elGwbXbAlnjfNpzXmjC5hcKypOkROh5MaPIK39jOb+zgxT2zcYfBPW8WbYwyVcoztHd0PwIXrCArL3lqUsSejcjK5I1Elrr99/oxb2RZ+reXjOA4LWduyTKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443659; c=relaxed/simple;
	bh=iECa52X1WMxQXk08e2oTItD2s9nnyd0o6WElpXC8J/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=airmLMpW79YtjvmCxeqHHdwt45EB88F8IdSROngkRaL2ePGYfnuDnD075mSJeM6HouPz/4T2tt+IjK0JqKIy/WUZDmIdyF70fYb720M7xJnAhtE9JCSvpT3peWPgcKh7GAYOnaB+4vqmZv5EUiKvryCuRKezORuEiDXvDDzInUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nP4LXN+x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJGeply1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBGO863922568
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LjdBzauvOqjzi+H4aHlYeX
	gujOJFM540mstkGc96erE=; b=nP4LXN+xdbQ3uQDml1CVFhdhQPcjogVx96VHYt
	blUy3wFnf7PB3e8Imt/g03JwpYDlNjKUHT/SbEZ83G89KQLyyNi6uC3Mo6MDDGJG
	tOwT9PH8kTDJbGKOsVCta8KB62MXMdnplDQ7mgSUVkO+wqO/4Bn+ZrzkFxe1xGeA
	T1lioRc5zvJcFCdLdAs1trBWGc8eZWft8bbNAKlNaGb7kzEJ+ZL2Qx/vaq/47fo2
	Hg5mgHvsCmnflaZaV7LO/7GeJkOoueM+CIZd/8K/6AZPxNCuwZnAPqvA48RQQrOl
	anmX9tIT0Ahdr3D7FyPP0fJxECqookHmux7jNrOqvId8FCrw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40rau68t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:00:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b07bd30b5eso13024385ad.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774443656; x=1775048456; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjdBzauvOqjzi+H4aHlYeXgujOJFM540mstkGc96erE=;
        b=RJGeply199+Zz0wGDrrxDCnJorsE/lWRsRmcZv5IyxvlYg9puEIAGFmtue1g+C+Xyw
         7sfUjCVi7O23E625o3TBfEMg0CBPQR/UiMslss0qx+EmZc1qr9qmu5AG3pubJYdNx4om
         sYcIVXgLqVbJb+dkvnKA+nNTVR/8dDsGDSd/Wt7mKqX5bAa4EGBioD/7gFsPrDDzHuAD
         OZA26F1jof23ou25FeHf1ywbrc0kCt50LdQZsLkLOnuAO6ZiO3U84Lj+xThB/VpI0ujU
         uUDCaCiNYzliowTfPBR5gWGo/1vYe+xFXto+cboSImYR7JY3mrwrE/puwtZmO1WVTyRX
         8wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443656; x=1775048456;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjdBzauvOqjzi+H4aHlYeXgujOJFM540mstkGc96erE=;
        b=gXBL4sw1lWaqoCzHWoylHApVK+v8ArIfzcwclFId1bzJEVMpl/Sg2SFgA1z6eC5Or/
         sB6HSJkI0gDgqs8W93pT1kDiiVroCPWi+oGz0N10cJ8URO9YGzBVVbTFljaogEMkmgKY
         778mm0NIgeunPBvSoHiATCBRcJYIkMNjYvmwnXfJThmK/o4q9H7QsNWURwGrsJ0lFfqc
         76SiAlTgevc8MYF7KFU/De9jSBCBVNsDIBbPU6JNJ2jFlJFn/wVMZ4Ws0+sMiPMCFcIk
         vpc3hR5hSKX6syWaW84UAvD4E9VRZ9n9gVmUdnhjY1YSuBJQNdgHw8QHfdBBN15s/UcC
         czBA==
X-Forwarded-Encrypted: i=1; AJvYcCUTH5Gi+uR0jqutMo8kkmPcMOLz1oDszVa4/Xjx9bgrvCc38cC24dKM4GISEaOQv6M6TJhRgt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2pbmImEEmaQt3lW5mPK7apFBA8HFzc8PPaasgwkjOD6MZiLr
	MY8bVZAMIhvMsv+QsWf9f4xpv0M+xpaiS5/dc6Uz7glksQgHCfii+yXJFs80ExFE8GinSrOVHg0
	zze9LVE2zNQWHCGV/Fkn3wMgwCHiGhrPqwBtAP2rp9LCEO9t84jO3JcHqsCQ=
X-Gm-Gg: ATEYQzzjN+SUlAxheaO3o2O+xMg5H4jM1amJsnQ0ebcDWBR8IJAhP86VoZrS9tujhbd
	3ZiYuBnq9s8VHZctI9z6wb6ziTsOncLG0wWM/Dbldfors3JAPaIuLQqSg1PKU/6YBLjs2d1dkoG
	xTKyC5DBdqxrruSFB8TSRM0o8JPZbP82OC3brKb4GWUNAqqMTh8JHE9ISe+uRzP2kJYYhXmcsMi
	wbVF0Nkn1HLFANUmiXuDgxc+RpQ0gQZkpZMW3/V/F1wR+XqiujW8vrSd2FWTaUeO3USvRdvRssV
	yOPbIlG8ZzlQDHd81uwz3c0oxsYFhDLDpweVAGMUu1FL0YGbIzpz00X80rK8ACvO6382anPy59U
	IhCvkaAJ89mE+MZoKYHIY+NBN9Z1WVdFZ1fdXLlmflgaMde/kg/vx/XgLWg==
X-Received: by 2002:a17:902:f607:b0:2ae:5350:3a4e with SMTP id d9443c01a7336-2b0b07efad5mr35559625ad.21.1774443655460;
        Wed, 25 Mar 2026 06:00:55 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2ae:5350:3a4e with SMTP id d9443c01a7336-2b0b07efad5mr35558835ad.21.1774443654537;
        Wed, 25 Mar 2026 06:00:54 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm262575755ad.45.2026.03.25.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:00:53 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 18:30:37 +0530
Subject: [PATCH v1] arm64: dts: qcom: lemans: Correct QUP interrupt numbers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-lemans-irq-num-v1-1-a470d544966a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHXcw2kC/yWMwQqDMBAFf0Xe2YUkVgv+SvGgca1bNG2zKoL47
 03b4wzMHFCOwoo6OxB5E5VnSGDzDH5sw51J+sRwxlWmcCVNPLdBSeKbwjqT96a4OjtcStsjRa/
 Ig+y/4Q2bRfN3unYP9sv3hPP8AKhdIGR2AAAA
X-Change-ID: 20260325-lemans-irq-num-cc03721f451d
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774443649; l=2483;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=iECa52X1WMxQXk08e2oTItD2s9nnyd0o6WElpXC8J/Q=;
 b=h7U3vULDB7kvty2wDiJfNo0SWaU2i9OgE41ELIdnqbE5iVVqQ7OQGEVtcw67Vr2XB2V3Cd5d6
 novS8Vn0CVAAYodn9Z+B+8hwCdrVdlXpXgIduN37LRhShOP8opzZvNn
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c3dc89 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nXOf96giqOHqJdTUQPAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XIj9ETmcsN6kIs47OohO35l1-hoIUhjz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5MyBTYWx0ZWRfX0Jl7VFntuEjF
 aMsUqCblJzShJE2fn611Hvno1TYVQPbG3x0OI/1oHK4NAlg/4chXugiyUc8PZsry5kbcDkIYGAB
 r9n2+YIry9roraHAwhNJvX0frdkmJGFat2Q2wJ/2xPIeWxJpD2IZU3vGkdOFIfx/JrxukUr5NvR
 fp3KZ/tCN00QLauDBdk+1UGFDXAoOGaF5e9w+lNfhOYJk1sLfPxmC2aVIovfblN77gYcy6Zotsw
 WsPt2XI3N1QsYBdmNcQQr3Mjw7d6uq33dlAy8NsYxrJXMHgyfPxKw3RTsVBGqR5YOMZCKVfO2DC
 hCqvlL25j9LKwhbv44WTJ8Qecx7KOhE5Tv1Fhdzt1FJR9ZCNCTK6su01Mwx2WSvCkZz5U3Qz+7f
 nBXmo/Eq11zvWCrQWLs0DKK8R8LZXyzV5SHKMq9wqDFLuiS0M1Ya0C03Zxw9FAkq7R6kP3Uyx9R
 9kc2hPPBL+Z6nqfDqQA==
X-Proofpoint-GUID: XIj9ETmcsN6kIs47OohO35l1-hoIUhjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250093
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230340-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.13.179.208:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,a98000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C7E16325D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix GIC_SPI interrupt numbers for QUPv3 SE6 nodes on Lemans SoC.
Using incorrect interrupt lines can prevent IRQs from triggering
and break I2C, SPI, and UART operation.

Fixes: 34a407316b7d3 ("arm64: dts: qcom: sa8775p: Populate additional UART DT nodes")
Fixes: 1b2d7ad5ac14d ("arm64: dts: qcom: sa8775p: add missing spi nodes")
Fixes: ee2f5f906d69d ("arm64: dts: qcom: sa8775p: add missing i2c nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index f565067bda31..05c0888e2bc6 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1512,7 +1512,7 @@ i2c20: i2c@898000 {
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c20_default>;
@@ -1539,7 +1539,7 @@ spi20: spi@898000 {
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_spi20_default>;
@@ -1564,7 +1564,7 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 			uart20: serial@898000 {
 				compatible = "qcom,geni-uart";
 				reg = <0x0 0x00898000 0x0 0x4000>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart20_default>;
@@ -2510,7 +2510,7 @@ i2c13: i2c@a98000 {
 				reg = <0x0 0xa98000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c13_default>;

---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20260325-lemans-irq-num-cc03721f451d

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>


