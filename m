Return-Path: <stable+bounces-240301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WChAMN+Y6GnVNAIAu9opvQ
	(envelope-from <stable+bounces-240301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:46:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EF444306
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2299302612E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D323C3C0B;
	Wed, 22 Apr 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LRfczsno";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnEUZiFP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EE3C3BE2
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850776; cv=none; b=i4uZB5klBwTaw4OY6MfcOLCprUta3gkuLgNYhR6bVbMJZgdUm8YudoZBHDaikbWsQkIoiAK7sDoR6yC1YjcF1ZIaoWyeuAWc6wwCp6yLczcPIClKdnA/EBm/IEqr0Zo9kL9wsSU1jKMmyCHo8o2OC/XhVP5eHKqYH5x7n4bMovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850776; c=relaxed/simple;
	bh=lYBtb/FXLnrKMGDRY9R5zWWqwoEjMD1L30jny+RJLSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cY4UiZ+c+6x8fzSL4U6FHSjIz3YsRimAeK6Q1aBdRr7BCNje5H5iLzrwCZdHAnFvZVpw3bjj40o2t5zM8JsnkTzvRBdLOYGTznSbjfKxH+e2YE4TJqdLYvyI5V8s6r11+NL/gxFcewm8yLRoT2gvW6ewGjPGnWbx8ovRE/WmX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LRfczsno; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnEUZiFP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M992OD1442696
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=K+FRj/TOjFm+Bx5q74z+YlRnH1IU+JAqkB0
	bSNcN+l0=; b=LRfczsno+Gy73PGx/ywrfzaDoeyRo5wWkJgMKsVePg2bBXz1efL
	egsSWS4rW2tIT2I//4+gP9cFGhPQHKrCppe58OjOwOadzVjqzQWL90kWuNQyqojY
	3/OAuFX2txcOBGSBPqCZzQoAa8umqlkHgY9H/1aRGsUP56tY339xRK+14jIbLBBT
	VAocVtsjrUdfGAuSrdJCgAccRl1EvOLrsZaazFkIMEZAcpLQno6M/7JdDSKljqGB
	rHpIyfSgDiNL/I/2S+x3XkRtHwmOgnfXcXa31CI78aT9WQkVoBuwe56cW21NCvpA
	r0RYCOChN/X4VEtfqdwqSmACY92cJUnDFJg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenftpdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:39:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5626925a91.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776850773; x=1777455573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+FRj/TOjFm+Bx5q74z+YlRnH1IU+JAqkB0bSNcN+l0=;
        b=ZnEUZiFPTdP7zF/hc/EDx3+/J/pyoeCX7HiDdUT9YhX+D8MNrTazGThFRFOdfkSj/c
         L1Tp9JqQJPG7eYCXA/xUgvdUND99SEfazVXK/NNf0hIoJ5p4KWXciViNJn5ARUpDFEZX
         wIIAHkKQYfrnSbXwjd/M/UY12P4mb/Y4U45vdiRjVEdBRIEJgL5LTJ21DUJu533BVdhg
         KGzAHUHRh6sZbkUgMnqc7VjsIWI2rBpwaPlm5/liY891MQj40ZVikH9kYylRDXKTDlmR
         m4rnKnpJeOjpCMQofS8hHDtkKUOtdVTbsl8ML9Hqla9bHHlxlATsu6QjQPJmIFjiroeq
         kDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850773; x=1777455573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+FRj/TOjFm+Bx5q74z+YlRnH1IU+JAqkB0bSNcN+l0=;
        b=Ehhp5xWpdUXJ/bkDZSb+WIn+fVxeKJSNh0Mf7jmX5TLqcYg9JAyL0CHQgpTT/tNMhs
         T50rFIKz0CWcEqqG6yyqz4TIGVs9BYIbR6BvG6J9nplelUI/oRpeweM9RaDWY/2uFpli
         3GxCfBwOTbUXFwdCJ8sFDPdT8s5wqvnRjdzj4Zdrki0q0L/dLr10VOwqGjObPeD4cXSq
         4d5+6OXiVa1cjEPydUgZ3qOU7/+N9A5sclXzysauc1U5px7I6Nu/ngbWSqORo+Cc49x5
         XNFWa9wj2T7Bk6GJ8ZYYqfDOMqyIH6VAH44PZv2SmxxMlcaSfSuZpi6QhVIwEhkiFOdS
         8dOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t3FloBOUUDxI9ObU4U3tmAy192FcNHpHUZeFueN//jnJQpIMnBdzISRn6WEsKtDNWXmro41s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37y4wRcwqfThePtw04IZtb1ptJMyahorpR7O/aTgdqE/IHVBb
	/1a0KlSxSIguBCCsmEqvBNXQTsv9JHEZlDluEg0i6Zgr4SmdlyhmjsYL2NPB4iprRioe5fGAymL
	gaIkhNn09xAI30jmXE75IwiCMeBl+KsRxGyy0qQC/3js0Aoy96jYnY1utVGc=
X-Gm-Gg: AeBDievn30bJ55BY8dYn3nYI1XESuJbgfnILLti8+lrvccyikh+G3cSYp4p59E2b2lw
	Ufpeqk4m0sPesH1Vzke9HPdmIGz69aHpt30zb+L6YgqzJh/wTMjTRZYp8Py1FrRBJBHx5HYuRdZ
	E0cfryoQQrR9JWK/AcRsK4YYAgNW9jBrGcvzMqZBZa/czPVlDAistqLW49xbxcRqtZl1MbqKsTQ
	kSj7agHLja2HxVHchz7JursyYqAyW/XhP1F00K07z4caOSBdY7FoYPNGEFC9j4NbOqKMgKKmp6h
	6riJlzFq4/tBqTCdv5NJEHkwORZgc+AAucmmmSqKbYHDV3bUcsOS1MRB7IT2pJufP2mNF9m7AJ3
	YEbIgz5L1jRY2rn2+tt9fsf+XWU61F1K49tHRd5kdpBFMM4QcGjHzRjuhtYre
X-Received: by 2002:a17:90b:5203:b0:35d:9560:3efc with SMTP id 98e67ed59e1d1-361404632e8mr20112387a91.14.1776850772398;
        Wed, 22 Apr 2026 02:39:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5203:b0:35d:9560:3efc with SMTP id 98e67ed59e1d1-361404632e8mr20112345a91.14.1776850771789;
        Wed, 22 Apr 2026 02:39:31 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm16097037a91.0.2026.04.22.02.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:39:31 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0 port
Date: Wed, 22 Apr 2026 15:09:24 +0530
Message-Id: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qiKlKpZ9bqkbkbAXiOPbPlC2QOiVyIo0
X-Authority-Analysis: v=2.4 cv=YJuvDxGx c=1 sm=1 tr=0 ts=69e89755 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=UU6esRB091ZTEFAXl-wA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA5MSBTYWx0ZWRfXw+heej5xTEio
 FIIWmWSWCxXgyfIVKt5rk5oV3fcWO/7+RvSQmA85FwL1+6FxEvlMMTeIBOgw7+3BiHAuqLVqTWP
 Ar9wykDIf9RrDPUg/xhfgWh6tNow0scX4XOGi7+wNLWBLB/H4aIFGtxS2VJvQYOP9XN9O5p4+9y
 NkCgxwGGZlWBrD+08mLWCu3w3/Hm0L2nL79NOgV2fL5iAiukStnf2DCgMHKDRlICIUqFLeSJGwx
 JXOzzT4SjERdCnja5ROZhHP7PXLTf0v8tdyQA2LSYXGvsKYABuSzA7ImTr6sVfWecvDlDsFJzeL
 hJeMSNRyCEhJ9cb3u/bPZWntgkVABpNMBWPbyc4gIXV8niFTQOOSXgVIsw57x8whNoTQgzNbcGE
 bwM5YxiVIyGmfq4o9XNF648gBwTNUegbDXppCraF0/GXG3Lh5pKe1KPeUk+umt7jaMhpEwvf1ps
 Kg1LCPwaZSoA7cObyYg==
X-Proofpoint-ORIG-GUID: qiKlKpZ9bqkbkbAXiOPbPlC2QOiVyIo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220091
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	TAGGED_FROM(0.00)[bounces-240301-lists,stable=lfdr.de];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.367];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,0.0.0.0:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.8:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 615EF444306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the retimer for usb_1_ss0 port (USB0), in order to enable
super-speed enumeration on that port.

Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
Cc: stable@vger.kernel.org
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 54 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 460f27dcd6f6..a9ad05bef5d6 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -118,7 +118,7 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss0_ss_in: endpoint {
-						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+						remote-endpoint = <&retimer_ss0_ss_out>;
 					};
 				};
 
@@ -785,6 +785,56 @@ retimer_ss2_con_sbu_out: endpoint {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	typec-mux@8 {
+		compatible = "parade,ps8830";
+		reg = <0x08>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK3>;
+
+		vdd-supply = <&vreg_rtmr0_1p15>;
+		vdd33-supply = <&vreg_rtmr0_3p3>;
+		vdd33-cap-supply = <&vreg_rtmr0_3p3>;
+		vddar-supply = <&vreg_rtmr0_1p15>;
+		vddat-supply = <&vreg_rtmr0_1p15>;
+		vddio-supply = <&vreg_rtmr0_1p8>;
+
+		reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&rtmr0_default>;
+		pinctrl-names = "default";
+
+		retimer-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				retimer_ss0_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss0_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				retimer_ss0_ss_in: endpoint {
+					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+				};
+			};
+
+		};
+	};
+};
+
 &i2c5 {
 	clock-frequency = <400000>;
 
@@ -1541,7 +1591,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
 &usb_1_ss1_dwc3_hs {
-- 
2.34.1


