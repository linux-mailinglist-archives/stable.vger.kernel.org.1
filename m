Return-Path: <stable+bounces-203524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB2CE69F3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA2B300660E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D12D94A9;
	Mon, 29 Dec 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxT6NwR3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZWMOzJQz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF352C11CB
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009461; cv=none; b=W09dQqQMJeZZoj4u6CWvNJM69PA1pEjgWjC0EHas//2VbUMtONE/Jt4IRIegx5o42BAmhj9rniqYChjf+3ZawIsN7z5Zp5GUr6+xwXKxwZwmMK9XUa04BoFp+UrLlARNUG5RVkRiN3PtWUKyYxkRRjFi15JtTsLxyhMJqR1Zaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009461; c=relaxed/simple;
	bh=BewsNS9SqpxvSCK5wDz0XrlBx7mMNeSs7Khxl2WuUq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaF3OUb8j4m0BmOQmXOHyYAYVXsLvK9OuPBJdROGJcVAfsYhQzNndGsJZxeW6mpCtE4ptqkIPHfDazYQ50XxkrzxeGww5KSRtawXU4XURptbNAwKeZEQV8UI8zsEz3ZUgqJSI44FV0VeIU4sVBXpWKt9ei5Eu9zKy/PQFeglXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HxT6NwR3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZWMOzJQz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT9a6x83252780
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oUAJjDGcfm8FZcDWt4kU/L4+/V1PyEokkxD
	6HwvMzys=; b=HxT6NwR3G+VMJyj1ji+AXjCice5AQD5I2VPB1SbgLWFvTWn9DkM
	VIYIki2M07ERefBq9gT17mip6cyqSZhTy1xUSZkrOlwHCLWLzaZh93S66r6dxdBL
	H/B+qFuksseP9KgHttXZuGzHUcvGVVoVydF+khE4zzfryg++0Bp7XBNVLeC25IYZ
	u3tQ2ccvjEl5EEIIh/A+OxC2RhmzPv1wPCjcrHFtQdOYGJVVytFz2x5VqFnpaDdr
	/aAIgOItbpqEy9F/x2qJpZWJ2xz/1616SKO2VUAajaLw7AtdgckpwHSDuYwnykDI
	RAFKHZAGUNG3MgGmf8YLPlCxq7PQ+ROSyvA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tnvev9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:57:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so221027901cf.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 03:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767009459; x=1767614259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUAJjDGcfm8FZcDWt4kU/L4+/V1PyEokkxD6HwvMzys=;
        b=ZWMOzJQzYhUik71XTO3A4ZsHWh246WjF4DEbRq2V211k0rWOjtnmwnATdBwKiI/4Cz
         Ks6LNT0qxjNSBpm3maEMZJBj3/W3sBRMCXC2fghLyGQ+BuqjH5bwdbJNGGT215vUqd/P
         k66D99q/HeKyS+cDmEg93PtST433hI04JH2Fdryv0NFVjsWrwc2qZCRVpl4LhGovP9Zo
         YiloAmfu+RRWbhsaDwpwfVDNSh/ZfxwYZYkGaGQbxvwv6USzEvT09EYvX3SIbqOr4UZl
         F5naASGuf47AEVDuhrA9XJwm+Gw+WTLEfFeZdjkAJi0NgBPtIrFVMb10rTR8akUFgDa/
         S5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767009459; x=1767614259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUAJjDGcfm8FZcDWt4kU/L4+/V1PyEokkxD6HwvMzys=;
        b=Wlumw8bPslfK7ULa2DDEl7eNGNAkPJ0DXESj2v5D2kKbaA32xGzzROaK3rO54tIFBv
         4JuA92pRZzZwhNAiiPATflPbE8lHbOCKDODFMZyAPXbDnU44xGRyv84JXg6PbfZRHue7
         STVPqrRUAPmogHwis0Drmg6wG6pmBM5k4A/Wf7/lg/XJLK5vtHiiJIP0ZFEM6uYb05uK
         TqJzK6GrNj0B0bopJssngzFR3Bs4Iwxe1uIcTZ4pY8C+ZG+BN38BxewHRuBW6YtZWgTP
         VcE3d8Mf1MCWRvYZTCHfR/CDUyqLNTo8LbOlPWvdJxrKoxvEHgrNcBG1c5+9r5oYp5T0
         FUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQfVgZCltTRkinWO91ZFc5G/heFqaqQbuxUEbN0cZaZO290SP17SG835PFpSOMIEgnhPQ2Q3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY3Ns0IXUwpY65Qt465qRcMXbnUCIEIBZm6Ju6E3dSE01+Yl6
	NUOaZdQZNvFoBcztg3Vj8EGwnJ4egDwCDEOGCOybbeJmLLEhXpEH/VoUDVB/5e2ypCslepuPkuR
	Via79l3ljVpd5DMp9L0YRWQQABZ2duoVe4oa23/6JorUOGVSX7F7mhh7Je7U=
X-Gm-Gg: AY/fxX6yiYhkNg/2BLoy4ch2qMlpZCdOiXQXdsShMZiuNFL2LE7tTMaeC8geZZg2GkB
	QgjKn0GFi0wMAP0C9YdJlhCkhKxChUuImdedUVPjPyaVRzeN3SUHw33s9kbyvK7r8fx0WNXHqnE
	7CYohpfkKOuMCE1nE/4Us8UEyUwRn9Pefdxwy8taQVftv56mtP/Rnpt+M68DOyo0NpdkWAHt4xR
	k3HwDaWeA9zduGbs30WVh4Eqy+hCsYcKke90HsOHD5kSU6OSPz3TA7wEhvEviy7yUrto+vVDcsU
	9oGq0npSd9hT4CpEkFjSGI4kDxURIm4ZZdj1CZ8iZCO0HEOfFv41K3jIlwMgnhyZ7I+Ap9y3GgR
	E0D8uHGbpYXtiUOtV27fvziHKgQ==
