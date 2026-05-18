Return-Path: <stable+bounces-249239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOOoDVDbCmog8wQAu9opvQ
	(envelope-from <stable+bounces-249239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE4E569AC7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95C863032CEE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D0B3E2757;
	Mon, 18 May 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MnyhI2N1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WCwEXlTO"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5653E5EDD
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096238; cv=none; b=NDATfLEgFtZrTs4lOyAYbrAw9IfM4YH0L2uWtDUDVw+jM8S32YCutiFhjyk3YK2/e7ydhzZB+0b+xY6DvSqCuYfrkHQsi2Ml9ZuTQIM+mAu4iiQDP1I02SWRg5T026KniFEHzY1UILn8CTjnVjwDyYzVZfbuHcdsPr095gztW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096238; c=relaxed/simple;
	bh=RCs85gMYZ1p9MuIk2+VubwPsJIHZd4Qgpqt8dbtEJpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbPUfk2DxTu0MFAmhI6vUkHS4iZOct3pX5WORlF6OmEIX3wU1s/n3l/914CRQ4zOYKUPhVhrDJBFMoeCh6IDQeIB0xvoD4uP7dUbXzvHAmU6/bYlALCmLfGxhcp26DIo5Gi7ftiKqgJyCiTV6FVLj7qLjX4qCa7/wuewoCvFJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MnyhI2N1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WCwEXlTO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7eI2w2893009
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s/uuIZd9tj7
	QhjDlqlxXE48EZqcvyagv3QTAGMpzuIA=; b=MnyhI2N1cFnaVI0OIWEJRYbrl5D
	vyg/05SnXAb9BXCaEZ/Up0ZBwfOkn/Xyb5ZzMkOmA563fVpJYRhqiyQFi+RM9G7I
	hqpM0GsoV0I4kyE/ZeEhjZRx6caUFUNyezoqRLaGAxrTjQoOAVkc2dhH6aY8Fjzd
	admrMs0awSJRoqrL9AbqPRzq4WiDM54dRr1avmikdvycZh9RZ9GH5muvVBF4q4Uk
	fW3UPcmmGH/DbwNLH6Y4Dn+Jw4fcXtPCfeRsnGp6YXudRkrEB+gb09cxUHmQPiRd
	dZ+nyUntNteX5VFCCNIwRqYZyQPIBnRCJc+M2aQwWD4PPifVqf24C2SWglw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk18efa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-514551d5f2aso96625531cf.2
        for <Stable@vger.kernel.org>; Mon, 18 May 2026 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779096235; x=1779701035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/uuIZd9tj7QhjDlqlxXE48EZqcvyagv3QTAGMpzuIA=;
        b=WCwEXlTOb0GMmX22or4eV0qY7WjjxdAARTUPwJXFgQJEXTfAv1UzUKJElfuJpJgyg/
         ZfR2QMKdtdedUrZC8NMPHy5lpCY+l0dcvB79ayop6dIP+v5aZeET+mIDGiDFNrxzhVCV
         /M5/U9vrZrg3v01awoZRXRaklvECOlCzsO+aKwatZmeF4qHbpXcpWiTmV+Vfya3fiQcF
         nxsKKqnVpc03m3A0lwMsx9YhyugrsPKtXuJ9MW3M2iicY5+KESp5msj9PnkCpFfQHROg
         TxN9HMzUoJ5731bdyzVK0R1CQypSJwfNnM7WK546/ofMas9LGCpF0rlg4Kr4QiS87nmr
         U3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096235; x=1779701035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s/uuIZd9tj7QhjDlqlxXE48EZqcvyagv3QTAGMpzuIA=;
        b=ahvVN8385XUVQ4+CqtGbNJJ6ytezcXMO0TGodLsrfeO1BqaXFwgjbx9MitXhN1GO94
         Tyj9KDqcX+pfDx+SAI0UYpgwLBbFbsG90coG8A+Wg3jo0zWnUhT0ah3i79OIFCaYuHC8
         JgGtoUHyrgsA7eKWkGyb2BO6e22kp2JgmlRbp2JJOk7D6Asuwkd3HX3rxnUQNtN7LFHZ
         /Q+BcAxOZTushU5z1aMPn1l7Y2wG0Ji8FV1oP+10Ol1AMtGUCFD5WD7CT2KmHXMxm9a0
         vwEEsZVhomL2+ll8tXc+NtRezmTVgmZe5Z29CdU5zQNQ8P/XOkm4inTWwi8wh939Xryu
         2dfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8V6U/DAzm7PjKgjeFItS9CSasxIthOFljB4UIkMic5PCl5dnpVzHkIeJDyolnbNAFcgesf598=@vger.kernel.org
X-Gm-Message-State: AOJu0YzceOgu7R3jOc5tPXLWIi+6UFuWAYRQ8GiPZf2mKcssSeKnuczk
	W3gAZdx12LjAyvJGDhFo4M5oqW9OUf9sWyXaaMEdmSC5Sbecyat4EGVBT+hyUEOF8Gpl/tP7VMH
	YPCafia7YLKHgYbTFiTVNAegaQzmZPbSF6zC2d+j89s0UjUgIB5u5P73FSto=
X-Gm-Gg: Acq92OGlh11iqkTqAm9LLrDbFEb2At7p0GIxL5CuwL6tztXu6PMzPtB0oV6GdP0lRtF
	xmPlVq7+BCWOcZCdW5h+uKxhoSNNh5q7TZb3I2SgC5LO8O58TuIAyK2wGhPB4QY9yUl0gs5YNJM
	EHeDPVwK19fjSGwcGV6+bcwOrIlO3FjJq40rc99P9WqHk9GdwnFeJgcF7QpCCrbNrGtpz+Jtdyi
	bBA6vxqlTKiolEnko+TjpWMf8K655mQYOwE3c9CnCyUNiQyMGgb+lPvnrGg/1erkGCzCfcTkhev
	dOAU9/eb+5SNza2QFzOXq2B7VOOVB1GQio0IsM0tgH7LA5qJhVS8RnhZAaq2pAQqP1JPFwFd8hh
	ygCOc/MAkHiOLMHzvD/WTWOpWCOj4THoyXhU49PLhRgQ/5j5TgJoOYAg=
X-Received: by 2002:a05:622a:2514:b0:509:39b5:a97f with SMTP id d75a77b69052e-5165a0a37a6mr197720881cf.29.1779096234945;
        Mon, 18 May 2026 02:23:54 -0700 (PDT)
X-Received: by 2002:a05:622a:2514:b0:509:39b5:a97f with SMTP id d75a77b69052e-5165a0a37a6mr197720721cf.29.1779096234552;
        Mon, 18 May 2026 02:23:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm33265900f8f.26.2026.05.18.02.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:23:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: jens.glathe@oldschoolsolutions.biz, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        val@packett.cool, mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 2/5] ASoC: qcom: q6asm-dai: close stream only when running
