Return-Path: <stable+bounces-223048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LxYHs4uqGlPpQAAu9opvQ
	(envelope-from <stable+bounces-223048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:08:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EB200112
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98F64305DDDB
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387D32E126;
	Wed,  4 Mar 2026 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6NMvo5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TnoVotb7"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982A28C869
	for <Stable@vger.kernel.org>; Wed,  4 Mar 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629646; cv=none; b=NKlB3VEUxdBgbRLbxRUDK20vI9zJCRqFI0k6FjKuhZcu0ixOvQEdlvpWoR1wS8KJ7VEfqWpSDIcw+h4O+3oiFa9xvAbddJNgMJAHcLMTDCdJP4NqOQG53fpTCZZNzhqvx8qPHg6SHJXNaMGkDmJOsXsKnVxvznRF8Jr2pHtljVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629646; c=relaxed/simple;
	bh=AhoflfyPSEypIadA7rENraHqNcIi0OFcEnzEL9v8we8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn0TePWJwR9ZjpkMejLE/hf8Q9nRK8AJdmWjpByCs66omv+9ul8bIOZ2O4Kaf6tKnx0wer5IGMHVxU3O31nVfHHI/xF1kCgGNqgiEMyeUC7tfIQuiXR0pmfp3WbJzNTM4U4a2U8+j1fviScQnwrPPsB8neem066vQkGGs9lKsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6NMvo5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TnoVotb7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624CbrJw152521
	for <Stable@vger.kernel.org>; Wed, 4 Mar 2026 13:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PS19lL6QwLa
	ikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=; b=X6NMvo5DiaqLkarnGukacZIf3Pp
	KUpkBmh2/n4zstZh0MVQ5M/OLoFjyrL+xIf8hYkJ0frgdcnp+xgWICBgibFS3XjE
	FxpjOOJnO0okahQH9Aa8rseTNErMB7ayHHKf9kMG/3c2TfrIoa2+/wDdYhTJdHfK
	ZYq5j7wcHVPiM8QosHQ9sCzfNIaFyGREKyO9mYL2q8cFGkUe5dW2xT3NnJZLosyQ
	I3jBrjXV7058/OUhuCgbXF/nkeLIy2gsBYib/fQpp8NC+3UJK8r7jqn3GJ28qzCj
	3AxKQSAdy/KBVO85Th4dCob36Y3mIu9Uzdui3B1wYe33BE03ymONTh4hrHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvkpsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 04 Mar 2026 13:07:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c71304beb4so788582285a.3
        for <Stable@vger.kernel.org>; Wed, 04 Mar 2026 05:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772629643; x=1773234443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS19lL6QwLaikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=;
        b=TnoVotb7k2U4qIj4GNsKstRDRVMCKlPKVz7lyqtGaaPx373P3kxmgu8Rc4kh+g/DAT
         pCuUYcBSejGNKJxRcirxaQGG2kpvvxlQqe/N6qIXtDlX+ZXuWHK6yGfpa4horXMzOj9W
         VXHU488x78UZd8W4WSf47CWndUaZj8CTbKYiyHe5XXoT+odr2/MG4WYK0boE/lTwxPT1
         e0YXBRyFx6mftmiiyIV7WjuIU/Yldnd80pzgq+C9HpC+bviSREb5TceA+oIeUOOvR5fB
         fL0Lk8OSpjKjKuk1Qqr3TGWSCd49Y/iwSclh8qrsW4jIX1qSuKNo5fjefKmzHppsI1xd
         OPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772629643; x=1773234443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PS19lL6QwLaikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=;
        b=eyKw48dheb50blaHIg/mL8lT90a5L7URPkSJa550iK1CElz5gCtJYRJjXWzRfaTlKB
         nJNUlpncijzTeJueT7Q+cPhHaNMV67A/GzvXhwFXhH5mMOIzKcXw1WW3dDc+cWltyiCv
         KfGNj3bihVaJ/sZYMnexQTC0srXQVb3kvJQJASHS56wRHMGvodkWaRQ6TQc21UqzDEAq
         dNn/MfpRwyIzQk6pslTD2qv2EfOg4Vrxlu2iBU0sT8v61vCvq0W95lLL+VF4KmIUgxR0
         eKn5y6e2VjyWmQF0SSt3c8eVy7eLR9OXIyYSQ85YWHxJ2ZljCnfNR/Fc9NN+WI9Gv/Wp
         GSMw==
X-Forwarded-Encrypted: i=1; AJvYcCWCk+O+Af45FPmmjYktM6rNwX9APfXHxZRdS7xuHYhmCCG8iA6gg5p4prv0vuQwVtZX7bPDgJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabhW4FPGu3NpYzJRe+FarMsf3uTLfN4XSd/YCaBKPQiV+E+jR
	gXHq/6ty3+IIfbz6HSITx3YG8pcYNq9mx7J1068zSUz91kL4ixsztb8DDVG8NmrNpZCJ27StT9L
	j5+uXZcDTr6UAgnjHx7BtFmQaQQXMyHuUNrlBLnV2RmEKLEevKxMCQANhzUI=
X-Gm-Gg: ATEYQzzStDMUy9JLpPrHXS2ucWUypY7d+m0/MtYSszEfThEYjPhZ5NDcLrS/Bj+CDyZ
	8fuv1LwN5F6QEyzNsIRad4mNvl/mqtg9JmrGLxtqBzz26AEy8phR2XisJ39xoQ9vmPFtp7uVtT9
	Me7mERQTyzpZ8Sdqyt0rW+wthnhdWCrak5nE17F9jJvdSKk3AxqBU7UsD1Z7Is38hKRLXhBCYVR
	C8K4GorU7vA26q286mtvRUiqRacNJuZrbBEfvxc08ikJvEynG0p8O+QVSVFgGnIAS6hXn94VhNI
	EoBeJwSJMb6H2XP/FQoUwLVtaoEPXwXlUBNw3as3uE24kzg8pbHpqpIeO4csM3TJTYfQDnyfxwM
	5iYYzBptBgGBQAjcE+0jDLvjWF5SgN9wyageLs4LBL4//mImR6Xev6Ts=
X-Received: by 2002:a05:620a:d88:b0:8c7:d2b:b5c9 with SMTP id af79cd13be357-8cd5aec945cmr205978485a.9.1772629643527;
        Wed, 04 Mar 2026 05:07:23 -0800 (PST)
X-Received: by 2002:a05:620a:d88:b0:8c7:d2b:b5c9 with SMTP id af79cd13be357-8cd5aec945cmr205970985a.9.1772629642975;
        Wed, 04 Mar 2026 05:07:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188122a6sm49969745e9.12.2026.03.04.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:07:22 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v3 05/14] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Wed,  4 Mar 2026 13:07:03 +0000
