Return-Path: <stable+bounces-189088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C079C00750
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C0C1898148
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B965289E17;
	Thu, 23 Oct 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rx8YMLF2"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958B30B507
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215163; cv=none; b=QxvmSk1f48jp5gsL0ZiPlvwF/lNBAhv8LtlzAiEytJ3Iqp4Tn4NFMUsX0569ILLL4AmjzylWex6qhnyPIfMgIDrT0QPPna/TUSbVdF2F41r2GRmFhCcvbVeHMrCYifp4BzYM2Wfus3LQpl6YSjaYVj02wLqP0Oe8k3uBxFMnhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215163; c=relaxed/simple;
	bh=0NX0xrr/Yc+5DC4N9bMIQUn7iisOTqFME7dif499+F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs9Iuabr1SxSPOxQdCTD2A7R4mTTd1H1gxvd/6oFiBB9i3q9dpM1dMHufy/GeuU1g+ty3qHnVWAYTRNuhef+yREGLAQf8KMe73diRHi10qzFOGDVcWda/YmBQfjlr82F0eZv2H4skF3xIGNQKsdbvse1OgeLG2ZB68nMGcKP+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rx8YMLF2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6rLsM008244
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rFyaRjCqrsV
	Ko5s83gYJ5NPJ5RtH4VSu/szdbYAmjEM=; b=Rx8YMLF2ki2Zt5b4l/45qX2MiQ+
	HxSn4jUkFtd1xYRVeAz1B9d/D3Q5M+9HNXSJmJcZRh8lnYWFfYhwk1mfjG8goGbk
	gBiXBNJpZjtcVPZYSMRGf958bAr44gY+EtCayYRpJjlHURVdceISASbtrSMPIwI3
	8NHIOb1eWTBmRijalxdgy6TJTPCbeKX2W7huimyPNZKEmOg6O/FNK/+iPd26Fig1
	g/5RZCa6p24beG21dl/Buxxa+EcKzpKG6vGybh/ICv93AsKv4WnkwBnI5N+oLCnR
	NSl/dtu9EaAWUExiGqfZS+cxHKo0WRPVmUYDk9lS5o0h4mEaVfHlhxOysXA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j7y2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:25:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8bb155690so8465031cf.0
        for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 03:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215159; x=1761819959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFyaRjCqrsVKo5s83gYJ5NPJ5RtH4VSu/szdbYAmjEM=;
        b=hTotMaAze57H+JyzIQpetmngqcjsPmDGSlb4DSnlimiKTQnx23OP05YXG2M7iVSNex
         t0bcyUEpA7EKdLVW6ZCtEjdzJJghwde+2K3cpCTWiDrN7woHNPI+jUb4Q6mM4l1lYgYc
         IgLFCokiP7xg25StdBUZCJC585j7/OHnBm7qL1WN/qN4xYxWrpPFAY9Qi4nREFw0vU8Z
         I5RwFWakCu4cmCQ91RzaWf9a3CjhLZHGf15gwR972aO8Suj2fpNA1h3PC2Tdtsxp4NrG
         26iMxG9Zvkv6xKo5v62KPe3HxWUwA1ce1CLqRocNKlOGKLQCg/jdS0GMSJPX1K+rmovm
         JpVw==
X-Forwarded-Encrypted: i=1; AJvYcCVwhx3L3scNsuLrbz0TIvK2w4L8Fc7fPkGWXzi599xiWAaND5rMU9nl5FwMQ+okn9XEeQIfQak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ4yyUC+geypMeSOJlEMVYUSg3Cutg7rqfNZy3UOzIGLZ+SJx8
	iVsU8obQGSSD4VXIPSzBtbbyXe3dCAGKu0rLNxgPrIg435vAsbraamfOHaq2xgLo+lyMiM7mDsy
	kDjXSIYTdwjjNqhJX9/FYSg4/vqbz136Pksa9N8w57NR3rBuKRMVDcHang/k=
X-Gm-Gg: ASbGnctMgH68GC2mebShpqWeTo1iOHSTeE6dhURXEmpX3ph3qEOblc0VpYueTrlRqiw
	BvPTOcWYm+Lxc1QVbKMCoDVvssqjwctJ9UmQD4CpTCSTqZKItw6NLM7UFKNeTmBm/ehYylObJWh
	GyF+v9Tp6G2r9p1UxHo0ZTbnHUa28gi/qTVfroWG/sfYdJXtgeoypfo6LOpIUTcHU/8fq7QUgSI
	l/uZoaVs642usrMCbAWVuBosWHNtjKbQ3Md02NEQ+ui/x7yo+9MR4xAC1YSYVfaETDMp2QuuQO4
	w8j8WBNryRu2xxYkiY8Eo0ilvuLm0OYrQxwLCz/icXDY/OJDQwVfXfp8kPrjE56sAQHjhp0NPx4
	RqkEAlKWWIAtR
X-Received: by 2002:a05:622a:393:b0:4e8:bab2:9e0b with SMTP id d75a77b69052e-4e8bab2a3d8mr229158491cf.77.1761215157433;
        Thu, 23 Oct 2025 03:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEipUZPr/7bW8OGjBlVV+GOSronEBCQCGLlkN6DxGOE9VuhM0WSPcYLaWlph9XC0He1x3Uo4Q==