Date: Mon, 18 May 2026 09:23:44 +0000
Message-ID: <20260518092347.3446946-3-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: spLh7iZu6iGEETcZWQuwtz_Y1_fEdNin
X-Proofpoint-ORIG-GUID: spLh7iZu6iGEETcZWQuwtz_Y1_fEdNin
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0adaab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KnWeaZq26ommGgBC8l4A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5MCBTYWx0ZWRfX2HRz7RqVjSfj
 Ed6sndBS8K3JUozmAo/HkY00XcYL8yAQCDnB+jQFyxy1kBNDWtLKlEKLBoW3uGYGhrEHZa2JWeG
 dI5bGDPDF9g28JxcJJKWhX8JV4wH3XDKJDE0WfNvSUnr9p7dgZdo3qHO9BC7QIpfbNzwSZOdfKc
 ocrIZZJrKyeEL6nqo6nFtn01JTy0PiIIqAyMkn1dmUgqZwAbtUo6e0nEtFa7dpWpD5uRL/yLYmy
 3DWflXRVS9PLqlKM5KE1aOodAUCgDk/mJ/1498+T+tn3rddtvEAtIpQD8M9cKey0PfFvkGFgrUO
 7AO04avrRamkNPXLh4fC75HX4MystsLXKBKMZeuB81fuhTyrj9UX3TDwFK8ZplMENiFSsOnkPeP
 6iyssIaVOqYjikVmj3E6WLZfEZg3I4s7yGqpDbyRtx8mwhjTF40hfzlgWjhI/IQBkIjEEOUD7l0
 ksA4tgD70mx/BR0Zfng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180090
X-Rspamd-Queue-Id: AAE4E569AC7
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
	TAGGED_FROM(0.00)[bounces-249239-lists,stable=lfdr.de];
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

q6asm_dai_close() and q6asm_dai_compr_free() currently issue CMD_CLOSE
whenever prtd->state is non-zero.

After prepare() closes an existing stream, the state is updated to
Q6ASM_STREAM_STOPPED. Since this state is also non-zero, the close and
free paths can send CMD_CLOSE again for a stream that has already been
closed.

Restrict CMD_CLOSE to the Q6ASM_STREAM_RUNNING state so the command is
sent only when the ASM stream is still active.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 56f0d8913904..ef86b5b9a951 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -455,12 +455,12 @@ static int q6asm_dai_close(struct snd_soc_component *component,
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state)
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
-
-		q6asm_unmap_memory_regions(substream->stream,
+			q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
+		}
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -670,7 +670,7 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state) {
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
 			if (prtd->next_track_stream_id) {
@@ -678,11 +678,11 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 					  prtd->next_track_stream_id,
 					  CMD_CLOSE);
 			}
-		}
 
-		snd_dma_free_pages(&prtd->dma_buffer);
-		q6asm_unmap_memory_regions(stream->direction,
+			q6asm_unmap_memory_regions(stream->direction,
 					   prtd->audio_client);
+		}
+		snd_dma_free_pages(&prtd->dma_buffer);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
-- 
2.47.3


