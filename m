Return-Path: <stable+bounces-203488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF690CE6664
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99C03018D5C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC032E974D;
	Mon, 29 Dec 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LZebAHCs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdNzUBG5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4A2F39CE
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767004975; cv=none; b=VGCR8vCXD7fbsK+HEHC69zA5VV6dEubzerUwK3VdriO7lMeppDqRCupio+EH008/P+7QIP2cQEO5wHyRsLnTAqNeWrKwChGuK3yRJVBX1QiFl+96D31dIDNaWBJH+GgVhpJHslq5xP2CQd+hg6T7gC/+xG8fBdm5HXOZ/bfpsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767004975; c=relaxed/simple;
	bh=PwDxGVqlPCalaJqsrWiJVP8Bkv6pzkcROQ1PZGyP8Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhffASXexIypUc5ZaFjKniXRxjArchITjX9yZT+AcCp3GHG6wgeNCxqS9f3u8e4DnRqDhypxFK8nHUFvas5czU/2tdkQQD44U1lA6PFUHEKLGpTXPW8qWp0T1mvyHvHgKyvPzS5hNk/xWnJ4kEUZeg2Hjr5QOq5dub80y0RDQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LZebAHCs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TdNzUBG5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA8UwL3253861
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=; b=LZebAHCsgQRJVWfr
	I+cljWa40/K1txRjB2F1ibvInYbxq983UDVddqPM9k1UAbOTBLXFAvHfnQS89F1P
	A6TUtBe/iIVTMEYbJedF43k2PqAJFTJm3F801Z16QeOVgTPp/ldrKxY/k+4QqG5f
	/mGgvvtW+CZH+iAfdQba0dhsy9fIYkOMlJ6bNZdts1ZATXvqNHwE3d0d+lT/lr/f
	LTmgzT6fF5aQlN8yLk8ihkOiOcpQw2tbs3an11Sj0pxSvm8oDmJh7BdRjnnOO5zT
	pRmeq6t/YNpKpqCZ0F9c/eibTCt1SS6piO9veETgBVu+iVuQ8ea5kn9v4HLEaAi3
	mjURzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tnvasj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 10:42:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f26fc6476so148463235ad.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767004972; x=1767609772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=;
        b=TdNzUBG5s0GxYOLMRvj2EcBO0KMyGDDLT5xuqoWXRVquqhQp1O1fZ5kHFo1qJgTvWT
         5GMZiMyb0IhmNmSWSrzwNAhv40/S5LIpyU8wYw54f8RnZ8bIUqIS63nZR81j5rYIsj+t
         7v26Zs6jEKU6RT5P5zdJIfEvNH++Mrx/yXb8DIHxw7A3wbY0riCnAkqIEosIYRe7dSZc
         ikU1osePVjNKF1iFEnGR7IRH0KS1t776xZ9NDRwgg1E2z9MmSebKGGuG5ZcEX7y86LKZ
         iq68GtQkWliwBGRXd0LT1QBlL6IcsDJ0P16Ayxif+wGvZchxvW1dsEY+D20BnZCCTZAA
         vOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767004972; x=1767609772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwdN1Hzsrc+ug6247grY+gZgtiGh816xfGCrunPfDc0=;
        b=RgoWvq8ChnzgFGnnVaYqN+EKZa4falx8qy2eorcWwu34WbNJQhfOukYfqgZrlpQexd
         K7Eorjhop8IEGlcj9mqO+1jY+iReUfvyuvoP6jO//1dNgog6UiKUM1WRmDRWbiAXx7V/
         ZtKhaculRhhYHpCRRZiLnHluNU29zyG+gp4TyrKa7VZ5PP/ptB3aeq2w8QUTg1zcLH77
         0taAT0upX0XqDHbJLQzzaQHfiPzoOi1salOsTWgcvuOPMPKJjCCYoEXIG9x6VfYXLUaI
         UoLEXxUodSeE6atRdHnLQWAyVZYm4+BXtlFaHoHfHX8K+96yMqu86XUROLJAaP9LfD3s
         7UYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpskS9lYK+jF/AYd1iVIwnF3s6jWxkufDRIt5xwO+z2uzHxwAuxQgICCM9waCZNxvwysg1VMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvv7+0A8z/IyLHMOOsYA1p3KEdg4FFYTpYg2vgZPZVYIiDY8GL
	A07FbnCxrfUpav2420+Z74ZGFkJ/fdyJ1+VaVRXdYrhcWPkpQlDVZo3nn9Og6z8eY7WJzlTObRF
	9LbXvMRmxWT+xSSYIzXdKvlwj2TKLY4W/KQvpjKlrsXPBmSBvT6qbUr8p6yk=
