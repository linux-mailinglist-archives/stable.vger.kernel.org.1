Return-Path: <stable+bounces-213052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DeBOnB+gGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:37:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A47ACB116
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C564300B591
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91472D6E67;
	Mon,  2 Feb 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQ8BvocQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D3H79eTA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC235B65A
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028621; cv=none; b=aULSSv1QbWS4v+z5E8seVcr++OajRXxyLndYputE3unZnQpoq6TChUYVknhtRY2p07r8ay/Bnv5M2HvsYVgEejHkRDFN093z1/rfaa2wu8eieKOuThDhI7BQYeecAdnTTytZ25sxJ/1GXL86m9s9Cb+L/00xdC4+LufxwoPJrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028621; c=relaxed/simple;
	bh=83Ri8S9goG1iCa+8ktvsORt2dAUMpMuPdoRhUF30yoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4o+GE1s/yuh0YdD/oNSMM1tcX+WEdi+/TzBIqsMChvuecX7nQIZSQM2Aq2IBoqZcU+KzyryJ2oE0pF+Ighge4ed5MVvI3eYiaxeP7FUFSuuG9yymh6UMM7/78M7Rs8VE58d2aCMTvOoYv8FsKN8TPdHXOy+iAKo3dDrv6NBQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQ8BvocQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D3H79eTA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6127PhbT899595
	for <stable@vger.kernel.org>; Mon, 2 Feb 2026 10:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mbEfukDVHfO60T1BK/eFrrNdy5LSHY6uxiS
	psgFfqmE=; b=pQ8BvocQ+Z2OIzDTG9CdT1YguxYFhhG2BFYvBl9HjkwmFg3TTK/
	bPZftZrl6rTdyWk4l1fIPj4R6IV42Y8kWfDTMhJdNxA1lRFQ0RSsqzt24D2SYI8s
	lxXXXntCGm8WPWmercNRwh2wNK6FpwP/BZ2/cu2r/DuA7Gyd0T+JFpo2X5f7Wff9
	9GscxrKNgpmkgb1XpBggou+tqCWQRqeisV8pqk5lFj84t09PDJs8xrCjX3u1ZIaG
	xbLRukNm7WbcNzbDi4/1W7rsShze254MYjsi5SOH9bTFaDK1XpTXCQeeMbsEkBFv
	QVA58H+XOFCdt93UcBQhQkVdou48URr/UuA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awnw4mx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Feb 2026 10:36:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3545cc84ab1so3184503a91.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770028617; x=1770633417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbEfukDVHfO60T1BK/eFrrNdy5LSHY6uxiSpsgFfqmE=;
        b=D3H79eTARe/RcrwEbi+77ir0PwQxwSiQP/GyYnOjaGWOVAjZCsiS1CdKO5TEw5EY8w
         AYfHkjHbNzfNGzKmPpoqucOOD7Dmcb3dDdYbp1mpEae4dZokuIvBhfFR6MScDiPqCqia
         QwCMmF9mb+7g5kxDdd4YpLRuQ5O3ckaUewk5uC5ACiq3knp8HUodiqySw8vZxtF++4sZ
         V9gj3piQdzq7eyRaDQWkpdgNaMbVFBHzx7GuPihPDoBf4hthOK9mzhjrjxv5rQ7tZNh8
         Y+W79XZ8YvBSE4rvcrrfs3paH6co85BlCLsMWhr182c0JXeeu049DfsSeuKs47SOirMC
         7nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028617; x=1770633417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbEfukDVHfO60T1BK/eFrrNdy5LSHY6uxiSpsgFfqmE=;
        b=VSV5FTz75ldItsDYyGHJEVmyJQnlKGIAoYM/1jzTviQjFwnuO6Z/obM6dYHtyNHiXP
         EL/PeQMSNiCJHE3xhUhy54rVRlgClU6eiVJxDSK3aiNMAXsNFWOLmKxOaFoVYY8xmS+4
         dBuFx1lzzi1vRtUgem1FQy1twimGtDqVYSihizJce0Wbb/gVOgVBYy5zXd7/HzI5yjL4
         oBTSqHzqGJQ9t9AWmTp9SrUeyZLqFOS7HI+eNfZBH2w3Zhkar2kJD87KOwdzg0toVlGC
         rbsgKKqW3ATafM3yjVeHQtdeKdGiKYrnspjMLaHfbJLctttknmyJ4Se2iSwAyaLj3lsH
         qFvw==
X-Forwarded-Encrypted: i=1; AJvYcCVMsMbLuo0/MaUK80cZj98Cq6Xuj94TfffPY6I4d9bx6LBjK61b15VHviJlPB7X3q4bLZ/MSA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsCT41GA9mJZTCjBq90707i62MXjthzyLqIAZ8QQWkfkiG1TY
	3CW4c46kA/J4+D+L0gcDCIq4NmNjurziSNjxJPz38CvKsK8gAEIRIhnqVyEhblo4q3XHdjZPUn7
	GO9h9EkHRyW5YvaDYJtB1/uZxOI9dfSvAu0ktbZtOtjwL93cOb5Rw0I5n+Pc=
