Return-Path: <stable+bounces-178847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3860B483AB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E733BC37C
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E5238C0F;
	Mon,  8 Sep 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pT+UtsMG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE22367D3
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309848; cv=none; b=IHTnz4T+fKa6byAGZ67q6MjO2bYNGFz2p9e1vVilPRATYree9rI1g2VqLk9U9MoKEPfOWSRxO3mVCBAPMwrvUgJg9YlVCP4SdsVKfgr+ZWu+86+o376RtFbAJfoPnRO/QCRrarcF2hhx/JhSEcrqi8gvhHf8ARuaDiK9U0TwR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309848; c=relaxed/simple;
	bh=RhOFMO390kD6vVPQk+wsaIHxpEh7Rl6s/uQ6K6nB+Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P43gqST5b3AtkxsFS4zAn6jkODsD1kTDRxWl4vUSYfQtz+TaudIpwifAsljluhDTM0B0TueviJItDRsREnJ6xKCpakZUabbIHaWf5yp4FTvnBgH4HD5SnYohKz95jbFY0rh5wsWVsQfo6+iQwBhHkE9Rj+pvv/9eRYgj7InbEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pT+UtsMG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880qGoN003713
	for <stable@vger.kernel.org>; Mon, 8 Sep 2025 05:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HWX0jsMcz+X
	znw8DUFwCpjh9opKGeTSObz3aq0hQzb4=; b=pT+UtsMGperxMiWj/SHOY9fBAa0
	RPiePWRqn9AtH3Yg1EdsgYIKWfxAjyiUNfNhfX+H5K50spInLYiRZxdN0U7iCypf
	ltcs5u4bGQo/OB8R2rVGgKuikfA4g7sAl5NapYvuwEZTl0mCSpOPIFb9LFZvhMLU
	w21oZgBPIKet6dZAAkP8Xxdsj/lnCADpl0NnLsYTjlF/N4zewxzhmVwKUxjzjBIy
	J32/S5mv+ByR/4BVyvfMDaphxNBo9GQ+i5BukH7Pm4cU3sAG/sRG5dRGEh+1KWXx
	yb20xRQ7jw/xR0z9xfXS97LPfkemrpL23Ug7h8zPHWbBp3AZAxBCT6ffEcQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfu92q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Sep 2025 05:37:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4fc06ba4c1so3102715a12.1
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 22:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309845; x=1757914645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWX0jsMcz+Xznw8DUFwCpjh9opKGeTSObz3aq0hQzb4=;
        b=KpG31cNK+OReRjRSAq+unk+idG7N4tU3p8UshTGZuAY+OQQEwIZvDnI1XMsfXqMQne
         MHNDAiBVJFwi06PAjPXBdQRhuOPHbV0fUaeJzS0goIIwAjyxqI+1bhRX7oVyBppFTiyM
         OKN4U1AG5VtT48rQcQfFVhIa0qrJ0qMLQSZQQRCra4TNjaewLriqhvTquXX7Sv+LSjC7
         uUqi/G6XYN9WRaDBRqiwZxRw3TT5v3lAiUNcjcSJ9BmjEpGbo0pGTdbj64MfqqBq9Oha
         m0477BFyNbJHWO0mKKkte7Wpjksso643UpVZFtagqrnD2icyOUMyvdvoueaNp4DuEER6
         ldfg==
X-Forwarded-Encrypted: i=1; AJvYcCUp2fjSDa7trINwLtdZZozY8CBgKvGIv4vOFlMggVnpRkXqJO7j8RWpA36J1w5YKyf1zBKy1m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOg73/VHJV+/RGvLoN8FrIGAxEM8MJBfNkAH2UAHUs1uKnGNq
	0p21RcrF7q499MsQuuhgkeMEpJpnNM8qbWirIfYN/YAMtB4CT4jM/rtUXhw1qlCTqrhckY13QQL
	ol/WsxAmk0l+9VG8RDQUwq2xIpCNF0d5Aq6IOKKr+/Pougtn7AtsaLdJ8fsg=
X-Gm-Gg: ASbGncudz7pTW+kOwrE0xbd+RxlbCstUfdlp/vddYwrxzvpUD9IcU9DXHHqBuYhApFg
	6C73Jac/UPJdnuEdzLyJXQFRXG0gYAw6HT1693T55q2fbGykql0dZ7klGr7H3wQiEDS12nAwxF1
	DdSrQHUDwDsewHGAUyB5wVSMtUGzLOWpd7nNHWX9m9pNmcTHHaUh7DFa34MTw9VfUEt6EnyVWDf
	toz6WxzPqDa7UNW9menxHlVqGv7dDCBhLsXUXw7cwrkrEqBZr2O9sTxSW1JvB8565KvEd+vaDuj
	ZrqKGZi9KZReehPkUZz8h0ypO1kan2e03QJaGMeqJpKVdsc8rWtwZjfXkNZbk1fLQfLdlS4IOWF
	+
X-Received: by 2002:a05:6a20:4322:b0:240:489:be9a with SMTP id adf61e73a8af0-2533fab5821mr9907414637.23.1757309845021;
        Sun, 07 Sep 2025 22:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiiCDYxE12pB+bzy1cltbrdX0bzzKGs/EE30YA0O6ftyQUyRTV93nZj0ULHEaojirXrT3w0A==
X-Received: by 2002:a05:6a20:4322:b0:240:489:be9a with SMTP id adf61e73a8af0-2533fab5821mr9907391637.23.1757309844546;
        Sun, 07 Sep 2025 22:37:24 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:24 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Mon,  8 Sep 2025 11:06:30 +0530
Message-Id: <20250908053631.70978-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eU5kOTx513X4wVgmpgIobEBcDo-vmqdF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX776LQiTWPfa5
 u2fVuXFESvWDtR8HhhAcEdPQ7EDedfBUQVdK/F4bwwAklj6clqZrCt+KC4zK2ZiLyykvCPZm7b0
 RYtzuF0Fw9NCGgKVeIsn6vNFDK/OCzGpKv3G3pIDr3/zooKdW0d/WGhIe/wcIP4Yr4IQGznNT9Y
 T3JIRscLlLjhnldhWSmXmCNZBfok1fiumlf5cJTjSNJPT6vc1wP6I7NSKH+eB9ay3XRVZj5+A1W
 /QKMZoxyECEPv+Fna/bimTGJJb227UZiRi9e9zmBfdJcFfV7RhWwn32vA/EYS+wq/KxJRZPYdtQ
 OQpT1tvL6JvaeleqrY4QYuiO+gYGoGmdLO+nnwnjHTf6psuR7rlZp6rzgOXufktCUkFkv5DQPOJ
 90VYpmVQ
X-Proofpoint-GUID: eU5kOTx513X4wVgmpgIobEBcDo-vmqdF
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be6b96 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 20974f10406b..528756f1332b 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -262,6 +262,7 @@ static const struct snd_soc_dai_ops q6i2s_ops = {
 	.shutdown	= q6apm_lpass_dai_shutdown,
 	.set_channel_map  = q6dma_set_channel_map,
 	.hw_params        = q6dma_hw_params,
+	.set_fmt	= q6i2s_set_fmt,
 };
 
 static const struct snd_soc_dai_ops q6hdmi_ops = {
-- 
2.34.1


