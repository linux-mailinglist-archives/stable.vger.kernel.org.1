Return-Path: <stable+bounces-172813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A91B33C4A
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02ADD7A4AC3
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF02DAFA2;
	Mon, 25 Aug 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HX0CBdcN"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B22D5432
	for <Stable@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116782; cv=none; b=HKGZJvk9AS0pQSecd08MnkG/sendl95xT2dmkgJ3LS5plKq2RhixvvOM/qed0TMju9kXXaGoOGIYCCNDQbnnXevhqNSics5KZhrfoNV/QZKM6tSYe79fZRdV/1R60E0XBf01W8GbJwb/Fu4bNvC1/Zk75Fi8FeEYSrSrNxagPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116782; c=relaxed/simple;
	bh=qETacxdD+xOMesgXMU0txWNaZ5hKWFtVQbpaLYum4Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDAlj/K/OXK20c5CrCjdTiyy8P2f1pGZA9EyGhrY1gMKmiU4ks1FT8RZnqcjvnpK+9BZbOT+/s737EPr5gEnjxafamvJBZIyEPAsqndDd6QBZbFB37hKyar2CCPoJGLiWrvRZQNM8iU8pBk4PFeOJrh4Lkn3GYX7hrRyL4Im7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HX0CBdcN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8LOl2012253
	for <Stable@vger.kernel.org>; Mon, 25 Aug 2025 10:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M94yiXXN3v2
	OeJTyDLo3KsFMQqNubljS5iZCkUwPSZ8=; b=HX0CBdcNMAbP5YdkvBxw06GNjHs
	dXwFKQKsnZrIvxTZbcsiK1KYW90sEKivlKgJFD+6g+kydNSH/pv1RvvPiu5lwB/X
	ug9ZFCKox4qmhIk7HytzYQncH0GmsuIe7Fg+w0NXw8UWKIcp5V0N/A05Fxz9bTP5
	C1WgmsLC6wIa9EAFyaz4t8sIGIUSbeYF99s5/Wvg0co5WOXC1Tiln9vrArZpojqv
	SJohIZ3/ppYgqky5n0jZgvqLMLnKKw9MSaeYau+zvhcmfWhb9XQSm9rnrnrFs/tG
	RUcuoAsX0+LAX/iv4TfsVtrsKQWXg61JF6S3lQwrMo2urbSluQdvCf8CrmQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfcqq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 25 Aug 2025 10:12:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bc103bso98533041cf.2
        for <Stable@vger.kernel.org>; Mon, 25 Aug 2025 03:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116779; x=1756721579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M94yiXXN3v2OeJTyDLo3KsFMQqNubljS5iZCkUwPSZ8=;
        b=hfho0180SzyCNpR5xkIjsAg+dY/2UYjNzX6yyBR2gF2hiCaMfL36pzdsfuPhejBQk5
         zhFSI20RwshmeD3B39/sTJqOwuNYw418cQgOlVjXOVkctZZt4X6Mp+YCsf50q/aFslaD
         dPaOFkY3mWlbe+XotYzQfFJkpz59X1lBv6PaFtAFTwxvKgGuSbuKj3jaof1UbbhDqT5i
         Ez7zab7DBW79+0oz6M9VWaFJJzitmFn//GAMMsfAaU3IPWCWJFtpfwrulW+I5JNTiV6T
         O772FCWcZGXMgh7mucv4RndqCQCl7tzXBUTmjR/V66tzXRN+0usrUZuMj7Ur1kfwdAME
         5I9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUPgyB8q4OGnyNyQetR5cQP4IGz385N385Z/A+h/jfqw8DohCEZU6lCV3LJxKZ1cnVHWZLZkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/D+qMGXX4q+DwJlrlmP8e6Z4cGHzD6pF3aP+s9+UqRvOls8g
	i3ln/gUVGuW+5kfafLo1HcWIb3UFaWssHQDpedx2ThVYQp5WJmr7ktJO2ViAFt3rva9QPegk/Y4
	1mH20BOw0RKXw2AgouwXuSyNlKyw4I54ruHkerbqgEJjN/+EBQUQxFHOnPNs=
