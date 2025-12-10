Return-Path: <stable+bounces-200712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CDECB2D01
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5405E3105568
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261CE2877D8;
	Wed, 10 Dec 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TW0LoTTH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrQCNEVq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581312F12AD
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365883; cv=none; b=dZNHGYabPls4clNgbUs3QJESC9ZnC4R4TbXpU67B4ww8s/+UYwATG1wek2gfTdk54aFOdmnYwDcO3+qyh6A7dzf92Q70Lyxu9qvluDf+JtGggb/+CILm1fkEVcZ4f9tFH4VWtwTA7AQf1u4DcXwYWJvUuFcDvoDun1GV4VnsYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365883; c=relaxed/simple;
	bh=FXUKIqsthWWyvudG+oJkzl2SQLj5wPYuhwqvhfNAqoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9vu1+N0/XBOgJmRhxrs4sE6Flvr9WEeB+O4VlZG1xSZa+p2Nr/JpMV0KLITbRbmj0newvSBMNoxBV5lDrkxb7E16ThS3is/PYZZuA1F30jIZSDkxIh9wEIgQHZ75tlqXjULD6fdDMDD2kaNGsUxN0j0ikyZqMShwoP+1AqUxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TW0LoTTH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrQCNEVq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8e0FE1917966
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kzd7UvnXKQF
	kJhVz2pcrda3QFTnBwb/widBA8XEE0gA=; b=TW0LoTTH0dGO5we6PPPj8jKUJfr
	pP4iNBbyX4awrf8yHOsmFXrNjR5/Wkm5JoMcbm3j+Fovz0DfsjZre7F7diKttSkQ
	aE2nt+XNPxlsHCRssIAyZ7CMsAdK36l7XxmMVORj9UyjOWdTRpz3ADMDdj8uvtwA
	QBixNzTgWYf4ebJX8kr9TsaSKJ34xujyV8DTkA+Ci9uCTGcJb7syhgXumiT+H4hG
	v9QTDOL0iisqYQX5YHQTcZtWmhZCIyNQsD32vmbw69ukh43fexogKBCvFqyjqd4k
	QtaLqbKKikTzZABCgsTDlJYBwaa3xx7FxT9Sp4GKy4kMybk9kK/S24q+NoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay1xp16gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:24:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edad69b4e8so14426851cf.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765365880; x=1765970680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzd7UvnXKQFkJhVz2pcrda3QFTnBwb/widBA8XEE0gA=;
        b=ZrQCNEVqaOp6QrdkJNGjJrLR0g4Zs+JPCi2cikjw5gW0GiRLtFzCskib4L9bhC5E02
         2uoalbfvntbVxhouG5Vy0leDCDvixGZX6rpa+HY8oggJmvQfNp2vzKRTh/4PK3VfGG0B
         oNx8Adf9ik6OpOcWbUQvtIIv63pG7gYUZxFPsYyaYY6XWJTqxNfgAzVAxQX9xY5O3/G/
         SGWQYSLvd6tU+yLwzEgphB1nNNk1m9aMs1M9795k7lh2DkPajQu+/XjuxHmE4rizeE+A
         2mEk2a3LQOEoAXjV5jGj4fpQFWX5RhTgCbee0MalvKvA0rlZmlLrKRHQOriLQ/tr5OV0
         un4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365880; x=1765970680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzd7UvnXKQFkJhVz2pcrda3QFTnBwb/widBA8XEE0gA=;
        b=F1em1chgc/XKJ/DnTSw5YaazLvnDp8512AhWw9lk5gKyI9BkDIs3tIkUE3u+xBYBTk
         rLsl12q3MlLiVae24IaBjJLMC+uP8f+uJKDoWhBDx3E8ZqqUkc03mee0+HTQ3ch60qIm
         7GY59KIcwI5bzDWDmBhBSHghGpp2kf5HeURiHsqiUhVmrmc93dKw/X2hMKnG2GV6XKod
         QSHFuwAf3gM3KvSgnpjwLWuzrUH6Jmx3ZiklQEOVpFHZdm6J+IUER5Stgwf4RIVsT9tD
         hcJt3Zqd/1T9MJm8yPWmLkKQ/dh0L88hbHJCOOpqPwBIt0h7+PlpjXzJuu3ZkyyTU3LO
         9YyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqOkvor57EijVBgnB+6jrsxCFWLvOUncQ06p9j9stwNj6Cj1sjqBETL6LL8QVD2wRiiByxfVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXbrEVLQDGXMzMSJSZjGIEYMdkHh0+dtqKcxn6sqALxnKIQnj
	PDUsOd/fbHKWp87eEg7scLiH9hXb31gtYQ47R461huPcI+HVDM2lyodu/q9idrcCqnO2BoLepvS
	ov5hIZzsxNHvmoS7EPRPLZHJLIYxcMdgCF+UwnUj40rNjM/TrGpNdX4kwdc4=
