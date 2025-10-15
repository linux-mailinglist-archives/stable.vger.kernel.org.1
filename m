Return-Path: <stable+bounces-185820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B6BDEB60
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B04748181D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245DA22424E;
	Wed, 15 Oct 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfVNaGvx"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11320408A
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534295; cv=none; b=AwWxnS71N36KRGN8qqwoa2JgW72FZSqRelNncwLFn7jaleDkqKuKcQkGJBghPpnFJb7BA19ue5Bt+KB5IN2ZMMSnoKp4L09Rep+5VLsdaoNBlfo8ETbNE1CVCXTI72RXRho7Ov+YapU3fSJXYBf9S69iA2uxyXTzeaBmMHF0F+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534295; c=relaxed/simple;
	bh=FciMJV9TB+OlUWS0wBBXljHH3OORGyEACeJ2UfDr5yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWgCKUqWwY09zgClhijvN2pWdaCa5Q/QVnHAEUgmafCT84UlrGJNHRVku/eThlameZJArKY+KPbg4V/rZI2NirvE9Dm4/dyEn9Dlt3GAtHiK1gk2T16aei5wWUKwsCicxoribWDNYczn2dnJ2WDtHq/am8pfH5AMj1UeaiNpQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfVNaGvx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAqe4K009128
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qHkE+bKT/J8
	nbQ5S5gGHutvtvukdRZt0lHpKcZkg+54=; b=TfVNaGvxxRSKVcbpPC/Wp1JJJec
	YlsdhhhsEh5aeuH/7/kzZN0kVr9ULIK3W0b3ZuqtLUY+wazTc3YN6YtUTFITAP55
	c5Bl9XBUJ3Mb2xX+E0tj2YKVMAypXQ6+6J6Gaj0Hnzy3I2sFRDJns1D+nWa/h7XQ
	qRUKvF8YMkI3j/eKwidoNIc2ZkhCDdBvuCREBIzUxR3wLafIMmCyuOEOGQEhP/bt
	F+4uxX/hpKRld93fh4EfiNd8coNXHUZci/HtUzLhrGKip02u16sJqrkP5o/yOAxT
	1AN2wy1nfOCFLR6avE8THRn23OvklOjPMwq4T77rzG0Xr1DqTNirboY/2MQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c4ebq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-876ee102b44so32372116d6.1
        for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534291; x=1761139091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHkE+bKT/J8nbQ5S5gGHutvtvukdRZt0lHpKcZkg+54=;
        b=HQmCrikvYs3Zx8ObftXP89NilVOx0pm7J9j7rfRLo/rR4ZigEQKR0mOfS+d2gL2eVK
         QbIOSrwMD/tXKWkVweXS5Yjtk4Wo0pdzRnRpuuxBDf//M/RKBOlSpe6BorA0BMAhCsrk
         k7P8fEF711L4Ts2t/btY1WTD4O7DbN8Yn9C4GrjYaFkcK8SSQY6O1ZB2YNhV6ZZxNmVM
         s9BE2++tCPsuFi2jPnP8JxfWTBMnAadP3K+9Ig2ogwxELttWhSmx5EX+65CN9rbJbygL
         VGY9W0627zAPHDp+kEbxSz9m0YjYDz85xdhgELLQ6TWmqk+NFnOJJWxyuILA4q1lfqk+
         Qbrw==
X-Forwarded-Encrypted: i=1; AJvYcCUn8JeIXFQ69Cum5OxwzPwDwESmbeUP/PEtG0SL31096s0hHWYM0gr+Kjta+IYWfvBw+gY8jF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHFTw68mLrX9Dn4C6E1YB3sDjl67zOuajC9YBOMWmpljZAw+6
	lHRIH4aM64xS92eDx36Q8Vn+KqluaHfzS4zhKT0qMYJgSsJHawRLXVBWglcLKeySgrCI4mYQO/g
	5ite6mIzriyWUX/OP/i+6jTxESAfLGjCE2QKKya81duJYhEQ822CQR4ZIKLA=
X-Gm-Gg: ASbGncsKv3SN3r7Xrhs77gS57/W/LWNggUxl2vqCOLeb7rraFf1sodMUIGcXSxDqeXV
	sNQ/LfQYirbghs0tYH+aJylrtSulsnw/fvzCER5icyExo4asoqHxpEA4XWUf1yTmb7J8jrEO+bj
	xqfP8DLxi/siX0ovMJe6JAICacD6xLWUIlQMlyjk9MCxBGpmtUQCaDwHkruhiwrNsADWSBHLS/t
	H5raU1uxuWkuRhDi2xRdoXFK85Lk57srUx5I/mz/jYXMh7A9I8WpzzP+MZtzVtaeQo79bV6ybck
	YXgie9rzzNNJDm9g6NYIrEVBmr+st93a/WDuoC8W98NPOS9vSMYmEA==
X-Received: by 2002:ac8:5a45:0:b0:4e6:eaa9:8a2a with SMTP id d75a77b69052e-4e890defe64mr794891cf.15.1760534291279;
        Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYMWisWH0+ZGB14jA4jsreCXonf5bTEm2tvxmjYdPJwPg9hoSqnxhGbMTLY6h3qG2Avbm8MQ==
X-Received: by 2002:ac8:5a45:0:b0:4e6:eaa9:8a2a with SMTP id d75a77b69052e-4e890defe64mr794491cf.15.1760534290799;
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 4/9] ASoC: qcom: q6asm-dai: perform correct state check before closing
Date: Wed, 15 Oct 2025 14:17:34 +0100
Message-ID: <20251015131740.340258-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dQnALfwPsjclG44NUgBYKS2bLPfh4Fg1
X-Proofpoint-ORIG-GUID: dQnALfwPsjclG44NUgBYKS2bLPfh4Fg1
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef9f14 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=MOmvoJmQv4oe-d1MVI8A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX++ityj8ZKqmq
 Tbs11tPcmeB2hqFUmhmTZIrUY7rsLmQ9OEZb0o2cEUosnJeNNnF2BB3+Hl8NZfjqcrAswpeRbhq
 mzDZlbEiy3pYLdR2XLedi63eX+KIGrERD+ra+V4Ei1vfL26JqR+zzyrywY+NbTgoAcO9gpHr3tf
 /jLmFs5hfj+W86R+rx+CTiguijwxwvOm9aJ0RT294398cnmp7c5n1DrwSwDLaUyHMzc5nf9+IgM
 XyRq2UBZShZo+umo+wI+23aTtD0zSm0DZPdHNBLPBTaPAVgLNS9FGqyP9UFS8VJRJe2FpCdMA15
 uf8CtQiY94uixISoW9ANbNxObQ5HdcVnYTkyJvpgSqzyYdmymFRUXF8Zky6gOxbXh2ydp3TX0Op
 RpqcPhwTGVbPVhv4z7dCsdmbaZYgGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

Do not stop a q6asm stream if its not started, this can result in
unnecessary dsp command which will timeout anyway something like below:

q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: CMD 10bcd timeout

Fix this by correctly checking the state.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index e8129510a734..0eae8c6e42b8 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -233,13 +233,14 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
 	prtd->pcm_irq_pos = 0;
 	/* rate and channels are sent to audio driver */
-	if (prtd->state) {
+	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
 		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 		q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
+		prtd->state = Q6ASM_STREAM_STOPPED;
 	}
 
 	ret = q6asm_map_memory_regions(substream->stream, prtd->audio_client,
-- 
2.51.0


