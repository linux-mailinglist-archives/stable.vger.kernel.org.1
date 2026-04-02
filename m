Return-Path: <stable+bounces-232933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIzgDhklzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:13:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB165385B1E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09F13042608
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79A3B27CE;
	Thu,  2 Apr 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QVOh9pWE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3kuIe8b"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198823A2548
	for <Stable@vger.kernel.org>; Thu,  2 Apr 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117510; cv=none; b=TW/NE/lK6/5XXbWNWRKN6CxtXY2SDYgNn3FoqjhuWyzHGLDx4Zwn7MtbvATkUq0RvI2Q8UBZ9o05MpWmCITGNDowzvdFDsEwLhE6uGSMPY7LcW0m6H41S8ponRJ8ovYDWcMTHzbYYDA2GhfHYNfFQfIzTbcvUMe0qG44Z1+BGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117510; c=relaxed/simple;
	bh=aiDV+ay9pDagfXi99dECc3+gFHUApEvFgcp/SMLLkOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+7s5ujk7Tt3nvLfYcgxlGpOy8V/NwVFXpKHzhsVyS4Z3QG3tPUR/GXbspdwR4e03FyIJOAxF0uvVvHneu1wY3QM0gaiNKYM4r8hlzvCMvKWWOyeJYDV8tagxRuVvOxh3w+HFpTdmNIFhtNE7rZ9iU1+3wYrQ3u1zw6fgYnDh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QVOh9pWE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3kuIe8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326vZ7p2903305
	for <Stable@vger.kernel.org>; Thu, 2 Apr 2026 08:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yFv97piS34p
	vw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=; b=QVOh9pWEICPGgTVQyCUf2lFQUB3
	/3lHUE8RrAhf1r49B3XSffGuoEHAWWsQ1tp7fV31ETW4u8Clx3bL3vnhauJY0P3B
	YtWDeAS3hwXMj3EmEfFVIdye/XfKu1KB4GWS6jEmz4bHfyUfy5hIhz4JW6j/2O7O
	p1pFOy3NT4JtoYhBFwFYjfHfrqtdkucq95sX1a5IaPuoYdtGh/WwtutHvD2bP+l+
	wLoE/aiWO7Q9KycepcdLkYu9w3ZZRuDzb/KsmpHXFikQ5hWIQ5JOV+CHlzvTLV29
	2EwTfnpAN2j0umYyEKwGPkgr8U4jqSsK9XP5vjfPKHWMxhKqNRvXYSQbr8g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d954cbp0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 08:11:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b802961ecso6108431cf.1
        for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 01:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775117496; x=1775722296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFv97piS34pvw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=;
        b=R3kuIe8bKjjXm0vU2ggqOTTFVcPQ5cQefR1J+4rD9jfYqwyoJ9hi+X4RJC3iJuixgm
         WpW8WKrhmUuSe1m06UhwGf8Q3cydwEZo89sVzHjdF8gCcMq42k+OO+YGzpJEp9wJqYV9
         3t/0WSdXnDX0Ljfd1DQD6uLZyZiPwu9Pw8bY34TCoeTGwteH07Z21DgM2nXO2AWQFp4w
         DxIV/1vNH9ZuBq5pDtVJC5L5KZAJintNdxLh95NpPweiu9oa9E/W2CR+XtK43PIBpDdh
         uvnGqsfxBY5moTaGg56+pVoCdpTtkkyzJf9t3HC3kZUVM3Rba7CLnkeLZUtpyuILJ7WI
         adhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117496; x=1775722296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFv97piS34pvw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=;
        b=hKVPZ5TZ7b7l17ZP6D9Q4xBwAVUYDXtgg8JOUYc8GKam7+nhnuRnfnGGXL4SDTrgBf
         WcjyoMHqX+eA8KE6ZoIArLtwQIdBCNzUxKhVnC/NdP9nr323rYkPZWCEPeLqAIuZqbaY
         pl+7YAkU7APDl0FCBPPQ0syHcmrMQwEZY9A56ObqlkRAyWWBZRblJBXFqMXgpFVn8frc
         NbRRZRWggcTAatl5oSDGcYQ1ycN7U7FtkB6sDU4NlX/JV1hO2lxnFvW5tufF8eNJWbHG
         zHb+VQkq3esQEuaoxTAwBRwjvUZ3QQ1Oo85ePgMW+WdTweJdItakDOQ1iKwy/RQEr3VL
         7bZw==
