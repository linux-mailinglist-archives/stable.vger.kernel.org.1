Return-Path: <stable+bounces-203489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE8CCE6670
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B15543021068
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE022F5A32;
	Mon, 29 Dec 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BsV5wpN2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gz/QtgMN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88302F5331
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004978; cv=none; b=Te0WXzbxh5uqJJ5Krp8maGekqguAveUe+QFCltbzdqSlly8NDVaHxu3ktlKRj5GDiqSBwVU0XNTDyhdbNcrc09hjz/DJ0IF2fh4D3Ql54C0alTpdULYY0UyHWqSMD+1hxHiQbcGRd/QgwLNE2dFlZNDSOUl/Fx4TURyLnUjrGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004978; c=relaxed/simple;
	bh=VP/aaC9vMzd9wjGQfa1FtCcLvjnP6IcYIJvaUpBKKaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTBpy1gbfMKO7ppkgdWpT3v8cfuqGb57rxzplWnSyNuoFhx5CIYc5W+I0HxHYP53WNkdOjVKHZKr24XmSspXfHXa7cXix0dWqlcOqSocqihTa+OlQIwzsKs/5bdRfByFaCneAaBCempXaNEIhbwmze5453gwsOnFXO5X2XHb+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BsV5wpN2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gz/QtgMN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA4v01956253
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzja3z4Vcipbec9fpYHnYBIDS9e3pJxHPIAzLcYh1Ig=; b=BsV5wpN2Z0kUVuXG
	HZvkOHzofXSnbjmJRxt50ni5ke7VnC4c4cFpjsLdsr0NRENC/ffIdvcqIGxPAYSy
	SF+8nTa7UnkbJFuONJRbRRlYzFZqIgCoA4ma8KQDn1ZssX+19CMn844lXdwIq1sD
	I13zPPoWzdQ6+UClr9R97IKoJ1nfIJ3gPIRAPYEjneUt0s+Ub6AbiZG9msyDKwhf
	yu/hCCsF0yFlloq2BZ7phd635OhPwI7rQ4NDGSf6BU8I4qe0VLSd6xuMRfBVnkMw
	Bb4/rfQXSpj08dGQJ7xVzR/oh/JLF6TWat9f1+CUHMvpZhnV+BHS/gQWDA2/Vw3J
	gsMqmw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk1826h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f47c0e60so232984425ad.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004975; x=1767609775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzja3z4Vcipbec9fpYHnYBIDS9e3pJxHPIAzLcYh1Ig=;
        b=gz/QtgMNRk9R0DsP++Vv6J3wAo5CzKPWvGHOn4w+x6KsQ7dV552tD36VXalPosKI0X
         AeGkzmGtNG3C1yxmtQefGjE8a6XIZ3Ai2dj9f5Yg0Hi1DU5HAzPhGmZM1SpsYVGA317V
         OrMsOdarJwgyuw9OjIJ66wWvC2D1lJq+4QUNJahHirEzrQLMTnLszTe+NVvGZwYpJggW
         vuar9+xp5qEQ5isjnAryFlWMODQrCzrZcz9LzthObhDYfeOkNuTVDMSJqpHNSewdZHJq
         N5WE1GQNCcXRGa8eNy+MY40dVg16vOmybdkuvKgljV3ZPf8kKJQhl9iyFDwuRWbPHae6
         w79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004975; x=1767609775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzja3z4Vcipbec9fpYHnYBIDS9e3pJxHPIAzLcYh1Ig=;
        b=t9McZzWaZP719QAqfX+EuamGkfFJpgzVEnGa4Zt1wnQe/Pxo/W70kMQGBdHpnFdEe0
         GsFShN2BhFuc+Aif5KUAcSTkWEqVt3v175VKA/Q6dLf3HHV+or18IslKqIdQiO5cHE93
         lhntBr3C0l0WZx/RIre9qLY0N8h7JfVxco9ccIbKsVXO1CJ0v73NzpfkRCAJtukOVGX8
         XW/tkOZUpDXOOyuTSkzGIPEl5R9y19O4ETwUR9py5cnlFodgbpXZrGy7saYrtTQ3ux7G
         zUAkG3/auAAKIsEW03U6uuGmCWcL3Fi6xzIlXLyLSgt8zkU5dMC6hCFnfI0QNJHyYG/w
         crCg==
X-Forwarded-Encrypted: i=1; AJvYcCUXW2yIJOoE2M53aRc+h0LRpI6k82r8N4rjpvOCi7xOaX2O2UV6wYKT8cBtHb7IrAtDB68tfL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjGGS1M8oOciaBJtLZ5IwRUvo2rBedD/mB2CXdQDqjsPpmLCh
	Irbqp5Zru9h9/v62G/izRKq367jPK+43t4dwGicHFZT8ZfX6cT6DMSQNRtq+e/S6LNZSkp+cNAK
	T8g3N5kFJTNKZQS1KwFELKoblH9d6Y9Nw7zx9JdcFpeOEo35/otEvwUf+l4U=
