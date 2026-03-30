Return-Path: <stable+bounces-231044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPFAMhs1ymnn6QUAu9opvQ
	(envelope-from <stable+bounces-231044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950D357327
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C14E305DAB5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D003ACF11;
	Mon, 30 Mar 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jzn6VMyD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnIZJKFN"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33573ACEF8
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858903; cv=none; b=eMFpGZrlJiJCGiBVFa5dlsj7DCocsFpnZB42g06PU9M7VdDmPcKr2j12NdRCNa5wao+VkAkF+QsGeFc9fI0xeps1cHlUlaLFoGQGeucIiWLQ+KER9zie/PmLzE3Id26wk4DXCnAOUVEr8sss6sDRwm7G3Y7oNGJOQCVXuI1baZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858903; c=relaxed/simple;
	bh=Y2gMg9r9rY5Id6C816eYq1RewX5CB2zXG/L5mc3pjP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikBs3NBNsbYEvbBroes7Iw8WRVazLVyZtV1QUgjRQk8wpZM+ZcT3wGmR6/+Ue5LIw3gIlhwe2TtjJ2cyvLFNRNm3Sz7vJ+DRsn6uEZEulAwLx0skQ4FY5c4EsExBw5x+uDuX3KM3+HnfajF6YdyOzNeRy597uJ5GVBcBih9QqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jzn6VMyD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnIZJKFN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U7HT4r1333673
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7B75lNNFNuA
	Ypi9X+NzbIbx8p2NgysFuyaIXmAqO5Vs=; b=Jzn6VMyD/t72QhmbJmpDDhXFs48
	Yh5GEsd+nAQ4nhJGc6i1wIlee03pm2x7L/BlTw4SPEDFdlmAdB2T5QsmFYccbL9v
	O1Zw4jG6vCr5GAZJqkx/OLjOel1RF3ZZQNwlKY469bh6twYAP4cguBXHoD0ZOKBV
	86eoPuQd11CioifkD7zgu1MqOTXHYNNEVTFuUjd1/0YOiku3gaxu4mkHS9KtcG5c
	YKenPo5iBglxk/SRkJAmDLEb8/jhHoyTqoLIRpXDUw5T9IHGNgpvzU/PxFb+pw9C
	PD1wbskWyea6glHxsz+U31iHECwwpxaF6xPCVXgAKjhGiccnTf2RHGlkUuQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d677155wn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b2cbe7223so139843231cf.2
        for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774858900; x=1775463700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B75lNNFNuAYpi9X+NzbIbx8p2NgysFuyaIXmAqO5Vs=;
        b=NnIZJKFN2UK1MgoNG1UBIhSWAiBvBiutW3sohhdWihKdA1uEcjAufvjQhTA9j6Y95K
         1LKd4ruHNqytfQHa+4OdMyxxAD3kcR+ljUe1mI4yIfiFsC1gjSPCgaqnwEDZBKn6kjwn
         DogMssGEMjO4Rpn/KkePvOxeNmHjvzFP+/yI7CuRJQvIwsgDNY7YY5CnIYC/GDkYS63d
         JE8y+GAg3BgWSU3F44QwfYjhEBdzYv4Sxa1Vo3vsRo01G+TQYYdh6v3D3pHTiCiozQ+d
         R3PvvhzMxGoguLbsJsSYqyjp5SKZGhn2WdavGZadP/AzqDzEDy8CDV6qQfeCPTqr01IJ
         U7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858900; x=1775463700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7B75lNNFNuAYpi9X+NzbIbx8p2NgysFuyaIXmAqO5Vs=;
        b=niAZtKVDreSuSTboeoVk7JBc8C8y/1d1BeiIC9vM0Xen6cIAa/gECBezhZ7UnwYkwC
         W+s4con/stZQ8/hdGAb8izOIjoUQJ4xM1uCQUfDJqsNN1TyjedH3lSxRklMvgIVUGMxD
         OCPWl3paWwiEogi2gjt2vJ0nIjgv8LCrRRTSlFBRbqPPjgpYT5yPEgOdnTxSqf5E41fO
         L70u0o8klST0z77kPArcYNYKJ+xje+LweDo4nfuVHBJnxwsGv9au2aBbisFo/lVq1jlU
         xhkrtR7H7GA7S7jwNKDvSfR8AzzesyFbi+HUPW3KvB2Mb7c550R1NJN0Nwkvw7n/st4Z
         ybLA==
X-Forwarded-Encrypted: i=1; AJvYcCXjUExWEAsuvCLT2u90gI3rxK+NT+fdWBz9d81sT+H5geFRoOAQuTno5Pt+1JoInefypxdsDWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTHgPcbIv/JspOuAURzyfMhDVMecuCXCM97ulENgKEeyixgJx
	UYT+xFh9Bb3OjbHE+5MHd7nX+b+o+BTwd5Lyy5QE4HakerKt8wEIqGNPJQn6sKK8nd3lb1U3gqm
	Y0mIDZ/aQ38xmuoxSiSTn5V8ukrOE0oyeBP2ltj/mAh4Mzge/Pn3K/aEBOUM=
X-Gm-Gg: ATEYQzxINkfhMdmKTs/m0g5zVaFbYhUKL07Gz5k04U2C8Q4j9XJGXctzfJxiJotgan9
	IHKS/xkjamYpCjFuYDIq+ZE5Xu6c4ld4OBv2Yl5H2eNyd9xI/ByCNk1Zhm8uFUSJFBHILJZIvai
	UUGtXqqLo9kr2Hllma2u/pFYs30dCsIWu17x4BOJMQOePdb+RKf98t2tBmAG/FuR4lKqf/aa0t7
	au09dFfTP59HZXCn7wUpwYjKB46rLNmPlpN2riJ/DAj1QB8ztTM6Sruc/rdoqsZ6nkiwG/aDfVw
	7lwvbtNE9eZPHRLb/GqrWVRFBfrO9h7+uS4lgfY1WhD1Q88egNYmQBX1tcY9p011nD8luXdoVGF
	uzCryUn7MB+mDEr3SMeFTs1WnDr1H/rT/pjIY+06W+qdqItp57cMNdk8=
X-Received: by 2002:a05:622a:5e16:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50ba3816a05mr155380221cf.17.1774858900192;
        Mon, 30 Mar 2026 01:21:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5e16:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50ba3816a05mr155379951cf.17.1774858899803;
        Mon, 30 Mar 2026 01:21:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf1db08e6sm26244773f8f.0.2026.03.30.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:21:38 -0700 (PDT)
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
Subject: [PATCH v8 03/13] ASoC: qcom: qdsp6: topology: check widget type before accessing data
Date: Mon, 30 Mar 2026 08:20:55 +0000
Message-ID: <20260330082105.278055-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: vn7GtN5mTrbESLdQOVsMnaSU6AB7uisb
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca3295 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5HTw2GpdgXbBP0wXRk4A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vn7GtN5mTrbESLdQOVsMnaSU6AB7uisb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2NSBTYWx0ZWRfX2XFynhqJn37y
 bNvJenh4nX+gfJLJY5zrSFpxu1QgvWCmf6i2cw2KPYLTuRJH85DA7RK8f1Z1Ac/qAQSI4rDrV4k
 h/b0cjtXKDB6b1qbcsVhFp0+tCZJ3X1FTuWiOMgxS0vpxNAWdndt0eAfGrRR2ZORhgZSgkKH+Lf
 k1ecrcmExBo1ST/hxh1vzQEf7P6UmDO8mzb2F02kcXsIb/m920o36Vo7MbnhBtM0WYs0ZqpW0pg
 127wmovvFs87wOERvJUYqctUJ63NxjPuU97IGSz1qx8837QX/QNyVZ1STBFd/SYNK4AiTPIg4nb
 xwqZNJmYEFxUj9dAeb9DtYZ8LQnfmt4UbyU4OnXzaUtdMWdbvLiCtqYHaQq3oLZqVlEmTRoGZtx
 2iqAddCgzK1z4/M+lZ4e4ppD+xU9Wflu9cqdVTB0tWMwBLQBU/0GofdrSoFUqM/bXuHXHyXBltJ
 JNefseTOU64f3Ttk2Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300065
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231044-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3950D357327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check widget type before accessing the private data, as this could a
virtual widget which is no associated with a dsp graph, container and
module. Accessing witout check could lead to incorrect memory access.

Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index e732fac9b8ca..1f69fba6de26 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -952,9 +952,6 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 	struct audioreach_container *cont;
 	struct audioreach_module *mod;
 
-	mod = dobj->private;
-	cont = mod->container;
-
 	if (w->id == snd_soc_dapm_mixer) {
 		/* virtual widget */
 		struct snd_ar_control *scontrol = dobj->private;
@@ -963,6 +960,11 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 		kfree(scontrol);
 		return 0;
 	}
+	mod = dobj->private;
+	if (!mod)
+		return 0;
+
+	cont = mod->container;
 
 	mutex_lock(&apm->lock);
 	idr_remove(&apm->modules_idr, mod->instance_id);
-- 
2.47.3


