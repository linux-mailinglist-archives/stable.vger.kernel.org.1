Return-Path: <stable+bounces-231046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG6YDx81ymnn6QUAu9opvQ
	(envelope-from <stable+bounces-231046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:32:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D17EB35732E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A263060BD3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902773AE71C;
	Mon, 30 Mar 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hm6gpN3u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKQJJmQE"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437B3AE1B4
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858906; cv=none; b=ADWSTVuZV4VwI1LBW3GOBv/Uy1omXYsFPTkLVgJjKABPeQOAeGYQMS68mhp14mN55LwvvBYO+1KjswSmZvouJr8KM8YTPuRgmn5TxY6aQ4Twv0ysQVLSimAERF9Xikb+9rxUcJaiahET8TuDQvlzZSuU1SezeobFVl24Trr1WlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858906; c=relaxed/simple;
	bh=aiDV+ay9pDagfXi99dECc3+gFHUApEvFgcp/SMLLkOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRVCPe5W0lHoIopE3KdTyHMWQykluQpc0erdEZFxuZXBd5tORnx1CWIcFH5DB431mWLG2+u+rENWOpvqgyv281Z7CNa0ix10YHur2LGknKGi6fMAzhk+R40YW+xnrkj7uQjcLL1BCCAhUlSWBThvxXSG3BHZNTqgv6Xxhv6U3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hm6gpN3u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKQJJmQE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U4LHWM865969
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yFv97piS34p
	vw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=; b=Hm6gpN3uVmzLfqZbkE992WozLU6
	KTlx3d0Ta/UswVXL2uMYfrFOxDSjGPefz9hhlPz4WmUpSxZqCr5v4Sh3ikhA47R5
	cEppGu7D75F/sE6jQ81Y/l18NdFsR2wsSVuh8iQVrkLLvQEUYSiAjjaEjV/59d1t
	nqrMhUpBQr/6Gk17tfIjYHLk+M+bGpBAM37Vq7hjc9rMaNya4pMiTZmEALRMbcVi
	/hLeBmhvlX9F/pPFQwHLjv4kXb7kZZ8ZJXyhM/kRd2NdRHzOB0w1i+9T8Z8Cszl4
	kPWK+XBAEStBTam8vDUtdkoV9ShoAOUv1/kiZNTccacI6K3sJty9HkKL7sg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685hd3rh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4fe4ff7bso175510211cf.0
        for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774858903; x=1775463703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFv97piS34pvw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=;
        b=ZKQJJmQEm3GAgJJHVW4ZkDp/RYowwV1iWJ7XFrMViFnBHDm0DSCBOkhisrsT56pVE+
         qnTgupqcbXbyNssBjgy65sR2wv1nHIocux+QfAlqxRKTqHWhVaykTqdGJpg8ZSTlnQpH
         RpP6SNASkjUzRWmlKrdEXfE+j3DK12EyhcttDeSMsoTlri6/e71L57C7ReagTq5w8cpl
         m8kCExOKiQM+0aC/o7gejVY/Bkf4AuzMWiGgK97kjRmBU/59+/vqRr2T6hnmriXuI8sC
         TJqH+FFPhoQL2jkY9N5nuyxsy1HvC23D9nePcSUvrM6K6DLGGCcmR0oi7sGegdDuNXbv
         xy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858903; x=1775463703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFv97piS34pvw8S7ZuPziYbAwBwFldQJ4NalWJR5jGw=;
        b=Cv+dpLpcKpPTJX+9ow0JJ02/X5DTRNriX5pkdTNJDcyaqeZJm4YxElrVWMM/o6Onvf
         7i8ssBZYLRRB1eu6iZ2giVu4W2cu/DHKBonJzKPSAW1ITptg4Bvjhmoo7wmxYBlXq+9p
         xnHpq27ZdftgE32t0TqxNwA8Zil2xaAj9slCsmwECL5Gg5oUpfwAuL96IPRkgDdv4gqE
         Kf06YAkhcS0tgWboNOjkVQZfEuHt2TFZ8yyzL1FhZW2n73XRpz8L6UMHbLISpRpkB3d0
         D3A/cAP2XMmS6w3kJLjYqq3YzOL+T+rAvcfA6tdqWvMCNNEmH10OI7Oq7XEHhv4dPrQY
         rQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3FYizNT/lLV/CKCH2Mu+dMIE0OxNzLd5DbuzfALM6OrZLM83HfKrK8j/30obSVbKSmIvf/Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaBrxcpGOLn55UU2qKx5jXnxhe+KTvwk7XlOADX1UEGUAkx7n
	owAPtoOVb2lG3/W8fGIsu8OcJgJMJar1HnjmW1bdTqnGdI6/dYanUB0KCVw6DNkDK9i2Nczn2rR
	QLLF7xjxDQefbAbur5nh1UQF8VWemlr8XVrAF6iW2BPZG6jT0c/31Koxx4tI=
X-Gm-Gg: ATEYQzw813eePAfmMkqO3mYanb9ZhXCdr+pKKtq1gOZGszGMOTTTC5d+H5w3UBIJefq
	su6P5wyS6qlLeKco5U2C/RAFTgRmKnej58J2MrIbDOezSKq2k5JXvZ8y9rmbGvxUPTrFX6x16B/
	XCmc4F06FkmIUiTB/2/FZlE6uTVLSd5pKf5fyF2oOJKYWXbQmqaWaCEffXdMCIOtA/oEF5kSCMT
	OtYYbbG+OEPMYo6kdaxH3QZfGORakkGyZeHYloLoEZyp/2JULV33tlxmVD5VI19atVighmn6Lzx
	tBV//WDUmtPRPx3ya6vq+1o46mZwT13fFpzkZBy8VKq2wT5viFz3YbKSxb6+HoyuzmmM95zas3+
	yAQhg8ZfB+/Vzn5hpyqzDVsNbyJkNFkfo0ewUA/duSYh9MgLbADEVZGM=
X-Received: by 2002:a05:622a:ce:b0:509:16fd:ac37 with SMTP id d75a77b69052e-50b9950036fmr188614511cf.29.1774858903176;
        Mon, 30 Mar 2026 01:21:43 -0700 (PDT)
X-Received: by 2002:a05:622a:ce:b0:509:16fd:ac37 with SMTP id d75a77b69052e-50b9950036fmr188614371cf.29.1774858902706;
        Mon, 30 Mar 2026 01:21:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf1db08e6sm26244773f8f.0.2026.03.30.01.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:21:42 -0700 (PDT)
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
Subject: [PATCH v8 05/13] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Mon, 30 Mar 2026 08:20:57 +0000
Message-ID: <20260330082105.278055-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330082105.278055-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260330082105.278055-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69ca3298 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2NSBTYWx0ZWRfX+iQIMZNPaPd8
 5Tu+TI3vszdmsp4vWfPb7mJl29rYuvSL58ke315JHqUzmcwAqggZZDShDLQk1WLLyIsC93LpGh5
 NQp129PkF245jEzMyFzglx3BN+1jAttnSyvX7bT7hDqG3am1LOk1Z3orNRQVUsWKyOPqk0Dm1HV
 UqF8w4eCSnMYSznn8aTjdSll2FHzgbhG+QMZ2hiuAzBvXdLOmK7J7kr+MKkG5jxTAi8GIlTHGD7
 uKynPWcWManRzVlqLeJcspEi0AetZ2Byi3Ye7bVomVVi3ony48mV432pc+p3OHaC9MICbgpq3VQ
 MCn8BFL49guIZIYA+u4hViTazQ1xPjjlIY50iZS0dGLMzB9u5Ou9gaMUoVIMG77qiXdqtl2a/Dc
 t+/U0vt6VIzznuhsfUBPAtXpFj2fJEw9ncLPcw77GvLaBnFuhZ0hV36X+ELO3bw3yzpVf+yJgFx
 eZ8Z4aSIDHO7sggbHsQ==
X-Proofpoint-ORIG-GUID: Z2JTXFig-ZpwYj4Uxy9qXSUQQOrGM7nl
X-Proofpoint-GUID: Z2JTXFig-ZpwYj4Uxy9qXSUQQOrGM7nl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300065
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231046-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D17EB35732E
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