X-Gm-Gg: ASbGncvuDfG+VQK+0UHIfNFR4Uq8ufwKLaeomayV1F1RpB2VE24JO3EmkmnPCUOA9p6
	zYSbrQGB98/OyPSAf+nzGdk9r2oXFbl3uQi9LdzFMgBowXv1Vf/frCFBIHPeZqwr0xxjAydj4Ln
	QM0BGulidtN/121f3N0fy89wB5aDQlpatcMGlDZFoJXFYkp+FgvFxuFXD8ntLpva9SkmmEbewcD
	uYmegVaFpnAqY5Nesd1kLzEvV1gD6EaxUEp15VhzIrZBzaBq3s/oTYfRB7HDeVgPDZz25w7jRfO
	5GRDa6L8r/DCuIg9QUgZlWklxtcGjuS/AnmtSNoEbIklowsdsQsI3Q==
X-Received: by 2002:a05:622a:4188:b0:4b2:d25d:2f15 with SMTP id d75a77b69052e-4b2d25d317amr35725531cf.20.1756116778642;
        Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2cGVPeIFuXbrWm4z0GxzF/KpOCtFW5IwJGn5xkGyqjVJJolW8huuGhTudz9wm/LFSsEywjw==
X-Received: by 2002:a05:622a:4188:b0:4b2:d25d:2f15 with SMTP id d75a77b69052e-4b2d25d317amr35725231cf.20.1756116778089;
        Mon, 25 Aug 2025 03:12:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6359b8d6sm5798645e9.4.2025.08.25.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:12:57 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>, Stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: qcom: audioreach: fix potential null pointer dereference
Date: Mon, 25 Aug 2025 11:12:45 +0100
Message-ID: <20250825101247.152619-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6hbAa/h760D9
 Rvt9OPPYiWoYdo1+DqreNJFEorGKZz/fuSNEJpBOGr9il/D2wvdhdSI6bH9y3J+ilS6fQJREUfX
 mdKaLD8WJ5HMocEgh2aOmzPrCQpRd6yHgQSaCXxf1r1DxXMH3Av0WxnCFi1ExVXiGHlrwc8pvTn
 Qc+abZpmV79txC2fC/mFvG6hHKMvDp/ee5j/+R8lJCRWeASF4RiySofANSt/nDDkbyhPD0EOnW6
 SA1Zt4g4h1nqEgXn+6wRMKA7PVYeafwxgEXXIEF0seJs7VLIWBF5qejHX1IKH0IFRqxWfASX4ES
 +hQFqI4UDtMCJTwQLzJF0wrrG5g4J/6loI8PC+umMtgo6zb4qDKZryz3W5s1fgcon7SMoueAHP9
 8Dlj1+Pc
X-Proofpoint-GUID: u0BsL8cNuEAamdVXJIyQvnL5xIGgh_CK
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ac372b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=6m3MDpN89X3R0uDixRgA:9 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: u0BsL8cNuEAamdVXJIyQvnL5xIGgh_CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

It is possible that the topology parsing function
audioreach_widget_load_module_common() could return NULL or an error
pointer. Add missing NULL check so that we do not dereference it.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: <Stable@vger.kernel.org>
Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index ec51fabd98cb..c2226ed5164f 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -607,8 +607,8 @@ static int audioreach_widget_load_module_common(struct snd_soc_component *compon
 		return PTR_ERR(cont);
 
 	mod = audioreach_parse_common_tokens(apm, cont, &tplg_w->priv, w);
-	if (IS_ERR(mod))
-		return PTR_ERR(mod);
+	if (IS_ERR_OR_NULL(mod))
+		return mod ? PTR_ERR(mod) : -ENODEV;
 
 	mod->data = audioreach_get_module_priv_data(&tplg_w->priv);
 
-- 
2.50.0


