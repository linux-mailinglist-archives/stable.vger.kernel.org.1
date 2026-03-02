Return-Path: <stable+bounces-222546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ay6AAlRpWke8wUAu9opvQ
	(envelope-from <stable+bounces-222546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:57:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B091D5131
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7ADC300E3AE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B238BF9E;
	Mon,  2 Mar 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFoyPolg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZdYbXWWX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B280389DE3
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441783; cv=none; b=QZNdr7gxUf0DYh2vmNB5MUyND9zq9/txLTEGHa0yhjBgtBtUOxjEK62uZkpwIdaa7GdTshxIyL5HPRF7uv1ZKwkrlDTJYcN+V4IhKoo17FYZle+/8I+CEaelNlLVA3wnyfkFhOFRcf+vAK1Mreu+U54XJHclUt62NKsHJvRTmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441783; c=relaxed/simple;
	bh=YSle7age6/sGC4mrbcE1fgXH371qq6gkeUXhaxiCOyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrK4sF9pSFR72+WEgYu39q8ZON/zSZmJTFpW+S2gWzO0d3eRgW3Xd6L9DvzZXsq1M8AASJ471l7x+2KsX7DE9OsPGKkN9mF1sXGht4EQ00SFcRoeZauAoFyhBHR5rhzxUOX+JOZ8dthfpeSu3LacczYo4NLUQE8cuFX8QNJ4fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFoyPolg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZdYbXWWX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226hAvm2504612
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 08:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WApl3fPUusQhgCuPfXm41GbJ+B8rlZDv+NV
	xfvyf6qI=; b=DFoyPolgCp/EYJgTV2hvkk8ihX/ytfIJn6J2abn+QncUKRTGVtK
	ZJaGh0+irgpLI9LzNxJAiQqLowGytkcMZACEy7YbRvUi2yLXgofgdA6VHT0D2egw
	eMY1xNtX3jke5KRM6u3PpNWMHV1E6kQgjRtfK1Zp18uOjU4r9tXUIIxAw8PQ4fR2
	US3h82xcsjtRf7jIrhVfR/ZQaMwNDATh67Koj62swj8hQSa111zk2wdNYKmU9uaI
	tMaH8YqTErI+yAq2e4oy/rwPuEuP+fuxHo8ReRliAFqJCTgFVrctkJesR00O0t8J
	3LA3KVQweNdMi7BviEhGu+6p4Z+Nh6KKP/w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5herf6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:56:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ab4de9580dso262951335ad.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 00:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772441781; x=1773046581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WApl3fPUusQhgCuPfXm41GbJ+B8rlZDv+NVxfvyf6qI=;
        b=ZdYbXWWXk/8frrMJjQZbAI5xHLKBu2yTfU6wagp9E4Ywxoy2BrmGAzjeinAD3Rkz6P
         +MLLzSvapC2xx025J605XhBi/Yegw5pN9YidtDsG5Kh5155EEcxsJqqCgEow0vWnauVs
         xb1vv5jk1i3P9lXXgDJT04SD87QFYAiMJzPQRMYpx1R51cWbFoXrEUJqDwH1rH9G1Yws
         89OfQP8QrOIKSoKJhAmO1NHyY7LnYYm/Tf0XHSIO21InPraj8m0PRZ3TMjokBqtaCl7W
         xFYF7ESTvZqdCJ8HrUFKbAG6R3m4Ku4tD603jXwKInMh4oUc1FDyHhTMjMbfbNOxch0R
         uBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441781; x=1773046581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WApl3fPUusQhgCuPfXm41GbJ+B8rlZDv+NVxfvyf6qI=;
        b=uEctKc/VXRXVALp5LHecPbG+MOVW6Oi3+iyN38ugQOpGpY/DIItmo5f1Nhw0frTMtr
         c+jmjcVUQwIjwVQjF7Wi12Cm8NnkokcGxRZ77io2RuxadbgMNWt0T1c5gN6H2B7oPom1
         htfdYy41nIZWxsjKKFMqgCk+7zIUf4Ep4MdS+vrSabal1zv/pLEdrhwQoqCgnCUHvuU/
         YmX7bDHQbKMyyUHmtYZuyflfP/CD8kd3OccA6mFJhuUJk220DaFHDN+Ui6/SwLd2f1Yk
         FvuvYkcKF/ZAwBwpYQPVFjZ/KL4FTxB2kyMTYpGLMgrQ+vJcnr9ZRsYOIgC3AoxNzVSq
         CIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXedogoFlDFout91FSZl1st2qhuEgYZE1bffOUfey1GCfC6wJLV890ZGwW3OuSkffYUVuxzcyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzwgZGD4VOLAjlDB/ZhlA8ZIrrnqL/LJ4hIfzcIn8K6M1LEwu
	bXU1hen9QvMRT+U8YLirpFLoztQZ7CYa2RYeOtuLETnFRLC7zkOokNGM9JhZRcuYwA4b/Hih1Mh
	zFgLSK6QEoKTF8zgw0MLdTeMZitMIojaH86+9vvNlL1P9ZS9zcqK4YwUceOI=
X-Gm-Gg: ATEYQzzu/JWlC9LC91HuhaHPp7dGdvJ6eA+HbDfvfTx8XsHqB/ynL7AT7b52DHDfFuj
	7jfcQMinLhQQAC9Hdrb1CVcKh1MVyTHKZQK6hZ/GPLnriONAbX7aTjVku0oS5VDyvnH8B5VKPA1
	exIRi5av23N35gWUrOuIg0L2TEsXzNL9u8OMKnk9sSSqjApOhH+S74ErMCD2r5gzMfzB/0CIaSp
	vMmuXHrxVlkgJ9tDEHQWQG2wDPRvvLI5KDLT9lZQBWu/wHbSRkiMiRIyBoXF7n3mT5P3XUpmK7t
	hmTcwpFUOwq8Zf3KoocwiB+GWeCxTgWf69y6NfzlbPtUg2mwZyccVTCgHSCbDn7kVFwBh9lFpsl
	fClUbtPnAFtvqWF+v5AKF42JtgVL1ebRxWRTrApbzHDOtOZs=
X-Received: by 2002:a17:902:d508:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2ae2e4d0a96mr130649815ad.50.1772441781162;
        Mon, 02 Mar 2026 00:56:21 -0800 (PST)
X-Received: by 2002:a17:902:d508:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2ae2e4d0a96mr130649365ad.50.1772441780596;
        Mon, 02 Mar 2026 00:56:20 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:40ee:341f:1665:8aed])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f6e0sm20781263a91.1.2026.03.02.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:56:20 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: mani@kernel.org
