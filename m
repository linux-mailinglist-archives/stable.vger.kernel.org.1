Return-Path: <stable+bounces-152371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD2AD4907
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 04:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127373A4731
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 02:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7822541B;
	Wed, 11 Jun 2025 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bXx9v6tP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A4225413
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610722; cv=none; b=j4H+Epw70OxdpL5N/B3IbYIMQ/13Y+E0c6I0I2hXYOgMBDWgQ5xh/r9IjXNnP53PKZcy8jFLl+xJUH9RVoF05ph+kf1asa9weoopKR+5VCCmYGnLSYOdbYwD4kHB93KCXUxf2pRmJzcuVbV3MHvCbPL85YKtxovz/qEhg7VhjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610722; c=relaxed/simple;
	bh=CAZ/SIZXGULw26SKxotaF4nRCv62GltcOelZ3heoC6w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dlwa9RQwsZZkJBos1kdisER6AOs8n4RO48p8W6Jiwg/dFQkrK6Hj67f3NjQa02tFDzK1WZWyalLgfCeiUNbrxQ63io6E/dZvU8U+88QgAhBOfiP6eAz8BlagLpYOdg3b4oqBhnpepwhoIg6vm6Haa4mOWS/MsF0ZAJu0RkwdHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bXx9v6tP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIQ1lI022379
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PnvbGOLWjgVd2ibog5YycE
	QyE3LZR9r4haxSXY7ibqM=; b=bXx9v6tPlZxdLY9glWmE7kcis92aVz7dD86rBe
	zsKEKr2hKonY3rV/EuSsOlpip7gBmy5fLX2XKpE+Fd/twECK/7+7ZlHy1n9hWrAm
	euxruVB2zGhaq2DQmChIlzkRFwAcWe5Pa7bFGt5jotlamHb8XvxSKXRQ5YctWNgp
	TyeEraKAK9xHNsgo1vlVDRb6WljKw5Su4ZgoG2HbrRurH03keKZSFW9P7r+V0lNg
	1mGkKUXsBmW6TMG54ASe1q/5r/8IxqIlCdGbHD1AobtEjMyLlPvuRx/OJs8fVfLY
	umUDKGWp739oduQv4MM9rp8L873EfFiqlkk4oPBBabk9iSbQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpu5xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 02:58:39 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6049acdc5c5so4774805eaf.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749610718; x=1750215518;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnvbGOLWjgVd2ibog5YycEQyE3LZR9r4haxSXY7ibqM=;
        b=Y6biid5AnvqH5UYOOiumHFZW8hImgPNk4krgIAHSRlcuaD6BVsJ7rXTOUQi6BJsiy2
         k+06Aqx7KlqnEsv58M3buh200OvmX3UD4+KlXjemQK+gxSPFzxlUSWdShFFtZLIC+WTI
         Y9eX2MCu0Qrg/XoI6V/1slzkwz5H4zrpkP5d6/RLLbju6/pCTKeEp5nzQ3XCUpxtmsSK
         2ikTKlIcWL+tETgQzQ7U5NNXQYZvLIbyhOM1wr8c9ldqkkWOf8EFXQ0szIAhmHQtVLkM
         S00IxHub2lVDzkhSxTdhJCghN869qjy8vUFT91t2aePWevIaB5enQKSMFi/prNLZmmdT
         BdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq0qG9Hk6p409bSmVhOqbpFnrUpppVlhqLTkXGLHqsl4eVT0pHwO/DNPr8dux+bm5avcvjhHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq60kKQrrKVoFUH9MerkDuAi2EPvQQE+blAkQ3QxIhCJxLEMPB
	5OD+E0ApbDQQ0jCfOyFjF522RVGkUE9rEAB7Qtr0kKLez832i8y4dpbum5F+cD4RpVeNC+rVcRL
	e/39NAsLJPPn11FSz9GvNH5MAhe7gDF7PkiwfsZ1F9dTH+N41b3cLSl0kCIU=
X-Gm-Gg: ASbGncux/ytjpq1n71Cc0dL6rv+XACz+/yGVCp9AnWPrcUlVeBDm+q2dUdhkRAGFsVL
	mmku08GIGHI/thztyKlSbrZ8rGW8BE08x9WacsZP8DV5FkaDEUW4FwVwErYvSFJLoeoKYSFEQnI
	G+2FxmIt0YOsRvsLg1Xbf1ZwvfhvLpq9YTW+tYSlssW7I1wCa8Kb9xAya/vOkbrRHyCBOuh5V7m
	vGBiJQaKCKV/d0970G4X4j3RSo/DTFksuSErFuwKSA7pEZ+GeuccD+JQsqwKad59jRQ2MAXy/wV
	KeemJVTdk52YZ0F4clVqiu9HLEcFyx3ynKqdJ7MCbrx0NaCbo9kdiqbFa80D9EgnIl1SaP7AsaL
	Bh2WYOlUO07pPivvmTXN+IA==
X-Received: by 2002:a05:6870:d38d:b0:2e9:a15f:6c3b with SMTP id 586e51a60fabf-2ea96c4f2cfmr1052588fac.10.1749610718047;
        Tue, 10 Jun 2025 19:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOYMDwQ9+qWoO9sZAHQjuHpCm3eIJ+fGXAaOH2eDXzRmpmRSfdlsETZJ1wyfXaLwgJC/19HQ==
