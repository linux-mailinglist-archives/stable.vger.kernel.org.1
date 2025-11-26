Return-Path: <stable+bounces-197019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B3C89F1D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0D341F4D
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FB4244675;
	Wed, 26 Nov 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mljQ7ex1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Thuy54kb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D590267B89
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162722; cv=none; b=uCkG/APvtndozAxE0RDK2FWSN5kOIwspyzNAQreeeVjCVhbewFwkkHT8El4X3qBhKY1Oh8li1ReVgA7SOfb5kmcX8uu+wGbxd/iKKzLMtuzqtWHcPn2SfxHYp0jkLW1jc2aC73qgqLlbGbrkky/TM8ryU+aZykSPno6tC9Dk1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162722; c=relaxed/simple;
	bh=Kx6SDNGGmtR+vCY7Fvwx0dLzXDrGEhUQ+uAXXXTIdVY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NFWDjSyedGjW/8/KvCR3lxDYsdOwwFqA3KuwP8LcOSd4vhIxqsSD/jN7sqA29X2YqX+FA9e4HUcKSwaYvwoXxfiZLzWa9kJvk5V+vFl3ag8V/LRu8DN1+P0KCB+JNH7TjH5w3fHsFVsZWq/cgT30jAZgipTSM/lWzQH7NPSDNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mljQ7ex1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Thuy54kb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ957aC4048329
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=atO2d0oj7Xnc
	utkIW7ClolzNmLa6YnG+2BwUOup5uEY=; b=mljQ7ex15eGMm5My1ngSgROk4Aic
	pc7M4q/4tEvIB8FtFsn3n5Pi5CJGMxHwd0vDI2UEc0mVvki1OmH1G3UqPyKyt/ec
	cIbHnR5mNpIw5JcMK6OgMEHHCuSHr/qNZ5Uq4jZ5wve8ssjnkYRCFHCnEZbU1S/N
	RXTJHxmBLv0sJiNhQM0U86cFRaWvkWAwCHJIcdkVNAgJqHiq2QL1z5FJ1aZpguUR
	+3RjVemxemxOfFdawEIIbjFo+KOoRzO3cdun9mPkBWiCIwil/03lkF+4y5GHTUij
	7cx4d0qly9tAOgn0Bn6KblE6c/Nury+oG9GFwlRlZEzyR+EVMPRfph7aRQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anp2nj16p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:11:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29557f43d56so84731645ad.3
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764162719; x=1764767519; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atO2d0oj7XncutkIW7ClolzNmLa6YnG+2BwUOup5uEY=;
        b=Thuy54kbIyJMyUN5Ye57EvF0dCasKPBcXiYFUZNUSPyrXLGeRFTe+NjtmNX1/KmZDA
         gA7yROj0VnUq7JiH+GFWtpUnkrcCH06vU3dubi9lnXN6TvGYkethPWCg5z0IvHxIKLYO
         skD9XiK4A+HA7PTG6Ecv5O1Qwy2cDnK8wLT+jSIRVilBEPEgAXNvEm36Mbqgf0I5Ntzh
         imdpTivl7mU2BW2s69U7vYK820wn2rRGd9O4JWTQdBB4uxTXQUnqLXkFGMcnlxeNUa4d
         4KWTWgNRLD+RPGqCuanbpjQAw/UOEwvDcED03GOi1mQci8Gr1vd/bpdeWNTvzklfQD1l
         s1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162719; x=1764767519;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=atO2d0oj7XncutkIW7ClolzNmLa6YnG+2BwUOup5uEY=;
        b=apxeIj33NnsEZdnSGhxjEQMFnUbY0b0mKJzQbWS2Qx5cspJUGuWsReH1xWweZ4rwH0
         uMwI1mZayfQWjMMclkHPxfkTBnPmrmC5pkgBdbvINcEvDwxRe9IaWQmSbpQ+TPJ+vjcn
         +805TZy/fWbc/DYXMHDnjT1OSwNj3NyPLQPA/W7BDyBlNezQA6YF/z/Hr15BRTTB5Q7a
         D/MlXetA3VjNfHlMFnk/mrsIidOUJhsgENugukSZMtDTtVuj3l/jbzxErJKp4K20c2QI
         nqWZiolUYp88ltGLZZX52gtmXt6+H1UW15Z/60+456QTB17Ek+7nj9cQIlEYvLCiVLB1
         Lkjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTD9kJC6CWe4mSJI6rQdjeCFLPSNFKmJoDn33EfvcaolPOCx85/7bebm9d9/V7za7NGYog+Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kB+c6uD1f/uDDz3hUch5LEgGHpWD1jIVtEScENg8ohyfHXsk
	7OlGb0m8eHj/8/FK5RTYd/qiUdr3pCAzxB8Rrf58elkF3jfueSupN7EBmm0hyZwPW2W7ezwArnZ
	GAdLyVAlv9OfqfQwfvTq874L0ARatALcZsSAyo0yFFpr9D1cqoDdUilxJvRs=