X-Received: by 2002:a05:622a:393:b0:4e8:bab2:9e0b with SMTP id d75a77b69052e-4e8bab2a3d8mr229158211cf.77.1761215156957;
        Thu, 23 Oct 2025 03:25:56 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:56 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Martino Facchin <m.facchin@arduino.cc>,
        Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 02/20] ASoC: qcom: q6adm: the the copp device only during last instance
Date: Thu, 23 Oct 2025 11:24:26 +0100
Message-ID: <20251023102444.88158-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX9Y93A6irc1go
 EEqFs+yR4sb2KhHKkRcQOgbJgfOyXGfThdf9x8ABl18pZDJcbyeRmc8Daengm68RV0MKyBMMm5K
 ecBpF0peTWTUZPkmplXDgkQfta8njGUnrC432qpme6XRJ/9jj8a8YOtq96qTraceu9eyd825J7z
 y63wR+iE4oyJIpH1xqTZnEehbjRhW80ub04gnY1KuTNOs+ukQXEEUoyWoajRPFof7euJf7H4MpE
 io1JuBdebeJ3DgwvnNF6fJ74K99B2sacOM+eKphU+JfVdeFKUCNgYEdgOghJPRvaMZkAjseWTD0
 rE+j6tGkbV2+qmsdPHJz9c0OfyYF1wLBH1pKxOlt6EgudHSxhVggSVXi9vsuMm6QDBLq3yOHlZE
 21rGj9RIHmJMja/FLSQaVnOb/TD/TQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa02b7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=LQLTnAVHjxzgEifUwDEA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: O5ol0dnD6gfWD_pBpHGjRUDkqIGc0t_k
X-Proofpoint-ORIG-GUID: O5ol0dnD6gfWD_pBpHGjRUDkqIGc0t_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

A matching Common object post processing instance is normally resused
across multiple streams. However currently we close this on DSP
even though there is a refcount on this copp object, this can result in
below error.

q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: Found Matching Copp 0x0
qcom-q6adm aprsvc:service:4:8: cmd = 0x10325 return error = 0x2
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: DSP returned error[2]
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: Found Matching Copp 0x0
qcom-q6adm aprsvc:service:4:8: cmd = 0x10325 return error = 0x2
q6routing ab00000.remoteproc:glink-edge:apr:service@8:routing: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: cmd = 0x10327 return error = 0x2
qcom-q6adm aprsvc:service:4:8: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: Failed to close copp -22
qcom-q6adm aprsvc:service:4:8: cmd = 0x10327 return error = 0x2
qcom-q6adm aprsvc:service:4:8: DSP returned error[2]
qcom-q6adm aprsvc:service:4:8: Failed to close copp -22

Fix this by addressing moving the adm_close to copp_kref destructor
callback.

Fixes: 7b20b2be51e1 ("ASoC: qdsp6: q6adm: Add q6adm driver")
Cc: <Stable@vger.kernel.org>
Reported-by: Martino Facchin <m.facchin@arduino.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
---
 sound/soc/qcom/qdsp6/q6adm.c | 146 +++++++++++++++++------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 1530e98df165..75a029a696ac 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -109,11 +109,75 @@ static struct q6copp *q6adm_find_copp(struct q6adm *adm, int port_idx,
 
 }
 
