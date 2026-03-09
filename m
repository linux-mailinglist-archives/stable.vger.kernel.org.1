Return-Path: <stable+bounces-223514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCPBOrSMrmnlFwIAu9opvQ
	(envelope-from <stable+bounces-223514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 10:02:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72550235D02
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7EE130242A2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC6376BEC;
	Mon,  9 Mar 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzzV8Aqf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zfz+VZVz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A41E505
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046922; cv=none; b=rk0cBJHF0j6J3KaAIRyIZvXjlA6qSAY7XAyiigDV/9g5xcmVrT2xyEyN+EVN6TA16G3QEZUjcqAaM85BvgIM/YahVCa05L3TyTLtuXH2jH/3dwmJuGPMW9mw3vj0OcBMS2JYyfnJSQ4zxKPLsWvnim+yAY+i3FoV7JeRtHAwXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046922; c=relaxed/simple;
	bh=Dg8zrA6CUods8o4GrDVZcKD1y+aUliP9q3308zWT0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7hqehRBAsbboxt/5Gv9/JfCkqL/Cy07GATcto/ZHpgyvMGjIW+TL9HAmx/PJbWb0cIHJSuvfsOm4podiZM9Kc3ddk4fzqhNfvkDiVdwwAobsMlNIlFRAanc3TVpUby7H8R/RVpNjUOqbwXp0+3++9AYo0vmECpQjBw1DWaW+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QzzV8Aqf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zfz+VZVz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298AbP53016718
	for <stable@vger.kernel.org>; Mon, 9 Mar 2026 09:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Hd0u74ruSn6uVMlMdsGn8P4cicEn+NcTzo5
	0tkBlkiQ=; b=QzzV8Aqf3/BfpVkIcjKaLnyQ1icNDC09UnqbkX4pYZYTghv3Jf8
	ujnxu+uK1R0AZBMfd2Gus7GdQzJDXmAmT/nWdZLVUziNgfgZ+ZBJpLjX0Ifxz4fw
	JqoRkFDznKamxJnNzNfkQIbCycHZb8jy+DqlJGuiV6g7DJ9YmiouQSciZC05zU5m
	Bl9upAcnvdVcPhAjy4ORBpfwF7GMBGv4j48E3fN6/kLeIX8NvAwADqOV0J3tVwXf
	pED/Yb5g50CZfoOTNxSDSr8bCZcrJw39/DRrXvFjaVsyDq3sUOKWTeUrYYnvRz98
	aPXK9k2kAGsKYJKm2fSfmVe2vUjJrp9pWHg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crbkxvp5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Mar 2026 09:01:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c629a3276e9so41642242a12.2
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773046919; x=1773651719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd0u74ruSn6uVMlMdsGn8P4cicEn+NcTzo50tkBlkiQ=;
        b=Zfz+VZVz/DwR+g3fYnwZ0EDIioXC3d15tzMsqhLbX3hXQ/14aVhHcppgrZXuDuwBrY
         s1jpWNXR1Ma9Db++I6657kDbznc+9XLawCjUL/ZwJ03WXGR0SZgwchwl8eUczPyJoEBQ
         upBIOjYsklLYZivpIgly2iCKTQfWPe76cgLzj9d5+vFoTfyXwPDvyvQKgQEqJUhdPcQ/
         29N0/i874iVLzjCSKE4O7hH+aiAaS0iUm/vdTjQ+E0mBhVaRmNIM61gTmohfCV556x7T
         PWJjy0Ce4my00FO8Q55nyQ7ePXpbfP/bvZFjxWc4xyJRW5LwD2R5pu7Lbrfumij1zxxn
         vuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773046919; x=1773651719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd0u74ruSn6uVMlMdsGn8P4cicEn+NcTzo50tkBlkiQ=;
        b=FQZfq3Nbi9dIIFXbbEa4X71d2t2pTWn8oBdl5UCATelD+AmrGUHUAncaGNe8uSEXUV
         KJPc45LMt3nVwDk9iUf9Ms6rwdlQO3ymBUG6dhg31Eoq6Rq7LdgeQ3WeFAjWWvpjMGau
         YxBMbpxYioee6zGtqbuXEOlofSSYxpMg+PsWfgqYqKSuJXj6S83pwyPacUTnZP7j6ejf
         mMmGj4gmipE9Ad68xb71bsjIOV9Hoh509+efRUld5Sy99xvDKkmeQ268fIBrGcxIEKaV
         WHuGgkccPiVr2l9xOQzBFFcxPcOJ9KotMvaeempLCTGC6vJA2A1sIwamW9F4LQVObR4+
         L96w==
X-Forwarded-Encrypted: i=1; AJvYcCWKkkrimPAXYzp8QHOpzIRypYkVKzfcPjw28PHQEGV4SF8t6gw0CAM7mFpalyoyQaN5mv2WC9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQF0A5WZpmfT0CEWMjqW5+zbASNWGj3xaF+OVH0iblHda2L0o8
	E4sR+A/uA0K8rcgcfj06W4uSWhz5VLF0UBhej4gYFsAcB5K2zkJpmquTc1MlmxXFBO+V4RzQ088
	wEh1wKg2DonIAl5oqge1tsba1SBvnvadgra+ub9yDQb+1zYWHc2rZ7hiZMCE=
X-Gm-Gg: ATEYQzyrhJLCcM/DiHBwFl+zekHPEXDu//eLInfmOVLiTSBfFGGsm0XxanLhDGK94R/
	tXmkGQ4RFUwbdI8y41yDrpRSb7P6utG/rg/74UhNaB0cFC94d5AwDl/6gx1hRwUrjkwp8LyMf/i
	593PrrN0j+hJnvy8h6G/zrz8EHinGjp7JFoQmRRYewJqFcxeuhJB3qb0pJGoiEt8WjPbBFoTylh
	fpPH3fx1Jle0/2mwq8y5mWQqNGqATmrxZHf49klpUYEQboPV0hZIxE1CtvtQF/BuqLgQ5J/J0jd
	Ius93Cq7G5wcrG9Aw84cVgyxJwePyq9vl306N0c2qxpPQiDqz6q4iccW3aD/y+PGtcT4ZqP8ztn
	GwXdUc5qoxnmHTcCU5ALcD4qb//fV+nudkNJgEeVPKxRSIx9+
X-Received: by 2002:a05:6a00:2e99:b0:81f:3cd5:206e with SMTP id d2e1a72fcca58-829a2dd7258mr9294067b3a.1.1773046918408;
        Mon, 09 Mar 2026 02:01:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e99:b0:81f:3cd5:206e with SMTP id d2e1a72fcca58-829a2dd7258mr9294016b3a.1.1773046917738;
        Mon, 09 Mar 2026 02:01:57 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d372esm9698087b3a.61.2026.03.09.02.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:01:57 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, Chris Lew <quic_clew@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v3] soc: qcom: pd-mapper: Fix element length in servreg_loc_pfr_req_ei
