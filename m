Return-Path: <stable+bounces-249238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IB5ITPbCmog8wQAu9opvQ
	(envelope-from <stable+bounces-249238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:26:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDAF569AB2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6E8302834E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4683E5577;
	Mon, 18 May 2026 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F7y/Hyto";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMF5LlhD"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1F3E5A2E
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096236; cv=none; b=OKNoarfqHg2bSpKhWcDePSbXVnLajXoZKy/UKBrsFjYkqDbu8+LfZ/6PX2do0SMWXVIUIN34G0/lWOqeZufj13b6uxDk85ldKFdkPWj6RtypKpFMNKmKp9heeWwNw7YDJgPySNN7tkOaSv9A04gdAMCiEW1AMAAMUtjOYITwMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096236; c=relaxed/simple;
	bh=OartzHtMjkwbtY495zYmORd7DntitjwDcZpmsbrjb5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGYPpZH9TaA0OXHOsS2x587gBEBkTyhWDmJt/mFQFg0SXKWtOMSueKYOraUhdnv2cn9jWyGlIAQJef759iLagX1sYTGfrj1SOQNQgezxJqdnpaD5Z4RriFMJVMr6gZ4He9YjdXZtFXwgFKnzaCepHvQjYkKJfQhzOwaTKNsoFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F7y/Hyto; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMF5LlhD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5Ype02685242
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DEneedWpQwB
	+o3i2G+K+xijFiG8S93MO38MV8xEuYUA=; b=F7y/HytoopXeqf5NpwhfH8SiEDQ
	uhfuFuR5R8nHi8N3My7WO9PtB3ZLG14U0/ev2OspTDneEm+CqjbmrcuJKmKcVAJZ
	6iXprYaEDim8a503zvvZ0n78Yj6Ns4zlpHEKJYbtRAVIUiwMx3eNMEPBAmoC1RGj
	f0A/ym+whJzDgdptUqgOwN5i8g9KZBrgr7jqWgBB3GEgco0KSRPzV40ANobwTvip
	wsYNdUhqyGfzpQas7NAT/t8VY0heQSSyeLyRjbtslQbgLg7xK+goqGYUI8AFyqkj
	teZzy2TEOX+4KwDHbZu1rB0xVnmhxLqupncmGlyG0RWwFK4o/QVgvFKavlg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbs04d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8b49424ad88so72167266d6.1
        for <Stable@vger.kernel.org>; Mon, 18 May 2026 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779096234; x=1779701034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEneedWpQwB+o3i2G+K+xijFiG8S93MO38MV8xEuYUA=;
        b=JMF5LlhDp/XPYRbbf6GVldA3ysC9wy9ZdiGUairy2o9F6tHdOketLEZZMrLZrZNtfM
         2OdcwdQ3AxeHx4poCD7M7XvOX9EZ4SlxT0skc/1F5XE2Cc3lVlkZ3EGsWkU0ZWPrkp3I
         RLBFxrjA6byHTioigtN7svruD/4/RErI/7nJj4soKCQFd/+tVHEmPyZntXKXK/b+HO4J
         5oBgjuPYw2AZZInNseN2kQhy2DYZPZZUy8xbTb+jirWIiKjKw/6KXUud5acVuGc2kAqT
         6saK2jZCfSRHAqImyrcTLTFcC3fRc0UKYc6dWJEoAD/uFwB4PKmqwXmxfRhkLwBmkZOq
         7LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096234; x=1779701034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEneedWpQwB+o3i2G+K+xijFiG8S93MO38MV8xEuYUA=;
        b=Ao3N3JzHlPsJa0bDEPbpGWzIcsBKyHMayWbDs6UCfUw7a8inOgxhKlz7ws634+wg1y
         Chmv4yLMHG3eZmP5UrdAoheJEA3sfLYyPSjBmZhONRJhFQS2mX/ChFmoZqq9dknSyNVu
         hQoYPq01gH5/dtPZZVhNHWBKo9ig/n3B4oL7jgIpawN7Me0rcM+WOxKBmZdiwUskCk76
         dLPPPSI/fMCij3Yr8jglMRskEg95Ak73XFQI/chPNMCv5q2vECQpQuA13LMywp/xuAAR
         1GN7GwFYLZ+Fy5Z1W/XZBV8f0YdGyMpVL0YY5lmuwgE6lQx+YQULHJe/7rhtpntdEmSh
         PctQ==
X-Forwarded-Encrypted: i=1; AFNElJ80sDBowMoWRrZqwtABTB/BxebWByXX3CCdFFZmoaRVn3XJ/T3HseWswWnQmN9e4zUL4CjQzjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpxl+3pMYk3wHfDX+gzmAgqwKM9ihhLvxsFdYENi6yxxRNuFt
	YAeGH8BUskD/oFQLd4s+odaUmOxCoHLHqxWs62cWzOMHudFWJrAuXiZ9rgcSIXUMJ1MVA36NM7D
	pLVKGfphOVSnsp3i2MnA0TcHzF/KLCNAE/86ol1C5atGSOMiZw52iicnuTX0=
X-Gm-Gg: Acq92OGaVr97GxpFT5UDncG+Dk7tc8o1dCV+o4kNRiBqDmBV/TpIC0S+Jilr/uZLh9t
	oNi5Yl1XMrFWodaI6r1pssat03O+I7FI+wwbOTZ0EGexA0+b/nIdnDGxA3wf//KEvzW9bF8rYLD
	kmFmCrJsqMATzIym6FPBnnIIw3R1bGYqauZst4vxFG0jz7DTox5+4QsXjHXF90xzvKfZWHv9LHW
	E7Gz03hEVshD1MOUGZBuXIjcpaqrUO1uz1c6Li28kb0QuvuAnO2S3/hKagX7Nmt3LwGesGe9yWH
	70IjoIInjSCph9WZbhpKGdf0PQDYvaghTJazICC5eY5MHmJ/wXou50Oy14uHGss+nE2U89cdowA
	O1/RB+83WhsBHZnHH7eIPQ9xiEjsmtrdSZ3Hl9UEeP3uIMkR2vZV/XPg=
X-Received: by 2002:a05:622a:1f96:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-5165a03f078mr203841161cf.16.1779096233783;
        Mon, 18 May 2026 02:23:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1f96:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-5165a03f078mr203840921cf.16.1779096233343;
        Mon, 18 May 2026 02:23:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm33265900f8f.26.2026.05.18.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:23:52 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: jens.glathe@oldschoolsolutions.biz, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        val@packett.cool, mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 1/5] ASoC: qcom: q6asm-dai: do not set stream state in event and trigger callbacks
