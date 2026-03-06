Return-Path: <stable+bounces-223330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPxhEF/HqmkyXAEAu9opvQ
	(envelope-from <stable+bounces-223330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:23:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C42220833
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 13:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FDC43028D7B
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30A43921E0;
	Fri,  6 Mar 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P76SvNFs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pb27lQig"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56056242D6C
	for <Stable@vger.kernel.org>; Fri,  6 Mar 2026 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799731; cv=none; b=aZH0QFwhTZZdyG+gOBv2UGZs6CH3P7p6jH3YgR3hSiKGIYi0RvqaqraaKm8Js8DrVve5jMPM+pwSaFWBSk5EkeSXqlAsIZXUq9G2kCJT9od04MqAQeIS9EVEXRsoAGsVJnV75PNhubFPZq7fInt7rBrWDLwMdjm+Asgd1txdcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799731; c=relaxed/simple;
	bh=KvhN5EIM3XXPaotrLaYPSuOdgBSYq4SNpSPqi8ZqfN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRfa4ARzm+Bl7SPL1KTxOkmmpjQF+l8vvaXooQWb3G1qsCQzZt2o1CN/LX7xdCG+8CZIcd1u0fyWUv7HdHmjiz5RrHfplcTWh3208iXxHqRQaIpa0riWNAfUKrSMM2hV50KCHLMriViAijS7q7Bgo2w3TRDGm/LV5o0rIQAIUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P76SvNFs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pb27lQig; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626Bak3C4186067
	for <Stable@vger.kernel.org>; Fri, 6 Mar 2026 12:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=K4gYoo9JoJP
	OJ5mTuliJj+hphclVDgk4+5Zp53bnrEg=; b=P76SvNFsuij9ZEa/4BmQF7denLn
	q/n5YvrZcQ1DypSC4YOtgDhpsUHc8TahtJwm7ZU+p1RJ5Xv6mWgj84yZLydire8w
	EU06roC5QanSFtAuyb4L2vylyBZeyqWquhqFoc0XxyQC5fhRv/OYWbq6xzvMPzU7
	JDs60aY9DbUBeXKL1fdN12E+LAC3J3gVlXmcftvVQ2oLdQgpASV/YwHovTDKVg/w
	FlrLvM3chwmL14COPULPre9rOjzu9JyY0ogDBdDRXKCvgJUftYtK4ebtSbR1Y87T
	3R7LsnnV/uDNj1uTh+ZOcNQi9pEy4b7+b1mmyQm+MD3xn9Q8yjbZdsnGs5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqruk9a8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 06 Mar 2026 12:22:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c711251ac5so5061871785a.1
        for <Stable@vger.kernel.org>; Fri, 06 Mar 2026 04:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772799725; x=1773404525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4gYoo9JoJPOJ5mTuliJj+hphclVDgk4+5Zp53bnrEg=;
        b=Pb27lQigYpwr0mDY5+7fEaXdEjundDGN1KOL6Fl4GAqfVytZcSztXEdX3uxKhi0a2w
         1bi3ffXweX60nM/wGEX0kV3fh0uaOXOsTWHbHgvvKXQBMx6Pl9p/kNMQjwgpXvXpm4eS
         r7NkjbxzOLiW/qDl4jTqRnv944PJVBc/AsP2H/9LMIJbg7HsTfMV799FKVwd/HH/VKdz
         A+fhnXTBmjeuo/RGGseV7VRsLF/FexEGzX5H6wrY8yJc/J9tj3OMWtpvS9rMYY6o/kuo
         wrM9xAvbbhK+iRw6WM4R9uvBUpopX70wfS9hlqvTR88IMyVdufw2YPtHgapNTwpKG+vH
         /4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799725; x=1773404525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4gYoo9JoJPOJ5mTuliJj+hphclVDgk4+5Zp53bnrEg=;
        b=WhT2PqyBA2P//D9wkxbNfID+74MwlpL0hF/piDE6Jw4Vac+fJC+L6rOrIad41POxwm
         gFNrZab3XUNa0hdB5xsquvyWFKY/OY+/9h9RyPGGh6EDNCoUy9hxMc44NC64aDDYOu70
         bOKUumschCxNVxrSL64e5NlJmIJzIsnXJeZL8jGO0wNWT4TZqwI7rPmvd483ejePJWeY
         6doAbPrhXVhU7FQqu2wNCurQwtHcpCQRxIsUrizZbCVR8pMisNqEPl6jRVWGCht922Jo
         yf76d8JgnYhmW0wLRx1oFhrJPaUTXY1YMfFOY8BrFDKM7WxEHg7Y+hfYnIZaoQjvr6SB
         bKAg==
X-Forwarded-Encrypted: i=1; AJvYcCXHBqqqfyM+l3wE+MjbSSqHgeJi5Sv+gBg7C7+tniwwFm6S65Je/lIukDjhoTEXGpVEUqTmgNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNV6qvkk3phIZszeJniGapZyvepNjd4fle418elvGYtj9Gt4G
	NZgg2FSczWuRAK/Aet/Ao5rNtfT49EIxg2f8HJqCCHjr0WznoAVPrc2RrXhoAbahvZR3qKru5WB
	nfkNs86QTmyDumLoUwdS095bVJeYN7VQji+8Pbkp2S3FX91lx9laSRbtG4Lc=
X-Gm-Gg: ATEYQzybVSLzF1OozBYMovUCvqwfRME1TPROG7iawkbzhR9QJy3dKqt1NNQt+RVeANb
	fLt2wfhlkRJ/Un0iAZHpfr9OH2NkgvDEA52W8roY/WNnAOH82NPdftT+6/WQIvhHpACKT3h4RkI
	a0wh+pOQVhqUBmE+nj6iKLlhYr9sFtay+zMwDfLXshTqI6OqRkqxso9n76FLumJnq3MBdmlwNJi
	fve9s5Q94Ip2GVkXU2c/CkEh/6B4fq5EOCpvwRFZbckVdls1gcq7XF40pbf3DWZ+px2/AlLi5LU
	/BC+z0VQYAvMrPYPJb8kPSePwvoZSrpop4R5+LsIEC9KYfhoENJ/gI1tCTv9sWtoZrW0U/xfEPM
	4h2MVvcYTlHgsofWl9avnWvm+XNBM3zqS+pNLKtJZYerje8aU44Xxz9o=
X-Received: by 2002:a05:620a:4588:b0:8c7:7a3:501c with SMTP id af79cd13be357-8cd6d4285famr205930485a.52.1772799724997;
        Fri, 06 Mar 2026 04:22:04 -0800 (PST)
X-Received: by 2002:a05:620a:4588:b0:8c7:7a3:501c with SMTP id af79cd13be357-8cd6d4285famr205927985a.52.1772799724551;
        Fri, 06 Mar 2026 04:22:04 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fa87e56sm111972395e9.0.2026.03.06.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:22:03 -0800 (PST)
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
Subject: [PATCH v4 04/13] ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
Date: Fri,  6 Mar 2026 12:21:06 +0000
Message-ID: <20260306122115.509705-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNyBTYWx0ZWRfX1VVUgVJMwkHM
 WNSMRJumbO/Q2pHE5PRz7IuU2w+BG3lAu4hNwv+txh8ToZVhXqc4q70aWaIeVhJlshAh0nF2cIi
 Xm7dR6BjSHiKv1PNB8O/1yDt0cTQ4cyXNG8b38Jv84EtYdk2Sez4ZYuTgC3TFLuFJzpUgxQnCOj
 7r5u1DBwBD5jtKIB17RTJGRLNATmRSL/Jt2yVm0qYEDnKgXvBehVAhQ5izURh0UsJ/w8NwgcVts
 brexmzcdyp4SUNnGR96W9rvf5seqfpE+Gp5nKOHdRoOGMNi2bJk4C/aKqBLHSsbhVJ/dO/NFWGV
 aK5bTbSSQzX8+Swb1V0bgqxbqFkx6DJmsSk4pVIilPcPuo+ZyqHN8DI1GcmqWzUMtFnMYq5oEAP
 lCtB52e5hjYs2EaudrwIdtEzeVjOmnyCwrnSoy/ZfSA2t7saJ1/66gCYdDjwOruQwpD8SaYdQ3V
 KCWwRuqVtbQIhwMoJDA==
X-Proofpoint-ORIG-GUID: BIbgHe0Qt_k_JUe19oZHdm6BZz1F_uQX
X-Authority-Analysis: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=69aac6ed cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M_mAHeyD2EURj3i0m2kA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: BIbgHe0Qt_k_JUe19oZHdm6BZz1F_uQX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060117
X-Rspamd-Queue-Id: 37C42220833
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223330-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
index 528756f1332b..f68d4b4974f3 100644
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


