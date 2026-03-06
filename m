Return-Path: <stable+bounces-223331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCzmAmLHqmkyXAEAu9opvQ
	(envelope-from <stable+bounces-223331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:24:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB336220842
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA6D3078FB5
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5F392C4E;
	Fri,  6 Mar 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYETanTp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHrddHAo"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771438E5F6
	for <Stable@vger.kernel.org>; Fri,  6 Mar 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799735; cv=none; b=Sc+TGeMTKIhjpvf1aDV5X6EfRP5pWXpOz7ZTgRoSA+wh9jS7FfnsOzBAB/ULcDcHM2Y4hcc8G8nc/39LIGMVHkg9rCsHMq+Jhqsraei3PU/o0zzMF7iu+7r69GfHFSblipUtQFgq9IWfT1g9SvGXHxaHjYGWxGYONlTfPT/QGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799735; c=relaxed/simple;
	bh=AhoflfyPSEypIadA7rENraHqNcIi0OFcEnzEL9v8we8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBcpeGJ2hYhodg46pcgiRTdnB3mKHKvAhXEfMjneA9w8uanVaH1TzaXG6h/3bjoNo7283Sd3ZKxbsFK+K3uwqxhY3du95esUhLfE946QE5Pg7asgwU8INc0RZ94eoKrHllt7j6fFUBEjbR9RTbf6rPSe29h5O96MOkYJvP550cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VYETanTp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OHrddHAo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626BbEv31189321
	for <Stable@vger.kernel.org>; Fri, 6 Mar 2026 12:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=PS19lL6QwLa
	ikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=; b=VYETanTpP9TKbfw8VB9Q1wzGu2f
	81uLF3VdflICc8WVRkd1rvVwhCU0iaAZSYRe+unDyhiY3uBXgaTw5T5a6xGtJu5o
	v0Cosrptta2XIYPalxG6L631WHKhnC+6i5f3jf4M/HFrTK6eQyI3ORYhStO101MW
	q1rdH4DQTZumHS1d80YmIz9musaIzLNRee6uOzHdX1ntq6fwzriEOD+IKTNZsMEZ
	oqzgAHxwSA/efwk8DSGikwhsP85ee3oEznxbDFq+IJCdGc4X4ZcY4PuWgz3vKIyw
	lFoAhp4rZSZRfBmQiQln8Iy/59MOPQ2hTgohXfXGBXtBDfuYKLiLSHJAksA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqx14g5ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 06 Mar 2026 12:22:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb37db8b79so6626933285a.3
        for <Stable@vger.kernel.org>; Fri, 06 Mar 2026 04:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772799726; x=1773404526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS19lL6QwLaikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=;
        b=OHrddHAo83B86rMGxrGrGa2eUuvzQmYMnxpA361W5V7qoTwTz2v/nJIov1Xc3vnnJ4
         hAQvodmRq610hxRuQR7b1SiuW3qNLBtvMt2xypB0DIoTYFhqWt70wYma9hE0Xt8/HKKH
         2vFu72LndCOXlUPTO6XeDMfEsPpR4MPbiy/e1t7oX8tFwn3vm59yZqDm9sl4ZdV7bkSj
         lw8hVar/XoDITX9upja7IWfWFiBAKyQsOW/87JycuLn/Ku5SvIh2mXq6P50CGRPUbkQB
         90DJ+tH+Reyo8IARq93H8yoSAmG/rTmoHnHZiKb9THd/7nssiaVuRuEg04sZa4T1xwYn
         s5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799726; x=1773404526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PS19lL6QwLaikI1GyQO9iydtpc90HsQ6A4ACO7BE4wA=;
        b=bvbwJR3OSugYWm/ifaJD9NhHUlidgMGNxJZG2iG86Hb0JjZGmc7bKE0aIE/vpQWEF0
         1E5j288SgGJxKRhu5wOJ3vKSMSwpGc0CJ9nv+ghIjXsML/BopoLSqNw88Rb/B4ar7ji3
         3TKq3nhU0obt4rt+BnXkv05GxrQfBLj+NTYctmMTNkHYIFTKVhoqlWvWVcVP5d2iWTyS
         jFxMPlVvtEpyxqUagD/2dpx5XMCFdwekEF7d24+Xoj49HTteAnkeNNcbmL7m7Hvt3z0X
         zsgYlTNDF6yl7L3Vs6RU7+U7W+2on0lGqXfwF60uE0T456a9GAYdOEtrx65jT7Bq9XGM
         eGDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+z9qCgz3h3kJ69LmORiYeGu4uQYSGsz+W950QRnLpoZ8opr4glizTYUEk+DbqQM0bTXDoHP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfJ8DhxsTrkJuaDHQOhL1UhK6tVpLeYOjcQvw6dSsWZRifxPV
	PhFfYRi2+qLlx2eJc3WoaI1Q8avlrk8N1q3pJ0CMhZfFtbawrN67Ey/YfVhlOvxnEW3S1eH46pZ
	X828u3scxsin9Obi0mtfF5CJo6syAnhZBO0/HNFbpnY7yEs8a5kzIPkSEs4M=
X-Gm-Gg: ATEYQzzbzf12GezVartCxJRzUB6cG25osKYNeemnfPkQYKHZoyNdR/JdM3/p4/nzSrt
	F0wSBmT63rdxSHK69DWUA0kZmzGSquzXNJAcmmyMCh1BDo7gW1bhbGzdQaXjgTxBJqaSNBWc0cQ
	RJ+wlemuuk0LjA/ztg8odg8SP8TK2tR+toceD0Ile/or7n+Ns3TBODNKOkk0ySTglDGLUUaQRDY
	dz3B+gZR6rrELRzkEj/SgpOtHFItaergqG4FnOagyhUOLeJ90XHLrR5QT2HrQ7Xo5NT8DqcKbCQ
	jywRkR0F1MFSwgSzJvp2849RMMKt2hF3sWp7ABtCpWDO6w2ZDzpR8kbwb8PDAg8v77xXugbOvDl
	dJaUg1gCo31l5WGDBMAd4c5CkB5R60znTVQWhebB9k1+Y/oFKSSIp9jk=
X-Received: by 2002:a05:620a:d8a:b0:8c6:b247:4c with SMTP id af79cd13be357-8cd6d3ecdeemr229073185a.2.1772799726345;
        Fri, 06 Mar 2026 04:22:06 -0800 (PST)
X-Received: by 2002:a05:620a:d8a:b0:8c6:b247:4c with SMTP id af79cd13be357-8cd6d3ecdeemr229069585a.2.1772799725934;
        Fri, 06 Mar 2026 04:22:05 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fa87e56sm111972395e9.0.2026.03.06.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:22:05 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v4 05/13] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Fri,  6 Mar 2026 12:21:07 +0000