Date: Mon, 18 May 2026 09:23:43 +0000
Message-ID: <20260518092347.3446946-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518092347.3446946-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260518092347.3446946-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Aqojf98u7xvlsd1Wl0X9uUO1Q1MZyrfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5MCBTYWx0ZWRfX3EjPLXod6w09
 0qdu9aOFXC2B4I2wLQ45dAv9U5VQZcS18QjexOlBt4mPdbGJEYAENAyO3wZGCaF7wayI7tKZ+ue
 wURsbSrY6I6uVmbtZyPNUe7OOGRo9Zuk7vvhheGAmPT/ZT8JDyzlCbqlM8YIzTi+7DzyvrEVQDv
 IzC1R8UX4RImiwJU1Sn+JhOBYMgYEfTflYWzfFiU0Of0B2+EIIrl4nyYuGeJo3wt/fjbC2xZ8NV
 U8os4+NHpbgCKJUnjiahIv5uXD1KviWblLBnZ3ZSVv0DlY3Rj5lPUEhNCbX7f0rPuX1boAdoT4C
 mEEQxt56bGM6VYBzTWBWE2If58B7Hw585FkPcjUFWTff0DxZHgpfazurLjAHXvvN/xEReeo/GvS
 7Eou9Xm0EO2wlhR3Nwhs31BsDMxho/KjrwDfOoddv4FyLG5+2NtdOawF94oh/HMAMy2HhvvxfvP
 GWNHdA7rjOP0MAInKgg==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0adaaa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TpFDhmux8Oo1qIo2-XoA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: Aqojf98u7xvlsd1Wl0X9uUO1Q1MZyrfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180090
X-Rspamd-Queue-Id: DFDAF569AB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[oldschoolsolutions.biz,vger.kernel.org,gmail.com,perex.cz,suse.com,packett.cool,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-249238-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The q6asm-dai stream state is used by prepare() to decide whether an
existing stream setup needs to be closed before opening/configuring a new
one. Updating the state from trigger or asynchronous DSP callbacks can make
that state stale or incorrect relative to the actual setup lifetime.

In particular, setting Q6ASM_STREAM_STOPPED on STOP or EOS completion can
make prepare() believe there is no active setup to close, which can result
in opening/configuring the same stream more than once.

Keep stream state updates tied to prepare(), where the stream is actually
closed and reopened, and stop changing it from trigger and EOS callbacks.

Fixes: bfbb12dfa144 ("ASoC: qcom: q6asm-dai: perform correct state check before closing")
Cc: <Stable@vger.kernel.org>
Closes: https://lore.kernel.org/all/afS7rTHdc9TyIeLx@rdacayan/
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 4f8f7db6c3d3..56f0d8913904 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -186,7 +186,6 @@ static void event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
 		break;
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		break;
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
 		snd_pcm_period_elapsed(substream);
@@ -341,7 +340,6 @@ static int q6asm_dai_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
@@ -555,8 +553,6 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 			snd_compr_drain_notify(prtd->cstream);
 			prtd->notify_on_drain = false;
 
-		} else {
-			prtd->state = Q6ASM_STREAM_STOPPED;
 		}
 		break;
 
@@ -1014,7 +1010,6 @@ static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
-- 
2.47.3