Message-ID: <20260304130712.222246-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304130712.222246-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260304130712.222246-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEwNSBTYWx0ZWRfX+Ueunj44EkL4
 Ce9AUiCxVSkXzid1UEIPWoUGKaLVpr5QvZ0+b0l5NCSVAW0JbYst9CQv5FAarLXz8wt7Z3zH5BJ
 uRgqXjM6ZNezs46Enx1TBUZ/5P8QE4gEhQlNpbegMfEEQlWLm6UgWJn/UIz9o3zQ39ZQVEv/6Nj
 E0SP69IeinGTQfw+rGcpi/O+W3YuS4VEMxIEGKbYKxnPVrEjiSy3cwh8NLXCOWjDYW8r5Sd5ZpP
 flgDQB8QIYlW11wOdYwtAvOjpUaHrJl5mbrnRIP4fBgexwf8/UEPIH3SvbRw0IPKPa9FXh69HIm
 A/J/QB6NJJwF9Avcwlf+/dg1B+s5fugP8PQadEYwfr78D8XuAdzzJ7hjldM9fZVMTwXN0DoGP63
 Uo0nXNHT+juzQq8P+jXnwnjpDA8yoCjUn2zb/SumqjxP74mhZ13BY5ln/PMtqc2jBF2oWPhNsJv
 xdAdaC70wvDfGlIYpRQ==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a82e8c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: BP0TK-gudJLJAUlCx8rr-VHRo9eGCuIt
X-Proofpoint-ORIG-GUID: BP0TK-gudJLJAUlCx8rr-VHRo9eGCuIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040105
X-Rspamd-Queue-Id: 334EB200112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223048-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
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
index de3bdac3e791..3eff45b241c9 100644
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
index ebd5e3ac0366..f190ad5e912a 100644
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


