Return-Path: <stable+bounces-249240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MUzJWrbCmog8wQAu9opvQ
	(envelope-from <stable+bounces-249240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:27:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE97569ADE
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C63303AAB1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C43E63A6;
	Mon, 18 May 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UbMrueYk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CrKqB8Am"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5D3E5A17
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096239; cv=none; b=ZkYeWgsOi7+PopfDQ5XmFX2dw3Tdqu5pQiVfbwwiPbyRVhkVQi+nu9Nad2NGXB8tSP5n14yENH6UPwHTEKELMmVdmHO9CJrXvsneWvHJDKyVkYzvspbM1yKsSTJSvZGyA2lrv3tRQtzHMINcwvBkua7WvBkX0jg8KBDOz92Ungw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096239; c=relaxed/simple;
	bh=46oO58C6qyz+oSF3AkdKCK/hAYNIkihn1nqY49j8PJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/EV5+Vth/FYxs7I7eSBluX9V9fM1xfQR1AEhBo3KGJXGFlFRxT++pHKed9NL1B7PqBTSvF2OAh6iLfMEqF4PYTwoT37hVQcjMk+Cq274ZLYZ1oTqQO4SnMU4IjCfYiveaOdiXs3fdRFeuO+bqgicUqSd9T63hx4N0etveaFB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UbMrueYk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CrKqB8Am; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6crP8483452
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eF0aOw/ne8U
	OJ7hbYAxIT1oxXliCf3HbLnmolxKozDc=; b=UbMrueYkgjyXRAPARDJN9oW3Hip
	DoLN6N7sThhrT1fUs1HFTl7ECWgUpmXWdBt6Wx69gAE/TqzwBa10Y89V010+aRfg
	IlsVDdo0qlkBakE9U5Gmkyl0/pf3KtqxD1GISta05W31mxE0fv9/YTrmq9pBR2Mt
	aYBnEKaTFuTMcXK3IL3SB85z1elno2zQiBEQySVSYmFuRMviIgi4V6hZx5AmfIFU
	gTOkqDDd/KCKwqqef+46fuvmEhl9CBA8GjLuTuX/fVJK4YUBjPDeVWM1b/JqFF0B
	Q7/3kXb7Pp1m0m7Uzq11IgGbWDOQSyQFq9utqtTRO9TvHkfD+PlBjZUXADw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6tvcmj9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 18 May 2026 09:23:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fb6d713ddso30871161cf.1
        for <Stable@vger.kernel.org>; Mon, 18 May 2026 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779096236; x=1779701036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF0aOw/ne8UOJ7hbYAxIT1oxXliCf3HbLnmolxKozDc=;
        b=CrKqB8AmBsUmHbC8cMkGb9Y3TWZMutpcz8HNvh/K3B4i+UiOo6SGMWDIPfjnHefWdP
         uxY0MH40cI1mOrN2yvoYhpxwFDDfLV608lRN8TIGllM58a+aFo2cai0e1T9tfpC4SMIy
         KvphCC5OOVrpBkC92N70lEIDFxgIdd+iiNh5aCUa9abTgvYLazXgLaaEaq//43trUaG8
         CCIxLRlnPfDq/5gUFZ9FmBuyUbrCG5y9VHZ/XsAYYI7KlVbm0G+PV9G1KVPd33nAf3Wx
         c1nMxI8ZFgDoxs6axOQo1pHoUOC9lWCyJLc7x8lTyWxbOuqUhXDOQWEbsAZt+hz8Hymb
         rCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096236; x=1779701036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eF0aOw/ne8UOJ7hbYAxIT1oxXliCf3HbLnmolxKozDc=;
        b=nS1P+/6HbR+zycxmDl7Ewnt2RKFRFYxymtmnUfbYgBSo7jw98QxSNwFbKfeXtDJBNr
         HUmBF0Uw4WPgqeZbbZR2TcFm/qhOV625N3uS1qhENH2PBPdNRfLHIj4BL0J5vIRz2KR8
         JbcjzS4/aKKPsl5+hXQ7magCGp3pI2pJDidRzRU6TSmjuN1i255dVlFAi4vyoU2UOzUY
         atCBgdXx54oIMyGWZsjKlRmIv7OQJM9pb4mq30wIGEqUrT6PYygmEE54TsgbeD8oWgBj
         P3dteZS0XPeJyjAdZQ71O+ch/5EkHmZVdjab92NDPPwHSZ3rvDtPEQob2rZpCdg/Oz6J
         T9YQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Mh6Bt0WlbBUzWGWw6rRu8B6sndjuIr4QbAg3SN1vjdfaIp9Vno3dkSrYaNV8KS7BBuZ7lkc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVA0G0EkRIwWvKCxBUJiEB/8yJAEu2j4Jr600uvnt3Z8BQ6Q/
	dObINYklfX9qtJqAYG1IkXgDImr0ONmvshyibOy2J60l+1LzvJ+/+0s1kUHhV/f9mdSjIGC5Hrn
	fw5b29jiiwhKdptlUL+aYZDG2XprivWScw3DDdxKsUUx3nEvZbv89lnsk+H0=
X-Gm-Gg: Acq92OFnWtMXM2Sn0rcsKKaGmcauX2ioVlUGQ1HTLJH8SBqrljWM9oq2QU/rAq8pneA
	0NllIIK7G+Q+/ND8jy500/px9uSfjN7o8B8g33HI7EB7DhmVzuTjPGBJ0jxTG4DY0TxwOf+kcz1
	BbOaUGj6Oeh0XaVWqVbF2irCNrj9PXJn7FYI4cFsnGHN561+dntR27ZcT7Vcu0gUSVaTHLWSqpi
	RoyaAVIjgzzIQZhjksRIYOv8MoCo13xLodWYFbKpBVle0umgO+QjrCKlncYl3oPgpJfXTwKl6Gl
	dxfo1uC1A9v0lCWIJj33bF6d1A+6y49pJAcsle4Ed2uX9J6u9Pm/sznsIs+SCPZIs5a7CsJDJQJ
	BzPETiFNQCidsgSJ5CA4enDe65oNuj0AgZP4tFLtmjrN3YzJAVwK4AZCIiIGrUSkmoQ==
X-Received: by 2002:a05:622a:430f:b0:50f:ae24:ecdb with SMTP id d75a77b69052e-5165a276492mr152147031cf.37.1779096236474;
        Mon, 18 May 2026 02:23:56 -0700 (PDT)
X-Received: by 2002:a05:622a:430f:b0:50f:ae24:ecdb with SMTP id d75a77b69052e-5165a276492mr152146761cf.37.1779096235788;
        Mon, 18 May 2026 02:23:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm33265900f8f.26.2026.05.18.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:23:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: jens.glathe@oldschoolsolutions.biz, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        val@packett.cool, mailingradian@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 3/5] ASoC: qcom: q6asm-dai: fix error handling in prepare and set_params
