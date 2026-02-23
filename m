Return-Path: <stable+bounces-217814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPjdDuuXnGluJgQAu9opvQ
	(envelope-from <stable+bounces-217814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:09:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A217B4AF
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15A23085A71
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039F33D4FD;
	Mon, 23 Feb 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E5w2WyfZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EPb/iLC3"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879733C515
	for <Stable@vger.kernel.org>; Mon, 23 Feb 2026 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870085; cv=none; b=kzDYHLtCm0AUuEfob3ytpGAKUk2TUtBY9rEfqTKrteF8FLBNGwRb8ARFTyIGqRpGP3KeowX9LdEAGKwwIZkqGzSC+LOrCJV57uGDeNppjJJFG5H9S8q+sJFo68oQXFy8hhxHikZ7JfonuF3RxTIzaoOg6mcqQHXn6seFOLQMymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870085; c=relaxed/simple;
	bh=D974qErk+eSVxHSJ/kOz4RqeA8U4H6OLfYkanxY/E0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rg9XI7tbb8ACoOfiI4lMbAzMNkiAEmL+mAp3nLvc4sJAWotSWova3j9Qa33KWqpVXXY59btD7z3qeo834/s89Aq3/VeiHRDZszEZWUPvBuECvnSs9/aY+PHraz6fotc3hW0mpLb7bUUtTmNvQKA07ZJd7B1WqXtRhdlfT+75xps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E5w2WyfZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EPb/iLC3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NI4I6L1298512
	for <Stable@vger.kernel.org>; Mon, 23 Feb 2026 18:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UxOF72ZgTD7
	tt4flWCIeDBHXEX4DVKcDbCAoRgYqJlk=; b=E5w2WyfZPUGpfO/3ef28JwgbvGP
	mNMyMsHpfSZOoI/EYyOggTRnwKFTq7hTwxWF9azVe1SsiKGGiTOEsw2ItVwQjG+j
	4Wo/McvzGRVyMAwulQBJW1s4LvanvSULobCdRa/OGXC1wFAcWRlLhxZVz4lLvxb6
	bYZWC3gxF85+vokzFfT9GKdv1TippnJQ5LO9cyJSkoro4SOEQKbDEIBonTeVDWpV
	7zMRKBSUnlHlaOl4AM9fAFq2kbyLiqW7vK2WjRo2teOCrguomkcu99TQ4xIrHK7/
	AvA+Sf8Zc762bSs4U+8/qWzKVm+jOMxIcVpdb2ikGpkg3eP6UUWV300oepw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y1e69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Mon, 23 Feb 2026 18:08:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb706313beso657484185a.3
        for <Stable@vger.kernel.org>; Mon, 23 Feb 2026 10:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771870082; x=1772474882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxOF72ZgTD7tt4flWCIeDBHXEX4DVKcDbCAoRgYqJlk=;
        b=EPb/iLC3GrkG13fUTnaglhFuw9M4IX23hD5t0B00dkUaS4qbKPJGbgHWBwCzf/6R+R
         yi0a1LajgckrVagCPn0v/uPZbSdNiUUnjjsUuyxquk79w3ENX0I/9rvCaIV06Seds3LS
         rH7Yg1i0dlpl7gZkhQC+VpiS6b3L2BkGOxM2CRuSVR+/xL/a2zE5uUy3j6jyCOK2UH4V
         dQQhO4yu3vDUEai9+KYJkOKYcmTA7vDZVyrb6NpP398QXe1Z1Zc0fnGGhrHNEkbOvBAp
         QgIA4qyqTj2Mzo130Leucw870RirH+HLxQCcXqrZsPPCaq01E/Z3DYJgO9Sm/ykEXlji
         k7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771870082; x=1772474882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxOF72ZgTD7tt4flWCIeDBHXEX4DVKcDbCAoRgYqJlk=;
        b=VvywZhyPYF2KbzIMylRZYoweF57o/uZPrPRLJNX/XPePkiPo1nP+vijn3LhpPySZPS
         DazHo5qeiXXc+6ZdGVnqyLsRP0rL8uzCBuEgDMidoWoSAPLhPWXXw8H69KRad2H5O7dn
         hoc1ClVOE6wHmPjspkBA4eT/zJttXcnuEpFjRTZRjKxPMgp4m4TxqPkQkxTaaPeXTn61
         s+SwMZzUFEuN+CajJDjV18ZS85ND1dE0yE2FdSei56SZHlGrk/h7zh3fQssXSkpeqNQA
         +gFBtZ3YRr59nGBGk0ZbF5hPex5+lZLztX3rPE3zx97hKitzaobU1obNVFFs3ilNBKGG
         B5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/cvrUU3pERXBiD0ls59ig1KOrhW0q7rcJ+LYtTphLIFtR7jERjCpu/95/FuiJUvbucYh9Bpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kEgdvhAMrHIpKMW6ApESlq30djqrBL3fSsjch6Vvh+OYCCbG
	61plUjgtSRhct0H3SVCC6R78YVbnI1xQDf83CNW2efnvdqqarR0p5gyOj8PyH6tB7bK7fU/sRsT
	v7ICHZm6hMSf/GsrTlWWSd/lDmSMKjiaRp3AmEXOCvx7vld6yfZCIrJI0QOY=
X-Gm-Gg: AZuq6aKYb0DrlYAmgL2jIAW1aZUUO3BOMVqs1YJdYI5wx3mURpyyYI1hOEdkjvixm1K
	jI/9Zrfw7++qZoxcoEaFWocpQE4jACHR7o7qdXgPVo93Pj8y/km9z6Yd5hhAln8LS9i6Vv7bdZq
	Y2UDHVjszxIsV30Ku57Oz7qWKgDWrKCU2xoXOyDwVB6PSsK/BKRH/gEXyZj1Zv0qtx21WTshjeN
	VXv0o8IFLzDlvYzwtmiM/daCUMPRvi2pR2+tcWGb8rRjNKEeHT5DF0hQi+v1GRSEZ17ItpoMrMQ
	LgI5/yKOwcqkPvmmwAtmwFDHEDZa0qlZB8pKMWlgSmxeanBnaYHw626qvyjiYKIWYRx9TrjJfqD
	IgSsHSbOXd5OmDO6UM1Jt+E55lNDStKeBm2BlUijnj4lZsW7afmfDZ4A=
X-Received: by 2002:a05:620a:4016:b0:890:2e24:a543 with SMTP id af79cd13be357-8cb8ca07cb6mr1259242685a.34.1771870081456;
        Mon, 23 Feb 2026 10:08:01 -0800 (PST)
X-Received: by 2002:a05:620a:4016:b0:890:2e24:a543 with SMTP id af79cd13be357-8cb8ca07cb6mr1259236385a.34.1771870080953;
        Mon, 23 Feb 2026 10:08:00 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm20458574f8f.23.2026.02.23.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:08:00 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: mohammad.rafi.shaik@oss.qualcomm.com, linux-sound@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, johan@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v2 05/14] ASoC: qcom: q6apm-dai: reset queue ptr on trigger stop
