Return-Path: <stable+bounces-214521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAW5HqrQhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:17:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A9F5C9F
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D113072A15
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876643CEF6;
	Thu,  5 Feb 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtTyeQhk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4fseVDl"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EC43CEEB
	for <Stable@vger.kernel.org>; Thu,  5 Feb 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311661; cv=none; b=PzGfLKDMJc6YV3zTXURTp2S4guMV6x9h61HGNhZPn8kliOVlpVACL7PkrVatIEIvSnXWvtv53G6q5cPPCBodYojR7f/HJpyeZMEPso2kjRTd9XtdvJftVuW/3Em/pcHr4vW04rLkjcAPqSLvaWc+s2gORocuyD3tMpHO0/IJ1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311661; c=relaxed/simple;
	bh=XaUu0VWsXIOKq9aElMOeuD+T1g8fF6us2kR3AzJirng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5tYxyfyq9aIZ5NbEaVegPveIL86iYevL+CuTleFK+SaYJnF6Gvjq1xInvZ3WU9EHkT/IWwI7HYaXqKwdb7T9oQr0elzvY7UO/jw/fCdYHh5UO7QZ7cOXtFPV52H/gAA77Bl1zYzJlz3+9bi/WpKcp9db+XeZKozQIKAT1dKvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtTyeQhk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4fseVDl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Bo8TT3047911
	for <Stable@vger.kernel.org>; Thu, 5 Feb 2026 17:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZoB2N4YhuCT
	U3IhDeytsYqmgYo6gsKL6Ikjrrs1blzw=; b=jtTyeQhkMU0n33LtUdb/sfVLWLC
	x9dhbYT9AefdJAD6dbEWxYEKT9zObdeGkGFOfdMoDj8/oJOwnzq99QVoU3U0Ujhn
	B2zwNI5o+jiPT0LjxrTuBNrD9aOQvks8z31Mg/MlFZjGwlA2ah794ADQGMguoWpi
	/LJC1WLotDpVeMTV1WAYv3KXtjLVVLnYHLj7YRH45fqVIbbebfqLh3qJ8DLguBqj
	AuWw3A0lnmE84c/Db10PkzJlqJkh3K+h0N0UQTLrQN0VyAXFHjkYMh9XhlgQj0PT
	ooH/Wv9dmtv1MErRxcUnbPWvQlMdaeh3QEM7XMdsNsGRWodEUva7ExDPZyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4mrtj7mj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 05 Feb 2026 17:14:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a291e7faso476019385a.3
        for <Stable@vger.kernel.org>; Thu, 05 Feb 2026 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770311659; x=1770916459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoB2N4YhuCTU3IhDeytsYqmgYo6gsKL6Ikjrrs1blzw=;
        b=Q4fseVDlDkyLG1yRzXcHBaLVBSWsl5Qqoo11heCQFC8oq+N3ALqbD2MU/86swVFnJ3
         9hTXhzvO9mjLl8jy40KLf+6K5bRdeofOEGpnChBfdEmbMTq9s7NJSIKgj97VLVOp76Z6
         ZrbLQnRuN/GSFJZj7/00aNQuj3nbk3diijfxlKT6zUHZcheZ9hsr6RnPZ3yfcVvbQ9Am
         +eUBeqL45wJhrEhtIrSHuGavxapYpZjaT8Wl3SWOHPfc9IGnP2UJolh08kbnYCJHjRHs
         38QiPgnjIOe5tbjTQXGjSgF1NRHakU3YddRre5gBm88jlWUXjWK2LuNk5X8rDQsa+xX/
         VSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311659; x=1770916459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoB2N4YhuCTU3IhDeytsYqmgYo6gsKL6Ikjrrs1blzw=;
        b=gtiNX3SEZLnfe+R590cl08noL3XId9KbHHMLpkmmh31+ZeDsDbPxrd2/rBBTAx+mE3
         Ts83WNQ3HzscNcE1B9mKGT/TNFquCqL04+lAXQigzMJokkhPUO5QazPb5EZuvtLgtXp9
         keCKHVtMGtsr4IwzY8lHCNCjz37q5nsCEWx0VtTqlicneR6cw1kUr85ElQkTufQMl+IO
         D9he0btegl8RRylfWjepiJ+CThPvvi2xdcYNkU/n8B0P2Bb/Pa06S+zYdvGkFfFqxeUo
         RUTEkiQbRk+xP9rU/uZ/qUm6SX8mrX3gDNVPKj7l5X+uWqQy3FewAjS+S27LD7iEaIP9
         A5eA==
