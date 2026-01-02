Return-Path: <stable+bounces-204446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0ACEE14B
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E50AE300F19A
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED92C3278;
	Fri,  2 Jan 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gRUSGiR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STEK9dbk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF02D6E5A
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347015; cv=none; b=uh39b03Z+9K/0LsBf4F5RLeavCE+aafGaDsFYDPBBmnpZv2vETcF4rB7v8wNXwGJ39/tNl2qc68gMRoOBCH0liqLVRYgT7rNuz3jPFk0xbeM4Rp9zTjOG0HLthPy26XXUAl+E9M6Gd5ypPH4xCZoBpjHXcH1YhPNosUUmJlk84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347015; c=relaxed/simple;
	bh=XWV/wiMti0j+LrV/v/Z4jEKFQZ3FlNsqfF/Lgy82Fcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gl0dUPNhzz4YRc23dS47kKiftJYddUukm6CBB6yXL743Djr1B7A8tiK1Zinjfa+axIDism/4omoQiibpEtTUkEzfOYhfUeeY2uDivodLkFJVbHGUaf/SxJdwVaUUcdHgk0ittrmb3goHNMeqEFJdMFCyYvcSF6IinkfSSeSL9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gRUSGiR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=STEK9dbk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WFri504788
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 09:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JB7hwuiRZo4xET1vDRIYfFg56T6wWX3e2ytUVrjm1QE=; b=gRUSGiR+yflpye64
	q2KRm2VriGAIlxLq1ffiinjm3E9SiwhoHA4/ABk38GUh9Au4ooNRA/ynIN4LkpcH
	Dh7IF6gwldgVjkMBaRNOAYD5PLCAtMx34oq7rv6TYRMSp4etOjMh3mK3duRycvCY
	8eXjjm12LEDS8icAAKP4jhSWhx3sK6tGc06SBrueoqtzw6gEJ6U+UOFn1Lhba728
	5wTy5f2ELp9eyHtHKKtZKb80JM3rTkzrgFWtomCbnrOzpq+Sff5wgy22WCUz8WqB
	UPBmRHnmM3+52r9CTnH7j3DWV0WlypCc21YjvURN98xjQqQVJ2gXEXsRdVY+91au
	brjlFA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4be8bk8d0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 09:43:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso194870345ad.3
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 01:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767347012; x=1767951812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JB7hwuiRZo4xET1vDRIYfFg56T6wWX3e2ytUVrjm1QE=;
        b=STEK9dbkQXtOKQ/ldKRlHo91w+sX8HiX3PT3hArT0RLYNXPzupAbUY+pqTCwMJzYhM
         in0Jk/8AAfmdC27V7CI9adTyGch2eg6tuwMvoYMfuSDzQEfrjn/KQVH+aS7h5Abmq3eh
         xu1mq6sDF/OAFxKnCjMHNibJW4+d8WDLq9mWgsPh0Ybij7TUVU/Nj2nKixGIv0Ew/xir
         YD+/ozXjkblGnwJGFfeTTP/tcYXw8Xzp163VZsNag/deH71QK7oaY8lHPhoOqn+AIXj9
         qPkCTB8Jgxq3e3JsMPGcYxzBkor0EPTY7lCNMG4AzJie6676qpn03J2CXBssYrDpznSA
         T3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347012; x=1767951812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JB7hwuiRZo4xET1vDRIYfFg56T6wWX3e2ytUVrjm1QE=;
        b=I1AeWofePEvzthtOgfk0nMwuehuD/cQ2WOhL3gPut07lBHtxl6Sp9dm4tlcErE6rOw
         HuSGD7C4SxST5DjP4slBtv9b3QxZFjZtxWaBUcyfHj76ER1rTg3iOlSIqRXOkwQ7Vmuy
         ZD+MVxPXDa/R1/YJpz2FYff/uRe+3++4sh8rq8LXIDV2yupljaY25fn58JX7AhXNxQDd
         dVwnD76l+8amGNKr1d3IAxRpWL8GilkXJmG3A5Ek38P2c836bGbDD6PlIASkqi/45OKZ
         uSUCrIMH1ptt7w8ZT6TTqEPLvsxIavqMO46Y3EucwzbLzPmKG8ys0/hQmPGzOivZrswh
         qD4g==
X-Forwarded-Encrypted: i=1; AJvYcCUmgivU2pWJAECJg+/s39BDOgHE1NwXrEyX3HXyeCkfGoSfEWbnAXwhQmGICXFzs8lGV100AhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXol0ca7J9g5E9MLdcBucEubrpU1LWlalLJ869ObPcyqw5oFDg
	1zRqNZebYz5sSIJKTAZeKmYP8jcLb41h+HrwIrdozxFTDb7vFEmOjdGlNIthqgw4ipp7LEpnxdF
	gEkHjwpYPLMK7zU/CV3G390HCApd8iRwbLMb4ilLdOf0Ut9AtRDLVpovD+Ps=