X-Gm-Gg: AY/fxX6ItIrdeUaYCu8B9bBxqAuj00L+sP0sGJaAdxhGMa3izcIJfwF1DSJZdaW8bkb
	/NC2zvCa2gSG2ycWoJBdFVlMoqog/FjEYo8h1di+Dx1RKpy2b3Sla6HFafePdD5GxrHLgB64TNL
	lIgAV6UBrXSnoKVSMAoi8iv+R9+tCv27CDE3A/iuCcwdtTWht9LuQzR7VZVS2ObwYXoAdRLiL9Q
	L8Zc39U/yQKH+dD9xzx5bISnQbQn2bmOq3fx9o4afuQNS1yHQs+R/7YeE9ssmEw+LfRCsK7NYH/
	H5Rvx3K3RemZSOrLLAuA3PqmvSp7WZNFMr9QRZlGQfpDzimHn0S5XaIbvMk2sKCuh7R4rwgd784
	hOEs5u7MePP5qW9tz1AILScHRWB2RK2Xxc/TqqqJVaN/U
X-Received: by 2002:a17:903:228b:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a2f2c56453mr290588445ad.61.1767004971737;
        Mon, 29 Dec 2025 02:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEioKFGNJBNeeqVZgzXmhPFsUS0ACvTBBn1SY4kNRpxoJLiA7uLug0gT1p3bVGZUFUTysadJA==
X-Received: by 2002:a17:903:228b:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2a2f2c56453mr290588295ad.61.1767004971298;
        Mon, 29 Dec 2025 02:42:51 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm273412365ad.59.2025.12.29.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:42:50 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 16:12:41 +0530
Subject: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU setup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767004963; l=1914;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PwDxGVqlPCalaJqsrWiJVP8Bkv6pzkcROQ1PZGyP8Eo=;
 b=6/isTRmSRgxo+TugjzFqCVCXMPDX9AlprjcXjqTnJ4b5O/wACitsNUSm8zo/yTf6VtJbzGdx1
 liJTqd4KMTKAvLR9DeUsgYhTVFsSOAw7YH9bmWMumneoELk0d/+bsEK
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=69525b2c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5cqX_iqSVL2xjhDF-JMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: lB-Lusat-4s4WaAtTrYkXFyRYWghc5-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA5OSBTYWx0ZWRfXx3mJZkj40RpL
 mZTMoox/X3nQ1JIQnFrZAxEbJkOkWVnBJwA3n34Ez0lBMJqNZcJY6H5PeMW/kZNa5S5qFI/seNl
 mqbX1EBulKQghpgnQBfQWgCDQdriwvNFGE4i7mOiwtUsKoQ3PsmiVxv/k4baauvcIe1NX4wHDJI
 PxN9MAW8NZrTEfIK7rxlC8Rsn5PNO+gZ8XsB5ee8NlM1Lkth2LRp8+k7yX4CAIBGUM11G6omcje
 WZj2XqXw3uu+rsQjtpOftle3L8vilzbMWadHCuIJ0fV1w4ajB+G2U+c+aEpKKFGy6RtafQWiRls
 B1dMra8Vp3JmzCxxZZvESYp/KtXalF17QGKFVIRiLv4psLRqxJY8+qmnOHiDkWPU2Z7W46Qgpk/
 fFSTeB6hTVB78ftt5549MAwJXrlrPORbnmLV0syoO+PM3bUxXmekgRIVdHQ6cvp0cHDLUd5YZ82
 2B6sfsBF1UYs0VhDAuQ==
X-Proofpoint-ORIG-GUID: lB-Lusat-4s4WaAtTrYkXFyRYWghc5-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_03,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290099

In dw_pcie_iatu_setup(), the outbound ATU loop uses a pre-increment
on the index and starts programming from 1, effectively skipping
index 0. This results in the first outbound window never being
configured.

Update the logic to start from index 0 and use post-increment (i++)
when assigning atu.index.

Fixes: ce06bf570390f ("PCI: dwc: Check iATU in/outbound range setup status")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Note:- The fix tag shown above is for applying this patch cleanly,
further below versions we need to manually apply them, If any one
intrested to apply this fix then we can submit another patch based on
that kernel version.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda51bde3a7157033ddbd73afa370d78..32a26458ed8f1696fe2fdcf9df6b795c4c761f1f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -896,10 +896,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows < i)
 			break;
 
-		atu.index = i;
+		atu.index = i++;
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
@@ -920,7 +920,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	}
 
 	if (pp->io_size) {
-		if (pci->num_ob_windows > ++i) {
+		if (pci->num_ob_windows > i) {
 			atu.index = i;
 			atu.type = PCIE_ATU_TYPE_IO;
 			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;

-- 
2.34.1


