Return-Path: <stable+bounces-217427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO5/MgTwlmngrAIAu9opvQ
	(envelope-from <stable+bounces-217427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 12:12:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230515E31A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 12:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3929E301F4A7
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF333D6F9;
	Thu, 19 Feb 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aqpv5oaU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NOZBjilY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEE239E63
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499521; cv=none; b=WMHY+CVSw9J/Ljv7E0aBIQBee2g4UlLkV0/SHVWq7XW83UFIVy3wnMqMVil4m+xZiFtDaF76wJRI2dhyaHoZAgAX54pRLQAcpMLTrx/xnyTYtlPnXCFIcDvBQtiRlk74hP+XU1Q+cosB3bjPWEH+I2UobifR04tH+uUZEpNt9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499521; c=relaxed/simple;
	bh=zbxY9b0ZlCq0UrOIJd6sjF+e77WKY8qgVD84bS+Ct8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EUpikfeh+1qFXO51p9au/5DRp4Ysv3ul3oJ54Z47oHc+luA45uLia1Igghq3lnLbfCZ2RPuQTnPiUXZ1UXjjWgKjEQ2hnBQNy28+hGtSK1T+10KCJ0ae9I8l7H+x2IN4nO01MRyGgtqcJEyF0FMETd4gS5rMFvJup+fEflHKNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aqpv5oaU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NOZBjilY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INleJE1924861
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 11:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vOvNdYCVSmVkwGXEsNxSmL
	jxoujgZy923FLHo8wDNN8=; b=Aqpv5oaUyjdHA8YT96METkbU8yj35aopI7zRw6
	jBkftnIdd1qZnD2+IlgvxoDfcA1BPPcuyCHVfIz/WIRaXP+s0uECHK380CWhy0Z9
	Rx542b8z54/9SbbNEqO1pQqegi0owcFVoUXfB7W+a2nFwWqNP0HtYs4DF+02FdUB
	J3DDy99883M9ebjyJ76dEgjTVcep+rG+y6fFaqYlsELBn//ztKHH2mM6TP2clCrq
	DBNAKB94Y9WxcFmllRnZUrgcRH3vbId7u9EAiSwF0L0oizA4NR4NL3MOAjurxzSs
	8Q+nm35AFNS5DDlOUkIeibl3wezeD/r6a3ZvIvncrZjzUiYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdg9dj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 11:11:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506549eb4b7so91690331cf.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771499519; x=1772104319; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOvNdYCVSmVkwGXEsNxSmLjxoujgZy923FLHo8wDNN8=;
        b=NOZBjilYX87nyoEA4XTcscDaNuGrsRNqtof71r+4JLwOD3DvTOsIQmSKL/R5qpItSJ
         BMenyfDp1QZCfEoPP9Himy8OjtH0DT6Q3lS1JFU4Vg4hCODSaF+q3uqijqHXoIaEPVdD
         uofFwk4AdVb6XJfE7U4mjoJGictPMpNVtyoFPpFu90jkGQShMdatYyAat4lW7WzVACoR
         zSS2/bvQOkZQ8i7yj8JV/ZvssK7/b0a7gZFCjJH6oO3LvIpmARYqujz6FhKV4D62A/OX
         DdDBUk+YjZi8HdUwdzFASuWoc7dMVEPSy8NEAu/2EbdtiT+M/+2cJbfhBzMbGhbfiqwr
         pP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771499519; x=1772104319;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOvNdYCVSmVkwGXEsNxSmLjxoujgZy923FLHo8wDNN8=;
        b=vxzN/YQrdnxoBIE26ds2rNAIAnnkGlteDwDN7nEcu5ZAWkM8Rc5ZPKcRisGLOfRbfo
         /dFCzpTT934y6DfiEZqigZi0DBuq+NJ/dcGQKBxdt0rm1uCZOVgxPQ6Gc61YEY4iYzEO
         vTMavht7l7Y1rmwtWh5L2/pRmktS3jM5Cqv7dvM1wEYu6a8ne60C29SmZWXrrKjul7qC
         6y9efSQBfuDLe0Yavp17O8ABiynyR6CXQeiW/SgeqyaiJd7uzgQSPOMMIh1+7jBbWS0Q
         gjlS8UHfiXIuETgT3x8JbfGL1REcYj8DsuwQ1fd9nw7ktzhwQsfJfuKzk6EoVrA0CEuD
         NLWw==
X-Forwarded-Encrypted: i=1; AJvYcCU8bo0irrkw+bzq0VpMHS0Lwa6WCSCyr2/Q1/beWAOb3y5WcKF+SIw19bvRqMCuScJQPBAsHC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxZJ/+Aq3vfsa63hJnKy2hob8zwpd7mBIpIuEVxHPXQdh6AK/
	5SpfEy1R+96Hu/CioRNE0cx2HaR6rEV7h/UtP0cTT+E0XT4hz4LwYZI/O42YffOGuih8PuEOnsS
	ZkoyZt8UwRNOCFHSusAklh5k6ATWO7AiZi457t7P0xETYVibItNy0j0rxfOY=
X-Gm-Gg: AZuq6aKehyoARihFdsWc/GNYP7Y3P+NqTluxyPt42K7vsIvu48lUa73lWS7bNaUEXu3
	4VzX1wZguv90TUJe8mbaWr8FRIwwEnGV33/UgshJzti7fuBzpHME0htqr8vUxqoEMTiRivWeasH
	O56UmVbVZSqxyN6Nw95Gl5rltbpk/Mw0f7X5yL50hQFDWRHnDw/sWdlU2akedXO/AIn+Rtj0rys
	ixwFT39syYpL62x5SYPIM1F4kkDSURSMUDI4+5oUmW8Vz9azWCaZ5sVvMPT5LBC9zO1kAMb0fXE
	2x6AM1CHQ8A0Zs2Qx8HcKXnf0Q+EvpF51hBPzXzAK8s4rFPcL6S/KZ7H4z7Ml9QZpi50Rdoh8rl
	OgCuZw/DxJeo55Y8XVUp6doAXG3+GEQ==
X-Received: by 2002:a05:620a:8bc1:b0:8cb:47b4:165f with SMTP id af79cd13be357-8cb47b4235amr1650124985a.14.1771499518408;
        Thu, 19 Feb 2026 03:11:58 -0800 (PST)
X-Received: by 2002:a05:620a:8bc1:b0:8cb:47b4:165f with SMTP id af79cd13be357-8cb47b4235amr1650122485a.14.1771499517898;
        Thu, 19 Feb 2026 03:11:57 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm1003935615e9.0.2026.02.19.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 03:11:57 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 13:11:48 +0200
Subject: [PATCH] phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-v1-1-f136505b57f6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPPvlmkC/yXNywqDMBCF4VeRWXcgCVW0r1K6yGWiKY3GjBZFf
 Pem7fKDw38OYMqBGG7VAZnegcM0FshLBXbQY08YXDEooRqhZIdp2HG2U8Q5Jlw9ow8bcmybWmC
 yjP0VF21ehJ2T2nlZi9YbKLmUqUx/V/fH37yaJ9nl24fz/AAhDg4CjAAAAA==
X-Change-ID: 20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-9d1adf1508fb
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=zbxY9b0ZlCq0UrOIJd6sjF+e77WKY8qgVD84bS+Ct8g=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBplu/2nLEANE/+RGxkee6qF82zBRu6o+t4/dBv9
 RHpgPiujVWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZbv9gAKCRAbX0TJAJUV
 VikkD/9vK/KxNfCrXsqpjHZTVapOxrnG7w0vh7H64jya46zwEV8JS2fwNSqFZf8Xr4ulsRCeHcU
 7Ij8VIKnDJmf22Pggu+h2avvL56D6hm1c5r1IJl9Hqy33Qq+uMORKJKMTJbyBb18gfrGmz+7oTh
 IAt/IQfK7TfVERp1KX92Q1vt0C58d0+icEYiQyYA1qsXuodRTY5zlwzUUmhAtvehLGdAkq8Ydo1
 zGQ0bfxLTQ5A13k3+ahnMmOtpZdCXGnzRBaBVULQnoILyXz/1jFYOMyneBviuSN9HHgjllKR2ek
 yZ+Kej6CvnU4hnLohsgpDp5ujsinjsnZlnPHi3/lbYXrqFUDmaTDKb543ktDEM5dyNNdbQVDR/+
 GCbWDc+/eITAkGO4nm74mhjl6NZcCNJRjOZjCQ2Dak9KazU6+mGjbfj25XAzdnrtZSE91w1w676
 FGq5a03pDVnaGQ5IzyovPVn7h8uU2g2iKRvYvMBuY3gz7mVxGH0oMbkxdZi9Ebrqry5LYnVYaF2
 DDnUM2cXdT1aCehliJJJvlygkAbEKXOYiT1pchk1XYI6qN36lc03vYNf5cpMM5CqnKZPO1aKyaP
 YUZZiML8f4ct+7ci6nkvQs5Kr/4oxILREuGC+U/J4q3wl6s/UZeflPzX8H0UK2IwNkfeymPDpw9
 D91A7D4UkxxAS/A==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: WaT-m9yoO5jIFibgKY2l3nl_3VEcxNXQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwMiBTYWx0ZWRfX9uWmWLfZHTLF
 jsuA6NabLKlKdSsJkf1FS9Yr3+ochOIusQTKbbkY26VaS0uXSUGuE0v3OybbGCn3xq6tSukgSlu
 p+jYhFfQndG+dKz54Av4vWHvW1S+qyx0UYxBylypg2C3M+DtDW5CUKLfyToYDmSQQTP6Wt/aHWr
 pdstTJNVbr39UiJ+/D0wyCmLx72EW41vYnN1tmN6E0D6gyDUJuusRToZPsYxsf8zO3CLvxB3090
 lEmHU3SzEoPdGlRXoPRF3BdlPxF3vco9c/4zczufq6dMilAXXYetlKbS8ry/rfFCPHPu5aSgqpO
 NC6rPx3Qc6gdNfuQ8U++E1O7hssM18al1yCPYZMCCyS99cPIPA4bhg9EA/NUxNprJXsnXTJHoK5
 RjoIVF4kI4jo6Zw0EtFcIfR5IDTndvical/Xuj9z2Rn+MLQZARLzOC1h7w5xZg2FYF5DbV0ZeEZ
 GEXyAA9Nn1/iwvi9mYw==
X-Proofpoint-GUID: WaT-m9yoO5jIFibgKY2l3nl_3VEcxNXQ
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=6996efff cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iZjorvmLyqBVRiOuJXwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217427-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4230515E31A
X-Rspamd-Action: no action

According to internal documentation, on SM8650, when the PHY is configured
in Gear 4, the QPHY_V6_PCS_UFS_PLL_CNTL register needs to have the same
value as for Gear 5.

At the moment, there is no board that comes with a UFS 3.x device, so
this issue doesn't show up, but with the new Eliza SoC, which uses the
same init sequence as SM8650, on the MTP board, the link startup fails
with the current Gear 4 PCS table.

So fix that by moving the entry into the PCS generic table instead,
while keeping the value from Gear 5 configuration.

Cc: stable@vger.kernel.org # v6.10
Fixes: b9251e64a96f ("phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5")
Suggested-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index df138a5442eb..771bc7c2ab50 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -990,6 +990,7 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PCS_CTRL1, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4, 0x0e),
@@ -999,13 +1000,11 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_pcs[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8650_ufsphy_g4_pcs[] = {
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x13),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
 };
 
 static const struct qmp_phy_init_tbl sm8650_ufsphy_g5_pcs[] = {
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x05),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x05),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4d),

---
base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
change-id: 20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-9d1adf1508fb

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


