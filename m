Return-Path: <stable+bounces-199980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28008CA30EE
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 551BF3009698
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4A334C0B;
	Thu,  4 Dec 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOXRvqVR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPpsENVv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E091A9FAF
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841463; cv=none; b=iB1U2t2OdpFzhYIYtjNfnytdtc4CdZ59MOI44C5Gark3/85sgZy7CYCW7ZJx1JxJH8Re+v98UTGUOPgfh2OHjIrz/uitO3ij/m6cKHJdSmG1YArGTIe7EpC1HA1K8pHmBjBsAe6Oz73CUjY9LogAaP10tj5QTRwHY1ORfe8Jf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841463; c=relaxed/simple;
	bh=vXblevtqTt4/ExqMNMsLHoKBrEeogH8uHzyxwjnr7n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfRFaYGt7A9lRUOEBbpB9F5950a1Bi4gmDK7IN9iLJHudpfAJ91YLhV8CRIqLWra60L0hPkRQnhvNojasZEsbS2dpe61x8ZDs8ditBIJKuZybazrd4objmipSSajH4dFvd9HuClQdmty/qBW46wiNiNPxTPgEQoT0e00ScfxtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOXRvqVR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPpsENVv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B468ip1560144
	for <stable@vger.kernel.org>; Thu, 4 Dec 2025 09:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0brUBNo2+3OsIrwv8UuAtu44g7X1/MXs8D1
	JRheaSsk=; b=EOXRvqVR7amOZGb1xkLKhXW+0S/68TINUQWS8q2m4j+EVuJJ1In
	Sz5MSyxqmZncc7hQRL+2wFqmBySziUfVmo6uOatCKswyuhddrfaa880Nk16Vz97/
	aI/e/X+pyeE7zd3XUfr1YtiWaCBPzWI8WgrSFP2eUY38ITsUMR9WKdY5MOfA0+Em
	un/AUhKAQfYShwBv3p9FVCsYnx6TLZM+NBnLwzUzbKpjQqitl4ZINEhoR8TueuYx
	TA5dcvl5ddbcCYbI/eaP//6BSfOgKxnWX2VhD9eVrria6J4YgRUA3etItCCdrm+1
	a/NItvUq/wk2nUBIb/Aj78gDED5uIMe0yRg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4attmhadfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Dec 2025 09:44:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b245c49d0cso143947885a.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764841461; x=1765446261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0brUBNo2+3OsIrwv8UuAtu44g7X1/MXs8D1JRheaSsk=;
        b=CPpsENVvZeG59itlaXxTmN14boIxpXUV/K234d0Uzqh4O8x/iNuj0cmlhl1m1e9k+L
         dNLdsrtzfkdFeF6IHTveudk55rTLdeacbGsc7NNWZIDV00YGMcz5+OvhWtJ72M9mBHYl
         YVIw/IvEXFKlrWMpQpF4WS8PV1F5JMRwM/CobdMj6Kw24hevGJNHBlJUJzjnmi82Zmc+
         d2BFOYO2kZ8l9PPIRl5mp3ZTrjwZJ050GGDPzNclv3DqY8Bm2+QzZHgH5AWdFo0T6J46
         SLT4Jd12+Jy0OUydbbP3/H11h14tKrwWK2zyhF7wOQ0q9S2DyAcFDex9wweDp5mXxscc
         nuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841461; x=1765446261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0brUBNo2+3OsIrwv8UuAtu44g7X1/MXs8D1JRheaSsk=;
        b=UzCg/Cbvqbp2LE/znEhM/ueeTjYmlHFt5GUSt8sdy3KMirpmtEEDsi42zsnNsQU05v
         Pvst7XvtuQvv+lICi0M56qJpOFitLGOqFD2eP8Y1q7XtndRZQ6iw51riSx+oG5/hBPvV
         qZI1p/31aKNLKzBG+yatpGOC+VcV2N5ySFrvH1Gkh7fZyJ7US6a4/tRxu8j6fLyVN0cA
         gOFGVQjUywIrTvol50pfyNuO9rgLQeB/xCfTib3rdeEf5FD6Io9pNAf6CbMdgk3fRT2g
         XA9/FP7BJbbNcw/FmCB9SUd5FuH+S4KCVESl8+o5/3xnOExHcq8gstrn/euXqBj1A08M
         MGEw==
