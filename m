Return-Path: <stable+bounces-179078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644BBB4FA93
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE96D34402F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98F258ED5;
	Tue,  9 Sep 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NM/0uNpC"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5ED2F879
	for <Stable@vger.kernel.org>; Tue,  9 Sep 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420424; cv=none; b=rqV/zQWwOlZfQj2WqU++SbWkfiig/dXLfc31QPJ9aVQVlRapQI+0fUgYjj0w1JcJL/tpgqd4ZMvmF7HxcuKBe46KQTptm+hCQ5XRj7SDoXvPmzKyD0DrYgOV/LX+0P29l326KxgjE5z4mkZ8Kv//wGX/m3QwcrNJ1TaIlLLPbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420424; c=relaxed/simple;
	bh=Y67OeXOkwjcW/WgRDCaa4+GVWkV3DnYW2b1CZ9RDeD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5zKvmyT3BZ8DyTkLAN8d5QkOm9iGr3LatbZpDgyr/YEf+MIWm5T6Jvh4l6D/VE8swP2re4NWNTytsB+CPqTBITx+lBvDYHwwt9R7t7MY8ZkMEMkoALYCjjpyJ0FbVtMzB3r43kcdgLB7KGp9S8Nid4s2tpUlGbkgCNrBOqCr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NM/0uNpC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LQ6Q009051
	for <Stable@vger.kernel.org>; Tue, 9 Sep 2025 12:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jw6p4thKtOG
	Ii/duK9Bwui939to4NPczh9FQMtKLRgs=; b=NM/0uNpC3/AvOA/+o2UUeWz9DE3
	qGNRxtIu5eVS51f7SXII0au7YsKGpQDZ12aHkEzr4JUKQMHUDnFpdp4y2Efu5FGF
	SBGgX7D+sI5NdtbfJ3ZkZCMXfNmnTp4ocjBo29oYZ7YeaOHWj2K+HRhTweakkcO5
	b18o9w1IYhg7o88sp/F5Fw8ZNVQNVoZPumop4RQEMYPU3GDyaR3BfjtUF3u0UVG7
	+yrFiUte/kcX/BZtCP468JO49X14N4IPyK0uYhIg4QyD5hP6Xuj7ll5nWJwep5bk
	/7mR3Q3fTkXv/tz6RY/5KL1eFK94w9JTLqNSTJCqrKkbr0WzMwq3Xdy1TQA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdvyb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Tue, 09 Sep 2025 12:20:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f75c17a3so91847361cf.3
        for <Stable@vger.kernel.org>; Tue, 09 Sep 2025 05:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420421; x=1758025221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw6p4thKtOGIi/duK9Bwui939to4NPczh9FQMtKLRgs=;
        b=r/RLv4m3WT64IqUNn62pIDFWz5tp8gOUJfMG95/PbCB9/WMMCrpJFwcqyacjDIbTw/
         9kSWpBxdg+hd9u7mmdXn/iXL1N5ilbT8pr7nfAVbMCiGQeJhFbf/XERDQ2Hic7xFfo6M
         0392YR8BvGdIB1VwFaojXSQwAMlI/RcCrGJMd9O4oTwd644S4EztMYiDtcENitIGPzRf
         IIhhprZ4Gc+HOqTQhiDqbkjNHrLVhWJKqyul2lV3mWV9zZrTPQn1mzJLHhPJbViDNuEW
         MtSkuTBD81LPezEEUFffJZ5Z3OfqVcs5R/qqelsYAMflXNCc2SwJnmDFIgEHTqx8D6Mv
         JRXg==
X-Forwarded-Encrypted: i=1; AJvYcCVo6p1UK9u5vG745ngxNPxKXOAB9uEslZtnH/5pY3NqVqCwjf+qwxSJZYt17fSGIDUYUUQeXVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GC20/bOnl4lc/SvpLIfGwRQxNaN9B8o4OWhJhEbnsQuqJr8B
	H6TpNmyb4cdiC2EXbXla0GhCqIb+GyuHzhZQ31C6MwRHiMvHFfVxe7rwevmWEsc2cmJ/PDSzojK
	hPt5OuAiMNPgwz8ivKwOgnHtD4/TV4666RSJpz7QtF3iI55FOLvtcyJt0ses=