X-Gm-Gg: AZuq6aL00m4Hsg+9GK15RuqDAnS6gmJnyRLZVAfTJ8X1Q4IqFlacHmb/RVpRHKQlhJr
	llCL1jJ+9uQzjK1Y57rb9DqexNSBT/MHQQdEHGPTTFxFDuSsQKV+rvoRJAhdU/khPaiCVciDUZB
	xA82jDI0KZ6R+VU+m7/WjIOcavpUPb0C4t36eV1AdN1llRgwEQn+j70VIlc3tepcjWpW54SQmPf
	Eji9jGyV9wm0sFtzCNHMuefzCC4QuPt3ZNz9aiwxw0ipBDTTuYQie7EiqLt+Buov6vGZCWZl3Hm
	HA/MobYixcEUULVd73bS2cYF3u/imVTWm6wDnsPyp1YKLiFDdc4k19bNjmF+IbMM4d5ff7uTPD6
	PvCfie4SJUV6TxYioM8cbPr3l8cGUzd2iOJ0W
X-Received: by 2002:a17:90b:2e50:b0:34a:b8e0:dd59 with SMTP id 98e67ed59e1d1-3543b2ffb30mr11954134a91.15.1770028616626;
        Mon, 02 Feb 2026 02:36:56 -0800 (PST)
X-Received: by 2002:a17:90b:2e50:b0:34a:b8e0:dd59 with SMTP id 98e67ed59e1d1-3543b2ffb30mr11954109a91.15.1770028616009;
        Mon, 02 Feb 2026 02:36:56 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d4fc332sm4907106a91.3.2026.02.02.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:36:55 -0800 (PST)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, Chris Lew <quic_clew@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
Subject: [PATCH v2 1/2] soc: qcom: pd-mapper: Fix element length in servreg_loc_pfr_req_ei
Date: Mon,  2 Feb 2026 16:06:40 +0530
Message-ID: <20260202103641.3003867-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=69807e49 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2cWN1nsCyI40IQ2q-vwA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: f9CfYsfPWTSWkd0vgeAcHLDlYmXlPTNI
X-Proofpoint-ORIG-GUID: f9CfYsfPWTSWkd0vgeAcHLDlYmXlPTNI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NyBTYWx0ZWRfX6NwEzYANsodw
 ON9zIjjsAxwhR/VGDmeK6HEs+LHxENWCKiUzyWdu3xVDWhao8pE7P/09bOYxNGYBR2VtlOlAopV
 +XHADnN8nJSNmAsG+cTK71iaTmj3hyFj8gQFA1XEzHk0wop+GbTgeVEnmtAWw/kQq2ZGXExrdzN
 V1ZRqu7G5n59Gy5KIqhqtDQH3qNAB1e3eYlhRo/30BBkunxAf9WNytEo1OQIdt9hWuT9fu+9ca1
 XqAnbwOuJe08MdeiqIgWO00SPOXf/yTnnfMLZlhbxLnSjzVdyZIHHS4LqU8vNp0UupLaJteZPaM
 cwTrIAwfTbnOgpz86AQ1+n5Wh6TZ97oBwTUeKBSlAL8gq1BnJsee6eBrUMZo996Cb+SorDbTRqZ
 FRPXs0JH/KfBPYFinV140V7Q+ZOBAyY6ZdIpkiNvS3w2DsMo/AmscGzIVuqhy3IolUtnpOrpRtX
 /lchLtk4dZV0L/eHDuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213052-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A47ACB116
X-Rspamd-Action: no action

It looks element length declared in servreg_loc_pfr_req_ei for reason
not matching servreg_loc_pfr_req's reason field due which we could
observe decoding error on PD crash.

  qmi_decode_string_elem: String len 81 >= Max Len 65

Fix this by matching with servreg_loc_pfr_req's reason field.

Cc: stable@vger.kernel.org
Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Co-developed-by: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
Signed-off-by: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2:
  - Given credit to my colleague Gokul.K who first faced this issue and given
    initial fix and that was later corrected by me.
  - Rebased it on next-20260130 and added stable mailing list, R-b tag.


 drivers/soc/qcom/pdr_internal.h | 2 +-
 drivers/soc/qcom/qcom_pdr_msg.c | 2 +-
 include/linux/soc/qcom/pdr.h    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index 039508c1bbf7..047c0160b617 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -84,7 +84,7 @@ struct servreg_set_ack_resp {
 
 struct servreg_loc_pfr_req {
 	char service[SERVREG_NAME_LENGTH + 1];
-	char reason[257];
+	char reason[SERVREG_PFR_LENGTH + 1];
 };
 
 struct servreg_loc_pfr_resp {
diff --git a/drivers/soc/qcom/qcom_pdr_msg.c b/drivers/soc/qcom/qcom_pdr_msg.c
index ca98932140d8..02022b11ecf0 100644
--- a/drivers/soc/qcom/qcom_pdr_msg.c
+++ b/drivers/soc/qcom/qcom_pdr_msg.c
@@ -325,7 +325,7 @@ const struct qmi_elem_info servreg_loc_pfr_req_ei[] = {
 	},
 	{
 		.data_type = QMI_STRING,
-		.elem_len = SERVREG_NAME_LENGTH + 1,
+		.elem_len = SERVREG_PFR_LENGTH + 1,
 		.elem_size = sizeof(char),
 		.array_type = VAR_LEN_ARRAY,
 		.tlv_type = 0x02,
diff --git a/include/linux/soc/qcom/pdr.h b/include/linux/soc/qcom/pdr.h
index 83a8ea612e69..2b7691e47c2a 100644
--- a/include/linux/soc/qcom/pdr.h
+++ b/include/linux/soc/qcom/pdr.h
@@ -5,6 +5,7 @@
 #include <linux/soc/qcom/qmi.h>
 
 #define SERVREG_NAME_LENGTH	64
+#define SERVREG_PFR_LENGTH	256
 
 struct pdr_service;
 struct pdr_handle;
-- 
2.50.1