X-Received: by 2002:a05:6870:d38d:b0:2e9:a15f:6c3b with SMTP id 586e51a60fabf-2ea96c4f2cfmr1052580fac.10.1749610717755;
        Tue, 10 Jun 2025 19:58:37 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea85fa2cbasm478059fac.8.2025.06.10.19.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 19:58:37 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH v2 0/3] soc: qcom: mdt_loader: Validation and cleanup fixes
Date: Tue, 10 Jun 2025 21:58:27 -0500
Message-Id: <20250610-mdt-loader-validation-and-fixes-v2-0-f7073e9ab899@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANPwSGgC/4WNQQ6CMBBFr0K6dkgZKYgr72FYjHQqTYBii42Gc
 HcriWs3k7z/89+sIrC3HMQ5W4XnaIN1UwI8ZKLrabozWJ1YoEQlK1nCqBcYHGn2EGmwmpa0AJo
 0GPviAKo7YlUbdSsaI5Jl9rwXSXJtE/c2LM6/94ex+KY/t/rrjgVIwIYRuaYTmvLiQsgfTxo6N
 455OqLdtu0DDAXoCtUAAAA=
X-Change-ID: 20250604-mdt-loader-validation-and-fixes-5c3267f5b19f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=684;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=CAZ/SIZXGULw26SKxotaF4nRCv62GltcOelZ3heoC6w=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBoSPDceVmktbeGo5Ss9Evwmm1BekycHe1ROSgLC
 GrysKoq1f2JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaEjw3BUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcX3KhAA2hs1VdO/LFQzQLgsU3BG2hssf1iW48bhD0XhM74
 IU6pit9HUYEyrJhBT03PnZ3rxy7BomH9Y06pQ9s47EyHojwnho5oRRD6MjH3sse/Jp7ZL75ibFA
 lnOot35mzN+uQBaahtcZGP3vGslKuXeTHXfC3p5qr2phduPdcCZPUOu98Vewwdr/x9dLl9TordW
 2OrJtV6PQ1t0CF6vqvu5dS7PUplOpXecrTuA6IdeQJaE//Yz9GmAkydb4ffTqhFJOIlvWbSZJX1
 bbR5gRxM8S7r//057iUYJvXLUh+ZDvW+kWi3HIaI3e9S+y4X8eW8XqUXT8d+ybE6Q7HVy+fPE9O
 UxkOjefBvt1rTI13KrsZqocXKyCZQmUQjrC7JkNemrH6F5tNplv7RhjP+Iz4qLyjATOaVVThNIK
 vJYJNurNvvayYQf1NqOiWJHYrbraKDahVw1aSiqGtWr6Awz2CCl7hDdwwkhnA2GS0b9lNSfKAo8
 FopzqFannBwB48Hpf1GskAbCKO8JuNi13RStomgJu1mkN3jaWbcX4KLe/WFBrJftMM4NMBkS+Q+
 tPu39VGwBNK1J9uWJly/V7OBCqCVLRjxs23SA3Vsj4DMVyAiD7Knu5M8ApyKEbM36MWdi3qTL9Z
 dvQrgqdEXWHUa+DcEb+GF/mLULonX5NypihJvV0yeOs4=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=6848f0df cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=OVvt1KTugGfhVnbKlbwA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAyNSBTYWx0ZWRfX4D/Vkkwk2ooe
 uSAw5uSKgvDoKUOnrzO5O8NWri4RAur9n06H33QaJCxEaQ2X7gTYPAG94s21UnhGOs3HU/nXGPy
 TOQ2rBS6UQB4e7e02iDqqSEdUeftdLLNM5Y38+LDA1Ukytui0gvwXMdrKgu4n5A6kwGAEJ+R8nP
 eUU+EJzTLW+Q1fbCwrYXMlhwmdMqvdqeLytGF6BwYqisPYMZzshxXVqedSj3wOh7soyt5FXohok
 CVQGBgF+MACiXaIRBhmTn5KZYv+9l4G+gioGCvhdn4awzbipFw7tdGItE7XDXMkJQMztlZ6XYkU
 kG+UwNLxnGDcoId/eS0t7hFlQyAMZb8XePvFePuLjdPziG7WNJT1ZM54CzuVythWTPJtQ69dAxT
 IEczVQUO4XszZ6AipT/OFAMsXiAGaM7bsRCCiI4b9E4r/FlZ5CYpoqpYByIuUpbG1KJF6KGl
X-Proofpoint-GUID: O6uO3Ca9Wg1nMV1mwZC594fvAgbM_4Ma
X-Proofpoint-ORIG-GUID: O6uO3Ca9Wg1nMV1mwZC594fvAgbM_4Ma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=980 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110025

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Changes in v2:
- Validate e_phentsize and and e_shentsize as well

---
Bjorn Andersson (3):
      soc: qcom: mdt_loader: Ensure we don't read past the ELF header
      soc: qcom: mdt_loader: Rename mdt_phdr_valid()
      soc: qcom: mdt_loader: Actually use the e_phoff

 drivers/soc/qcom/mdt_loader.c | 63 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250604-mdt-loader-validation-and-fixes-5c3267f5b19f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


