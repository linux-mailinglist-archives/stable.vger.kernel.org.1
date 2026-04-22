Return-Path: <stable+bounces-240296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEgwH1eS6Gl9MgIAu9opvQ
	(envelope-from <stable+bounces-240296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB386443D54
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E791A3038294
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BC369206;
	Wed, 22 Apr 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kito6TtU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Btne9T18"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55103B27EC
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848794; cv=none; b=Rwvww6Xoya789UCmBNrKyyFbj9rQIcLvt4JGngSlpWgi+Ug9ylxDtL5iz1HhBZtNjHUMvhtMPACSTdunG99c53FMw1W44MfQ94EVuu7+xDbkabu8TWlcxl2JcjNL+oXNKYkwmMRQj3noCMhAZZ+e6R91O7e30Zz1bIFxQlkRgos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848794; c=relaxed/simple;
	bh=sQ5ydDIiuzHce/6nFF8sLHx7Vq5yR1NpajPOCPVEafM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3DBzbCReVLDuNYLP4mXBqH7PHtrBifu3BzxLj8gVVQSoEJ4tfcwLKSWKDOnq7ct1qGT5vgcBGQZJb9iQa0bdcKTc+jFrmdUuG9lwYcsVcM8jETu2icq+lxp70G+1ILGWgw4Q/HbdG4JfYoBciUwVi3z33NhD8SoeXVYZPRPBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kito6TtU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Btne9T18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M4jPFK4051042
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1s9RK2TaLIlNy2a/ptNujAIJZ9k0XQ8BcyE
	A9GRA8C8=; b=kito6TtUT9YpQ7UtfIrNz1EiO24R6fevooDa5yxAF57zxjW6GO7
	DCl+HvE5gWiG1Ls42+5PC9cG6Ve7alkumzNoePcZkjWPxi4e9jsfAWn+gIYnlFxm
	6vmFn11B8LvDqE8HpnoB+VskTJkp0ewBtWb8hRakPrdwNw5KkV205mFz/amO5VhI
	u3724tvfQnHvdLWAsI2QYf4xZNU1s3WaE9/oRBlW4FS+nNaOzI3nts6Ypy+/XWyj
	nYmPs/8jgOe3DbEXMI98pD1e4GUkEciKttFtwQIUaCtxlBzPo3R/IQoKpZ9HD4pM
	9rtyqFZp8e6ZyGch+74Oi+catPkbdUvpx+g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfjpvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:06:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso2541578b3a.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776848791; x=1777453591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9RK2TaLIlNy2a/ptNujAIJZ9k0XQ8BcyEA9GRA8C8=;
        b=Btne9T18WjiVk27CWqzvddAYmkkUQQ4ogQoTl87VdD1erZ8Aq9pT7sLkWnDmwJILK5
         2IMhhobbF8NJFMBTGhCb7rEL7+mmts2JjBDmRBWvq2/6U6ckSdDS78rHdx9CuBpbScgC
         z2nEYBoV5Xdhfq0KwmfxT4Djq3cdtk4STRMzSTeO32DW+U/rxCyoMItZuABT9YiP5F6W
         LbqvsF6utvXVIQPgB9898CxN1+zCK3+HzXqMqEot5ZcbMen8xoZ8M3Z9dTurvFt+xG6K
         mEaq9jHqZSkfXMZfrYi0i0v2ZkedSEu3aR0CBPFpQV3oQ8W1Jfm0VpJ1x0bzCfDb5gvE
         FDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848791; x=1777453591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s9RK2TaLIlNy2a/ptNujAIJZ9k0XQ8BcyEA9GRA8C8=;
        b=euZ025zJHOxWPJByiJBaEbqvVPXk2OMvszG4JHisVd/2z+oGIX2EOgn9xyqdCiWVQi
         L8IqSeHXbT9pGIvYvZGCrgrUndK+nv7JMJIp540VoyGGcEw6EWSNtLExvmLf8Z9tV3+U
         KlfCyHuWLd4hCJanpo50vR5xIHPFoEM2tHrzUKLaZDq6tiiNcIVT8YQxdGxByWvmJodk
         XjbfeXtICYFWkELnqP2UqsGqv2A9J72zQsEjMGl05t8mRDhvkKveaylY5Qc/lpMRbJmr
         0hMShhHCMf/ZbG3zQbECTAnDfyhZkh68e2tgK4+AXYeo6CNl07WxI4hWsTtcY4nFGhBG
         WOWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6+rePvaDvdXH4te/ILcJAMTgJsB8rSfuZ0Y0iXpcSKn2hwZooNvqKS7BUhLu9Z5OvqASTrXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMU7cRF8/kM3iI09bImtvrjSzW7aT7covP4Ys5i9AXVncBKYwZ
	kRp67eJJEx3Odu65zpxtfygLGUcCPLjo5UqnNUnd6JJp0EnxcsISPXOBixKcTfL18WglMCRfZ4h
	KgdMtBmE49VnGsncFV1YTdkgI97mYdrMQb6d/uageZ/HIL/2WPnH2imT9exRDPsxa19I=
X-Gm-Gg: AeBDietlw1MIfWopajjsEezPaW32yGclFvw/fprJ1Y22B4lNFbbqZZ6QiAXQ2ASlOM+
	fmnRPJovOh9SahzqmjOQ4fp8/N5lLzDVOE5fuOpqKarSP9CT6p8zgI1nK5/EF2JKb8P9Ak/tkJn
	n6A8KB5pnh9FuNh0TXaKjcvrTPydr4J8JmCv0oPCjBrwpAC6ipopAqDbAvLqgNt/ueYnqtqLRg+
	cqmcBNmzIkdZcLOWLnrX7sIubdK1AR+y1q4SDSymSp2t3r7yWcc7/gulkxabooDWcX/Apd8AFL8
	aP8GmVev+Fd3xNLDSSzUbqmwj/pFo6LhH0j5b6yxJofbVhGR8lzKZGlNQWEm4saCBT8DRpJ24Eg
	yCc/Z+4ZRJmh4YENGVumbCYe9VvKSxZqgbE5ZNDs13U2PQt0GStpbI/wkUkr9
X-Received: by 2002:a05:6a00:4b4f:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-82f8c94401fmr21730956b3a.35.1776848791127;
        Wed, 22 Apr 2026 02:06:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b4f:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-82f8c94401fmr21730918b3a.35.1776848790576;
        Wed, 22 Apr 2026 02:06:30 -0700 (PDT)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9e0f40sm17834057b3a.17.2026.04.22.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:06:30 -0700 (PDT)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0 port
Date: Wed, 22 Apr 2026 14:36:24 +0530
Message-Id: <20260422090624.2948669-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4MyBTYWx0ZWRfXwRQmNFDBWx1/
 QI2XicCo/XF4F6mwyjTiUiXkQhpYdtwqcOI/KTu0UGea7kWyqpl0o+bjTTQgazQKx2VrzqpqIeV
 khTElELQpvsacont+Q838giA/xL0e26myZR68tPan9MpcBzNPOaRfnhSOIOugqpWAT8+xSpphuy
 TgNiQtJB5dKUd+MYUKR5ENFwZC9KKRCkUNtsdv14KwM8ubQMpwkE5Vctrwaz/uYFikDJssTxge6
 H2UNI619olNitowK5af6oo02zUMnJG8SJcj2ftkLNwOC7Icyjoec67rBO5gsdA47FY/X4I3zR35
 1aXqjweFL+9XoLmpOIQSgkPGu/OZ022OH9Ysj9uiu9pZFkvCZqQQGnbg0o42Cmbi0MU7zp5RHit
 cYLfRTKdj7AG2vqv/w1RLu6WcMgX9Q5c0ekzCJk1ujTdcYj5sjv+ZOWBJ1+cZs2eihMnYrqBLJ+
 DMKIewy1IrWYvyrr4tg==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e88f98 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=P5204MnaK-Erwutjw2sA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zKw6dBK26o4QLhTdJ-9318d3X0lscGIA
X-Proofpoint-ORIG-GUID: zKw6dBK26o4QLhTdJ-9318d3X0lscGIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220083
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-240296-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_SPAM(0.00)[0.389];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,0.0.0.1:email,0.0.0.8:email];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CB386443D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently while connecting super-speed devices to the usb_1_ss0
(USB0 port), it falls back to high-speed. Add the retimer for
USB0 port, enabling super-speed enumeration on that port.

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


