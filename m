Return-Path: <stable+bounces-152372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F528AD4908
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 04:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF13516BAFD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5BA22687C;
	Wed, 11 Jun 2025 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcbO4tcQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF95225766
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610722; cv=none; b=mQaLb8DjKsZ+0i3k8eoyWCHNjt+kRVQOHE0dQh5Ahgr1SAqjnai6izTOxnptgIrbFUZWK0WEBXKNHhXKAUalaWla7TXcF8woEa9Fvo4sYkwRRMVkuQw15Esfgei6qGp/KNsbEeDM6NLcnqUOTwV2JS3dN1WyoDedFPDbrVf68kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610722; c=relaxed/simple;
	bh=DJn9NYHqZgqnTw4yMsPNWysi1jIuh/SNHNWMy4qhxPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ds6YnI/svlldqfX74PjMEUfFQW9UgwK33JWWUxhTvj+4HZT4uGtD/N5Aqom+R2keKaIKx7isZ/2fgnBbmQaq8r1H2q7J7kYOkV2jfWO7ENbGjjM8mqtwcafM6GSGHY0kvh3CVawFpbX/P7zqT06Sb0xvk3D12l+w5MzFX7685bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcbO4tcQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIPtn3027426
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHqKWedYyr0OY6wJ10igxBdQqHVIA6btUlkeWEdA34E=; b=mcbO4tcQ5e+IxFIi
	2gII1o93SHjYQi4LJQzxEWpyqyQqWH0nUZfaUZYYSSmhw5pNopJeC4GAFF+a/PWj
	fi57u1GCEUYhHAu0APylj2TrK9iX3f2WbzLhnzmUShBCzxU5+WHzNC1bmGK12qcv
	eE+q+I4cUIvPdlZzcsojVtU2RdCw/E5jfj60ZR9mybF5RT0dt54e+Qf5EHEbgZe7
	1HizZJ4AiZki5rWTPN64Gi5gleUFv7qhxdRW+BjTN+Lmo06MDFVs8OdIrJR+5gnb
	1kZepFjQds2c2/C8lb/xwjm4/dUtMMk0tB4hzJawohpIbHMniQabmyV7EkmlrRxI
	pZi67A==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4766mcm5pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:39 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2da802bd11eso1631824fac.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749610719; x=1750215519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHqKWedYyr0OY6wJ10igxBdQqHVIA6btUlkeWEdA34E=;
        b=Hpqw4d3d1sj6M+l5LdeHnPib3zM+5ddeGLy1bvEpD1HGQkw92U5v0r6XGnr+o46Mih
         SDj8ZQDGzF/2o4ZllPCEzbNodhv5Igr/2ZPDGjQ00Q8WHudvYU1mMTriSylSn2jfmEJI
         WS7dGC7mwdahwRHp79A39fO4vUNX3fq40MzlqshpIcYNg1tlXF600D5jCuAU7umjA49Q
         QJE2hXt8pSlJVx1uPMl7LuxY2R6cr5ABW+mebEnysKYRXywuCiVhSc14V9bcBGDeKx3n
         0AgbisGqstlg9k29yVphVhGAxCSd8jI16m2+HdXANzxVYYb7TB9iVfecTOsZjaIdHnYy
         qcEA==
X-Forwarded-Encrypted: i=1; AJvYcCUogGQFNO5uVwsphIf2NWdkyn94rHDurnpv/vFlOcsTTObI4G5JksxXMOrYRP91CERFZhOAE44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVVR7qtr/nxVp6AVqSRERnEzM3Hbv8wdrNoJpoYWk/HNY9zFZ
	g4GM1TIXH08t75pnFuPDMta8/2WJ0VUU/zCVPJAuTVlyq45yAqwYeO+MXjLgD6q8LaxLOBlzCsI
	j18tE2NvE3CBmrv7z/Ka6TRC8POKv1cSlt7+JzqH5rdRFm8LzbGXZh8m0YcQ=
X-Gm-Gg: ASbGncsTBkrhhCjXCCPGX4nz5DgLttSoXimhHYLWK6Nvr7V7+NuoQg9xOPPP5EjL0m9
	4tEoUMwt+Sy0Kfb65QBfQbswm0mxDrzkpdg3Hwe/AhG8XvKqY5OtM2akgouB3Dx8nvYzyiiiXjB
	vEgbP1KlR2XsfC09Ajv7bf0zakK3at95Om/ZvqhHmRliRNfj/oqVJ164Iz6u4yMoNM/MZQMYHDQ
	+FuXSXRTMN5eQqAgBlZ+0hr8pcKoMnBQyBlWx8N3LsNSKJ8KTvAmSaeDQanMAiDX4mGRl2pN9Fd
	Wdpr/22AMi+ymmo/kVUFrH4dBBevsW/Sq6JnALaAUA/dvaY20aSYuTbuGVOTleDsBTqNRtbJFxP
	ZlqcpfRJh76/QeRK6waKbbg==
X-Received: by 2002:a05:6871:230d:b0:2d6:6633:463a with SMTP id 586e51a60fabf-2ea99630c12mr729392fac.8.1749610718958;
        Tue, 10 Jun 2025 19:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRLQcilCJwRVztlhp6Tq1XQRDSfon5wVImIcFPTKlDGIIDnxnp7kRLq0y9C6AdKmJ0vdJFaQ==
