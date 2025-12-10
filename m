Return-Path: <stable+bounces-200713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0ACB2D07
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43839311C428
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB912FE06E;
	Wed, 10 Dec 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXc62bqm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+DBKxCP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C12F99B3
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365885; cv=none; b=rNqbvkyo4wdjuGifPNmVjYIkjLWVXxq/olCFOs1MatwcEuz0RBXeuJ1WtQmCfJ8DQhKJntdYhNg+sc1d1UOZvI7Y7jgJoHLEaEqxk3mxq0DiJZBwrWWbKMoTDnmytFAJyIaWk72QVZz5nopRZqXlS1c1E9JH/Lo+jP1ZnHU2C1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365885; c=relaxed/simple;
	bh=cv/MpDxkm9bj1BI6PHG0lW873UwxtTeP14x+eCF3rKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4dI+wd01/7fRnsmF+Hcgk9lukBzioAA23PCf820gRl9rerHdvMMBKHagT0G90mE4vXOYQS92OGQpO+mEqMc6/oI+Rol1WizBBjFz9fcGZhiY5VnVpQZKgJlthMo7YCUkyCqxHUmWIRcymGHhhiLClxLaBwMRfbQUg7G/mblzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXc62bqm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+DBKxCP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8eMvV2669701
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=62XUzBsMAUn
	DDXsuylkY8xD2h2WtQl5JnYPJsOXdjqQ=; b=JXc62bqmo04Sbw39slEPZg84Gy1
	lGRbIQmo+RsG1GQfCZUZTKhWhB8o5HjHI5GlaCPYZ31KB3IwEsvgz3a4yJpw1LcA
	Weu7xdibXHiE+Yrvw/gH5h5Sayu3T/OXbxeVEK5Q6ru5hgOoOHens2K/m0Jh3r9h
	jKF9KRu0qmL/LAWajoxqjZWva4AbWNaYA7rGSdAJtsARlcCOngPeYGqFWFyTO2mp
	Q+0k1fij41ULYMwDdeElUvU36eyIupwQe3Q3FhL9Swo0Y5ar8LJbCrOuS+PCwj0E
	JAR1ueauPRDStPttJVoBYWACgZtPTg+CWuESrydmrpugckEHKdjSJgflPhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay4ykgm2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e19c8558so1308313485a.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765365882; x=1765970682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62XUzBsMAUnDDXsuylkY8xD2h2WtQl5JnYPJsOXdjqQ=;
        b=K+DBKxCPJyUvV6qdLcNe7Uw7u6HuCA4ESCHYePDAvZkPVxhFmYenDBkhuHoIuTAr0Q
         J3tUTw3+GDzLfAO8CIH5Yx7AMvUX1ndzr7r3iKsasYSoGPAv1O4XhJsPdzKM+LyBXW/M
         I5VRuwgE2cP/35QpudWs09l4f2uXU8oY/+Gt4/2vb8Q7W3fSShj/eJCwPB1AzIhTv16T
         w5BYkUYZ/0kpwtgTnqM1t3c9Pw19sUemNM+oagorbu94og8cMjpEun/QQfkjXmYyai1a
         ChJYlADHnH4B2C+xCDTwqoGdQg26SFefvy0ElrgjlxVFd8JsMDjhWz3eDCdq5rBmMK5H
         y58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365882; x=1765970682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62XUzBsMAUnDDXsuylkY8xD2h2WtQl5JnYPJsOXdjqQ=;
        b=K53IuO+tL/wVl/8fxKwoSWbLjhQT6lepZhD5Bbo9qlNhVpwgxpZ1rCWxXoXT4k7/t8
         ZOxQMctYr3DFSuet9IqoDcdomsN7AklJ9qs8411eo2Uc+B7ocfNkpoFRH0R7eZ+uyFKU
         dDGj9EKjJie0aVR/ebJudDR4p9aa/2SDwTXNnVKNK6xbwFlZFZNKNapPgwTqaZtO7fxV
         +F+jB2ec0cN3tJR9N+hs37tw69Z+OHuDFw0vPUKvECs5uVvVGgKYULFDt759pTQgLe3S
         IaMzNCSNc76BWFW3km2HNEC2e34HvBELRY09aWORR2OEKu9GnceA/mbiHgCQvVY78LHH
         z23w==
X-Forwarded-Encrypted: i=1; AJvYcCU2arJ6/SkPFpqAc7O4Ksqf7K6cVwTpr5fD2H2V19T8ZH6J/vduQ1cFcX+L3PfC8OVTeoIB5o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgLdHC/2BEUc7pwxGsncwlxeplVOGwJclNaXWVA/cbb6TkMZE
	dyZOUlxWD0MyT+o2We7kTJYaCSebtOJdhIcKwt+YmYmdY3WiX8MmZn4yqv+v/uRSNbp4SYYl04M
	kR772veQvIFgbM6U5p+SWCElh5qA4pDJaQ+uxFPcthaezeuYC8Sj56a34rYU=