X-Received: by 2002:ac8:4912:0:b0:4f4:bce1:31b6 with SMTP id d75a77b69052e-4f4bce13d18mr254122431cf.19.1767009458983;
        Mon, 29 Dec 2025 03:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3MoxW7QO1tS6i3fzefDmlQvpExf/LlB7NTW0W9nWxV7dnxXGhKKTH6k+5VBB1tPTEvZNISw==
X-Received: by 2002:ac8:4912:0:b0:4f4:bce1:31b6 with SMTP id d75a77b69052e-4f4bce13d18mr254122301cf.19.1767009458529;
        Mon, 29 Dec 2025 03:57:38 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80426fc164sm3146571866b.30.2025.12.29.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:57:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] arm64: qcom: sm8750: Fix BAM DMA probing
Date: Mon, 29 Dec 2025 12:57:35 +0100
Message-ID: <20251229115734.205744-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=BewsNS9SqpxvSCK5wDz0XrlBx7mMNeSs7Khxl2WuUq0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpUmyu7ddQWEplHnsukdjz7AjiCdknas9BBtuUx
 OPX0DPyMWWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVJsrgAKCRDBN2bmhouD
 199XD/sEGi1D+Ko8tw7yx2LN4yE99AfHNlDuJrVI9ledkDvYGY40hAsQxO/B4dlcfXi4tkphoOv
 /7xe3B20/BLWYaPCJjCHpo1TOBuhvwYbO0noJHfqaHYzkHsGDlYI1Ldu82VXGKE/+QeiPuUeBmT
 K0oiQfo3L0174esEbB30YOJ/5VZhz8rKC4WEBW4Y3HJN+nBv0++TkNb7HNmgBQR+E2aKbbbssCE
 vjoq2Ce4nVLf/Jvk/ohmxkFitEqQeEjsem+9NNIUcsxpQy83l0dJriBlanzt8jVix2tRDK9lwT6
 X5nRVxPx3oo1kuRjke5+URlVmwereIwAbiR4Qm2cNkwYTEvuqVF5huR3yV5jlR4oiQMDs/59Ak2
 CHjgMbTQJkEM7UP0CavNxtmxQoNONaMm3wT4AoKDk70Ka0dGozs6m+1VfXDftaSA0o/HfLiieDv
 Nv/1FNOdyOQ9c2QRumK+DD/Vg0fhtUiANUPIzBS0FJwy6xryoROAD5HLxvspWfusvjL0pgPe+pm
 anKdX7YOQ+SrDLp3Ul7QeIx9U0EnCWbVmelzutoYC1ANdX8cml0Zxik+UjsvS6aEp+Q1KOmlAe/
 HihAI8kWF7lEbQPawY2GZWTDTCGhxVrtMY5nHGhK4wfW7o249qZjQ4F7KRDT77s4lS2JwBk0vRJ X+S0TjjfzTQef4Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=69526cb3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kLiTxru8Czh8OvV4UKwA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 9JiHHiZ19Rs7Xdk6zowI2DiD5EtMi--Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDExMSBTYWx0ZWRfX43DYlvFmgnND
 yBqGI5BV8d03g3Irbsb2iYFMckL5HGGEdm/fLncD76NQjdn8jfODTlJ18xHaSxKMtsw+0+DGULn
 UAGakURZDtm4Q9Z4ONx38eRyptIx7nMKG4xmh5g9l5gCbeZruSOW8R+tynSsfp4JF3TvG4gwnhU
 HVKcN2Xbcm28dms3Ur7Vy6K1SYVaB0p+QNK2aNdiBzs5ykf/tayNEswYj+1eV0x1nI4R/5oA68j
 IPGntgtBx4687UIzzENJp7hwgVg0PUtpzWkrM+SVNhovHKx8vtkarP3P7XHeMtfQKypuMZGFhQd
 6kZWIRDJE3wV31Y/bMXYd8Yf+S7T2/zq7jtvb2v3nSsAb6cjg6odc1BBsWjl4cO0R5UnvCm0eji
 HlDIeK0tJphgbBD7FqG/bmaSMGWXrX4TWM7snAYqcb2Rvkgp31qNqwX+ioy+v+gk54Edkk6/Aq/
 VAP166r73VhMrinnelA==
X-Proofpoint-ORIG-GUID: 9JiHHiZ19Rs7Xdk6zowI2DiD5EtMi--Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290111

Bindings always required "qcom,num-ees" and "num-channels" properties,
as reported by dtbs_check:

  sm8750-mtp.dtb: dma-controller@1dc4000 (qcom,bam-v1.7.4): 'anyOf' conditional failed, one must be fixed:
    'qcom,powered-remotely' is a required property
    'num-channels' is a required property
    'qcom,num-ees' is a required property
    'clocks' is a required property
    'clock-names' is a required property

However since commit 5068b5254812 ("dmaengine: qcom: bam_dma: Fix DT
error handling for num-channels/ees") missing properties are actually
fatal and BAM does not probe:

  bam-dma-engine 1dc4000.dma-controller: num-channels unspecified in dt
  bam-dma-engine 1dc4000.dma-controller: probe with driver bam-dma-engine failed with error -22

Fixes: eeb0f3e4ea67 ("arm64: dts: qcom: sm8750: Add QCrypto nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3040c02fb6e4..bd555ec9e04a 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2076,6 +2076,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x481 0>;
 
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 		};
 
-- 
2.51.0