X-Gm-Gg: AY/fxX5CGmC3Z0fKA6yFyopbJbA8jWP/47KiwuzaGzljHhfRgt9m1ziJtm7KGzDLvGS
	M9KAqs7vW2wqrBSaayEkocflwseHwDv0TxawwYBfOWwUthS3wajbNsNNkhGr4obrsgHDhGpwDuP
	p5/3fCROAxRmn8RjLjtoOwe6x7/HNIn/6tqVSXyJEiFUvmO58ZCykFOR8lyrA7UYe+0b74PZNnu
	PaLpzdXs85xXcTlGWR89dYzJMSTRG3gyzmTZxHM4zJpbPHoyVJY0F9CETVhw6FQdwszYd4nyNkV
	F89H/eNTVRqcNE6N0JgsCsmuZRmN13XMamBWOnmDeqBq0Cn0neCXmmE9aFEYPApQH/fvKb0CChW
	I0dxXmbqULsIUzAEH65JnTflBQkMaCYNR1oL9eZnGcqLv
X-Received: by 2002:a17:902:f68f:b0:29f:1fad:8e56 with SMTP id d9443c01a7336-2a2f22049acmr450584275ad.6.1767347012263;
        Fri, 02 Jan 2026 01:43:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhlhtaXG5OsG1h0mp8RwKg+DT8zDGhYOuhsQqle7zgqDlMdejCBeYAk6HCuBnd1vNMjgoFSw==
X-Received: by 2002:a17:902:f68f:b0:29f:1fad:8e56 with SMTP id d9443c01a7336-2a2f22049acmr450583995ad.6.1767347011783;
        Fri, 02 Jan 2026 01:43:31 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm376154255ad.10.2026.01.02.01.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:43:31 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 02 Jan 2026 15:13:02 +0530
Subject: [PATCH 2/7] clk: qcom: gcc-sa8775p: Do not turn off PCIe GDSCs
 during gdsc_disable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pci_gdsc_fix-v1-2-b17ed3d175bc@oss.qualcomm.com>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
In-Reply-To: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767346994; l=1401;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XWV/wiMti0j+LrV/v/Z4jEKFQZ3FlNsqfF/Lgy82Fcg=;
 b=ZiOafuSgqrNoKWzDz10Fp18Cn71VALIMfXhyts5U4XInt2ii753CsccSOLhmicHetirjzDRWj
 Xho+N0leocCD+zTjaoK6QQ+GsIOpkeDq4s4NMJCwfR2mkWIr9an42ZL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4NiBTYWx0ZWRfX1neOfkoMQoKU
 dz9bddg31R6AhJYs5FM+ZbIJFgWOmqvvZG6CJidZEJxPVhkytz7BgfmRw68LRv5Xtpxwpt7IeFu
 DFOzLlOeJjw5azkoKdMRk9LjNehk+C9RzGCwV7Q6dcRyvVaYozRnEXDjQ8crNaBuKTnqJGlrEkQ
 kT53OdUxsTx82gnthODETQno84FCTStNc0xEz/Nb1PrsuK/e8OcNTPScY/Kpdog59aM0zbE32VR
 VshwdU2xWm2yc/tCna/wY0b2B8OVXRhkrMkL//oPZUDynxxvmHubizHBjrZWMXlxuRvpF6VZ1Kv
 IZITdhJ+Y6UiCXin4QpJ6Y83TiyP9IXD72K2LtJMAy+K+6LuAhNszSy3cALSMASzX4Roi5bJo5+
 Jf8KdBNMHGCypkvWlswNoO1s+pHIlsUNS2ltF7cIm2X3mYFd3gWOcKzMinRPfAZzsXqtZpjTQ9z
 f6QDUKhzKR98ldZeJKg==
X-Proofpoint-ORIG-GUID: Cl4b5jXRtlPBFTikIwZHvm6zLpoU0mxX
X-Authority-Analysis: v=2.4 cv=d5/4CBjE c=1 sm=1 tr=0 ts=69579344 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ByFm4HHrRE6C6VNyrcUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Cl4b5jXRtlPBFTikIwZHvm6zLpoU0mxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020086

With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
can happen during scenarios such as system suspend and breaks the resume
of PCIe controllers from suspend.

So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
during gdsc_disable() and allow the hardware to transition the GDSCs to
retention when the parent domain enters low power state during system
suspend.

Fixes: 08c51ceb12f7 ("clk: qcom: add the GCC driver for sa8775p")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-sa8775p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index e7425e82c54f2355015b58f5a25f11d2fb5020e6..b2e8639e9f09194fccde927466dab0f179e08e01 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4211,7 +4211,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | RETAIN_FF_ENABLE | POLL_CFG_GDSCR,
 };
 
@@ -4225,7 +4225,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE | RETAIN_FF_ENABLE | POLL_CFG_GDSCR,
 };
 

-- 
2.34.1


