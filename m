Return-Path: <stable+bounces-186262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B8BE74E7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7529622441
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07292C0F7C;
	Fri, 17 Oct 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDgeaNcx"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12D29AAFA
	for <Stable@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691385; cv=none; b=t52DhDotmpOfKX6uvPKQYRQj4FRBm2zTnX2BPW3+qsEY4s+fJuNVtazZ5W1aFtIH+r2rtGR7jhYviB5gNKb9U90H+F/Jbc0ZOe2r15OW4NM4E3kU+4nkZ+qrs7PyvrNDhcQvYPlW457yLYIQEORIx1kPm8w0Y+cOSZeh2CSDrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691385; c=relaxed/simple;
	bh=ENO3YSOfTnciWFB7PA21ZeJ+n8gziqAO4GtBW3dwPPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8oSrpr+ac5TGvoK7ECpq1Y7L2AqCuiAcqrlsOEI0uaqXZ5SVLj305DXYsb+AizoVND9+euRi9rnyn+HadWqY8lZwHJUMtkysYw8R2bPP8OJCjkKWxqW1uFP2tSy1AMv4RrJdBoyjCx45cuGQjbEL9CrsKD6UqUTg3I1r1XRT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SDgeaNcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8DvOw020342
	for <Stable@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2qk5/cDXnMl
	tBmhvmLVh3pUHcYmEfXQKc8nHF57WqJ4=; b=SDgeaNcxQnseZaDUnIlewILulX1
	e3ImkJv5NOHHSQxWYsdl4vaZtvuXLh0CHik8QqjWWgDWTlWiqJvKjmMFqyQTj8uL
	hj6A7dWvEm1JPhuI9YIy9czvFKSHi4jwePTo5Qy1XywqaVD02RFAkMffN3VHz+W/
	fDlOEtq9TTlRFz3hMk5dvbhK3c24Mgkfoes2eG3bTZ4kw+MbfEuWZRCpwJ2r+eSf
	v4qjg32mGj7QyXrB4mANy0VCqt9MDOyeXjknhjwRPbG1VHYUYl4CfBBErUK+LXig
	nbcYb/qBA0vLEA75gz6OoWSWDYosJJ8S0tMsD2ZIUvBBkvPvQctauw4s2ZA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpmyex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 17 Oct 2025 08:56:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c08308d26so59424866d6.1
        for <Stable@vger.kernel.org>; Fri, 17 Oct 2025 01:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691382; x=1761296182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qk5/cDXnMltBmhvmLVh3pUHcYmEfXQKc8nHF57WqJ4=;
        b=lm5sd0ipUjP5VWQxZyXOiJLLIgNF7WtFAIw4BCejg5UCBqqtkIpq/yFjg5w0+ho6Th
         HfmF1qykiz58Mp3LdkKHaDR4ay7aa2HxlNC+mKKCcg/8vbuuYJSXm+tsqwfzAYwvzIho
         6+O26ZHQMzeqOGl5cGvnSLJSBvyd6N8FJzSt4SEoJ+bVXGHD8vx0EHBzinMJqyIp1uGi
         aPuAKKh24pR7Ym0QNiaPLAz9VWe60DwwU8YTtZd0DYipHiXuSgzAT1mlr3fxf3MObEMp
         /TaEgyESBI9WSECpP9HdK7rqwqXBEo0FcNjCihgqAjvuF6xDDxkayuSanJvBgnSBuQUL
         2KaA==
X-Forwarded-Encrypted: i=1; AJvYcCWe4Vbc5kpoimod0S/1WUQJazuGPwVFDeSsTmkEBMdmGNSlBXnCtVKktLFiLx94cC/AbzM6c48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjpGbruk3WZOsmy6IvUnukTeyz0faAWwW+CudFWMrpezJuiGq
	ZhZu9FV4rg+tRLI27XZ4idb23fiO28EI+T60IkVKUmINauhGc7gwicEIGdMF0xWiEAW+essEmqD
	VLYBjg9yKjS6eRqyO5sPMKPRYw9ZVuY5Mmh7ewpTCRX6yGwnzrIeoPOxu3UY=