X-Gm-Gg: ASbGncv7N4m1+tBGMVSUrkKn1lZBQcdUnGAhWevUASxTDoTLzDCnE7AmhVVI1vqF2dq
	kKRYMx+9xpBNTE1LcffF07GgtyvuUhNkWmqBw9KyVxvTnACdr+NGCpZ3g9Cu/COfRgJvbZBReXx
	Q+53ZKLNK7/bSYeZauxqXBs1GGkPpUtKjyTJZB2IFcK6usHpgC//iG0dRg6IbPv2FsgI+I2plw/
	T4JclaUxu8VDxO0Kz6H5gxNO7oVAjZau7SuVG0U96tdFXC4TT/XXVhQaiQeQQ2rlUu5+p2JkxGx
	e5HKVNjN2z3lhdHPKLxqihjwhNxlxMWD9Ihk9NVycY2a1mP2Z7LhKg==
X-Received: by 2002:a05:622a:18a1:b0:4b2:fb0b:1122 with SMTP id d75a77b69052e-4b5f84bb472mr113320351cf.79.1757420419818;
        Tue, 09 Sep 2025 05:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIyTDywxBfjStYv8GV4OQGPpf5h39STdyrIcnbnoLBGmrnUb4Pm8UjcwFoNGfdUV9syMdXzw==
X-Received: by 2002:a05:622a:18a1:b0:4b2:fb0b:1122 with SMTP id d75a77b69052e-4b5f84bb472mr113317241cf.79.1757420419064;
        Tue, 09 Sep 2025 05:20:19 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224db20sm2414629f8f.60.2025.09.09.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:20:18 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, srini@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v5 02/13] ASoC: codecs: wcd937x: make stub functions inline
Date: Tue,  9 Sep 2025 13:19:43 +0100
Message-ID: <20250909121954.225833-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250909121954.225833-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250909121954.225833-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DFyfXYaSit98atCAYuQrgmB3p_OWi_KD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX7xSKsynfmD+D
 fpBztk0XpZPC4I5rWQYTP7+CtJ4MhLGRaP4S53fn2A/p9SDDuuDa+9Z2U06dnaEG0p0wAB+8sk2
 GIILi6gc95jcK+hGVjZHo1pJpp19g3XF1Ufov2CaOiMs5Tc4Br0GXCmQ8GJtqsKOVH+ac3d7C92
 Ei2tUg4Z06UroxsN6ns1vtUKGmpVJT3fS6kaeTcm+Fd0mdzbLr8bTZ+nMOAnFA8zmKQTJGD+Eri
 +86ua4hMpBeNWh/SN8OV5trH0vOMqgdmXC0pCSV6tv+o83z29zXAWUm3UCSGbdEth++IP3/d55a
 SISPNUv/aBbvVRv5ZfZTv7vqmvepDsSrr2i5QGDMPnYthYdyozRLMpthrxDDQULRNcpw5bP9hyD
 LdQmnbFp
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c01b86 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SV47_qJM1wkz75m2VG8A:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: DFyfXYaSit98atCAYuQrgmB3p_OWi_KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

For some reason we ended up with stub functions that are not inline,
this can result in build error if its included multiple places, as we will
be redefining the same function

Fixes: c99a515ff153 ("ASoC: codecs: wcd937x-sdw: add SoundWire driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/wcd937x.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 3ab21bb5846e..d20886a2803a 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -552,21 +552,21 @@ int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 struct device *wcd937x_sdw_device_get(struct device_node *np);
 
 #else
-int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
 		     struct snd_pcm_substream *substream,
 		     struct snd_soc_dai *dai)
 {
 	return -EOPNOTSUPP;
 }
 
-int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
 			       struct snd_soc_dai *dai,
 			       void *stream, int direction)
 {
 	return -EOPNOTSUPP;
 }
 
-int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai)
-- 
2.50.0


