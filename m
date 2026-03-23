Return-Path: <stable+bounces-230025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM/aE9XBwWkHWQQAu9opvQ
	(envelope-from <stable+bounces-230025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:42:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B32FE64B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B689D30BE1FA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C338422D;
	Mon, 23 Mar 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QHbJWsIx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSxYg5FJ"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC376383C6D
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305545; cv=none; b=Xm6jWnUQ0alAMZqEd8VRexxNb6lKUT3pzgHQaPiwIdiQROoad/YN8lHzTPLmODSM1BwMldK8fuhlotR3v6umev1S4Bks5UsxCMKhkdBZgJIUlmVPrZVARk5c6Dd1/AmLkv4vn9XYuzeoeclK78hbBdzNU1yewKGcsdxm/KNbJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305545; c=relaxed/simple;
	bh=Nn5W6j2KgfG3MXrQpHQ1hcxXhxv/yUbhKAiv5Knj23A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVG4R3vs+nzAPa+cU34GZIt53+1LsV+t4aP4NnXDHFieXn/lcf3yaz/LofWYd/CEkt09S6DbnySJhizTCeidwwl30VfV53V2vZVvmO8XdAiHylLGmDf3WeFvnIoGJiTgCu/Z29JokqUrLvwphMyDkkBL5GT2vrmc8vsUFn9jm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QHbJWsIx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gSxYg5FJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NIYfFx1908754
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=it+OAEpYU8v
	0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=; b=QHbJWsIx/8lLLj6n3P/BeISv0aQ
	kBaTFMKLD+cxAyz55BUhVzExBgrs1cgJiYNojyZnCC30x68+kVZQnUGvcA91hvNH
	CdOu4Dt3MncJkU2NlH//PlKCKSxfgoIGhVeF7hC9N3trUtDWcyqm7CV7ai3T3Zql
	DGHOlqB1c+T9ZTxmhm//WsOlc/hFc+sRghEtJUs3endX3fg7XeHUMitHUHx/E3JU
	QWj06u13jBrbiLLbGd2qxJ8mkOT2Ux2Hq2nT4nKhInbYhBROWXaQl4BtZ0RjJb4s
	XtYkpGWEYq3fpELYZ6gJiXG+Vc4/PMO9WvCblHBrSIyDYDd7xAcMS1jnlBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3awyrns6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 22:39:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5090e08dcfcso38579361cf.0
        for <Stable@vger.kernel.org>; Mon, 23 Mar 2026 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774305542; x=1774910342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it+OAEpYU8v0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=;
        b=gSxYg5FJvmJUWNNPuyFqPVTw8NXuJDjIWJNPOETNL/QXuLed5zx8ISFcFOlOPo5XtE
         NahxU2a8HRjN/6k3WByFBJMHsBhB/R1rMbNrau+bpJ4Rf72Jl3uZV8++u+bp4n5HrOkN
         TsM8inZeN5VTpyBShdFkyWoVMgSbhJx2WVuQ0lJlbSfbpT6sgeQZKuudIs8eL9qm0oLA
         QNbFfC7wJToeRViSvhOCW2xWOOK8ZSxfUeGw5WBxQxdGSVDASNfAlfSHQ48AALCHLtif
         oZUAbCfYOzQ6FznZlMiFLKAfJEDtqVckrJoxSRxID1yTOeopgvye5w8oqX1z6cuSWIM1
         tLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774305542; x=1774910342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it+OAEpYU8v0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=;
        b=KmBsNV1egn67EPRtKGC9Ge4s73mehO/UEta61tYRH+8dTjVz+iYrHt1xP7y0L1ZSDA
         jOQv6zkuC58pkbO6U9Hjonn01/bLaG0Bk/waQa6T2OMMr+lwoi08f0SZVlpnG/s7pYrD
         3dFW9mH6YuCEwao1hmTpdzjEoJi9EeL32pNHbyQcxrZrCt8y1eRfObtLPg0Mtia4oIjm
         aUQpgks5IRDPeUs4qZLYhW9KMEZmoI1J9FZW9CDpHAppbVp0odW3jzh8Ihwi4rdQXMte
         TdqgYT2xJl4okKE1C3GYr8KyhPS45eCBPf7UXgc5HLH/7DkI3tLVDBu4HglTZlZmmeZL
         ZYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6YYUGsmmMHbB+y+B3r3l1dGxVq61Thn1gszT6SfEY9NFWoVxFoJq6RxK6RjrtBV3dS9z1kaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwvgD2keUZc+h2nTf76gxpfNZMPWXrM3T9v0kK3b6r8/4TFFL
	grTsy+zrQpbMUQ0bH9LPqnSQwNSFODt/nocDSjjMVVZ8gp7xF+ceMWMvl4AonRrZRdSDTZEZ6GD
	A5k43znPIsGOV5x1+riYw1/G31HXU82ng7w2qmYKRe8UdXu+HEkDAbaOJQ5A=
X-Gm-Gg: ATEYQzycFVgMz8osvSnBp4S8qzZdqupMzktZzCGXUHTUvmcRM1gAAhSRyJGrMjUBovm
	quZ2H9rr0ZTtI3A/R/lHkAeS2ogCFX5jcRe8N0CojQ0RAEFjfhwEGo6uqH/pnKWkV9Jvbf3sixv
	c2/RufYOpEFbOG3kXJUnHaFlrZEGgtFamk2uHWIQD9jsJ0sKJxo3kT1lcdk9YkEcwAfa8fYfike
	LnossWn000PEiOWYWfJ5vIuYMcEwQ6EoT8AgMqz55l9SPIUOXiEnEFYCC+UDWtND2xeYtgDMe4Z
	QtkjAqiNid2mg3mtV9QBf2oTn/EKfRHSUHUfVuVIjI+FIyqB7O0oMbZNOyqEi3w9vic7PKHpsOM
	XAZhK3KuInmQ2WdLVEUiZao7WsMoev5RKrqZQZWdk8KESD+jWM9A5kcQ=
X-Received: by 2002:a05:622a:5d0b:b0:50b:2eee:4b38 with SMTP id d75a77b69052e-50b373a041dmr159958921cf.8.1774305542223;
        Mon, 23 Mar 2026 15:39:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5d0b:b0:50b:2eee:4b38 with SMTP id d75a77b69052e-50b373a041dmr159958711cf.8.1774305541822;
        Mon, 23 Mar 2026 15:39:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64715539sm33320351f8f.33.2026.03.23.15.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:39:01 -0700 (PDT)
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
Subject: [PATCH v7 04/13] ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
Date: Mon, 23 Mar 2026 22:38:36 +0000
Message-ID: <20260323223845.2126142-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2NyBTYWx0ZWRfXxbscOYxGLMP/
 wfOWZSmS0/gf0zNlEo7nPb1KpezqEBJH3bWxWSoNxcX1cv809Y3lzFFyuqqF5RmbfPEyOrrsqMf
 Zbb44Q1ecZE48jRU5O6k4jyVlNfFqLCNlgY6KZJoukLHB8wxQmi5JnHjOfYnNW5k6RcEncGcQhh
 /gVhv1r7mPunpmwNcUXlJg0Glc+LU1N7xGsVIg0fhlwRhOLz4Xum6kgMUgy7Vg063fy4HcJMCrq
 h2qNQEXmDaeUngra6hOiP+53ufyfL/Cp2kKYl5JoskNu4AKZ4zKtePIfWxHCtJTTczF6Z5RamOO
 ssmL88zFcp92BSpMvff5s2nyHda6/XJ8grxyaShGgzSgkiDJOwlA23dyLBgzirKf6qP3XyrqaTp
 x1r1o/T4IsNmJH2etMxtc42lnWOSisgzYN/VAlBi0XPt2v2bB878JWuCTnppARDi0htV+j3BOxb
 Pj+t44niAbtPvrEHRcA==
X-Proofpoint-ORIG-GUID: 3Ahj6c1PwB4y_idznQ4lJfDA_vQGcskx
X-Authority-Analysis: v=2.4 cv=KuhAGGWN c=1 sm=1 tr=0 ts=69c1c107 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M_mAHeyD2EURj3i0m2kA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 3Ahj6c1PwB4y_idznQ4lJfDA_vQGcskx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230167
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230025-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C00B32FE64B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As prepare can be called mulitple times, this can result in multiple
graph opens for playback path.

This will result in a memory leaks, fix this by adding a check before
opening.

Fixes: be1fae62cf25 ("ASoC: q6apm-lpass-dai: close graph on prepare errors")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 5be37eeea329..ba64117b8cfe 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -181,7 +181,7 @@ static int q6apm_lpass_dai_prepare(struct snd_pcm_substream *substream, struct s
 	 * It is recommend to load DSP with source graph first and then sink
 	 * graph, so sequence for playback and capture will be different
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && dai_data->graph[dai->id] == NULL) {
 		graph = q6apm_graph_open(dai->dev, NULL, dai->dev, graph_id);
 		if (IS_ERR(graph)) {
 			dev_err(dai->dev, "Failed to open graph (%d)\n", graph_id);
-- 
2.47.3


