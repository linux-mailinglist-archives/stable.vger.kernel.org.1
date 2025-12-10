Return-Path: <stable+bounces-200711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8ACB2CF8
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A435730D5944
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB042F90C4;
	Wed, 10 Dec 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dv35FpFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KtrPpDmr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AE2DE6EF
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365883; cv=none; b=ME0LTnM++ZVVXh3yRihGsDnFtEhDHFmHqAME9DOSD20sjszWCiGL0F3O31XwYw7OAGYjK9kCxNt1HF7cGUnX0WuLHt+CB+sFU5gwXr2AQwGhhl8cx+cHYAxkM53N/2u7+VxXWllO1j7Szyyc8eFKx4ImL9xHJwFplOcxbGrFRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365883; c=relaxed/simple;
	bh=rNR7EXPl86rbTWN0Lt97s6nqyMeGIDhIh2PCHA3te+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEzpKpv4XLw4m8p24A6/0jcQZmS4t9zc6xR0P2Hl69vAxkJ1pRt+Vqrdg9J4HMa1x/za2cP5D94avgb2pD5d+aeH2uvv93jGgmYbzhlgielFdYEERJRqLtjp9XJy0dTfDbmC8usP+mW+MCjyOGftR9FSO3Ia7VTl1utNqs8Bxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dv35FpFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KtrPpDmr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAB65hL2419637
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cnMORWoZXvu
	5f6gtZ/v4yMHO8QWC0/Po8/JI0GaNh7c=; b=dv35FpFp5LQtHnNmoMgk5kyRN9N
	hJpUmLinMlYGCsvdOmkQD4RxFUrbUXR8jWT3RoxdNfLbfNl7KiwDCy0RRYD+9OOg
	giVfsf9djKkEVBWxqS8zrpqwNZDV7+3ilKmRtqnXKrnnsqy4XjHBLw055fqwR+IQ
	mBc9AoncPpAUAhRSXvp0en46ZyJ/53D8QW9MRZk6JVnO/CIwTGPUa6RINE95I3lO
	WlxKradk1KTinDmXZMY5AaUKi/7udg2euA5fkRE0mp9JqF8Yfk3B9mZwNL9BczQT
	2persq8NkYEOkERgl9/DOqgbNQXQKF6j1zZdRgt3iKFoLUqoYt2lfsp6iTQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay7pp01aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee416413a8so75496281cf.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765365880; x=1765970680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnMORWoZXvu5f6gtZ/v4yMHO8QWC0/Po8/JI0GaNh7c=;
        b=KtrPpDmrrvLMJSfhMtqUVd9hJQOT1q59mFHsumzeyrXStlX/NWSlOKUQ0qfHtA/B+I
         Uf+jHnUkZI70MDDRXRTzNCBERAMTBbVJbM8DrV8yWpqyHYyZDh2pt1vcN/lNobhVDpKA
         wz/jssuHw1JlvhILtfAXAeco43ApitOGfAFHqS6Ei6gpPAFXFW2ca0dZSTNd9NeqtV+A
         52Hp6O+RECl6Bd8syw0nShWVlk83whBTh4UM0IBUOItTzTauwXINp3qm6x2uUKhapheO
         BmjvO5giOM94E3efM2e41PR/takXs/HXNCn4bSgCZP3iyMx0otEfM41Bv/fFncIduM5E
         Ub8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365880; x=1765970680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnMORWoZXvu5f6gtZ/v4yMHO8QWC0/Po8/JI0GaNh7c=;
        b=SV7we7lB9dKf/877b8vqqWXKZ54F5qMlV93wjhFYaUEUI7zBUdd5dM/YeIR+sRZ26C
         hmlghe4umLM9ql2p5RjQ5qOmbfUp+75tIRe6FFlmaDm4W451Ug9ADv89dUhKLxUI9cZm
         L4WtDDOOFQQhrQT8Te8gc4i3LxALLAm/e6bh73cGBugvrNUV1zZLX7DinuA0zr5HZvED
         R2W8yBvkEhTLPi+9CGstTob3K1DWHY4d7+XYIWN8+EaXl8SIMJ8GxCZ5vrs3JOsL4r6G
         ofZEUZLKV6ZoVOeJkR5qZgl7Mf7mOdrbb22KB5pVh6bv2GXgpml4o0ijPpvoWWsFgrqU
         +0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVWQYjnTYQS4vCfHUG2hOpAl3H/Yt35bgOtSdkgiEiyyajJRWFF1jAb7j+3/DS2V0WLYOfLZL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3JiQHiS+QfJITli90HkNW0LsUw9mPZ79Je6P4vI+xeWsYSTN
	9WaFlC2rYBLhc+BFnjRvP9t5AZNBkT6fV0t491oKigzNwtn8KS4TufeNhaXcWGoQJ7LT0FCLgv5
	Q8exhYV4PJIkTxdQ66PuAs3f4UWWMl7989Q7aotqVQ78oZ2S1L0suRMynP64=
