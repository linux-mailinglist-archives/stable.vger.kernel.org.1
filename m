Return-Path: <stable+bounces-230026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMW8LabBwWn0WAQAu9opvQ
	(envelope-from <stable+bounces-230026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:41:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DC2FE606
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9330306874B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529F383C83;
	Mon, 23 Mar 2026 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXFPfg4P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEcDTOH0"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55998384249
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305550; cv=none; b=clKaxVPl3CCS+dYy6t1aYqH8ksjRHAeWWAHGGMg4c/hHsL5SWtPv8x75KbPMvFnQMk2UOWEn8BiU2HjlVhWghJL6pk2DFw7rPClGWhMl0VjdniRS2V71RAu1cFzqQak9kZCgsTKMqCqlZZ1tZ+doIiskrrYqlNxkVumPwgix9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305550; c=relaxed/simple;
	bh=uSbPbbEF96iO4/jDf1d3kH2TPon+s7DHfw5HFTuRwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFwlJLbEBY1LNDN9h6n6M3I/4U1dDJ9iPQhK/DL2r6/XCz0MoWP2kQo1n5f3BG+zb6RQOVjPxe39aQhAme+ZGKfXsF9+cdADppLX3HFWvytbh86u2j5AUfMkO9PL230G8Zo0FmqxVX3XeONxaEu+JNRBblHWEDLj0RuoztmJkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXFPfg4P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BEcDTOH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqrGx2681734
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/jKQw8dGxLC
	6/wkqCmrBcQV0wz2LZBd3Fby8QVjVQNY=; b=UXFPfg4Pc+yf2grujnyk+iEix6P
	EGl0Ezy9IKDWfnTcxfEvfXpvaAJFq3lHhyjbh1jzAZQGY3JYxrksAaCIj7p/pgZE
	hfMNe1sd+/7jkyqC58m32NZMcXODN0demDCsiK8ZELr/k1er/+R+WMIZhN+/GTte
	FcUfTV/TEqls7IDe5JLBacuUYH1InGq1t1lqX2JVbM/EUafhNTnQs1+7ZZ2INz1J
	w7cSpJLpbyq7wl4cbGBt4x1FaZZ1mB+iEHMkiaXvt0fuBG1oBTX1IcLpHR3/pBZh
	9Y9Qbstm4o0EtvMhrI33AwKNTU3OAv6Ir0mqyBfdf3+zNI5gxdF1/hZ7mQg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p7axqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-509219f94b0so61547201cf.3
        for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774305544; x=1774910344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jKQw8dGxLC6/wkqCmrBcQV0wz2LZBd3Fby8QVjVQNY=;
        b=BEcDTOH0KlM6asJ6wnjVNKvGXIuXK3CTdxPmHy+FQO7Qf+LoayBeqMpW2xMwoB4AZj
         E3dmeSUelNXffw+oTXQAx28xlIoaanZ1k3w7LICnb2tEz43DNQspMDqR3g/5Hi7mpMkC
         1C810/nO+dCc9x+q/aydtWdIBOsvn/hFKPnlgf3aq0uJ7mEFWfOv2D5OBRm9a4AX2QZP
         BhYJPboIZliifUk0bnC5WV/nOnMu9AOkdsvDYe+FCqsA08ObqPQj7tU5NRZQvjJ3QDfo
         jAOjfXeTFfvKzbyTw4kgwto1vpn/xkEO4cNptVgE+kxy8K/zhhuIuw7dno8RyaHtA8J/
         0T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774305544; x=1774910344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jKQw8dGxLC6/wkqCmrBcQV0wz2LZBd3Fby8QVjVQNY=;
        b=dtf3fHE3pP0Q/0mHbkSyvsrMI4L7MJXdJ3VNiVSeqSrpsku90d1JAwN8gLlViXvZV+
         ielLYr80RUNJC6qbC8/mFVtU1P8ljMY75YA/rnatv1OVos/pSgyfJL5+qWxZhl/9l+TT
         rZs4sIW62XZnhWRUk5zOHx9mKWzW7ZbzYVbOVVMlGn9ejoxE8vQjtgnNGawGagbpofsh
         +SlYZ4zLFk8QQDH9VMv2iHN1vLzEWbsVWO9O0w+2ozA7jj2AoDvOLzSTFlCPSl5jet0r
         hbBANYUp/moUuZwB/AcMzRdUWlcb+ouEW6NoSv4FigPs9IeddyMFcyw1AnToKuYq5GXi
         JsSg==
X-Forwarded-Encrypted: i=1; AJvYcCVU4UhKDf2sjeWXnaz86omYWINBhNbYRdoNWkbIGHdhzLqb+v0LQu8Qu0iKaK18c0uiWaNc9bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpD7HNiT0wq5PEPy47rMytKFP92BaITnzDS6YEPRZBO7eWkAz
	vmGTiV4u8t7LD2Bw59eo2Z+lgGDH4aaRQndQiI4KpEiIb01Q2AU6WreJC7fW+OI9iOdlN5wppT7
	T5Q5iT/KBJJHY447X6iyeKpHRmhcU6YaIq2LY41lz5W+CCUMQ/C4XQTr2Qn4=
X-Gm-Gg: ATEYQzzdfBk5VYbP4Gd71shPRG8tZV1dZoP3sgbIdx1qWQ0Z96YlgkPb4Jgo3YGrYmB
	h4OClqA+0QHDf/MUGgX9TMLLR6nractnTHOrtqc4VmOWYT+vgQG4WCimg4tLwek518b4rL2t/Cw
	STp+oC6IeZKBNP92N053hyU6kywyG5dXkMh88FJLn8Q5hfwPhaGPIRJqQakg6lvFNzbP6ro/4Nz
	9Eo0S3XMOytgDBrOJJoyC0h0KtFvQCLEK86rpWYIQmAF+EO9ldfaQie2C5NCwiMLGp7RojuKBGS
	FvsaT7ZQqQ5z7agEy/Indj0/9t8zw/Ef8oiTGBrnmovOLUnpKuM7NVJHRvzBZzpSW+pjRH0rb0A
	CE8VwlfHdoQoePHIGIl/uiWnSxZJ0sJTMijjd82Zfx4oGGE/mhWnzfOY=
X-Received: by 2002:a05:622a:154:b0:50b:6fb2:fe1a with SMTP id d75a77b69052e-50b6fb30404mr14837241cf.42.1774305543682;
        Mon, 23 Mar 2026 15:39:03 -0700 (PDT)
X-Received: by 2002:a05:622a:154:b0:50b:6fb2:fe1a with SMTP id d75a77b69052e-50b6fb30404mr14837011cf.42.1774305543137;
        Mon, 23 Mar 2026 15:39:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64715539sm33320351f8f.33.2026.03.23.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:39:02 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srini@kernel.org, val@packett.cool,
        mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v7 05/13] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Mon, 23 Mar 2026 22:38:37 +0000