X-Gm-Gg: ASbGncv+qGSx9s4/Rgy6lUS+d0xTB+o39mB9jXfl+XmylgI3DTTKyrAnh8uiP4Rf8ya
	Ku9PXa7WGE1rXxldUd1bLKReUXi5iIbmxa0h0dyrTsEzk62Z8gT61Nhn9LueRbfRJR7YRGXQ+gS
	vLyWcpSCdfpk4Al8ok8QrOAW8bz2ZD9wYb9haXwvuefids1fUhtgTeXJ9Wbe6B6hyWaO0OroRON
	FRkFVtczMEpfOFRgaon+AOh+zb2z0biv3EjghSeeEr0Skl+q2dLeLz4vEMwFAx8J/hqsrkCXhCG
	PrZgYLF9cMUFGhLyO6/JZrZmwREwgSOyl2Ml2wSXq2yrdu12PWh03JkgeDymP3K4vndJYdX6+s/
	DF1KaKEWzx3vL7/DwB/W4IQyr+aqISy+By5jcRAugJi4vD8nIYwwN
X-Received: by 2002:a17:903:4b4b:b0:298:35c:c313 with SMTP id d9443c01a7336-29bab30b2c3mr77442585ad.61.1764162718671;
        Wed, 26 Nov 2025 05:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw2Uz2j8uYz6Je8kTb/xoW8pe2wn0hP1weQH0XaAMrTvugT5iKNhZx9dgT0F487YDp+nrf+A==
X-Received: by 2002:a17:903:4b4b:b0:298:35c:c313 with SMTP id d9443c01a7336-29bab30b2c3mr77442055ad.61.1764162718180;
        Wed, 26 Nov 2025 05:11:58 -0800 (PST)
Received: from hu-pragalla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ac81bsm200049395ad.93.2025.11.26.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:11:57 -0800 (PST)
From: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@oss.qualcomm.com
Cc: quic_sayalil@quicinc.com, nitin.rawat@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH V1] arm64: dts: qcom: talos: Correct UFS clocks ordering
Date: Wed, 26 Nov 2025 18:41:46 +0530
Message-Id: <20251126131146.16146-1-pradeep.pragallapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=KerfcAYD c=1 sm=1 tr=0 ts=6926fc9f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LC8b3lGDU_EJS_S-YZAA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ZoBxM1YW7NKGWBq6tOeQOltxbj9U7PG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEwOCBTYWx0ZWRfX7vElaSDIQCed
 mRrDE2DX7oWeGDTbJgDaihSuK+s3oTJEjOvCWXvs81dMKacubYlZhjlD14/fvlou96qN0uDcm/1
 wE0jbeMaJ95T1mLz/7jgUwcbAJBoJokswUEjaIS37bezepYALt+2M6DfOf/FGy31JaTOUkEbNZX
 QWGWhghyGnRTD+sBbESMo5IAYvHQjuhqmj07TsAnv8MdR4DIR+lQTY9hexDsWjIEn1rp79u6H7f
 m7fNcszvqGtfkyjwqzijghaCs9CRhMX73dMXAl0QYFYcbIOyyI18qVoLtIjEXJ4YgOoNs44yCl6
 UvJEz0b5mhzShYrrcHo+jya7Obp4JEn+yPv2hxgBhYYkWt4M1zK+yC9nrBh+S2ZL20vUt6xEKL0
 NKEJExwR/W+YMdJ3+6XaiqfRmbk3cw==
X-Proofpoint-ORIG-GUID: ZoBxM1YW7NKGWBq6tOeQOltxbj9U7PG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260108
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The current UFS clocks does not align with their respective names,
causing the ref_clk to be set to an incorrect frequency as below,
which results in command timeouts.

ufshcd-qcom 1d84000.ufshc: invalid ref_clk setting = 300000000

This commit fixes the issue by properly reordering the UFS clocks to
match their names.

Fixes: ea172f61f4fd ("arm64: dts: qcom: qcs615: Fix up UFS clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index d1dbfa3bd81c..95d26e313622 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1399,10 +1399,10 @@
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
 				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 			clock-names = "core_clk",
 				      "bus_aggr_clk",
 				      "iface_clk",
-- 
2.17.1


