Return-Path: <stable+bounces-231045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPYoNag0ymnn6QUAu9opvQ
	(envelope-from <stable+bounces-231045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:30:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCF03572CF
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A9F3062F9B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508DB3A8736;
	Mon, 30 Mar 2026 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODVRXoP5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLhORz3T"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FC3AD515
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858906; cv=none; b=RtaBI4WK/tFPq4RS41zoFpgG6M2BAbz2zELYssZ7WFYYGEnP5vhGwWtVE0HW9moh5fdyAgkwaxfYEgCTLXO/aWiGc6Tle9cDEKDlTNW+9wBg/CQMM5oZouZ2i19iLInO+Gekq+J+PHFq98fplzZhGC6RdoealGLNe21aF9rHALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858906; c=relaxed/simple;
	bh=Nn5W6j2KgfG3MXrQpHQ1hcxXhxv/yUbhKAiv5Knj23A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSdDDhx6GjdLGLwhubA76Kflo7CGkoGOQgWKQuEm+x5eWp584o6cwle1phhl0jLDuaueuvlFHhaBqKZIoPr+jFsMkk/jGakIkq99wYu5IuHIIIdPlEWsWQ3ZnzqRluBqo6AajSqM0wmJ1tJxlxhl+XCm4LvqN2sk4sTH+uySGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODVRXoP5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLhORz3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U3m4XL2954647
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=it+OAEpYU8v
	0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=; b=ODVRXoP5DPzAOpeIcW0XRex9b9l
	CrEkwyNYBrFqKot1f6vuXl18YEpNr9OsG3mGouk+4ukkEjxlGVP0R6WSZLR5NSiT
	X2Q4yVm1Ewgj++zto+b0rLONXRoud0rVDYMwJ/65t+IHZ6XJzZrL2Cot8+Jt4W/8
	iriy+Qp52rESuU1nxHZ/PiAcuOq4gMARmx4AqX74edlPxp9EmEEZwJtvHZTeCa4g
	FYRgAOmqgSaiWhhvZPBWE+8lQLHQ7V/0U5GHATajY+uzBTIX2MqGA9pzsYMfIjGp
	nKn2mUFy1IbGxOIGL0PBrAM7wWqVi4wmW5qRgWuhyZT0qa3txTrSk96AUpQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6wqek2eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 08:21:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b3544bc7bso57241751cf.2
        for <Stable@vger.kernel.org>; Mon, 30 Mar 2026 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774858902; x=1775463702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it+OAEpYU8v0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=;
        b=TLhORz3Te5ybLPk6+CW3DHK5CPoJZyeARZpyGTgeP+2hcStx0t/1QSZ+7qHMnZadaq
         PkRkL/2tfqIbCULRcvdjZfDlKay8AT7VTgnews4BWJjPw1XDCoWYCJaP7yt6XIfhCGuP
         i8Qa9guY0VlEASaIJUDXjnnopmdrq+YC7ZTMZFi4R0uZNiZ3EdAKdd/xq2tcJfr6uQxQ
         EhpWuE8uAH2bqnqwKAz/VUpNDvJq1cFPb6EAMmi1dZih2qvKBfayi3AMfaRkIpDKQu7S
         wtr6/9HwlitQAV5IPi7PKi+R3oTGT6AMduPu2i7VTxME1LEnjN+nF54Pj1kNW0BM4KQi
         3BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858902; x=1775463702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it+OAEpYU8v0MR39X1WR6T1UKdIHL61i+TcaqL8baj4=;
        b=Vh/G4SwHgsD5SOaQZAKmp75PVRMYVf7fVdeneOILCFisdxaoFdhY/uLpX0GL6F3eFm
         zuP0rRvdIbbotEyKOdGoAoRAzm8BgdTmUbSvrHjSv5CLhhxuSmC5TtrfSW8MBlknNkd3
         S5XaKwvg5L6DF42l55AR8tTH3vhhv6OV8hYUkgO+FXlzsM8AElvt1IyPjBWXEdajBEu7
         qaUH5rNTaVu64MPLeuYNZ3BGEB7W3TOr59j3CayJ49rPF8EPiUKVyStf6UXmWdqOOO9F
         AkrauEi16baRRNjJxIGhr//xu+Ug4/EKN+k2CwnD7dOd5PDr1pJfeWlkPy4Ak8+0XuEy
         faMA==
X-Forwarded-Encrypted: i=1; AJvYcCVyogKmB3YHGijkyVe7xm5V8fIVR57VD86cw0kjsHDigVVEsc1MTGSdiFwPeSpkvFQR0WY4+90=@vger.kernel.org
X-Gm-Message-State: AOJu0YznGWFAS5fgvBrB4WmDolK9wAMMBfmVdyYFHulfOznekTbnewN+
	vNmdRmPyPVRdde2MDma40zk/VGlNtHEtLDVwgVYLEgtq7Z5oyRwcLQYVWPwtCtvl6A6gnWj4OX+
	PT5hDltwU80Rs/OYzijgIO4NRR8eaoQAGiEENgCv3FqT9NIHfQ/k0v/lUwio=
X-Gm-Gg: ATEYQzzc/5EC6k6bM0OeBuo41T3wT/pZPXNHWpT/C5SReNY0I5+9ZV7sWQ6ngaA3JdR
	GJGJoXg8eGk6O2H8lXSmn2/oAACcTfCE8BnUG2y+7nUODENSmk3bCGcH74oOz7/zI1Vd8L/tFwT
	jdVa9K7ovSeYnZnRyInF+Mx7SAbPvS0JWaBoye+Pgp0o2uvDWhLCpATQ9kTgzzTG/zyj9LVG3OD
	cuS9uXNbTD+cRYk/tOiszMCPC8o73mnrumyWBes09AGDEXh1r38Idtq8PJ84Z0LEgFa4UPc1NLI
	VvbsU94b0p6sm0gXU94F0xjwl2pwCRXMxae47C5m54k5RTr4nhkpjkQbzNdYqXA/1yabtJ/XBXL
	U+FhmkHCE40HaWqxnROWFuAH6gJ3XxgRSXDPYeab7UarKIB1Cjqb6geY=
X-Received: by 2002:a05:622a:5a87:b0:50b:40a6:29b5 with SMTP id d75a77b69052e-50ba39186acmr156494421cf.42.1774858901757;
        Mon, 30 Mar 2026 01:21:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5a87:b0:50b:40a6:29b5 with SMTP id d75a77b69052e-50ba39186acmr156494201cf.42.1774858901294;
        Mon, 30 Mar 2026 01:21:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf1db08e6sm26244773f8f.0.2026.03.30.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:21:40 -0700 (PDT)
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
Subject: [PATCH v8 04/13] ASoC: qcom: q6apm-lpass-dai: Fix multiple graph opens
Date: Mon, 30 Mar 2026 08:20:56 +0000
Message-ID: <20260330082105.278055-5-srinivas.kandagatla@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Jo78bc4C c=1 sm=1 tr=0 ts=69ca3296 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M_mAHeyD2EURj3i0m2kA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: RApgiQjpKun1EmqnKmFTEcCPn5v9S85n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2NSBTYWx0ZWRfX2ENe132pZvbW
 723T+dfRKbfIxy8Ca6XpdKN9R6L2GhM5oh8m4tfJADWw1Fz08AsZVrf6UGRvKvpS0ADURDypiJK
 8tuX2JBxM5CiBY3idPNQcPUFv33h/ZdA7oph97RJxet4g0VYR6iKYiEbE/faTdAI/ARrk/5HLq1
 G49ZgMSvjsy6MWUQUCnr2dsgdxLyXx6SBXR99cZCToHJzfTnTw2y6A5jXBNlTUTTFA5nZtUwIzf
 qaJ3y0PYkHCjxKetztS70u06tnVhCFwpzhMqQ+F0oGiF3HknuSE9jMfC0nvRRWo+/huuh/RDf7M
 cBLI2ROXkiRhG5qdYBg7KjnEVLjGAS0zgfntDYgCWRQ+X77qWZ34d0v0rcu+RLkgcz7B4BcME8x
 SvpD3k3wBinaLAbVSN7k2ASoGoJmdWZd0IWIYFNV48wMjjRkowercaGyeKjy/aCeDQqnsp6sRjN
 g/NTXapRfeZ5wO3JlOg==
X-Proofpoint-ORIG-GUID: RApgiQjpKun1EmqnKmFTEcCPn5v9S85n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
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
	TAGGED_FROM(0.00)[bounces-231045-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3DCF03572CF
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