Message-ID: <20260323223845.2126142-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323223845.2126142-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260323223845.2126142-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c1c108 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: eVoP5NzKBT_11Y5GfybIkUeHqNlS1mxS
X-Proofpoint-GUID: eVoP5NzKBT_11Y5GfybIkUeHqNlS1mxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfX20f3l9GWMMZD
 GSlESZlvsrdtnpHLYI9aye6GSaYHOvHiiTBipICIUz1zPR+oVMi8QpmHRyD/yvSIfaNgTCMB53Z
 ydlcBRKYnOodgmbWuqVK8n1qqk+1BZ8Mg7cnbmEU3aAUexyPtXYWPvjM7i1vD2dCPZ2VIhT3HKu
 J5HeUq0PUmyracwnWlyFJ3x3eFPl+8m8XkYPWdWhQfLvDJOsaokp5Qc8zj4HR5wurri4+cekb/J
 5alQRWy+yoCa1umQNtG18Y2l76N4oOZ5olSHKWhSaPPU/qO01AsCiI2TT+ljlGVKVfMAdecVKky
 uKppEo57AgIpI5z34jqz+moQN8Yvs9AtM2+NKdL745Ij9WaNQnrHpfq2ak4qGYLTzfNZNcK/gtc
 /yEaSTKLiZSJ1tLl0xHRtb+DYzedSqQxMtzvkJdGJLR2vVXlfw6lhnN9rrOH67yJNYtqsdbq/LJ
 V1vR0qiF/chIBMKly+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230167
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230026-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 350DC2FE606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reset queue pointer on SNDRV_PCM_TRIGGER_STOP event to be inline
with resetting appl_ptr. Without this we will end up with a queue_ptr
out of sync and driver could try to send data that is not ready yet.

Fix this by resetting the queue_ptr.

Fixes: 3d4a4411aa8bb ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 1 +
 sound/soc/qcom/qdsp6/q6apm.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 306e928e7b49..292be457764f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -317,6 +317,7 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
 		prtd->state = Q6APM_STREAM_STOPPED;
+		prtd->queue_ptr = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 1fbcbbf3123d..9d4cbe29cf94 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -215,6 +215,8 @@ int q6apm_map_memory_regions(struct q6apm_graph *graph, unsigned int dir, phys_a
 
 	mutex_lock(&graph->lock);
 
+	data->dsp_buf = 0;
+
 	if (data->buf) {
 		mutex_unlock(&graph->lock);
 		return 0;
-- 
2.47.3


