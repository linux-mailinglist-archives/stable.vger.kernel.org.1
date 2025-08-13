Return-Path: <stable+bounces-169333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11958B241B5
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 08:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E17A7AE05C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F22D3A7D;
	Wed, 13 Aug 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VDVPCiKh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A12D3723
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067138; cv=none; b=ee/qHZXF8TwAZbF0RVThFYiC84fLUq3PNtpGalX56bcyBuFF26JZZ64pKMPnwMr8pL/PTRR6oDR2SwnsyEaGLCbIIu1xxQOBta26d3E+InPXSwWRV2xCvN0jNSYUQStNUfC1EA/J4Ru01HvqDE0DcluLnX04QL0hzPj9q67xjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067138; c=relaxed/simple;
	bh=rXp5CgpdfOwq6IvtQTfJNHezSgRGwP7XgoOkdM34CAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Til71Sl52+G0flClsZ0MbVlXprL8XUgxMIt2MwuA3UwHSRVk71Vf7uGooI5kj7lR3zQ1D7ry5Y3lt34E9hYATDV361G2LgNQbXET6ckzH5WrI9eY81RNtZxmvwxUQaueWRzFQ9nzmMLK/wjVI+NtxskwJoWPwvmsSfI5WdjFoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VDVPCiKh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D643xp009553
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X18+UHg7svFJzutDLuLGcKihBz8fvMq6lXl
	9O85SJg8=; b=VDVPCiKhd7wqr8qb45I2gzPhX8OXurZrITlNVdC8eGcu/MrElrg
	pCFEw22LxaVcjfYhm6dOjEE+V737aWYCb2MknciswHkVJ28RYA6tnm2eALeZzhNF
	hrrVIS7BlN5flqYyx9o+6OzbfDBxJpw+aWVp5SB9qy8RHqHx9C5p4vRDlw9nKlpp
	I2tOpJjnYG75nPPpDvE7fjq2uXobuVRMELA7ZOVx7atMuncNZB8JWzmAp4Sw/L+j
	FosgZHrrSYRSkzitDPojVOayr9sai8PSf/RtPul2SbSq3kYOLFDOGkHej75QQ12u
	2pxtbt+UsWkbGa2YHQapL48kPD4C3GJYGVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjpjvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:38:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24249098fd0so68297465ad.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 23:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067135; x=1755671935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X18+UHg7svFJzutDLuLGcKihBz8fvMq6lXl9O85SJg8=;
        b=mO80oqhLYalQ2GEnFORrib//SNUwcdz+GyWy++rTLHSmBiK1DZH9x5BD8U4Hbg0fVa
         XbehsgIcSDJEQzJwNiQeRRhmRWr+SczEOLzNDJJ1LzVH9PhV1W3tDfuEmvvceLHjHwk8
         p1zT4StAx63V+NPmvB09I9CzNB0DHrGgUtO/Hbz7dW+x8f0uvVADuBc7lZcrJ6lSuTsH
         TNb9IrmjPMGKc/NFIC4/vBaQnAWUMQcFuPLSOke4Aq995yzOE/GO7UmqH2iBT/0/0YAn
         k82+d36DIlgjTeMsS5r+5Zh4JoCmC44bOq1kVAMpThKU+DWSAuXolCUodcWPvZ4NnMWK
         r7tg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ktwt6uuWbN89u7s0w1/HGxwdYN0/+1c2YLWjG0xNcvHM7ERh8MxhSpHbG4t6nPrh72Jb0OI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nmBnnzGUMoX+CLhofVSEVUwJbeIKTpBOJYgL3jat7WB+EJSE
	YJiw9s1lQMgClZO+kJES1NDRhwiVF17DBOoO1iRxDBExqp5uQk/KcPdfhoV6DxjPGWgxHtVNfQo
	kbd3a1cEGyILTwTspGEJWThMr29peGcP2vfjjN8Dqpx8s7iqf21LFmJe8zU8=
X-Gm-Gg: ASbGncs9R/TXEu/ZIn50c6PLME4AvNGFl6uWpDmoAi6vgeMTEP3p+VfMz3FqL11tkR8
	Fzso1xFrMa+ujnQkgGd6R5CcwEVdmCpZFdh/QaRjXIsLko55ti8d3ASEHcUiQZF8/ffj3Z6XvRE
	G4viwEGX+5Kq4bYH9UfVCA5HjNCBKB6X3Q4ktqW4LY4SLhManPXLyLx1tiq8c1oitAr4QlSHb5W
	bhfaEjs7GX3mp9EN3fvfgd5jwGB9dwMpIO80X9tvyVszNN5Zp6HCqg8b2BINfDRyKjXeAs4XRFt
	bwlxvlQtttKtTXk2R3secsMPKLQfelLeI0aVwuZFR8eF7Awxp44j4729laBg+ymiC/xePgU3U6P
	yEw==
X-Received: by 2002:a17:903:3c2c:b0:235:f143:9b16 with SMTP id d9443c01a7336-2430d1e30c0mr26615705ad.41.1755067134611;
        Tue, 12 Aug 2025 23:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2uBR3ZPiiG7SAkxHbGW8wZNiVA+HlrNvkHKaxz/Lc8LMbuYKlIhTOF22do5XE5gFKhmT0Kg==
X-Received: by 2002:a17:903:3c2c:b0:235:f143:9b16 with SMTP id d9443c01a7336-2430d1e30c0mr26615445ad.41.1755067134156;
        Tue, 12 Aug 2025 23:38:54 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24309a18411sm21766305ad.146.2025.08.12.23.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:38:53 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] arm64: dts: qcom: sm8450: Fix address for usb controller node
Date: Wed, 13 Aug 2025 12:08:40 +0530
Message-Id: <20250813063840.2158792-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX0sIW6rVPMgvk
 VNBBcfH+fmdfcMfy275V/PKeh3/U3qH7DJSQcmYFXNBztUndVKNc/SXsDSVT4C+YGipliZ3YOmA
 4OyKNPbTOmigPh1xoq+MW9OnUWN2UP14WQ3aKAJWwmzmOGWAqw/EIX2OZLQOIhleZGfach/qC/q
 8hLnO1o+sFhOJj2k+2ZPTHqFkWzvzfzxZmcSMz+GkvOhH9ULBy7b/znceGWZG/6FxxkAKMFYCS6
 WCaMNxDEOKEJjTiXC+5p6LX4J7448zgHRVc7qk2oG8wM5J+X8m+omBcHTWePrl5/t5DnSC5ekfB
 +FqXJ55MPBDqrT3Mr4rkvmC+9iVDeooH15BRxBB7JetOaRtxFdM8BJ5rjOjy0Xt/wV22g0wymnj
 Qc4+7u4S
X-Proofpoint-GUID: KzUHo5hcug3OCw6uxMJYfksYIqKxCdyb
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689c32ff cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=1MfqABlD--IGNdjwxagA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KzUHo5hcug3OCw6uxMJYfksYIqKxCdyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

Correct the address in usb controller node to fix the following warning:

Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
format error, expected "a600000"

Fixes: c015f76c23ac ("arm64: dts: qcom: sm8450: Fix address for usb controller node")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508121834.953Mvah2-lkp@intel.com/
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
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


