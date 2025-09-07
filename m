Return-Path: <stable+bounces-178037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F5B47AD2
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7381E189EB7D
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AA2620E5;
	Sun,  7 Sep 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="He5UVYVg"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF72609D4
	for <Stable@vger.kernel.org>; Sun,  7 Sep 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244131; cv=none; b=DMxRdHxUdQ/1HY7XzqKBKeHFUnTUmTwSltSJs71g0r1HIiBdq1+BD1cqwSKe09mXt3r+FrZt4J2o5EE/JTSxUdZ6zLywcTf9BcLal9wfV6PZD3j7sRZsSSPwVf+gFlcrsbRvGGxP7L280sdC8dmyMOIN+ZfB1sqpY3wtVrgUZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244131; c=relaxed/simple;
	bh=Y67OeXOkwjcW/WgRDCaa4+GVWkV3DnYW2b1CZ9RDeD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn2jd7JefmroOKEx1jpPO76BmLypycJBlXZkXPxTZ+XXCvE3oz05MJNoxbFhABhptjDmNgUSD9qeNvQ9RKvVIKc5U4HYLnREBB46ds047eBjn43e8GBbXyyEa5vmiLhTDpicCUBpN/f7obqnDzHFVMyMxhiVZyo853aaArido+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=He5UVYVg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587AUuxk010385
	for <Stable@vger.kernel.org>; Sun, 7 Sep 2025 11:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jw6p4thKtOG
	Ii/duK9Bwui939to4NPczh9FQMtKLRgs=; b=He5UVYVgzFSPSHyrXkl6dcmoMAq
	yi/iz8se6Vdqr3NKuNZmha2s2KUP3ql+FTZB2nAzdJePQJSPLH3XU/oYEeUb6Pab
	z1PW52eNrSWujywPLV4uDAK2EYtwlrbbcuvKgNVl+8E33cjoUI2a5tXwZvN/bdPG
	WCrGQebyzeLCHQw1F1hFIzVqOZo/Xo4t3xefMMIw4Wwt+mRpcP/jxFcp9J/drTTs
	uJ24rvR4pV/Wyz6yKFnXpJkb+VtYD67Az+tCioDhzqNx/RkxDCY6mUdbxjGl0XzG
	rr0A0SlheOFGe0zMi4LWnsmKC9Tp4cxKF4ds+gFVQA2RdcVu925xuqWD/qw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8a01w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Sun, 07 Sep 2025 11:22:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b345aff439so100285551cf.0
        for <Stable@vger.kernel.org>; Sun, 07 Sep 2025 04:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757244128; x=1757848928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw6p4thKtOGIi/duK9Bwui939to4NPczh9FQMtKLRgs=;
        b=b4+qGCCphIweL6JiVwRTN53gY7fHYOYPbFww31R45H04IRzPkS2GO4zHaSDFz7Rdpb
         Zlk5UNRvJs6jK2FadOptxs4pBCt9fTQbcmUFodbCWWhLqvz0AuoBxizmuqFhznT4MEm4
         8ratPEkiXlXrUX5KnrYWuAsrOVewpfKGGlZpRVct0QZJFDWRc8MGKuC0/IVRg2EI4IOj
         qqHxGmSkNQnv1CexcFTUWZcDbukPXcfU2mp3EcJA9AUjplMjUV6NVbEJbtcqbzxCR6OP
         gAKs2ODjPT4kdx1GZIPVp1Cz8+ABES62S/L89sDvSi+WGkYishg80Gw21Zyc+37tqMQH
         5qyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxV5RwZpjQCrpObp5ehJUaRLJ3JxXZiDHKd4q5CM7Ojria1rBGHT5PI9W6ScN97LG787bkeg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVw+Jqwr+b7f6l+ncdB3fxIMdHjeYkd3ajzrDEuGetQS0HBVvN
	IVgtNLHs4TIK4kjHzuxJ87R8fVhmS8WxS5GCOYS9A0uD0NQhawH2D6S0ic6ysL0z+4a4c3rJAIt
	IlxwsVVz+MqTjb5GwcJrayCc/B68iDrtNygh0/SV1bZ4rD8akLyHa1N96ZQI=
X-Gm-Gg: ASbGncuVW6SK++DBoIFQ5zZSvRLdY0cFWFJ3ba5hXeMxBKW+Tb5RPKddObKMRe8qrrw
	hRo16D26hF9lpE1a35wK1YST3vOy+fcjvHNf0mqWf+E0jwJeeSKjdnV2MyC+JGFIXcRqvCsYc8I
	GLnNkrjL68Y0bvnS8uaO0PSMWjG09gCPeYVcrYLXnhj8F2+q15ygA8NyUmJJsUtYpxcxzm9bEe8
	QRV8bywmw1p8EWyR/NsXU+BlE+YTlvtoZJqoLP/7cvOHBOm/8/76yvjgYt5Ezbdc0vVGemC/RXF
	uGrcwrnKjOU2n34h6C728OdW8ICeMcPbST+XdUofOceVGjgCdDVCnQ==
X-Received: by 2002:a05:6214:130d:b0:71f:85bf:6386 with SMTP id 6a1803df08f44-739453b8593mr51717236d6.59.1757244127741;
        Sun, 07 Sep 2025 04:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUK7tyWynSX9vOFGSp5aznUiforb8jjvNd8bvncFpn2AcSchHoh7Woa5kC+0D8QEz8w1rZxA==
X-Received: by 2002:a05:6214:130d:b0:71f:85bf:6386 with SMTP id 6a1803df08f44-739453b8593mr51716966d6.59.1757244127332;
        Sun, 07 Sep 2025 04:22:07 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm37523289f8f.61.2025.09.07.04.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 04:22:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        srini@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v4 02/13] ASoC: codecs: wcd937x: make stub functions inline
Date: Sun,  7 Sep 2025 12:21:49 +0100
Message-ID: <20250907112201.259405-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250907112201.259405-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250907112201.259405-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX45Z7+0owhI+d
 nAavYAH33o7Ls/rpfEDWJFesjIRss5T284mZUW0kHYXXgA4ZMYcbijGtOePma7PpRFaYNvKMYyu
 M50zhHTY3Jn8ZNj1DqQBZqzi/FqX2ZP2ajkavqvfihMZ5frtlXY/BAWvcTmLf+yw1AOUbCx0jvN
 mARIENIV91hQqzBRQIOBprLoqjB0/zGWNjYvEvnyZmU5aPW2uqO2NCLcGxRpxM+LOD2coAoR9dd
 sp5evSC+je4tqKPwNHEW7vKlPsGE4corEy8og5+BREwtP0ff/zroOf6IQyVk7D4DpvJ68nxei8n
 Bz+FS7t2uQgLPDD7QCp+wtQbMnRJHYrG1KXNIIXEVGfCr0sn0DtyaUQjSQIARcgOhTbiCW3vzdv
 eMdcLAc+
X-Proofpoint-ORIG-GUID: nAUNRAX8IDzmOPy3l22VtDxvQnaeN-0l
X-Proofpoint-GUID: nAUNRAX8IDzmOPy3l22VtDxvQnaeN-0l
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bd6ae0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SV47_qJM1wkz75m2VG8A:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

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


