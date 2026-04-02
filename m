Return-Path: <stable+bounces-232930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD10HMwkzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:11:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9548385AA7
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C71303C87E
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF113A6EF7;
	Thu,  2 Apr 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfqF+dvo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DG1X5DSu"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6813A3E7A
	for <Stable@vger.kernel.org>; Thu,  2 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117503; cv=none; b=XVW5na4DjZ2yT9iWZQ63k6O5Pw/djf7CTRlUUODvOcVFRBxQ+nrXcC4Hc912s8S1Xwc4Ur5Qm2TSIStLEI0l/Z/lmrfbx6UHN4wcRU4xQxLjOgD3PdautaEOuRuXNcQRasQrI7ySm5+5g6L4zVq05eZkWRUV3IzvgWr1f5Fjy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117503; c=relaxed/simple;
	bh=BssiN8tl0qU1iQXG8+lB5lBZKyz1PiocGJtwp+eWGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lal7KzKro7CpxtPE6gxTJpFUQdbAH7AdcoYtxWxH8IKtQeoy8eQFeqRZA+7KomtADUxPRjMKdxgvmMTABX3Zv6Y6Zc/vgv47cNYPXg12jqmz4HTDMclYiZvG03376FhfG1TqyAG6+D9/+DnNxMlKymtcWAyq03SPhTARqTwGcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CfqF+dvo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DG1X5DSu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6324Qlh41551329
	for <Stable@vger.kernel.org>; Thu, 2 Apr 2026 08:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eSDnacEmZXI
	09UfS9vabkH7g9erGJLEY42mHV3XwiZ8=; b=CfqF+dvowD9s0QhWzwX1dXqey1Z
	T9ZpC4k8ZVF4hFHsP/E1TaJbOKyDE9GVQQoXhEUYzSYrpKTBassT9RppSxxb0/wQ
	ecWvwifwjmUlD1MUkWy+ZJVjwDGCSW3LVdhG1qpBxX0vMJCLJwUVb0zQYfaZSqpP
	+Goj4VaNHxV5V8CWZOLRV24/rxTLIY8/8VIuSAKDoMSR61+l19j2G56GNfLI1HPx
	QsmaHh3j9HKTu0Zus2BRTpjARINLso4ZjUcCxFalEbJBC2leozFT8mnDpNnnxJno
	ky1jgDPKnNcARi56KO9HsqiiLHfgfoy57SkqRqCR7/97hoThb9skwhOd5jg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9heerwc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 08:11:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b878a8c07so11985471cf.0
        for <Stable@vger.kernel.org>; Thu, 02 Apr 2026 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775117491; x=1775722291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSDnacEmZXI09UfS9vabkH7g9erGJLEY42mHV3XwiZ8=;
        b=DG1X5DSu5SG0U95yTjCxBKKGUxnRBZWK7zjbYmkfJM9zNEUxPv42Z1OmpirO3bh4L/
         ISGUIIV0GmEvbe2/Q0ElAeCuKd4/ea1CPosbftMtB+rVqrINSJqJBjn397coYJE/GT/Z
         3xojJMFsy9SgSDxKVW+ZU3ExstjtIYgvVX0aCe5txHNHl/vpvu+nGPQMqNH7f/quc3kA
         UNL45lm9kigFMoJGZKjSppUy7h2UQn8l0dT2D4l4afc2D7mqZHwTnG/PMRm7qekUjAIx
         x9Xv4fQG/PtkqcN9TJ1PsiIXXPMMCj0BlwDWeIooTeB5V8gOugLp50BNOt1/UfwrvtqU
         Nhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117491; x=1775722291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSDnacEmZXI09UfS9vabkH7g9erGJLEY42mHV3XwiZ8=;
        b=m9cV0p4zn/JM5Tr9ptVYjHnmTR7hRrMJjkGM047Qq2xF8KOqiZJSKeRxE/4onh8XkX
         XsfHfizeBNQwyGo1Ii1Lk1d18+MkblcxMtZezvs6czpYIuaKGdJw6vnXWrCWq4XDkAWh
         HOVn0r3k62oWvuDHUC1lxNLiM7IDOmowR8o/BdF6oO6UuduL4aCaAA2/llrW6iuwEsdg
         IsMbZR8zDUlrCePOKfhOtHfPf6YLMAfJq2YKdTJ4hXMRYgxRr1qWAtGtKcH3Sp9qQP9p
         MkhEjl3mkgb1Ew1nEwLGyygUh0Z2u4aFNrpdOOdD+91JXGQDKCTLQwITvGCgjINnONYm
         c9nw==