X-Forwarded-Encrypted: i=1; AJvYcCVWP9j6uhcxnPAB+CaNDOjV1/LyPaUHqzCrob38VgeWcUavdP4mgszajHcOrh9Zt1ZuxOv6shc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaaoYtzPyCUK1bk2plLQ+72tCHiPfqF2UEa0GiaRsVzyAMkLV
	Z05VvT7TM9SWXwSnThmpl30sIKYy21uugnglXyALOxSYjrCxVWdbgO6CVkkY2prT1BmnRRc6QnQ
	PCPYv2t77EYX9gg11quKuiuWD8zmKSW92pmBGFTClWtNJiB++JDFOkXRJvnw=
X-Gm-Gg: ATEYQzyfGXIeDM7Rhk0stWoG/BVeC5Ca/4jM2RQE5aDf9p0rjNgxfC6DuaYG8qNAAPO
	WWUcO9R4NEZD0wOLnN5osKb+BemuR0qBV9GVmBiK8vjqyZss29JGlgA0msSB5UgZe5Az70hrJE9
	ICyH3VkvK7fewFGMMzHoAuabT5crDTZ8AXkp3QWqWpVH4eZucgFBKiVd1k2ihqHCUtXi76UP/xp
	11YjMpCg1K3W5Ji9ztOLm3gmcQwg7yR8ERK1YjTQs7JjBEFxAMXiouDwAFUwpU1nSA466ARP7XX
	Vbr7/nt7jtWLFxT4LCOjZg2lcxUGddRtu6A/8ybup4WHNqJ7GFq5YCe850IMYFNAO1CV3wRI8td
	86yAkxJ8BoSK/YEKhyLFbMGvbXQfZoftiKEMlGY71bTqMKOvbBXnhmEY=
X-Received: by 2002:ac8:59d6:0:b0:50b:4d74:6614 with SMTP id d75a77b69052e-50d3bd9e18emr90671231cf.63.1775117495871;
        Thu, 02 Apr 2026 01:11:35 -0700 (PDT)
X-Received: by 2002:ac8:59d6:0:b0:50b:4d74:6614 with SMTP id d75a77b69052e-50d3bd9e18emr90670831cf.63.1775117495403;
        Thu, 02 Apr 2026 01:11:35 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c3a01sm5712604f8f.12.2026.04.02.01.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:11:34 -0700 (PDT)
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
Subject: [PATCH v9 05/13] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Thu,  2 Apr 2026 08:11:10 +0000
Message-ID: <20260402081118.348071-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402081118.348071-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260402081118.348071-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMlyn3sR c=1 sm=1 tr=0 ts=69ce24b8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: bmo3tLVvOWNbjoYGoouEUqsCTDIp8jqb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MiBTYWx0ZWRfXy2/6rO6IT6eE
 9OvCXgaNHNBir9dyB4Xh9tQuROjmpF38hnyofG+bd23iE+sDN9mWKNIO3oUSLTk5TAnzlTWeeqw
 dCwPJaisxkBIWz/O9us8osuXYTZEXSOIEPPpDPouK0ZAE8V/M0FHw1VQmvuYVswZEl7J/VN/N9I
 MrYcewzxcQz4u9TfItnDZ2X+IsBvAjG54z6/AndZHyH7cjpurBiE36TKR79+xZeDybLrddJJSZt
 NtVk8qAFxRzGa8oOIAJEqHO2PT0mc/W+zRTZFJXtC9oVRQ1KOmHAh5XNafGP9M4j0Jb3MDEMf9b
 aZrliNx5js3pCWdT3sPQW42W4m3V0v82+ob/X4er/lzG7Vtked19n0WtwFNn+vJtpQV3XxS7EZg
 QURw3lqruG/mYwGchSY/OoG51uxir/p8lD9j2KpUUi/uCVzd7SyMxVmzuKnKXK+jjIAYtZ1DwTD
 9LV8nJ1kT0gTE3+iwCA==
X-Proofpoint-ORIG-GUID: bmo3tLVvOWNbjoYGoouEUqsCTDIp8jqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020072
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
	TAGGED_FROM(0.00)[bounces-232933-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB165385B1E
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
index 2dc525c8be42..5751e80b3b92 100644
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