X-Gm-Gg: ASbGncueVK2OEDgHyN3AxlqECKC1Rs7FX28DanZA9KuDN7JynI/w9+pAtzvS0SZ0y6r
	hjPeMzsltaGMh5GPcQtKPrqhhZFOVlwPWCYJBA1GcUAZQuJYKJ7A2WY0IqDX3BGDGvN1sGkLw4F
	5QNM92vFP3IcizDFBUECH7mIumNP+Q9TIf6UKiUDMNu8XQoIvg5z/Mg909O95v2amxNpgOD3Tnf
	B8fflkGiMbN82CRBavtLtRB6nvc0posGX2CFFpF0N3znJ4p5W5RL9KQZjJ4gq9eaVTUPoltirVC
	6o1D9uAum0dei8yv7cOuv8XWejuvp4Q8K6EyJOW4A+lcMh4L7NiFZdkKJAxFv/6A1erbTYbAnvo
	+C1kFQ2c6PNcV3huS4LVksnQHTozEttn2HveuH5QbWAAd22urvitJe1ZgiuydJJLwfoP3L1kT05
	4I7gpcFCMSfWHTFVP7Z0/ifZKW
X-Received: by 2002:a05:622a:2483:b0:4ef:bd1c:69fa with SMTP id d75a77b69052e-4f1b19e77a2mr22745851cf.18.1765365879675;
        Wed, 10 Dec 2025 03:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO9bwBKRNmiwv5FMgTPvCrvJKKiQgWKJR0H8r2+dfvJPaWrOtgVlfrbu7O8TWWqFyYAzrnDg==
X-Received: by 2002:a05:622a:2483:b0:4ef:bd1c:69fa with SMTP id d75a77b69052e-4f1b19e77a2mr22745501cf.18.1765365879204;
        Wed, 10 Dec 2025 03:24:39 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49e3fb1sm1696851266b.60.2025.12.10.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:24:38 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Hans Verkuil <hverkuil@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/5] media: ov02c10: Fix bayer-pattern change after default vflip change
Date: Wed, 10 Dec 2025 12:24:32 +0100
Message-ID: <20251210112436.167212-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
References: <20251210112436.167212-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NU5-Y7PoUdPMIcuzNIxZcAdZhjGJsIk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfX+ttBU6WdVFke
 YR3uF6GhxSpeAcAHEbPS5iA2OKjn/Qly9KE1PLCe51xGC5DsxNq60ypZ7X77+IisbQA0bxsMpHL
 BkgRh8Ed+f09XSfvDEhyRVjwc/76Wr01GfMLnErMWEIyzVV3Ko5WR93blwTlXWomfy6yW/Vg/+W
 qIJ1cD2r0WVRITVEB/hk5TdT5lmf5GIr58eFjvMy5NPGfYcZV+GxEqDQdv4FhBXnwEbdeRh9eup
 pUWAjY+UPm/lIveyphWVkeBIlHzER8Galk+dGnkYHf8hGeSMpiy/ZeJx8ORxSE+Yyz821aUFkFK
 pJYPDpYE4Kx9Xo5HdNRJX7KzE58Tx7pKllq67WFBqlOtc2JIAAvcNQdQyP9neYIR8t8e7YNzKF0
 bUlGrgLZlznw1pbtVIlUUCPfhHjpLw==
X-Proofpoint-ORIG-GUID: NU5-Y7PoUdPMIcuzNIxZcAdZhjGJsIk8
X-Authority-Analysis: v=2.4 cv=WaMBqkhX c=1 sm=1 tr=0 ts=69395878 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eVcqbF-lr0Sowpx3myIA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100091

After commit d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
the reported bayer-pattern of MEDIA_BUS_FMT_SGRBG10_1X10 is no longer
correct.

Change the 16-bit x-win register (0x3810) value from 2 to 1 so that
the sensor will generate data in GRBG bayer-order again.

Fixes: d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
Cc: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/media/i2c/ov02c10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index b1e540eb8326..6369841de88b 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -168,7 +168,7 @@ static const struct reg_sequence sensor_1928x1092_30fps_setting[] = {
 	{0x3810, 0x00},
 	{0x3811, 0x02},
 	{0x3812, 0x00},
-	{0x3813, 0x02},
+	{0x3813, 0x01},
 	{0x3814, 0x01},
 	{0x3815, 0x01},
 	{0x3816, 0x01},
-- 
2.52.0