Message-ID: <20260306122115.509705-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306122115.509705-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260306122115.509705-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNyBTYWx0ZWRfX8VmHqGBhpcgW
 w9n8xtJpVBeFu+ixaIvUErBPL9T48sjR2FPoKpGxaQ59nt1o/2foVcNuMnZLofpmv0VaS3iwgYt
 RC9PSW9B0FPQ7U/mno4Gw6NNXIRdNn6RDHn6BYl5yK5Ro+siGqvK4FykLfzXGRAyCH45hEqh6Gn
 CADdB2b/fMlvZKwuBmEw5bspjMoerTxlkSxALdBFWsdGiNnZmiLQX1rNR8/isdSCRYfWMG7AIn5
 LO+LkysN/L9L6VjKen23X1OCMm0mhGZ6izFPSrx3Y5I2yk/HYaNpvabX/AEQLj0tlM+3eA5YMMX
 G1vwRxOTgFHn2TVdA4g99GRCVzch6V6ZOWaYJvNc+gAZQeR8iFsRTZH8mrJmZI0UOAs5uzuD1Xj
 XYL/OM2Og2spz9bRVyGeOJYy0RQ6QikyH/rjpgDvyOmgpz1E5aRH/cxJhMgLS/aIt3baYppsyBU
 D0DxVTphf0kNJKCr5BA==
X-Proofpoint-GUID: uHZE2g2FtrgAmv1QevYEoytwTcrpJHxQ
X-Proofpoint-ORIG-GUID: uHZE2g2FtrgAmv1QevYEoytwTcrpJHxQ
X-Authority-Analysis: v=2.4 cv=e/MLiKp/ c=1 sm=1 tr=0 ts=69aac6ef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060117
X-Rspamd-Queue-Id: BB336220842
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223331-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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