X-Forwarded-Encrypted: i=1; AJvYcCW5vaER7wxItpoKzbbvELQ/TlW767OcWaRb0ty6bREXQgpI4OT6BIsqtzG3OcVKh74uiCCMYv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNBx28o0ppzhlFl1k46yGi0K5arEUanAYseEUFxLL5ItN2wok
	EQy029zYpTuh/CAq3yJD/iXLahRUEV1MLbSQ0KvNy7lL8Oyq9rSE/gpj0QgJoaxuFZv8/DJ9tCQ
	I+GCEMY57LglisMJ946NVEQJfBhU6kCMuU7UWU9j2m3KfDYTsjL+bET86IIQ=
X-Gm-Gg: AZuq6aK6o0zC3/YaI//UgD7paNz/N+zxUiKytgzHiBSILnm09JkndJWS01Cwsz3rZ3C
	Au7fXoxe4q+ngVInzmGxzij/FvP1ofBKoUrAesfuOjFWLGAPF3/sKDg0Rxsru3tJzvXckowVIk+
	G5lpWveHCUW+5ZD2N2Y0zBh1qwqMSZvcPaHbVN1pIzPYV5Huug3PHFnmmGj7FA0yY0rHz94ZpGt
	5k2Q6esoK/IOroJ+ygrW8H72rQ/JgkaALmS9EUNaSR2fBZZfq0zrZh+iX9Dp/PHgdDrqk4aMfOA
	JuAWC0Ld7krH7rxY8QGTspnyfJzYDVZhHj9pxMuJx5woYZtekxZ6qmt53RFDTdldjsOOmN7t17x
	cnsS1ktjg9Ay4M4z2vEoAmJFzZXNUEru8P0HpgghTnNo=
X-Received: by 2002:a05:620a:2681:b0:8c9:eac6:4168 with SMTP id af79cd13be357-8ca2f80e2f2mr795714185a.9.1770311659534;
        Thu, 05 Feb 2026 09:14:19 -0800 (PST)
X-Received: by 2002:a05:620a:2681:b0:8c9:eac6:4168 with SMTP id af79cd13be357-8ca2f80e2f2mr795709685a.9.1770311659078;
        Thu, 05 Feb 2026 09:14:19 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618057f87sm14802849f8f.21.2026.02.05.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:14:18 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        cnor+dt@kernel.org, srini@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexey.klimov@linaro.org, mohammad.rafi.shaik@oss.qualcomm.com,
        quic_wcheng@quicinc.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 03/10] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Thu,  5 Feb 2026 12:14:04 -0500
Message-ID: <20260205171411.34908-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205171411.34908-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260205171411.34908-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMCBTYWx0ZWRfX7b0Oxc8ByJU4
 Ids6/dGLnVfdL1y/HTXdfwMpz/Am2JFVvtb6geDFd62pyYWLvf4KWx9ySbAbLGjC4UeRMCy5HKl
 H/elOD75YJhCOZvkeVXx5aBeKMUxgg3ozmjpucJziJ+fIhLjR86ru/Hls6kuUBfv6OMjVn5pbjN
 kT+aRu0oL628bVv1GJrXFnRJTBv/YF7WYYx6h19BCHdXAs62uafnnhEygzS5QsjsH3A206CSiDc
 0MAsvv8JnfHVQ6PrVRsuaYx2WW9dmhBod96ea95FtVGEn/OF8hzbYth2QygJukbCihti81rfCU2
 GKSIwi1xg/1iTy+OiCpj4rhCHXwKWJz5/dQdnHBTeOiJVZv6pq8S4okQ1bvAnXw8W15S91axiWV
 RbNWp3BgGl8yXLuTSNus3f7s6ftYRbHBq85+fb3f6d9X5zEeSUFLvDZDaH/VYruvetHj+CcjMkY
 vIOu/2r15TgqEbiJz3w==
X-Proofpoint-ORIG-GUID: c6my03-DiMT4vss4btPzBeNa2bZki8UB
X-Authority-Analysis: v=2.4 cv=UoBu9uwB c=1 sm=1 tr=0 ts=6984cfec cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: c6my03-DiMT4vss4btPzBeNa2bZki8UB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,linaro.org,oss.qualcomm.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214521-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D93A9F5C9F
X-Rspamd-Action: no action

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
index aaeeadded7aa..87e4474d680a 100644
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
index 1d5edf285793..2cfebd622be2 100644
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


