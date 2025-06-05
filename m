Return-Path: <stable+bounces-151538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF7ACF107
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A50416A607
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794E825DAE1;
	Thu,  5 Jun 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MIUsm2k1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD02405F6
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130999; cv=none; b=A5vm0Ekb4Nvp49MPlPld+GQAsSn6UZjy1enlzSLypKcsPaP6naw8MIxiHvjjNxEPaWSGBNaKT8to8YO6zof8MQaI8qxzXV4VaxJbgSUOyMRpmhZPUNuFh1+ViFYB6p3cAyOrA3g3cylSnRuypLRHyGRTpd+ItwpxwvcWO3CDUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130999; c=relaxed/simple;
	bh=VAZvVY4YvO4yZJam3Pqn64RyEqzAe5U0pqKB9Nl1xSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s/HkG2ufkun1vLYBlI2zJB+bKBZv+GkzLVGz3Qwp4Z/Sj6pcp+eW8jVhxgRvibGfXvnoZ5QuP3S+DmXu5mqh7hw+9qWWjVrZ8h/NaU8bVsST9NdqIA7a8POl47T8BlKNwTREPb/lfYSRUt+V1nz9Gm14PKM/D6eGdL2oKDhPgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MIUsm2k1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55593q9e007709
	for <stable@vger.kernel.org>; Thu, 5 Jun 2025 13:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4K1V7X0mjkkzCtjA8wOdUTAbcAITWxzAG6tod7BBZUY=; b=MIUsm2k1HDuWbw6f
	sj7bv4aDOBMkQ+Ez3x/M/tTYYfBEEbAT5bBFMO21tSQ7JhyhZ6iC5ecIW0AtissW
	z8JUiwtDgZmpbToEpPDpfLZ41NNNSWgwiUG4YJWWbaV1N0Ijp6nhoFpOuiuPMgDc
	KZpxTwiDSK9X2COW4bxzvpJiQU/B2n4LlhQjvFowmaWbORSkOds971IgwlsEwJw+
	wPJPINsuUCR204WNVntf+euhpOLjrOzZQS5+/eRAqOjgReQRbdSna9y1ZwEzEFAn
	1xexUOBZcISpREreDCUlu6KYY92MSzT83b72lxir0qeRL9KI03K6zWV4SPIyM+Gh
	oU/y/w==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t1egv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Jun 2025 13:43:15 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-60d2dc0c4f8so1529827eaf.0
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 06:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130994; x=1749735794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K1V7X0mjkkzCtjA8wOdUTAbcAITWxzAG6tod7BBZUY=;
        b=B7NNsz+2u8zbPZkPYCfRq7owqsww5bwudkBusX8r8bhXV7sS9S22RKCi3WEY3FVFNh
         EIP7MXEvpvnRjxuENrrLaeifp0CmYcaUb8dbOl0dRm441PJ6milVfsUozbk47wJ5+rGV
         4/ymw7HwB76qWO2w/M39bBmsQ+rd2O6FE7JVuIB5a4O8VQCV4Nt85m0keJp3RyaJiSvS
         uuPmy+94X4TIbxKgyACtXJeK0iEnWo93ZU4ck/tCZNtTnuNknF3D+shmDjhDZ34OTrwt
         OdCA5oj9rSQYwXv3vmySLPXEVnAWih8rD0OYL13Rkj97v77xlra/cwNvDyXEZeVD0WQe
         2YVg==
X-Forwarded-Encrypted: i=1; AJvYcCX93YDlDGEu+2ATjOtK4LdJ8uW+BvBjj0zqtKFbxMw/bQ6ic4rnJ09YBJe9hEsdZYtXMh3bIRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfEvBZ4/+Vd312ykryt9ECxCShUI1Dniq3wc2VWJ1hxVB1ePI
	6wV157QIJrzbeEdmt+qqIhVrZSAfitYZjzI1tYn//tolD6BIOLB1syZuCQ15Q3cfFm1/Oj5H9sg
	5wRNhzzGGQSamZPtjTEMmPrvocsBix+pVIKmSGaUV2fw3CUhoz4gfyevirCY=
X-Gm-Gg: ASbGncsYTJa1Pm6Rs8S7zy6nm9uc0cL9CEq4QnI1kCHmEc9zHe6Bsc3T/0VRwNMZcF7
	NjCX1dAeThv4ufd3f8yj+WgylbxAtasTlIZjQmhtRtP4yHQcKOaYuNGWOULHtDGwmTemMNmuqvK
	UiU/CEEKNyrUoK8doHNtsYHPdN7ODSbeBXmvbVptgVTLWoXG3RPa2BXTmDrUd7j1iyHrdcfLwlg
	duD0svgypzn7hDqbyGHTXigTImerO83kGngoTSQV96jwZFTDx7o6zV1NpQW1oeHd8jjl0oWK+mV
	J0eTNmsVXWWVRiJa+oKXO88annuej4hlyenYDnHuZpaEYzSiIFehX3iW045Niww6he3rXw83XVa
	bYyX9tk3BfJw=
X-Received: by 2002:a05:6808:398c:b0:406:6875:3f0b with SMTP id 5614622812f47-408fab8b28cmr2811694b6e.7.1749130994478;
        Thu, 05 Jun 2025 06:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVO4JnGuwbYTanrmVGFuPGT0vXXaE6+r6I65XBXdCTONC7vN0Ig72qhyjwBB4WTSWBBcIaYw==
