Return-Path: <stable+bounces-118716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D4A417EF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C682516F151
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD1242924;
	Mon, 24 Feb 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjWEf4zj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E04241681
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387377; cv=none; b=Ju7NGmBl7uKC/4ZFhzcVOTOvwROuyMsbj9RPHbXQVAESeP5qQaq3sLITEzb+L/3Oz1ANSYo8WzFLbvtWJcI+9QjQWEsgz78Tzs3EZz+zhxy3kLP1e1CNXp8sIbPhTmEwlluThrr84I26m1zZFz50FLG1KXSSETESEbmizg7I7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387377; c=relaxed/simple;
	bh=ycAwiMbxF3n0lZ9z26ElUzrRQcR5Owt3AdSg+tGrPXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6Pw9blCxIDBrckiasuYqSdR6rl5oli4QKOIzmgEjMO4oyMpayTdwwYRxQVFcLH4wj8V1/0gSK2FALWsSQf+n4KsfMuj6gPQhqwPikMVz26m8+K70yWVlRu8Myy0WmozmniXotBeQgHScatypLJZrD101KHe+2JF1vb3yxv3Kcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fjWEf4zj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NM0eYH005873
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TeXXCbYN/NL6nm0TIhtB7ORF7skKDF6mo30
	jLzYZfoM=; b=fjWEf4zjHwzpUQY7T33v9fYwr3sykKHfc682wdJSe/YCv1v1WTN
	/lDeRdM5zE6HfRX7eXc0B/B6EtJDLYZ7LgeU8HchSfQO/Bo0tEI5IGprX2UdpglQ
	xMob63sLxVsEEJ0lrktmesHDPH8JuZ15XadXLJnTHEUpjuiK5p6ZJjY9ZfLfg10J
	48v1KKDWw0X7tUj9tI33LKNRCpcp2ifPl5wWavGDQZFI4XRhxVrzf6+wYan9zPQ9
	+rvlGlsWwEq6OSyHj0sOw7mg2JGUU2zHlDRKYN4R5AfqS0jqGiZ6swEGyz/yINqm
	Dhmxz05HyYx7LkVApfyKQ0qSyrXDLLh/pmg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgmajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 08:56:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220d6c10a17so94666285ad.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 00:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387373; x=1740992173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeXXCbYN/NL6nm0TIhtB7ORF7skKDF6mo30jLzYZfoM=;
        b=d98RlaeyTyk6pEelLyoWEQs/WeKzHNtmHs0jx4MG0a5lCLDdYfQ6J6wEGyqzxDUSeh
         sz60uQX5qmEEL21pQUOdxbbxEs8PBvvV0s8+Eq3GT7XTySFp71ZYp0XEbA6Xkggk8+pb
         gzOBY2Fnjj19TaXYMQARMpEVmneV5b7/3d32Bhlj+m0SnzspQ14DtwK/zOYZO8mVAutU
         sGZ7HH6XcwF/Gw3stFk8PCGe2INY7racTZslh5OPt6lFGCvWpjZkZwppTOQ+2koJVec2
         cz9h1vSr4roGijPPBChfvErIjWWszCRrYRE8YH0VpKeKOZB+c7VRrsQ9UASfjhIjTU78
         WGbw==
X-Forwarded-Encrypted: i=1; AJvYcCWH6ayKt6/GnfYMheGpPwK4txHwobOm4ocSIvmxzOTVEQ0BMeu0P+6P1Ddk7b+v/beR0peWn6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrTVvsaRCDQte+8Wi91UUDh7daJS60xGpSLnA72KVB6ZH7ln1
	69xKi8UZ1/lo4e7ejx4cOxfAr+2fjyTPSZhSRf4BdxugpsMR5827IUnDVpfNcolOXhCj0jy5yHN
	nbY+KFbrK+cQY7MCMrbk+oczU9wnS2OFTrlC/LSUBkvyqcHX1pyD+f9E=
X-Gm-Gg: ASbGncsArvFDdnSSKFOeSKOIkIG0vbgeOL8Yv0d7DXJJ+OBF64u4AEw675rIZDeA8g+
	2R0aSBSjLt7bTH/qhwBw9iniH37YMpxSu0tgLkD6ba3DyEq5vF7SmH470R7dgrsUTOnupAYNWNz
	EBRkj9JgGoJYPOKcr/1higTZOs+UhlVc6prd6UNvGx/7S5YHcdzyDv4UCoZMXe0E9scbG3SjPEr
	JHsMo3uXgaXcVuxMer3ufnWCVg4M8Z8tv5fYqk3MPdTHxoCUuRhebiHGwcZZQsbu68TiAvhZjmn
	06pmGam9WZw2Hb1dDBJ2n/xHBBBbhhXkPaqu4pJFpJsw
X-Received: by 2002:a05:6a21:99a7:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1eef3cbe826mr22651565637.9.1740387373198;
        Mon, 24 Feb 2025 00:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGODOh9bvtWJ+Wd/yTYPKP51Y5HpfVfLQY6VnaKmCSDPUuwobspDsFFqALPPRN8NBLX7OhXIw==
X-Received: by 2002:a05:6a21:99a7:b0:1ee:c7c8:cae with SMTP id adf61e73a8af0-1eef3cbe826mr22651528637.9.1740387372762;
        Mon, 24 Feb 2025 00:56:12 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm20161399b3a.48.2025.02.24.00.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:56:12 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Bakker <kees@ijzerbout.nl>,
        William McVicker <willmcvicker@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] usb: gadget: Check bmAttributes only if configuration is valid
Date: Mon, 24 Feb 2025 14:26:04 +0530
Message-Id: <20250224085604.417327-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hGpUhJ19I0Q2mcgF41ljv7e9qwp7QSEa
X-Proofpoint-ORIG-GUID: hGpUhJ19I0Q2mcgF41ljv7e9qwp7QSEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=602 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240064

If the USB configuration is not valid, then avoid checking for
bmAttributes to prevent null pointer deference.

Cc: stable@vger.kernel.org
Fixes: 40e89ff5750f ("usb: gadget: Set self-powered based on MaxPower and bmAttributes")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 4bcf73bae761..869ad99afb48 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1051,7 +1051,7 @@ static int set_config(struct usb_composite_dev *cdev,
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
 	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
-	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
 	else
 		usb_gadget_set_selfpowered(gadget);
-- 
2.25.1