X-Received: by 2002:a05:6871:230d:b0:2d6:6633:463a with SMTP id 586e51a60fabf-2ea99630c12mr729379fac.8.1749610718647;
        Tue, 10 Jun 2025 19:58:38 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea85fa2cbasm478059fac.8.2025.06.10.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 19:58:38 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 10 Jun 2025 21:58:28 -0500
Subject: [PATCH v2 1/3] soc: qcom: mdt_loader: Ensure we don't read past
 the ELF header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-mdt-loader-validation-and-fixes-v2-1-f7073e9ab899@oss.qualcomm.com>
References: <20250610-mdt-loader-validation-and-fixes-v2-0-f7073e9ab899@oss.qualcomm.com>
In-Reply-To: <20250610-mdt-loader-validation-and-fixes-v2-0-f7073e9ab899@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3078;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=DJn9NYHqZgqnTw4yMsPNWysi1jIuh/SNHNWMy4qhxPQ=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBoSPDcWMhl8PNhEUSpN0/Q5gk8VSK6rZb/VYHEr
 OGbXJKHVbmJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaEjw3BUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXRow//XIVlajDg/QB4/Ejz8xnsC13HZRwJw6RFbDmviPK
 9+M9T+oSd0oJELF+cVbPGfvsPyDgHgQuWQbnHIi4N4rMhtY0Lvfcm5NJelfBet4oJfwckF8fiyR
 LX9ez77SqzOHBBrWoSOMxQBz/IrB4b/30n0oV3Fkf2GnsgFnbaMU/PImMJirh7hMkfAhxo0pRJx
 7bzA4D2iwOpO3+d7cB8WP7rwyU7QaMngZ2YSElK/cKD2c4kfZav+1KeSwQJRi1sHncuE9+qQXpw
 YuU44pAk4BDRZOPktAt0+vkSdaYRijoE2Dw+JaBj4az0ZZPgbmkgJu5wviMEdlI/gi2J7PLeeJM
 CerjSJEmHdAJii3IvdU953ABtk70tL0FYrgGL5jIUpGDV4+9msLY6NyZdXUmJD5QIDQtQb/wMSg
 nOk1VsbsqPyd1Ud9u8cmB8T29tqTbaCn3L4XUu2yg2LVs/n4xKpdn44cgjrVYYNpqo0GrytATQL
 lX9ROm5A4TopngVk6nT/5257bw7RpMNNZGly1r/J1Bv1TCAYWc4JujZ+c4P72wSDmSgkyKn37gI
 QJU+aJ1k29rR7q8ACOmDdk+t8bTSyf77YA1/g5bNlYXBDD64Lcn1RzVd0yWOY/i3R+zVRzc08lE
 4aEzqmNwJtZ2ftWHoX5/8+FYqiUpTmJJPKe4eS87JI+M=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=T8KMT+KQ c=1 sm=1 tr=0 ts=6848f0df cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=R2NP8FmM25b3pXeoK7YA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: 9bHs2tr-z5_PFrOS2nwTcSP9oMWSqeI7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAyNSBTYWx0ZWRfXw01eOQBzvGgT
 YjZoozgC6FgZaPAkIJNNv9NuD5bgMYju+VMiTd9tFfGYWaQI/Mdz6HIkIACmT8t5F3CZ2PzlP+6
 8ERsr6Rc25ZgoBuu59N/e9aFPbAmE646tOQfNYBhAbMfX/46dRot8+vpFylET0fwPZ/yzKxBKby
 NROud0i2eviQNryCksOR+rUMhLyL8Iw0d1/A4eW72Ztw4p5IVSy7siRPuprex1xa4Q21qroodHT
 WRhXHCfx91PQmUtnrnIwOPdMaf11c5m/9ClBftMpSp1zjEVc2SM8zL3Aj7sWjwcGkKTK54RFaYk
 zzuSkHTDzcg7ApJ9XNEiJYILabycATbPE2S52Jf1a0oIlsmTs6jlJu3ttLepREoe7Xy7jg6WCBY
 vym6JZ51AgZ1AlnUYs3ySEDBvA5qlydxsv1fxXLG0w9OKlRmfutJTBTBYbbjBFflS9n0Q2B0
X-Proofpoint-GUID: 9bHs2tr-z5_PFrOS2nwTcSP9oMWSqeI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110025

When the MDT loader is used in remoteproc, the ELF header is sanitized
beforehand, but that's not necessary the case for other clients.

Validate the size of the firmware buffer to ensure that we don't read
past the end as we iterate over the header. e_phentsize and e_shentsize
are validated as well, to ensure that the assumptions about step size in
the traversal are valid.

Fixes: 2aad40d911ee ("remoteproc: Move qcom_mdt_loader into drivers/soc/qcom")
Cc: <stable@vger.kernel.org>
Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index b2c0fb55d4ae678ee333f0d6b8b586de319f53b1..b2c9731b6f2afacf4acafe555dd36ca0657444a6 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -18,6 +18,37 @@
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
+	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+		return -EINVAL;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+		return -EINVAL;
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
@@ -82,6 +113,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -134,6 +168,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	ssize_t ret;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -214,6 +251,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	int ret;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -310,6 +350,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
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