X-Forwarded-Encrypted: i=1; AJvYcCWzo6z25GWmkpaSSIoHYEJCrIUVrA2VnaSwBv1F3mpf6Z12UirsEf/vxcueSiw4nH3xaoqhJT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ76UmX4EMe49ZpSeBnkNiACf/CyxM9yreCeKVqd09LH/J4MQg
	ZrJN9wZ8qAlmwABBKxh0A+KKcUFikq0stFRAGKbO+qET3pCmZWbSSFk6G/V6PQMSYSpQXl+j6tP
	T2L/w2PgQLrIinSbwYs0UqlKFvjDA8Np+ImVGRva0FRhoSqmpRQNJB7+CprQ=
X-Gm-Gg: ATEYQzzL1xHB3qdWmfK8MQUjQksUE/nEddm9ZRVPWIUL888P6ZnCH8dUAoMaS+O7k5J
	iYYBD7RCKRKbpp8Y1p0P92B/CzKhI/nRnN3aojr63qYTP+gnDNMHjtm20bAq/lUHuixm2PJDo6P
	f2BNufoRBXmgcDJw2LndQjDwUz2gxZMwIDLbHyBNvHYXBO62uvZuJ7oYL08zRB7vIy8Mg34b0lq
	qyZLB4NRMZulRA+j9F8qeY3fAubzCSGg2leIzkKjEljxWQn5sesCq0+/ih0JFPP7ZlGQ7LmIswf
	3pvTX8adQxsCJ9ZipU2aKy0bXDi09As9RiTYP6uFPCz+K/kBpNRBT+Kc4ZuMO4dyMwoI8aVM7B8
	ismAGi9RBwYNVbUgy5qRRKSolcWpCW7qKfxmx5j/xPbp358YWbHDQLHU=
X-Received: by 2002:a05:622a:54:b0:509:2858:3c63 with SMTP id d75a77b69052e-50d4bb5f1c9mr36507531cf.23.1775117491400;
        Thu, 02 Apr 2026 01:11:31 -0700 (PDT)
X-Received: by 2002:a05:622a:54:b0:509:2858:3c63 with SMTP id d75a77b69052e-50d4bb5f1c9mr36507241cf.23.1775117490889;
        Thu, 02 Apr 2026 01:11:30 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c3a01sm5712604f8f.12.2026.04.02.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:11:29 -0700 (PDT)
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
Subject: [PATCH v9 02/13] ASoC: qcom: q6apm: remove child devices when apm is removed
Date: Thu,  2 Apr 2026 08:11:07 +0000
Message-ID: <20260402081118.348071-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qxchibAQQQfFZmJFPCpMhm3ZwEiWK_Tj
X-Authority-Analysis: v=2.4 cv=VY36/Vp9 c=1 sm=1 tr=0 ts=69ce24b4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WbEMVPVtDBSXEMPt_8MA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: qxchibAQQQfFZmJFPCpMhm3ZwEiWK_Tj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MiBTYWx0ZWRfX7nSq/SpyatZL
 /7REzEfbviIGUaNNKmszAO6paVk8nJ9G9OFO2VLm4h853eaJ+YPoguEzyl5JmhXqPKvVu0OoPjo
 GC8w77N4sqkSLBZZstGKgViWHLsz4cNSIVdVWFQz4MwIJnu/H7Pt+e6sQGwQfzCe0tMMwlhVvMR
 ySJO4Uy5us048oTQ6fUtf6T3UtiajnaRlcR1U3p5CXSFSa82pPe53qrEd1oA0TyXUlf5sCMbYkK
 NJFl8I9Tj5VVbIfv0vPWjfDUOOtMzdqD0svGVWTA8IOQmAxfHA2Eg8GMMSrNHgkiNcXVDY1/HMU
 vMjeGw1XxbbrRY6pzz2icn0893LW483PFCHNHpLoiJxX14ONYiP/sYrm6EgI/ROVg3NgCpKQdOZ
 tl/+7J29wXKcbldvx23mVr8ynDSfZ0n2ocPAnhBuk8V+3AJncUaRJH1gk6Sf7rXc3BoNsGxg0P0
 4434EUlceOLc1euPcnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020072
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,packett.cool];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232930-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D9548385AA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

looks like q6apm driver does not remove the child driver q6apm-dai and
q6apm-bedais when the this driver is removed.

Fix this by depopulating them in remove callback.

With this change when the dsp is shutdown all the devices associated with
q6apm will now be removed.

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 069048db5367..2dc525c8be42 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -762,6 +762,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 static void apm_remove(gpr_device_t *gdev)
 {
+	of_platform_depopulate(&gdev->dev);
 	snd_soc_unregister_component(&gdev->dev);
 }
 
-- 
2.47.3