X-Gm-Gg: ASbGncu7zuk0w6Cyon8eNYAxIP5WFKVTweUAnLre4VzYaLcUSQcE+eZDEyuvKm16mWP
	OHZzy0mbZr/UKVaIv3zQZyKNZTC4aVKclWCyf6jxwy88gqx33XK3EIb+4v5so3WAzYBcfUvdVI3
	05TgGgbvEN6q7NWo0QkswUPD/fHTzKMg59/rqboqhZXRmt6AX+G3l75FimDyXdez1d4bPpnzX0j
	JEIZ/wEzezQZF8UVeBw/Rk5nLE4SpL9XjZ42dXUAYBRrjWpkh7biyFxdBxiFU+spaG2KMcRR25F
	oCrIk3wjq+oIQcQTzMbpKkcXBvhWpi/r+YPPB5JPaIxnvsWJsyBpwNV7kbtWRI3hj9WxriYAz0W
	xpyv1HSNAEBpJ
X-Received: by 2002:a05:622a:310:b0:4e8:9c58:3282 with SMTP id d75a77b69052e-4e89d28b3cfmr45995091cf.29.1760691382175;
        Fri, 17 Oct 2025 01:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXmaWELNHeA4YfO9bK7KKaN2PbiUIZEHrtDSzzKi76qlVj6r6Tyv+8YGZWV56bOI27CdHbfA==
X-Received: by 2002:a05:622a:310:b0:4e8:9c58:3282 with SMTP id d75a77b69052e-4e89d28b3cfmr45994871cf.29.1760691381758;
        Fri, 17 Oct 2025 01:56:21 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm70764985e9.14.2025.10.17.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:56:21 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 01/12] ASoC: qdsp6: q6asm: do not sleep while atomic
Date: Fri, 17 Oct 2025 09:52:56 +0100
Message-ID: <20251017085307.4325-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251017085307.4325-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f204b7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=cAUPnWn_dBUFebge008A:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfX0Mqw9jax/kfU
 rPl901nOjwWkS4jWhN9zSVBMwPhbewE2iAoAw4i0s4vdDa1uD/4D8vAzzwxYVIL5LyVWcbMoeP7
 8Kg1ha4iiYiBvHYN5yYrl21HkNx2HKV3lo8hIkiQZOWEFP+NBB1QRQ+z3VfbIGmi0R649VwgFZN
 h6LrfZ/cReMtsmbWCjXElbJFozWW/+/IrHEf05ye0F5H0HF7B2k+7mIppUOeoHj6CVoV6g2ivFe
 iwsnCV6z3/pyrOZSrmpm4dovc3xk374enGvicyZgBDyE+sLWLAcKgXPx/NmRXQiksqyp6k0wXA0
 0efyO4lEoWa71shaGk8YE78WLvIadyPVB2050ZFQNuEKFIXl92YeueZ4gIybsYwXA49tIrveCx4
 4sbA6Cx07DXu9jWMVZLj65YftBtFYg==
X-Proofpoint-ORIG-GUID: YIdrjIUQ0mvJOE5yicQI6cWp1ZXRfAyG
X-Proofpoint-GUID: YIdrjIUQ0mvJOE5yicQI6cWp1ZXRfAyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

For some reason we ended up kfree between spinlock lock and unlock,
which can sleep.

move the kfree out of spinlock section.

Fixes: a2a5d30218fd ("ASoC: qdsp6: q6asm: Add support to memory map and unmap")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 06a802f9dba5..67e9ca18883c 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -377,9 +377,9 @@ static void q6asm_audio_client_free_buf(struct audio_client *ac,
 
 	spin_lock_irqsave(&ac->lock, flags);
 	port->num_periods = 0;
+	spin_unlock_irqrestore(&ac->lock, flags);
 	kfree(port->buf);
 	port->buf = NULL;
-	spin_unlock_irqrestore(&ac->lock, flags);
 }
 
 /**
-- 
2.51.0


