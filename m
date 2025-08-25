Return-Path: <stable+bounces-172832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412AFB33E6C
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7A43B1908
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530A2ECD03;
	Mon, 25 Aug 2025 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDCU99zf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFD2EBDDE
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122745; cv=none; b=vAOJhX9kUmLePfZ8B2tlsJbRo4GDi/lV0dpnOHOPKssKxYGyA62jWqsbbeQEQI34r6FT1fzn8mh+EPgpn7qOfp3WQIwMqn2/SfYk7KL/AiseJ7Hx6YSo9i+Lhw9SdE4rY+2DbOudndRx5mbyF/0222pUmzasBiNAYddwDNB425o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122745; c=relaxed/simple;
	bh=WrQJ8y2wkRh0Pm9UxftV2Jxk1mcEkUib4bVXH4a+nuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XbDSCB7NEL+wwoRObcATQCX17XuTyAHv8wTLj1+sDAUB6hBR99paYjz99EyPIsc2FyXhS5ug81RTtaKyVFC/89Ro/nXeZp5LRfHvRJFG5ufCL0ZsxNkAkB5zeDGDzkKFePyawMlvPGQhrt1cl5+gdoTPsmpGmgNdmWW6IwCEd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDCU99zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8umYR026177
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1RD0fxwdT+wj1xPAjqTg5MEtJTG2YBJSBCyvEzZQyeE=; b=hDCU99zfPOpo3lqc
	QnzIA0HfHXmMAQ9o6m0PoOm0e+5yfXdqKA68kB3DdltalXW6KJmqdWKAp+YdIXH+
	OwcN6qpBJDO4LGhjBRhol2CJve6gU8Em/7q2rvJZ88WxmyGflnHavNxTPdKaw0dZ
	jtf2p+dBHZ8uIUYctm1cELUA22Ho9dNM9Twy05FhkMzfbXaLCuNy4/oosJX/dAIf
	P+fCseuEvx91k2V3xsBW3FnTLhIy4ar87C4dmfLvyZdEDjwZS56mlKxRdjdRSm8k
	KXmTiw9KR02c25TtJm+cDxbWeVGfpiD9HPsUDHlvSv82tEYE9gVFd/IfjRcSydYZ
	09bc6g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfcyd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47610d3879so3443351a12.0
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 04:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122741; x=1756727541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RD0fxwdT+wj1xPAjqTg5MEtJTG2YBJSBCyvEzZQyeE=;
        b=eE1KHTb8kRRB+Q4ZEV7kCZEtvUuq0L/ToVIZUNbmJvohJMCZ8XCrSBQtwR0nxBYjPE
         5iXyDlrv4xKQhV/pXGEnMgk5XXnMkvXJWAqWGEujvSP+aljUTdeGpcCqf7VYpWomIZzA
         OQ69GJUcq7OTbk+bAYOVrnnaEY+ZJ/VmjWjX4F9GHaBNVhI+YPocs07wGgj96NFsHOgo
         ykunXUJ2WEjoNqIN12kFVN1N7iYPO2rCXUNx5b1zCgCt0PdYTnlDfB0ZMnNkk1ThFdg2
         3GRZzwRKurBEUwhGrkrplb7RbuEjinBqN5ez7t1unajEkaXbeJ8MT3BM3JtnYPBTiSSM
         yZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUasSIQ3RUw11KSgcVHeCgRdPpJWzoq8tA9EOESZ3lf5h78Jb9lfzCT+XdRdjaFDAs/RvJwt/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPF+mK2yRraOhAdAMOKFzJd7z8TYFeAVCrbUKlER8eQsP1psOu
	lbw0z6qINkEXTbVLSoAfkn+YZO+TVPJaUkc9vnqgIYDkGOxf3vnzmkJhMkGQLj5C64xpRF39xxV
	b+5UrnmnuUvaNHnz6+C6yr2oYrbD/ck2DmRjrTlixgstydSIEKEEVS2kIq4M=