X-Gm-Gg: ASbGncuxA5wKNW+sTEClN1hAWHMBAoPg0Q5t+tPJwnb/EHOn/O1VFng7n88fO7ioIAL
	8l2UoMSPOCpFh8Jyb7BAWC2qBnbyVyYmuHlahao1Qpbel645cCG5eKPHP8Izu4IegHB+Stm1GqM
	M0hbn+I7x4+8F1GK9IBfVbxRrZOrvPypHenTB27ZTLJOiyYqbILKgGeyqXXj6ppqs0tuvmBv3dn
	QISRUSGmedANYx1DV/Zxna8rdTUFzBhlaWdSpDVBwUrxAShqlaev4BPj0eifPS4QLPMmRasLmp9
	zJUS2yrnugrebNDyVtM75yky4tTa3LPXExGveld0bEfCTsTteEYdajgT/7ry/4PLwgabHNYld3U
	8nInV/kZM9nRxsMf2FknStpsfNiJCYj/I7OB8TLiHpeyz3wREr33W48OiNIlkxA78fOw6Wx4O11
	j9yN7iQqqtMnBzV9/yZvaYVtjM
X-Received: by 2002:a05:622a:514:b0:4f1:8bfd:bdc2 with SMTP id d75a77b69052e-4f1a9b7857emr71133601cf.41.1765365880586;
        Wed, 10 Dec 2025 03:24:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQPMMAVv5ADsYY8uNhG19fDP/1leyomv8BxOcbJHU/ekZS+71j2kXZcY67O1hi8mHDbFcZSQ==
X-Received: by 2002:a05:622a:514:b0:4f1:8bfd:bdc2 with SMTP id d75a77b69052e-4f1a9b7857emr71133341cf.41.1765365880201;
        Wed, 10 Dec 2025 03:24:40 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49e3fb1sm1696851266b.60.2025.12.10.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 03:24:39 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Hans Verkuil <hverkuil@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-media@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 2/5] media: ov02c10: Adjust x-win/y-win when changing flipping to preserve bayer-pattern
Date: Wed, 10 Dec 2025 12:24:33 +0100
Message-ID: <20251210112436.167212-3-johannes.goede@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MSBTYWx0ZWRfXxuj7oDO+W3f0
 1mwR5cjaaylRZgs/aKaOgCzJvTfzgnL2gN2fD05FQPgupgbeYGwcvpvpqomet9P6XtvQgnc6Cs8
 yDvuml4m06LdmOUx/oGhIQkeJusIckxsWhHxT79wYVBcg7yxOeAdEvMsfF7LvqbvhtAg1o0pto7
 sPzKjrwVbNPZcQyPoYhb1ab0QDkVCcF/krtev7qVU0kEMOqt/a4ZkKgr1tN3Mrv7N//XFnEVG34
 ftrVTcUieISOo4+Uh+mw+7J2ntyrbh7N2sfQlv0ZNspim9t0IFurW+NBvPik/SkYKBlenV6sy6Q
 tTm5DYSODoEo0ScbPeRA9SRJeRdBVqmm+c17ggy2wDOhuBFtSpFcHM+LLL7LsKG0H2emLo3Kk7h
 ylmkr10jmArBcAZL/xeu3i3MEaEhoQ==