X-Gm-Gg: ASbGncuOZyenzXhEA2x7jP+tYRtZRqmAITtHdkY89/dqe9GD7OPLCgDkkz+v34mwIDq
	vXdgk+UY9/AHhu/aduNatqMQ8CiNZwLC8rZJ6uK/qqhBIUfHe+d+E36bSLUHKDebA+ZOdI1Wa5l
	uE8/433wUvv+EnF2camW44YPblujuwpOxEixmJCqsYYLnB9Sy5C3Kvee7hkl2Qq/1QWgtOwq20b
	D2AaEsZsHRnXbI6OAMoEWQK9De4WEx6bdn2BSGojT4CmkBGc0vM/dwZYpwKMlmyEHYaZmdu8iGa
	LnjWRRs8Gr0QnT+4VxXnzT1lMiAswqTE7AHdi5bPkcKy+4yHkQMuwwUfEzTbsKu62Bvq1uJdhp1
	FtN1B8HfzDDkGgHmkboMWCQ1k/2NC7kB7nx0xiQQa3OpAg4jBYqykqvebGPnhlxC9O1j7xi5SXn
	FDDIOyrpr507pENkhtGEDg9ac0
X-Received: by 2002:a05:620a:1789:b0:8b2:4383:b3d7 with SMTP id af79cd13be357-8ba3ac40723mr287153385a.78.1765365881581;
        Wed, 10 Dec 2025 03:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOEZKDYgRs0ts4IA26zkaUYmjQtYHk7rPP4kz6Nz/u82soBx8ce3JHq1ZDhZgu9kG0zkIuhQ==
X-Received: by 2002:a05:620a:1789:b0:8b2:4383:b3d7 with SMTP id af79cd13be357-8ba3ac40723mr287150985a.78.1765365881148;
        Wed, 10 Dec 2025 03:24:41 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49e3fb1sm1696851266b.60.2025.12.10.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:24:40 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Hans Verkuil <hverkuil@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 3/5] media: ov02c10: Fix the horizontal flip control
Date: Wed, 10 Dec 2025 12:24:34 +0100
Message-ID: <20251210112436.167212-4-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: jkECOHoJcifdg5PXYIsiTUp_jT76ME4e
X-Authority-Analysis: v=2.4 cv=Mfthep/f c=1 sm=1 tr=0 ts=6939587a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jFe5OU4AeXr8QxTHl_sA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: jkECOHoJcifdg5PXYIsiTUp_jT76ME4e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfX/L4DaIj6Jui6
 KzZ/eeVnOl8a9Rru22d0bCcNlggpWmjnRynXbQvnIQgvrAA/kLXZDLrUXMTO+YArfh5FD6CYDAJ
 o+RRXsYIMXS9iAacAiXlKrdyMQ+cFegF6/6sear9HGfrXp6STJaMm60wPp04yENTSjhil54N+vw
 YFzyAgh6HLWAGFZkmoTfKvhIFGFo2tbxgcq09Ee8JXWHNjwv6LJIgNQm5Ll/KhcrNEPcEvz3qgv
 Uf55Ld2HoPwfCIYDusS2vRRbpiMSMKdLnwEBKPdnVHAH8Ajio65+Anu/u+giCve9XB8qS98V92c
 DpYXjem1dJi8PbIOsKLVvF2KNjGj1EdKAQ/uwBTSF5kBm4YSBxWiwanWpsGfuYQRa/MMcOnYUh3
 JvsLAk1J9NcD3MTeAsDpcnTCiIdqkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100091

During sensor calibration I noticed that with the hflip control set to
false/disabled the image was mirrored.

The horizontal flip control is inverted and needs to be set to 1 to not
flip. This is something which seems to be common with various recent
Omnivision sensors, the ov01a10 and ov08x40 also have an inverted
mirror control.

Invert the hflip control to fix the sensor mirroring by default.

Fixes: b7cd2ba3f692 ("media: ov02c10: Support hflip and vflip")
Cc: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index 384c2f0b1608..f912ae142040 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -170,7 +170,7 @@ static const struct reg_sequence sensor_1928x1092_30fps_setting[] = {
 	{0x3816, 0x01},
 	{0x3817, 0x01},
 
-	{0x3820, 0xa0},
+	{0x3820, 0xa8},
 	{0x3821, 0x00},
 	{0x3822, 0x80},
 	{0x3823, 0x08},
@@ -462,9 +462,9 @@ static int ov02c10_set_ctrl(struct v4l2_ctrl *ctrl)
 
 	case V4L2_CID_HFLIP:
 		cci_write(ov02c10->regmap, OV02C10_ISP_X_WIN_CONTROL,
-			  ctrl->val ? 1 : 2, &ret);
+			  ctrl->val ? 2 : 1, &ret);
 		cci_update_bits(ov02c10->regmap, OV02C10_ROTATE_CONTROL,
-				BIT(3), ov02c10->hflip->val << 3, &ret);
+				BIT(3), ctrl->val ? 0 : BIT(3), &ret);
 		break;
 
 	case V4L2_CID_VFLIP:
-- 
2.52.0