X-Gm-Gg: ASbGnct7bnY90Vl0DOwcx5C7acmKblyT3Di5tybBtEO8i9TizFxQMuNIr6GWcxxyk76
	Si/dyIPfss/5tLsl3lOnmGXFGHLEAs00PM2XSvXXbc4jSULBqio2mCkEBZLlLg1RN4uYN2+uZ3s
	maFLlHAaXG6Pc+R//Iz/3M56aPYj1KTJ/ZykyC1wtIKClBXHoFfDz0voVelMXpQUSzEo2N5SAuh
	6xrltra6jmLTxW3Ljo/Bel57D+xebGL4j5YuR/zTN6RA+miW8rRnV63J6oQQdmBlEddE6K5Tz4D
	YSJEs9Im6bCRG7vVXY3LP4rZdoolumDJOwTZfrJJ9iAdRyt5zf+3acdkmohqRkJo2DwDnvFzQB/
	g9VCIFEiTVnnYKCc8pkTvmgu+V4KoEUdFylLODFdnMz1COa5jPMWrURNY281aVl28iZMFxIS8Wd
	8=
X-Received: by 2002:a17:902:d48c:b0:246:96bf:c919 with SMTP id d9443c01a7336-24696bfd54amr85187635ad.10.1756122741421;
        Mon, 25 Aug 2025 04:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaLDyLIvMkQiJKdMioGfxMs/33mkrUVT35+uXH7WGxzy1geJK0Zer8Luo6lAcRhKMl1HXryA==
X-Received: by 2002:a17:902:d48c:b0:246:96bf:c919 with SMTP id d9443c01a7336-24696bfd54amr85187225ad.10.1756122740912;
        Mon, 25 Aug 2025 04:52:20 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:20 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 17:22:04 +0530
Subject: [PATCH 3/3] phy: qcom-qmp-usbc: fix NULL pointer dereference in PM
 callbacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-qmp-null-deref-on-pm-v1-3-bbd3ca330849@oss.qualcomm.com>
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
In-Reply-To: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=1613;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=gZlFwG2FsBtPkQDUxJ9WIqEJzQC4A40Ol48lNH0eyzE=;
 b=D6EbEOJZPQ86Rzpamaut1ppVk09TGRn58vCjBk8qVEa2c4cjy4SEham80Ams0Yh1KNdQlocGr
 ggkfCvnjmIQBBnRZyJ6QA+WIQiSf623Aq6EZmfjH4CwGqa0rTbtvRrp
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX+tLdetM2KIUh
 RucINvhfGQmte7SLJ/xpPkllkAK6DjV/To76LK39fs74FxrtcBWcUik9acHlloit2n8UcOvxARF
 pWkBLJVKQ/bflEo145jsQiD2zFy4NlWTyVceGsA+I8JQZISexaad9jLtFx22p98WKtVgi+TFiTE
 5n9JC+HwC7/YOAosG5KOEHK8yq9hP1ePgnVGFsht27JUiCmri1IMZq/JDLholFTxcZ8T157l3/W
 DzRFdXQMc7hrpBAkVff4YzHYv3TVUC8tVt+sdoQP54UZRp8b0/BZsrYG51X1/XZmfJUBlRaqAok
 DWuZSXXyoBNYugZcWWJPL4/gZAM5o4ey2oZqkvkaQyGeqEvJ7sMA0GW0WYH3knL/ZqEHyORo9X8
 q+kIHiu9
X-Proofpoint-GUID: WYvwZ815Nu3-XVycIDnRhbv0zvUYlXfG
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ac4e76 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFmJHyBsCXrKv0U1x8cA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WYvwZ815Nu3-XVycIDnRhbv0zvUYlXfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

The pm ops are enabled before qmp phy create which causes
a NULL pointer dereference when accessing qmp->phy->init_count
in the qmp_usb_runtime_suspend.

So if qmp->phy is NULL, bail out early in suspend / resume callbacks
to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
qmp_usb_runtime_resume.

Cc: stable@vger.kernel.org # v6.9
Fixes: 19281571a4d5 ("phy: qcom: qmp-usb: split USB-C PHY driver")
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 5e7fcb26744a4401c3076960df9c0dcbec7fdef7..640f6520f7c1cd78f9e79843a0778c1bee790f64 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -690,7 +690,7 @@ static int __maybe_unused qmp_usbc_runtime_suspend(struct device *dev)
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
@@ -710,7 +710,7 @@ static int __maybe_unused qmp_usbc_runtime_resume(struct device *dev)
 
 	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
 
-	if (!qmp->phy->init_count) {
+	if (!qmp->phy || !qmp->phy->init_count) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}

-- 
2.34.1