X-Proofpoint-ORIG-GUID: 1ddP832gqla_YzwVM7Z3KXHyIsahziMc
X-Proofpoint-GUID: 1ddP832gqla_YzwVM7Z3KXHyIsahziMc
X-Authority-Analysis: v=2.4 cv=A/Zh/qWG c=1 sm=1 tr=0 ts=69395879 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=oX69UmKp2CGo4zr9RpIA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100091

The ov02c10 is capable of having its (crop) window shifted around with 1
pixel precision while streaming.

This allows changing the x/y window coordinates when changing flipping to
preserve the bayer-pattern.

__v4l2_ctrl_handler_setup() will now write the window coordinates at 0x3810
and 0x3812 so these can be dropped from sensor_1928x1092_30fps_setting.

Since the bayer-pattern is now unchanged, the V4L2_CTRL_FLAG_MODIFY_LAYOUT
flag can be dropped from the flip controls.

Note the original use of the V4L2_CTRL_FLAG_MODIFY_LAYOUT flag was
incomplete, besides setting the flag the driver should also have reported
a different mbus code when getting the source pad's format depending on
the hflip / vflip settings see the ov2680.c driver for example.

Fixes: b7cd2ba3f692 ("media: ov02c10: Support hflip and vflip")
Cc: stable@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/media/i2c/ov02c10.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index 6369841de88b..384c2f0b1608 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -165,10 +165,6 @@ static const struct reg_sequence sensor_1928x1092_30fps_setting[] = {
 	{0x3809, 0x88},
 	{0x380a, 0x04},
 	{0x380b, 0x44},
-	{0x3810, 0x00},
-	{0x3811, 0x02},
-	{0x3812, 0x00},
-	{0x3813, 0x01},
 	{0x3814, 0x01},
 	{0x3815, 0x01},
 	{0x3816, 0x01},
@@ -465,11 +461,15 @@ static int ov02c10_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 
 	case V4L2_CID_HFLIP:
+		cci_write(ov02c10->regmap, OV02C10_ISP_X_WIN_CONTROL,
+			  ctrl->val ? 1 : 2, &ret);
 		cci_update_bits(ov02c10->regmap, OV02C10_ROTATE_CONTROL,
 				BIT(3), ov02c10->hflip->val << 3, &ret);
 		break;
 
 	case V4L2_CID_VFLIP:
+		cci_write(ov02c10->regmap, OV02C10_ISP_Y_WIN_CONTROL,
+			  ctrl->val ? 2 : 1, &ret);
 		cci_update_bits(ov02c10->regmap, OV02C10_ROTATE_CONTROL,
 				BIT(4), ov02c10->vflip->val << 4, &ret);
 		break;
@@ -551,13 +551,9 @@ static int ov02c10_init_controls(struct ov02c10 *ov02c10)
 
 	ov02c10->hflip = v4l2_ctrl_new_std(ctrl_hdlr, &ov02c10_ctrl_ops,
 					   V4L2_CID_HFLIP, 0, 1, 1, 0);
-	if (ov02c10->hflip)
-		ov02c10->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	ov02c10->vflip = v4l2_ctrl_new_std(ctrl_hdlr, &ov02c10_ctrl_ops,
 					   V4L2_CID_VFLIP, 0, 1, 1, 0);
-	if (ov02c10->vflip)
-		ov02c10->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &ov02c10_ctrl_ops,
 				     V4L2_CID_TEST_PATTERN,
-- 
2.52.0