Cc: sumit.kumar@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] bus: mhi: ep: Protect mhi_ep_handle_syserr() in the error path
Date: Mon,  2 Mar 2026 14:26:12 +0530
Message-ID: <20260302085612.18725-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a550b5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AUlretI1EePZII7xc8UA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 7hXOPKf4OOpG9UALPAn_mKcf5gEL56_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NyBTYWx0ZWRfX3l0Kzhlx88jg
 bwy7ERIPCP37zTK2xDI5wk8URZcJoazNem+QUPkWL5vtQzWgRNrbAwVO//PP1+YROTmoljvkoTs
 SLzbqFvXauwm6gqw62bP54rPK4TF6WwPFG93IQcmZjWOL3L6xbyz0RGrQUG5ulZkoZVv31rBdxP
 PoLLIWTlD6VL+VWCuMENpjB5W25g9IX+c0voR14jeIKLr1RNVCTTZ1Z7SCYzN7chrRp+UrHpo4j
 erVjgq/A2CZK8y9huuzmsid1xv0vGy7dIwediPkkVUkYiGdzqG3iRheLahlKAdMEC/0G9gYeaPE
 XTZddktAXP+WFWBor/nRsBplWW6fuJJx+U4w5LpcjR6AnjI0GHybXRdd3iqQxsS/qSTlAW0hi5z
 TTIxRQIu1njlmXz/QUVpllFy60pGu8/pYECNCNaz4fGxJIIkk+sMN+va0C+ZNwxSz6zZItcHaLX
 4OSRiSReGrjXOflBMHw==
X-Proofpoint-ORIG-GUID: 7hXOPKf4OOpG9UALPAn_mKcf5gEL56_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222546-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96B091D5131
X-Rspamd-Action: no action

All the callers of mhi_ep_handle_syserr() except mhi_ep_process_cmd_ring()
are holding the 'state_lock' to avoid the race in setting the MHI state. So
do the same in mhi_ep_process_cmd_ring() for sanity.

Cc: <stable@vger.kernel.org> # 5.18
Fixes: e827569062a8 ("bus: mhi: ep: Add support for processing command rings")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index e3d0a3cbaf94..6a6aa2c28760 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -232,7 +232,9 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 			ret = mhi_ep_create_device(mhi_cntrl, ch_id);
 			if (ret) {
 				dev_err(dev, "Error creating device for channel (%u)\n", ch_id);
+				mutex_lock(&mhi_cntrl->state_lock);
 				mhi_ep_handle_syserr(mhi_cntrl);
+				mutex_unlock(&mhi_cntrl->state_lock);
 				return ret;
 			}
 		}
-- 
2.51.0