Date: Mon,  9 Mar 2026 14:31:50 +0530
Message-ID: <20260309090151.897685-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4MiBTYWx0ZWRfX7k9yW5DidJOF
 qA+5HADsqxha83oq+FDdT4OUCtA4dBHgVI02G5NM84cqJkDPMj0Lf8u5Adtg7VYEVWeFIYMwHA7
 OXZoQ5a1PU+F9jcRSJ2vOWSnecIVrXuno6lPrU4Q3Zr5fRRu1O4qoVFpcqAPqDRlFKRQTXAvm2A
 Y7UbP7oy60yriTnoVswttYc/PhvVkd4VGkeUhh8z4ui5qQ4SzsPpbjeEjmWeOoX86zvy/NYPpbw
 LT/K7YrcE7twVpJIut80YXRySQNY92ui7BynKkPpPE8NDNLl5O+yalxbfbpWHgR78lMvjTHg4Sc
 XW+gqYzYQjK1bpWP/+vTOgoOlkEa+y2XkON0lYi/BgRNncYLLlC+nsZxMqQx1bxf4OT91tsRoPU
 8qPsi/xnaCVR2N7gdk27hFIlnibr5NoG6lMgyJH6U3d0j3LVwmfkwuAirDyIJAVcKIZ6zK2kU5r
 sBlp2O5oC6b9jbrCFhw==
X-Proofpoint-ORIG-GUID: -0crFjIyvguWumZhJFTixOKoqXzQyvLA
X-Proofpoint-GUID: -0crFjIyvguWumZhJFTixOKoqXzQyvLA
X-Authority-Analysis: v=2.4 cv=LOprgZW9 c=1 sm=1 tr=0 ts=69ae8c87 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2cWN1nsCyI40IQ2q-vwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090082
X-Rspamd-Queue-Id: 72550235D02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>

It looks element length declared in servreg_loc_pfr_req_ei for reason
not matching servreg_loc_pfr_req's reason field due which we could
observe decoding error on PD crash.

  qmi_decode_string_elem: String len 81 >= Max Len 65

Fix this by matching with servreg_loc_pfr_req's reason field.

Cc: stable@vger.kernel.org
Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
[mukesh: the element length change to the service field is not required.
 Fixed it by removing the change and rephrasing the commit text.]
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v3: https://lore.kernel.org/lkml/20260202103641.3003867-1-mukesh.ojha@oss.qualcomm.com/
  - Remove debug patch as we have enough prints to make decode error
    code.
  - Added Gokul as the author of the patch and added the information on the 
    changes done by me on top.

Changes in v2: https://lore.kernel.org/lkml/20260129152320.3658053-1-mukesh.ojha@oss.qualcomm.com/ 
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


