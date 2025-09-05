Return-Path: <stable+bounces-177830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F2B45BEE
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11C8A40A5E
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBB30217C;
	Fri,  5 Sep 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkhgop2S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369230214E
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084741; cv=none; b=cWwnc1p+5OTBBXfJtb49+9PTWpqmPRao1yY3B5v2hCYbaT7HAjQ0Bk3QioyM8zC3ZnxWbXXYgTz2lLrviQLLPEi2ZIXgH2VjbXWENhHmhOIET1xAJ8lKa8XJa0tYTKW/TrfgCfZ5imAxAO2AczDCpA2g9iaDVrq1MKMzX+bFv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084741; c=relaxed/simple;
	bh=MoCMuDXvh+Nu9b2vpvZYjT7oWfQjMy2t9SXDsBDVWPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCu33P+1D8+iLf7w7574N0RK95tfcASINCigM4B/3zxCBcnz/QaRuQvhgW1eTESHBO5DizRX8xc20J0J3as6fXnIHFpHKUf5EsFGQHSlQI2OJQLg9N29UfeiUrnpjrXnuWns6U6QUSRRxYtqDc8PpE/LQ1g1Mg1M3fy8hIKxaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mkhgop2S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857CrUP003768
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ja7IG9owaxs
	h1UgdgM/0Skauh8Aewx5qIfunpWQiINo=; b=mkhgop2SOMwXZsAhrA4ValusQS3
	b069AqqecinOTRO/4cniy0P6p0Klumic0LwYbF138VNr/g5OWfpMdz0cWVsXTK8x
	oFm+U7k4DUDbhxjk3Z/hp9uUgeyk4/gwVdDbWhmqTxOV36ngbiav62MOMGPbCp+S
	p3GpfuU06W0CBBmipQukZwvUI6YB1aDeQIcCCyET2J1ze24G8aQx8C3sxV5MesvI
	btc+kx6+VvuI85tgGLtE22oW9Ky4eWk5ozTqSQEnXaEvqGJ6DbImr/6XD9ia+b2U
	y4Xljfh+Mb6BPSeFaDpUZey9tWBcw84yj4p7x+QAvL366SIhislhk5uXFOg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sbktn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:05:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329745d6b89so3882237a91.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 08:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084737; x=1757689537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja7IG9owaxsh1UgdgM/0Skauh8Aewx5qIfunpWQiINo=;
        b=lnJYYTZZXDPfHSOm//qZn9LonLcarVyBw7/E0XovJ2208r4hCbvfU5F5+C3fmZH2Jn
         MPLFoVuKlG/HNGkcLJX395pM0JKT1yldYn+6yz8XH2OkiZfMQ5l5u26ogKaprmpUwzN0
         v47tq3JQKoqnpTFR/FIXN8oie8vyP60CJVEOpoqbJVadYYVFIWMJSFsBeFbxySKszFjr
         iPaDIAumrvX/RtVtB5a38uPvuDb/av+6KRSBSbCE0ZDk9EWwU3r+n0EWvIldzj+JKp+0
         cRktfmKN3jD88jtPzsdB2vahy+75lcnpgLECJgLn0QvrDAOX7iTdd3kAWAfgNm63afMn
         GxsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD21DK3wkp7jnKeCoyz1XtbKaU4gRF/dRNgIb5F4hQ7m6rBU4DspiZC+Zu0wDMDFSUJMBydUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmIQQlRBNKTMVoBM6IG5EF1zP/zi/9ow3ofh1sxIEmj3bv4eZ
	kkO+z+7zB1aqEIKxp/O9nZ9eogy9iJdKImyOQlArl7COqiwKwRmiyouhSiTfw2Vi7eaUl+XHIC1
	nTTJhQrBBr5GolggUcwoBgEEpvVfgdVxHnnB0DUxzzBPT/9+e0CR+Cikry4M=
X-Gm-Gg: ASbGncv1fG+EdrfKm3xR5sT2yrkBNl4vn+EMB4plDV7QkFH3o00pjlZbyMIYNx2HE1v
	4Am+ESaId2W82DESGcZcNx7XvUejcyuC0gdjV8NKyuQjKM+0kMLDgxjT1PrRax4nBamc/VGxnLF
	yoKyFr2t9zvSeoxHcfo+z4X+9N1PbYdrpz8sWfzB5OIpyI5srT2a9QPiZGp3Lzc78SanhrQDvlj
	fBy6jyh0HuwobA0qVPbm6PYmfZG7VYxEzK113VXwqPyo0XP5h5C+Uk4awLVK/przIiqz7EgNOoM
	iR9JmqpFqA1WXG6XYOTOejS9BFuIBSmvvPXk6CMDgz9HDP8Or9hNOpj9oQqz9THxBKaL652qU7L
	v
X-Received: by 2002:a17:90b:4d92:b0:327:e018:204a with SMTP id 98e67ed59e1d1-3281531d3e3mr30603486a91.0.1757084736543;
        Fri, 05 Sep 2025 08:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqIiEJYnj8QbW+Wv6u6rEqkieOl2LWNIL2cqibUoeZ/H246F4m2n7ChcRg2w3QOWU4GeqyAA==
X-Received: by 2002:a17:90b:4d92:b0:327:e018:204a with SMTP id 98e67ed59e1d1-3281531d3e3mr30603424a91.0.1757084735781;
        Fri, 05 Sep 2025 08:05:35 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:35 -0700 (PDT)
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
Subject: [PATCH v3 2/3] ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
Date: Fri,  5 Sep 2025 20:34:44 +0530
Message-Id: <20250905150445.2596140-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX3pFFHDHelMmP
 5D7x93E+2eg9rsNS1nja1n2fC6AHWw9/hPQwSNHxazzf11jgPGk11MPTr89lw2Tte1JiCDuDMg3
 klEYFzdNV6cbAVXAS9A0oj8raUfRTFfDjrSQqHdMHXiikJNX/y73m+m0YYznAqrRGE6ky4XCw5E
 qCAsjymJfsZ9uDR/p5ll0eN//Gj16r9MFpHGhFi6LCkd9OBL7Mr8oqHW0KbzBzs5CddUIrnIC3g
 Xa0IB7r0D+wj64WUddKMkT59M6zX7tG/IKC9V3qnOAezI2sqpIA95JPisI6uG/aP8NJDzhc7fFR
 qMINo4NuXiniAZSLfJGuw45kPw0jeMzV4eqWufRtG77ywQUmXiMXvzYU8D4yqju1me0CeBvPiLs
 AvxFy9eJ
X-Proofpoint-GUID: ScWP5Xh4VmOnqprfo50z0n_eLZmFDDvw
X-Proofpoint-ORIG-GUID: ScWP5Xh4VmOnqprfo50z0n_eLZmFDDvw
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bafc41 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VUbThP3hI7wIHPtXhhgA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

The q6i2s_set_fmt() function was defined but never linked into the
I2S DAI operations, resulting DAI format settings is being ignored
during stream setup. This change fixes the issue by properly linking
the .set_fmt handler within the DAI ops.

Fixes: 30ad723b93ade ("ASoC: qdsp6: audioreach: add q6apm lpass dai support")
Cc: <stable@vger.kernel.org>
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