+static int q6adm_apr_send_copp_pkt(struct q6adm *adm, struct q6copp *copp,
+				   struct apr_pkt *pkt, uint32_t rsp_opcode)
+{
+	struct device *dev = adm->dev;
+	uint32_t opcode = pkt->hdr.opcode;
+	int ret;
+
+	mutex_lock(&adm->lock);
+	copp->result.opcode = 0;
+	copp->result.status = 0;
+	ret = apr_send_pkt(adm->apr, pkt);
+	if (ret < 0) {
+		dev_err(dev, "Failed to send APR packet\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Wait for the callback with copp id */
+	if (rsp_opcode)
+		ret = wait_event_timeout(copp->wait,
+					 (copp->result.opcode == opcode) ||
+					 (copp->result.opcode == rsp_opcode),
+					 msecs_to_jiffies(TIMEOUT_MS));
+	else
+		ret = wait_event_timeout(copp->wait,
+					 (copp->result.opcode == opcode),
+					 msecs_to_jiffies(TIMEOUT_MS));
+
+	if (!ret) {
+		dev_err(dev, "ADM copp cmd timedout\n");
+		ret = -ETIMEDOUT;
+	} else if (copp->result.status > 0) {
+		dev_err(dev, "DSP returned error[%d]\n",
+			copp->result.status);
+		ret = -EINVAL;
+	}
+
+err:
+	mutex_unlock(&adm->lock);
+	return ret;
+}
+
+static int q6adm_device_close(struct q6adm *adm, struct q6copp *copp,
+			      int port_id, int copp_idx)
+{
+	struct apr_pkt close;
+
+	close.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					APR_HDR_LEN(APR_HDR_SIZE),
+					APR_PKT_VER);
+	close.hdr.pkt_size = sizeof(close);
+	close.hdr.src_port = port_id;
+	close.hdr.dest_port = copp->id;
+	close.hdr.token = port_id << 16 | copp_idx;
+	close.hdr.opcode = ADM_CMD_DEVICE_CLOSE_V5;
+
+	return q6adm_apr_send_copp_pkt(adm, copp, &close, 0);
+}
+
 static void q6adm_free_copp(struct kref *ref)
 {
 	struct q6copp *c = container_of(ref, struct q6copp, refcount);
 	struct q6adm *adm = c->adm;
 	unsigned long flags;
+	int ret;
+
+	ret = q6adm_device_close(adm, c, c->afe_port, c->copp_idx);
+	if (ret < 0)
+		dev_err(adm->dev, "Failed to close copp %d\n", ret);
 
 	spin_lock_irqsave(&adm->copps_list_lock, flags);
 	clear_bit(c->copp_idx, &adm->copp_bitmap[c->afe_port]);
@@ -155,13 +219,13 @@ static int q6adm_callback(struct apr_device *adev, struct apr_resp_pkt *data)
 		switch (result->opcode) {
 		case ADM_CMD_DEVICE_OPEN_V5:
 		case ADM_CMD_DEVICE_CLOSE_V5:
-			copp = q6adm_find_copp(adm, port_idx, copp_idx);
-			if (!copp)
-				return 0;
-
-			copp->result = *result;
-			wake_up(&copp->wait);
-			kref_put(&copp->refcount, q6adm_free_copp);
+			list_for_each_entry(copp, &adm->copps_list, node) {
+				if ((port_idx == copp->afe_port) && (copp_idx == copp->copp_idx)) {
+					copp->result = *result;
+					wake_up(&copp->wait);
+					break;
+				}
+			}
 			break;
 		case ADM_CMD_MATRIX_MAP_ROUTINGS_V5:
 			adm->result = *result;
@@ -234,65 +298,6 @@ static struct q6copp *q6adm_alloc_copp(struct q6adm *adm, int port_idx)
 	return c;
 }
 
-static int q6adm_apr_send_copp_pkt(struct q6adm *adm, struct q6copp *copp,
-				   struct apr_pkt *pkt, uint32_t rsp_opcode)
-{
-	struct device *dev = adm->dev;
-	uint32_t opcode = pkt->hdr.opcode;
-	int ret;
-
-	mutex_lock(&adm->lock);
-	copp->result.opcode = 0;
-	copp->result.status = 0;
-	ret = apr_send_pkt(adm->apr, pkt);
-	if (ret < 0) {
-		dev_err(dev, "Failed to send APR packet\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	/* Wait for the callback with copp id */
-	if (rsp_opcode)
-		ret = wait_event_timeout(copp->wait,
-					 (copp->result.opcode == opcode) ||
-					 (copp->result.opcode == rsp_opcode),
-					 msecs_to_jiffies(TIMEOUT_MS));
-	else
-		ret = wait_event_timeout(copp->wait,
-					 (copp->result.opcode == opcode),
-					 msecs_to_jiffies(TIMEOUT_MS));
-
-	if (!ret) {
-		dev_err(dev, "ADM copp cmd timedout\n");
-		ret = -ETIMEDOUT;
-	} else if (copp->result.status > 0) {
-		dev_err(dev, "DSP returned error[%d]\n",
-			copp->result.status);
-		ret = -EINVAL;
-	}
-
-err:
-	mutex_unlock(&adm->lock);
-	return ret;
-}
-
-static int q6adm_device_close(struct q6adm *adm, struct q6copp *copp,
-			      int port_id, int copp_idx)
-{
-	struct apr_pkt close;
-
-	close.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
-					APR_HDR_LEN(APR_HDR_SIZE),
-					APR_PKT_VER);
-	close.hdr.pkt_size = sizeof(close);
-	close.hdr.src_port = port_id;
-	close.hdr.dest_port = copp->id;
-	close.hdr.token = port_id << 16 | copp_idx;
-	close.hdr.opcode = ADM_CMD_DEVICE_CLOSE_V5;
-
-	return q6adm_apr_send_copp_pkt(adm, copp, &close, 0);
-}
-
 static struct q6copp *q6adm_find_matching_copp(struct q6adm *adm,
 					       int port_id, int topology,
 					       int mode, int rate,
@@ -567,15 +572,6 @@ EXPORT_SYMBOL_GPL(q6adm_matrix_map);
  */
 int q6adm_close(struct device *dev, struct q6copp *copp)
 {
-	struct q6adm *adm = dev_get_drvdata(dev->parent);
-	int ret = 0;
-
-	ret = q6adm_device_close(adm, copp, copp->afe_port, copp->copp_idx);
-	if (ret < 0) {
-		dev_err(adm->dev, "Failed to close copp %d\n", ret);
-		return ret;
-	}
-
 	kref_put(&copp->refcount, q6adm_free_copp);
 
 	return 0;
-- 
2.51.0