Date: Mon, 23 Feb 2026 18:07:31 +0000
Message-ID: <20260223180740.444311-6-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223180740.444311-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260223180740.444311-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE1NiBTYWx0ZWRfX/ob4xXUSjed8
 0ot86zfkf8w0Ubj5XCO/QM1bgWG6qdIuVgYnqB/D81oO8Wi0sn3xiHfOjEwzL4DppjY7O8tEoly
 pW7zUbnGQIAzWrbK4mMKoTIzsLRYISTDdg9D1TVXoXx8qtw8Z+tgsv3F5j/vQ/FHqL1KOepUuoo
 Matm7EKY5d4TVm1T4XKGSYI40d+MV0v/UAbjqWH8dD+CnmokWsizfrvURfd8WXwVPtb0TiCi1kC
 zzuyJE8LaKwZPNpPhmqh4caLDTGDUvreHp7cmdRGEBfWQ3i3ATx/FnAaCkQL6RhDIJuYcUeIkad
 R1VcjU34z/T81PyxG+f6bjtqjbXsQyLU3Z+mivYXGJcSxc4UbcZ3S6/BPwIQROfk4jAXT5bEqkJ
 x0WYBpmnoEacbYPO+Sm1yo9i0H7wcOWoo/89akm5O0oJTPwvN2vGFaucUSSiUwqQ9LGcYLPapNi
 n51ZSmsGdg+fSnBeg1w==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699c9782 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=w9bA4Yi6UXS1dLCTJJEA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 22rMhMNnokz9SXbV22Q40F7Y2i0H-hho
X-Proofpoint-ORIG-GUID: 22rMhMNnokz9SXbV22Q40F7Y2i0H-hho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217814-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C29A217B4AF
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
index aaeeadded7aa..87e4474d680a 100644
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
index be8b205d42c4..4d2fa6a5e065 100644
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