Date: Mon, 18 May 2026 09:23:45 +0000
Message-ID: <20260518092347.3446946-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: X2W6GNnVspHAOB-U6cBLHRKT63KHzkYk
X-Authority-Analysis: v=2.4 cv=UIDt2ify c=1 sm=1 tr=0 ts=6a0adaad cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=D1n_lw8EissL0yZ26mEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: X2W6GNnVspHAOB-U6cBLHRKT63KHzkYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5MCBTYWx0ZWRfX39cx9rtNH2do
 eMNs0pLYa7aS9QmkJ04uKeMpsGAkbD+/UkGWojsq1IfPmrpmLXEll+j+3sCJmZcsKd6O/npbmhQ
 z1vsCxgDBfH1P0BB49lR9FUZ6HHdFN628DRXmwGtgX7Jk7K6zyaZBHUyTZ8y1aRCjgQGAkCGtpH
 5Bc1B3lzT/Twpus4YE8kSg/70PxfcnjhKQEHv1LPY229SWKWeSBuCpixM3VxKU6+dX5heYMY5+h
 +c/yivQ3gA63UTuDByooUOPx9k23EAMWC9Wgf9jOydx11nh4hCwmllQ5ru6xCDT/QGIQPCsuX2g
 Bcee9Iqcnzdt8bIyEzSu8ZdOuJ5dbpZz0ZVPOGdj7TJnxT1+cY5dILG4vjfF0718CjMeYEJpBmT
 VN54P7CH098DFGC6h8UTNZXxqrDnT1ME7z6jkmU8mUaoizGQwZbPFxFYNzXvEZtC1s1p6+ZWz7n
 1Tv+3TSbmzUCYN6M3yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180090
X-Rspamd-Queue-Id: 0EE97569ADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[oldschoolsolutions.biz,vger.kernel.org,gmail.com,perex.cz,suse.com,packett.cool,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-249240-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Fix error handling in q6asm_dai_compr_set_params() and q6asm_dai_prepare()
for both CMD_CLOSE and q6asm_unmap_memory_regions().

In both the functions, we are doing q6asm_audio_client_free in failure
cases, which means if prepare or set_params fail, we can never recover.
Now open and close are done in respective dai_open/close functions.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index ef86b5b9a951..fd691004a657 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -226,9 +226,19 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	/* rate and channels are sent to audio driver */
 	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
-		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
-		q6asm_unmap_memory_regions(substream->stream,
-					   prtd->audio_client);
+		ret = q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+		if (ret < 0) {
+			dev_err(dev, "Failed to close q6asm stream %d\n", prtd->stream_id);
+			return ret;
+		}
+
+		ret = q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+		if (ret < 0) {
+			dev_err(dev, "Failed to unmap memory regions for q6asm stream %d\n",
+				prtd->stream_id);
+			return ret;
+		}
+
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -296,8 +306,6 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
 open_err:
 	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 
 	return ret;
 }
@@ -912,7 +920,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		goto q6_err;
+		goto routing_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -938,11 +946,11 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 
 q6_err:
+	q6routing_stream_close(rtd->dai_link->id, dir);
+routing_err:
 	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 
 open_err:
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 	return ret;
 }
 
-- 
2.47.3