X-Received: by 2002:a05:6808:398c:b0:406:6875:3f0b with SMTP id 5614622812f47-408fab8b28cmr2811682b6e.7.1749130994131;
        Thu, 05 Jun 2025 06:43:14 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c1eb719f8sm2691359eaf.28.2025.06.05.06.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:43:13 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Thu, 05 Jun 2025 08:43:00 -0500
Subject: [PATCH 1/3] soc: qcom: mdt_loader: Ensure we don't read past the
 ELF header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-mdt-loader-validation-and-fixes-v1-1-29e22e7a82f4@oss.qualcomm.com>
References: <20250605-mdt-loader-validation-and-fixes-v1-0-29e22e7a82f4@oss.qualcomm.com>
In-Reply-To: <20250605-mdt-loader-validation-and-fixes-v1-0-29e22e7a82f4@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=VAZvVY4YvO4yZJam3Pqn64RyEqzAe5U0pqKB9Nl1xSw=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBoQZ7wAqUKHWx5c58KFtrNhi1WL9mDfy3fQItYg
 wVrzRnDtYiJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaEGe8BUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUXbBAAwnO6nb6pVq3Y8z20lFrjxXplNhoWbkPBK4mPuxS
 mBiFeoCsC1o5w0QkoFilM1m9PwsF7Q1rHWiuj8NtiGaCTMuCr2fCtjvbpBLKHOXmJFbkAMVCD7D
 nC3e12G080tmK1ytZ6YaUxLJ7KxSar5HOWZpgKwvl3etBpKuxBo9RE6fSnxDC9kCRSdPeFbfEVD
 NwUv3K2MLTNj2+GjpGlLR1CG/LMaPYvpS0D4l/AnpT1HDbk3HKHBN7aZ6iK4Iu/jZA+jSToqhe9
 pblCaTdLCAC8X055d7cOp1nLU9pNm/8TFwTi1LmudeICp5pGKYH4zJo6QEN2qf+8gNzfcOq+hL/
 wZamX32BWdgI02HDBboUgOkcZFbbI/2yN+wm5Lv2ruvxjVJPE6/56RoWTfrx+oMHwquibpuxI6k
 Zt4vH0tw3Bho12O71POPh8ct8pDn0pq2vIPMzWNpVQMt4/aM2oooRbi6JSDms5eHqwo1nSTLax8
 osnCuqfNfHfG0KOUTrOv2bV+89GjTV9jdAheC71M1OeyAwhm6qDHCw0bOICYD/EabT5k54HetG+
 22sQk1GgsfLmMWLtrhc+PDgBIEPQQo52IhFMZMtHUubaAVWlZWuhHcyFK8e4Pkyj6+LUl2lysav
 PCmHVzW0xXo2WLVV1FahABDuZnci9AEW5FbBxEhHY3qY=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=68419ef3 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=R2NP8FmM25b3pXeoK7YA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExNyBTYWx0ZWRfX5tGsv+/GM/n9
 CywnmVfGg+NLdqpib/OCTNtphO+2S7AHhzfhvaEOH+qEQby4KjxLgfkWmzwW6Y5nSTeWACd4qSk
 QaTAn9PSzkeyXkEgttHvJPujdpCa5MEPpfnXs5tEpWzUS/oswJqeuccm41eu28RFzDNdYQjXfUd
 MYaUihr5KOQGqJS81dPsGz/C16uVaxIMH3lE3zbKHVInsTt/L4Yg+5VHYKRQtQl/MrgdJAIV3aa
 vefAZeiEY7mlngIz3St2Ai0nuhY/8JqpGebhbdxKmu49Am67I5hr7zULd8EqNdEhoyKUOZ2FaAG
 M5BIeMOaxs+5VRLe5LSjeM/SonyssqCzHiGeXZqA4dHPJNJqFNyfS7gMVSakM6BC2XCgqDqZQWQ
 o6aiKaAZIda2acI52mrT0VMe5ftq9MOiWgXOEXS/Hfg0aGYssIzleWZTzgDlFK1TXqNwGzik
X-Proofpoint-GUID: O9Gc2AZnc0klo6jJ5orwuiQv0mdUV_QI
X-Proofpoint-ORIG-GUID: O9Gc2AZnc0klo6jJ5orwuiQv0mdUV_QI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050117

When the MDT loader is used in remoteproc, the ELF header is sanitized
beforehand, but that's not necessary the case for other clients.

Validate the size of the firmware buffer to ensure that we don't read
past the end as we iterate over the header.

Fixes: 2aad40d911ee ("remoteproc: Move qcom_mdt_loader into drivers/soc/qcom")
Cc: <stable@vger.kernel.org>
Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index b2c0fb55d4ae678ee333f0d6b8b586de319f53b1..1da22b23d19d28678ec78cccdf8c328b50d3ffda 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -18,6 +18,31 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
+static bool mdt_header_valid(const struct firmware *fw)
+{
+	const struct elf32_hdr *ehdr;
+	size_t phend;
+	size_t shend;
+
+	if (fw->size < sizeof(*ehdr))
+		return false;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
+		return false;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+	if (shend > fw->size)
+		return false;
+
+	return true;
+}
+
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
 	if (phdr->p_type != PT_LOAD)
@@ -82,6 +107,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -134,6 +162,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	ssize_t ret;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -214,6 +245,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	int ret;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -310,6 +344,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);

-- 
2.49.0