X-Gm-Gg: AY/fxX6hv6fCyoAfW3sTgvYqrHEzuwsoE4IuPQXyURW27OIQ00OJe3fU6gzwxsBhGz+
	jgyw/5zPMlBhUhEqhxdG4wZepN0pMi10bOupf21Mklg61Ow6L76FB3vPpFs8j26uXK+Y/cynF+l
	DvO2A8L0rvNi4VE6Jsyg/41+rZO2FlcLNPZBeOJcM5i6keyHfMoglIC9yiVxCt7+BxWBFtYFXVp
	0HHGPLUKfiuK8ZDtf/3q2RyckLgEeGgZNbRpQTVqOHeS25PEwlB4Jf+jW7yCN9ANF5h2RbEGISO
	Keh5O3/8FnF2er0sYvyHcYNFTV305/FiQltrt5+nN3Qi363opGQyY6P0niuNEe2sob1WXBvS8ZK
	s4YtR03eHZDGO40ix5LQZgyOtOypDEtAZsD5+7iKU1fCE
X-Received: by 2002:a17:902:d2d2:b0:294:f310:5218 with SMTP id d9443c01a7336-2a2f1f904a0mr319171865ad.0.1767004975461;
        Mon, 29 Dec 2025 02:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX7GUdGEZTM1wCnh9H8UUdz+oyV97UmsieHwnd9pMEPTwPfmI0XqXNyycSVuRPz16mzTauSQ==
X-Received: by 2002:a17:902:d2d2:b0:294:f310:5218 with SMTP id d9443c01a7336-2a2f1f904a0mr319171605ad.0.1767004975027;
        Mon, 29 Dec 2025 02:42:55 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm273412365ad.59.2025.12.29.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:42:54 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 16:12:42 +0530
Subject: [PATCH v2 2/3] PCI: dwc: Correct iATU index increment for MSG TLP
 region
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-ecam_io_fix-v2-2-41a0e56a6faa@oss.qualcomm.com>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
In-Reply-To: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767004963; l=2252;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=VP/aaC9vMzd9wjGQfa1FtCcLvjnP6IcYIJvaUpBKKaM=;
 b=5dUFO/et0Tm1sWu2Ern1mNDF2HinrMfFcY3HFlg6+t4OXMB4gYxy3hq1LQUsu4wKAAJmf4nI3
 JKhG1OFq0JeCQnEY2b804iLM9o0zCWBinU1Wl1GekVq08EO63X5Zv0B
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: YCWK38EY7wEoYp_wAlFsGQCka3DBrekP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OSBTYWx0ZWRfX4EQD0TrI6nCO
 q0dV+rOD4u/+5dem0/LPb/XRwVEX9JAzwcUKZGEsCTMtpFqEzwwhXwDrNgGTjwTGh8UV7n8aDwi
 vlfdY6Dlhf0R50mbzriV2LnjPd/MMtRBdpwnr6L1tBMWeM8iy36lI11WA3I8ZEDFehgbokBEUsF
 scxbRgW0KMYAVdczQl4nmMuLtVDPEjHh7F4boK95jquTA5GkNZ5goBNrWf27NFFLAWzAF5M9hNU
 jSTvHxJfKK3JkTII3q9+VBFIklzfuEcj04b3Hze8wiNi3bUFfUD+aRcRowFB7NEUgVR3D0V2IKC
 PdKspdhbnxKA3lfQkoAIXfU2cdxXCMIo2GqzR2z3FBquC+S4cz0sY1BInGTFVNx17SbBrcXICeo
 wyIG9qDybG2WdOtJSVHNlJUrEanowhcb1jhfN4UBiEPZr/ZXPgA9dPGQjS/9NmqsoLAzD0YYAz1
 9JKyPX1zOBGHFWuWhgg==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=69525b30 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=BcPKCTjPAAAA:8 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=FLJoTJX8p8-1ICVlPiMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=MNXww67FyIVnWKX2fotq:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: YCWK38EY7wEoYp_wAlFsGQCka3DBrekP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290099

Commit e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending
PME_Turn_Off when system suspend") introduced a mechanism to reserve an
iATU window for MSG TLP transactions. However, the code incorrectly
assigned pp->msg_atu_index = i without incrementing i first, causing
the MSG TLP region to reuse the last configured outbound window instead
of the next available one. This can cause issue with IO transfers as
this can over write iATU configured for IO memory.

Fix this by incrementing i before assigning it to msg_atu_index so
that the MSG TLP region uses a dedicated iATU entry.

Added error logs in dw_pcie_pme_turn_off().

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 32a26458ed8f1696fe2fdcf9df6b795c4c761f1f..88b6ace0607e97bf6dd6bf7886baaa13bf267e6e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -942,7 +942,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->msg_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
@@ -1113,11 +1113,15 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	void __iomem *mem;
 	int ret;
 
-	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+	if (pci->num_ob_windows <= pci->pp.msg_atu_index) {
+		dev_err(pci->dev, "No available iATU enteries\n");
 		return -ENOSPC;
+	}
 
-	if (!pci->pp.msg_res)
+	if (!pci->pp.msg_res) {
+		dev_err(pci->dev, "Msg resource is not allocated\n");
 		return -ENOSPC;
+	}
 
 	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
 	atu.routing = PCIE_MSG_TYPE_R_BC;

-- 
2.34.1