X-Forwarded-Encrypted: i=1; AJvYcCWMrIQBu7Duc06pjw6suMokY2eFXLppLYFgLdBkK4SGccqAw8lyVVi0JEF4X7UzMJ7Fpf01lw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVbLtjUS706z9uGiUciSP7DCvFP5QCcCCDrLHqwhf/9cxmw5a
	qixEkcuwO51dgHMz4P53pwoHoSlaM84XoHkpIZK/Xzd3ZlR/08Y5Bcf+Yist/nmR/PxPNrrCigA
	hQ4nJ9VUtXfxZjN4l0P/JB5SkLoRTLZgpGk36q+u30552/CvYhvZqcg0Ho48=
X-Gm-Gg: ASbGncuntGAv+IlLiCkHkTeCFEGdsKqOsKStT9NbNaHe/5ScWpLjG+S6P2/BpK7VuFp
	vQ8q+JuTaxHZ5UeSScl9HrQnZzoQrL91g5y8JAm3oPqrJCcfbYMyuKuWfuqSOtv/ispV4mfvPxx
	gD3CFUVvD4M3BtNi4zPQFlpyvF2ieoBnvaUaUxyr76Dw/K5EkndBhM7qdpVCWxxRjw9D/97xQuo
	ocT+pCC7WHaGFTDouvPE8xtiwmpr+aVLqMcspyFu0Ql7TyLXjz4naVPF4yZZfSNt/d5Z1yURqT8
	47LyGwY1+DgPs49xLdxoAnXWJTiiLY9blFrDKpWmvw0PNn2GO7PwlXJXc5Uj3P60rPJDR/aHF5B
	khB1VqGRTxPuXCp0GJg==
X-Received: by 2002:a05:620a:4709:b0:8b2:f1f7:b867 with SMTP id af79cd13be357-8b5e535e20cmr705025485a.11.1764841460798;
        Thu, 04 Dec 2025 01:44:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzQBFsGx9JpmMIqL9fCWT9ejZtveihFlSFVoGDQUzSfiK6jjc+GzBWGLMYRlYLQAQSyY4C5Q==
X-Received: by 2002:a05:620a:4709:b0:8b2:f1f7:b867 with SMTP id af79cd13be357-8b5e535e20cmr705021685a.11.1764841459884;
        Thu, 04 Dec 2025 01:44:19 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:74f:3ed7:4831:5695])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226e7sm2239669f8f.27.2025.12.04.01.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 01:44:19 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] reset: gpio: suppress bind attributes in sysfs
Date: Thu,  4 Dec 2025 10:44:12 +0100
Message-ID: <20251204094412.17116-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KPl6eo4oengYvoAzWImwdQ6SJ_xjCuo0
X-Authority-Analysis: v=2.4 cv=NcTrFmD4 c=1 sm=1 tr=0 ts=693157f5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UvoPXoD5CY4mxSsR51IA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA3OCBTYWx0ZWRfXzUPIGVgfhU6D
 v1vIKmUf81IynP7hMEFVaiDx4rfyem5lFMPl5Qa+9lQR05KjHJCjppu8HvaDE09wyaY2oNsvxzM
 hDX0Glnii5N+QV3z6iSpvRYwtIOFI//ftPIbnRsEuysW+UNlDW/GgBeB/QMwcYAWon3icqX0xoo
 EhLdu1LLi0Vh7NxcuvaimbsPHTGBwzIFejdDL8FyEwLyC0yt2wCqMDuQxc8nhAPNfZ5aq0MlJJw
 6R7HfJQSsjNlMAUixw291r1X65UqwIIIKl9RG8AWCtXrWNfQ8STWXx8ooz8AQTfnM/oV8Q8Jonx
 bu6ur3aN+XjD6sKhAu66JYKZ1ulYmSrFMCY8SrTPp2D2Co/1BI1YyUQA5AZamgr9QUyvDvlwJv1
 /vXI0+S39NC9Xc1pWZ2NQWpdh3p2sg==
X-Proofpoint-ORIG-GUID: KPl6eo4oengYvoAzWImwdQ6SJ_xjCuo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512040078

This is a special device that's created dynamically and is supposed to
stay in memory forever. We also currently don't have a devlink between
it and the actual reset consumer. Suppress sysfs bind attributes so that
user-space can't unbind the device because - as of now - it will cause a
use-after-free splat from any user that puts the reset control handle.

Fixes: cee544a40e44 ("reset: gpio: Add GPIO-based reset controller")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
index e5512b3b596b..626c4c639c15 100644
--- a/drivers/reset/reset-gpio.c
+++ b/drivers/reset/reset-gpio.c
@@ -111,6 +111,7 @@ static struct auxiliary_driver reset_gpio_driver = {
 	.id_table	= reset_gpio_ids,
 	.driver	= {
 		.name = "reset-gpio",
+		.suppress_bind_attrs = true,
 	},
 };
 module_auxiliary_driver(reset_gpio_driver);
-- 
2.51.0


